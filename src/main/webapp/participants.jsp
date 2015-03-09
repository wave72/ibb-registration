<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.tarine.ibb.business.ConfigBusiness"%>
<%@ page import="net.tarine.ibb.business.WizardBusiness"%>
<%@ page import="net.tarine.ibb.business.ParticipantsBusiness"%>
<%@ page import="net.tarine.ibb.model.*"%>
<%@ page import="net.tarine.ibb.*"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Integer ticketCount = WizardBusiness.countConfirmedParticipants();
Integer maxTicket = ConfigBusiness.findIntValueByName(AppConstants.CONFIG_MAX_TICKET_COUNT);
Double percentage = ((double)ticketCount/(double)maxTicket)*100D;
String percentageString = AppConstants.FORMAT_INTEGER.format(percentage)+"%";
//Integer reducedTicketCount = WizardBusiness.countReducedTickets();
session.setAttribute("ticketCount", ticketCount);
session.setAttribute("maxTicket", maxTicket);
session.setAttribute("percentageString", percentageString);
//session.setAttribute("reducedTicketCount", reducedTicketCount);

List<Participants> statList = ParticipantsBusiness.findAllParticipants();
request.setAttribute("pList", statList);
%>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>IBB Participants</title>
	
	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet" />
	<link rel="shortcut icon" type="image/png" href="images/favicon.png" />
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>

	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="table table-condensed" style="border-collapse: collapse">
					<thead>
						<tr>
							<th>
							</th>
							<!--<th>
								<b>Email</b>
							</th>-->
							<th>
								<b>Name</b>
							</th>
							<th>
								<b>Food restr.</b>
							</th>
							<th>
								<b>Country</b>
							</th>
							<th>
								<b>Arrival time</b>
							</th>
							<th>
								<b>Volunteer</b>
							</th>
							<th>
								<b>Amount</b>
							</th>
							<th>
								<b>Payment</b>
							</th>
							<!--<th>
								<b>Created/modified</b>
							</th>-->
						</tr>
					</thead>
				
					<tbody>
						<% int count = 0; %>
						<c:forEach items="${requestScope.pList}" var="p" varStatus="status">
						<tr>
							<td>
								<c:choose>
									<c:when test="${not empty p.payment}">
										<% count++;%>
										<%=count %>.
									</c:when>
									<c:otherwise>
										&nbsp;
									</c:otherwise>
								</c:choose>
							</td>
							<!--<td>
								<b><c:out value="${p.email}" /></b>
							</td>-->
							<td>
								<b><c:out value="${p.name}" /></b>
							</td>
							<td>
								<c:out value="${p.foodRestrictions}" />
							</td>
							<td>
								<c:out value="${p.countryName}" />
							</td>
							<td>
								<c:out value="${p.arrivalTime}" />
							</td>
							<td>
								<c:out value="${p.volunteering}" />
							</td>
							<td>
								<c:if test="${not empty p.payment}">
									<b>&euro;<c:out value="${p.amount}" /></b>
									<img src="images/confirmed.png" />
								</c:if>
							</td>
							<td>
								<c:if test="${not empty p.payment}">
									<c:out value="${p.payment}" />
								</c:if>
							</td>
							<!--<td>
								<c:out value="${p.created}" />
							</td>-->
						</tr>
						</c:forEach>
					</tbody>
				</table>

				<p>Total confirmed tickets: 
					<c:out value="${sessionScope.ticketCount}" />/<c:out value="${sessionScope.maxTicket}" />
					&nbsp;(<c:out value="${sessionScope.percentageString}" />)<br />
				<!-- Total reduced tickets: <c:out value="${sessionScope.reducedTicketCount}" />--></p>
			</div>
		</div>
	</div>
	<!-- /container -->

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>

