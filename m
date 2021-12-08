Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300F46CC72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhLHE1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbhLHE0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F82C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2pAlN3Jv5xfx1nt9+sFDKAqPwC3DtkGU2AVdY8nIpv4=; b=YOZ7bCS4ftD9n4wBqnZ0CUI/Ml
        wuna8g/SEXz34ZZdfvhlcMcDQSQ6HrVvx0kIaofyHkpDzG00tci4avK0Ilx5VLBugixNEZEgb2+NH
        53iWfN4t1Nr71HwNF7OIktUSz2zLt+ksuLPb3G8H2PVFvCmYxfdp4Js/6ncEt2mX2nLAScjQvahs4
        +SseUp+3O3oogd0JglCNbO3EjZMSBT5OYKrTa9qq9oaIPsz3CZlXDQ4SNUAFBiLqDMFxoJUJdsHcd
        et0sfg1AQVW0bRVucRoMsH6W14Zxp0LK/7ba74CBTS/x7oTKBFg2C/0+0WhwWUTc/Bw5F4z8mqN4c
        ZOOEBbOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU7-0084cj-E6; Wed, 08 Dec 2021 04:23:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 41/48] filemap: Return only folios from find_get_entries()
Date:   Wed,  8 Dec 2021 04:22:49 +0000
Message-Id: <20211208042256.1923824-42-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callers have all been converted to work on folios, so convert
find_get_entries() to return a batch of folios instead of pages.
We also now return multiple large folios in a single call.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 43 +++++++++++------------------------------
 mm/internal.h           |  4 ++++
 mm/shmem.c              | 36 +++++++++++++++++++---------------
 mm/truncate.c           | 43 +++++++++++++++++++++++------------------
 5 files changed, 59 insertions(+), 69 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index eb6e58e106c8..d2259a1da51c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -592,8 +592,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 38726ca96f0e..4f00412d72d3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2015,57 +2015,36 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
  * @end:	The final page index (inclusive).
- * @pvec:	Where the resulting entries are placed.
+ * @fbatch:	Where the resulting entries are placed.
  * @indices:	The cache indices corresponding to the entries in @entries
  *
  * find_get_entries() will search for and return a batch of entries in
- * the mapping.  The entries are placed in @pvec.  find_get_entries()
- * takes a reference on any actual pages it returns.
+ * the mapping.  The entries are placed in @fbatch.  find_get_entries()
+ * takes a reference on any actual folios it returns.
  *
- * The search returns a group of mapping-contiguous page cache entries
- * with ascending indexes.  There may be holes in the indices due to
- * not-present pages.
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries or large folios.
  *
- * Any shadow entries of evicted pages, or swap entries from
+ * Any shadow entries of evicted folios, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
- * If it finds a Transparent Huge Page, head or tail, find_get_entries()
- * stops at that page: the caller is likely to have a better way to handle
- * the compound page as a whole, and then skip its extent, than repeatedly
- * calling find_get_entries() to return all its tails.
- *
- * Return: the number of pages and shadow entries which were found.
+ * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct folio *folio;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
-		struct page *page = &folio->page;
-		/*
-		 * Terminate early on finding a THP, to allow the caller to
-		 * handle it all at once; but continue if this is hugetlbfs.
-		 */
-		if (!xa_is_value(folio) && folio_test_large(folio) &&
-				!folio_test_hugetlb(folio)) {
-			page = folio_file_page(folio, xas.xa_index);
-			nr_entries = ret + 1;
-		}
-
-		indices[ret] = xas.xa_index;
-		pvec->pages[ret] = page;
-		if (++ret == nr_entries)
+		indices[fbatch->nr] = xas.xa_index;
+		if (!folio_batch_add(fbatch, folio))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return folio_batch_count(fbatch);
 }
 
 /**
diff --git a/mm/internal.h b/mm/internal.h
index d3c7b35934ed..36ad6ffe53bf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,8 @@
 #include <linux/pagemap.h>
 #include <linux/tracepoint-defs.h>
 
+struct folio_batch;
+
 /*
  * The set of flags that only affect watermark checking and reclaim
  * behaviour. This is used by the MM to obey the caller constraints
@@ -113,6 +115,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index dbef008fb6e5..e909c163fb38 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -920,6 +920,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
 	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
 	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
 	long nr_swaps_freed = 0;
 	pgoff_t index;
@@ -987,11 +988,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (start >= end)
 		return;
 
+	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, index, end - 1, &pvec,
+		if (!find_get_entries(mapping, index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -1000,14 +1002,14 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			index = start;
 			continue;
 		}
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			index = indices[i];
-			if (xa_is_value(page)) {
+			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, index, page)) {
+				if (shmem_free_swap(mapping, index, folio)) {
 					/* Swap was replaced by page: retry */
 					index--;
 					break;
