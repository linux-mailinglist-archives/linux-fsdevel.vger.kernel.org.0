Return-Path: <linux-fsdevel+bounces-32865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9E9AFE89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB151C2037D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB61D4144;
	Fri, 25 Oct 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuUYkM32";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WrxIVMv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA1175A6;
	Fri, 25 Oct 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849324; cv=fail; b=R/5n542IgNty7K7zgAcK4DOBloi7pWuZfZuWftd6vu2zZMmRFNssBD58cmY8RH8caKsIWtG4HHa1JWX9Pzh/5mMa1WPbErbeue7sqL2emoGPsyfB56YG1C83Tn76ZGWLErASoSR0G2kJcI6zJffEiDjxq5KQgEgM4VYJFY1Y2H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849324; c=relaxed/simple;
	bh=vRRQ+Ce4OVvETHMjVaOTAjvfK3ABITHJCDvwMQgi7FA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HVLI46zs39ppbMRJR8Hkl+Y4966uLMGbYGQRa+nAWnxZDAquenHvHPxcAVuwJ1IUIl/yopd41I24Xwwylm/FsIySi8PlkezkGuMzfGn1DKEk+MogAVkh7MJIxIAw1qVCHN1GXGRJOnE1bvladUOFccdp4oW/ca1Ao9twnycN/YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HuUYkM32; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WrxIVMv0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BXEl026764;
	Fri, 25 Oct 2024 09:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=FFTdP8lgnifFQOFs
	ml/Qe8phbq8ETymSWjXv0Ipy31U=; b=HuUYkM329fgxjQoXi3dbP6aqbT53At2Q
	iyUd0IAJb1vPcXPQpV9d+C3eMGAXReRSR8R/b1iYGXyvor/ylVVKiFp7dUiWxQGh
	JB4mX2Tx1BA6+upHU8GdFfpO/eepI6KPEyYILcPs7X6MpGqkKkwSLLONAhVF3dk8
	w7ejUYIWtRqMq0BSE+SEfBxykxztYLAcCnV7sRsIYZKePysAJ6FRoXrpzOdFTGcC
	/DgznXrs9YWxswipu70fqJJMh5PwWBHo4xIdJDtReYm0eA2USZeP8jEH/6TkRXmE
	QZvQsstj3f8whUnTKyS8KD8hceAHrlVZHnFb9rQ+FsMsocnUcvp2Cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v4ked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7aGu2039579;
	Fri, 25 Oct 2024 09:41:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdnd3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6jSuKCfzzkQkpEh2Mu/Ey6si+7Xv8dydNArqClLM6KeoZMsUKTfQ4fvVOq9QBAtGDx46iY1YijqcY7aOwk7NHDyBARC4lDhXQs2VIh5k4uiWEWla6mwBBUTd5RADDcH27H/O8WpBbiM6k/d4jstvlDVim7jkWbLiEoxOrncygDkhmF3dSPdL3MXf4v1I5iSBQUiM0PhjnCdy3HviSRx0S+9bF0vmPSpLTASTej1frNkw16dNPcVZGqqKQz/ogM3LtyU0hlD2B3XAKA3M7UfX+W0maNNkpPAvgercu2PBAWIOBmlOR6OcB2VQzrJOZQv4NRTgZLhnnD2J7wl6Xia5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFTdP8lgnifFQOFsml/Qe8phbq8ETymSWjXv0Ipy31U=;
 b=qltpPiEdgjSLp37+paJ8RITjfPqJLw4b5vzk7F5SxX/Fj12ttszTiTW0gfn74tngTnlgGO3HMuk7upFFwUZw7QCZPUvwLOtYZrANZ8zkXGD1jzMb4ApvKau/0+o7GFZnR3/vuYhRoXDl+jOY0W/O55dSVaJDM73+HQzkPur9WRbY1d9rc5jLJVqjpogXbvJRAbq1xZoYsxTFHvyv9W7Kb60Wz7ktJ8rkEyVJ5Z2f2u6Goz4mjdSO8BpIfq24/GJZGOLsgXL9jG7Ta9WGGNIwZXMUywa4dNAAH2GOIdE2/bYyniFF4DyNYMf/ul05Y5BLR4oVzIumIloBz4gR+4afvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFTdP8lgnifFQOFsml/Qe8phbq8ETymSWjXv0Ipy31U=;
 b=WrxIVMv0uUv75WLZszcRwhrYkcB7guRVlKVs1391WJkAD6OEXtisdS4xcAxyEqFu0y75KSWclfAeeMQDEqiPaxnTWv4kx7Dox4aYQki6gvBUF1ZA/Ot7tJHp1WMwK6JDputg9R8H9z+cpyUBxe00lXbecCrCwTuSuBY6e43PGjg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:40 +0000
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
Subject: [PATCH v5 0/5]  introduce PIDFD_SELF* sentinels
Date: Fri, 25 Oct 2024 10:41:29 +0100
Message-ID: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: a13a6242-e5cf-47f8-300b-08dcf4d93a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2SkvbOr0BhRZxonDbJm65VbMPh8FqNv0PppYQ+3CZ6XhZmuxEQvuO+tfAkh?=
 =?us-ascii?Q?o4d/O1N8rnnhNX6rXy3ZG/cpbwgz8vscZ6v4v+qBo3bWRdGbyK0CzGEnI2tc?=
 =?us-ascii?Q?wiOtDXtgl+Lwg9xuuzx9mI5J0GzpVOmh6IMfGpYTB1AA8JS6ioV2xcdmgvUe?=
 =?us-ascii?Q?JUkxwXAnvb1QQeXhf971A0JSm18E3ukAEcmzl/7UFu01VGj0cyRmg6Z1vKbk?=
 =?us-ascii?Q?dHKGv9bXKeiPDbJv5r0ju+FdUrS43NNOCTcverRK9wymsvmu1Yb4kM6aXfe3?=
 =?us-ascii?Q?lFRWJPv25PQsMqbftEXUheWJ4XJ3SOw9w2o1RRpdSwottwWeYJYkrTltUp15?=
 =?us-ascii?Q?1BoN6HDh3UjvKHmewetYgUjFCDveSWIoITBriS0M/fICwxYfv1LxWZS56rkV?=
 =?us-ascii?Q?G1goKRXyBLfhCy69JaPF3k6ujUlIObhCBAQ/CXFbdSFd9PMqKz+tay9k36Vr?=
 =?us-ascii?Q?Lf0r3VUunV2uUJUw60mi+x5fS3+7zQK24ZI3vh/qTiBT8UjSRIfhUj6DuiEz?=
 =?us-ascii?Q?s+lQDIxn/yCQEHMXrl/6+GOiEOMBjrBkyEe9KxT2GTEwwpLyzf6fut6hkLmv?=
 =?us-ascii?Q?9bW94T+wUdK0SNlyC5jM/zPw7jslcWI/b6zimDubc4rCxBDNTq6Z1SWD+kez?=
 =?us-ascii?Q?RgcSX4IsD9WGPI6h+B6Fzh/h+Jo2FP1cS9ft0Slj0aM5btnqjzgWJnoO1fIv?=
 =?us-ascii?Q?eV00/dmXXxzfJ09+oEsZQAohxgHwRx8qDns0luSQkBxyLuGCG1EWi2qzA8bF?=
 =?us-ascii?Q?wB40Iom/ugmlGg1betf3wjznyOhxwFvTwqIXatqJ0M/J2QzqCqE2016EeJsQ?=
 =?us-ascii?Q?9Yj8YZPpxylZLRyJ0nq//ZS0EHfu0fGLVU+b3xPuG34ZAbapL/B3oRF6A7Jm?=
 =?us-ascii?Q?Uvahpij0DU7urrfFZSUzcq3um8l7UXQKei2hRZjjAEV6ZO4L6gqv0fufTvs0?=
 =?us-ascii?Q?0c55j8EINMwq8TDcblv4Nz5OV7erxh2csiZPlrN+i1WN8siOslFoZRg6CUEC?=
 =?us-ascii?Q?csdHRm/VAfKUGXISOtqdiR2NnHlr4CGoAacEVpc5tBtCsFhWXeunSH9DovkZ?=
 =?us-ascii?Q?T5QoQlnRpuVFrok2bMxpEYrF0FYDccvk5P+RlpDn/Zk8b7iZQgo6mguVoNCp?=
 =?us-ascii?Q?sNbF1QcODFD5IqJL5Bn2JtZGSjl8MgS9kANKw3ZPDgvWUqTauTt083upbM2p?=
 =?us-ascii?Q?EdjvsVd/PydhcZaaN/yqNHtHBrqXoHlC+IB3FxXYalPD/pNDFKTGV1qFA/8u?=
 =?us-ascii?Q?lmU1XeXP7op9X/7hwsmI43j/hVxYpjbZtKNzgOXqVsuepLcBVlJ1qpVQQ9cn?=
 =?us-ascii?Q?vEPll0g5UpZ0/4J0/BBQjZrQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPEcBRiLAibhPq41wis+ODrCh/rxUTLDTbxsmzjm5+7rPrXQWA2q7gvkUdwE?=
 =?us-ascii?Q?Zp5PZNNEDubQmuOm0+dmrHiMo95UCwBa/gLb/JKXs5nDhLWID7+BamNZ7+L9?=
 =?us-ascii?Q?x/FgHAZCie4pbQDU5aQvGdgZeS8TLbpl4u8y/8keVJu/EZ5WT6doa+gmqWkq?=
 =?us-ascii?Q?4H8etNRdDY2BOpTDj4Gf+hMhK439A6wvregQ3i3JkmU0vIxt17EuhJ8ot9Sg?=
 =?us-ascii?Q?WXAQJJZ3eU4wRkFAGBgxmKMwUEt0hy/Gz3CUEwuZQ6/0CDhrLOaUOQJoeVYR?=
 =?us-ascii?Q?67XW3JY/1l/AWP2y8mdSJi7pO+7qpjicXYcnNK2KKXwOwSXHiUuMSrpZmJ+s?=
 =?us-ascii?Q?0arbVUYxqffTqoEpGDkXqdqkX8pFOGCAgeCPufId03GfSQY+tjG36pw1d2Fj?=
 =?us-ascii?Q?L2G9vlMyxZ4a2L3b5wXCAPeW+kIKuGjCj0Yv1Qhymz+HVtUOj64myKBEF/7m?=
 =?us-ascii?Q?/pqhFNu/P7LxoWxkXPTLcSmk6jkPJlW063DukchcxZzIN//H6EIvm7ttnC67?=
 =?us-ascii?Q?ypL6vMsIpLuoRRZqYWATXPs0geZMOI4meP0bcbR7uF/h5H/xmcW6t36SboPv?=
 =?us-ascii?Q?ZiWnI52xdvQQtgQXg7zCmHLlyHadedmPDn19xTkZslhVHJCUfKiBQTmMe9oF?=
 =?us-ascii?Q?z6jKFNHVbYx66PK6FgUJPj5ptf/b4qQtTyzuMaLfq+6WGFEGLOjRhYelWK52?=
 =?us-ascii?Q?yJmv/+KnT5VLwqHpZCdZoDAxblweg2imZ1dmWKsRnt8ciFjfPFB56aPqlPT+?=
 =?us-ascii?Q?k/R6ITxHqUfIzxCMlny9TeeNN8Q5WOmOICAQBSKiO3latdTJ4qc4wivyXsKn?=
 =?us-ascii?Q?pJErOgAHDAAuysni02MO3alfHP0Myy+PnqX9nIAU4X+IgnsEU6fQSGUy8t6y?=
 =?us-ascii?Q?bSFoRrWN7YUzHawrSfavN1qMcTqEILYap+DLXIGnCIZ/RTkHTaF5FV4t5/We?=
 =?us-ascii?Q?PI+IW8Sn7rFv9B9lZP4f0z8McuY4GVlCNbLjADEa1ZlCvu3Xh1vrUJdO6uD0?=
 =?us-ascii?Q?h97wqBV7mmwvYJyESRSd8MCgz0xyBLpSo+0M3ZBO4i+jD3UPFKAaduMT5GNf?=
 =?us-ascii?Q?B220wU6O5Sk/w3sbA0jwsMuhDK68JVOCjTUTIP5E9Or8KQIZdCgcKGeuEn5e?=
 =?us-ascii?Q?dXBjQYTjRrT3ohUixJtCL/iTti0rQpdqZXLGPGrWALvkoV9/2ir1J85I9Vjs?=
 =?us-ascii?Q?wbWoDCRMpfNl4ehyuJMc7CSjxy1HE+kWfNsEniGHGduAnu16n8Jhd9aNyouf?=
 =?us-ascii?Q?H7kmIlOmSlfSJsSmeA1YnO9RPz6or4/39wYmiA/7ms6SVZmZCyrxvoXa1W64?=
 =?us-ascii?Q?31pDhqEcHMctLSZgF0sTik346WDuztemZvlAoTIHg4bdoGHBwVcy/HJZwoiG?=
 =?us-ascii?Q?VBDnAtrcX0GD4Ver6j03R6jcq2xfffExbwgnqyDtHxMpfvdfI2NDJJIb3m5X?=
 =?us-ascii?Q?BywRaSs4wkI3xX4PlZ8hg/U23HD0+66M34VAZ4UVzQSilx33Hat28BXJmU5G?=
 =?us-ascii?Q?8fD1rbhxOACyGvG5IbVxMZlqydTg/d4Fwj0k7DGAH0CLVYWTJGA/pTBK/rxo?=
 =?us-ascii?Q?kzNR/azt+QH5tmjnqCoe0rN8hf5NzGqHyZwbuw4YeT1o6ivecneTBVAKeBYU?=
 =?us-ascii?Q?/xOVvSqr85SzlYWdpteYL2UngEL51dsBTpy4VpQcb8FK4MG6sJJH8Sjgr4iY?=
 =?us-ascii?Q?dOR/LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r5Xy4UPTaQVEMtiBWCc4a07PnFtyuRjJ5U6eF77c9XvRuyS1FZSloxcj3/oeP1C4oeAE9Jzr92QBNLPj2u4eLCagDXEKwEFkdHVba7ayD2GM8/wQe9ZeCWzJosG/xQ3sck3tegnjp0VhvDQu+It6CJevIBK5lIKQdMtULjCbxDk1PY8pqP9cFnVImmbf5Eu1E1ftA8hlMJ4h/AvEwn8sCc/m8cxjHdWwHEsgFd3lBvHJMgRndjo2pazKG1P1WhGjBvkIWrMoYLS9MEjeJ+Z22OHmpiOrLDykO5HJ2mMv+zrhgolLnBD4f6ZQwnaBZftGxhDjcAnmtvtdlVQ5ivZwYged1hhcODY7b62eIXzPEAV9LMRg5seCU1iXvTs17EyD3gvGdJNC7R8IWJz6sx8GtNLTyB7Ltlk8rJ2cWrYNfOnT+yWLGWomgtBLDQ1LRrWX1tH+io2KkuAIOrTLrqcNEZdVOu8kMOPB2uKTmkMKpNnj41SlBCCUuX2zdErztftTHggu6Rac/NxG1qLGSK7+mfacYMTVR8djpiis4mP3CpmlS4unRXYqHQVYPTIJ81HO9Pv02nyaCodvGmrY2XkC4j/namh8T3BsSL7k29rGyPg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13a6242-e5cf-47f8-300b-08dcf4d93a1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:40.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/LQFHKzUW8lSJ6N0Xf3nnL2YrFIkDANddSVp+wGr//BJTxHzGuMaX6Wxr+yc/g+3CYluQdnQqiiDOF6Ma+nmLY5+hTO7BV44Mr/mnEORGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250073
