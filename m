Return-Path: <linux-fsdevel+bounces-38816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3DA08793
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA02B3A9EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDA20ADDD;
	Fri, 10 Jan 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AqfVdM/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E80207A11;
	Fri, 10 Jan 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488935; cv=fail; b=T41ikMS6duKERDCUAb3A6pXAOwaOSNdiDa5Ba/rUTJ/WJOLnzLEvP/vPHAH5hkO+0JwB+FBoSWk4ZbrHkiwBb4aVip+LDoT9VKSJJfw/oA1YiGBl7TZsxRwLhc/aFvaPsG5gqtgf9rTaiKSdgAWEp0PcISDUifdAC73dDmtTSFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488935; c=relaxed/simple;
	bh=/9nCN1XQPfgyA5VlyoRarJnrFqQw20cJtW1L8P7Lq0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAtpVjrZNYeD7eEIwklf/hfGwVBJ4jKJORgfHCnvLrg/nD7Zh5FFlHPVYI6NWkZex3kyHyyb4fwK2+xNIBifOnLqxrLY9MPCgq5UdCe5vFjRasiIKsD6nf57AiyPXzTsmOTsaOMlT1TUHSaHKorfwRwvSP7MkcGyH6yTuBhHdLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AqfVdM/m; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjBF8ito/6q38FAFc8vOMCYrexzqUL0ZDtxLBj6y5T+pBOZx81ISvM8Rg2J2gSufssmCsnbMnKUICUg5SbosFmtnBGD984B4ZIWWokPMYMdY+PhPRsyznuk9XbUACxhsYILilrW4HotnTNzArW4kmryaXA/yukMJ8kXjw5ZwC156LcslqSF+B+7nhoEXW1KBtahbPvsSuPVFz+5xfKg4z9NK703GvhXQlwuK9tySQY08lybPm0Uu9p+KLsWJICxOmu8P+x911n1yAHV3pqf1P/64n10d+nwRnwxuxmBk4yRCNSWO3WmWfXI8d8E1cA9x770NKc7uFcokiu9C1ZsRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=nS0cyd/qcr7b7UtW2mzo+nw3yr79hmAEOl7Wttjg2EUat5NUPedXSip3DL/aRJr+0Xl7gU2GODCF6RHKDkIlXBnxLNI4rokJ6ezlGtYDw9rlj3vA/Ekcg/4JJJTFac6O0Ea7hzytFCuuV6DjAaDXbkY3CUKwccEjHgFh94pMpNxJ1hCV18rk3afNx/VH6srzdnqWJRPJEW9mEgU8pyzs/dJZBURJ/Es5vYw9QNOjMG7d/S2ql/2oGOSxqDAW9m+6H9mFrJrSVGFxBYYjuDU21Hv6dyvMi0INpg2fy2pgGfDHdulyrtPKVzjHHpIWLZtWEE0IvME6qzf/Poa0wpc46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=AqfVdM/mgvGt5dI+ySgrmOU67rk9XK3lN0fnv0zhGkNFxHkpoIOd/lAmAAfal6fDuL8RDpDziIXb0qPyHFruTPBA/LJ97zk0VfflhkCuOXnLF0NKeiKnuZA1Do34vEpeCTjOZ/htQkMKdSFp931LiKA5oqulWDZeMx28aRKyiRmwNpY6cz2SLwQbT7riRlzFQPangSodNTbN46jE2iLQ//3uHRfNdxeeEDA2eoOqhGNn2jjCIwTeYsGbihDf/6uUShhokWbuyqK06u+yNxf1RJfa+lcANxtBYzB8i3p11p9RcUyyxpsUjusgkAhYocqMGNFQ2+0LXjg63rKUFtit/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:02:11 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:02:11 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v6 10/26] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Fri, 10 Jan 2025 17:00:38 +1100
