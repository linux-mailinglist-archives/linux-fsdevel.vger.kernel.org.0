Return-Path: <linux-fsdevel+bounces-24056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02144938CE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B134C28894E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005016C859;
	Mon, 22 Jul 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQCP/lRO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l08sZ6Pp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF016C689;
	Mon, 22 Jul 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642273; cv=fail; b=kIb3FqjZVjEzN9lWzivB70A8qSRqnnpn5uHH1ttxtrgSQQGJQvHX/sJJ2l9BcqMxWyf7eiV/pGsOXUh5RC8hMlazXpXZi7pyrWYX865jCbnbKbwr38j419gKdQnGKt2cfPgcEHVZ/8ScvOyZE71H+g9PYFXvv34rH0ADhk6iooQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642273; c=relaxed/simple;
	bh=Krg0dDumiklh1I3WD+rX8L0KAqNUWLIcVqV8zyBnGHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q33X7ANlJzDr8t1hmVEJ3U9Z0Y/H6j9JzpThgvCGheT+ggSpV6FXPnYva897HHfaxsuQ262Peb4jWzKukeGzOhR3MnfF3mU2mHnWqV/bIPkanzFtMPA/Xt9fQIj75mlbR/s33y3Q66g6emBN69wWvKK1sEgW7XdOffF47MVBy2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQCP/lRO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l08sZ6Pp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cv29031954;
	Mon, 22 Jul 2024 09:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=85sxQ3/CFQg+wXr7bRmy2JxgvMycwGsKYRZrFr3auSw=; b=
	AQCP/lROoYUjMGQXi3HWNeMoxN9oDTZryUuMirfB527xRHqyXqJB9x6b1V1jbEfp
	bFXSs2DQe5mwepSs1Z1OfG9sA4IKf8KOb4adLnDI9U5ClBRD52SR7aX4TF/u9ewT
	nOALOrSbt85W1NOnz3+48ekcsJXS8LUoPXFWyILfennp7juTyQwJlgmxtZBN0tAt
	PwgsBCt67cMeZ5+eej8ZcHq9k0eraBHP/oUd8xTPkxJcDWn9x+Mle5LzkSq9HKJc
	WVAipnP2qt0PkVeseImXdulYysnrnqjc+uil0s9wiiUZVg642PzCov7FreR5jKIW
	iNqc9WdGMwMmL+9CfZLnzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxp961n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46M91j1K009108;
	Mon, 22 Jul 2024 09:57:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29yqf8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViHe01T6Eq4rOybsk6pud3WwUfL7qwo/Xgp7EjNvoZi4aq8WaW+vh5mrMlyNBhD7VejgwBwLf4iLyFYkzDC/jiVK08hqOO/wqb0C97Mit72xgA0B6Qhaiu2EBAWYhSe+8WPlAcTXAcLCjF2MCxlp6gls1kLNpGLMuIdAf5j6c7tqiN7GLKYmmkEe1eFjqOp0XksD38RAlUPdZBKi9kiKEaTk2lnlbCJajnVsEDuE/Oqr7HvZ+HoJzNjTaziWe1e2kP3g3V3HpR3hIAMN8M4EXNRRAVL2pJnfQF+HeDHf5DUc3Hy5oArFEKmLBufX3BAy2mE3FSsR/Anmc7ito6jN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85sxQ3/CFQg+wXr7bRmy2JxgvMycwGsKYRZrFr3auSw=;
 b=Tvcnq86HgaDznfKYAwr+ATty2qj135ZkyoBzcd2XR9qw8EosrQ4KILcdqSlxP3MSx5nOOPanKnTBGGbkbZMyZG7WbINWdXhE0LTKv1rQHmveKAvavDJmMvAoz0VnMf+lDqGGmxMctEgP99gLcSmxwdGJzli4U+63mrszcTv4z/YWD1GrYtkPr/BDns8Lvi145cvZonqbfql2SlUNRqPCj3t7faUPyLmI46OBBXjbQld4JDZIgQJ4IxRSnAYSpRMLcH7vMbt8Ma105oh4Sh+JbUKFnE9l0DnxsDUzs/Yl+CEd4qVAjk7wA4E+b1KBrpUnf8aiwWUuVGw4Rx0NRXo61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85sxQ3/CFQg+wXr7bRmy2JxgvMycwGsKYRZrFr3auSw=;
 b=l08sZ6Ppsxf0JuLEQqRyZ3Mdsb3rG5yOL4oVX9X0IB+OM8J3ot/9cBfCyPY514kQMhCj86DEJ0CDfbMd3q+EGLrRbOQI5lIhVNLfdjO3fRxMh085aJ57ZzecdOIRyGJcVW0Q5IZlO3S6rvPEYE5kUxYP8q5KXvd1uleFF5L4L68=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 09:57:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 09:57:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 1/3] statx.2: Document STATX_WRITE_ATOMIC