@@ -1016,33 +1018,35 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				continue;
 			}
 
-			lock_page(page);
+			folio_lock(folio);
 
-			if (!unfalloc || !PageUptodate(page)) {
-				if (page_mapping(page) != mapping) {
+			if (!unfalloc || !folio_test_uptodate(folio)) {
+				struct page *page = folio_file_page(folio,
+									index);
+				if (folio_mapping(folio) != mapping) {
 					/* Page was replaced by swap: retry */
-					unlock_page(page);
+					folio_unlock(folio);
 					index--;
 					break;
 				}
-				VM_BUG_ON_PAGE(PageWriteback(page), page);
+				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
+						folio);
 				if (shmem_punch_compound(page, start, end))
-					truncate_inode_folio(mapping,
-							     page_folio(page));
+					truncate_inode_folio(mapping, folio);
 				else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 					/* Wipe the page and don't get stuck */
 					clear_highpage(page);
 					flush_dcache_page(page);
-					set_page_dirty(page);
+					folio_mark_dirty(folio);
 					if (index <
 					    round_up(start, HPAGE_PMD_NR))
 						start = index + 1;
 				}
 			}
-			unlock_page(page);
+			folio_unlock(folio);
 		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
+		folio_batch_remove_exceptionals(&fbatch);
+		folio_batch_release(&fbatch);
 		index++;
 	}
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 5370094641d6..357af144df63 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -108,6 +108,13 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 	pvec->nr = j;
 }
 
+static void truncate_folio_batch_exceptionals(struct address_space *mapping,
+				struct folio_batch *fbatch, pgoff_t *indices)
+{
+	truncate_exceptional_pvec_entries(mapping, (struct pagevec *)fbatch,
+						indices);
+}
+
 /*
  * Invalidate exceptional entry if easily possible. This handles exceptional
  * entries for invalidate_inode_pages().
@@ -297,6 +304,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	unsigned int	partial_start;	/* inclusive */
 	unsigned int	partial_end;	/* exclusive */
 	struct pagevec	pvec;
+	struct folio_batch fbatch;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
@@ -379,10 +387,11 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (start >= end)
 		goto out;
 
+	folio_batch_init(&fbatch);
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!find_get_entries(mapping, index, end - 1, &pvec,
+		if (!find_get_entries(mapping, index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
@@ -392,16 +401,14 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			continue;
 		}
 
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			struct folio *folio;
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
 
-			if (xa_is_value(page))
+			if (xa_is_value(folio))
 				continue;
-			folio = page_folio(page);
 
 			folio_lock(folio);
 			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
@@ -410,8 +417,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			folio_unlock(folio);
 			index = folio_index(folio) + folio_nr_pages(folio) - 1;
 		}
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
-		pagevec_release(&pvec);
+		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
+		folio_batch_release(&fbatch);
 		index++;
 	}
 
@@ -625,7 +632,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				  pgoff_t start, pgoff_t end)
 {
 	pgoff_t indices[PAGEVEC_SIZE];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index;
 	int i;
 	int ret = 0;
@@ -635,23 +642,21 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	if (mapping_empty(mapping))
 		goto out;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = start;
-	while (find_get_entries(mapping, index, end, &pvec, indices)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			struct folio *folio;
+	while (find_get_entries(mapping, index, end, &fbatch, indices)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
 			index = indices[i];
 
-			if (xa_is_value(page)) {
+			if (xa_is_value(folio)) {
 				if (!invalidate_exceptional_entry2(mapping,
-								   index, page))
+						index, folio))
 					ret = -EBUSY;
 				continue;
 			}
-			folio = page_folio(page);
 
 			if (!did_range_unmap && folio_mapped(folio)) {
 				/*
@@ -684,8 +689,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				ret = ret2;
 			folio_unlock(folio);
 		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
+		folio_batch_remove_exceptionals(&fbatch);
+		folio_batch_release(&fbatch);
 		cond_resched();
 		index++;
 	}
-- 
2.33.0