X-Proofpoint-GUID: iMgcDOANhTWDmXmtzq5WTSzlcejRt4aQ
X-Proofpoint-ORIG-GUID: iMgcDOANhTWDmXmtzq5WTSzlcejRt4aQ

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

v5:
* Fixup self test dependencies on pidfd/pidfd.h.

v4:
* Avoid returning an fd in the __pidfd_get_pid() function as pointed out by
  Christian, instead simply always pin the pid and maintain fd scope in the
  helper alone.
* Add wrapper header file in tools/include/linux to allow for import of
  UAPI pidfd.h header without encountering the collision between system
  fcntl.h and linux/fcntl.h as discussed with Shuah and John.
* Fixup tests to import the UAPI pidfd.h header working around conflicts
  between system fcntl.h and linux/fcntl.h which the UAPI pidfd.h imports,
  as reported by Shuah.
* Use an int for pidfd_is_self_sentinel() to avoid any dependency on
  stdbool.h in userland.
https://lore.kernel.org/linux-mm/cover.1729198898.git.lorenzo.stoakes@oracle.com/

v3:
* Do not fput() an invalid fd as reported by kernel test bot.
* Fix unintended churn from moving variable declaration.
https://lore.kernel.org/linux-mm/cover.1729073310.git.lorenzo.stoakes@oracle.com/

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.
https://lore.kernel.org/linux-mm/cover.1728643714.git.lorenzo.stoakes@oracle.com/

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  tools: testing: separate out wait_for_pid() into helper header
  selftests: pidfd: add pidfd.h UAPI wrapper
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  34 ++++-
 include/uapi/linux/pidfd.h                    |  15 ++
 kernel/exit.c                                 |   3 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  65 +++++---
 kernel/signal.c                               |  29 +---
 tools/include/linux/pidfd.h                   |  14 ++
 tools/testing/selftests/cgroup/test_kill.c    |   2 +-
 .../pid_namespace/regression_enomem.c         |   2 +-
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  28 +---
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_helpers.h |  39 +++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 15 files changed, 375 insertions(+), 88 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

--
2.47.0

