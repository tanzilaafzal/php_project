
create database tests;
flush privileges;
grant all privileges on tests.sql to root@"localhost" identified by tani;
SET storage_engine=INNODB;
use tests;

CREATE TABLE IF NOT EXISTS answers (
  answer_id int(11) NOT NULL,
  answer_text varchar(800)  NULL,
  answer_image varchar(450)  NULL,
  correct_answer int(11) NOT NULL,
  priority int(11) NULL,
  correct_answer_text varchar(800) NULL,
  answer_pos int(11) NOT NULL,
  answer_text_eng varchar(800) NULL,
  control_type int(11) NULL,
  text_unit char(10) NOT NULL,
  quiz_id int(11) NOT NULL,
  PRIMARY KEY (answer_id)
);

INSERT INTO answers VALUES (1,'dfg','hjk',9,5, NULL,0 , 'nmk', 3, 'b',2 );

CREATE TABLE IF NOT EXISTS assignments (
  assignment_id  int(11) NOT NULL AUTO_INCREMENT,
  results_mode int(11) NOT NULL,
  added_date datetime NOT NULL,
  quiz_id int(11) NOT NULL,
  assignment_time int(11) NOT NULL,
  show_results int(11) NOT NULL,
  pass_score decimal(10,2) NOT NULL,
  assignment_type int(11) NOT NULL,
  status int(11) NOT NULL,
  PRIMARY KEY (assignment_id )
); 


CREATE TABLE IF NOT EXISTS imported_users (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(250) NOT NULL ,
  surname varchar(255) NOT NULL ,
  user_name varchar(150) NOT NULL ,
  password varchar(150) NOT NULL ,
  PRIMARY KEY (id)
); 



INSERT INTO imported_users (id, name, surname, user_name, password) VALUES
(1, 'test1', 'test2', 'user1', 'ee11cbb'),
(2, 'test2', 'test2', 'user2', 'ee11cbb1');


CREATE TABLE IF NOT EXISTS modules (
  id int(11) NOT NULL AUTO_INCREMENT,
  module_name varchar(255) NULL,
  file_name varchar(255) NULL,
  parent_id int(11),
  priority varchar(255) ,
  PRIMARY KEY (id)
);


INSERT INTO modules (id, module_name, file_name, parent_id, priority) VALUES
(1, 'Test Managment', NULL, 0, 1);

CREATE TABLE IF NOT EXISTS questions (
  
  question_id int(11) NOT NULL AUTO_INCREMENT,
  question_text varchar(3800) NULL,
  question_type_id int(11) NOT NULL,
  priority int(11) NOT NULL,
  quiz_id int(11) NOT NULL,
  point decimal(18,0) NOT NULL,
  added_date timestamp NOT NULL,
  question_total decimal(18,0) NULL,
  check_total int(11) NULL,
  header_text varchar(1500) NULL,
  footer_text varchar(1500) NULL,
  question_text_eng varchar(1800) NULL,
  help_image varchar(550) NULL,
  PRIMARY KEY (question_id)
); 



CREATE TABLE IF NOT EXISTS question_groups (
  question_group_id int(11) NOT NULL AUTO_INCREMENT,
  group_name varchar(450) NOT NULL,
  show_header int(11) NOT NULL,
  group_total decimal(18,0) NOT NULL,
  show_footer int(11) NULL,
  check_total decimal(18,0) NULL,
  group_name_eng varchar(450) NULL,
  added_date timestamp NULL,
  PRIMARY KEY (question_group_id)
); 

INSERT INTO question_groups(question_group_id, group_name, show_header,group_total) VALUES
(2, 'bhj', 0, 5);

CREATE TABLE IF NOT EXISTS question_type(
  id int(11) NOT NULL,
  question_id int(11) NULL,
question_group_id int(11) NULL,
  question_type varchar(150) NOT NULL,
  PRIMARY KEY (id),
FOREIGN KEY (question_group_id ) REFERENCES question_groups(question_group_id ),
FOREIGN KEY (question_id) REFERENCES  questions(question_id )
); 



CREATE TABLE IF NOT EXISTS quizzes (
  quiz_id  int(11) NOT NULL,
  quiz_name varchar(500) NOT NULL,
  quiz_desc varchar(500) NOT NULL,
  added_date datetime NOT NULL,
  show_intro int(11) NOT NULL,
  intro_text varchar(3850) NULL,
  PRIMARY KEY (quiz_id )
); 


CREATE TABLE IF NOT EXISTS users (
  UserID int(11) NOT NULL AUTO_INCREMENT,
  UserName varchar(50) NOT NULL,
  Password varchar(50) NOT NULL,
  Name varchar(150) NOT NULL,
  Surname varchar(150) NOT NULL,
  added_date datetime NULL,
  user_type int(11) NULL,
  email varchar(200) NULL,
  PRIMARY KEY (UserID)
); 
INSERT INTO users (UserID, UserName, Password, Name, Surname, added_date, user_type, email) VALUES
(12, 'abc', 'abc', 'abc', 'abc', NULL, 1, 'abc');

CREATE TABLE IF NOT EXISTS user_answers (
  id int(11) NOT NULL AUTO_INCREMENT,
  quiz_id int(11) NULL,
UserID int(11) NOT NULL AUTO_INCREMENT,
  question_id int(11) NULL,
  answer_id int(11) NULL,
  user_answer_text varchar(3800) NULL,
  added_date datetime NULL,
  PRIMARY KEY (id), 
FOREIGN KEY (UserID ) REFERENCES users(UserID),
FOREIGN KEY (answer_id ) REFERENCES answers(answer_id )
); 

CREATE TABLE IF NOT EXISTS userquizzes (
  id int(11) NOT NULL AUTO_INCREMENT,
  UserID int(11) NULL,
  status int(11) NULL,
  quiz_id int(11) NOT NULL,
  added_date datetime NULL,
  success int(11) NULL,
  finish_date datetime NULL,
  pass_score_point decimal(10,2) NULL,
  pass_score_perc decimal(10,2) NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (UserID ) REFERENCES users(UserID),
  FOREIGN KEY (quiz_id ) REFERENCES quizzes(quiz_id )
); 

CREATE TABLE IF NOT EXISTS assignment_users (
  id int(11) NOT NULL AUTO_INCREMENT,
  assignment_id int(11) NOT NULL,
  UserID int(11) NOT NULL,
  PRIMARY KEY (id), 
  FOREIGN KEY (assignment_id ) REFERENCES assignments(assignment_id ),
FOREIGN KEY (UserID ) REFERENCES users(UserID )
); 

CREATE  VIEW myView AS
   SELECT UserName, Surname,email FROM users WHERE UserID= 12;

CREATE  VIEW myView2 AS
   select UserID, UserName, Password, Name, Surname, added_date, user_type, email
from users;

CREATE  VIEW myView3 AS
   SELECT s.UserID, s.UserName, q.quiz_id
    FROM users s, userquizzes q
     WHERE s.UserID = q.UserID;

DELIMITER // 
CREATE PROCEDURE GetAllusers() 
BEGIN 
SELECT * FROM users; 
END // 
DELIMITER ; 

DELIMITER // 
CREATE PROCEDURE Getquestiongroups() 
BEGIN 
select question_group_id, group_name, show_header,group_total
from question_groups;
END // 
DELIMITER ; 

show tables;

select * from answers;

select * from question_groups;

select * from imported_users;

SELECT * FROM myView;

SELECT * FROM myView2;

SELECT * FROM myView3;

Call GetAllusers;

Call Getquestiongroups;

