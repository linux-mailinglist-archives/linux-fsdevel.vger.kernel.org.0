Return-Path: <linux-fsdevel+bounces-65026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B2BF9D87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6DB19C6616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED662D12EA;
	Wed, 22 Oct 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpnKSKlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794B2D323D;
	Wed, 22 Oct 2025 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104219; cv=fail; b=SVWU322vo39DMmC+OTGvQKyjxiFfxx4BwgY71zw/w754EKGWNJs3p4BR+RMHm597zBmoy7j8kE0mDzGBSGS5L/xd+i+rOGGp4Y1w7LOBSupra9qi0S8JhjCNkOMFR7hIt6aHN8zbty3uQDUUhD7gV3sfuu+JURKs2KtOzMaOQjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104219; c=relaxed/simple;
	bh=lHFSv6Y0CjHmmpVyhrv2pUvCsupGaccqcx2hMj8/nes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddjR5QR1KW1fAGoV0I//Dav3WG5ECWlPePTR3C+I1TyWwJhQbnsEbeO2Vls1K6bpHSSnrIlU20WqtMXR+RV0pIm+H7RQclmfFVE29hIoA0ZrnDZ/90OTKF+B9e0JHbYX4c9u4glIArePMArKy4G/swvcc16C9lTVsikdGuJDljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpnKSKlU; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOI81TYOxxylh7O+mDeBFlD55l7m59Ggf9KD140Iwth0fXiniVKffenZAwms5aowZbUSud/YFtgSk2lQGdzPXtFe3yD07df1BM7dbO8sZ/dnFzqW/aU9CG7wzY3oyh8qCh9njRZnxm7zYhN9tCnxXPeuNYmO7j9YCysuG9vpBc6dMk7tv+IcNF3lF2mX6mO54BE1c5sgAiHBINyGAVdkzVUyuodfyZkbNVMv/KKXyXMByxPpcviNqMY068bZeFrj4qCBRSnoQ0SjKx6jCwJso7XRqIrluGdlziXzgQOfUnovRhmBlYHiMNHr7u5w/FJPkiwP0hI8gWohGgpR+G5nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZT0XCRJVbj1WvWFdYdZ8grPJ+rp3Brk06dfTfBCiYs=;
 b=J9JSIyLqGa5n5m8EPlOBxRhAqhxzeRbHOrrAwa7sgj0WWEmMj8p64Vv95U5bXXghphtVyMwdCAfTlxU0+IcxV1OGU2rQL244qryDFs4y71szfNUk+6W+Xy2syFb7z/wS75aUxYpFxm/uGXL6kPOZqiSlzVFUSfQMoUmfhJZ/Ww3SJ7UNHTxW0nIN4C3K0ewZPG6roUQoQ28ERlLIXijrGw9zurm5vHuJPMHj5flHOv4sIHorWuCuABIR7CRFOOVZ8uIpXqreLSEkeyAMAe+JkM3NkbhGt4mXKHxWj2VvZonXt3E6mGmvwlEghefnKjO0kqSgZiUtBgVq26W9mjnuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZT0XCRJVbj1WvWFdYdZ8grPJ+rp3Brk06dfTfBCiYs=;
 b=SpnKSKlUUF/UhZvnkaOVT+ZvLHy3UPEGLzLa6MWUiBkPpmuT8EJvwwa5mXu7lYD8n6TDRUSgWz36XiI3s3i2OHtg6zTXWBPJ8xreWzz3WFXw2STCXVFEVZ0iR9M2f0RSwu6+JadHFaPEIK4Bfu5ozC4BnruQHhsnNB/5/wRnDAcgYwaIxTkRD6VpvTaSXJY4l88jmb33IsynTT3GzjA3Xm1Dm2PuamPMqzj4FQp70ma6ZGswMVXxeDQNpvTW3MsTaxU1zEojZXy7gx8Rptx+0jTYN8ADTM9TuqJXCgdIBQgV28s0nn/BXesjxTc2UhtGB0qwnor4ZPbUlEBrzS9Umg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 03:36:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 03:36:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com
Cc: kernel@pankajraghav.com,
	ziy@nvidia.com,
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
	Yang Shi <shy828301@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/4] mm/huge_memory: fix kernel-doc comments for folio_split() and related.
