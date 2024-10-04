Return-Path: <linux-fsdevel+bounces-30946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B9098FFA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958B31C2233B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745031514CB;
	Fri,  4 Oct 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OEkDTVxZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BhxOzOu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F014BF8A;
	Fri,  4 Oct 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033839; cv=fail; b=jo1lQNjQ2TTgQRST2Fg6d+eEjPeMQmHFuYr+CXGOUJERMSXHUrTTDMFJ7ji7egZaRSZl1QAWFH0WX9Pqnb4TaMOBudEDw4Q3Mdln9yrShA0kCzWo4CpBg1XEFkAL4kfu//Hfnd51FjjOke4hX4OyFbofVKtFNpuJ9vON6k/ksEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033839; c=relaxed/simple;
	bh=lxd4N7eR28r3sbPqxxker7d0yndncwA0/HmE226Da7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ACZq5SWTJfecn6wDVV/wd9bhu5W8Q0u38xnchoi3INllk0HFNUuKxZocl4ZcFcLFJTWPqE40UECdWPBIMyM4vJQ12Bz39NJ+T0X4/oMnMLcl/oD48UY9/AvsPbH6olfE8JBuaKPEgIKdDsQjB3Z9LPAhwvIx/NLrj92q+pxtOZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEkDTVxZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BhxOzOu+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tev0013498;
	Fri, 4 Oct 2024 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=STxOqbCDp/AAc3DmRB7xsYyTvFZ4NcYVVjPDSnzoTcs=; b=
	OEkDTVxZp1/hgFS8qpptzWZTRmhBng42mevj55n869sVDKfV0/qhtwU+cKSV/Zf5
	C8vPZIT2PugdsKlUnGZiF8BTD7+d11/+Tkn6f/RXGrBed4oFP8wAc0nBrno4q0CL
	DMMVgQGSZUkQ9JtrTxRV5ATtLG9PBuhGGu5OyGhA7RXqLZ0ITgyGYQvmOUnBJOJ2
	2kPVp/FqCs98TiBfm04Y/ACUbzKca7NadJBDMUXzmua8HjR1LY0lTHD57r4j07di
	/sMPP6eYlpW8L169mWQ8jmuCoZ4C5bl7ciDx0Ek5Yhc+fHPBmBHORQ2QspNjYxvM
	2Ia/mCG0wn3Rpwvl2LegPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204es6pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49495IE7038110;
	Fri, 4 Oct 2024 09:23:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057118t-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw1WCL+nYeHb0bVGkY8t3atGL8cN+N7jvPxR3BFmPoSlVlCzsrHG3oL5s0euy1+XpTaqfve87QKA7GyBkK8Av+FfL0TkaYzl3ER+xbOzI2WMuMJjln38oxE2c3bROnrLjsM5j2ZnYsPkLOKjLUuptZUvTPloJTBbLQkuMj1p043j7heFZcyEpab155MTiOg3qu3kwHb/IOEB5Ii77X3XNGy0h3BkH9lJ6JClYEYx5ehU3jRKmjdaCugw2JZ06ZRzmFCVMEn+Trhtp3KM4DYsJO+7pYqmm4e26gizECo8Vliu7wgUZQTGygtuQVLoc4JTIeioDvYvs16/eF6SIwNHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STxOqbCDp/AAc3DmRB7xsYyTvFZ4NcYVVjPDSnzoTcs=;
 b=G3ZGNqFatcMKHxnvTfWFL/OP1mDr1Tn0ODSfnA/HeaZjDpJsnOHshLMvYsqbFFE6IfM47xS5XXgIO10YNh8j7VBWYM8C+DjUqTh4o68x4sfly1CvLGvu8PCJgotKp/5t1gymPyo7hdf9r+TRAvEdvjy4bFg8RYy7Wo85zsbI/iUizfGVyqbkZZ+6XFlPXemsasYrbQbjUs0PU19AfYr55+SFTZbZSpBlCCisdTarv2SL8p3InSGKdDZLvImHy4q37Kdj/NQZbBLFo1P9jaxlSEJU4j87GoNfYl9UmTdRVizs4CHbcwLd0FesNK65+ic+X/qiJ5lcBGLMjPR1PQZUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STxOqbCDp/AAc3DmRB7xsYyTvFZ4NcYVVjPDSnzoTcs=;
 b=BhxOzOu+JJpTR89Puv6V9yWTtKUUwtCP2msEMW0yVd4zFU/Lnc8Fmcn9pn6ngMp9L/bL6LdaDN95ruOjDryl7cV78xpii1YMT3iTNiRcvjJM2pjh09s7L3YbJ3+DMKJ+Gf8V81bGdoCJXJgc13ChFezcBGOCgz9c9Dv/2p3NUL8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 6/8] xfs: Support atomic write for statx
