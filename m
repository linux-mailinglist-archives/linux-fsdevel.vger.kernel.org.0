Return-Path: <linux-fsdevel+bounces-26190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2559556FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B601C21192
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D90154BEB;
	Sat, 17 Aug 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZlXjGVP8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vPvxyPi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B214EC47;
	Sat, 17 Aug 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888125; cv=fail; b=PiWZvg4dJhxsJz4OLUOeBAJdLUMCozvApHZWTpBcuEosVpff1t/icOvacg/vCQkhmhjilhhWeBug9Yn2tyjAJKG571WOw0c1DG8gdP/RIhLWq5cRi209ET60PXZcjLZ2VlV66WBL+88LOI3OAxu0HZo3kg0IxrLUpKvpXAplDr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888125; c=relaxed/simple;
	bh=EO79lrMO6s5HLmNaV2s5qz2u4D8NayFVfLzHVHNUOI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtoHTWeqj0k+KLjxBz/JCvWACjGhN72t8Yby047MB6YD+c2+ElqYrJ15qKWLy3+OK9xJWSiSe1CtfKRbbmc6tBTfoUTtt0ZvN1UIAHQlZPTbSPUafY7eEMaScP84T2KeMqRWmMYu8yJgxA4CbFMbZEd5VZ5D/yJFUIPyTnI1Los=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZlXjGVP8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vPvxyPi5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H3cwYq016060;
	Sat, 17 Aug 2024 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=HcFhOOyCAg0pxM2P8Hxtqb2nQYZd2mVqG51j/7hxr5I=; b=
	ZlXjGVP8+rWvON2hTwgouskTd20DSQL76OEg/QkxkWJpPSIW6uB/sxbNe8RyM70B
	XRA4gVvOI1udw8S412hQrt/T5xA1XHIe5EyB9fsIURLGgerwYHIHmVgCqATZscWc
	NpEXqFhGDFlvxkpsAzOj1P5l9gx6PO7+aXgCNZJFySjXHzEGOHE+G9hLfmypl2Xe
	NQE/QOvQpDj1AiBYEm1xHaOIFlF9pOYjwYXUn6uj3tFhw++iWeFxG390Xrurg27Y
	yUAvKjczf+GlnJnikqO072U7Z5AZKRHRO9pJIO0u+YkJoE+6BMq04vEhtCdOl2No
	Km0pISCyiXbEgxX7LRWm1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4ur7jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H5jh12037350;
	Sat, 17 Aug 2024 09:48:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5f27s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7zQwEaJrZjaToPjm7TJzxWvNsULXEKHV3Xux+R8FtRJkdgPjWUpesVKReDB0LS9iAdgCrkLq3uQvvYMximHiyvfTJKQUgFMIJ8ZsdJ/082wDfcwJKUIuJ1ShI3syF5RNcgolYqfbztzKGw6K79D6X60pHv6qk+UMTcJUmTTGn0iKLhm5to5VcYAciUdAxoYt2Q6ZX3EjgjqzJCZ1lmEyrsClMsGRA/MsCslxJSpwnyTc3S2Kx3Dyt75RJRmYx8921UWOKvdJxN14z0K/slZMqQ6E7mXtiiP5ZOVWDZ5oNywo1e6ugn0mkw+WVxmfOPccvt/IyfnadzGCMmEJd9bYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcFhOOyCAg0pxM2P8Hxtqb2nQYZd2mVqG51j/7hxr5I=;
 b=df7kwV+0iEk81wfe9C3KEjvXrqxCKB0pNBDd2WOBPDUFQD9ukmM9CIxnjcTtDnAdB0q9wRZvM3ISt0NVqkl5EQKDAp6cTYBa6LInmILq+5tluwf6FqwrXXdXdzFbMirGaXR85m+8hfH0Mg6JD8J5g+C+5bWjvOOwql30nxgdm5Va3z8hDMQE5uVS/6tgNVvWMfBhQKgusRysF8piLpCfkJ+9zLmMw5iYdYJKs7RBnPemFrIYjhRpk9r1Mw0R1FSs5yUOjmRMRrOaeGTDkJCXb1W4P6tg3S3t+FaYRJQzgtiV7SEUt2jGxhELyBFBhP93P9kECERZF0DBEriHyEyAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcFhOOyCAg0pxM2P8Hxtqb2nQYZd2mVqG51j/7hxr5I=;
 b=vPvxyPi5Lagb4qVRI3AhoItkZOEsRbHJBJM/QgE83UCFYMlh6Iu3OifWEkC9ddwgQwyv0HubCSWCeVehJX3h2oN0CX7VH9RUxj7i2n9ruAwjUAWEA+M8iN/guT41QEib+l0QRtw68L4JvoRDSMvgvHW1/Wa1rCmeWbQyUKQQLfU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:22 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 4/7] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Date: Sat, 17 Aug 2024 09:47:57 +0000
