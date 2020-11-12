Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF982B105A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKLV1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKLV0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BAC0613D4;
        Thu, 12 Nov 2020 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Vcc2Gm3awZbAsTWopBxfrDFjg5Xf0IYed41wGhvKh4w=; b=t+odpWwArKJCoToaTQXc1TtYwJ
        vnPXlIV04BRYtWjzQcbQAe+dC06/sDjllkr88i5zIt4qYXW4YC+S2vlZUlPko4mHXGR85ywUxCP7D
        jbFMULCWPXlsAZeeZEK8XjTZ4vJW+A2G8mY9SymRRLakj1QN/N8quhrUcmWfm3Qb0LZ+uq2aKEpWc
        zjy9pUEBVTeFog0Hq17OFicyoBgDTrRL88m8BkRRABuzflAs1Odtl0i+gAwskUUFsyjg1QwW89vhT
        B/5W+4QNHp6wg5ssBWWKIB0Xm/Ai1Yt7NS9jznrTMhHsKahb1gaHB6E8kCACROcR/mbN4xfSzTPMp
        J8FEZNIg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7G-0007Hr-Nt; Thu, 12 Nov 2020 21:26:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs
Date:   Thu, 12 Nov 2020 21:26:40 +0000
Message-Id: <20201112212641.27837-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle THP splitting in the parts of the truncation functions which
already handle partial pages.  Factor all that code out into a new
function called truncate_inode_partial_page().

We lose the easy 'bail out' path if a truncate or hole punch is entirely
within a single page.  We can add some more complex logic to restore
the optimisation if it proves to be worthwhile.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/internal.h |   1 +
 mm/shmem.c    |  97 ++++++++++++++---------------------------
 mm/truncate.c | 118 +++++++++++++++++++++++++++++++-------------------
 3 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3547fed59d51..cb7487efa856 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -618,4 +618,5 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index e01457988dd6..25fe257e56c0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -857,32 +857,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
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
@@ -894,13 +868,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
-	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
-	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
 	struct pagevec pvec;
 	pgoff_t indices[PAGEVEC_SIZE];
+	struct page *page;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
+	bool partial_end;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -910,7 +884,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end && find_lock_entries(mapping, index, end - 1,
 			&pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			page = pvec.pages[i];
 
 			index = indices[i];
 
@@ -933,33 +907,37 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
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
+	page = NULL;
+	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
+	if (page) {
+		bool same_page;
+
+		page = thp_head(page);
+		same_page = lend < page_offset(page) + thp_size(page);
+		if (same_page)
+			partial_end = false;
+		set_page_dirty(page);
+		if (!truncate_inode_partial_page(page, lstart, lend)) {
+			start = page->index + thp_nr_pages(page);
+			if (same_page)
+				end = page->index;
 		}
+		unlock_page(page);
+		put_page(page);
+		page = NULL;
 	}
-	if (partial_end) {
-		struct page *page = NULL;
+
+	if (partial_end)
 		shmem_getpage(inode, end, &page, SGP_READ);
-		if (page) {
-			zero_user_segment(page, 0, partial_end);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
-		}
+	if (page) {
+		page = thp_head(page);
+		set_page_dirty(page);
+		if (!truncate_inode_partial_page(page, lstart, lend))
+			end = page->index;
+		unlock_page(page);
+		put_page(page);
 	}
-	if (start >= end)
-		return;
 
 	index = start;
 	while (index < end) {
@@ -975,7 +953,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			continue;
 		}
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			page = pvec.pages[i];
 
 			index = indices[i];
 			if (xa_is_value(page)) {
@@ -1000,18 +978,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					break;
 				}
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
-				if (shmem_punch_compound(page, start, end))
-					truncate_inode_page(mapping, page);
-				else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-					/* Wipe the page and don't get stuck */
-					clear_highpage(page);
-					flush_dcache_page(page);
-					set_page_dirty(page);
-					if (index <
-					    round_up(start, HPAGE_PMD_NR))
-						start = index + 1;
-				}
+				truncate_inode_page(mapping, page);
 			}
