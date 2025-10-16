Return-Path: <linux-fsdevel+bounces-64337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD164BE15E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 05:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A319A5CA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 03:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1C321D3F8;
	Thu, 16 Oct 2025 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xch7svec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4921ADA7;
	Thu, 16 Oct 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585707; cv=fail; b=DPRe8Yi8VpbfLfst8QHb8CAr89UTg9t+b5mgP/VjWy2KLdTh12P0+PMOUveGgALSP8URECOiodIGRAXJ7j9UmlC969V28FGXQY+PVGCAeYUxSS9Vu4AhXsr64+HbSehEjUxkHn1sQPG1x6sn5qTy3kgQf8Mio2ilKJ5b+jkvT3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585707; c=relaxed/simple;
	bh=j0yxpYbHKRvtb53QOyW8xJAbj1t3RxcRp0huRDNhk+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loVE7rF5LISD/V7bG+jHqJHc0UMQp/xUMJCEJLBHAZJxftZHxDcwjNKLod6NFAPxDhKw51A7c8x+RBj6CqCgVaglnPdngWSTX8W5gI+bHfzAqwmWVeA+UWENMJHyTr84mYodnw0yQ8GsGhKKhaMEcJ5IYRYCyN1gpoSuQwONBcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xch7svec; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST5jbeuN/9o+mtw3uXZZdcQVZpY/1UIiCqrFrIeg1wFBCPmcUR715ypnhdv4VFYJRCZz2inC2sKFxVd+BcdqQj2DRr4D0C6cLdaCdcJJqfZqSAkSkNAv+7HNEDlNi+gqwXjj9BQLiAtmZwIZ5/l5AKgXX+nb49Uf1YFuZjxBXYV0xsuLiikjuJ/Y1SBEhHPcph0hdgyMRGvAuSfmfGirBB3v5YJT9DqV8kJhBOJqG9d3X4JtNtTyfJgaU5aGs8H6/74IkHNdfJMfg0Bt1qRZ+KM2yyPNWVQccBQMTDyO8GeNsJZ8N3zntXZHra9o92Oe5dXnyzJ/zk2xFtyuHfKcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKn9gX7MGGTwdV1DNMYsG4uUPELySLhyOvhgTOrwNoc=;
 b=HTivu6ec0jw74mNOCRWKIiNWTf6+8CPyQupc3Yq7UGCVhxIsdknk8YHNaZzvxRlyUYzrD3yrKFQ8jQOvZQNVZV5Obw9Xcx1MVoM/CShUI4bkvqqvovZieCLb05sghtfktxzEG2GXmMoszwdZ2zCvtlVpo+Nu727vjO72bgb6UkN3q8ti1lSBSLQHO8qD6b1I0JaC5s+mWMt1GQtVXbxLpZ+jSxQp+Q0DxK3Z9/4/7qDhk1rGJLIbu4dy7TfeniIkFvP+HXv958estMRrZbpNSGN9fjUaFkBCT+X8QPT6jMIw/EGhHsvikDbp5bN0yjSt2jMCBmtDut2oHbs7Y+ufIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKn9gX7MGGTwdV1DNMYsG4uUPELySLhyOvhgTOrwNoc=;
 b=Xch7svecRNAWhG0M9fdqgqMS3QjHKADgy7WtO58w/VVOhud0EfE7rmdRKMA+Cy6KNp16kmy0xvgYyPsbH/PsqWMO0xAwR1GjyoWNgILot8hyy4Jnysc7l1werDMEVnoLhibhPiEt415uecmg7ZA5IXOmZlFuXyCVkwQ3sTN/r8Nzyu+h21/yV+BEGcmtQvZE95ZveH5H4PVEWpZ3iF/Kdz05E+sPxq5eLMhFxrPiH6K5z2VwqzEkse30UAuEwjUo7WRw/MbTSp8rxwLIEtag4wUH6qA7XU2wt5bZn1roWljqrXqBo4/7fSLgccPD7xyiUy1E7HoRavfsHRJL1gJtjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 03:35:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 03:35:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm/huge_memory: fix kernel-doc comments for folio_split() and related.
