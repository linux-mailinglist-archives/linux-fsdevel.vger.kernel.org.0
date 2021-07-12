Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CF3C42B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhGLEPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLEPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:15:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32EC0613DD;
        Sun, 11 Jul 2021 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F67y1HGC1JFbJBcJYgO6DDgZyec9wpQ1QiUMRE5+pfc=; b=rMAFI2dIYsrMyzTn5zl8V2EL67
        HGSBQCpqKIjnw2Qg9hE+kz8qf8Na978j/niJ3rE95s1fvF9JR+rT3qgcUOMPHGGA9fl7RnIWImpPJ
        MAWJhPnCMDHYVTDyL5AD5xqrn8XYGWKVW4wquhRpeRTeudO+U57Eap2utBu8RQPB2abrf3+nrFKLX
        F3H/MpcehV+xXgDjVS1Uhw1TtILjcRMZr3lHUinaeOTawcSqIFTYCD0LaQ+nfN/6DkG411FM+v0WX
        T4iiLpwllFaz5WzYO2t/FejuB/QHBiwoG1mVXSlqpDzAF8x+rZvVp4WrsPumQY14yjoMWNFBPaEJ/
        NErckiLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nHt-00GrKc-02; Mon, 12 Jul 2021 04:11:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 122/137] mm/filemap: Use a folio in filemap_map_pages
Date:   Mon, 12 Jul 2021 04:06:46 +0100
Message-Id: <20210712030701.4000097-123-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Saves 61 bytes due to fewer calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 37fb333d56ce..82f985f61224 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3105,7 +3105,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	return false;
 }
 
-static struct page *next_uptodate_page(struct folio *folio,
+static struct folio *next_uptodate_page(struct folio *folio,
 				       struct address_space *mapping,
 				       struct xa_state *xas, pgoff_t end_pgoff)
 {
@@ -3136,7 +3136,7 @@ static struct page *next_uptodate_page(struct folio *folio,
 		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (xas->xa_index >= max_idx)
 			goto unlock;
-		return &folio->page;
+		return folio;
 unlock:
 		folio_unlock(folio);
 skip:
@@ -3146,7 +3146,7 @@ static struct page *next_uptodate_page(struct folio *folio,
 	return NULL;
 }
 
-static inline struct page *first_map_page(struct address_space *mapping,
+static inline struct folio *first_map_page(struct address_space *mapping,
 					  struct xa_state *xas,
 					  pgoff_t end_pgoff)
 {
@@ -3154,7 +3154,7 @@ static inline struct page *first_map_page(struct address_space *mapping,
 				  mapping, xas, end_pgoff);
 }
 
-static inline struct page *next_map_page(struct address_space *mapping,
+static inline struct folio *next_map_page(struct address_space *mapping,
 					 struct xa_state *xas,
 					 pgoff_t end_pgoff)
 {
@@ -3171,16 +3171,17 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
-	struct page *head, *page;
+	struct folio *folio;
+	struct page *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
 
 	rcu_read_lock();
-	head = first_map_page(mapping, &xas, end_pgoff);
-	if (!head)
+	folio = first_map_page(mapping, &xas, end_pgoff);
+	if (!folio)
 		goto out;
 
-	if (filemap_map_pmd(vmf, head)) {
+	if (filemap_map_pmd(vmf, &folio->page)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3188,7 +3189,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
-		page = find_subpage(head, xas.xa_index);
+		page = folio_file_page(folio, xas.xa_index);
 		if (PageHWPoison(page))
 			goto unlock;
 
@@ -3209,12 +3210,12 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		do_set_pte(vmf, page, addr);
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, addr, vmf->pte);
-		unlock_page(head);
+		folio_unlock(folio);
 		continue;
 unlock:
-		unlock_page(head);
-		put_page(head);
-	} while ((head = next_map_page(mapping, &xas, end_pgoff)) != NULL);
+		folio_unlock(folio);
+		folio_put(folio);
+	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-- 
2.30.2

