Return-Path: <linux-fsdevel+bounces-32418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86119A4DEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A638B26B73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23192B9D4;
	Sat, 19 Oct 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HiN2wEEb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZVWM3v3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF5BE57;
	Sat, 19 Oct 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342316; cv=fail; b=c7ykkzydI4EIEGEGgsozt99jV9NojrlN0hEpjeNIpEqBl2ij3n2JtqWoES+5rMj4U2ybDWXXr1l1b8oAjWity/RD+1paoEgkYtAPwG1C/qJpzvP98CKDzd9APRrO6PSTAn08l5m5fT+ujp0Fye2ESgFAyMNuUc9ZBH7NMgtmaPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342316; c=relaxed/simple;
	bh=7lad5ETXW8JBTsvY4IsXUDF/RPCoEMjoihl9zfu3vXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRu80rxh9r9JJ96C6CN5yBVc2VsHyXe5gz4iSvbSAVOZwbhRaeO+gkC27m93Jte15A7kjfNA1l+4yuVp3glMaISXO0LSVJuPBt4KD0D1TLiVrAwou7CaV+DoabiF+ojtqEWgXr1Ym8Jn0fnjpimnzj8+cRyxSHFFOxo3zyZ/XS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HiN2wEEb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZVWM3v3t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J6K2i3019596;
	Sat, 19 Oct 2024 12:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w+pwMUmApIvUnnO4FO7j4FRwoZg2cKy5ZGQsttPsQxc=; b=
	HiN2wEEb8EA7omM4lXzJHs+ETLXJKeuOfP5xRmcjuAm/gVceyTZ+58WgcbwxkB9F
	QE/jQEDiCNhKbZKhbmdFHj9KEXrr3jSPsPOfJLNzcS6xA5SS7BaYcQuBEhl+aSHr
	wV3Qv0CsSih4VXK500lShOMsx9KUQeZHyrIEFEKBIxbO2n6CHWga0jl07aGqeFyh
	pLuEt/6ddvv6zVzVbtTCu6JPBYRLDApUcZ18k2XGcCETaYv8sbZozX9DzqrqzNFJ
	e9b8eFXswbFwkT4tLrEU1uYqqIAcRAXKGB6xSaRt/fsZXp94AjLiZzRXTndcUQTs
	qY8BNy9g7OyqJrk1nKbx6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c56m09gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49J7Uvws022635;
	Sat, 19 Oct 2024 12:51:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8esmbq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsi1Otkyvkp2ZOxx4ZJNaPG49d3w8ND6HnE5/5P2kgeT9byBeF8FIhxxPLPwXnZ7OgabSye4lGDhTPHPARbyLxSx0/ZCtp10lGklClpCX69F0jwDSfF8rCh4MsBKA4pgOFieDxOopKeJdVSDsDo8E7LPnNKrh0qAYVWh8+TH9zCAo+TGNxhvABk+6+oto0BK03jlpHkelB1T3Dv/uSicbpFp37yG7n0mGau3HlCnH20IaQP350bYomhb+cmklWB0nV54+00ity8Tdl6GfrE1XGk0udDNDjMvvj1ZP0ntG0FIjBxGRKS3FKChtvNFOL/yYYzk2fS++t3WbzUwi7/8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+pwMUmApIvUnnO4FO7j4FRwoZg2cKy5ZGQsttPsQxc=;
 b=t7rOKgrqG4DctBDDQcvzrSikP1Wj+/pH3Wlkj3X1k3JzzXITupkt1NYOfM+AhXuuKJGSm44KCRPUi3RPOYjxRMRwXnxecbhgXTUJerrJrnbAaqzUfm743d0e8cIuQaEL7Z1+QysMrIV/nuEADT9GUZs5bLyWi1t6sgb8kwW4SryctIZjXReh8+LXKiJ7XkSYKMGgZHJEbT/mwWQ+1FkBmdLr9EDkNZve8QqGD0he+gSKPahUIBb0pl1KzxoaGT1DpuocZI3kbXFW/gKMuaC6isbAcE+zReXBVI6uIL8oprQviNVGW4gvX5vCnG1tNLe4wqkgBC0wqflGJJ/0UnyBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+pwMUmApIvUnnO4FO7j4FRwoZg2cKy5ZGQsttPsQxc=;
 b=ZVWM3v3tDiqqMUp1UbCmiQN4rWV5galfP43B5F3MsRYVJu9hBWRxR2aPHh1XDqiIoSXPAvOYo6fzB4WUrX73ORaK0Rf+4MfyOZbnwDiNVFeEsqK2WeIhwQ7G9Ow2euoVsRzPVc4IthyzQ/S097WcQxOOCq0pRCdf8FXJ2dV89os=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
