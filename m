Return-Path: <linux-fsdevel+bounces-36936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1849EB17F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAEB188CA53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DC1AAA21;
	Tue, 10 Dec 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EeIafqLK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQ/7vZLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F61A76CB;
	Tue, 10 Dec 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835637; cv=fail; b=D+Zy2J2n7ZFM0vvWmjfQfHCNTAIQK9m1RvwsutOXabc7NRlzrPOWk9oIQP0Lg2/LYDSafOzzCd1kRfSNE6jwfzPiwTK3/8HQg3pDJK9536SkuPf4PTmArcgSRVawqNxQup72zLvRy42+AZ8kD0Ljj7hEyv3bioxwfy6niyB4eB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835637; c=relaxed/simple;
	bh=T/H0MQl6+6wQP89dXD/1cxALDZ5syofyLVpY8AZVQvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6T+ExbnQHvLURJn+3DB53Og4ZsV1hAXRTLw1/MQ7GD7eXEeZ58kqWIu4Wz4gbiO2XEG74bL9IYm1kZ7+YgqPf10y+u2yXaFgHnnBjfFr52PK4nypgeuyhLwZ9+lA8ZjNgbGIK8TFslDrM8y2QkmklgAuYYBtJA3Htm5qM92U8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EeIafqLK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQ/7vZLk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACG6Fn021896;
	Tue, 10 Dec 2024 12:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=; b=
	EeIafqLKvbO77QWBvLgSbto/HHb0Ss94j90fAhu8HFKLA7nPGSo0cWgEN4pwxfHF
	ZVIWbWnq/0yQJ4QmaSoUzqkYICnekOCLv1lk8kqJVU1E6HIHx25JGtPe8Qa26xZe
	FDqRrWT9Qb9hVzjyrdW5MyWon+SVIlhaljLEhQpKfVg6cwz+jHXURz6qusdwkucJ
	aNmIs3odjNPTegkQt949R50vhll7bLGuAWYtmVeRxyGkJo10xcOGEuQnKIOezF7Z
	oLsxAJL6NWZR5UQNgt22IIkpAPFXIGyDP/ATWs0cLMSVNsMzIkWBrbgYoQhZphuC
	9sto6gswEel7ckYEbGEgiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s2ur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABnpXC036434;
	Tue, 10 Dec 2024 12:58:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8kuj2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spv/TdF6uJ2uET2dq3DUcThIZXh96AyhiBi7df9Ihdtz6HrZL8IgNRYRCMEyw6o097MNc26RpuXsY1uohPYZUIUazPjhEDGKtt5mH7SRe7guVM7oldzovkFns8pXz2Be99dbsNsk+Ee20YbNlCLTWK39Fcqd5q2GVAEGedAWmDq7ZVOpZA8lY6upbZJwS41XH5ubRQKl3XYoCZmlFHh6qv9EooHINk3Jkd3FqtLOCxyl4VywD5lTWOuPGK3Nsz+GsNX+yUcwMWF9PLS2PPF9wOsikbvi/oktSRw9drGYqMAkMo+FOMxZqTwpBvLFQqqq+pWPSIbh8rQfjhELa1qQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=;
 b=m9/Zk3aS4MijILq0Tojd4z5J9U2kGSSm06POiLrxWwXMnh5OFbjjXWqDElp3GaahYy4c1Un+yrpWqH0sMfid73+1RdcljQBWwv/kZD4IvxXq7unX3Eut8za1gZgIwJn5ZWMYgqISqSIHV+KpoXpWroHfwNkaCP9OK87G983OsfST0EIqlS6+wQTHy5HuDvR9eehNVAT99jMlUWQVFo7bgKcjtznc1W5ZObtwCQBox1CbVD2wuPlkY35IDdWLW0sYhnA0uW2ZPydYAm+Wl9evylOBIo30Q9YFyJz0causP5VrllG/89aZ40l9V4MIofxMlsLLcx17uHSUouCN9D/dOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJa2FYn+l3JgVXkyj+HzJHLUFWBrqtA+vCZJkGiC1zk=;
 b=hQ/7vZLkPWt7FldEyGpy8BB/U/NBbhhGAz6QqmQhU49N+ePUI7S8nkHn16Ea9Ro+F2ZAES6gjva/vEJkKwnH0j0qvEDS4cPxLZYNLGJtLy/LSXO481FNftFcunWiO3r0rMyWxhiXdE0vUtntM6LHrwg0fJNDOzMzBDgVksNYP8M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:58:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:58:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 7/7] xfs: Update xfs_get_atomic_write_attr() for large atomic writes