Message-Id: <20240817094800.776408-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:408:d4::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 304c6ecf-e23d-4820-50ee-08dcbea1bb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKNt5JoB1n6xU+azzoBUcUBTbgsARGIR7a5N9ldppJh9BhnCMGDcRAJwVaVh?=
 =?us-ascii?Q?wLAzjvjLbXc/VSHhg6K9auZWbyIZM42FCHRvrfFLk0d35AUf4iHkUfAzzx+S?=
 =?us-ascii?Q?B2rgA0eXPSyez4VZluJVIF321rjFhUsv5RyXCAf4Mt/V4f79Pu1w+9K23cc/?=
 =?us-ascii?Q?FdieL7RARB84QPh2NxZn3014Nwz5/B2c4M2xr41nwsF07V5LfPc01g6z+Vdu?=
 =?us-ascii?Q?YM7FMH0Tm1GETm9qmeLCTHX8Qq5GAOCq+z8GFCjckATVsyiMFTflfe0BDh3H?=
 =?us-ascii?Q?Njp7JZL/vpySsyoQYkaNEPmdp6oaGeQn/N/HC3DbSiFD5BI6MzpbzJoDtpjX?=
 =?us-ascii?Q?yyQKLbgwP6xzB1NZwGY6VkaZm+KiR+3tv84EUsKUXjPmC0Y7yNQ07mT1HhGk?=
 =?us-ascii?Q?ITrRtoDYFpbs9LYIeZbBa0D9WsDpriGjrN7CeV85AOv37NwK+FYMliSeBNFN?=
 =?us-ascii?Q?XJ9iSG1qBzswNDVNugZUY+T/qw1B/9ynf0tuiTMGs+NGivgD+jO1ODClvz/X?=
 =?us-ascii?Q?0YPkPjNsgBtfoYYLNCTjnMv5iWQB25fY50XPeCehrRq6L/ifOCrOKQc1orMc?=
 =?us-ascii?Q?ZUOeDY5kxKd9+GGXSCwn9pvRKq3aK2GvuieQjsBsmigNsHPSYNvDT+jRxUvV?=
 =?us-ascii?Q?Jr1RWERaN4BFqLwIfu8p9b1kZmBbZctMRduz+ljSCFUDohFAbr8zhVblXeT0?=
 =?us-ascii?Q?M8mP4aweDSdU3UxEYSs7+jJZJqU+ecJ4YS97/I2L/OlXA5hPf+XlvZgaAxcy?=
 =?us-ascii?Q?OtpEa55oKkpHnZlnieSW6VOrNDziOfEUan1/Ag1lhkVvKvC9nYeLjd3A+mts?=
 =?us-ascii?Q?mCBvFpRlvkFEZJWIui+VWfMcnpv2aRoYbbLNK0wFQBcp3Pq3srH3gmGIq603?=
 =?us-ascii?Q?oI7xa28W0H+aYu3ld+zwHpAscPtH5legYvLSkxPgtgmH6w46N4vvv21WThvR?=
 =?us-ascii?Q?W6zK2+trHVBHXkWL7HvrumKNthYKWBByEq3q8xuh5TS6sv5Sn6jRJ8YHVVgx?=
 =?us-ascii?Q?ormkO8IbBFO+sikuzYrMEH+/PRqdzJ3Wt2pFr/0mosi9GQVU5ZecJg0ObzWq?=
 =?us-ascii?Q?dXrW/PmOPB+4str4M4tqEQmt2rXxfzqqSNTWJKG4VltT+W3+qgVOrUr0pfpQ?=
 =?us-ascii?Q?6KvReVjHHx0hJ7PgJtC2fmS3n//hsp9RruITuqqqc2xgEix0L93OV5yvuSTu?=
 =?us-ascii?Q?UlW2hcw3OMashVKsf5xwAGC78jLjohtLJ3sGpkUrgr5j074eOzk35MJi0pt1?=
 =?us-ascii?Q?B/NPoUX0W42AFmyx4BHFCHitUbrQP+My+3WTm3wJ1QU/fn/9F0G+DIkw9CkT?=
 =?us-ascii?Q?Y8f3CaL+YOU9J3hkxn1my37Qi8ueiWqkZvaj54M5RNK/Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jkp+CHn31/ZJZ1U0xigYXhczC9275pz0rg47VeOmHCvaQmMfrufEd5TRDCT?=
 =?us-ascii?Q?lmQRr/9PF/hlJE3Ycr18y7mU/vB9ulEuUhUfTC8O/mTRQ6Tb0Jy0pi+W++MO?=
 =?us-ascii?Q?10iBt1GoX2PXzCPh38rxvzS/xo2JJXt+rFqOQExbrHAQVlEAS0WvCmAozZ95?=
 =?us-ascii?Q?9t7ZoeTxmMBZ908yRNZQK+FlZtGTGJL6zFAPvNVJimYyvhVlNv2b2LghocDy?=
 =?us-ascii?Q?26sVXpCJPOVrB1EoadKuAfG7X4OmevnsC+V+Hq1FtF4Fpxs/ciRc0G4FHYL/?=
 =?us-ascii?Q?Sny8SyL07kn0Ayw0wxQ0J0qOzsogNjlCK6alDs/ywf21Glkd/PiaFQHDYIxX?=
 =?us-ascii?Q?j44r8nDGWDIKWw/NWXJvrSOU0F8Zv30mWRjFBBg/t+igF6B1jbEzfCTXBG+1?=
 =?us-ascii?Q?99NLDoNIXyLkKyKOlpX+vMxg9PMEXoFfApqTprzEFTzGUNBJDbfTf9UM8AWP?=
 =?us-ascii?Q?yrGaXXOwQ1tOjB5lBUdJQh++MAvzEorhUkhf62q9/1nRbFJ4t80d2AOcXGZX?=
 =?us-ascii?Q?MfENPNZE1wHthPo+8sxeR69rEyYcKwFY25aqdxQS/HsKp9XpiYD5fA/j5wAV?=
 =?us-ascii?Q?7ixTH9Eb9DNnNgSfVxTX7DACoLNL4pUSvUiJJcBS0gHXKGcotssphfD6MD9V?=
 =?us-ascii?Q?2HP0DNLgPpam84Vc4YxLhezUJeUwa0HoUq06uih1T3zvChbx17Bm7Hq9Upcu?=
 =?us-ascii?Q?vCtgg+L+8EuBMzEcNjiKz1JHxoPcXvNuhQjYJX5S2VdSieS8BnC2sAmXwsII?=
 =?us-ascii?Q?1pX1xjsPqH0G/qhw+5jKN0DQ5LYjtzFSBwLFrR//bQrTSHckCp5nFxGFJdC0?=
 =?us-ascii?Q?u/AIGPPYSR8GGb3//sqicyibtmT06DxNfvzHQFsC7qfCnCW4AExXT2z9UF0j?=
 =?us-ascii?Q?bwZeq90Pwkj6XMH8m4uXIGNA8GGfXwvFLX21WJfcgZEdvcJEqlHL7gu8KaSK?=
 =?us-ascii?Q?dBRUuXNvIx71Icz6RM6lYkwoQdK9nE7QMa3nhDcgDtXd/4EE/hzlfxp7zPjM?=
 =?us-ascii?Q?NNXGSSgyfQsnf811RCxDj9cUgrT86XSfOrxZYA873feNUv/jLWDW13N9Kttr?=
 =?us-ascii?Q?DDM9eULnntcY1Zg596by/LwT+oOnhBMdLAovcXv5Ow5hvcMEBG3xyTRnJnrz?=
 =?us-ascii?Q?6DnGZ8FXIMA/jE0XOybEJ41Pwn5hRw1Tcntmh3xRXpBSoTv+bJo+eijSWXt3?=
 =?us-ascii?Q?qFKnHQdC5cyb628y5wdpam9FejFLPj67kvIeFvTkIomqM7UxeKBVPzv9Mepq?=
 =?us-ascii?Q?/92zLfUAJvmivcEQ8/ArBkE23ggLx4FDpdVISYXFqb4vl2N465ZfJPWIDjVJ?=
 =?us-ascii?Q?qC2UMwgRsGaiQ0m2aoPXbGed27UMhbC1UFMV9I//vPQQjqoPemGZPMwu0yhD?=
 =?us-ascii?Q?aQl1RikxcnBlSgcAWfCz8nx62J186fB6eMrkr5nBbuyp0Y8e4eKN0EF6xTr1?=
 =?us-ascii?Q?ML6ku10JRYlPrG1LGIInzsH+GbsmI9D14lQUnghbI2dM+l1VAEbCwDqvKBcg?=
 =?us-ascii?Q?S+FRmHSawdeJEUKR5LYAE2RaAlnJge28Wv+Mp6eLIJLTL+JYVaYVOOjX39pu?=
 =?us-ascii?Q?7gbhyXUBRMn0W2zGCeIQpbkZxz5BJhiU7KuLOSnt5fwU08mOiAvzvipBGdLf?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	urjYeLWgTFuU7lgaG5YyX/9z1CIXX6mDYD4BTnEHX234jKXD0Mp3KcuAXcrfNWJlABroElZljWbt4JadpEgcufbKf3kUUaRi1xvI6CxUr1Ey9aiH3jgxzRpy2wPjPOmx4T/sAQ75CMJY7JQzWtgG60GmwDBDgfkaY6E+GOogqj2SmBC9r1whjnZNf9aYE7DPPVueXo9QcVVtmPphB2JPPcTNupDRqkJiEtlUJ/IMHt8kQHkqvECleGqvho88ZoiF8pg+wpggIdk9qEG3WI0VtuHuYYvvDEG2PguicBkYi3afXjlk75nc4Lu39LewW1umtBfsR5PBO5tLK4RKtxY0V56xl0IrL4WTQEgklyWCs+SLrMexiLDvjM8BwDHHa14T/qk75nejr7/CO8F2TYZk2xmuP1IyRjZeAnrpkpuwN8JOosPKpEi4qNa78vUkRgSZrBC3x2eQoCHnSYFZ7KzcinR+qUe/Lr9eqkbK54RnBwLqyC9ilCMF63Oev0zYczFb9iaEpfeK+sY8SZNWdojOJmri45BEhactlNQwDKHarSPhn1C7WJnN2dJdrQ9KLRhnqBgg+WxAnTwHAaujWzaVST0orqPz44VQ6lobipImaXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304c6ecf-e23d-4820-50ee-08dcbea1bb8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:22.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL3Nh6mu+S2BREhP9tVTmdeFo5gyF3QtXbBBiYlhMNOhoBrAX/xfYiOOPfYTxKalFWXux5KsXa2UBeatAbsEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: PvCAhgsaY20Ko9uByycfcqUlbaFonJKI
