Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F162C4B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgKYXJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 18:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgKYXJC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:09:02 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15D2206F7;
        Wed, 25 Nov 2020 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606345741;
        bh=XyEMKAhR98h0oF1fmcxjuE/yOW29LI4jWRmgkcEPsP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IFS+y3CI2wRze1RwHyOzVZB1r7qv4W2t/PJN1M5j1R3CLdatO9Z3ekyjRos2ibJrA
         6QWsXOmHQmuWOX9SwNVz5K3Vtlyqe9Ik0mq3ipfZiBaIflYyFakhATJpMM+9wBleBV
         8lGkFYDQUUmMizjZnlU94X5OeHrx/hlyaFOU2WDc=
Date:   Wed, 25 Nov 2020 15:08:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-Id: <20201125150859.25adad8ff64db312681184bd@linux-foundation.org>
In-Reply-To: <20201125023234.GH4327@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
        <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
        <20201117153947.GL29991@casper.infradead.org>
        <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
        <20201117191513.GV29991@casper.infradead.org>
        <20201117234302.GC29991@casper.infradead.org>
        <20201125023234.GH4327@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Nov 2020 02:32:34 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > > I find both of these functions exceptionally confusing.  Does this
> > > make it easier to understand?
> > 
> > Never mind, this is buggy.  I'll send something better tomorrow.
> 
> That took a week, not a day.  *sigh*.  At least this is shorter.
> 
> commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Tue Nov 17 10:45:18 2020 -0500
> 
>     fix mm-truncateshmem-handle-truncates-that-split-thps.patch
> 

That's a big patch.  Big enough to put
mm-truncateshmem-handle-truncates-that-split-thps.patch back into
unreviewed state, methinks.  And big enough to have a changelog!

Below is the folded-together result for reviewers, please.

Is the changelog still accurate and complete?


From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: mm/truncate,shmem: handle truncates that split THPs

Handle THP splitting in the parts of the truncation functions which
already handle partial pages.  Factor all that code out into a new
function called truncate_inode_partial_page().

We lose the easy 'bail out' path if a truncate or hole punch is entirely
within a single page.  We can add some more complex logic to restore the
optimisation if it proves to be worthwhile.

[willy@infradead.org: fix]
  Link: https://lkml.kernel.org/r/20201125023234.GH4327@casper.infradead.org
Link: https://lkml.kernel.org/r/20201112212641.27837-16-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/internal.h |    2 
 mm/shmem.c    |  137 +++++++++++++----------------------------
 mm/truncate.c |  157 +++++++++++++++++++++++-------------------------
 3 files changed, 122 insertions(+), 174 deletions(-)

--- a/mm/internal.h~mm-truncateshmem-handle-truncates-that-split-thps
+++ a/mm/internal.h
@@ -623,4 +623,6 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+pgoff_t truncate_inode_partial_page(struct address_space *mapping,
+		struct page *page, loff_t start, loff_t end);
 #endif	/* __MM_INTERNAL_H */
--- a/mm/shmem.c~mm-truncateshmem-handle-truncates-that-split-thps
+++ a/mm/shmem.c
@@ -858,32 +858,6 @@ void shmem_unlock_mapping(struct address
 }
 
 /*
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
-/*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
@@ -892,26 +866,33 @@ static void shmem_undo_range(struct inod
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
-	unsigned int partial_start = lstart & (PAGE_SIZE - 1);
-	unsigned int partial_end = (lend + 1) & (PAGE_SIZE - 1);
+	pgoff_t start, end;
 	struct pagevec pvec;
 	pgoff_t indices[PAGEVEC_SIZE];
+	struct page *page;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
 
-	if (lend == -1)
-		end = -1;	/* unsigned, so actually very big */
+	page = NULL;
+	start = lstart >> PAGE_SHIFT;
+	shmem_getpage(inode, start, &page, SGP_READ);
+	if (page) {
+		page = thp_head(page);
+		set_page_dirty(page);
+		start = truncate_inode_partial_page(mapping, page, lstart,
+							lend);
+	}
+
+	/* 'end' includes a partial page */
+	end = lend / PAGE_SIZE;
 
 	pagevec_init(&pvec);
 	index = start;
 	while (index < end && find_lock_entries(mapping, index, end - 1,
-			&pvec, indices)) {
+							&pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-
+			page = pvec.pages[i];
 			index = indices[i];
 
 			if (xa_is_value(page)) {
@@ -921,8 +902,6 @@ static void shmem_undo_range(struct inod
 								index, page);
 				continue;
 			}
-			index += thp_nr_pages(page) - 1;
-
 			if (!unfalloc || !PageUptodate(page))
 				truncate_inode_page(mapping, page);
 			unlock_page(page);
@@ -933,90 +912,60 @@ static void shmem_undo_range(struct inod
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
-		}
-	}
-	if (partial_end) {
-		struct page *page = NULL;
-		shmem_getpage(inode, end, &page, SGP_READ);
-		if (page) {
-			zero_user_segment(page, 0, partial_end);
-			set_page_dirty(page);
-			unlock_page(page);
-			put_page(page);
-		}
-	}
-	if (start >= end)
-		return;
-
 	index = start;