Date: Mon, 22 Jul 2024 09:57:21 +0000
Message-Id: <20240722095723.597846-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240722095723.597846-1-john.g.garry@oracle.com>
References: <20240722095723.597846-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: b262c4db-78cd-43d5-f86a-08dcaa34b7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypwFD9aa7Sxy9t4j+1YaoJbuaw8IyXvoqVeOIZEEo061NHz8CwT03sfa1lm5?=
 =?us-ascii?Q?E41zBolwfW3/Qwz6bFW5rD872AzBOG3rOvBMWno8WwKEt29Xef5R4d1I0AXH?=
 =?us-ascii?Q?NMpuotuVAren+iEM4NFkmsAmBEu6WoV4qgg0WmE+P6/8AV6FMp26i6CihEF6?=
 =?us-ascii?Q?bBaRGD2CsiDVJmNXjqpjJTcdDsSuxNIU+EwWusjwq/6HX5cfAbUv+u1PROeo?=
 =?us-ascii?Q?Wi+UmcRtefMHAQE8c2DJFgV9y8T6dt9C5NFD1SQHCzbmbR8gRLsi5OgClLNz?=
 =?us-ascii?Q?g/l9Ysob6oH6jwNhpAlw7MAOXKKpuwI9/2N0UR4CQdqPBTQqor+svvXJWWbJ?=
 =?us-ascii?Q?JsjTY/jn4Gm8wKwO909vUw9HX5FHvsPaMbCpt04dJaPLOlsXW21f4zy3I0pO?=
 =?us-ascii?Q?1jj9LPxVT1agYEDy6n7qiFiJDp1hI7QT0/6SrADFoL6YQORw+WcgjqY4r9ZO?=
 =?us-ascii?Q?s9jhmxbsMIPdQV2zmZTjv9ej0l3dLsS4e0zZ+u5F0b39BFZxDkeGIbkV1p8p?=
 =?us-ascii?Q?X0K0cPKxbwCkQE4N8WIM1orYW5c/7iQ3Kr/kxlEZDRrp2+KpnXsmph6S0Yx6?=
 =?us-ascii?Q?c9mPeIDUmJo+YFf2QVpXUTs90znaic2Cd2ZeYYdC4umvhVBOs7yGMCrFKRuT?=
 =?us-ascii?Q?CZRWZRWiCmGWMjAFqbmlZld/kd0o3ERYyY8S7qGPshVjLoiY2ijU5jmLtkFF?=
 =?us-ascii?Q?vc5iPFYczdlJXz5eFBBYoA0GK4rNvtlA+aKm8FwIC13sYWX9YBmekmKz7qZI?=
 =?us-ascii?Q?tOcB8IfH6FoLz4IyWMVrOXjmBc2KHc2bKNzIBHxT5UJlH8At0RJ4Q/BWymkw?=
 =?us-ascii?Q?XE+yrFbOMsySXfumRlgm61ylVrXk8VOXBzPFNC8YSK65DZhhv1cv5vDor2Qx?=
 =?us-ascii?Q?/ud2QbtRD68M3OjNeg0kziTZTeAAXQ4FDqmjeh/dcrh0HtC2OYYUY47J+zE7?=
 =?us-ascii?Q?lZ7uYREkuOfrHpt9j1hxJDBn0idUZ0Q+Y8JW7MKKROTLAidAAENmkPz2UD5u?=
 =?us-ascii?Q?aECWBo0+4irJgtJ560MXWtKjTi7S92tsja5ORpAKEszR9a3ijPSutWn9rj9j?=
 =?us-ascii?Q?EDoS8eJWnMW3g2MDirdz+1he8u9/DXL53xbjc+B7kGaZphkCb1VRGlHIg9e2?=
 =?us-ascii?Q?hJLRC7bfh/AzJJ7V1ycy8+ZGpk1EBrk2wkGxvUB1U/9qvgFRpa0WBMd0WfHb?=
 =?us-ascii?Q?/ImWq1b2N2JfN8AxVeFZsWdHENsLgX8jaFnsPeDZAr6Q6SnA+p4J+Fh4+WqQ?=
 =?us-ascii?Q?146w9x059G7NFo+jAEpu9SxYXJCF7EqkGILQLcx6COjQUaZNXvc3L0XIK11q?=
 =?us-ascii?Q?Isma32FeMi2oPRcv18AjmviNBl68WD1m5FWc12haJnh/dA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZK+HiQlOW8kBARohqkSQDgZUe3ejbKcQR44x7Wf3kMvoKxYJLyGUkM2+eZP/?=
 =?us-ascii?Q?soO7GyVMmLWsrPpWMQg7opXW6bW+rQZY+cEGvbDuUu0988eH+EJzMWqEszds?=
 =?us-ascii?Q?8dHM7tlBxGvDACL8Yo1Qt5c4E3jbJWrhY7K8OFDpEkGsL/i7iU21K8l91eOZ?=
 =?us-ascii?Q?7WM2BG1EMi6v6Wiim2vqn0Wdfwj3YWzSvgGAIdEelrRUNelri7eDdVMWkwCL?=
 =?us-ascii?Q?13/FwcwlOC31XM4goIpxKsdV9pVgdwYTsKCFzbdhiu5QhK80g9mLvPaNs44P?=
 =?us-ascii?Q?74JsHfPhy/l2leQJUVLaSqFu1Vq4MBtudAb6hlGDdeF9Wb4vV/AnFznG4Kqc?=
 =?us-ascii?Q?jPTWfcir2kYFey/30jfpZQnKWRNfEB5g7VyPf8+uJKQvDGVghDjUZcobJrGo?=
 =?us-ascii?Q?/E15P06Zd27Juuc6xnFmhUiRUuhwW9QkDU3ZwsN92lwyRvYaa1hG3zCUxNan?=
 =?us-ascii?Q?sX11kKKhf7/GwjJpm2qglo1RZwwEMAqVDgPLXWAFVCweLe0G4HIdinumKVNc?=
 =?us-ascii?Q?vBomo2cP+Cl5Tq5CBUSr/qMwZ+qdUuu0ZLbfU6NohlV3rXNGr4Y/QNpkCewa?=
 =?us-ascii?Q?YdQUBgOIZj5k8w3bA9dRGhAoToRWLeBxSPVLQLOihqvp79s830H2pFOCqPvV?=
 =?us-ascii?Q?X2uPjBclTAA4BTNm4VeYApAdlaPAAVgtOOmEQZ+SdCgr6L8SK5d7cLyQ+SrH?=
 =?us-ascii?Q?mETBp8mZbUdLDNdB5H7I/U7ddTnVm8DUSoXYhMWGKiTdxpTWAgo6HPugkhgV?=
 =?us-ascii?Q?UBhO194lGn5N2amd9SeEwcu7Nc+FD6A3EH+PiKqXxWWLlxhBsu9woNnshXOp?=
 =?us-ascii?Q?7G+7fOFbbfvWB5vHULErDCX5zHjs03MWqnfpFl7lhrRcosYN/iOfUoTxiSBE?=
 =?us-ascii?Q?Unqm6VraYqKvPQH9DCe+MLor+k6Z1lihyQSvrkUEZY5ne1tr2JYVLcszhPLH?=
 =?us-ascii?Q?n2RaNiQiaoAdxGXpar/wFfLqpYz0qVbNb97M+eTfQXCXUniJdm7675Uiy/5+?=
 =?us-ascii?Q?A73oaOFhbcM64wtu5/4Xk7Azmqi5rDVDq8U83Kjk0Nm83FmQHddp0yzsNp46?=
 =?us-ascii?Q?I19LtUUM35WDlAEDflo6kIfARlXlsTmreThq1kypPO3ZhqY1+wbc3iSGpysO?=
 =?us-ascii?Q?MHI/4x0aXGqRse7WFUHYHdAMz5PMQn1FfyjeVcK+/wsp47oRaGybYICrvL0x?=
 =?us-ascii?Q?byeB0HkVXGiAEz3tLKDbpLsbvkVnHaWLziYVPjNkvHDfJl87sbH0RHbRPN2Q?=
 =?us-ascii?Q?P2Ia5HWqJin9OIHbODdk0tVwkjIxArQg6LIH5gJ3dr9uQOeEyCkKe2kWMyv5?=
 =?us-ascii?Q?AA38TcuAjlZndF1JYyGlsZMi0/qFQjAWDocL0pysABO/ho0Va7ILgW+YEU82?=
 =?us-ascii?Q?gV4VIr/zqGeg7/z7RyhIVY7hezEhIQwz/wtzSVpa8xVlDN3XTTbMtrVBd+21?=
 =?us-ascii?Q?LW5rEyuQ3wcFTZoQ169WCD52bXlIb0TOoIbiIGKmCNOe2BAqAwr/F1xbuojF?=
 =?us-ascii?Q?7v3UaWQW7Y5A4kxFtVD53KVI9r06jydGDK4LAJpjZuwIkW1+g/UtSKZ9KLm4?=
 =?us-ascii?Q?WHClnNWTXQL7RhkDmQBklSi1LnRF1EfS+ebZlUzg8d1dtqgajak7Fd5rqUsS?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oJPxGM8WrobhtHsQLlC9yn5qHTOJc4S6ahhUKoBVnLCcjUoEXaaKx9pNXtCulfQ9nuufZfvhtQj1z4GHASUwB5e8vGI+KPOza2/bFz8Esa9wj9wOFlAdwvIhJRxaewvl+q1C85jxliavearUyWWtoj9y9giM49/YhhSBbsnkubCCv7sVlBlj0WUipNNtbRCyN1bCLaaXZI+t+NxthrNA7MQFoPtRfm5JLiysbgdHhvvdBYpF6BBvHW1sxM79SVeLspclEfROdmdbkpO4JVGenSHhbOqwZ9vPh6d7MuEo04A0jzmYdWDF9t86P8Ui2FeUkyrVCzULYH7kuL+NuazkHnZRQbyCitPFUIOBRnMgQVwouPx7Sn+CcBEDnw7FMrAnfHmd0GVL7f6cMLKHHgZUw+SRBzE3o1pFRAQ3B4hf+70vM/0NsFlgVd3mPdiQdTl9yjV88e+GDo36UuFgzM2DiBEmmeJuLhAAZm1MjIXjqod9O8qPnwTJQhB/KNj0s9ngAjf+4JJaBPAiV9CzRz8l1/CevtO4w+fe9szw+6nRKMdmov7HgaPL7sJgoG65QGwzwob1Q2xzxb1MA12/yPUVbDOSyf5bGdYm/1S4EvaScw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b262c4db-78cd-43d5-f86a-08dcaa34b7e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:57:38.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTr2k4e0fRqKsndceAdlpZ5c50Mnff5GufMxn5Krz24YKhlwSBBnbi7DpenywTYxN0Z5QU1ilrgThQhMIbzJZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220076
