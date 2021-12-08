Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74FE46CC74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244262AbhLHE1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C95C0698D9
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Dq/cUR5SbTMPbPSqbVO2t1AYxOZw6BdCsm3TCwKwRHU=; b=ArN31cJb6BZgTNuvg/cFwnm+AO
        Ii58uFTd5p4H36ILo5WZR/HecCIZWdQ4zlIPuGCQg70/xzeQdtY1V63YSYox0RRz3o7Vp1GombxeY
        VyOiC9gB9HmL9+b4XqMy1hNnw7w6O8cKk/GKGMoSH8xVKwZmgCHjQ83w0xjBfA4Qq5E+cSMz9NHVy
        K4vwiJTFKSccjdDuHh/eW0cq/5Y+vR6We756Y4F7pjszb19Go83LwmeiLnOtI28kbPa5xhSxj+RBF
        SbtetWxJzX3mBpNIhWrd1vGfEYe07poUtljYsNYXcOHys7+bfRve7bZI+g3nLSc+1rzsNrj+9SbvD
        trzrjToQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU8-0084eL-GD; Wed, 08 Dec 2021 04:23:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 46/48] truncate,shmem: Handle truncates that split large folios
Date:   Wed,  8 Dec 2021 04:22:54 +0000
Message-Id: <20211208042256.1923824-47-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle folio splitting in the parts of the truncation functions which
already handle partial pages.  Factor all that code out into a new
function called truncate_inode_partial_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/internal.h |   2 +
 mm/shmem.c    | 107 ++++++++++++++++++---------------------------
 mm/truncate.c | 118 ++++++++++++++++++++++++++++++++------------------
 3 files changed, 120 insertions(+), 107 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7759d4ff3323..e989d8ceec91 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -119,6 +119,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
+bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
+		loff_t end);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/shmem.c b/mm/shmem.c
index bbfa2d05e787..7f0b07845c1f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -151,6 +151,19 @@ int shmem_getpage(struct inode *inode, pgoff_t index,
 		mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
 }
 
+int shmem_get_folio(struct inode *inode, pgoff_t index,
+		struct folio **foliop, enum sgp_type sgp)
+{
+	struct page *page = NULL;
+	int ret = shmem_getpage(inode, index, &page, sgp);
+
+	if (page)
+		*foliop = page_folio(page);
+	else
+		*foliop = NULL;
+	return ret;
+}
+
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -880,32 +893,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	}
 }
 
-/*
- * Check whether a hole-punch or truncation needs to split a huge page,
- * returning true if no split was required, or the split has been successful.
- *
- * Eviction (or truncation to 0 size) should never need to split a huge page;
- * but in rare cases might do so, if shmem_undo_range() failed to trylock on
- * head, and then succeeded to trylock on tail.
- *
- * A split can only succeed when there are no additional references on the
- * huge page: so the split below relies upon find_get_entries() having stopped
- * when it found a subpage of the huge page, without getting further references.
- */
-static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
-{
-	if (!PageTransCompound(page))
-		return true;
-
-	/* Just proceed to delete a huge page wholly within the range punched */
-	if (PageHead(page) &&
-	    page->index >= start && page->index + HPAGE_PMD_NR <= end)
-		return true;
-
-	/* Try to split huge page, so we can truly punch the hole or truncate */
-	return split_huge_page(page) >= 0;
-}
-
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -917,13 +904,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
-	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
-	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
+	struct folio *folio;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
+	bool partial_end;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -959,33 +946,34 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		index++;
 	}
 
