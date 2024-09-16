Return-Path: <linux-fsdevel+bounces-29516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CD97A660
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C4282EC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7815B999;
	Mon, 16 Sep 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4AItlesE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B997166315;
	Mon, 16 Sep 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505920; cv=fail; b=fsAen224EEf//0YG/ssRHRGVZ+1ZyR9pDhiQvubz/w1Sh4wkCQXGoF7ThrY7AECIX+OlBokFRg37il5w1qM8VK58Mfr9BOhRoSHzLEs4wowAUFkYMQ9zhuDJNBbiH5EvKOg+wAl+mcw1dDgM0zeaZ/CMZ1MvmydTzafY6/M49ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505920; c=relaxed/simple;
	bh=/iToNvPzY6wDaJI+40I/f/6Gjo2h5qnYW+RnSCtZUAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4WgmNh/syOcVlm/QIXRG95EJ3T/spkX153jQXMc6c8SZaqGjL+IYgb7b9BAfy9La7hM8tmtojXqukyo03UGfu4quFG4a2AQ+Bemk8mVTtKFb6YoQ0lsv82Mu637b3rJhX0Fh4/OS3/nzsOpD8rbm6FEJOz4tTLsD3UQ9P/znI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4AItlesE; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0CtHGecNJ7MD6op2QX4O9W4yTR2pfAlCQ8Gfdd5zMo6jOgsrhBir8F4tMLjhEGstoZoRrzYDOHRNPfMn4f4V28bpnqeYHDEBg35NQb1iIJnlh7NNlljTATrlY+tbVVK4o3Nv/1fdf6D5SE3dwYs2a1gvDQ77g1zpXS9WNjAibFWWUuwaWrHlJ6LD1sYvkmfjHUtGZWTM8UCBb2po9qHDgr6aNgcStLeBNNQJtmRLBTbSGygajvaHMBplCAUdnWZ6PEH8ac+TkuYZMDk9oEpJZ4lIgtwqoxTqHG25MR5w6+zkt3eirbH8Yu1LNXwnR867l7VE7M+xTVsHFkBRf8mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVP9Dii3HPFNi0wU5QvtIqIv1UyuRRkoFQmZgmQjIHI=;
 b=idjKFsBt8jWYViusOgUFflYCvL5PbK8I8HKZ6lmsHpMha5/QTL1zeSk1GLw+2xlZyjKR8eQwrwB/EACx4PVjtWF8eiHCWsegCvDmrTqpcIzcwiY2JVFKZpV0EUt5i3FoILMutErcvIHijtJ/ADtZp3ZL0MK1JYGxPoIMxS9WaMpBH7wxZo3vnywb/lS9RLQ4ypRRhjmd63adaQMIFrbBlfXD31xldhhTMjD993kExInUXall71HyOBIs02z+JR9UbJvZQbr+e6LLtdMMtqHrYvjCkmm0b/brdwAj60I+ds7PMRmPoPtL/xN3pdiR0ZcL2UreLJr/m1NICvGl2bbIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVP9Dii3HPFNi0wU5QvtIqIv1UyuRRkoFQmZgmQjIHI=;
 b=4AItlesEfdHYwycTxmNZdHOSkZ+q5hDSkVXnU004Yygw6f2kpYYXiMZYrN+vo4fZvaCs+sqZxhbNN1aJsJoO+OlrgywJy7AmwBPqQu29p8yw9UaZylWpBwNEAyWPqmhLbaBXE9Wo7Wu47pkZE5mt5oWdvUfYgTS7xHHMu7TbaEM=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 16 Sep
 2024 16:58:32 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::ac) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:58:32 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:58:26 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<shivansh.dhiman@amd.com>, <bharata@amd.com>, <nikunj@amd.com>