Date: Fri,  4 Oct 2024 09:22:52 +0000
Message-Id: <20241004092254.3759210-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 132148f4-8a75-4b4d-00cb-08dce4563519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsEM55BHyU2vndK/nW+oO5t2jvD8D93m4waWNp55nUk1dAG6uG+Tb0pmsu9c?=
 =?us-ascii?Q?cLIgKRC8TrzWdv4MrV5vsMJn3N1mh3XvkD6SOcELazu83JGFIJH/Qli1oJCR?=
 =?us-ascii?Q?pbUgmTtpI0SVPgYwbglOskvDMxMq1wNzjRoABOdq+m7r/xdhXhlsJ9vb5mx9?=
 =?us-ascii?Q?bvjN6mbxRA/XtHptIBPb3eYXiKs585VcSl+5MY1S15qDqBIk1Ij2HARwv79u?=
 =?us-ascii?Q?cBe3Non2ykB4MRKYYsOjsj68snOJqTynefs7A+RSx02fOsNIgNuNLx6CQ8KT?=
 =?us-ascii?Q?s0AUrjcfyCYxVQTC3H9zrjnQP9pTuyMpwHFXc5eLqsEeJbtCcMH5obfOewK0?=
 =?us-ascii?Q?JEzBGjp51dH91LP4rN2Eej54Qk59iHjydbB1E7w8MqIF5qre7k7Vp1js7++K?=
 =?us-ascii?Q?U/ErFXkfSZ3K/AhtmG7dURwnK2KcKixmVI5VRlI0UVuokYu1AVOQ4OGWI0uB?=
 =?us-ascii?Q?lHvZmW9eaHOZty1C1rOSTEa3cs4acq1UiGjgQjaKvwJ+FKcBLMXcZWBNTc76?=
 =?us-ascii?Q?7JAd7I5mPiC7xPEDpEjfk+OpFx/hfrb5MgZkYvcP1zfB4MbV0LP3geZeDVn1?=
 =?us-ascii?Q?+1VlRy8zklICtlAiJMnoCSEuLef3+6OHYt0i9b6j98GdAR8pzvSLymDSldBB?=
 =?us-ascii?Q?8liOG/cNjHskemLjMLG6mDfTUnsrdpXKzZTiDol82aFvUnQl+jPH2njXUiIZ?=
 =?us-ascii?Q?0SZypQXb80wck2ebATJGq/NQV0yA7myQ+3RIf1t25VYC4YjkHkOnc8xrVG7K?=
 =?us-ascii?Q?C6WFvnQ8aLT9JqcGfgCEgM8NY1fiF8ax3CMarYp1dWN1Ud+Dr3RBaHpGl6M7?=
 =?us-ascii?Q?DFepii7P6W4TC34lrqN7rGV+XBvW5v8KDaii7WY+4ITQ81BUd642knTP/PpW?=
 =?us-ascii?Q?SiMaBRk0xFbmQc2gHcx0SMDTxDk4hXbrxSZfxQc1rer9IiPvowiNpjTzKUuk?=
 =?us-ascii?Q?VpEUJRg0NaZ/IBMqaX5nsp13fo9Za7qG2K/pmAIKnSO7oTQ+37ovw7BK5VJq?=
 =?us-ascii?Q?0rgu8o6vJnSGe5QHZtteH3p3IfWCHzBkqtxMg3vN/5cqiRZp4fO66AQKCaJV?=
 =?us-ascii?Q?xWH9Bs3Qz96BsBf7CbUczy7mDKVk/AOTtmyYVuSEGr+mrXOqC3m3sWoaEUw3?=
 =?us-ascii?Q?R+P4pv2TCKkmeQMAv7CHUGraDbf8ogP6VVxkkDBfm2SiO3Zu0VDRSLoK8bx7?=
 =?us-ascii?Q?kWt/IBzmOf/jZciMT+Va9IcrB15Wq9a5i9Zu0wsBZrB0L5IXLpNdIYNY/jU8?=
 =?us-ascii?Q?tEVtkuAg07gJqJmGKyM9W02nCb0Whd+lI8/1il8LtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJm/aKRg2eRYAk6o2MonJdYG/QGx5scvm6yttoDS7zGszf7337UKdjHjw8wF?=
 =?us-ascii?Q?D0VYtCBxXz5ul0Bx6UVbHujevW2cTQ/SFGOTbc420L+C4f8kyB19xl0ilvbn?=
 =?us-ascii?Q?mrdR5hRnUT+brbeD6oX33fTleL62ozhJRs0NGRVoq+opL1oWZmaqu4hBCyUh?=
 =?us-ascii?Q?rFPpguC5opuCWZ1N+f+15M2SHNRgCME9FioYCb985cWR/DfBrgoCrK71QnxR?=
 =?us-ascii?Q?MO3szfxcU1vejmgCnK1sh1xu5NLs01iREPICJubxrOvnAayN1bgkvXEW+ZX4?=
 =?us-ascii?Q?G/SLqfbr9TPJeUr4Yc63IKcCva6HFPC590L0fiEu+bt8wYPG7J8mM/+XRSPp?=
 =?us-ascii?Q?//BUtiLF0pXcalsC50cIHnM/4E0MFUlNybJSD8PLT6+n6ZzTi2QS0y7OHhLH?=
 =?us-ascii?Q?8VblZpMev4HK08j3zCz3oxBkboF7fOATI5JYvkm4MB7cOp13liqLgLClLaMt?=
 =?us-ascii?Q?OElFoy5eeoofMh9ZKeR+iZHveN5rLqAibxrjd4/5fyOexx1fiZvMarjaa3kA?=
 =?us-ascii?Q?D9LH+iz5YTiJhimvqwt13N8z7W3e20L/8xpNTfXcOob7Zo1jttBK4Uc34itC?=
 =?us-ascii?Q?nFPmfemp/s06qY3NEe8PdftQaia5jQr9kXIvSgLfULllZxzRnugF8pUz0P/U?=
 =?us-ascii?Q?vuVp8XIws4+Bd+s7QeYmThp5s/ADyVMDhDSPXBDgdJT2ZB5c3wGoQNqJGS1n?=
 =?us-ascii?Q?G7dXaZtvP2tsWEUzycomruOcWSqAXnWbJClNXMT/G/XM7Xg/UfJCZrJ6Xmj3?=
 =?us-ascii?Q?P4D8faMxh3/NNwfUqe0PKiJfJNuw+Qt9Yhnt26ArhrlBM1gU3ZyrBNBmAi6q?=
 =?us-ascii?Q?xChY+cxp0LLrd1oqvqcZBWIdZzrEGy6hXlGbbSsoXb0MhFbnh8/mP/dC2TKL?=
 =?us-ascii?Q?8pkZCQ3dI59+HHUSIfqvlFRMLsIWOqPE4j6cudavCqNTkr7aDsGsaEqCAEz1?=
 =?us-ascii?Q?NABDXCyqpsCzNfmChtaP38lAV3/KW1pW3KxOGz1JAXg4sGZ6Hk1qO9dvjz2O?=
 =?us-ascii?Q?iBiPEwZpjJYw5VoKANOY/ur0n3MGl7Vq8sPefLpp0bTyFh24wd+A3Jd0tEqu?=
 =?us-ascii?Q?0G15VwVTPdDlzzuqFrBrHIinXJq9hHj/He4DrS2S77wtj9O5hsYxs45xLaYH?=
 =?us-ascii?Q?jhWeVlGv/9pOx0IPJLEjiXwLq6B3mMuzB99EKUEtbYWSUHst3qhl0H1drPfI?=
 =?us-ascii?Q?japc5QA3729wxIo63pq99oU3Px6KCPTA+OaFy9rdLo3cJb6dIYSuQPQpi9OQ?=
 =?us-ascii?Q?OsVEqnYtcHBfkNQM7amI96+UbpWm6ZtjL5f4iG/tzMnAzFQmbzTh85NY1C9B?=
 =?us-ascii?Q?G0GzpXkvrz9ya89P7XVQ2uqVQ9MRtnvCmLOlfJoSEHpFZ7nh6mgIKaktsaRG?=
 =?us-ascii?Q?/ueyRSsWU6zxJS8cIvXMYG1eOP5UX1dzzaynmfOINMxAg0qY8DAVrUI+KeLD?=
 =?us-ascii?Q?0hcHc8FDjN6KqQTTjGMRjfaL0huk2n7AJMW2jayZ+tSOcawg+A3H/almQUNS?=
 =?us-ascii?Q?mN/6nQ+KM71hYjAuwS/BqIjw3JVse2G1M6GQodTPUrGcdQaZzm6dY4cg70V5?=
 =?us-ascii?Q?C5qCMbeKa2/qnl/yMpq2+T0oO4HM9mvWRvPLWn15RjoMXq2KA6z7IjU8DYuc?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w6gVkQwc9NTkRqEEX5/KRY4oHO/oxPGvdGyA+flNLHhiNHdGYJ2QB+atsmLzkHcm/SJn2OMWNDN5F3L+D2GlNmE/GkAY+4N7bX0XCtzhmSxD1jxD3OBgUo2J9v/tf1McBejYrSFARgesnF9m+rxdel8zVeHGKwYeu++xnBtuP+GAGy+FmRK+r7vNQc8R5UIQCU92yv6hJ+yEKfVsh0SYkcZh/iiVCAVhXAfSluwO9jzrvVrFmLMPf2+VxZkb25nhcVqFIYenIRSv/eO6q5DelxIHfWh432l5LdCWUThbAFAlMzUOeC0tQmMyx8oDapIsgJ1BAgLLvPZA80gp6FpbD5y1KrpZAvM0bCNInggPLi5NDope259i/SYWoA7CiAa0o1t8w/SUENDX1SDmoDAtZNb2Wakf3+5vfNoWMimXseAW0b0+KuIzwrf+0sVXHuoNNcqBoSXh0Mfst1xHpNwuykibihZZmp8HV8s/SS/lPGBeBiXPtx2CSuCu+GuLRqyKr/FYYggxM9cmFCctbRwbme82r+y2BA/MOYuIRlUH1oemRU6u5iUQCDz9/A+A1wXXVyZsQn+hDl72NXPgsowdYj9JoBvZTZjlI8dxKMMhp50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132148f4-8a75-4b4d-00cb-08dce4563519
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:29.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2LAVwZQwqAgCMoXHLVby3GxWHWfMdAAgXtvhfkOIFjXCuxmF13B3cDPOwItQH/SjMX9iFYMhA6MqxJw5ggDPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-GUID: WIcIm2G8_eJceelTyYMssxjdBhJQXVnp
X-Proofpoint-ORIG-GUID: WIcIm2G8_eJceelTyYMssxjdBhJQXVnp

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size. As for
max, we limit also at FS block size, as there is no current method to
guarantee extent alignment or granularity for regular files.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.h | 17 +++++++++++++++++
 fs/xfs/xfs_iops.c  | 25 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1c62ee294a5a..1ea73402d592 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -332,6 +332,23 @@ static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
 }
 
+static inline bool
+xfs_inode_can_atomicwrite(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	if (!xfs_inode_has_atomicwrites(ip))
+		return false;
+	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
+		return false;
+	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
+		return false;
+
+	return true;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..919fbcb4b72a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,23 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+static void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = sbp->sb_blocksize;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -643,6 +660,14 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min,
+					&unit_max);
+			generic_fill_statx_atomic_writes(stat,
+					unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.31.1


