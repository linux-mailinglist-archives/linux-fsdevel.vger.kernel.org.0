Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD746CC82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbhLHE3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B5C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=biuqP+A2N13cdbfNyPGAJFwZ1O/isFh5dNQAV3yeGDo=; b=qKFhICvbMl1ap6IAkDrGUz9TD4
        N1ddfkarBoa3ssq03SzygQ4fhC9U42i9NYefVgSU04L8BIZw/Sg6jLVKMo3dgS75Vu4V5YwiSjt/5
        FibbRS9EJ1gFtkTt1VhIoaOHAZzUYG0Lv3wVUDnq0TFdv0x+uwjpqtUjCn2dXzAuqJB8BycGX4W0t
        CDYO7vp8F8oZaMnX9+ljjimLdB15N2YzyKP8ntH3ByrkBMfJvIlkLh2q4RaXIniuiQO0Y4CTh7VC/
        1gzlK8QhPGTMRj18aZSh1ve86H+P0z3i46muwZD9kEcxoegvadKvxODhBZaHt2cQw64w8yhMCdIjn
        QxEQRouQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU7-0084d9-Jx; Wed, 08 Dec 2021 04:23:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 42/48] mm: Convert find_lock_entries() to use a folio_batch
Date:   Wed,  8 Dec 2021 04:22:50 +0000
Message-Id: <20211208042256.1923824-43-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

find_lock_entries() already only returned the head page of folios, so
convert it to return a folio_batch instead of a pagevec.  That cascades
through converting truncate_inode_pages_range() to
delete_from_page_cache_batch() and page_cache_delete_batch().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  4 +--
 mm/filemap.c            | 60 ++++++++++++++++++------------------
 mm/internal.h           |  2 +-
 mm/shmem.c              | 14 ++++-----
 mm/truncate.c           | 67 ++++++++++++++++++-----------------------
 5 files changed, 67 insertions(+), 80 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d2259a1da51c..6e038811f4c8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -16,7 +16,7 @@
 #include <linux/hardirq.h> /* for in_interrupt() */
 #include <linux/hugetlb_inline.h>
 
-struct pagevec;
+struct folio_batch;
 
 static inline bool mapping_empty(struct address_space *mapping)
 {
@@ -936,7 +936,7 @@ static inline void __delete_from_page_cache(struct page *page, void *shadow)
 }
 void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