Date: Sat, 19 Oct 2024 12:51:07 +0000
Message-Id: <20241019125113.369994-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:408:113::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0bda86-f13e-4d72-ca7e-08dcf03cbdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pM1n+OwWYw57rsBy+JYAm/+VS5WZm2ZgZN60Gw2C27CI1opAwFDDiq2uThAd?=
 =?us-ascii?Q?pmPiabchU1ZSyZtyzrSRbW1Pxdlw9yiQ6weo/w2f4Aep+TpTH+ebYTz3KPfO?=
 =?us-ascii?Q?ZeCmq2L8TP0zc+PPb4uLkCwHFtLXlaxhgpPa5mt8h7uGqP7brz99gP7fQKL4?=
 =?us-ascii?Q?OgZizZCp1Gp5vWq3jMqBVgpieKZw7zX1Ry6muP7M2U8PiU97OcbiSSyyLCLP?=
 =?us-ascii?Q?LAPEgZcAwbZR4RVJld+7HIc7UVo72CaQUNfdLqO/cYGbM46FqyW2lZVqWeXI?=
 =?us-ascii?Q?FwK6pOHDTOO1fCtImAAyLiw1CdpZa6qWdwDuhalNsatlZPmo5Op6LAl0AmJ3?=
 =?us-ascii?Q?kSqkR7FwwsKCFCxCOVQYI7xC9cedet9EGWR0Qkz/Zw3KAplR4+Oz1aQbANEK?=
 =?us-ascii?Q?Ndo6GsLxzOIfEQ00kAkgkSBlx3iPVfl7HwHqD9R6wnJxXW88w+kNHtQNM9/b?=
 =?us-ascii?Q?Sq/qiUUvbkqq5x/dRR4MqXmc1lM7Gb1HLKYGGWAm7zQbxiEVbFUWC9cN2c21?=
 =?us-ascii?Q?SYPzeYYshrWPCk1WmAdJ+e7rveEhr+2i633wFOQBzJTGdnlt8bcbVhdbc1IQ?=
 =?us-ascii?Q?TVSiYcOvGkFea6uT2ap3UilZo0Cf0ZpCkBDmiA/l+7V+QdZuQBOQh2npNgye?=
 =?us-ascii?Q?HrR8Cd9QjJBZWbaClxfewfvnMmee849NWabEOrp8xkqiA7Dsj/bIRE8IQk1u?=
 =?us-ascii?Q?mmIkXo6JegaX4r3UkvMGGckSPeTTfh70RJDlUM+jmFq7uMF8vLX50CN6thxK?=
 =?us-ascii?Q?i8/mqc5tPaMJ5BJ4qojIbzdHEZxl+SKJICqUuB57quQmQA0eXwcudGNQJ2gL?=
 =?us-ascii?Q?S8f9kVPLumTmjD3cDka7Inpw/ICD8TG44hXhwkX6rNqa0EFQFJvjlPIJ9nMp?=
 =?us-ascii?Q?+szydj7yQliuh8frP4Yz4BC8cFjj+fwiLo42rblwEEy7pd5IAH3KzyjrKLWG?=
 =?us-ascii?Q?azVyzS2MQB8mhEXoWR9Zc4bRqNHBD5gYcdRoJrByje2u23VGL/WwSc6bhrGS?=
 =?us-ascii?Q?RpPZnR6yUqYt5babxoP7Q7JRiDa6xH5J9+LmVtGlOBFnG4tmB14VHWJsZOgp?=
 =?us-ascii?Q?vC3EBJMGvgNxdWtKIGf4Py1HrdWkuxDHpCJV5RXt4HlXJY8ZSdmnaWDbx0Up?=
 =?us-ascii?Q?cB0+hRqbME4XRTIIcOqIal4PXRgbnulMbd3yL/8wdWVjl9BDp3D0dSxAwb4a?=
 =?us-ascii?Q?gp9RuJ77SXprXwgg0Drkdf31w3uWxdnH4iesVZwmVo1VAeRH7dWJJdlcv3bM?=
 =?us-ascii?Q?btRurNQbKVn67Ylp7Hx8EFCVUuZrh2mQ4J0ijxWHyVatWlfxk/EivQkO/Iih?=
 =?us-ascii?Q?ocU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYQIPaIXAiIb6yILP3cb86U/si181WCELB+4ojp1j25i/ovw2s6aTqG3v7gJ?=
 =?us-ascii?Q?PLMBNQ8vMK9Y3GjMuOS+ByjaBqCVPipe7CkspeENsWQFuJT/Tdk2qNrjmy69?=
 =?us-ascii?Q?XOqdgETejcZe6pUycOwh0PzPGk1+pZVtrGUqCjJ0ArUyOB9tHTg+HOBgaQRN?=
 =?us-ascii?Q?gNdrhq2KOcLtEdA7AWqLAjPGO4jcRcqZv7lLAwI0zPKlqon5qlQTwOYzmGRz?=
 =?us-ascii?Q?jxwUfI6BcQPL1RZHyBScO1jLFsMBRkzbsWyXxW9IPugJnRPzX5xhdNJ4NWcf?=
 =?us-ascii?Q?YR4yIS8O+CKb/qFiRnWcQhRLCaCjx5+jhj34+6/Ajmx2SCsr0CuKviCLgaDd?=
 =?us-ascii?Q?l9o3Ai4gSR9R+34iJZ+OxrPjtnajTp65yA7GPezK4go688SlbtI/ymgRziwN?=
 =?us-ascii?Q?j31E6Xf+jg2Ox3WDU+UpQHIqSwrmcwv7kQqHINufkxumrD7VT8nv0pBgwROZ?=
 =?us-ascii?Q?UD2hbPlCu6KUfjkPhuLjVuz5Np9esOUZmzHCrMfdA486mwgon5FE5sRU3a68?=
 =?us-ascii?Q?C0QghXzFfRu9fjTdp0syr58lVkXajdWlX2rTMsH9OKiLpEgP8Mm8Gn9CrPAC?=
 =?us-ascii?Q?8rmoR2XIepkI4cE6OHze/iUCdVzujHPsYpF9qGqRwC9uLRQkro/uBEDQyK0X?=
 =?us-ascii?Q?Ch+d6ylCT6uWdmrr0snowkZzGJbegpWwMZZLIudvqePN5oFcrvS+zcdHHWTv?=
 =?us-ascii?Q?rW4nAi7ArDhDX5yVWyI2O6brt9uPNQRigXvPgdburDJCxTSKQW3+8FIG8UI5?=
 =?us-ascii?Q?4GrXghlTYQZsEocMew8+pyj9JTTaEf4hFtRe45Dk0uuu3QiuqHSWdnvEWUxf?=
 =?us-ascii?Q?V68LGK3HNFkp9EOrkzb0t4M+pOu7HOd/itrlmkwlOfDFfLNWv3630apC1Zb6?=
 =?us-ascii?Q?7JjaJxqxoAq62/J6s+GtuA+Lk/jAXnzecapB5Ph7TsAoZQlz1SZLoi+SpD/W?=
 =?us-ascii?Q?/ZvOcKb4AaEOw4AbKzFZOSiT270s1gdd8Ku7HNX+jY4Sm1ifuUyb9z1ksAzg?=
 =?us-ascii?Q?M2W6l7Da5VXwVP5vuCN0drveyP1zWt4N4wm476Jy+4ez+h95JTkrX98Dpa3E?=
 =?us-ascii?Q?jb/mY9Tn/vPiFPFpRUtl1IpmvPa4YdFK9hqTOtR76HhqA2g2GCR7fTzvdeVe?=
 =?us-ascii?Q?FeulXAafm9lne6fi34ZX+O54TXgEVrPfALm7ARoKbjT24QW86u5Z7tjsTpw1?=
 =?us-ascii?Q?VsnAfloREhrLa66IPBOcPJ5pjIYs/1iVwdMqTx84tP7jRvGukCdpNTEQ/run?=
 =?us-ascii?Q?XtH5t+9ZafxvFKs5frE0Xs1vfZ0mHA7VvK4/SFF6u4+5kdBQLWsQhK/AmqnR?=
 =?us-ascii?Q?t1pITqr1IOQdAz+axaTryjCULFJLOskfxjyKTbNFDvcTPFNmUhpFw4+Xhq4p?=
 =?us-ascii?Q?4XJyiw4PAGTEm/KTSqUOj0mW2uDBWJucEihpjJ21/wXW9viuvkzwD3AYzCOH?=
 =?us-ascii?Q?UWlFpHuwsYE9oD2mwmnXO3wvS4PrKgGTzrHmlT1V1b/5SIMI/mJ9QX0LwGXY?=
 =?us-ascii?Q?p4mTM5Pvs0a3swk/wFFS40oPC2N1G3oSE05D53YV7pEyHcZloh98CJxDyf5T?=
 =?us-ascii?Q?HzjmufFksWl3i8f2El+XFMA4ARGhr0NVvePpHT5Q3P1zE2RDQcPhDZHVDjxV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S8dIldSzQXHWJs022pqPTvTxb6BxfAI0EH0qrAlBtlgtPZBXMJaOaDDLekEx2XajvzDvj3HepUzWoCqTOP0BuY6mLAxW4/LdiYduwuee/+Y+DkJ4vyAnWIYbN3hQSIFZuZv1qYAnh7GkipwSY9TfELvDpW7UO99iOw+JydnDx1zcMP2jGLF+sVO13BtkvI5764HTGE7kTLfZyajUX9a4zA9dpmokPgXlFOE9MFDBsD1ccG9uxwyTVH9WSw9mnE7XtBnrgNaDaNbc4navpBw+/zMLHUjNB16nZbr0o3Gg+NygZM+oQo22Y073MxshTF32EF5RhqowGeolv8e6AWc4YNfKoQGEyq3YCvpD8dQHI3HnPctRky5RKXmcSEFHOI9shkUrNyfGsf/u2pDZYqHkdimCobJY8ewtRu6igTORcj8J0xcwqd2MEeLJlz6VGOQAGkmORxgDdZuiKpQqGuaoIP0duMH86sK5VEkbFEWPbjfjQOU6+6p7wED86mKSv3cfoQZ4TEJ5oRzofl6HtRzCMcdNHJRGflcal5P4uulTp59K2Ph8loX2yALEbZoqua02jnuF3Uh7sTeGYsnQFakiVMpSFEQbotMJXUbsH7c1v64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0bda86-f13e-4d72-ca7e-08dcf03cbdd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:25.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKVcV5nKpr+ezIqbYIqtNOOGX5u7aluxF8Bzlyuu2EqTqcf64osbmzOuwubTuQeiEzGIFqYvySXg+LeP7H/NQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-GUID: T-E5BF9IY17iwLOVqVI2V-DDOgK0jyj7