Date: Tue, 21 Oct 2025 23:35:30 -0400
Message-ID: <20251022033531.389351-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022033531.389351-1-ziy@nvidia.com>
References: <20251022033531.389351-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e11917c-ae96-4190-b005-08de111c3d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gGkyuXkrpAhMfB5FPU4F598BRan8vr+ii/YOyMnes0+9rTSK55FKeah1UmYx?=
 =?us-ascii?Q?6tOBepzlYR51ocx4BqcIVIzWvDEieEZVFCf3UemIZnQQQwwAvAUVoJflDHP1?=
 =?us-ascii?Q?ZQhbhliQo9L1GbBf3cT+EkPA4EfbwU+WxEOvjZsN9YnMjCz6HKgCwuQ/yhsv?=
 =?us-ascii?Q?CwWx2vf0UwduokAJBIgKAHeikRnEaJ4tj0OpnJp+6jICZMR5RrdZXK+YVK6U?=
 =?us-ascii?Q?CY4XW7fpoHSDEZmbE+PHdDTd+vaXFvdrrGkS0CHkGdwpQjXO1vYGxczggnAE?=
 =?us-ascii?Q?9Rk/QJ0VntaBB/kscgUEeit605q8a8xaJ5JkNbFn6JN0g+Pgfo9aAheIir51?=
 =?us-ascii?Q?kIYn1VhDH+rLUFGw8/5X3sEE0mBg0wps4+B6zTSMU4N7fJQGqqY8oV8ZGvHk?=
 =?us-ascii?Q?aUlB7//VACku/GulNEzY/v4rFqAUBDUGMFjZNr4/w3mLYELzwZ3ceV8TtBNP?=
 =?us-ascii?Q?3BHMIB67ICrzHjkb6a9kifv28cy01Vu/gokexhyr40h+6Bonk8d7++4/idFT?=
 =?us-ascii?Q?/VRPxT/GkQHWHIqZokqvcd2t9gg0tJNsXLfaodspPgTc1TH4rZE2JniWXWSU?=
 =?us-ascii?Q?YqzlWvGcVMO0UNJlPLY7XJQg94BOuw+OihxZ53wF8Kj3gnvLTLvJIC0B4gTo?=
 =?us-ascii?Q?upFrTqnzGBKJPqX6PnsDS3KAdReqf6BdZD0lNv8mHwaWIrHSLRYYOuy0UBbQ?=
 =?us-ascii?Q?F9hpPqvtrv0t1cM9TsWypopFmCzwUzPtvOmUSX/tpwWSkmJMixlMsVqxA0Eb?=
 =?us-ascii?Q?IfJHwZKHNrBr/OuA1/dqMf+Oh75UaoHoIQ2GLrxRStIddHZ64T6IZPtHgHfN?=
 =?us-ascii?Q?252OIozcJ4JYyPC1RTq6u8H8hb5qqMLWdQGoTzQdb1yUebMg+hqBwaGC8EYW?=
 =?us-ascii?Q?sCKrr5es93F48Y+uR+ZM99Zvmcx/FV6m9q+2rIiLqTsIMBHY8x+aGEC/vc/9?=
 =?us-ascii?Q?9vutsJD6tRemZTNaNoR13Mn1vrFbIDNoE93r+/7VxS2V/7ifOOg5meUTueSM?=
 =?us-ascii?Q?rOXuoN6VfXU7+p4W/pc/jWa003Mu91zMXRU2JkJUFeJhj6gAjjY1924WgxTE?=
 =?us-ascii?Q?K/W1b9ppeGkx2qzs+WbNDll1RRgmdaTO1OmF03SkveT1kGQGWUMZyBM+iJ52?=
 =?us-ascii?Q?jbVKhkUWrdsN//4GMTB7VhYdFM6TypLR8XcUpsO80mrPCBTu/NK91vy9m1qG?=
 =?us-ascii?Q?bAYr347mF5qGZ+UDr2d50j9b/bXqegqjh0+ySv419scJBl9ZNCDkpQuCdTUB?=
 =?us-ascii?Q?dKLEufXbkR0mGqk6yV2J8Lwe2FDlDrLVjMNKb49DZms8zp9AAccE4w1l50mo?=
 =?us-ascii?Q?3xl080AV9RwNfUXb5jbdX+okNYRMZNi28j6Xu2rc8oQhMPZWCBN39YQhCiHX?=
 =?us-ascii?Q?4gmn88JSa/w0tnUOcGaMDXbdojp5r63ZPzfQu3Pccy9MOCu4jTV3q0I97u3W?=
 =?us-ascii?Q?2sv4eLVEotFVle/PuWX7Hb6lvrKrKyvJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZuTdFLd9Sww5EuaHcKN2L+UFLDi7GfQz0Z7KTQwyqh8h16HdjJTteIlnjB2C?=
 =?us-ascii?Q?oBOt2u00lsosvCVQZHjGMHyxNPdonE8wvZuJzlPdycL9Ku3nt5OfQrLIbEZ2?=
 =?us-ascii?Q?uMOpEsgV2YndqNHr4RfHKCS7fH2tDFRGhO1sqvLyGUDHd8bG8bSgO82+O5EP?=
 =?us-ascii?Q?wSnDLPTiN1OG27EjQsphBLdi8x2PBqOranTjmmWTCEuJrotp3/qeamdyyRoM?=
 =?us-ascii?Q?7hX1dI5U+35r9xdg6Gd6CfEkCbTCyeWvvZdu29CIZ0X5gnS9i7qzYsHuiSOP?=
 =?us-ascii?Q?/GS/oMBphnOfAn6jb9pns1vL6E8LZc9e+0NItsWB3xYVp7EFeHnO3Q4+wKkS?=
 =?us-ascii?Q?rGkGmE3hHeA+2XeQiPwjCGpzz5dOlJMBTU3TRIqeTM77nxF1LcO5FyYsqGWh?=
 =?us-ascii?Q?P7PvXFd5XMa/Z8DGPxQAOOGwA76CP9nqGzHiK5PMCQE3hChEe0NC8zleCiaF?=
 =?us-ascii?Q?DFFLXSOTdCCtIVosPy0craNmGHY5fgpZq9M+X5tvgTo0NAdmdPWiw5o4kycK?=
 =?us-ascii?Q?GsK40CCXyISpSwl5e1WM96fkL8thryt39ZZdXh+D0ZhmbmVTe6lgfOLM/54z?=
 =?us-ascii?Q?fHM9Lu1+4XIropzhIoVjrOOLrE0tGid9Jw878JrWsTpL9qMf3+m88XAYTjXo?=
 =?us-ascii?Q?X1udv2lry3PVUntXmpjpx5HHeEolOG2pBwm5y8PeOaBAgt2kMs2vuhlnhS6v?=
 =?us-ascii?Q?sNHFmD6TBfMSG9VQLSrp6BeWe79JXVyKfcsQApLk1FATp8Hwn6tpYAdeaTH8?=
 =?us-ascii?Q?L1eJZFlHE2/XwFmEajtMAKIAGEI0pp8uQ3WQlDn03pymlTqavnz4HAqDirag?=
 =?us-ascii?Q?Qki6KXRaQt5HhMKKakceyhGdbHALo61R0Wb5sfij6KI1TRq6drOj+mFnPOVU?=
 =?us-ascii?Q?PGSzoO7ViJQCMhPPN4x+BKwr2ESgw2R84W/NaMrhm53Ya+uXl7/mYQ8ueG3S?=
 =?us-ascii?Q?JLa22eIipyVhf0bfvO8kqKb+BrQ3e7J4C1bLpQhBYegTCXQX2g8yvnlq3lek?=
 =?us-ascii?Q?vv6tY++zMBj30HQjyuVO+g5uRP6+/pztyZ8Fwiindo24xxpUNp64E/u29r0S?=
 =?us-ascii?Q?k5YjF6dYAVmp7hc8an32G/y1L1U9e0+8keby6qN2SrSmcUtiHmRwpGFIGH55?=
 =?us-ascii?Q?Gs/W0/H/Ji2Pt0nMWNEPwEZ9Y/rwFi4nhWQHprKEE5POCWfd/6CBQxs8BEj0?=
 =?us-ascii?Q?i1g2DPG86GJRna3L7VGn15sKfnvRmEu/f/pZu4MRX152SZ2w1N9kbqRXXxb+?=
 =?us-ascii?Q?V5GE12JxBFLVYcVipu2jVeK0nwQvh78stQ/woNw+Sm5xfNdNt6KkAHvM0Xdb?=
 =?us-ascii?Q?kiiVR1cC1GPrxBb6BjDNfJ1e6/fzU6cmfACn1soaei7RRPsgXbSM0hHhQA4o?=
 =?us-ascii?Q?hLQEzUZK3AGTsHoCQWzYCWIOQ5GOloJNSK+I0CNad6uFwWHvpUVLl0XT+8xR?=
 =?us-ascii?Q?PzBs81E21SeimxkA9chos91K9dRdYfxnSZjsnaVNlcWOQVvBYw8BpBb/sETT?=
 =?us-ascii?Q?OYa5SPVMo4SN7u/iePcF50l8wcDDj2I9gvV2qhT76zg3CZtG46rgc3YUUS+4?=
 =?us-ascii?Q?L4b5dZeJfqPca9e+pUCz9j51BZnXCJHdLU8VpaL3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11917c-ae96-4190-b005-08de111c3d6f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 03:36:52.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmJ+2baWKgHTbpQypqZZVKGzHVzWS0sucZzOHIKBZT/5y2Z8kWCx2d2O8nZfbMbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268

