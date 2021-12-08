Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8539A46CC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbhLHE1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34DC0698D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lNZrSgSL6qgITtDseTbflhdNUzinpmzsRmApffTrpVs=; b=jZSVSzz01fdqJru3kVCNcfaEDw
        f5oPA2b926j3xg7y6R58nMzkXIR+QZXoSQiWqXTFP9MhsQ6W4sLJkGuZE+JScvPoIE/l6bXttrl44
        yZ9Ovuy5fpn3Nldm+8dLQPfuxi3MDyhTnMdyP+Jv2EXUgAmUAqRYeLqFmDSecvgnNgW/S6jsGH2ge
        h9ueqx68nFVzmH+bHiYVn3C1E9pc6xK+0XrXh6jbdabyq4xO4Vi8vv/conyrLzoAIxrREMzaiyWSE
        +8xLK7e3ZdUlogQG9yEdY4QYSI5OMb7M0YNmYqsxfYP2o7OYbuJHB9g30zqvHgxfeAyUMaZ1IQQg0
        0USuxYZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU6-0084b9-BQ; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 35/48] truncate,shmem: Add truncate_inode_folio()
Date:   Wed,  8 Dec 2021 04:22:43 +0000
Message-Id: <20211208042256.1923824-36-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert all callers of truncate_inode_page() to call
truncate_inode_folio() instead, and move the declaration to mm/internal.h.
Move the assertion that the caller is not passing in a tail page to
generic_error_remove_page().  We can't entirely remove the struct page
from the callers yet because the page pointer in the pvec might be a
shadow/dax/swap entry instead of actually a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  1 -
 mm/internal.h      |  1 +
 mm/shmem.c         |  5 +++--
 mm/truncate.c      | 23 ++++++++++++-----------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9cdb26802fb..d8b7d7ed14dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1859,7 +1859,6 @@ extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
-int truncate_inode_page(struct address_space *mapping, struct page *page);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
 
diff --git a/mm/internal.h b/mm/internal.h
index 3f359f4830da..b05515d3b07b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -113,6 +113,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/shmem.c b/mm/shmem.c
index 40da9075374b..dbef008fb6e5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -950,7 +950,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			index += folio_nr_pages(folio) - 1;
 
 			if (!unfalloc || !folio_test_uptodate(folio))
-				truncate_inode_page(mapping, &folio->page);
+				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
 		pagevec_remove_exceptionals(&pvec);
@@ -1027,7 +1027,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				}
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
 				if (shmem_punch_compound(page, start, end))
-					truncate_inode_page(mapping, page);
+					truncate_inode_folio(mapping,
+							     page_folio(page));
 				else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 					/* Wipe the page and don't get stuck */
 					clear_highpage(page);
diff --git a/mm/truncate.c b/mm/truncate.c
index c98feea75a10..0000424fc56b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -218,12 +218,9 @@ invalidate_complete_page(struct address_space *mapping, struct page *page)
 	return ret;
 }
 
-int truncate_inode_page(struct address_space *mapping, struct page *page)
+int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	VM_BUG_ON_PAGE(PageTail(page), page);
-
-	if (page->mapping != mapping)
+	if (folio->mapping != mapping)
 		return -EIO;
 
 	truncate_cleanup_folio(folio);
@@ -236,6 +233,8 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
  */
 int generic_error_remove_page(struct address_space *mapping, struct page *page)
 {
+	VM_BUG_ON_PAGE(PageTail(page), page);
+
 	if (!mapping)
 		return -EINVAL;
 	/*
@@ -244,7 +243,7 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
 	 */
 	if (!S_ISREG(mapping->host->i_mode))
 		return -EIO;
-	return truncate_inode_page(mapping, page);
+	return truncate_inode_folio(mapping, page_folio(page));
 }
 EXPORT_SYMBOL(generic_error_remove_page);
 
@@ -395,18 +394,20 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			struct folio *folio;
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
 
 			if (xa_is_value(page))
 				continue;
+			folio = page_folio(page);
 
-			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
-			wait_on_page_writeback(page);
-			truncate_inode_page(mapping, page);
-			unlock_page(page);
+			folio_lock(folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			folio_wait_writeback(folio);
+			truncate_inode_folio(mapping, folio);
+			folio_unlock(folio);
 		}
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		pagevec_release(&pvec);
-- 
2.33.0

