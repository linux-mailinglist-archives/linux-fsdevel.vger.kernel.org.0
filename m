Return-Path: <linux-fsdevel+bounces-23217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA55928C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09575B22111
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71B16F8FC;
	Fri,  5 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCOb8bEg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3/pJnbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAA16F0EA;
	Fri,  5 Jul 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196731; cv=fail; b=INWTi0oz51rIv95pcC10jNKImr1Sd8Pqv77wYV3VqSWGa9TczhSbXXVyCLAcu+rq8OBFy3Yr3kMrZxsEONMmLWLkBiu7i7O1WU4aI4XtjzEhAhxwzANI+IIqot7JTOezIF4xvYAJ97PT7JAdJuB40oJGajZb7tGIqyjdLqBtmSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196731; c=relaxed/simple;
	bh=rZVCo9aLhqp1blOlClj0pjFQK9NTtNJrDY8y9Frur4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXwjvBYaTN9DyS3iOvythGKy+ia86NBW1FaTF2oKnr8Kzkv/DWhlzD17uxegCYhjLu1+VFDoy8X8LV3Gs3hoF9n5BcZOEaMZARGt9ujWCNaYrsY01SfzoSBFd9iWHbb9/n1RPVLXDWHoCwApuFF4FKiritqTjKWHQ0XX5qHSgQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCOb8bEg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3/pJnbR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMXvs007941;
	Fri, 5 Jul 2024 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=fH+NjeJoJ8kTTBBuZuuq71TIHENCLkxgvQrCzd+oBag=; b=
	NCOb8bEgv6DWUFl9sfXaKlyPGH680E/4qY5cvv+QWaYHH2njIqKM+Ib8GFhbqFMf
	ZXE8EWw06SF1ed/qK5CGSbSmqJHZatqQVhStBGqWyIKyGmbjHs+RVXnbu+FmXy/Y
	H5Rehju/7ppV5gOFHLPBzRLeS7OgLtijBPxiHejYqsvveDmz2fcB7LSGAxbqcIe8
	6KybG1VP0iOUZWOxnl5Q2FYVNHswrdcisty/jbx9pJnmJ4lq2UH8to+jYzHWe+xZ
	HbzcRmUtAhc21q0IYqetn7MYGYvZknNLegs4jrktM/36tgARCczFJ7R13/7aaH+z
	qnjKbVK6JDlfr0PAM2kGtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgns5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465Fs18t021462;
	Fri, 5 Jul 2024 16:25:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhm3mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcZcQ97tXYMyQ6GOhDWKPtiAs87jJdH9uox/2BACy6xqYOSyAc2fuoMsjisKoDTN/Qextd8ULzDTnx9voSkPRdsEW2ims7ZSIPN7k4GfHVxQl7ecZx5+tiCh5Jv8hTtTWjymv2omPdvEP9lVJpqF2QSajU66KdObQohM4CrhqZ9+VRggKSAeHEyNh5crXj12QhevgpGfEZF0ftvHte90NiuYh0pkorxw92btqqdJqdmFR5fz0YfT1ZK20u7fHC7bXQx4OyZWSLohbSjNpqsQZMR6OYj4XiaxOu7mKJyoSWNd6rIgnGhULuDtUH+X11KY7WNn8aUjM/dW5r88IYO/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH+NjeJoJ8kTTBBuZuuq71TIHENCLkxgvQrCzd+oBag=;
 b=TmtnwkVLls8VPCOJ36KqtEBdsOOarirBbntTKQhR0AYVNl/LvcaV/OEWS4U0yYrjg9xRdQEZILns+EFRkUwVN+pFBwgGNbhkoSlsgbxtXTT8aHBxxl8LH1Nso/BYd4YKoDoR9yP8KAZXXULHX3NLb7ScJaf6pxCdmSnaaZ8V9/bm9RQGSx5bSjxWdN4U2B+mBSISk1GiRhvZ7ZKK8G9X+AWzt9f9l6uWlpKfAC/oveDrL7sLeZ6Oh8L9FEALBr10kqsti8Zrup+SzjmE5e+ISSsLm/wEtf5DW03hqYPS4ENF82j3LLMa/Pm35R2UoDvt86pN2b4qj3mgCkwW3EaP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH+NjeJoJ8kTTBBuZuuq71TIHENCLkxgvQrCzd+oBag=;
 b=J3/pJnbRbkCZgpJpJtfL4xg4qu0dT0pB5moupO8gvWdkZA7mVl2FLDiLELxtd6mWpcFnZN6FH+Ta/KuOQ2qcONdLtxKuFzmTCCEWrTsBI8Qq2+Nicr64xCuAVKIMoDoXPG4PRlF2V62bvBKi2sH7GHCEBnrhLfdjc+HzuhJLcJ0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
