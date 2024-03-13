import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
//2.05 mins
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO DO APP",
      home: Todoapp(),
    );
  }
}

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});
  @override
  State createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  void submit(bool doEdit, [ToDoModelClass? toDoModelObj]) {
    //toDoMOdelobbj is null
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          cardList.add(ToDoModelClass(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim()));
        });
      } else {
        setState(() {
          toDoModelObj!.title = titleController.text.trim();
          toDoModelObj.description = descriptionController.text.trim();
          toDoModelObj.date = dateController.text.trim();
        });
      }
    }
    clearController();
  }

  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  bool editcreate = false;
  String sheettitle() {
    if (editcreate == false) {
      return "Create Task";
    } else {
      editcreate = false;
      return "Edit Task";
    }
  }

  void editCard(ToDoModelClass todoModelobj) {
    titleController.text = todoModelobj.title;
    descriptionController.text = todoModelobj.description;
    dateController.text = todoModelobj.date;
    editcreate = true;
    showBottomSheet(true, todoModelobj);
  }

  void deleteCard(ToDoModelClass toDoModelobj) {
    setState(() {
      cardList.remove(toDoModelobj);
    });
  }

  void showBottomSheet(bool doEdit, [ToDoModelClass? toDoModelObj]) {
    showModalBottomSheet(
        isScrollControlled: true, //modal sheet bottom must go up when typng
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              //padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,

                ///when the sheet goes up it shows minmum
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    //"Create Task",
                    sheettitle(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title",
                          style: GoogleFonts.quicksand(
                            //use google fonts
                            //style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      Text("Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      Text("Date",
                          style: GoogleFonts.quicksand(
                            //use google fonts
                            //style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          suffixIcon: const Icon(Icons.calendar_month_outlined),
                        ),
                        readOnly: true,
                        onTap: () async {
                          //pick the date from datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025),
                            //Formates the date into the Required
                            //Format of date i.e Year month Date
                          );
                          String formatedDate =
                              DateFormat.yMMMd().format(pickedDate!);
                          setState(() {
                            dateController.text = formatedDate;
                          });
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!doEdit) {
                        //!doEdit it is defalu false it will become true and send bu submit function
                        //to add task only doedit will be Send
                        submit(doEdit);
                      } else {
                        //For editng task obj and doEdit will be send
                        submit(doEdit, toDoModelObj);
                      }

                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(2, 167, 177, 1))),
                  ),
                ],
              ));
        });
  }

  List<ToDoModelClass> cardList = [
    ToDoModelClass(
        title: "Instagaram api",
        description: "Backend contact la contact karra",
        date: "Feb 26,2024"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2000,
        title: const Text("TO-DO List"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(2, 167, 177, 1),
      ),
      body: ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                    //color: Colors.white,
                    height: 112,
                    width: 330,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(10, 10),
                            color: Color.fromRGBO(2, 167, 177, 0.5),
                            blurRadius: 5,
                          )
                        ],
                        border: Border.all(
                          width: 2,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        )),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            //ROw
                            Row(children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.7),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                    "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564394-edit_81508.png"),
                              ),
                              const SizedBox(width: 3),
                              Column(
                                children: [
                                  Text(cardList[index].title,
                                      style: GoogleFonts.quicksand(
                                        //use google fonts
                                        //style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(cardList[index].description,
                                      style: GoogleFonts.quicksand(
                                        //use google fonts
                                        //style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      )),
                                ],
                              )
                            ]),
                            //Row2
                            Row(
                              children: [
                                Text(cardList[index].date,
                                    style: GoogleFonts.quicksand(
                                      //use google fonts
                                      //style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    )),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: Icon(
                                        color: Color.fromRGBO(2, 16, 177, 1),
                                        size: 20,
                                        Icons.edit_note_outlined,
                                      ),
                                      onTap: () {
                                        editCard(cardList[index]);
                                      },
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        color: Color.fromRGBO(2, 16, 177, 1),
                                        size: 20,
                                        Icons.delete_outline,
                                      ),
                                      onTap: () {
                                        deleteCard(cardList[index]);
                                      },
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ))));
          }),
      floatingActionButton: FloatingActionButton(
        elevation: 200,
        onPressed: () {
          showBottomSheet(false);
        },
        child: const Text("Add"),
        backgroundColor: Color.fromRGBO(2, 167, 177, 1),
      ),
    );
  }
}

//this make to send all the things compusory if not given it will show error
class ToDoModelClass {
  String title;
  String description;
  String date;
  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });
}
