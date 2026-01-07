Return-Path: <linux-fsdevel+bounces-72682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FEFCFF934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A9C2301785C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9C35770A;
	Wed,  7 Jan 2026 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwa971Wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01F3563FF;
	Wed,  7 Jan 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812068; cv=fail; b=prR0SiC6bb+tue1ScdLJCGkGAp+5RXj1Nky4c45cXPPLdA5fIuY0Ut4A4DRZ0O51LI9ExDjptj8o8TByHe7s4B5cOxlWLN/FdgQpiCtgoGpanKFGSnJ1oT0E7UbN4VbxywzfFGXIX1MDGBf/QoZIGWnqmeZ8eJfgV1dEicpYCyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812068; c=relaxed/simple;
	bh=CFDt/o2aPpNK8yx0uXRSRhPuDSKEo7LUpwki5HvePMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGff5gX5RJEpVnDGAejPc7CQqNA3QLftshX3giDtuKhD9iqLv8DG9SSOZ+djcSvHFeFmjm7gp+qGlgLFpJET2HSBbdOkCHoFALf9E3zVDLKyUWQdKR1SYAAdib5MRpDsqIA9YhMGizMlwH/3yaCkHbHYwRLbOcg3D2UFLmmt3ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwa971Wn; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foRajzVdAY+Avrsg+S9aFCjLTl2d9Ma+Q66BK2Whf5roY0kyvtHD643xNcwD7PAcIm5Q/877A9n7OOfDj1tUXCkHhu6Gqr8vChtpLJf/FS8GSV13H1WHKpfxkk1b6AOYMSXS4XJVr2KVE+2RPearpB7nZHBTkl6VbwMqfFns2pR1aK2J5s+sMDt5BedBxdwI5CR6Lj2oz0KxxJR778KN23JAJX7hHmGvlRQtQMssTnLBrR6M2C123IFHJmwrR/JJ+umXFOnBArajc8y7q6zOnBtQq4ZF5T98qtuaEpSz8gR7PNc4kSWLLcWTSW1/L3ni8y1k3xB8a0HY6YYDfd46gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MA0W0uY1QAwMjhhxU+rcD69xM+ngKVCJy3mvsXaUGw=;
 b=KFo+bsIQ77DIv5TJTT7sjBnYqcWI2pYuVQ7dnz1U3PxHWXzCg+oM6hfl2feZRszklPA87ZTJ+HVZJcMcDxyVg59TNS35naSNXsbKl8+cQENgMbhHgp8Jm6dyUiSOubNY7ThxYcaGgYmzClQ7N5tqjAHPS//2AJMRTjWJo2ARzyXMksPSKUC17ULQXcUqmZiSYryi6a+UeuStD6P6BnU5AMfBm7LH3ggpl3SkEIvn7+ei5NJrZ2yIoJZYs9PoS7S8P3ar/PsStUBlYOrAJOu7bgPlZ1IW9L7ipvB67Ygu/skWLl2Ku7raoh8jy3JkOeQbbgCgvosO5pfiIdCphtlpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MA0W0uY1QAwMjhhxU+rcD69xM+ngKVCJy3mvsXaUGw=;
 b=gwa971WnAwHIvB9Cc/GK6CzCoLPbG++irBIOQd16+zbeNKC+LBWr2el8TdPBFhhTt7ekDef5POT7EO62Cv03HpgG7S14GL14DwvtL5WTIs8XbC3SmUjlDJnqxLuO/nJXijM//aeGGkQhDu48Uq5qbIwWnvShUruGmw+2DFt6agDPeX01PjWVdJi/3i1mjIvq2lH7j8Vhae8W3wy9eEOwaVEK+gb6v3DGlevw46avjSapSeMmnlPqqXi/WJCk4UTG0IAaQ8q5Og6axbDMou7apsu3JE9IiTXl+B83fZnvmjBnpAtmsv25oc+elot3NWiiczjdoAnPTJhgsil0yeGajA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 18:54:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:54:15 +0000
