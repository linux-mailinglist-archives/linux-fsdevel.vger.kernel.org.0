Return-Path: <linux-fsdevel+bounces-33011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72B9B15DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB37283747
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BC8189910;
	Sat, 26 Oct 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aRK2Fv2U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uz6EpHGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAC192586;
	Sat, 26 Oct 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927539; cv=fail; b=ePW6NPYMEvrUWhioGj9LESvN4A+8/ccqGoxXDr0uLonJXvZLsoHNtLRgr23iGC5WJQpE2/Dq4UCJ+492SmE1bnG+s/A6PT+IFttYtRmWcR7/ugq8IEJZi3LuvVQxj/2o7pIfhGzZCtqCgvOMhNzuUodr0DHt3m/UmWQjteg/AhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927539; c=relaxed/simple;
	bh=YAL4uH7qzxdEpQx7rIRDZYNT+L2oPes1YFmGpVufLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZtT5GF3qLGC545FUqWr3LEKfOqQiOwe8Zi50BiWocIvdaPrnplP9Wvmv6VFMgDW96nkDOKpxig1PZS9bCwbXMHgbKeoyxjpddzmq7nbIjyvdrsrNrJ0oKK630e+kP1u0l8a9hsyMKGKFqz1pCoWtaNa4+io6qhP+Kfw8j5LBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aRK2Fv2U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uz6EpHGz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5qD04013183;
	Sat, 26 Oct 2024 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=93AZ6BG56bmfV9M0Ek0gTeDCqx9TsJGx9O40zGmQoQk=; b=
	aRK2Fv2ULY8QJBV43POrC1wseTUg54Q45be6zn3iRebWEisj/2FlQhkaQBe2K+NX
	1gOT0YmR+t7LgLrPW1BfT45VqZOe951oYipgKdHl0P7TkdUYzi7NZucJB3nTBmCV
	sxYJP4M/mXx5y5/2zqmYQvmhBBC1sjdzwTI8CE9Gj3Ew0FgWLaQqZbCZWfdXxTa3
	2dyS5zNeZ2DOzfnD8HyZToMqqBwiX/TmwAzIqsg0fU7y9C8pCGz1VdO1+aufEwp7
	Gw2wUWdgoBcmXYlRJDzeHA/o7fqwq7M+Gm6tAQt/xgquB0tG+EN0CSbW05WC6YZO
	p3CfaX9XBLfMy39DUVoINg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys0444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3DlB0019193;
	Sat, 26 Oct 2024 07:25:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv3vu3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPGl8e5Rely2S3A6zAysVRjpwRY0R4xcHm0KxsTGV5ix768Nr49uKq0PBLhKZlSavxnUkaLJsj89Wrc23EhKPXIm978TE/+k/3MMQPLSKHnHn/P5FOJCjORYSQ2EZl6NtQnof6JInwh9InkQlbMS2jTTsId4oQSEivVsGINdP0ull5GBTEW2/K+SCnPB0DKiYOaVb9bt8vQLyDt7/gacCxFF4bxmNkx3Ul0+49wABogWqLmpeutCTcohetXp04usNHUwj+BvdN/sqZOahfItczOaLRf+X9KM+ts1KQWOKaZcqdPn2vedt18pi+F+tc3/BDDvrvsyhag3cMKQlJqPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93AZ6BG56bmfV9M0Ek0gTeDCqx9TsJGx9O40zGmQoQk=;
 b=Z54XVg+abTHJ5hDfJPiFnCH3qqgAWS0rLKYi0zUgTUIJg5qt/xCGEEgUr1QQA6gcOydsN2NlAVndgQryUcr1wyE2VIwpmUF3CxyOHTn/coLxAwLinFuyG+8/5hefR1EU7LhDnhdfoHGRjJ4oqfZVMsEQNW03iTKyvnLgKC88D+zrzMg0XOYTitMNdZ+99b+lgiqBXU9jXEmpTrlb9S9RApqPYGy1jI5xxvNF6L5usJuDDW8YfFBiCJXa4HBL06Ut+nEq8aM6SfTVmG4D58pWnpG1yhEx9UcqJsy/DTBVBSZswqt7B+iZsuQKCjVNykMhwWhvd/UpeAPOw+zs/NPq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93AZ6BG56bmfV9M0Ek0gTeDCqx9TsJGx9O40zGmQoQk=;
 b=uz6EpHGzatEkGT7WfU+xtID3ZGBE+27NtJCaT9fiJ9/RazGWsheT121U5fIRsfOYxP/fyLv7Y3lr2dQLtgpPZYasrnQ+9CHcpk8zH/5ghccRV+O3I5hNz4jRTAKuqUJRoXI8wHhbkNdYjUqr/N2Mo5lF7Qf/TfDgLUTsdAA3cgw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Date: Sat, 26 Oct 2024 08:24:58 +0100
