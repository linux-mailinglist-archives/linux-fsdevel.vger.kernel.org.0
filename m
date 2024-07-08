Return-Path: <linux-fsdevel+bounces-23280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6E92A169
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D4F282DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923D7FBDA;
	Mon,  8 Jul 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mDRIGh3b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vAQWwuWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E42B9D4;
	Mon,  8 Jul 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438976; cv=fail; b=rTgvHNErs6aViuwU2YQdbOkGY0mNck6BVgXE81xrPaXtw3ep6PopwCOjUZ0pau9uECvgze+L/i/+gEIZNNg4fSihpKgfM7IeaFpSBWcY7FBnGTRuMf/zbppZpuuexgiTC5CtZqAxW1JFMhOoXCC99qmgxdHgLqWq/h0HPl6pSAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438976; c=relaxed/simple;
	bh=5bQ8NX86qRxb5I1gv88lk0UbcjwfB0MQa2SHXTR5LhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDGjsdVxCgBhbzSUGUxJ9g+JyLAgKZ5dJfJxMKVJ9ohdFroiFi/+SqbTPsplwOKJzHRW7RH1OuSUFi6uleipCcSr/DJmBxxlp4fDTUm+INcmJXEibtZPhCbnp0oHENvL0hMavJnUjU19xR5admO7SZZYNytr7i6z+FFz5L4gwv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mDRIGh3b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vAQWwuWt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fYSD011958;
	Mon, 8 Jul 2024 11:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=xb/OUh+Fp2Beb9QpU/oFatH5trNYo+2QIQK9nzjzGg0=; b=
	mDRIGh3bCdwWgfEWOoEXxz14jra8QeYjuXq7Ktdy6hwcsVrZM+/brWV63m6T8nTd
	8rtgwYfr5B7tNHnkmvG1gVZdT+NoVyWsRoxAODPXuqWZpWCdI3/0x/8hfa080rPB
	JQkvLU51IVdkak32S8gZSTa9DcjC9SO9VpbXRBCX+lPJ0tjcdREubF/7xrVTxldc
	cTD3I1qLwcvuxSb0UnAaR3TLL8WpfSqKX56L/23WEYOBYXLIh8Rh6xLHNrzUorqU
	O3OLwnKUsRuQcGEDfZV113yjoiyxARs/hq/1E41r8l3mkPAiMcNIMh/xDPZajQaY
	qhmHhv6GJKhuXOH2MAccQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybje3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BF9Ih014343;
	Mon, 8 Jul 2024 11:42:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf98yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9r2lHzUC0c/fNrLp0DbkdQi8hraQ+bmw+aEBW81ULRKdyf5sq/UDI/iqeds+YPLfrLJAISU+/RTfo16fkxiYmghc9iTfLQKmwuAAcDlvPOzfx5QS0M3/cJy6Ff5tlqOcx5Y5MaVxEEBCx6sRfqGZwvP/za8RzWwO/lt2VhZwYu7MI0EjD+XNMyFI/9LTr0Gld8pBljz10dB6bKaavWMwX3nPyYtROz4Ra2/o6kmmLi2cinGlOfLkJ4nKcv8DuQ2QfuWBUXsQQI51d/uhzQJ+DSqf3d5jNKxMVkBMwwA6q07DqaTPwUaIIMkfKNVQKWDWDUYhygGxtCK9tvl3mMcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb/OUh+Fp2Beb9QpU/oFatH5trNYo+2QIQK9nzjzGg0=;
 b=IsLT5yZOtLVjn31id9gH1UbRRJSlW5ZJkR0daiVJvq8cRzS6h2bHLBRtZee3hE/lozLoL02A1dRuAxc9r2jm8ptgjSXVX6QpnzUFN+OAXZ1NQkv9uK/A4tTTaEE4ObLlAvmWxl+OK0+RewQAGoHoEmms65bV8FGx0AamReyysJVBjs/qpXwDX4BrOfSTPrhk/KMUWavClcV94P7Rc9EuFH27xcHqbVM1CGRbV5lAAg/RQoDi29Dul2FKbZ+Hp7Z2fflGcmt+bj9PYWexBoPySJEAXQK0lz5DhwVGItlAB5zH33nTy5isx5GHqP99ui6h1XZaHBFSMtjwW8Q2RKJqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb/OUh+Fp2Beb9QpU/oFatH5trNYo+2QIQK9nzjzGg0=;
 b=vAQWwuWtqxUs+t9nHxSrGs6//Dl+gM1iZkxPz4f8gcDrN3ajo+OtT4F/UBhnQPPHnoc+nZ+Y+3mHpmPCWiRzQMEWncGW6X1S4y0LRUElkApNeJBlr98J1DE9csCBTakAbnz//FIgL8NtJBclfOpowsYsRQmQZH/n1KsKRC2J79w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:42:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:42:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/3] readv.2: Document RWF_ATOMIC flag