Date: Wed, 15 Oct 2025 23:34:52 -0400
Message-ID: <20251016033452.125479-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016033452.125479-1-ziy@nvidia.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:408:e5::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb12587-3e37-496c-247f-08de0c64fc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zI+3qW5U7ru9HYitAhS2xpNn4patslj3Ie031Ch+SvY/ocEjmgj+mpm5k3r6?=
 =?us-ascii?Q?Ry/CbOd7fVW2ANI1HLFXvM/2flKpYEfBHOD+C91sbe473CLtVaeNSV1Ozxcz?=
 =?us-ascii?Q?vasea0QK26Aj6ONomO5YivosNahw4e7eDRXCAeLL7mWnGebIS69zo0KfOGpM?=
 =?us-ascii?Q?eaHJ/Y2lcRegfUxjBm7FYZKpqOA1EnSDD1ZaxtJsa1i50STScJhyNs3eN+59?=
 =?us-ascii?Q?BlvvWc2sweOKitHPjY+vv/FbNSqRkvfxfh24QaaCtrDeli2BfEf8ZfS5BblF?=
 =?us-ascii?Q?CGDEFjWyLvPo74CWll/2hpP6PQ7iAYgzkFTDyPvEP24cqrFptgI+f5xdGQ4H?=
 =?us-ascii?Q?9SJz81a4JZQs1H70kYyWw0h/+aitkDg5vuOoSWLjrURL0NEG7pwl+re1uptF?=
 =?us-ascii?Q?XMconamSc664fqJNS8JYJ+1DPiWmltNG5UU/v9w36D5f/WRHQ4cggNz3/PgW?=
 =?us-ascii?Q?NJBJfok4QmhG6Vt7q6mCb7HBlLYHX7uudmifmdWt+eR6OtDV9Ht+54KdIW6y?=
 =?us-ascii?Q?0MGguoBJBKV7aYiezve1X8bI8TymGAL24dYVrt8+ozP6XgMR1EPHlIHOf5in?=
 =?us-ascii?Q?1lFPiB0m1yxmIQsUqpTin7ovl63ip8tV0nV07U2CVXz9e5pMxFAYGOn5uEbp?=
 =?us-ascii?Q?k55GL7j+Gfv7fHf/12Kq8jwezCUL5nw+8x8sAkveHuAqC19tUmNeR3kkgDd8?=
 =?us-ascii?Q?YAjC73RI8ChXaMcf1S6yHDvqeC59A5FugSN/RIHNZnPtjeUJYd5/HYJU+mBK?=
 =?us-ascii?Q?VdJTwOq9okILt8HVXQEr4CY9OsnJzfH4Kkzs0xrOsSyBNzfCl2IyI+mX8BsO?=
 =?us-ascii?Q?OQMnA3+ZRYr3wuNhWzpHDjH6jvVIahTu02eQlIWgYu2nCwXGN/MUTwB34sta?=
 =?us-ascii?Q?de3qs/RAYUKi2vSA1MasWOeILtNvt7SLhA/wXIdlwVom7+e46idi/EKvM/f4?=
 =?us-ascii?Q?Awo0oG5Jw6BuLClgEUOuUGJQDk/wTyxZ3gPqwnNwsZMBkkhaUKn8uGgV+1Mm?=
 =?us-ascii?Q?WDUVZj2+S+DCtYQON3pvyEXqjfTAqJ7dylftPz01U0K2AJSJiNv4Tt3i2mZL?=
 =?us-ascii?Q?6xH57fBaF/+b/ccDqZ8BQAEIfXz5llH/7psGJOrBEH9bYxnPCHAEBx8/3PMH?=
 =?us-ascii?Q?+QQGg40Xl6SZuAp6X3MduDHNHcNWsMnoVfUvmv80znDqFMdzQS2/IZm231Gv?=
 =?us-ascii?Q?kyh/EJ+KRCb+W8EqrLbNvLJyhlS6WEUOoz5ipcbMpENhRNt74KdAHV0s0hg3?=
 =?us-ascii?Q?2L58qzWpkKki7oUgDTVyY/RO32kMQThtMnyZtQnrZQtnp4AGjQbTOCWJ3FfZ?=
 =?us-ascii?Q?Ihxem6eVBqKR42UBsFYXTZ67l4/5YYP9yN0XF71092H6ZxaQtmfr2Z/cREli?=
 =?us-ascii?Q?qh3OqB2dt8O8Cwy8x65Dhc674qlx3jdCuyY2mlYyIov3FPaqYLVdOzjFbAta?=
 =?us-ascii?Q?sdYJJWNyqvboH8VwWINM/WgAjbuWdLff?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VXM7b8tkAy5dKIU6us+Ce5Qe+B3y76tiT09UWvkbHFXgGHOcIm35Cuwo/Bhe?=
 =?us-ascii?Q?zAQ1HQWr84l9BSFq3Lk6QaRHU7MpnONYkIg/Q96JyJ8YC31pmg1xLXtNm9+9?=
 =?us-ascii?Q?FUUL6kge5tV2RK1hQzE4FqYS43SGw2jFvFtroCfODlqyeekmdblPpTt+iLRU?=
 =?us-ascii?Q?jiHnKmmbXFxb3ZDUGdwglPKk+1CNGZdytSVKehAkTN75JhQ2MV9ftMNX5wQs?=
 =?us-ascii?Q?7poq/hPtTJMVGKl3UiK0yBjldTdl1bONLFKknRqmohYoVJ+pF7JGpt36yuMy?=
 =?us-ascii?Q?2QSIfyW4HnHKvCDb4FXfbWxStxQUx6GZM3jpMY4i2587cmRW4lQvwJa5HVL7?=
 =?us-ascii?Q?zwCgsENSj8d/4RVCOWPug51733FeEDQwb8Nq4C4GR8Ge55bQjJ3aq8WrnbGS?=
 =?us-ascii?Q?VjfNaXHAOABh71ZlJGWindQLl0j9O9MjFOYLyHzgQUoOZbTBedW8+ffauMm+?=
 =?us-ascii?Q?VY6UNM8O63LN9VEjBnhmUWMhzSlFMZapwlf5D3eg0ZvjQ6V0IsJPeW8r1iiF?=
 =?us-ascii?Q?t0MvcyXrjHMQoV93nHe5Hc+fLq/8ut1LI2JjBIhI87mlz50vQkUL4MpVPAzs?=
 =?us-ascii?Q?oWSCnmjAJXBraV2Uqq2GPetWhKoz0+5rHIgPy+dB8OrCuXpmoED4d3FAdFoC?=
 =?us-ascii?Q?VVvOIGRwxuWBjRSsszSKmIiRTQ9Dx8A0nREGu5zJyXvw7Pqm+pMAzLU8vqGX?=
 =?us-ascii?Q?dr/K5zqpa65oxlXBv8Cu794wWo62IKYyZhkhJdzOAPfLPyrPFmey7+NTsMgB?=
 =?us-ascii?Q?8sCAIOmP5QeHDWIcBue9fnYCC+v3CrRZ1aweo0Ba1jLx4Ru3veMUdroQoYt6?=
 =?us-ascii?Q?Rm25BrPPrZb1R0RFIKArtPr+O7i0IbRrqrToAsryalHqfaoc0rcwjR9EPJXb?=
 =?us-ascii?Q?6yy69riwHYrKSSJ01u+2/yEGf+8dmPys3vX0ntmYf5dwZL/FLtdTOO87QQZ2?=
 =?us-ascii?Q?RzJ6WUMNu/zkrudSe3zG7L/kemOcrNxkOw4k62hTG/yzFerh3dlJlDvEwduR?=
 =?us-ascii?Q?QDCCmz77ZsHYsvOMATky4jcwThF7iwSK3YRJLYUyIdD4gkIs7kDau2wAVn7W?=
 =?us-ascii?Q?10RDJ66shZlf0p731UVs81lsmsdh2u2Ye7+R+bz0xwCZZbH0VAE4QXLSJnaA?=
 =?us-ascii?Q?yKpQ82VyejEzBxZW6BlQJAPncErL+nJAT85W+td6I4S6OY8dwcA7zmQB6f6n?=
 =?us-ascii?Q?wO2E4yC6wlnIQA5z26g6P3y/GG0/6VGqnofGox1Ot+C42C/BgOLZuYx2dmuD?=
 =?us-ascii?Q?7WddfK2gCYiySHWNfQiR45jNUoXHVZy/IkvnYRktooode8eBraLM5Bh0z0wn?=
 =?us-ascii?Q?r7c4jKtVEKAU9sdG918hPDYEGOQRqA6Q7LzHgQ2MkbcKkrymnpW88dfYevVQ?=
 =?us-ascii?Q?xig1uejLoMxvX5W/sdo39k1tHK/wQ7QrjbDLcHsczjq3jFtsiw6kM6Neuc6A?=
 =?us-ascii?Q?a0CzvtPzJk9iG/hXDWd3loBgo1jobqmQhzTbfO0ws27WzxHYWkKaQRyR8mxQ?=
 =?us-ascii?Q?uRyLd+D6PjWunpT32Q7XdbApC3PFsb1GeapQ19855ZDdog3W4MZtyYYVgGvL?=
 =?us-ascii?Q?kLD98bFmSOIO2xAL3EiVqwnfN3VRwZl3d4vT47sm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb12587-3e37-496c-247f-08de0c64fc5b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 03:35:00.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+Xyo72my7CqgPZxwNrecdig38WAaVybeT1M9JVW3C68AyLSgQhjvOxa8/5wSBfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