-				  struct pagevec *pvec);
+				  struct folio_batch *fbatch);
 int try_to_release_page(struct page *page, gfp_t gfp);
 bool filemap_release_folio(struct folio *folio, gfp_t gfp);
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
diff --git a/mm/filemap.c b/mm/filemap.c
index 4f00412d72d3..89a10624e361 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -270,30 +270,29 @@ void filemap_remove_folio(struct folio *folio)
 }
 
 /*
- * page_cache_delete_batch - delete several pages from page cache
- * @mapping: the mapping to which pages belong
- * @pvec: pagevec with pages to delete
+ * page_cache_delete_batch - delete several folios from page cache
+ * @mapping: the mapping to which folios belong
+ * @fbatch: batch of folios to delete
  *
- * The function walks over mapping->i_pages and removes pages passed in @pvec
- * from the mapping. The function expects @pvec to be sorted by page index
- * and is optimised for it to be dense.
- * It tolerates holes in @pvec (mapping entries at those indices are not
- * modified). The function expects only THP head pages to be present in the
- * @pvec.
+ * The function walks over mapping->i_pages and removes folios passed in
+ * @fbatch from the mapping. The function expects @fbatch to be sorted
+ * by page index and is optimised for it to be dense.
+ * It tolerates holes in @fbatch (mapping entries at those indices are not
+ * modified).
  *
  * The function expects the i_pages lock to be held.
  */
 static void page_cache_delete_batch(struct address_space *mapping,
-			     struct pagevec *pvec)
+			     struct folio_batch *fbatch)
 {
-	XA_STATE(xas, &mapping->i_pages, pvec->pages[0]->index);
+	XA_STATE(xas, &mapping->i_pages, fbatch->folios[0]->index);
 	int total_pages = 0;
 	int i = 0;
 	struct folio *folio;
 
 	mapping_set_update(&xas, mapping);
 	xas_for_each(&xas, folio, ULONG_MAX) {
-		if (i >= pagevec_count(pvec))
+		if (i >= folio_batch_count(fbatch))
 			break;
 
 		/* A swap/dax/shadow entry got inserted? Skip it. */
@@ -306,9 +305,9 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		 * means our page has been removed, which shouldn't be
 		 * possible because we're holding the PageLock.
 		 */
-		if (&folio->page != pvec->pages[i]) {
+		if (folio != fbatch->folios[i]) {
 			VM_BUG_ON_FOLIO(folio->index >
-						pvec->pages[i]->index, folio);
+					fbatch->folios[i]->index, folio);
 			continue;
 		}
 
@@ -316,12 +315,11 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		if (folio->index == xas.xa_index)
 			folio->mapping = NULL;
-		/* Leave page->index set: truncation lookup relies on it */
+		/* Leave folio->index set: truncation lookup relies on it */
 
 		/*
-		 * Move to the next page in the vector if this is a regular
-		 * page or the index is of the last sub-page of this compound
-		 * page.
+		 * Move to the next folio in the batch if this is a regular
+		 * folio or the index is of the last sub-page of this folio.
 		 */
 		if (folio->index + folio_nr_pages(folio) - 1 == xas.xa_index)
 			i++;
@@ -332,29 +330,29 @@ static void page_cache_delete_batch(struct address_space *mapping,
 }
 
 void delete_from_page_cache_batch(struct address_space *mapping,
-				  struct pagevec *pvec)
+				  struct folio_batch *fbatch)
 {
 	int i;
 
-	if (!pagevec_count(pvec))
+	if (!folio_batch_count(fbatch))
 		return;
 
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct folio *folio = page_folio(pvec->pages[i]);
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
 
 		trace_mm_filemap_delete_from_page_cache(folio);
 		filemap_unaccount_folio(mapping, folio);
 	}
-	page_cache_delete_batch(mapping, pvec);
+	page_cache_delete_batch(mapping, fbatch);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
-	for (i = 0; i < pagevec_count(pvec); i++)
-		filemap_free_folio(mapping, page_folio(pvec->pages[i]));
+	for (i = 0; i < folio_batch_count(fbatch); i++)
+		filemap_free_folio(mapping, fbatch->folios[i]);
 }
 
 int filemap_check_errors(struct address_space *mapping)
@@ -2052,8 +2050,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * @mapping:	The address_space to search.
  * @start:	The starting page cache index.
  * @end:	The final page index (inclusive).
- * @pvec:	Where the resulting entries are placed.
- * @indices:	The cache indices of the entries in @pvec.
+ * @fbatch:	Where the resulting entries are placed.
+ * @indices:	The cache indices of the entries in @fbatch.
  *
  * find_lock_entries() will return a batch of entries from @mapping.
  * Swap, shadow and DAX entries are included.  Folios are returned
@@ -2068,7 +2066,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * Return: The number of entries which were found.
  */
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct folio *folio;
@@ -2088,8 +2086,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
 					folio);
 		}
-		indices[pvec->nr] = xas.xa_index;
-		if (!pagevec_add(pvec, &folio->page))
+		indices[fbatch->nr] = xas.xa_index;
+		if (!folio_batch_add(fbatch, folio))
 			break;
 		goto next;
 unlock:
@@ -2106,7 +2104,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 	}
 	rcu_read_unlock();
 
-	return pagevec_count(pvec);
+	return folio_batch_count(fbatch);
 }
 
 /**
diff --git a/mm/internal.h b/mm/internal.h
index 36ad6ffe53bf..7759d4ff3323 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -114,7 +114,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 }
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index e909c163fb38..bbfa2d05e787 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -919,7 +919,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
 	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
 	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
-	struct pagevec pvec;
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
 	long nr_swaps_freed = 0;
@@ -932,12 +931,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (info->fallocend > start && info->fallocend <= end && !unfalloc)
 		info->fallocend = start;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, index, end - 1,
-			&pvec, indices)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct folio *folio = (struct folio *)pvec.pages[i];
+			&fbatch, indices)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			index = indices[i];
 
@@ -954,8 +953,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
+		folio_batch_remove_exceptionals(&fbatch);
+		folio_batch_release(&fbatch);
 		cond_resched();
 		index++;
 	}
@@ -988,7 +987,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	if (start >= end)
 		return;
 
-	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end) {
 		cond_resched();
diff --git a/mm/truncate.c b/mm/truncate.c
index 357af144df63..e7f5762c43d3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -56,11 +56,11 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 
 /*
  * Unconditionally remove exceptional entries. Usually called from truncate
- * path. Note that the pagevec may be altered by this function by removing
+ * path. Note that the folio_batch may be altered by this function by removing
  * exceptional entries similar to what pagevec_remove_exceptionals does.
  */