Message-ID: <4f3fa1bb9cf4402d6131d0902472d8e9bae52f88.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0022.ausprd01.prod.outlook.com
 (2603:10c6:10:31::34) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: e59be270-d62b-45f9-3ed8-08dd313c52dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sd2dONtYCdATHIVY5dhEKQslrq1sx4o5Esyp+n24WLRDVY1kW3TPb+hauDrL?=
 =?us-ascii?Q?vBrlFqE9FcP7mm3Xwt/Qg88Ump+oye675Lx/XL7twjbYUJ6yk3aEXtVlX7zL?=
 =?us-ascii?Q?75a06cF26UUivGfB1I9hXJhMrTJCPMUVbuN6o4WIHKmVnB5HcMayGSPg7hCr?=
 =?us-ascii?Q?RobK1s3Bzx9sZziWnMAKlWNfs51gTFVL4p4C10zD62KswPIHu/V21FAVsmHP?=
 =?us-ascii?Q?acq/KqyyZFOf5YDtpGynvJsrvgH1frHrF0UpSdMLNCnWgXN2R4m6GLKDdpZ2?=
 =?us-ascii?Q?jqJICm21QSoOaztib9TQ50XBrhFDCS6+FOXmaCHg90DBDHbwM/h+0amXbGSb?=
 =?us-ascii?Q?nMci7fxTvieDu5NGzL/Y2PMeYZHA/o7FPdxbQhXbDMh0NPuoyzd6SWaA1i43?=
 =?us-ascii?Q?8j5kNaT/eO4Cspy+7uXBZCB0/XNTs7zd9kYaUxWJ9CuzSHm0qNHSkktEtGQO?=
 =?us-ascii?Q?EAstYuSUghsF66LEsJOHN29x3F+9OAcZBEVrFJbLdmu74eZRr3poH/u/yis5?=
 =?us-ascii?Q?1dPJ38oPHaW7bRO/LPjUZvVqabHMhOi+el5WCq2CB11dbZXy//ES9tudC2fF?=
 =?us-ascii?Q?rdOQLZNtqRTFi8kfGxMs93dYPg2F2nD+GPDjx0qQwhBcRoYZXZeN3DtztQcc?=
 =?us-ascii?Q?6BpjSzIZ/iaJfqa8XkdyTDMAbFrv+pX1IfX5HuOefwM/gsqnUUXyQDi650gl?=
 =?us-ascii?Q?eviss7VEjrbhL+NjvldzRz4EU32JwBiLuySL1lfRQIfDYChI4vQrAIeADA71?=
 =?us-ascii?Q?hehi++ipPGr6eMHRpahTBX1fISaTvWtKCVW579Gtt0ZMRj99+ov2ZM7hNaMv?=
 =?us-ascii?Q?xwvswzws2m3AmGsvt3e/bd50WfQ2u+KZQ93dDZhvkdNhDd2hSKyUv2HYxKdA?=
 =?us-ascii?Q?dH/xgGXzo0kcJw/67Qj1prx50j77gJ9JeU8HuS+w6gnVyrmN30/RiPlQa/bz?=
 =?us-ascii?Q?2vGZI8TSatXDmTq/PYaiN6+YUcjeTL4bQlqkojM1lr8Lfy4y4AhWgXWxT9RH?=
 =?us-ascii?Q?MeokHjemdsHPmV2bJenmgHyefQ2ku8j1qMUOOywA2TZvYjsUU3uCbHCxLS9x?=
 =?us-ascii?Q?LT/sMlYx+w1QXO3UTCHcT+USBtjBnkxaBKLwX1Dkx9eKr9i8Y5v+OHgDzVJA?=
 =?us-ascii?Q?VV2NN9jNkOUMNOTGT0qJqzob/TInhHpUA2OadmBIBNlZKBoENlLNjy9i31nu?=
 =?us-ascii?Q?ye97QX2U7i0hCJtoBQPSkMbvw8JCxUES3l0gs6kdFr9Cd7XJGou9DpcDt3rM?=
 =?us-ascii?Q?9gdE9Be0Pvo4G0pdHuLil6OVHsFPTg0JRO5jAzmNAET9YQakoqkQWkPnEFYD?=
 =?us-ascii?Q?twhf880NOcznnf33px9TxrbU22s5GywOYLesK+vJRmJxci8KrF3MlKOg9ArW?=
 =?us-ascii?Q?jdsrk25UwKnQm2WrUQqXzVrjtG0q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reMOE8NY8LL0fIfZs4nKfQbGc0q1CNeITk3A9ALc8ZyuXgwXpukZQ322sPS/?=
 =?us-ascii?Q?Czs51R8iZK7XbrWh12XEop5QQkUl66sS9qkLgDaSpNSHgpbTDnMn+DKS977A?=
 =?us-ascii?Q?0UK0RR98Clqm1dboxrgSybFsPHZTSYWC5DJtvGI+AL4LHEjrnfT+0Is6vwDN?=
 =?us-ascii?Q?/F/GjAgOhb/B6sY3qgzYgc3Q4fCPCysYkIlzwyHOrmLI48awG7hpqeOTDRHO?=
 =?us-ascii?Q?ObXvS8dLPIGjSLkNmMnFF2MvEk+lz8adwvBSIDKBrXhEDSvwxdVWdzSA34pS?=
 =?us-ascii?Q?y61JsDdMshjoxhRnNRs/c88msuOF0bsP96nmxl2WMr2SCiCh0RUJyKZsyLS9?=
 =?us-ascii?Q?KliTsgHZ5un1MkBaxD4ZD6DncLx8lRHpjuDoZiidlvVySOYM0GNmcKFYrP6+?=
 =?us-ascii?Q?b3spQF+5oPtrsSQPoFE/B2eKYL247JAN4teebECKdzBGSg1T0iCLYVEmZk97?=
 =?us-ascii?Q?rBTcb5BXtR0Y8zKmGj0h2QxI4p1O8pUHCw+aif3PXG2klhBrID3Uwj/PabhS?=
 =?us-ascii?Q?KD9t0nnsQBIwWmqPcPMLFq0ByFWmLg2hCaceUgWY7sUFbTrVcoOkJ3tmFyCm?=
 =?us-ascii?Q?hWwfjxT2Ps9uZoXGid/aTFqjXtSNyU7jfRq1H+SDm/TzxrA8OZe2UztRUpQF?=
 =?us-ascii?Q?rybOaY251Wfu83cU3ycieyrPf6RSC9VTiFQk+s29mvdnU83TsBKD6T9sNfYo?=
 =?us-ascii?Q?BARsmmIfGjEpwv002cqE6cxTDXsmH6urrUq8T+5pq+hrX1CFNFAovW8EyTLQ?=
 =?us-ascii?Q?w3+fFmA1pNb0QDSxxcFMub3EsyG/ix/6F4xXyly0HFi6rxiTKv11H0UqTgot?=
 =?us-ascii?Q?q74Zctq5jaxSKOaQ4IWjV18EuFaKCikuJ9U/r4btCk5G7QuUNk23WO/ElmVq?=
 =?us-ascii?Q?yf+caPf/NLQ5v7QRJOMfrOm/6jnmV/L7uTL92HLxJnkwp+2ImkEFbHInkOSN?=
 =?us-ascii?Q?M7AdDBISYKcNKN0JcFg+OA9LoUMIAXtHwno4DCwLSMhrITkuAxeXBDMKLtF8?=
 =?us-ascii?Q?kgoILiYRLcYR3m6fD7pGMngX4HqixR5GDlKtkZKuEAh6TfZnobYhpm3alZav?=
 =?us-ascii?Q?jc4O+3nNwVs1vep/TCoJmtPd28yP/cetAGKeEQwrqD7ECuNqLjzEhFhqLjK9?=
 =?us-ascii?Q?VgwtTq3ycGOJTRIriOEr9MBIvWtn5K1FtuTAI5O4yJOQmdrWJ5duKNMenb46?=
 =?us-ascii?Q?y7eE/ohzrRGDCz3GOASacOjZRhT7g1zArPsF5CFwzeV0hSKg67fnr1HkRzDA?=
 =?us-ascii?Q?X+I3cgy6Wjp08iTMW41hQbqTdLVYJ37FRIMEP0Se6HwMc2hXmxXJAy00QGI6?=
 =?us-ascii?Q?IOEaCqQ1djY/P57iH0fvq6sUOxiLF+J/qAZbNI8+s450veTHElwqDqqsGezO?=
 =?us-ascii?Q?6hGV+WswfsvOqd8+RbD3TZBO8Syq716jwrBj+tfIrJcjvun8/yJFmPiNy9PU?=
 =?us-ascii?Q?5q6FpoYFcZdzUuBuwcf5rnqB2rPU812R4ttkqOoPNTbEPAFy5XVFEL+zyTjl?=
 =?us-ascii?Q?+pl952KBpEOySMvZBpVXXQkJZwqwR6LayTVfXlpwj5KSA1XNci9jl0LbX2ox?=
 =?us-ascii?Q?KA9KUby3T5xJT+KmODwZlbFhhFXqbVk+TmFOj5RZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59be270-d62b-45f9-3ed8-08dd313c52dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:02:11.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17h6UKIZ1wuaFhVYIXwCyHIA48WBjjIJaLai5rmBjMdZkwR5VKql9ezlTbqLAHdaAG+nUwZWhoat+zIEi7ClEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Currently ZONE_DEVICE page reference counts are initialised by core
