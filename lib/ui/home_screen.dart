import 'dart:convert';

import 'package:cat_facts_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Person> personList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api Call'),
      ),
      body: ListView.builder(
          itemCount: personList.length,
          itemBuilder: (context, index) {
            final  person = personList[index];
            return  ListTile(
              leading: Image.network(person.image ?? ''),
              title: Text(person.name.toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(person.email.toString()),
                  Text(person.phone.toString()),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchData() async {
    Uri uri = Uri.parse('https://randomuser.me/api/?results=5');
    Response response = await get(uri);
    print('fetchUsers call');
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      for (Map<String, dynamic> p in decodedData['results']) {
        Person person = Person(
          name: p['name']['first'],
          phone: p['phone'],
          email: p['email'],
          image: p['picture']['thumbnail'],
        );
        print('data fetched');
        personList.add(person);
      }
    }
  }
}