Subject: [PATCH RFC 2/3] mm: Add mempolicy support to the filemap layer
Date: Mon, 16 Sep 2024 16:57:42 +0000
Message-ID: <20240916165743.201087-3-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916165743.201087-1-shivankg@amd.com>
References: <20240916165743.201087-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e9d57f-c103-4597-216b-08dcd670cba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdLdDgGJmLdGTLZl9SRjVrmjYYkLg9fm4+tnslOzLBpKI+RlC3S30zuIdjw0?=
 =?us-ascii?Q?v8lDhmbITO3ps+AKwrveNm5Kx22U6MZ1wtE6+WCplI140s34lqjOeby4i/E6?=
 =?us-ascii?Q?pLVkac7CR+jhjNXYRY5liNCU+QXmvHjaA/aSC0FWQYT5IHHEn1ItUUgDY6Yf?=
 =?us-ascii?Q?EIwtALPRXN7qVzqeCGHLFRquS8gtMqk6RuKCeszs67ZuiNMo+kYiKSt64VMr?=
 =?us-ascii?Q?Brep9dOftyP0DtvymGI7Pzx07ecz+k1OdA8ZvBopToRGR1Ps9CzNPE7SuiW/?=
 =?us-ascii?Q?ri6emX81I5w/Trtzy3iINcfQXX117tpE5U/YpUCV1T3kGDAsc8jSNlhmzCEG?=
 =?us-ascii?Q?KzYW1GULzAXJDx+Fqthbct1WqLZrUCSnD+6CSgxPqKK7/DrlvwlvGlvBVItF?=
 =?us-ascii?Q?zMDhg92A4eGXNbeXMFL2HgOMfTiOECVOHgs+f3YYVumXMtBgNkgH9nGI3FA7?=
 =?us-ascii?Q?HhnZnESSgM5kImRvl4dW04jm1wjIrL6gFyx8KOOJWjthU97VP58h7wX/yTGK?=
 =?us-ascii?Q?tBLPXwK2gSJK0Nj5/3NBSJ1tXm9WSulIeOMr0vZAbqgFHzBaWToXq4s/D1uy?=
 =?us-ascii?Q?t/rjuc67RPuVlHTtpp0PgCMkyRAy2aZyeTtKVDXmSbi9s3+nVwZkJpUq/izm?=
 =?us-ascii?Q?5PVt5ywjOpW41yDL5bwb8PqtuK8Rj9CMTgVm/wDRPWmErHpKjarokzV6Y1ey?=
 =?us-ascii?Q?Yv7TMQvV+9n8EOKclQm6lzPo7OFmqEzr80StF+Xhe9w8C01fWlqv4uLrVKEx?=
 =?us-ascii?Q?ooya9MundqXVQuh0kH/OsvPjEFUChYVUfv+CXRJ0oLWsD7rIy+tCQJdFAX0q?=
 =?us-ascii?Q?ZZvEtNa46StmYqz88hAyQEPG1z4l58NqlRiVkKftdDjy+nNq36JA8KBhbEFX?=
 =?us-ascii?Q?HsDjQbDUFndFHvu01wkHFzi0ijc2IQthLUFCIoq/ebHUmBzeaKZmvoR9Yrzy?=
 =?us-ascii?Q?b0HIJdGxhXUdLHBtTZgTJ9iOAZ3K2hBG1B9cHETw+8GYNHsSGU8t9ALuNBSl?=
 =?us-ascii?Q?5W6OwtNESsPXBotgE8eVNJXAgbw2Z5K985vQeoyDXHeOGCu7+AslH4BKrqZX?=
 =?us-ascii?Q?LMgNwOGRzu58Bc8wvEum175Ofao8XS9w88ZcIOQuX1WFNYO0+D64WCqXC3Us?=
 =?us-ascii?Q?JDbMV7Hhk8azFvYA9F+pxISfjE3eTmAe9/638WRyjMKWczEwCeTbV0hg40jy?=
 =?us-ascii?Q?6Vzjd0iVaRd8/E+gcyXsJDvARgkv5L6HGjZjiUlIIwEfJ6Cl3iTl1BYUIMzi?=
 =?us-ascii?Q?waoUYPPudk4yt7Pe9ZW/st3q2HirCBLYQvH9F1dHvymmuIOoWd81ApKvqLTJ?=
 =?us-ascii?Q?pvCo+CBRmbRtLPCUfGuDq0nVobMjpV9hH90SqMnPkbEYOuXWXpjSVSO2ZVnQ?=
 =?us-ascii?Q?vDJP2holbVq5ZYFr5vBi9r7tDcx4xLn/0pbFn5Z2SHwd5CaiAdfeAUKSkq03?=
 =?us-ascii?Q?+uc05aiKGnTAOveShOmqF3OxLSs9wcrf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:58:32.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e9d57f-c103-4597-216b-08dcd670cba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Introduce mempolicy support to the filemap. Add filemap_grab_folio_mpol,
