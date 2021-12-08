Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411F646CC61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhLHE12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F162C0698CB
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HmCkLmM73d68sFeDxuolEllAHZE5BSsg2WY8bvzzTFU=; b=GETSPJyRFuJqsMvXyRm+P1Lwlv
        AfTlnrLL1Jmnr6Zc3Mr6VQOD2hH7FZ9wvo7KmbUZhu+cuMe+j7/wZcaMcVl5Nyls6mrJ6vXocaTBi
        gbMEM7mfbB1nCYm1B4a3CJ4Uyc5939G77ahZL1EYl/1eKiq+Ki4eSNpGqLOk9xRO0ALsBJaA6J4JI
        DFvD0u2OyPG96ggBWZXRAJaSP1H/2j56vCisr2P2LcbvMiwwGAvvbVdhWYfmuvYDjAECZNL2cv7L2
        FmFM/iQ0FGskhIBXu8E3WVqSNlLLgI4NKDcWr5D2Hlgvi0g0aBl8EDieDLKwaMy8/1KCvn6j0NC2U
        ldqa9yOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084Zd-9k; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 29/48] filemap: Use a folio in filemap_map_pages
Date:   Wed,  8 Dec 2021 04:22:37 +0000
Message-Id: <20211208042256.1923824-30-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
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
index 47880ec789f4..8cca04a79808 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3227,7 +3227,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	return false;
 }
 
-static struct page *next_uptodate_page(struct folio *folio,
+static struct folio *next_uptodate_page(struct folio *folio,
 				       struct address_space *mapping,
 				       struct xa_state *xas, pgoff_t end_pgoff)
 {
@@ -3258,7 +3258,7 @@ static struct page *next_uptodate_page(struct folio *folio,
 		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 		if (xas->xa_index >= max_idx)
 			goto unlock;
-		return &folio->page;
+		return folio;
 unlock:
 		folio_unlock(folio);
 skip:
@@ -3268,7 +3268,7 @@ static struct page *next_uptodate_page(struct folio *folio,
 	return NULL;
 }
 
-static inline struct page *first_map_page(struct address_space *mapping,
+static inline struct folio *first_map_page(struct address_space *mapping,
 					  struct xa_state *xas,
 					  pgoff_t end_pgoff)
 {
@@ -3276,7 +3276,7 @@ static inline struct page *first_map_page(struct address_space *mapping,
 				  mapping, xas, end_pgoff);
 }
 
-static inline struct page *next_map_page(struct address_space *mapping,
+static inline struct folio *next_map_page(struct address_space *mapping,
 					 struct xa_state *xas,
 					 pgoff_t end_pgoff)
 {
@@ -3293,16 +3293,17 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
@@ -3310,7 +3311,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
-		page = find_subpage(head, xas.xa_index);
+		page = folio_file_page(folio, xas.xa_index);
 		if (PageHWPoison(page))
 			goto unlock;
 
@@ -3331,12 +3332,12 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
2.33.0