Message-ID: <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 98aa9585-7f16-476c-6126-08dcf58f5562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4UNGFj3RG/4r4OyRuOmt0xlf3OQsgGGyY4Dx37lUJL4LK7UNVDDa55cVAIW+?=
 =?us-ascii?Q?ZhHlXaDr5BUhM2L/a+h9ylyZf8ZKSMzw8HAi0dP3HSHrwJY+5h09tO+z4pYe?=
 =?us-ascii?Q?xk3L0/yAdLj2P2bS5d3fJZqv1y5jyXJbOJyfcl0pYXePQU1DFRRMXq23PfRg?=
 =?us-ascii?Q?lXMLxSamdOFEjLQpJe5x11kXUMJUjgclc46mKBMf1nC4FWBBpunyokNIfMH2?=
 =?us-ascii?Q?hDTocH5lo7KPM69ojF4WdqeUvvdcnQxLEXwp2iAKUUl1kcpx9a3BGbOEoOaU?=
 =?us-ascii?Q?P7SiM46GNkcS8I4l2uTZ0ehOXseuKtUM0AKsK5F/oOiyedclso6aLbcKpP19?=
 =?us-ascii?Q?bsoSnE5OCLRAY3qZxl/DgYycr4sEN2TexpOMe/49YDT6n7MIQqdbXkWTk95s?=
 =?us-ascii?Q?RJquqbtMHndyhVAFB7lH/dzYjo3MZv4gALEaFBBwVPRbuEyk1dgZWn4iFq80?=
 =?us-ascii?Q?Cijw6Fx4VNxQ3c/Nq9CW+0fCRgl9SQdfLY5dWl8YpCmgLxYNU5gqakqPQP2O?=
 =?us-ascii?Q?VZMPyaEYKS+b0itaTjfvT8wer5w3SSZdp73vcD2YnuDRr46yVOtSOlu7zz6C?=
 =?us-ascii?Q?BZbSMVpMqXpixa/sSoVeHAIo7+o4RyaO+Y1YqM/VicTmrBrd9CxZuD3rgTLt?=
 =?us-ascii?Q?RtL8Kofcd5v3iJKnVT9ktP6cB2zG0xg3XqF8bHq0fXdaenWUWQSLPChucQ3p?=
 =?us-ascii?Q?Eaw5wR2t0x4wM5iis+IBQ6qnlf8m2ihFXMjoj9auT72aV0O39xVthPz6FBwG?=
 =?us-ascii?Q?L+xiJ/SXmoFg/scNiwTJhBxRdr7xqc2nvTO5XDg4jHo9ug1EvTOjKjp2OqbX?=
 =?us-ascii?Q?Gz4q8G05jmlbkGW4gZZs12CfPhsOd6Nv5+BTqmtlUgY+HjJNFAzce7MhqI9q?=
 =?us-ascii?Q?FSGcRaJ+Biq2GNXzbeBMSqC7JtH/DiGPDE+lKLrDLf/ab7muud9rCGyCtiAp?=
 =?us-ascii?Q?Az8TYRN83PQ3YwA7QfbuRVT6uRXKLMtd1w2FA9xPthE2/omclvbaVvbQVdld?=
 =?us-ascii?Q?QhJp0Xstao8jNB+5FFgJlABIVbKkLpwgAGYxmd8NCRuEV8/9Z1bBcaIjj4De?=
 =?us-ascii?Q?OcmNFBS/jXkAC4jYy5e+qB0NeQPhGvBEoE/xSq8q9sxzQ8/KfNa1jWCn4JQU?=
 =?us-ascii?Q?WoIVrwRYk7Dq4kvDnC/S+IeavvsorKSwJwisvT+UbWtTICHlKdImO18Wf5Nl?=
 =?us-ascii?Q?zmokyKZKmPDTpIaH543IcAqMvr3VBbVyAvnadG4dT/v3jmbaNOTIi6dW6WEU?=
 =?us-ascii?Q?FJgwAhEd97MfJ/x1YVsBejWB38m+I0rL7GnuHjmvnH/tRwS4VcXD9LBfpSTG?=
 =?us-ascii?Q?/4A3034JDBSl1mquwlupgrwt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XyB5VJWFYfG/13+5YC3i+WShc13Aa6YSjGCGkGwH5yNPuF7sziUV/G86F1o+?=
 =?us-ascii?Q?eME9cDcIBOUZIOPS/hSCgphziGe8nVszQKyn2nHe/1FC7F8jWHSlDXTP/FrK?=
 =?us-ascii?Q?A6CpBtTrFZBrPTTM98zFnGhg+fifu6qMyn/FV2joewqMfPeN8Z2JTh3R6/y3?=
 =?us-ascii?Q?a5Jc0cX9sQddZcFaUUu6ZUdbMV3FOc5cnFn/hWT+oxYbP8X561zeZulVVcdp?=
 =?us-ascii?Q?o2SIuql5VWJci2gEwbtHtN0TmFLAruV9eRZZNkKqoPgOTvMcbwgP67H0siRE?=
 =?us-ascii?Q?N8ufYN2NIrAOtaFe4wYMJXmmUqC8m30Jo8TlD4jDYVObkA8jhRQaiq4TiPLt?=
 =?us-ascii?Q?wBWr1eam0GvKFCYKDfooBD9QOAY5uLfVvG4uNbxgYdKnGq3IkP8G+Qevb60C?=
 =?us-ascii?Q?wC4wqU7dre2K2WV6ZU1XE3LSoFmOoRDUPghdiEZ2TLwKP/Fe8O7P8UMAU0TT?=
 =?us-ascii?Q?ylLNA7Pyf6Ve/7rJJNFb/kZXs/dFQNEcQMmz7qrKNe6LB0uoEx8JsYwqrC0+?=
 =?us-ascii?Q?Yp4ra8tl2W5LysfIltFkx64Jo0ywa2Qmbc6Lj/6hGkYcmdyglNhi85jhKF7X?=
 =?us-ascii?Q?1Vso9DI8h4qrhBgsz1pzg4Th+w5mbynT42bblqR42rR9aB4HdZhfyEBFHDy8?=
 =?us-ascii?Q?5INTdTvWGA2z+Uy9ipuB8VW+H2C7/YNL5D7x5L+BUo8xtA1ShaIJosnUrIcv?=
 =?us-ascii?Q?goFjxlMKzARvMJEQpIiDU4xHl6tc4jEUrr/1OnLfmrsrKCT7znghJLYRrwsA?=
 =?us-ascii?Q?qyZUkq+rZrSYdnRHNyCUdkCZXI0Wa7R8JB685jOGy9kqtn5VWaZN172nA2DV?=
 =?us-ascii?Q?j5UwhW8rXWyBYueYQfH6Ayp90HyIitrPxiAieElrRKD2aFDysnsoMSDUzrbi?=
 =?us-ascii?Q?MfOKasAN+yifKUIyHMVSM6FotHvBBKsgoAdBkPG7AW4VYpO6yBzSxltMTGmf?=
 =?us-ascii?Q?ZnM7usA4oDNVMysKTw7mc/nBJ73Klksr+Z5Wl7Z37SVibeTt1a8SUscP1X2F?=
 =?us-ascii?Q?wUK0uEDou80guz4Ot+jX5n12XasVJ87X7HacKwGoxTR+tyWixvD2wrGcCvFA?=
 =?us-ascii?Q?swAY9bHAA+JVewAm1L41SZLjN2jS+wMl1vfKVlhHoYwDenxVfA6Ds9OrFTAo?=
 =?us-ascii?Q?ptuYPqrg758N2kkPnRyXQQmIhaWmUIzBx7D5VZV1Jo3scQXE1rej+B2TvSKo?=
 =?us-ascii?Q?BhTpvIgwnJMiMzCTD7rW17N5c3BSWl/2hCVJBhH38pHUYyE9jTV7PCeClDZ2?=
 =?us-ascii?Q?SBfUyfBv3n7TnsP6eMzodP0/6xMqS6ze87fIFd3MCcazMUZwj2snhc9m3UPz?=
 =?us-ascii?Q?8qf4SJOdLZaX7fr+Zk9GQEmxogCMsHMvYXJM9s8f2CtEJwyc9xE7DWqZva6X?=
 =?us-ascii?Q?rvgDlOMVd2AF4IsU2ZQ9aSiE68c3THTa5ByyyB3y8JPD2mEVUElrZkGM45Kj?=
 =?us-ascii?Q?dvEqSap7DhDrIjWROqHn1k5npUOvZEkL1WgqDaK+0wMGH34rbMBpRlANPuKZ?=
 =?us-ascii?Q?HBR1Yw2+fG4v1UXpD51IXx5lv6Qqy3iclpeOQDNiqUq9XPnxOffDt/4gGrCB?=
 =?us-ascii?Q?tuLOLkLN99wQa8PVQ85q+ri+FKr/5TNU86/hwFT1rft7CUpfcZlWRL8FhpUQ?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fn0Y0wWSPcuVBIZgXZx5OH1ZekbT8y80PDKdPBHNK5qW2xqWmTsbrLZw2K3Fr4oUS5oTvEYvvur188O1vCKBOeQEjUSyWKfXsGf46vB9Gu8ljnUP2xaUDClLpCNUPRgxC2EpTjfy4Jhg156gj4XqvH8GCCm7K5qiaXpCYP3bWXXtG+Z9CWekMmoCziU/AbbYMFIkcgy7wlGNhUtrRW88J3zPK8oV79cSgii2VX0lNBzPBTpv8aAP9LGaKOX4+RX7r1eN6p4LnmM+Wb/UMOvC/UXfOpD8fPKp8OrJmYiaJ6/bXrG7ZHgiOhC14pLdEhtv1nJJqXSYlh40mfmvuMy5CgWg0GvjXR6gOIOn55aderqcopomP/WGiZy81S//+tz/MicUQVsXFzevZ0DTEOLYC4Hzy7x5//3u+DHf/bM4aqRvjr5w2ZCmZ0+DV+meNtN9emJmNdo75u6ULN57WIWcYSiRhBqWqzK1VSc9eWbyCMyuSj76X75DMliFr9xpG6AfEMSbu6w3uBmRkwEVF/QtsMWgOm7iQ2Zx1H1ZEvCPA568IPEvCQprd7PyjfFJsoFl/fGnj5PRb4Lcb19i/TOPnkW878CACHUdNujTjRE0Vjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98aa9585-7f16-476c-6126-08dcf58f5562
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:14.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LxEsuD6wWOGJ90mMrtVpJGHklbGdNvvdjrMl2CNsjMhuo8BKCyKqPTv2ry2Y4p7q+wyKuM15Ym5nAiUUC7Y5y8xwTp+lf5JD3pTXKoJe00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410260060
X-Proofpoint-ORIG-GUID: 41Tm4lFbxtFktYxv57L6w3UwjiN1Q8fH
X-Proofpoint-GUID: 41Tm4lFbxtFktYxv57L6w3UwjiN1Q8fH