try_folio_split_to_order(), folio_split, __folio_split(), and
__split_unmapped_folio() do not have correct kernel-doc comment format.
Fix them.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h | 10 ++++++----
 mm/huge_memory.c        | 27 +++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 34f8d8453bf3..cbb2243f8e56 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
 	return split_huge_page_to_list_to_order(page, NULL, new_order);
 }
 
-/*
- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
- * non uniform split.
+/**
+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
+ * using non uniform split.
  * @folio: folio to be split
  * @page: split to @new_order at the given page
  * @new_order: the target split order
@@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
  * folios are put back to LRU list. Use min_order_for_split() to get the lower
  * bound of @new_order.
  *
- * Return: 0: split is successful, otherwise split failed.
+ * Return: 0 - split is successful, otherwise split failed.
  */
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
@@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 /**
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
+ *
+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
  */
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f3896c1f130f..38094d24fb14 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3576,8 +3576,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
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
@@ -3612,8 +3613,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
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
@@ -3732,8 +3733,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 	return true;
 }
 
-/*
- * __folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * __folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
@@ -3751,7 +3752,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
  * 1. for uniform split, @lock_at points to one of @folio's subpages;
  * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
  *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
  * split but not to @new_order, the caller needs to check)
  */
 static int __folio_split(struct folio *folio, unsigned int new_order,
@@ -4140,14 +4141,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
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
@@ -4161,6 +4161,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
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