filemap_alloc_folio_mpol_noprof() and __filemap_get_folio_mpol() APIs that
take mempolicy struct as an argument.

The API is required by VMs using KVM guest-memfd memory backends for NUMA
mempolicy aware allocations.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/pagemap.h | 30 ++++++++++++++++++++++++++++++
 mm/filemap.c            | 30 +++++++++++++++++++++++++-----
 mm/mempolicy.c          |  1 +
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d9c7edb6422b..da7e41a45588 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -564,11 +564,19 @@ static inline void *detach_page_private(struct page *page)
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+						struct mempolicy *mpol);
 #else
 static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
+static inline struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp,
+						unsigned int order,
+						struct mempolicy *mpol)
+{
+	return filemap_alloc_folio_noprof(gfp, order);
+}
 #endif
 
 #define filemap_alloc_folio(...)				\
@@ -652,6 +660,8 @@ static inline fgf_t fgf_set_order(size_t size)
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
@@ -710,6 +720,26 @@ static inline struct folio *filemap_grab_folio(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/**
+ * filemap_grab_folio_mpol - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ * @mpol: The mempolicy to apply
+ *
+ * Same as filemap_grab_folio(), except that it allocates the folio using
+ * given memory policy.
+ *
+ * Return: A found or created folio. ERR_PTR(-ENOMEM) if no folio is found
+ * and failed to create a folio.
+ */
+static inline struct folio *filemap_grab_folio_mpol(struct address_space *mapping,
+					pgoff_t index, struct mempolicy *mpol)
+{
+	return __filemap_get_folio_mpol(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping), mpol);
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..a94022e31974 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,8 +990,13 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
+			struct mempolicy *mpol)
 {
+	if (mpol)
+		return folio_alloc_mpol_noprof(gfp, order, mpol,
+				NO_INTERLEAVE_INDEX, numa_node_id());
+
 	int n;
 	struct folio *folio;
 
@@ -1007,6 +1012,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 	}
 	return folio_alloc_noprof(gfp, order);
 }
+EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
+
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+{
+	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
+}
 EXPORT_SYMBOL(filemap_alloc_folio_noprof);
 #endif
 
@@ -1861,11 +1872,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @mpol: The mempolicy to apply.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1876,8 +1888,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
 {
 	struct folio *folio;
 
@@ -1947,7 +1959,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio_mpol_noprof(alloc_gfp, order, mpol);
 			if (!folio)
 				continue;
 
@@ -1978,6 +1990,14 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		return ERR_PTR(-ENOENT);
 	return folio;
 }
+EXPORT_SYMBOL(__filemap_get_folio_mpol);
+
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index,
+			fgp_flags, gfp, NULL);
+}
 EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9e9450433fcc..88da732cf2be 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2281,6 +2281,7 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 	return page_rmappable_folio(alloc_pages_mpol_noprof(gfp | __GFP_COMP,
 							order, pol, ilx, nid));
 }
+EXPORT_SYMBOL(folio_alloc_mpol_noprof);
 
 /**
  * vma_alloc_folio - Allocate a folio for a VMA.
-- 
2.34.1


