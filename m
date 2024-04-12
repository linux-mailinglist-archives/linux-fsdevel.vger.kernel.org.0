Return-Path: <linux-fsdevel+bounces-16763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA368A23C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2A81F23708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3C514AA9;
	Fri, 12 Apr 2024 02:30:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41EDDAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889002; cv=none; b=ndee7CNIIREK5YC9Wy8FTZ0iWHL94krFMmYwjPBggSW1RC2SwUZj+9L1F830pW098jaZwBb9GHWezgNQto3c0VyfTu0tfPwfHfZZCk4NMLJZ9YnITzdyOdzv30j37tDSUnb9VLtajC6MsJGQ44hN/Jsx2ff8AX1GTikiQgrvywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889002; c=relaxed/simple;
	bh=TVSczl06ljHGmzlzJtI+zJNLxrV6iLWmNLwcHUw1/20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1Tn5Jpw+s+ROAEMIYkX2xGCqKbvOgumRJihM0/KBFF+37q1hnI4KaNzsBvs9qMxcitX0AlwlHnrtWsOnupsEMze9WjYfiJMPrvloDmJkAtwsrjYCXoY+Rnjb7sg20d/8Sk3OpEpgSPUvjQtg1BOywMaDvz/1N9m8plz+SrIzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG0nc1L0vzwRwS;
	Fri, 12 Apr 2024 10:27:00 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 77832140427;
	Fri, 12 Apr 2024 10:29:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:29:57 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: filemap: batch mm counter updating in filemap_map_pages()
Date: Fri, 12 Apr 2024 10:57:04 +0800
Message-ID: <20240412025704.53245-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
References: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Like copy_pte_range()/zap_pte_range(), make mm counter batch updating
in filemap_map_pages(), the 'lat_pagefault -P 1 file' test from lmbench
shows 12% improvement, and the percpu_counter_add_batch() is gone from
perf flame graph.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 04b813f0146c..c8d41ab5034b 100644
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
@@ -3610,6 +3609,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
 	vm_fault_t ret = 0;
+	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
 
 	rcu_read_lock();
@@ -3640,15 +3640,17 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
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
+
+	add_mm_counter(vma->vm_mm, mm_counter_file(folio), rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-- 
2.41.0