-static void truncate_exceptional_pvec_entries(struct address_space *mapping,
-				struct pagevec *pvec, pgoff_t *indices)
+static void truncate_folio_batch_exceptionals(struct address_space *mapping,
+				struct folio_batch *fbatch, pgoff_t *indices)
 {
 	int i, j;
 	bool dax;
@@ -69,11 +69,11 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 	if (shmem_mapping(mapping))
 		return;
 
-	for (j = 0; j < pagevec_count(pvec); j++)
-		if (xa_is_value(pvec->pages[j]))
+	for (j = 0; j < folio_batch_count(fbatch); j++)
+		if (xa_is_value(fbatch->folios[j]))
 			break;
 
-	if (j == pagevec_count(pvec))
+	if (j == folio_batch_count(fbatch))
 		return;
 
 	dax = dax_mapping(mapping);
@@ -82,12 +82,12 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		xa_lock_irq(&mapping->i_pages);
 	}
 
-	for (i = j; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+	for (i = j; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
 		pgoff_t index = indices[i];
 
-		if (!xa_is_value(page)) {
-			pvec->pages[j++] = page;
+		if (!xa_is_value(folio)) {
+			fbatch->folios[j++] = folio;
 			continue;
 		}
 
@@ -96,7 +96,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 			continue;
 		}
 
-		__clear_shadow_entry(mapping, index, page);
+		__clear_shadow_entry(mapping, index, folio);
 	}
 
 	if (!dax) {
@@ -105,14 +105,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 			inode_add_lru(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 	}
-	pvec->nr = j;
-}
-
-static void truncate_folio_batch_exceptionals(struct address_space *mapping,
-				struct folio_batch *fbatch, pgoff_t *indices)
-{
-	truncate_exceptional_pvec_entries(mapping, (struct pagevec *)fbatch,
-						indices);
+	fbatch->nr = j;
 }
 
 /*
@@ -303,7 +296,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		end;		/* exclusive */
 	unsigned int	partial_start;	/* inclusive */
 	unsigned int	partial_end;	/* exclusive */
-	struct pagevec	pvec;
 	struct folio_batch fbatch;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
@@ -333,18 +325,18 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	else
 		end = (lend + 1) >> PAGE_SHIFT;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, index, end - 1,
-			&pvec, indices)) {
-		index = indices[pagevec_count(&pvec) - 1] + 1;
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
-		for (i = 0; i < pagevec_count(&pvec); i++)
-			truncate_cleanup_folio(page_folio(pvec.pages[i]));
-		delete_from_page_cache_batch(mapping, &pvec);
-		for (i = 0; i < pagevec_count(&pvec); i++)
-			unlock_page(pvec.pages[i]);
-		pagevec_release(&pvec);
+			&fbatch, indices)) {
+		index = indices[folio_batch_count(&fbatch) - 1] + 1;
+		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			truncate_cleanup_folio(fbatch.folios[i]);
+		delete_from_page_cache_batch(mapping, &fbatch);
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			folio_unlock(fbatch.folios[i]);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
@@ -387,7 +379,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (start >= end)
 		goto out;
 
-	folio_batch_init(&fbatch);
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
@@ -489,16 +480,16 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
 {
 	pgoff_t indices[PAGEVEC_SIZE];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index = start;
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
 
-	pagevec_init(&pvec);
-	while (find_lock_entries(mapping, index, end, &pvec, indices)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+	folio_batch_init(&fbatch);
+	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
@@ -525,8 +516,8 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 			}
 			count += ret;
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