+			index = page->index + thp_nr_pages(page) - 1;
 			unlock_page(page);
 		}
 		pagevec_remove_exceptionals(&pvec);
diff --git a/mm/truncate.c b/mm/truncate.c
index 68b7630e1fc4..288781e41a7b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -224,6 +224,53 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
 	return 0;
 }
 
+/*
+ * Handle partial (transparent) pages.  The page may be entirely within the
+ * range if a split has raced with us.  If not, we zero the part of the
+ * page that's within the [start, end] range, and then split the page if
+ * it's a THP.  split_page_range() will discard pages which now lie beyond
+ * i_size, and we rely on the caller to discard pages which lie within a
+ * newly created hole.
+ *
+ * Returns false if THP splitting failed so the caller can avoid
+ * discarding the entire page which is stubbornly unsplit.
+ */
+bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
+{
+	loff_t pos = page_offset(page);
+	unsigned int offset, length;
+
+	if (pos < start)
+		offset = start - pos;
+	else
+		offset = 0;
+	length = thp_size(page);
+	if (pos + length <= (u64)end)
+		length = length - offset;
+	else
+		length = end + 1 - pos - offset;
+
+	wait_on_page_writeback(page);
+	if (length == thp_size(page)) {
+		truncate_inode_page(page->mapping, page);
+		return true;
+	}
+
+	/*
+	 * We may be zeroing pages we're about to discard, but it avoids
+	 * doing a complex calculation here, and then doing the zeroing
+	 * anyway if the page split fails.
+	 */
+	zero_user(page, offset, length);
+
+	cleancache_invalidate_page(page->mapping, page);
+	if (page_has_private(page))
+		do_invalidatepage(page, offset, length);
+	if (!PageTransHuge(page))
+		return true;
+	return split_huge_page(page) == 0;
+}
+
 /*
  * Used to get rid of pages on hardware memory corruption.
  */
@@ -288,20 +335,16 @@ void truncate_inode_pages_range(struct address_space *mapping,
 {
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
-	unsigned int	partial_start;	/* inclusive */
-	unsigned int	partial_end;	/* exclusive */
 	struct pagevec	pvec;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
+	struct page *	page;
+	bool partial_end;
 
 	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
 		goto out;
 
-	/* Offsets within partial pages */
-	partial_start = lstart & (PAGE_SIZE - 1);
-	partial_end = (lend + 1) & (PAGE_SIZE - 1);
-
 	/*
 	 * 'start' and 'end' always covers the range of pages to be fully
 	 * truncated. Partial pages are covered with 'partial_start' at the
@@ -334,48 +377,35 @@ void truncate_inode_pages_range(struct address_space *mapping,
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
+	page = find_lock_head(mapping, lstart >> PAGE_SHIFT);
+	if (page) {
+		bool same_page = lend < page_offset(page) + thp_size(page);
+		if (same_page)
+			partial_end = false;
+		if (!truncate_inode_partial_page(page, lstart, lend)) {
+			start = page->index + thp_nr_pages(page);
+			if (same_page)
+				end = page->index;
 		}
+		unlock_page(page);
+		put_page(page);
+		page = NULL;
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
+		page = find_lock_head(mapping, end);
+	if (page) {
+		if (!truncate_inode_partial_page(page, lstart, lend))
+			end = page->index;
+		unlock_page(page);
+		put_page(page);
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
+
 		if (!find_get_entries(mapping, index, end - 1, &pvec,
 				indices)) {
 			/* If all gone from start onwards, we're done */
@@ -387,7 +417,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		}
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
@@ -396,7 +426,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 				continue;
 
 			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
+			index = page->index + thp_nr_pages(page) - 1;
 			wait_on_page_writeback(page);
 			truncate_inode_page(mapping, page);
 			unlock_page(page);
-- 
2.28.0