-	while (index < end) {
+	while (index <= end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, index, end - 1, &pvec,
-				indices)) {
+		if (!find_get_entries(mapping, index, end, &pvec, indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
-			if (index == start || end != -1)
+			if (index == start || lend != (loff_t)-1)
 				break;
 			/* But if truncating, restart to make sure all gone */
 			index = start;
 			continue;
 		}
+
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			page = pvec.pages[i];
 
-			index = indices[i];
 			if (xa_is_value(page)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, index, page)) {
-					/* Swap was replaced by page: retry */
-					index--;
-					break;
+				index = indices[i];
+				if (index == end) {
+					/* Partial page swapped out? */
+					shmem_getpage(inode, end, &page,
+								SGP_READ);
+				} else {
+					if (shmem_free_swap(mapping, index,
+								page)) {
+						/* Swap replaced: retry */
+						break;
+					}
+					nr_swaps_freed++;
+					continue;
 				}
-				nr_swaps_freed++;
-				continue;
+			} else {
+				lock_page(page);
 			}
 
-			lock_page(page);
-
 			if (!unfalloc || !PageUptodate(page)) {
 				if (page_mapping(page) != mapping) {
 					/* Page was replaced by swap: retry */
 					unlock_page(page);
-					index--;
+					put_page(page);
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
+				index = truncate_inode_partial_page(mapping,
+						page, lstart, lend);
+				if (index > end)
+					end = indices[i] - 1;
 			}
-			unlock_page(page);
 		}
+		index = indices[i - 1] + 1;
 		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		index++;
+		pagevec_reinit(&pvec);
 	}
 
 	spin_lock_irq(&info->lock);
--- a/mm/truncate.c~mm-truncateshmem-handle-truncates-that-split-thps
+++ a/mm/truncate.c
@@ -225,6 +225,63 @@ int truncate_inode_page(struct address_s
 }
 
 /*
+ * Handle partial (transparent) pages.  If the page is entirely within
+ * the range, we discard it.  If not, we split the page if it's a THP
+ * and zero the part of the page that's within the [start, end] range.
+ * split_page_range() will discard any of the subpages which now lie
+ * beyond i_size, and the caller will discard pages which lie within a
+ * newly created hole.
+ *
+ * Return: The index after the current page.
+ */
+pgoff_t truncate_inode_partial_page(struct address_space *mapping,
+		struct page *page, loff_t start, loff_t end)
+{
+	loff_t pos = page_offset(page);
+	pgoff_t next_index = page->index + thp_nr_pages(page);
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
+	if (length == thp_size(page))
+		goto truncate;
+
+	cleancache_invalidate_page(page->mapping, page);
+	if (page_has_private(page))
+		do_invalidatepage(page, offset, length);
+	if (!PageTransHuge(page))
+		goto zero;
+	page += offset / PAGE_SIZE;
+	if (split_huge_page(page) < 0) {
+		page -= offset / PAGE_SIZE;
+		goto zero;
+	}
+	next_index = page->index + 1;
+	offset %= PAGE_SIZE;
+	if (offset == 0 && length >= PAGE_SIZE)
+		goto truncate;
+	length = PAGE_SIZE - offset;
+zero:
+	zero_user(page, offset, length);
+	goto out;
+truncate:
+	truncate_inode_page(mapping, page);
+out:
+	unlock_page(page);
+	put_page(page);
+	return next_index;
+}
+
+/*
  * Used to get rid of pages on hardware memory corruption.
  */
 int generic_error_remove_page(struct address_space *mapping, struct page *page)