Date: Wed, 7 Jan 2026 14:54:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
Message-ID: <20260107185414.GG293394@nvidia.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-15-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125165850.3389713-15-pasha.tatashin@soleen.com>
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: a0be14f9-b8cf-449d-fba4-08de4e1e27a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qAqjrEq2YuJaKN4HcB0xuQnysd46suVITVM//B0K39qhrjCizlEgnPYIWrV?=
 =?us-ascii?Q?21ivh4OQXFFqkT0vrZS+vmLJ0rruVVMO29QbUrJ5AeX0knXz0vjFXOBRMtQ7?=
 =?us-ascii?Q?bFR2DblMouUMuUUz1B0VrxM+LdzkCi9cF4JNKuzInpDwNgYxGmheuOrhpiuJ?=
 =?us-ascii?Q?9Rv2dXkbCxZGFZSwm2XfWBVUXkhrG1J27kX8V1D44WAgnAhmgSf9FoC97k2Q?=
 =?us-ascii?Q?XLITwxGjvrJeRGAanN0saLnCFRZjea+Fg6vvtLpc77dhPHWUDQ3cQhuPf94k?=
 =?us-ascii?Q?wAV5fGOjkPkQBYN4c5/GJLLAJ5X9aQAuO6LVEhffjzMxZstCyIC/rk7qAfge?=
 =?us-ascii?Q?7jmb0U46fDkKmSDVu2upyX/qdv6IUWKYwmlUM0zvBIl8K/7/22CSyYpHMFhk?=
 =?us-ascii?Q?Z3RoLut6YRyKo3gnOfIBP5MnHkZxfFJfpSlnIrslnvE1gX+44fE8pyiP1ixX?=
 =?us-ascii?Q?lhSwzMJH3utWV1gqZ//9Tpmn0wFiEkB9iNJYnptIrGdpJ+f4lRGkgA1JvYkg?=
 =?us-ascii?Q?kI/itxu3IqBrk8C5XWugInAiEjoXTRdcW7F2qPdGk7NYaMhrhdmZawr8q8KR?=
 =?us-ascii?Q?Cd9wzxoB2qv2xjmRbgjU2+hcnzVFXqkHc4fV2SJcwn1WUvpF/0splv+pDd3z?=
 =?us-ascii?Q?ISHQCrRQAyxriEBWtPzy5/c686A6dhcHa2eWzCx33iubNJDey4dZrWDxaB6d?=
 =?us-ascii?Q?fMsIy6VaNgLy5X9QrOftKd/+U8UUyhx52AFcX7dBuLd415OvrU5vdsOoM6Z4?=
 =?us-ascii?Q?QA9w0boSd/qsoejWsBjbek2lTn10fZ2WqOmInARL3WvlFyRONdJcS4p/jWg0?=
 =?us-ascii?Q?vyykx+Ej05OYapLVUjV0MoLcTcIYsduE5r9pOmjpaOMqWrsVNghs/gMtpWjJ?=
 =?us-ascii?Q?WHHnKgBD8mfvXP0YQsWTEX4sEeFio6v71gu6PcdKyPI5PlTSGktwlpalNtKg?=
 =?us-ascii?Q?3BzWe4mWq/CLTGJPOhDk9W6g/knFIyypvz88+A0pqxXHYzNTvrUC7jhjShDu?=
 =?us-ascii?Q?z2JRyTz4XcAZuUrvOltLrztzd9eEJkmPxLLoFQyDMSQWmtK08OOu/DyH20v8?=
 =?us-ascii?Q?P5db+AtQ7os6XiUNoab+iX25TjXvjGua+5C5878MMs5y6GKCWGiFwKgXOX2u?=
 =?us-ascii?Q?f0ThXu4mXPjiqFnmBqLzN09oCUJoPtnHOOnP/Fd4xpQXKrHneJ0Bp3tBAy8n?=
 =?us-ascii?Q?R8znENYuL10Jc85oOuIKty/xL11AEq+jaipwqfOuLtpYjwr5Y54K0ieTVKFA?=
 =?us-ascii?Q?WHHM/qS3TwvuIzhAUdPmJYx23TW7BXa0fUTh/JR7IRus/56rcgPCYKFDQYcH?=
 =?us-ascii?Q?8vz7xfFkorjX/6/veMhY7ld+S86+WX+7FLiavtU7d6zTTcx3viv9Zi33jWp1?=
 =?us-ascii?Q?Br2WTmdkGh/p/xMx8ZPNPQFmLb7StKS2HyF1Voq/0RDO2BpFQ0c8A7kcvYg9?=
 =?us-ascii?Q?91WCRGiSHTol6ZREqk/VYlDR+8nTG6ts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?chQPQAtOXF6kxE9ZI1r+3az383CDuD20912scnpFk3fbb46WA2FlJxlnZk0H?=
 =?us-ascii?Q?UXpjj/IsICk6DrNJC4+3VeE3p+MsIjzOkh6W8K8VNmPI+RnYn5mAnKWyvcdl?=
 =?us-ascii?Q?HmcK3h90ETOUW5R9DjxWesrGP+t38j4ekt/ky1QhY+JzE0GlKFO2VF3rXiUD?=
 =?us-ascii?Q?Rzt//FS8J5Aco1l1uuKUm7lOtI/A4ROwe4dF1Yvmb8Cqg1zJdRHY3ng1NUja?=
 =?us-ascii?Q?EaNaeVX+EkcANFWerMfb2+G5HHDuAt3ISfKRR/vs6HhmGmiy5/G8nOi33BkL?=
 =?us-ascii?Q?vElwr1/wF4CQ917K8lWwjhk9x+kTYiQmN0Z8vf5iMrKTA+T1/ku8VuVfVMdo?=
 =?us-ascii?Q?kprhZBfjlhKN0GKZSDjNZ1N9mbAZqV5VADYgyfcOSCuDNGu1MIJmAXzVfbUi?=
 =?us-ascii?Q?KqMRtVi0AgoO7AmXEGF/2oakX8ACZgxOIA6VNE85SECALQgvGENK9G7MjS6i?=
 =?us-ascii?Q?eZ3yQSP9z4Hsl8mz9dLwErdFFqSOD960Sf8GDdPELVSOtf24jvTwnxcsn3mz?=
 =?us-ascii?Q?Z7uY2amnpW10SWJflrlL4bFSZINaDbFSgWYsisVr9T+4Lfto35sKyASiDclO?=
 =?us-ascii?Q?Hn8CvU1u2ap8rv0019sdW41a0ixHfAKDQsxH91ChtmLyHUlsJOrrThqmQG14?=
 =?us-ascii?Q?OTIHCjYNjyQ/SkjCLAt/xzcjTMqIDQro8yZPy8jyGFI1qGfBb5gxtj/NZtEP?=
 =?us-ascii?Q?kc/+4az5KdQaY3SGnmhqzVZSSgvZfm4/e6y+8s38RvPdg3I0R+17JZBDrgOb?=
 =?us-ascii?Q?pIr7pKPtIypJd+TWb3Yit1YJwS8nRJQK8zeVLB8fbsPKZ8EbOkObK585pK/t?=
 =?us-ascii?Q?lF7daEbKWC5hIJ3hvvFtmuuS4CuANs04MzHNAPFURWiaGj5g+gzu+cbJSwhp?=
 =?us-ascii?Q?AFo4biTCM1oDTlx56QsKSt7H57DxHmFXiddX8W6OEwiS0p4/avg6kkHu3trr?=
 =?us-ascii?Q?QE5z3gFvb0s2VRJp96wWUHfGgKtZsycLLTAIBCtc1wHDMKz5pAbyrWVKWDTt?=
 =?us-ascii?Q?u2brxcbsuE3x2GZC6TM5LH/+NcEvHrGFCUIrrep9icIDqoBfnjvRrCIloXiS?=
 =?us-ascii?Q?SkhGLa18zRg1+gdDDdoc8JZaT2KrhVj1OAl3UzyF4R5ByVtVu9xfjWORaIGQ?=
 =?us-ascii?Q?m8qP9zJjO/ofIDSawrXKIqWVRufFiFRWrwkbvwop3S8rDFBdXFOfTFpaMqr5?=
 =?us-ascii?Q?zaILCzrrINJe9rpJxqN7vYOUcewhQbckYHDzzxx8jMXzjkKsE5EnIqCzHWu8?=
 =?us-ascii?Q?I1qIq6F8Cy2dAh8wniI7HPYC04bfxYRLnO5EQu3CudksIGcsgOZ4fv2cn2dA?=
 =?us-ascii?Q?9SeIYjvMiKBlIGDuSvSjx/JQi7juuLlNkj+T5twXKes8ksFnuxUqkqPeCJ6E?=
 =?us-ascii?Q?SvE/4H2WQUoFpkN7sUOq86ObtoN+XEc/YROOK5vVtnk1nYYBuCmx4UpR4YeY?=
 =?us-ascii?Q?CtguVzhTgJftXcOB9wLsgpDRsnYFpUBg+m3bGEKZEsLTV8oc29mJEDJsCcF5?=
 =?us-ascii?Q?8LTiowlVRpM3uRj7nUIBZCBCBja1JtMEIluYuBVLFphuiKcTxkNMfOaYJAKt?=
 =?us-ascii?Q?CFbzbqj3SVd0scDWY1/rfVFETkWtzVv+cCb+Uec/yGk4uieJEniuXwubhULl?=
 =?us-ascii?Q?15Nx4FHV5KxBkORWVV5WlC6T55Dg8VFTAs3gWOfRKPumfZzYjz6hRnxoTpQE?=
 =?us-ascii?Q?vVdgzRIbmSjHTu5G8o46Gv9WOjaIOv95dnQqvGhjIczc1nx4MX8nYGVVM7J8?=
 =?us-ascii?Q?q/lMKMrQ3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0be14f9-b8cf-449d-fba4-08de4e1e27a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:54:15.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzQZIBZ75FJVCpk5+uu6XopuxmPdi1NBGEr4MDv4QWAT+q526gG7qaBqjI1rdQed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

On Tue, Nov 25, 2025 at 11:58:44AM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> The ability to preserve a memfd allows userspace to use KHO and LUO to
> transfer its memory contents to the next kernel. This is useful in many
> ways. For one, it can be used with IOMMUFD as the backing store for
> IOMMU page tables. Preserving IOMMUFD is essential for performing a
> hypervisor live update with passthrough devices. memfd support provides
> the first building block for making that possible.

I would lead with the use of memfd to back the guest memory pages for
use with KVM :)

Jason

