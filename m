Return-Path: <linux-fsdevel+bounces-42044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E058A3B0C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFC518993CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE21CAA81;
	Wed, 19 Feb 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZCh7xZDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4D1C726D;
	Wed, 19 Feb 2025 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941581; cv=fail; b=aNY22rg7qi9q2uqRvck4W1dbveZc3RDThqqp1MxQQRAG+LABK0Mnah+Q59mQdalRuokrh2PBvBHJOfvkArEDvCy84NIXxBXHFBGVWHoAEPQJPRPrp6HnFrBhvWgVnTiivv37ejSg1gNBi3vHCf5r3ah18HNK9wJyVuSj2G+51OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941581; c=relaxed/simple;
	bh=znjNBWkbWK7NwDClisboff0CeUV4mfjAzZhevNoG7ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZsNkrLSHzl7lL7btHzMUgAUO/Wr3iJIWlxR7LisCmf4VqAImKQKKnOUiGLC0KEph14oAtZf+6AKKqbk/qYxcPP2u8QMrqEJGJWFRPsLYbxvHt2HUu9CJ8iUb+3CMKaSgG2whbWPrEN9kmXwVgaVVk2BTFY/LqCd8BU1NDKQ/7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZCh7xZDl; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI9kKLfGGVslr0PS/ovmN6XBR7l1rOOVlbBi42qgILVblg0qNx3jnAwF2OZVJiynXjWalYuwuWxVZH6ci3KOVUSeguqYw1+4Y4bzvPodTubdiDGv7rpqWdwwAKQP0Vfok3gq68n/hqLEx1DufZGKpE6Lc5IRXZrHA2Qb9kqJdOrBTYks+yezaj0sSYULRCwNW8pux5l4dkp5d5LaCuXNDRLY5+6Sikz6z5KpKRJ2trQONgVwJBm75UzI21AoCNw/GdeQIzvrazju1vh7Xpp7Ixh5fIdSMx3GH8ComrKS+ezfgDA9V2RDOnZb399Dro3QN2L5NoP8pz16tEqKu2/vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMS9zyNRN1MHtk2QAbEU3QXjdKpELOm6Q6Jc22PCJfc=;
 b=uMLvFIJ0OaMjUOCjnyw6AmVA6qR6sy4rWIjMypEY5BpGo34pbFXk3khz5KIABYuk/3UKjba4ztJtsW8ikNdFFL9TzqgmrdMc2joA4WwTL6u4ZopX/X5qOp8K5fFHJeJPPZ1dO9ijzNpconAxF378HgCresPGluf6c9uAq+A2Tj8UB8fsx6o8/G1+5pTqUiYsThToo2kbTs70Lc5wFz7FHlrUgUdpliBPdxlBjbYiLLjl5qktpz+serRjpxRj7CXF3ntz2YG27vSX3ckMMq2fJZktcJ1pTcZkbFOGMBmQIkzxNj7v4e0IMQA12fJZDnnRB02jzpCDYWWF8xe9CMnZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMS9zyNRN1MHtk2QAbEU3QXjdKpELOm6Q6Jc22PCJfc=;
 b=ZCh7xZDl8Fh+hosS925IFUKa7Scyw+HtUFZsNWN/5PQiEPSC1M8iyjuWxBrV6c0W1PxCYWRRM50hAO9iKNflNmF3Mf9+CwzQTg4UNFiX7+K9qKL+BtWBhjoEGj+sFwo2vHx0U8LXR1m6pfxsCGLlJLuxyLQsycbL9diksUOIAd178SxmR3il/V9XKdnhDPHHl/nOfKjbnbsK/EXDiyBiHTYVgNnI/kBjoL+B+8q0rBNqi/4MqA3Vn8mqvU/NQxanZnkFQjmjRwbGDj6doYdk7KVszUIyFaZGx3RhFZ0U/yPjlK+Ol6IB5v2aCJwavqJPWWrD7DaiDXeSaXs5kheGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Wed, 19 Feb 2025 05:06:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:06:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com