X-Proofpoint-GUID: PvCAhgsaY20Ko9uByycfcqUlbaFonJKI

Add initial support for new flag FS_XFLAG_ATOMICWRITES for forcealign
enabled.

This flag is a file attribute that mirrors an ondisk inode flag.  Actual
support for untorn file writes (for now) depends on both the iflag and the
underlying storage devices, which we can only really check at statx and
pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
the fs that we should try to enable the fsdax IO path on the file (instead
of the regular page cache), but applications have to query STAT_ATTR_DAX to
find out if they really got that IO path.

Current kernel support for atomic writes is based on HW support (for atomic
writes). As such, it is required to ensure extent alignment with
atomic_write_unit_max so that an atomic write can result in a single
HW-compliant IO operation.

rtvol also guarantees extent alignment, but we are basing support initially
on forcealign, which is not supported for rtvol yet.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h     | 11 +++++--
 fs/xfs/libxfs/xfs_inode_buf.c  | 52 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.c |  4 +++
 fs/xfs/libxfs/xfs_sb.c         |  2 ++
 fs/xfs/xfs_buf.c               | 15 +++++++++-
 fs/xfs/xfs_buf.h               |  4 ++-
 fs/xfs/xfs_buf_mem.c           |  2 +-
 fs/xfs/xfs_inode.h             |  5 ++++
 fs/xfs/xfs_ioctl.c             | 52 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  2 ++
 fs/xfs/xfs_super.c             | 12 ++++++++
 include/uapi/linux/fs.h        |  1 +
 12 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 04c6cbc943c2..a9f3389438a6 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,12 +353,16 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
 		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