It is useful to be able to utilise the pidfd mechanism to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  8 ++++--
 include/uapi/linux/pidfd.h | 10 ++++++++
 kernel/exit.c              |  4 ++-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
 5 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index d466890e1b35..3b2ac7567a88 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,11 +78,15 @@ struct file;
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
  * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
+
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
+ *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
+ *              this is set to zero.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..6fe1d63b2086 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,14 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)

+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-20000 /* Current thread group leader. */
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..e4f85ec4ba78 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>

+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>

 #include <asm/unistd.h>
@@ -1739,7 +1740,8 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && upid != PIDFD_SELF_THREAD &&
+		    upid != PIDFD_SELF_THREAD_GROUP)
 			return -EINVAL;

 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;

+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;

diff --git a/kernel/pid.c b/kernel/pid.c
index 94c97559e5c5..0a1861b4422c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);

+static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
+{
+	bool is_thread = pidfd == PIDFD_SELF_THREAD;
+	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
+	struct pid *pid = *task_pid_ptr(current, type);
+
+	/* The caller expects an elevated reference count. */
+	get_pid(pid);
+	return pid;
+}
+
 struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
 			    unsigned int *flags)
 {
-	struct pid *pid;
-	struct fd f = fdget(pidfd);
-	struct file *file = fd_file(f);
+	if (pidfd == PIDFD_SELF_THREAD || pidfd == PIDFD_SELF_THREAD_GROUP) {
+		return pidfd_get_pid_self(pidfd, flags);
+	} else {
+		struct pid *pid;
+		struct fd f = fdget(pidfd);
+		struct file *file = fd_file(f);

-	if (!file)
-		return ERR_PTR(-EBADF);
+		if (!file)
+			return ERR_PTR(-EBADF);

-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);

-	if (IS_ERR(pid)) {
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
+
+		/* Pin pid before we release fd. */
+		get_pid(pid);
+		if (flags)
+			*flags = file->f_flags;
 		fdput(f);
+
 		return pid;
 	}
-
-	/* Pin pid before we release fd. */
-	get_pid(pid);
-	if (flags)
-		*flags = file->f_flags;
-	fdput(f);
-
-	return pid;
 }

 /**
--
2.47.0