Subject: [PATCH RFC v2 12/12] mm/memremap: Remove unused devmap_managed_key
Date: Wed, 19 Feb 2025 16:04:56 +1100
Message-ID: <7efe718b19363bfc1ccd75c558ba9e5fcd94fa0c.1739941374.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
References: <cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0077.ausprd01.prod.outlook.com
 (2603:10c6:10:3::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 9905a869-c10b-4c02-7cfb-08dd50a323ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2NUe87OFXfTmIA6AuTEUL98knjV6gxamHmm6u4Bh7BmfNcdK5megCdOp8u2K?=
 =?us-ascii?Q?P1bH1jkP8naztOntBNQDyKU5AwRHwB9sbdHGAu415/s8ZOWwpQdKd2il1111?=
 =?us-ascii?Q?bWokYB8dpCbEPTJqbu0EvGYysIuU0zBLqXGeES5Iif2ZoODBjjT+iBi+1xLF?=
 =?us-ascii?Q?Pvq4etEZxhhU4WgEIJ4QNaz5zt1Mhp7CMPKhrm7rPFMc26FQXgjVhtA9ZIAO?=
 =?us-ascii?Q?DzdR5jJDkRLb1Io5jYekBbh1YMR6cfrhWrQWHMIv/pHXY7cH3YAizqVtLoxo?=
 =?us-ascii?Q?6pPPgTfoZE7Ye5ijGjaXlHPnqj0gxvjUNsw4XguRsX8N4biPvpYZiHOMFcqd?=
 =?us-ascii?Q?PibymoWwkZAjw5uVtRjbqbWsx/CIYdxdUf8zBhXId1Or9ZX7YLT4tLneuSa3?=
 =?us-ascii?Q?nDI7fwvgzXuALRiRjZro3sTXD3xeFAfnfJz72X3wg2lzujBBBT+FPCffOWZE?=
 =?us-ascii?Q?hapbz1hCPT+UdAP1xF859p+3FK64a4dd1PctgB1IqO9T4FHTrgVt/vdhxAAQ?=
 =?us-ascii?Q?BsXiMOfQj9g1uWVip++HW9+zlWw40V/S2fUl6/7FMo4evWcP8Udffw70JZ/l?=
 =?us-ascii?Q?NTjAXcCB53FZCGblLAdqTqsS5oPjZqIlN9oydjbT+z9AweP57ePGVl3i2E6F?=
 =?us-ascii?Q?CsmZ6B1G0/QOZBjYeniaAXUT7jsch4uPvl1J47haU3ECb4IKCZTmnxpeL4ED?=
 =?us-ascii?Q?gKYgxQBbp83nrfNFrB3vidIS71oJGC6XoIYYNxUBTigU3US8QRIlLfy/Nh9T?=
 =?us-ascii?Q?whyqJ59x9bWKw/fzodQQHn8AXA2Wacjy4SZig6hbgizzB64JZzqOcAMWkrVj?=
 =?us-ascii?Q?4cahgqHG3C8VoLAIv8r+7n7p8QYeq5E1aamcKychEmxg8Usj64EeswHQvvfP?=
 =?us-ascii?Q?12ScSTBbysknBhBUFqUhPg2HLMEICJ2ZDjI62JgHH20FNxD2OO6TqL4wO3cg?=
 =?us-ascii?Q?g9qbxtQax8eRV5YG43AoWaWTq0CkSs+GZu8jhS32aPkBOpSurgv2lmnebhlh?=
 =?us-ascii?Q?VogNgttogE5lYhq5OYnmctyOFaIgQDWsVZrSKH8KyML+4aJxr+c6BXDsWaj+?=
 =?us-ascii?Q?mHE2+5gZDDz8lvKXbM4jO+TYQ+4jW4LT5Xtd+OsDj3HTZH87koK91MhajzVw?=
 =?us-ascii?Q?vAjty5Rlkab/HTOPV/cjHVDJhNdZ9DWtvxbf8Ss0PhcBD+sP+UbI00RBt94E?=
 =?us-ascii?Q?HbPWwSFzloOL25aDb1+SwjqO0dtzpKC3c+dcAnA4NOeuDQ6tKGgjOpJO2Uzt?=
 =?us-ascii?Q?cYOJZGL3Y0HHI42EzsuyQKbwelidWZg2h9bTZtszR3o8UbyfUBIRVdF1VTdd?=
 =?us-ascii?Q?uDY7jYP3uulwIQZqZE79tSzSZl0U0jVTYjXlNnYPyTJTyBAFLtlv5QVBXcPE?=
 =?us-ascii?Q?/JZVDSPgXd4/lkGOANBH8q1bfqUV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?622uA9HC/etTd+OyrqmXB0khxBjXb8gN4aTH/ViCKcdCyTtNrLS+v2v4sLF4?=
 =?us-ascii?Q?nX7A0o6Piqt2gPvYlmXY7OpXombc9+j3KE5CbZ2wB31hpmfiHOYahTJkyVDy?=
 =?us-ascii?Q?rc6/d+I10nOBkg/1gagtkiGmI9jYZTVJ0jVfQxx6JhZ/9lGma/8vH0wl6CtH?=
 =?us-ascii?Q?wkjXg5vF0T6siE5Umpm78ixt2Vs8ELd+gW0UWwid8jDcU3qMw858v3VrzJ2j?=
 =?us-ascii?Q?ohi23HqUcZdd8CDA1PpA4uGemi2Za4eV9d6PcmI7Gnb4T/xqLCLIigMc70mC?=
 =?us-ascii?Q?Cg1zfvSFdgwxhmhGAFBex9d7tIrLxaVZe1hqlt9JFf4/161wbv0hBhuYz6GL?=
 =?us-ascii?Q?f1C4V4+0pWd39vye0Vq8TrZ56MUSanFJTijfQM1wgM6o+FTmj29eQRTMKtvc?=
 =?us-ascii?Q?pU0G4gsIitX3OU0d1uGeF3lUt87ig87ijwY6KU5qhl6QUBH+bqLIClaYCguk?=
 =?us-ascii?Q?xBZN3XouS2Y7heiCyh0J4BCCxJq6yjqbpZ7vATO/GfZqcuO1YrqEeuI8GJ4Z?=
 =?us-ascii?Q?3i9+PHbhfZhtOvrHmLcBFfvjWK/qXDt63L39S8L3HhC2EFbpNkml/UTIhOjn?=
 =?us-ascii?Q?0L9VgcD7L+YKNirrrz6RaI6u2A/bSA2q1Dtif/W8r5ff7lbn39nbEA7yPYKR?=
 =?us-ascii?Q?SLxzwVQXsxlAyf+ePqhTk4xrJXBZPE/v/T2utfPv2IcOoEYoRzKqCiDTVCrs?=
 =?us-ascii?Q?KvT+vnHKtiJy4TIOKlbJGUUxcY2+B/+Ac2BdA/gp73aHbR9GtwSeO0das1/R?=
 =?us-ascii?Q?BqYcIKF6kYgx7655q8Q9gGkrDONh/nE9gV0FqJqhjj7BtyHfpxEWMIZ367TR?=
 =?us-ascii?Q?y0+Luj1Jus8bm+WSQiQpKwndTCotcHj5qx5YnTJX9iLI2LSwmBfTaUFP9ty+?=
 =?us-ascii?Q?FnlItiKzU15dbhShOHTpPNS71iVXvl5T9+P4WRzREjrhSGj5oF1VLE3rv6Da?=
 =?us-ascii?Q?SbMfNcmvlMXcvFUYqbB9/Bw33D2ouAkRqCLzTCSAUL6LnwEut2bGFKyKQYqO?=
 =?us-ascii?Q?GyRhf338E0+YOjHv0wRQvpXUmfEk7NAVET5NM5/mbGLLEycTmqwkNXszj2sv?=
 =?us-ascii?Q?xnsi8jV8bqvyNDN4bD7oENHFKAnwSoHLsl6w2ovN4kzK4l/uLmSVuVgDXkPR?=
 =?us-ascii?Q?QVP6oLBOQKZn2Eg7LEho2F9IeJjxDzQ/ar9Qm2UYrxnVp66nK1QXbTE+QNqL?=
 =?us-ascii?Q?ifOffkkf57scKW05qHY9KHEYU6IHONYuY4s4PjhvcnT5eLv85pTY1XQI1d4o?=
 =?us-ascii?Q?g0aGihllXPPglX44HCCfNz8VmKXCidsK1Hh3TeLX1U8e3BoqeaFzg5n+T21b?=
 =?us-ascii?Q?SJSN6xeYNJ73OLCNwDrwej/IRWgJfXkN2/8nPeqqAvCTn+0C1PRcg3dkmNqA?=
 =?us-ascii?Q?z+mcC5FsI0qK7gO/B2xpPlW9hgQwN1g9RJaVjyzk1/zemQIWAePT/5tGv5Gu?=
 =?us-ascii?Q?9E4rBEZ7GkcAWfx7WfmSeURbEPvqL/kngu1gRnhi2UwURpfw5W39GC6EDW2i?=
 =?us-ascii?Q?38N5feQe3OK2foFLBhpVu/NG9pQGsqAE81jfJZ66Z4u0ntNEvjyyRgzao5Iq?=
 =?us-ascii?Q?pxk6z5Um6kUMx52Gr0di3fKu+jY7hX0Yi/rq6Skq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9905a869-c10b-4c02-7cfb-08dd50a323ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:06:16.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUA2oxFJlDMcvd1zG0PYCs40+5G+QfDroAK9/5WaQn7yDMUiRjmfhAbkjHjt+mB++FAhJI4oH6VkjJ7KGD/N1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

It's no longer used so remove it.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/memremap.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index d875534..e40672b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -38,30 +38,6 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-#ifdef CONFIG_FS_DAX
-DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL(devmap_managed_key);
-
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_dec(&devmap_managed_key);
-}
-
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_inc(&devmap_managed_key);
-}
-#else
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-}
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-}
-#endif /* CONFIG_FS_DAX */
-
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
@@ -150,7 +126,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	percpu_ref_exit(&pgmap->ref);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put(pgmap);
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -353,8 +328,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	if (error)
 		return ERR_PTR(error);
 
-	devmap_managed_enable_get(pgmap);
-
 	/*
 	 * Clear the pgmap nr_range as it will be incremented for each
 	 * successfully processed range. This communicates how many
-- 
git-series 0.9.1