X-Proofpoint-ORIG-GUID: T-E5BF9IY17iwLOVqVI2V-DDOgK0jyj7

Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
the file is open for direct IO. This does not work if the file is not
opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.

Change to check for direct IO on a per-IO basis in
generic_atomic_write_valid(). Since we want to report -EOPNOTSUPP for
non-direct IO for an atomic write, change to return an error code.

Relocate the block fops atomic write checks to the common write path, as to
catch non-direct IO.

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 18 ++++++++++--------
 fs/read_write.c    | 13 ++++++++-----
 include/linux/fs.h |  2 +-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 968b47b615c4..2d01c9007681 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -36,11 +36,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 }
 
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
-				struct iov_iter *iter, bool is_atomic)
+				struct iov_iter *iter)
 {
-	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
-		return true;
-
 	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -368,13 +365,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
-	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
@@ -383,7 +379,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, bdev,
 							nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
-	} else if (is_atomic) {
+	} else if (iocb->ki_flags & IOCB_ATOMIC) {
 		return -EINVAL;
 	}
 	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
@@ -625,7 +621,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
+	if (bdev_can_atomic_write(bdev))
 		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
@@ -700,6 +696,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
diff --git a/fs/read_write.c b/fs/read_write.c
index 2c3263530828..befec0b5c537 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,18 +1830,21 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
-		return false;
+		return -EINVAL;
 
 	if (!is_power_of_2(len))
-		return false;
+		return -EINVAL;
 
 	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return false;
+		return -EINVAL;
 
-	return true;
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return -EOPNOTSUPP;
+
+	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbfa032d1d90..ba47fb283730 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