try_folio_split_to_order(), folio_split, __folio_split(), and
__split_unmapped_folio() do not have correct kernel-doc comment format.
Fix them.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 10 ++++++----
 mm/huge_memory.c        | 27 +++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3d9587f40c0b..1a1b9ed50acc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -382,9 +382,9 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
 	return __split_huge_page_to_list_to_order(page, list, new_order, false);
 }
 
-/*
- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
- * non uniform split.
+/**
+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
+ * using non uniform split.
  * @folio: folio to be split
  * @page: split to @order at the given page
  * @new_order: the target split order
@@ -394,7 +394,7 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
  * folios are put back to LRU list. Use min_order_for_split() to get the lower
  * bound of @new_order.
  *
- * Return: 0: split is successful, otherwise split failed.
+ * Return: 0 - split is successful, otherwise split failed.
  */
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
@@ -483,6 +483,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 /**
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
+ *
+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
  */
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f308f11dc72f..89179711539e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3552,8 +3552,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		ClearPageCompound(&folio->page);
 }
 
-/*
- * It splits an unmapped @folio to lower order smaller folios in two ways.
+/**
+ * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
+ * two ways: uniform split or non-uniform split.
  * @folio: the to-be-split folio
  * @new_order: the smallest order of the after split folios (since buddy
  *             allocator like split generates folios with orders from @folio's
@@ -3588,8 +3589,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  * folio containing @page. The caller needs to unlock and/or free after-split
  * folios if necessary.
  *
- * For !uniform_split, when -ENOMEM is returned, the original folio might be
- * split. The caller needs to check the input folio.
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 static int __split_unmapped_folio(struct folio *folio, int new_order,
 		struct page *split_at, struct xa_state *xas,
@@ -3703,8 +3704,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 	return true;
 }
 
-/*
- * __folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * __folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
@@ -3722,7 +3723,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
  * 1. for uniform split, @lock_at points to one of @folio's subpages;
  * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
  *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
  * split but not to @new_order, the caller needs to check)
  */
 static int __folio_split(struct folio *folio, unsigned int new_order,
@@ -4111,14 +4112,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
 				unmapped);
 }
 
-/*
- * folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
- *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
- * split but not to @new_order, the caller needs to check)
+ * @list: after-split folios are added to @list if not null, otherwise to LRU
+ *        list
  *
  * It has the same prerequisites and returns as
  * split_huge_page_to_list_to_order().
@@ -4132,6 +4132,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
  * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
  *
  * After split, folio is left locked for caller.
+ *
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
-- 
2.51.0