Date: Mon,  8 Jul 2024 11:42:26 +0000
Message-Id: <20240708114227.211195-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708114227.211195-1-john.g.garry@oracle.com>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:208:32e::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ddb2f2-c099-4b37-31ce-08dc9f43151d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y9Iy27Q2bOCwqSfo2vclDjjhmk0RbXLpWVv+54EHe0p29kS05n3qtFdKmte1?=
 =?us-ascii?Q?jjp4Gsq7yW2UM70SYlEY9afjty4dXJVB/PeYKSM6FKHfzLuN5+uUH4Zw63Q5?=
 =?us-ascii?Q?IW5FJLp0/Js6wKJMbg/6kdeIycKOQEQGAnnDlJDdUcIErJ0MVwvUt9f2a1K0?=
 =?us-ascii?Q?kqNYBQBs8m0DzWjORczeQsV1VrM8oqCKR//q2cfuagV7BST98rHTfj2RxfUL?=
 =?us-ascii?Q?AScFoeBt58R91B1Z5U7NXm23f0s2+U3zvzjC1wN4YKrBG2nXUkewznmUv9SI?=
 =?us-ascii?Q?4+MC5gXIY62Bvf6iAucl0sisc+Ad5Eb1FuqGNnvd8+Yje9F10F1dhWMpfzZT?=
 =?us-ascii?Q?BQbWuRZruIHH1qRiJ0fFT7Ctf67mXJHARxUh9q0xJVVLkcqOvlxlG/gTg0zE?=
 =?us-ascii?Q?3HmJzBnR9LKEvcepJMk1UKITs7Zr1MGj3jUsbSFML8O2mypWgGA/0IpmvdET?=
 =?us-ascii?Q?B5Co3xr5E3JcC5cCpb11CoWv0w4p3wdV5WZ8Yx0GbcVWxp680W9yo84N7Lku?=
 =?us-ascii?Q?NceXQzJ2zEqtl31Mw55gAQCSaZaFbCGeAldCNWGo+4X4cGIngQqVfEOK0aZF?=
 =?us-ascii?Q?9pUjYgQ2QPLdqg49dFAEE1tAIB3CC9vvi5geMapyW2UhTXnl0XXamnSZcmVK?=
 =?us-ascii?Q?I9yhYRn6jnqcFhYAjttbFTfmssLWd8Auq29SSk/xEnzzJqEqokwJCvOjyjFX?=
 =?us-ascii?Q?aB47DSFmsD3SfWXxKlhAzE/4Q9iH1zGPyqN4XPQDMcaZHnaoOYuor71Yo9Fx?=
 =?us-ascii?Q?Y2bDqMHDPbakIXrjrtxPYkOJ+0lUIVGfT1cfqTdUCWnBPW3RxUXy4Ox935G7?=
 =?us-ascii?Q?/yG4/vS9muCm5TpVo/M9QdOZkV+00UnrnsIerLvuTEcNCyUjKvm47sAewP6A?=
 =?us-ascii?Q?w9T6A4SqYr/WXZhtWlUC17312gtrxTQy9yVzSLyM4rP3FDgB85msAb+wnbek?=
 =?us-ascii?Q?U8nJHyvLY47uQ1URtm723kxWGfp2JPXE2mJfPTFdt23jdvEACnnthN21YYOQ?=
 =?us-ascii?Q?wlMi7ht48tYt8/t6PQGNomfenAYMFXJ0SU3C/DdXa3RM7fgx3BXDWNkrc7/r?=
 =?us-ascii?Q?Cf+fQO19+y8i97YciYjlgaPOJQVYvemS0pIrNko9wTgM7UD6dKBb+AXHwHI/?=
 =?us-ascii?Q?0ryJQwcHBSXRb2fQK8HhFK6qnW0X8bNXap+hV1EoQFQHNBNW9GKMrPnDdL/F?=
 =?us-ascii?Q?/ALZvWdc2sXg7HgZGdEt7h1rjYqHnmEIt+jq6bUX2vKMskleYf0/qdN3wcmV?=
 =?us-ascii?Q?qyfDyf0iq1kv9HkGQ6sek7bVTvM/DvCH1gOFHBbBTmQZIg8HtNWRqtnJQggd?=
 =?us-ascii?Q?2jNhv7Eti0aCicmGzF6+pXg7QwmEYdglULs6HLev/luqLw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tQAB1R4vjz9hjktOniBBQlEZW84giJEWiVfLtFlY3dwoDHMfgRiuKGVKGL/X?=
 =?us-ascii?Q?lK7gOaJDjCtQcgJwRki4upiup1pXgvZhT2RM5O+FyHpJJuOyEpQEv6Vc7oke?=
 =?us-ascii?Q?f6GKNmyz3SavHT9Pc/0ckZck7I0qd6N8V9Yb2TGlgcBwByoO9ZGgdiX158fD?=
 =?us-ascii?Q?yOuthKK0ftJYd55YDG0gbXpIbXeoZ4p+qFLXf+X7knKX/Wybye7foPKj+IvJ?=
 =?us-ascii?Q?jwS3LuLPlfggj60ccDp8dKkP2XCjemyl2kN0E8vkHO88qztbJzNQe4NX+DYY?=
 =?us-ascii?Q?3qQFZZh2T3BBEjaznM5J0usUe4c5xz0Y3/AC99MilFrg1g7jlcL7BBuAQT1f?=
 =?us-ascii?Q?7JHV9c5lGmOlyAGJJ3Np7IWolrOCUAYnnnmiuvi9gELb33LT2o9TNkaZoZcB?=
 =?us-ascii?Q?xMn6ZJ7aCGYzR77kxzvBm6IR4NyfmCDqWCRYvr9RrXrt5Yj8FD51HVD6Ui3V?=
 =?us-ascii?Q?U/vcdS5wAl5skjVWrYrMlLTSBxt8zqeEE/NeSlaVCu1JoiAXQyFbZLmEyWP/?=
 =?us-ascii?Q?icdWfdWF46GZO53xsGNowFeb3Fn92rxt8d3INNEuKUZVslz+wse2f4Tn2wOb?=
 =?us-ascii?Q?q7OmnzSvURSkMpyOC8SDLyXN+TnNUtFmSMZsHnHiLUojpA2SkE6iU/Askvyz?=
 =?us-ascii?Q?mAFNq+cOrjUHd3YtF2zUODdmmexg6Tcjw/wCX/dHbPL+EcJKpJ8rGGI43ADK?=
 =?us-ascii?Q?ezlIpdhlRqoTSbWFC4GWwyt5wdw9OA/kNs7sV/YVGpTyNoh9bRilSQN5yb29?=
 =?us-ascii?Q?Gr7YV/0hPBRmQKiyo2krtNo+YUR1NjMUU1HE28dbV5qnfw2ulK/fPHBRpSEm?=
 =?us-ascii?Q?+Nhe1r+Y+wzEnS9QslJaubzT+CjcxcL+kl2RI4A9EoXRrHe9mFwnokkzsDG3?=
 =?us-ascii?Q?U5KNjmr6Ja0hMXXoxpz+d+rPufKj1AN+MBR8H7CPx+7lun2fd0y0VurzdnXv?=
 =?us-ascii?Q?sfsYw2ko6KIkg8/RntJ8U3fEPykBumFxtrWhE8ygFVhiUbZBQl5C3/zWhzH3?=
 =?us-ascii?Q?lZ1V7r59xwE6MAd2XxMwnVg3+CRQ7DfM3ce6mL7DJc0b5moU5jQu91SB8MY8?=
 =?us-ascii?Q?EvVTxkMtug39P3Q59s14zrPcnedsWT1XQMI5+q37dLDgyH/pziIsyeGu0bKZ?=
 =?us-ascii?Q?OGzdDWNmvWNHNeN/vcIMrg6Ixa2ajAtSFuQTH2Wc2/AT7t86/iAZ/GTfVrVM?=
 =?us-ascii?Q?biEiiTxGnXfx44XaoK6hlYbV+6+UKCDhkkL5MRdVRRtPPlh0nzkqHuz0ecYx?=
 =?us-ascii?Q?UVe3m6iycMIZqvn0f0xZiX/vfxvypgkQ69XlaT1iBkFdt2rc1enmpJ3sEa8h?=
 =?us-ascii?Q?YCbBWP/WyRPLGODCpHYMkP6/4kUIjMso0WhCLhTrMZpU3jM5U9xiN0NWCofk?=
 =?us-ascii?Q?HJXSh47apfiTw7rfM1X2z1Tk+3uZFMc8uihkIKxUyg0T4ZlTq8shbIXkC+CR?=
 =?us-ascii?Q?j7Ctkl9G9kupgZq6qlJBcPAMGnBxEUYpI+lmwkUgJyigYspl8Z7IuyhoWEso?=
 =?us-ascii?Q?1kaV+f40yd2hgdT0yc0vO/GFEJ9zc8su9u3158BPdTyNU5IKxDZ9iQbFQ37X?=
 =?us-ascii?Q?sybQRb0bHaXN4jbWiaalQ4XAtREU8Q01mc3fJG+EsyPHObeWEy5lrVn8xNf5?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XIUS31JbhhvGUoYyyQMOye4YSJZ2d53iFQhjtIgUuQ9uKCRHa6jp1Lx6afZnCXKRJKOZYZdoNB5FrdljjEMY12xj/rZ24MiPtI6rc3wCzFMJI6XrzmZkRxIGZLq3oQgMuUcf7SoluZc2jWZ0Ex1s+7q4j5jryck79bzQ+2mKKSLL86z/hqvuAceVmCnvNI2gtkD+94jyJsI8yeyRjpKRiAyolgFbQTI/4QJ8pKo6FXHl5qZr0alscyaNYXjyeEzIeg1ACCsZX42tu6TDu9rAd0idMnQQ+pkkWzce1AtNHcFY1Z93TJ6ZQYnC2wyHCGXE+UCaOB9NYDjczUCIeUr1NddpWb69c630wgN9coRshfJPNwa/bPvefUQuQ2wQbGClINaMrBbztBBRPX83HEQ01XkMtu6GLkRRV7uWaFP2Kpa0HSs3fpYACjdWQT63rzbJaY868nJCWYWj+jl0pbyGn385zIeE6WgVrDaUV0ci09uGae9XqT6zxlnRRa+dIJgpYfK/ZZh2J2UaJclY14cdQdcT34Ioc2Vzp/95FCbzQJOGdtS+5gaH+sd29DvT9HJKod++Hs1WCkDbyF5d9qZoUnhUHu8BVaHV93WGUrw9p+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ddb2f2-c099-4b37-31ce-08dc9f43151d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:42:44.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPmSBIA6KSaUN08CBPSehBEVMPcB2UBtyox7FqqxhoevzXcRg8FiGi42HI7j9dkAgy1u7luRtwvKgc3DbfgEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080089