-		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1097,6 +1101,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define XFS_DIFLAG2_FORCEALIGN_BIT 5
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
@@ -1104,10 +1109,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
 #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 1c59891fa9e2..59933c7df56d 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -178,7 +178,10 @@ xfs_inode_from_disk(
 	struct xfs_inode	*ip,
 	struct xfs_dinode	*from)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct inode		*inode = VFS_I(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
 	int			error;
 	xfs_failaddr_t		fa;
 
@@ -261,6 +264,13 @@ xfs_inode_from_disk(
 	}
 	if (xfs_is_reflink_inode(ip))
 		xfs_ifork_init_cow(ip);
+
+	if (xfs_inode_has_atomicwrites(ip)) {
+		if (sbp->sb_blocksize < target->bt_bdev_awu_min ||
+		    sbp->sb_blocksize * ip->i_extsize > target->bt_bdev_awu_max)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;
+	}
+
 	return 0;
 
 out_destroy_data_fork:
@@ -483,6 +493,40 @@ xfs_dinode_verify_nrext64(
 	return NULL;
 }
 
+static xfs_failaddr_t
+xfs_inode_validate_atomicwrites(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint64_t		flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_atomicwrites(mp))
+		return __this_address;
+
+	/*
+	 * forcealign is required, so rely on sanity checks in
+	 * xfs_inode_validate_forcealign()
+	 */
+	if (!(flags2 & XFS_DIFLAG2_FORCEALIGN))
+		return __this_address;
+
+	if (!is_power_of_2(extsize))
+		return __this_address;
+
+	/* Required to guarantee data block alignment */
+	if (mp->m_sb.sb_agblocks % extsize)
+		return __this_address;
+
+	/* Requires stripe unit+width be a multiple of extsize */
+	if (mp->m_dalign && (mp->m_dalign % extsize))
+		return __this_address;
+
+	if (mp->m_swidth && (mp->m_swidth % extsize))
+		return __this_address;
+
+	return NULL;
+}
+
 xfs_failaddr_t
 xfs_dinode_verify(
 	struct xfs_mount	*mp,
@@ -666,6 +710,14 @@ xfs_dinode_verify(
 			return fa;
 	}
 
+	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		fa = xfs_inode_validate_atomicwrites(mp,
+				be32_to_cpu(dip->di_extsize),
+				flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index b264939d8855..dbd5b16e1844 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -82,6 +82,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
 	if (xflags & FS_XFLAG_FORCEALIGN)
 		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -130,6 +132,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_COWEXTSIZE;
 		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
 			flags |= FS_XFLAG_FORCEALIGN;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e56911553edd..5de8725bf93a 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -166,6 +166,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_INOBTCNT;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 		features |= XFS_FEAT_FORCEALIGN;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..44bee3e2b2bb 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2060,6 +2060,8 @@ int
 xfs_init_buftarg(
 	struct xfs_buftarg		*btp,
 	size_t				logical_sectorsize,
+	unsigned int			awu_min,
+	unsigned int			awu_max,
 	const char			*descr)
 {
 	/* Set up device logical sector size mask */
@@ -2086,6 +2088,9 @@ xfs_init_buftarg(
 	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker->private_data = btp;
 	shrinker_register(btp->bt_shrinker);
+
+	btp->bt_bdev_awu_min = awu_min;
+	btp->bt_bdev_awu_max = awu_max;
 	return 0;
 
 out_destroy_io_count:
@@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
 {
 	struct xfs_buftarg	*btp;
 	const struct dax_holder_operations *ops = NULL;
+	unsigned int awu_min = 0, awu_max = 0;
 
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
@@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		awu_min = queue_atomic_write_unit_min_bytes(q);
+		awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
@@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
 	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
 		goto error_free;
 	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+			awu_min, awu_max, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b1580644501f..3bcd8137d739 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,8 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
@@ -393,7 +395,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
-		const char *descr);
+		unsigned int awu_min, unsigned int awu_max, const char *descr);
 void xfs_destroy_buftarg(struct xfs_buftarg *btp);
 
 #endif	/* __XFS_BUF_H__ */
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index 9bb2d24de709..af48a8da2f0f 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -93,7 +93,7 @@ xmbuf_alloc(
 	btp->bt_meta_sectorsize = XMBUF_BLOCKSIZE;
 	btp->bt_meta_sectormask = XMBUF_BLOCKSIZE - 1;
 
-	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, descr);
+	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, 0, 0, descr);
 	if (error)
 		goto out_bcache;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 336124105c47..cfcb67da12cb 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -321,6 +321,11 @@ static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
+static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a68ec68e5b92..7af2837779e8 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -502,6 +502,49 @@ xfs_ioctl_setattr_forcealign(
 	return 0;
 }
 
+
+/*
+ * Forcealign requires a power-of-2 extent size hint.
+ */
+static int
+xfs_ioctl_setattr_atomicwrites(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	uint32_t		extsize = XFS_B_TO_FSB(mp, fa->fsx_extsize);
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_has_atomicwrites(mp))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
+		return -EINVAL;
+
+	if (!is_power_of_2(extsize))
+		return -EINVAL;
+
+	/* Required to guarantee data block alignment */
+	if (mp->m_sb.sb_agblocks % extsize)
+		return -EINVAL;
+
+	/* Requires stripe unit+width be a multiple of extsize */
+	if (mp->m_dalign && (mp->m_dalign % extsize))
+		return -EINVAL;
+
+	if (mp->m_swidth && (mp->m_swidth % extsize))
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_max < fa->fsx_extsize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -511,9 +554,12 @@ xfs_ioctl_setattr_xflags(
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
 	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
+	bool			atomic_writes;
 	uint64_t		i_flags2;
 	int			error;
 
+	atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
+
 	/* Can't change RT or forcealign flags if any extents are allocated. */
 	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
 	    forcealign != xfs_inode_has_forcealign(ip)) {
@@ -554,6 +600,12 @@ xfs_ioctl_setattr_xflags(
 			return error;
 	}
 
+	if (atomic_writes) {
+		error = xfs_ioctl_setattr_atomicwrites(ip, fa);
+		if (error)
+			return error;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 30228fea908d..0c5a3ae3cdaf 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -300,6 +300,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
 #define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 29)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -387,6 +388,7 @@ __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
 __XFS_HAS_FEAT(forcealign, FORCEALIGN)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b52a01b50387..5352b90b2bb6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1721,6 +1721,18 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_atomicwrites(mp)) {
+		if (!xfs_has_forcealign(mp)) {
+			xfs_alert(mp,
+	"forcealign required for atomicwrites!");
+			error = -EINVAL;
+			goto out_filestream_unmount;
+		}
+
+		xfs_warn(mp,
+"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+	}
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f55d650f904a..c416f549e94d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -160,6 +160,7 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define FS_XFLAG_FORCEALIGN	0x00020000
+#define FS_XFLAG_ATOMICWRITES	0x00040000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


