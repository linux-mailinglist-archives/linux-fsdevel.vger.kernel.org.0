Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF13B3C9830
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhGOFUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhGOFUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:20:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68660C06175F;
        Wed, 14 Jul 2021 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=flIpsNI9pEz0i4v6s1nQcu/zmXv7ucD3WLL0ysBrFV4=; b=MTaL5QmqTwvXLYRjXInQhfECKn
        LMYLQGrdCZ15BADiUIQCt8S7IEBMtR15uYRMiLvIwB0TjigHmJ6Ng1Wi1Mt+BRaX3yL2RIvdiIESY
        T9ah2IItnexdXvQbQodWTwoRo3g70u0aZy5fgBmcJPO4JP/XCtXptLepQMCT5OAA3kNRYewm1N+KO
        7TNi+WJx1OxbTJFpacmyKisWuHvz2l253ajLotJFoKU6079rOSCEGhDu0o3EU+0tdxXqbNafxcEXo
        7I8Spcp1dH5N6hOHmII1WGW6l6YpcPcPIEfeK0PuGSmHx6YQ5j70VMZHxH86Ew4qhJw1VlxavdLVW
        58Mu0avQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tji-0030VQ-Ao; Thu, 15 Jul 2021 05:16:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 123/138] mm/filemap: Use a folio in filemap_map_pages
Date:   Thu, 15 Jul 2021 04:36:49 +0100
Message-Id: <20210715033704.692967-124-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 545323a77c1c..1c0c2663c57d 100644
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