@@ -275,10 +332,6 @@ int invalidate_inode_page(struct page *p
  * The first pass will remove most pages, so the search cost of the second pass
  * is low.
  *
- * We pass down the cache-hot hint to the page freeing code.  Even if the
- * mapping is large, it is probably the case that the final pages are the most
- * recently touched, and freeing happens in ascending file offset order.
- *
  * Note that since ->invalidatepage() accepts range to invalidate
  * truncate_inode_pages_range is able to handle cases where lend + 1 is not
  * page aligned properly.
@@ -286,38 +339,24 @@ int invalidate_inode_page(struct page *p
 void truncate_inode_pages_range(struct address_space *mapping,
 				loff_t lstart, loff_t lend)
 {
-	pgoff_t		start;		/* inclusive */
-	pgoff_t		end;		/* exclusive */
-	unsigned int	partial_start;	/* inclusive */
-	unsigned int	partial_end;	/* exclusive */
+	pgoff_t start, end;
 	struct pagevec	pvec;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
+	struct page *	page;
 
 	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
 		goto out;
 
-	/* Offsets within partial pages */
-	partial_start = lstart & (PAGE_SIZE - 1);
-	partial_end = (lend + 1) & (PAGE_SIZE - 1);
+	start = lstart >> PAGE_SHIFT;
+	page = find_lock_head(mapping, start);
+	if (page)
+		start = truncate_inode_partial_page(mapping, page, lstart,
+							lend);
 
-	/*
-	 * 'start' and 'end' always covers the range of pages to be fully
-	 * truncated. Partial pages are covered with 'partial_start' at the
-	 * start of the range and 'partial_end' at the end of the range.
-	 * Note that 'end' is exclusive while 'lend' is inclusive.
-	 */
-	start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (lend == -1)
-		/*
-		 * lend == -1 indicates end-of-file so we have to set 'end'
-		 * to the highest possible pgoff_t and since the type is
-		 * unsigned we're using -1.
-		 */
-		end = -1;
-	else
-		end = (lend + 1) >> PAGE_SHIFT;
+	/* 'end' includes a partial page */
+	end = lend / PAGE_SIZE;
 
 	pagevec_init(&pvec);
 	index = start;
@@ -334,50 +373,11 @@ void truncate_inode_pages_range(struct a
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
-		}
-	}
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
-	}
-	/*
-	 * If the truncation happened within a single page no pages
-	 * will be released, just zeroed, so we can bail out now.
-	 */
-	if (start >= end)
-		goto out;
-
 	index = start;
-	for ( ; ; ) {
+	while (index <= end) {
 		cond_resched();
-		if (!find_get_entries(mapping, index, end - 1, &pvec,
-				indices)) {
+
+		if (!find_get_entries(mapping, index, end, &pvec, indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -387,23 +387,20 @@ void truncate_inode_pages_range(struct a
 		}
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-
-			/* We rely upon deletion not changing page->index */
-			index = indices[i];
-
+			page = pvec.pages[i];
 			if (xa_is_value(page))
 				continue;
 
 			lock_page(page);
-			WARN_ON(page_to_index(page) != index);
-			wait_on_page_writeback(page);
-			truncate_inode_page(mapping, page);
-			unlock_page(page);
+			index = truncate_inode_partial_page(mapping, page,
+							lstart, lend);
+			/* Couldn't split a THP? */
+			if (index > end)
+				end = indices[i] - 1;
 		}
+		index = indices[i - 1] + 1;
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
-		pagevec_release(&pvec);
-		index++;
+		pagevec_reinit(&pvec);
 	}
 
 out:
_