memory management code in __init_zone_device_page() as part of the
memremap() call which driver modules make to obtain ZONE_DEVICE
pages. This initialises page refcounts to 1 before returning them to
the driver.

This was presumably done because it drivers had a reference of sorts
on the page. It also ensured the page could always be mapped with
vm_insert_page() for example and would never get freed (ie. have a
zero refcount), freeing drivers of manipulating page reference counts.

However it complicates figuring out whether or not a page is free from
the mm perspective because it is no longer possible to just look at
the refcount. Instead the page type must be known and if GUP is used a
secondary pgmap reference is also sometimes needed.

To simplify this it is desirable to remove the page reference count
for the driver, so core mm can just use the refcount without having to
account for page type or do other types of tracking. This is possible
because drivers can always assume the page is valid as core kernel
will never offline or remove the struct page.

This means it is now up to drivers to initialise the page refcount as
required. P2PDMA uses vm_insert_page() to map the page, and that
requires a non-zero reference count when initialising the page so set
that when the page is first mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - Initialise the page refcount for all pages covered by the kaddr
---
 drivers/pci/p2pdma.c | 13 +++++++++++--
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0cb7e0a..04773a8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -140,13 +140,22 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	rcu_read_unlock();
 
 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		struct page *page = virt_to_page(kaddr);
+
+		/*
+		 * Initialise the refcount for the freshly allocated page. As
+		 * we have just allocated the page no one else should be
+		 * using it.
+		 */
+		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		set_page_count(page, 1);
+		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			return ret;
 		}
 		percpu_ref_get(ref);
-		put_page(virt_to_page(kaddr));
+		put_page(page);
 		kaddr += PAGE_SIZE;
 		len -= PAGE_SIZE;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 24b68b4..f021e63 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,12 +1017,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1

