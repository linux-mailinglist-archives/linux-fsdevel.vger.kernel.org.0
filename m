Return-Path: <linux-fsdevel+bounces-16772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4538A2659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180E51C23A12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D22606;
	Fri, 12 Apr 2024 06:20:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8853234
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902848; cv=none; b=RXwB25HEbC0pG3jyVpb9Cqc8HXPkBPi8XitqvFH4kVT4gkS7nlHnW+tlHY5wUF0MJLu7de1ScKk+UgVORXtUBZRbCMdbcoTO6/vqgK/JCji8vysjzC5iH1opr7rD1zLCQBqdmpI6d/wXgXpvxCPNoKVbde+nSyctSCsE44U1ETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902848; c=relaxed/simple;
	bh=SRcZxI3A1FdS5Kz4sdiEuBlvhmd1re+y2WTrQM0qfAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8uGKNLij4ipnFSKQn+cLEns231/8OON7g3PYRDqPGO2wK/bqG7xv35BDvCWtj0DXC0sec0Z4+zrgde3xrWym43mMQbXynOrMA3bUuuZcp75NPQj5d0RIqQePaiRb3iOgbA3VQKQphSQvg5/KLFaAnkcmzdUgXueuzadwi+mlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VG5wc6D5cz1ynKD;
	Fri, 12 Apr 2024 14:18:24 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 85E5B140554;
	Fri, 12 Apr 2024 14:20:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:20:42 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 2/2] mm: filemap: batch mm counter updating in filemap_map_pages()
Date: Fri, 12 Apr 2024 14:47:51 +0800
Message-ID: <20240412064751.119015-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
References: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Like copy_pte_range()/zap_pte_range(), make mm counter batch updating
in filemap_map_pages(), since folios type are same(MM_SHMEMPAGES or
MM_FILEPAGES) in filemap_map_pages(), only check the first folio type
is enough, the 'lat_pagefault -P 1 file' test from lmbench shows 12%
improvement, and the percpu_counter_add_batch() is gone from perf flame
graph.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 04b813f0146c..531af4acc667 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3506,7 +3506,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned int *mmap_miss)
+			unsigned long *rss, unsigned int *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3540,8 +3540,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 skip:
 		if (count) {
 			set_pte_range(vmf, folio, page, count, addr);
-			add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio),
-				       count);
+			*rss += count;
 			folio_ref_add(folio, count);
 			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
@@ -3556,7 +3555,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 	if (count) {
 		set_pte_range(vmf, folio, page, count, addr);
-		add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), count);
+		*rss += count;
 		folio_ref_add(folio, count);
 		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
@@ -3569,7 +3568,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		struct folio *folio, unsigned long addr,
-		unsigned int *mmap_miss)
+		unsigned long *rss, unsigned int *mmap_miss)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3593,7 +3592,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		ret = VM_FAULT_NOPAGE;
 
 	set_pte_range(vmf, folio, page, 1, addr);
-	add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), 1);
+	(*rss)++;
 	folio_ref_inc(folio);
 
 	return ret;
@@ -3610,7 +3609,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
 	vm_fault_t ret = 0;
-	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
+	unsigned long rss = 0;
+	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3629,6 +3629,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		folio_put(folio);
 		goto out;
 	}
+
+	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
 
@@ -3640,15 +3642,16 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 		if (!folio_test_large(folio))
 			ret |= filemap_map_order0_folio(vmf,
-					folio, addr, &mmap_miss);
+					folio, addr, &rss, &mmap_miss);
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &mmap_miss);
+					nr_pages, &rss, &mmap_miss);
 
 		folio_unlock(folio);
 		folio_put(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
+	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-- 
2.41.0