Date: Fri,  5 Jul 2024 16:24:45 +0000
Message-Id: <20240705162450.3481169-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a1b470-d82e-4cae-598e-08dc9d0f0fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JQVkUC77sMffXaQ73Ge3WU/XhFeYCzlHZshdjUxb+CTk2blzPjkzVwQafVze?=
 =?us-ascii?Q?aoJxelsnng24DenPr10tJAQK2eKyJns78JW2Jz/sschfLwPX76oSOV/U+4Wz?=
 =?us-ascii?Q?rb5eUQuP2ZFH17VSpyNuz8n1VwqumF3Eqa+NyE6Fn96/PERgO+gyeUBRX0wV?=
 =?us-ascii?Q?0GquDoM99ycXMH/JjODNxNtpwxpCgk2MmlOB50+6q3eiu7KxWiIOxfOUjgaZ?=
 =?us-ascii?Q?P+Z3kQgnW8rdwHp73TEJJoRoGm540hfI6qwlSg6Z2QTMkEzJjAUWnhvyP32Y?=
 =?us-ascii?Q?Ix2YoNKkMzB2yIa1ovcRPYTePPlPDCgXMaOsEZLy+bPuFf8qjX9EInqq09Qg?=
 =?us-ascii?Q?mbnMac/lB+PA4oJ7UDmh+Jzv9NTrdSUgdhfLlteA+BudB7kShqcyK0Wo8d1a?=
 =?us-ascii?Q?QYqLdhkN13NqhQRdbZsTdpe7jcf5XP41GpvQdGac2ZwzSYs+PDg+wUpGBbqm?=
 =?us-ascii?Q?b4vBAFCOIgbEf9Dyi0+cvVbRwlUktZGKnGIQ4jQV13uNwleUwqs4yW2Kskce?=
 =?us-ascii?Q?7Q57sgVkcH+qVHyZ6eVP/H4xe8XylW3wQCuc6RqPul7h69wHBX+Q6Edo0yez?=
 =?us-ascii?Q?JFwIY7ytG0xYv5Swj7hOGdJTcv2NqSW99NKe00HyAGDPuQxedbSX2NSeGls9?=
 =?us-ascii?Q?rPNQUN7HbKApUdKoaxQ3an7TFvaXEiHbL9gzaBrOzydQb0os2bK4EJF8I3b3?=
 =?us-ascii?Q?GucEzKYrdT7n88jar1T5KOEZr7K9n9nYsgFBTYYRoPo09VWU8LDRMrJUS3GI?=
 =?us-ascii?Q?W9SUXBuGD8mvLwvrFtOj1+c1ylCLE0nBp3Bv44GcPtVKP0d0UBZF8GCFCdyQ?=
 =?us-ascii?Q?/H/GhkiqYdeG7sg+BFOeurPz0VLdpSXb3iiGnTgMOAqg3gSKjZIUrOQ3BNRK?=
 =?us-ascii?Q?ZbaBW+Z0Bnd8hv9Ib35LKi01eMsB1VM4fYagmvCvJULnodb4P6+ZyS1CZrjC?=
 =?us-ascii?Q?YNfQjv1RU4NuFy7QbCXm4S57WWKUFFGVxqx6rZn/lsKEQmTd5NsVY1kqJpTK?=
 =?us-ascii?Q?3IGnZ2nBbN++s+YimddZI2CPJCeYu2/jJdc1/YgCzL/CwHgN7ckuS+7Ytli4?=
 =?us-ascii?Q?UqTvZvTaLPdlNyBe+rrO659mMSVWKEPiLYx1PMWH27yx3NUEmDyU3bOApfzn?=
 =?us-ascii?Q?p7rbtQeiskPsR6AIlqHzxaXb0uv0jgW48d9ZPid15e4/zcPRvHCR65ciIL2a?=
 =?us-ascii?Q?5aXnqN8pbxzmkEs0kywm4fCFFiwaA9VyIVLQPKjG5tJSNdG8AV4SLM9H3Emc?=
 =?us-ascii?Q?kdo0i18f2VolhLLUwRTVdbgvymYRgz3TvpLUd7LGu8YpaeuXjYwPa5m04KeG?=
 =?us-ascii?Q?Z9gJt3nZr4KVegQs5p2md8cvUzuNroBOeKwjQqw0sPE5hA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E+CMRZ9wlNQ1v5RZcBr20aYoU5Rz89cPCp9SD4uroTPhYg3SUd4O1b6GUa7l?=
 =?us-ascii?Q?N4zhN3tG/zTjhr4dNzmEHGlTucb9D4N9EEbaIG5ZBJp+u21gRVMGXmf07gnz?=
 =?us-ascii?Q?VL0LxZEfe8LGHNnmVze+QvPovmVnDxJAHuWPMr4sfYnBRhRioNBF+p3neLcC?=
 =?us-ascii?Q?uQUANiC4RyyjhBmp2nF53JZczJoFrcP+n6Qzy+5jsgg6xnYSl4vdw9BpmjxK?=
 =?us-ascii?Q?QHn0gyFOjd0w9nPumNGnUiC5fgJ1GxrwgC2KmljgGTZY+tv8xLuk1PsFyZA9?=
 =?us-ascii?Q?zivVYMF5Iwoqskc44iN2Wt0mKO43i6yoff3cV/e5yEeWAaslhsLvF53Oaww8?=
 =?us-ascii?Q?5xJ1E/zpHEULw+isFOKxb8meAfMstxNAuXNqXaVZfEBXmkU+mY7Qnwp+6rsh?=
 =?us-ascii?Q?vgXwxpYsEEoqburm/+YUDVII4y+hHPMOWTkgjOSTNY2o21S/0jSRm7WuZ4g0?=
 =?us-ascii?Q?N+kJry4ydRF0uBR+cEBMhfqAnxOHg9J/jzFrSjREwqZi12C4iv8pEiBkkw5b?=
 =?us-ascii?Q?FV8Hn/3UjE8+mLLRu1Fqi+oFgC4sJ2toz8ye8Z+PTgoH+ZAePmef3xWCGvGp?=
 =?us-ascii?Q?LRe3NlY0+A4HPUERudXQn/2/BfkyoSRLGqZL/sarrrqLkhTGxU2nrQscJglL?=
 =?us-ascii?Q?fQQNDoMdSyV+zZjcO7MNSetzMkSj/4BtLui/hVfNnR9Ik9UrDdUEr3DH3jxw?=
 =?us-ascii?Q?WDaYlZ8XWQHGlawhIlNBGXpZLd6XJGAVwWSxUZDlJTGegDNoEf4SJP6qekhl?=
 =?us-ascii?Q?MgSlAjjoMIEQos6M/M2OZQEHUYN4maCQ6qInpX7+WV5JSUqLNHxOTmnllAWR?=
 =?us-ascii?Q?PQddnPYxODYqM8LzwNNyQc/crKybcfsx7ZH1kaoOo4HokYBXEfsB7cYl0rey?=
 =?us-ascii?Q?LBHZ/YGa0PGw1/oVK8iczSkB2aFm0Oj2vz8nz1+carPRqu2NBhR2k8mPx5+I?=
 =?us-ascii?Q?f++e2SAPY4+ORGgUeuo6Q3kQ+sEiGl8au+vZETTGTfaW/FyAv15dUc0qOJm8?=
 =?us-ascii?Q?r84W8BqkMgd7Dl3QdSZ7EZ9PWXv3D3uTE85ItqveW5NEfa9/RCQev9p0cRDV?=
 =?us-ascii?Q?a35KWTenmyX4bIktFaoQPHBDFIWOSi1Pm4v3Mb2vcQ+KPvzJ5U0s3OLtt72e?=
 =?us-ascii?Q?ZBuKThKUmWD+JCkmOIqjNzFxm5Dnh0vmBatLqw/mhMVj28iY9PgRJyVQWcQo?=
 =?us-ascii?Q?D3VrT+n8NzeZ0OC8flfkeLFTzrOB6m2JxJsLW2Q4gTmpCOoY12ztCuV0K7Su?=
 =?us-ascii?Q?0E7KAgMnSBw9D9SA41uziaqrTQpxSNk4rhuO4lUdzJ3K7h3C1Nor0l7dT/Ty?=
 =?us-ascii?Q?z8mTVyINO03VBGP1+VJ6XJdom3ajwPOosIbvxV3Na9qVSSkpjf4wm6Iqmtci?=
 =?us-ascii?Q?ZHvAnz7QQZZvG9b4WXl9AlpZGocc4VCkFnQAMzh4Jq2r8ohPPqWc6mRdcY1K?=
 =?us-ascii?Q?tgm7W9scOlqjJc4uWfcab1IawApwvh1p1A18qfQ+m1sv6gYROANU26pSfGXR?=
 =?us-ascii?Q?zMpBU0cVJKstEH8k0Fyi8YcItsvFj+tBI7XkurAXW0+dQM+Ss4q/jMArJQ0P?=
 =?us-ascii?Q?ckOVPCgH1MsBKwR6PWCz24Dx3c4rsAcQkJeuwt3qFES8gx/PGf6QLtuGnMpG?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gZDUSLbGtp2NWtUjKvtjRwaYXDZg6tdCJ1CU9axh+L9AskLfUiyw1SYBt+p6aBK62a/in4zmBE1QsoB6q2im2pilpeGanA10d20MH4AILYo2dwHWz6TiHrc/ucD/nZpQpI1ooO+WefwaPTs774cwJXcrQfG6wV9oq0E9uIYlHQPM/0+dLqrZvLQcmmjfQw890nrPBvfO163L/TKisriT/S0McRhbGcUD2oaQcSXw8TudlybSEU8Wz0hqtnviUz6TNrFfumlyNxCaSZmIdKWgHex8+nXu2wlS2oLEYaVQuyXzrC3V9wpPrstBmraP/TzAeea99kKEtIeWJJJ9lmxBeQPnrLMoCXLwhYnj+eq46Hukt3GVuqfdSxFCczWDuQ61upNzfkr6i52SOmP7vRQ9A1Ek0q7ho1R0vjR7J9Kdt5w+LJPWx5MjbL4FDT17IFI2l/RPwhKBIJ7/pn1gGI7FzGeVegQsOZVL5KNP9ACA1Bldq31po8S1R4jZM9WHxaTv7BgxNWNjX1WDSmZRXYHtwlBqrZFkCAlExbh1AHoRswOLPyjH28vOQbZm/7gtNmI7svio+21j5+vFQFjnZ0id7ALrFnHlPkqdDVTypVzV3vU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a1b470-d82e-4cae-598e-08dc9d0f0fba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:19.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdJnPWtH3xXI/L6JkBc/iRvcCHFVmVR/X3edn6kpKIln0AunbrLq6q/MhRqls5C9P55hMkibBnJ2h3iq/X952Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050119
X-Proofpoint-GUID: mHqv-M374h7GUqfwctf-LD2ElSFI2ZrO
X-Proofpoint-ORIG-GUID: mHqv-M374h7GUqfwctf-LD2ElSFI2ZrO

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fe2e2c930975..b9f8093ae78c 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -537,8 +537,13 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (xfs_inode_has_bigrtalloc(ip))
+
+	/* Only try to free beyond the allocation unit that crosses EOF */
+	if (xfs_inode_has_forcealign(ip))
+		end_fsb = roundup_64(end_fsb, ip->i_extsize);
+	else if (xfs_inode_has_bigrtalloc(ip))
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
-- 
2.31.1