X-Proofpoint-GUID: eQ1mn7uwNr4glj0s8HFQLMswTUN8T12a
X-Proofpoint-ORIG-GUID: eQ1mn7uwNr4glj0s8HFQLMswTUN8T12a

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the text to the statx man page.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/statx.2 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 3d47319c6..a7cdc0097 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -70,6 +70,11 @@ struct statx {
     __u32 stx_dio_offset_align;
 \&
     __u64 stx_subvol;      /* Subvolume identifier */
+\&
+    /* Direct I/O atomic write limits */
+    __u32 stx_atomic_write_unit_min;
+    __u32 stx_atomic_write_unit_max;
+    __u32 stx_atomic_write_segments_max;
 };
 .EE
 .in
@@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
 STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
+STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
+	and stx_atomic_write_segments_max.
+	(since Linux 6.11; support varies by filesystem)
 .TE
 .in
 .P
@@ -463,6 +471,22 @@ Subvolumes are fancy directories,
 i.e. they form a tree structure that may be walked recursively.
 Support varies by filesystem;
 it is supported by bcachefs and btrfs since Linux 6.10.
+.TP
+.I stx_atomic_write_unit_min
+.TQ
+.I stx_atomic_write_unit_max
+The minimum and maximum sizes (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection.
+These values are each guaranteed to be a power-of-2.
+.TP
+.I stx_atomic_write_segments_max
+The maximum number of elements in an array of vectors for a write with
+torn-write protection enabled.
+See
+.BR RWF_ATOMIC
+flag for
+.BR pwritev2 (2).
 .P
 For further information on the above fields, see
 .BR inode (7).
@@ -516,6 +540,9 @@ It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
 .TP
+.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.11)"
+The file supports torn-write protection.
+.TP
 .BR STATX_ATTR_DAX " (since Linux 5.8)"
 The file is in the DAX (cpu direct access) state.
 DAX state attempts to
-- 
2.31.1