Date: Tue, 10 Dec 2024 12:57:37 +0000
Message-Id: <20241210125737.786928-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 437fc060-2909-437c-e9b5-08dd191a4d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMnpqFUm3IiMaE9vlLSejls1mbgJSqd/ny8ZaoYD+dpE7G3GZHQTZpgQSheU?=
 =?us-ascii?Q?zYGKvekS23yj7WdKaoPXB/PKXJzJ3GfCOuxtf2ZHtSMfOq5Nx/k35fby+GkR?=
 =?us-ascii?Q?6nZtFPrJYbUG0uhX9xoPmK0wCmzSHMcUQLoRwQGx4uD5NzACbVFGZI7oAeMW?=
 =?us-ascii?Q?UKU0LzMyng4Uy99Kf0fIfg0DXDJFIfre1GN1G9yLTI3mXMMscQD9gGNoTqpa?=
 =?us-ascii?Q?Elm2NReTCATs5dEacKQvTv5HLXJ5l8/7DiQQpe6aDx7khXb2aMEWAx9nnt9j?=
 =?us-ascii?Q?q098ZtKAZa0UamKmNpBDW1UXOqMSPHXOwtOmH7mvPQllx9XAXJci/aaQZzeZ?=
 =?us-ascii?Q?VWkb7/J4MwjQJ/a7d1sodWwJsf1OL33QFmrSgoYi6f0pxNtnQGiMqrbOFzHB?=
 =?us-ascii?Q?8AX3oZ7AlTIvsIEUOBIBvOatSwr0LJAywkeOvYuL6TcEHcQnkbEEwFSHQuZJ?=
 =?us-ascii?Q?8IYvdP7pOwk8aVwW477aZGnft7MdkMj8VNG/SS17bhqgahXsgiP2YGAYp20I?=
 =?us-ascii?Q?szs8OBM55ZH4LQLHvqAra/PRuwdQftsn/cXVYxMALng5pHvC/aMqwiZrRDNX?=
 =?us-ascii?Q?Rej0ipq9Zi12TVMyjP0Vcr8u0NWzIq9l4cndnQma+o4e8j7cXGOr4jeup0EF?=
 =?us-ascii?Q?L3GWgsgfyQg/amaJIJzzEHqpTNiKmBfJS6ZYqM1Z9f13+8cpfv2q1fcVRGK2?=
 =?us-ascii?Q?y8iBAwqUtlyNJHvvnQvj4w81ilKMGOANTIxO9z/ModsQ6FYams4y8uSUzJE2?=
 =?us-ascii?Q?+uIQMadfnnw2sDXMC5zc46ivVb9WVDS4uGPITFAq1Nipf2TSjMQDu2ZU4Eqs?=
 =?us-ascii?Q?c9IlK4AqJ+2jSfmsKi6ahDydjTSxTKc+nE82sRWPVnIvpYK/MZks+mka/6XU?=
 =?us-ascii?Q?5meEVnfIeN6M98UFVF0wUlGFJRw3e7iLudAXBfnW0YWCwpzmXYeKXpDYija6?=
 =?us-ascii?Q?SscvsTdNMbA8XHZ3OmK/z05zl4kfbNSaeNP59+fjRyit5JvlUdQr8VD6oCFr?=
 =?us-ascii?Q?j5jyPoccjJKfTrORcM/MxshlMUB2PaSAE/C4h1e8JhOhjVztzL91NAAgBOt9?=
 =?us-ascii?Q?3kgDJxV+BzLSOvFKXH6vXrnAhPpbvVaVPM0gGYa06Kx9arfpZCqkSKmS6lbd?=
 =?us-ascii?Q?9hyafDpNx43yLoj2dSBNZCB1cI1SfeIxyffhOBXgBnWbfSkjJyJcUXI2JwXc?=
 =?us-ascii?Q?J6+lbHP2hK16TOywYR8DMcyDCxZikgWL4meku8cNiM1D6FFAPDQ+R0glKcOU?=
 =?us-ascii?Q?feouzraOoH+GKjcLddrWCugSfpEhg9X7VfGUxVjZzH92p1fH5J+15M+BHU60?=
 =?us-ascii?Q?sCPNIe4FWfQ0aVncn0SAZXw8QsLcdQE5Kp6/pznk5+dfLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35JI35sXpfG2S5bovDrZt122JWn1ea7Bp/NF5gIWc5vm4ymEy/VkC3WF+0Zs?=
 =?us-ascii?Q?Zgu8oVTVmw5ly7J+2mJDPJdtHwZz3aFscm3o2dveB+/xW4TkyVV/bKZ3NsfE?=
 =?us-ascii?Q?PKdZMXv9vapIBFNkqyxjYpotAAQ0xOlBYMMy/7hlE+/l9/ESpLrPFczI4RBH?=
 =?us-ascii?Q?eFnCA5dWm8b9OYF+spdvlBa7b7nsKdK50FNv36EAUPJ4r6VDg1tO1yv+VZNI?=
 =?us-ascii?Q?RYAMYh3axcPxK8FwMIhhKU4mfwl2WMYk2aNIxYA3G2Q1K9TrpAVCeJXtsFCZ?=
 =?us-ascii?Q?HQpMZG6L1yhHQDVyGcyT+03RYVpOkpUoXxGD+duxTT+5kVNZDo25rFTLcRmH?=
 =?us-ascii?Q?POFViBbO45ne9pWYxfA/v26NACzsmFX8CqpdVtOO+ST+pF1HuaKaCsvo12gL?=
 =?us-ascii?Q?xa1rgBEkTkNK738z3Z0czQwvFpFVcqbI54aPSr2XhGRVC+7xLCRXuYUj3wHs?=
 =?us-ascii?Q?fAHQrRtyoqJzO30y5Vvn/VFeSq2NkbA+pr0Q2j4qOaa/829KB25yX3Jr2EdL?=
 =?us-ascii?Q?oXyZdhPhJisWHGE9MPjN3v5a4sYmXzrbKmGVSCmhHS5p5k/l9/eJZpbKdSXY?=
 =?us-ascii?Q?Cw+22SaULTink9+4oFMKsK+L87zdzUh1Wo2+z50k/wfPZIm6JnNA/rTIalZ/?=
 =?us-ascii?Q?DFu5ZtvNRVz170AtQYmrOJaWeM1VaRDwlPodD1At/Dx6DLh/4AWmrRzGcee0?=
 =?us-ascii?Q?TQPzZTYzj0wzIuX389rvhEeyxqqZUH2RuW3yR1rlsjMCmcEK/p/1BPuQl7QN?=
 =?us-ascii?Q?mjLxbO97EZPgTcSJLpIo8Bui6HwGqH9+Oi1JqUwMdWurq5PYMY8z3+F7hHFd?=
 =?us-ascii?Q?AfLtcIooJ/smc30KaKquLvkkIizJV2ADKfV6QLtsLr4O78UVlhIp7aEMF+BW?=
 =?us-ascii?Q?RrjRGtCoz7lzgC03/U0FOS1qH7rV9fA3rrc++WtHDLmYQiMzmQG2D0oIZdPJ?=
 =?us-ascii?Q?iPDI9LROrmT6l8+vG0RNTu69Hx4eRMQGLfBHneaabRAOSSuzzvMBtEiIx668?=
 =?us-ascii?Q?hsWQKF/oSWB2MLIfnZYdUEsBf9k0/g9OmUfiSxnOcEucbe6cRv4CtshPVjMA?=
 =?us-ascii?Q?OKDPG2PITY8XBy4+f0W2ju4DgBYxpz3pgCKm6luh2aDpxEGYztw/OiPh/EEb?=
 =?us-ascii?Q?ibAPB783DF6G1OrlQytV0qG7GkBVeAiXN+ovHPwpWFGAT7+sWTedfP5l8pc9?=
 =?us-ascii?Q?2TjTBqouVCQZFimIqCLMylVxqoJT87A3Wi3vQIbjaBL2H3xxh5z2lreMUdyT?=
 =?us-ascii?Q?vW2FIRbpBRF/HXnLJxPnahSUQ+UPrWi/CbLJQ1Aacyp54Q00/9dppapGb0TM?=
 =?us-ascii?Q?OQYFoHZ9vZ/wxCmhl1iDm9lIt86QkIOQup2BidR+veaZ30gZBqjXO0RAIF3U?=
 =?us-ascii?Q?WlBJ0rp6ECZK5dn+6T2qm35Z/UZLkDNDROXuBBoUx2oBtmx0dwPDH+Oxgrmu?=
 =?us-ascii?Q?zrG3K7yUShWExy3yzUXh/vgR1PpPOaAREGdWbEGpCzHDLlZFLU2K21lDf1Gi?=
 =?us-ascii?Q?HmHpE/FqL1KmL71hcre+t3mSiHwI+DV+h9wsTQiUtlKMd9AQpzN8A093QSQu?=
 =?us-ascii?Q?ZMAjv6o3A0t3hQIqgYtNjTlZ5FTsWICVDOBrfx9EOKl/Z/HApqr5P51KUSfl?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWigfvaByKSj3tBaCCnFO3Pb53bUy/mZhvoocBPTQs6ZYNgAGY2mk+2S4CH0NmT9KOwSAObpiUggJ2BolxdLuL4ANi3Ph/WEoxuTULYr+ByB1MQ/fT/UxVE3svQreEQK7YJg+oiPbdAtIrosDc7fYQjYbQi4k7eux7nfK8UFIFnqjT59nO925AAPWC4orIbD6d8tHAL4lv8RPgnbRgVGWx9n72ns/harN5R3u07GWvtCeE6AMPMRtp5zz6SJzYk+Gx9LUYvRIFXRHUoHpewGHZqZtkbDFN9sGwOvB1G0Smxp1wraMejd/TknupaWb7YPSVk/0/VWj9t0wUtBv6262f/k40rEBcUsiWVjGfwxiEVfsYL2G5Vgw5v02nvRk+uOzFnNZE67SicxR3bfueJUvTt6lIgmehFVKBgHCUJTkRGt5YZMi8MEvUJ0pYLkRyLfb6RIcxtu0PrHyrNNN/iIpTt6f0A278w+hkC98psqA5wuquhthActdPRyaryI4Ke2nCJc41e727cZt1oSXxa7gcgsbFFJ2NwHMUQ8aLmm4JPuTpWcMxfctBZyo3ZAsaYCpH3vbYW8/X5zyPK+mBVBGGQTrcD7NVHVFv24NIKLRWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437fc060-2909-437c-e9b5-08dd191a4d52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:58:11.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1iZO9k0Xfqi+4u2S+yKaJ6T4DGEZmVEXOXyiE23h0RobehDvqXbvCF/jH3ePIMBFVJleKThcVN7pqoh3l5Qvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-ORIG-GUID: DJbCvptv66df7L7QCEJmW_h931bsesz0
X-Proofpoint-GUID: DJbCvptv66df7L7QCEJmW_h931bsesz0

Update xfs_get_atomic_write_attr() to take into account that rtvol can
support atomic writes spanning multiple FS blocks.

For non-rtvol, we are still limited in min and max by the blocksize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 883ec45ae708..75fb3738cb76 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,18 +572,35 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+/* Returns max atomic write unit for a file, in bytes. */
+static unsigned int
+xfs_inode_atomicwrite_max(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return mp->m_rt_awu_max;
+
+	return mp->m_sb.sb_blocksize;
+}
+
 void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	unsigned int		awu_max = xfs_inode_atomicwrite_max(ip);
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+	*unit_max =  min(target->bt_bdev_awu_max, awu_max);
 }
 
 STATIC int
-- 
2.31.1


