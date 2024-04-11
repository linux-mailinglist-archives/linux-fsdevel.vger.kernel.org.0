Return-Path: <linux-fsdevel+bounces-16678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F68A14D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8846328BE6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11C38F84;
	Thu, 11 Apr 2024 12:42:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E02433DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839364; cv=none; b=auX4+Trla+8YcqFLXbqJ1yuB/gPaWTqyJZKWxx6/CouBYNJPs7qXtvKPvJUmHcSXCzzH8CA/KWYPaQvrHq/ns3hI1v5mbukUHZJvyUJPen8tfoRwBQHgwympaaasZGXQEtTWD9lR+OXbjsiWxuSRoiqk+egyZFmGSAYArpAPfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839364; c=relaxed/simple;
	bh=vRnrgmnOxS+EnvXQ8m8xkQ7J9jfWKh7s8vr4/RowOSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbuQ6KbSz0uW8OnlSN6t4/aSa/B1K/tFLT8vhSj3cE3dmF+OynjnbpgMNXde3exl3wG6A30whc6Zh0xliGRJQYw7Yc/brwcU0E4y6KY+4+a3uMiA4M9BC0qqFvXwtaWuf4J6p1tOjtB1Ys7lRdy2HQYlDnWFdLZvtynH/ar4MJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VFfTK1GXtzYd80;
	Thu, 11 Apr 2024 20:41:41 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CFB3F140156;
	Thu, 11 Apr 2024 20:42:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:42:39 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: filemap: batch mm counter updating in filemap_map_pages()
Date: Thu, 11 Apr 2024 21:09:50 +0800
Message-ID: <20240411130950.73512-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
References: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Like copy_pte_range()/zap_pte_range(), make mm counter batch updating
in filemap_map_pages(), the 'lat_pagefault -P 1 file' test from lmbench
shows 12% improve, and the percpu_counter_add_batch() is gone from
perf flame graph.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 14 ++++++++++++++
 mm/filemap.c       | 19 +++++++++++--------
 mm/memory.c        | 14 --------------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6ad440ac3706..c7dffd358088 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2655,6 +2655,20 @@ static inline int mm_counter(struct folio *folio)
 	return mm_counter_file(folio);
 }
 
+static inline void init_rss_vec(int *rss)
+{
+	memset(rss, 0, sizeof(int) * NR_MM_COUNTERS);
+}
+
+static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
+{
+	int i;
+
+	for (i = 0; i < NR_MM_COUNTERS; i++)
+		if (rss[i])
+			add_mm_counter(mm, i, rss[i]);
+}
+
 static inline unsigned long get_mm_rss(struct mm_struct *mm)
 {
 	return get_mm_counter(mm, MM_FILEPAGES) +
diff --git a/mm/filemap.c b/mm/filemap.c
index 2274e590bab4..d8b23e976a43 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3506,7 +3506,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned int *mmap_miss)
+			int *rss, unsigned int *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3541,7 +3541,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 skip:
 		if (count) {
 			type = set_pte_range(vmf, folio, page, count, addr);
-			add_mm_counter(vmf->vma->vm_mm, type, count);
+			rss[type] += count;
 			folio_ref_add(folio, count);
 			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
@@ -3556,7 +3556,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 	if (count) {
 		type = set_pte_range(vmf, folio, page, count, addr);
-		add_mm_counter(vmf->vma->vm_mm, type, count);
+		rss[type] += count;
 		folio_ref_add(folio, count);
 		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
@@ -3569,7 +3569,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		struct folio *folio, unsigned long addr,
-		unsigned int *mmap_miss)
+		int *rss, unsigned int *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3592,8 +3592,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (vmf->address == addr)
 		ret = VM_FAULT_NOPAGE;
 
-	add_mm_counter(vmf->vma->vm_mm,
-		       set_pte_range(vmf, folio, page, 1, addr), 1);
+	rss[set_pte_range(vmf, folio, page, 1, addr)]++;
 	folio_ref_inc(folio);
 
 	return ret;
@@ -3610,6 +3609,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
 	vm_fault_t ret = 0;
+	int rss[NR_MM_COUNTERS];
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
 
 	rcu_read_lock();
@@ -3629,6 +3629,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		folio_put(folio);
 		goto out;
 	}
+
+	init_rss_vec(rss);
 	do {
 		unsigned long end;
 
@@ -3640,15 +3642,16 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 		if (!folio_test_large(folio))
 			ret |= filemap_map_order0_folio(vmf,
-					folio, addr, &mmap_miss);
+					folio, addr, rss, &mmap_miss);
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &mmap_miss);
+					nr_pages, rss, &mmap_miss);
 
 		folio_unlock(folio);
 		folio_put(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
+	add_mm_rss_vec(vma->vm_mm, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
diff --git a/mm/memory.c b/mm/memory.c
index 485ffec9d4c7..149208da1652 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -465,20 +465,6 @@ int __pte_alloc_kernel(pmd_t *pmd)
 	return 0;
 }
 
-static inline void init_rss_vec(int *rss)
-{
-	memset(rss, 0, sizeof(int) * NR_MM_COUNTERS);
-}
-
-static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
-{
-	int i;
-
-	for (i = 0; i < NR_MM_COUNTERS; i++)
-		if (rss[i])
-			add_mm_counter(mm, i, rss[i]);
-}
-
 /*
  * This function is called to print an error when a bad pte
  * is found. For example, we might have a PFN-mapped pte in
-- 
2.41.0