-	if (partial_start) {
-		struct page *page = NULL;
-		shmem_getpage(inode, start - 1, &page, SGP_READ);
-		if (page) {
-			unsigned int top = PAGE_SIZE;
-			if (start > end) {
-				top = partial_end;
-				partial_end = 0;
-			}
-			zero_user_segment(page, partial_start, top);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
+	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
+	if (folio) {
+		bool same_page;
+
+		same_page = lend < folio_pos(folio) + folio_size(folio);
+		if (same_page)
+			partial_end = false;
+		folio_mark_dirty(folio);
+		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
+			start = folio->index + folio_nr_pages(folio);
+			if (same_page)
+				end = folio->index;
 		}
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
 	}
-	if (partial_end) {
-		struct page *page = NULL;
-		shmem_getpage(inode, end, &page, SGP_READ);
-		if (page) {
-			zero_user_segment(page, 0, partial_end);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
-		}
+
+	if (partial_end)
+		shmem_get_folio(inode, end, &folio, SGP_READ);
+	if (folio) {
+		folio_mark_dirty(folio);
+		if (!truncate_inode_partial_folio(folio, lstart, lend))
+			end = folio->index;
+		folio_unlock(folio);
+		folio_put(folio);
 	}
-	if (start >= end)
-		return;
 
 	index = start;
 	while (index < end) {
@@ -1019,8 +1007,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio_lock(folio);
 
 			if (!unfalloc || !folio_test_uptodate(folio)) {
-				struct page *page = folio_file_page(folio,
-									index);
 				if (folio_mapping(folio) != mapping) {
 					/* Page was replaced by swap: retry */
 					folio_unlock(folio);
@@ -1029,18 +1015,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				}
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
-				if (shmem_punch_compound(page, start, end))
-					truncate_inode_folio(mapping, folio);
-				else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-					/* Wipe the page and don't get stuck */
-					clear_highpage(page);
-					flush_dcache_page(page);
-					folio_mark_dirty(folio);
-					if (index <
-					    round_up(start, HPAGE_PMD_NR))
-						start = index + 1;
-				}
+				truncate_inode_folio(mapping, folio);
 			}
+			index = folio->index + folio_nr_pages(folio) - 1;
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
diff --git a/mm/truncate.c b/mm/truncate.c
index 2d1dae085acb..336c8d099efa 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -228,6 +228,58 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+/*
+ * Handle partial folios.  The folio may be entirely within the
+ * range if a split has raced with us.  If not, we zero the part of the
+ * folio that's within the [start, end] range, and then split the folio if
+ * it's large.  split_page_range() will discard pages which now lie beyond
+ * i_size, and we rely on the caller to discard pages which lie within a
+ * newly created hole.
+ *
+ * Returns false if splitting failed so the caller can avoid
+ * discarding the entire folio which is stubbornly unsplit.
+ */
+bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
+{
+	loff_t pos = folio_pos(folio);
+	unsigned int offset, length;
+
+	if (pos < start)
+		offset = start - pos;
+	else
+		offset = 0;
+	length = folio_size(folio);
+	if (pos + length <= (u64)end)
+		length = length - offset;
+	else
+		length = end + 1 - pos - offset;
+
+	folio_wait_writeback(folio);
+	if (length == folio_size(folio)) {
+		truncate_inode_folio(folio->mapping, folio);
+		return true;
+	}
+
+	/*
+	 * We may be zeroing pages we're about to discard, but it avoids
+	 * doing a complex calculation here, and then doing the zeroing
+	 * anyway if the page split fails.
+	 */
+	folio_zero_range(folio, offset, length);
+
+	cleancache_invalidate_page(folio->mapping, &folio->page);
+	if (folio_has_private(folio))
+		do_invalidatepage(&folio->page, offset, length);
+	if (!folio_test_large(folio))
+		return true;
+	if (split_huge_page(&folio->page) == 0)
+		return true;
+	if (folio_test_dirty(folio))
+		return false;
+	truncate_inode_folio(folio->mapping, folio);
+	return true;
+}
+
 /*
  * Used to get rid of pages on hardware memory corruption.
  */
@@ -294,20 +346,16 @@ void truncate_inode_pages_range(struct address_space *mapping,
 {
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
-	unsigned int	partial_start;	/* inclusive */
-	unsigned int	partial_end;	/* exclusive */
 	struct folio_batch fbatch;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
+	struct folio *	folio;
+	bool partial_end;
 
 	if (mapping_empty(mapping))
 		goto out;
 
-	/* Offsets within partial pages */
-	partial_start = lstart & (PAGE_SIZE - 1);
-	partial_end = (lend + 1) & (PAGE_SIZE - 1);
-
 	/*
 	 * 'start' and 'end' always covers the range of pages to be fully
 	 * truncated. Partial pages are covered with 'partial_start' at the
@@ -340,47 +388,33 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		cond_resched();
 	}
 
-	if (partial_start) {
-		struct page *page = find_lock_page(mapping, start - 1);
-		if (page) {
-			unsigned int top = PAGE_SIZE;
-			if (start > end) {
-				/* Truncation within a single page */
-				top = partial_end;
-				partial_end = 0;
-			}
-			wait_on_page_writeback(page);
-			zero_user_segment(page, partial_start, top);
-			cleancache_invalidate_page(mapping, page);
-			if (page_has_private(page))
-				do_invalidatepage(page, partial_start,
-						  top - partial_start);
-			unlock_page(page);
-			put_page(page);
+	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
+	if (folio) {
+		bool same_folio = lend < folio_pos(folio) + folio_size(folio);
+		if (same_folio)
+			partial_end = false;
+		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
+			start = folio->index + folio_nr_pages(folio);
+			if (same_folio)
+				end = folio->index;
 		}
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
 	}
-	if (partial_end) {
-		struct page *page = find_lock_page(mapping, end);
-		if (page) {
-			wait_on_page_writeback(page);
-			zero_user_segment(page, 0, partial_end);
-			cleancache_invalidate_page(mapping, page);
-			if (page_has_private(page))
-				do_invalidatepage(page, 0,
-						  partial_end);
-			unlock_page(page);
-			put_page(page);
-		}
+
+	if (partial_end)
+		folio = __filemap_get_folio(mapping, end, FGP_LOCK, 0);
+	if (folio) {
+		if (!truncate_inode_partial_folio(folio, lstart, lend))
+			end = folio->index;
+		folio_unlock(folio);
+		folio_put(folio);
 	}
-	/*
-	 * If the truncation happened within a single page no pages
-	 * will be released, just zeroed, so we can bail out now.
-	 */
-	if (start >= end)
-		goto out;
 
 	index = start;
-	for ( ; ; ) {
+	while (index < end) {
 		cond_resched();
 		if (!find_get_entries(mapping, index, end - 1, &fbatch,
 				indices)) {
-- 
2.33.0