X-Proofpoint-GUID: 4Vq8wO0UQKHSTHOYwNZc4tYVVpBCuhVo
X-Proofpoint-ORIG-GUID: 4Vq8wO0UQKHSTHOYwNZc4tYVVpBCuhVo

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add RWF_ATOMIC flag description for pwritev2().

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
[jpg: complete rewrite]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/readv.2 | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/man/man2/readv.2 b/man/man2/readv.2
index eecde06dc..78d8305e3 100644
--- a/man/man2/readv.2
+++ b/man/man2/readv.2
@@ -193,6 +193,61 @@ which provides lower latency, but may use additional resources.
 .B O_DIRECT
 flag.)
 .TP
+.BR RWF_ATOMIC " (since Linux 6.11)"
+Requires that writes to regular files in block-based filesystems be issued with
+torn-write protection. Torn-write protection means that for a power failure or
+any other hardware failure, all or none of the data from the write will be
+stored, but never a mix of old and new data. This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
+The total write length must be power-of-2 and must be sized between
+.I stx_atomic_write_unit_min
+ and
+.I  stx_atomic_write_unit_max
+, both inclusive. The
+write must be at a naturally-aligned offset within the file with respect to the
+total write length - for example, a write of length 32KB at a file offset of
+32KB is permitted, however a write of length 32KB at a file offset of 48KB is
+not permitted. The upper limit of
+.I iovcnt
+for
+.BR pwritev2 ()
+is in
+.I stx_atomic_write_segments_max.
+Torn-write protection only works with
+.B O_DIRECT
+flag, i.e. buffered writes are not supported. To guarantee consistency from
+the write between a file's in-core state with the storage device,
+.BR fdatasync (2),
+or
+.BR fsync (2),
+or
+.BR open (2)
+and either
+.B O_SYNC
+or
+.B O_DSYNC,
+or
+.B pwritev2 ()
+and either
+.B RWF_SYNC
+or
+.B RWF_DSYNC
+is required. Flags
+.B O_SYNC
+or
+.B RWF_SYNC
+provide the strongest guarantees for
+.BR RWF_ATOMIC,
+in that all data and also file metadata updates will be persisted for a
+successfully completed write. Just using either flags
+.B O_DSYNC
+or
+.B RWF_DSYNC
+means that all data and any file updates will be persisted for a successfully
+completed write. Not using any sync flags means that there
+is no guarantee that data or filesystem updates are persisted.
+.TP
 .BR RWF_SYNC " (since Linux 4.7)"
 .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
 Provide a per-write equivalent of the
@@ -279,10 +334,26 @@ values overflows an
 .I ssize_t
 value.
 .TP
+.B EINVAL
+ For
+.BR RWF_ATOMIC
+set,
+the combination of the sum of the
+.I iov_len
+values and the
+.I offset
+value
+does not comply with the length and offset torn-write protection rules.
+.TP
 .B EINVAL
 The vector count,
 .IR iovcnt ,
-is less than zero or greater than the permitted maximum.
+is less than zero or greater than the permitted maximum. For
+.BR RWF_ATOMIC
+set, this maximum is in
+.I stx_atomic_write_segments_max
+from
+.I statx.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
-- 
2.31.1


