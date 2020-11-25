Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC52C36D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKYCcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 21:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYCcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:32:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41618C0613D4;
        Tue, 24 Nov 2020 18:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P2TSdtkfgK7WesR1VipqV2PSDW2NVNCUIStDCNxcMGE=; b=g0HDyhdaQ2GWERfKQYYtUgfneH
        8IYnjCKMGGYjFG7vjJY/SC1JqP8PuKyTR8Bsa9p4TmZEiX2oRQgAAutLavqzW0N3DVXzSc3mg1YUC
        JTvxN367R27Sv2azAr3S6dYJQoUc1P2mRtcAX3JiNT/60aTFIYPGyBvHz92Af+QAADxUrTdxgcUqX
        3jNNTUY+efnqSe1l8U2sF+YrSgPPS4MmM+2Nr4Zpmbggm83EdMTwJjrVtT6QwPCRzUT/YzYKg40Ip
        zUbdrJ+MUBVx+yWT6EHz2IJiBLTnv02xKbT4cpcA1iDmiHqC357AQRqghJgPXwqJp7ZotPtDp3f65
        N8rS9VDg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khkbi-0003Z5-N9; Wed, 25 Nov 2020 02:32:34 +0000
Date:   Wed, 25 Nov 2020 02:32:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201125023234.GH4327@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
 <20201117153947.GL29991@casper.infradead.org>
 <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
 <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117234302.GC29991@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > I find both of these functions exceptionally confusing.  Does this
> > make it easier to understand?
> 
> Never mind, this is buggy.  I'll send something better tomorrow.

That took a week, not a day.  *sigh*.  At least this is shorter.

commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue Nov 17 10:45:18 2020 -0500

    fix mm-truncateshmem-handle-truncates-that-split-thps.patch

diff --git a/mm/internal.h b/mm/internal.h
index 75ae680d0a2c..4ac239e8c42c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -622,5 +622,6 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
-bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
+pgoff_t truncate_inode_partial_page(struct address_space *mapping,
+		struct page *page, loff_t start, loff_t end);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 5da4f1a3e663..6fd00948e592 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -866,26 +866,33 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
+	pgoff_t start, end;
 	struct pagevec pvec;
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct page *page;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
-	bool partial_end;
 
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
 			page = pvec.pages[i];
-
 			index = indices[i];
 
 			if (xa_is_value(page)) {
@@ -895,8 +902,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 								index, page);
 				continue;
 			}
-			index += thp_nr_pages(page) - 1;
-
 			if (!unfalloc || !PageUptodate(page))
 				truncate_inode_page(mapping, page);
 			unlock_page(page);
@@ -907,85 +912,60 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		index++;
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
-	page = NULL;
-	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
-	if (page) {
-		bool same_page;
-
-		page = thp_head(page);
-		same_page = lend < page_offset(page) + thp_size(page);
-		if (same_page)
-			partial_end = false;
-		set_page_dirty(page);
-		if (!truncate_inode_partial_page(page, lstart, lend)) {
-			start = page->index + thp_nr_pages(page);
-			if (same_page)
-				end = page->index;
-		}
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
-	}
-
-	if (partial_end)
-		shmem_getpage(inode, end, &page, SGP_READ);
-	if (page) {
-		page = thp_head(page);
-		set_page_dirty(page);
-		if (!truncate_inode_partial_page(page, lstart, lend))
-			end = page->index;
-		unlock_page(page);
-		put_page(page);
-	}
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
 			page = pvec.pages[i];
 
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
-				truncate_inode_page(mapping, page);
+				index = truncate_inode_partial_page(mapping,
+						page, lstart, lend);
+				if (index > end)
+					end = indices[i] - 1;
 			}
-			index = page->index + thp_nr_pages(page) - 1;
-			unlock_page(page);
 		}
+		index = indices[i - 1] + 1;
 		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		index++;
+		pagevec_reinit(&pvec);
 	}
 
 	spin_lock_irq(&info->lock);
diff --git a/mm/truncate.c b/mm/truncate.c
index ddb94fc0bc9e..e9fb4f1db837 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -225,19 +225,20 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
 }
 
 /*
- * Handle partial (transparent) pages.  The page may be entirely within the
- * range if a split has raced with us.  If not, we zero the part of the
- * page that's within the [start, end] range, and then split the page if
- * it's a THP.  split_page_range() will discard pages which now lie beyond
- * i_size, and we rely on the caller to discard pages which lie within a
+ * Handle partial (transparent) pages.  If the page is entirely within
+ * the range, we discard it.  If not, we split the page if it's a THP
+ * and zero the part of the page that's within the [start, end] range.
+ * split_page_range() will discard any of the subpages which now lie
+ * beyond i_size, and the caller will discard pages which lie within a
  * newly created hole.
  *
- * Returns false if THP splitting failed so the caller can avoid
- * discarding the entire page which is stubbornly unsplit.
+ * Return: The index after the current page.
  */
-bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
+pgoff_t truncate_inode_partial_page(struct address_space *mapping,
+		struct page *page, loff_t start, loff_t end)
 {
 	loff_t pos = page_offset(page);
+	pgoff_t next_index = page->index + thp_nr_pages(page);
 	unsigned int offset, length;
 
 	if (pos < start)
@@ -251,24 +252,33 @@ bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
 		length = end + 1 - pos - offset;
 
 	wait_on_page_writeback(page);
-	if (length == thp_size(page)) {
-		truncate_inode_page(page->mapping, page);
-		return true;
-	}
-
-	/*
-	 * We may be zeroing pages we're about to discard, but it avoids
-	 * doing a complex calculation here, and then doing the zeroing
-	 * anyway if the page split fails.
-	 */
-	zero_user(page, offset, length);
+	if (length == thp_size(page))
+		goto truncate;
 
 	cleancache_invalidate_page(page->mapping, page);
 	if (page_has_private(page))
 		do_invalidatepage(page, offset, length);
 	if (!PageTransHuge(page))
-		return true;
-	return split_huge_page(page) == 0;
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
 }
 
 /*
@@ -322,10 +332,6 @@ int invalidate_inode_page(struct page *page)
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
@@ -333,34 +339,24 @@ int invalidate_inode_page(struct page *page)
 void truncate_inode_pages_range(struct address_space *mapping,
 				loff_t lstart, loff_t lend)
 {
-	pgoff_t		start;		/* inclusive */
-	pgoff_t		end;		/* exclusive */
+	pgoff_t start, end;
 	struct pagevec	pvec;
 	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
 	struct page *	page;
-	bool partial_end;
 
 	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
 		goto out;
 
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
+	start = lstart >> PAGE_SHIFT;
+	page = find_lock_head(mapping, start);
+	if (page)
+		start = truncate_inode_partial_page(mapping, page, lstart,
+							lend);
+
+	/* 'end' includes a partial page */
+	end = lend / PAGE_SIZE;
 
 	pagevec_init(&pvec);
 	index = start;
@@ -377,37 +373,11 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		cond_resched();
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
-	page = find_lock_head(mapping, lstart >> PAGE_SHIFT);
-	if (page) {
-		bool same_page = lend < page_offset(page) + thp_size(page);
-		if (same_page)
-			partial_end = false;
-		if (!truncate_inode_partial_page(page, lstart, lend)) {
-			start = page->index + thp_nr_pages(page);
-			if (same_page)
-				end = page->index;
-		}
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
-	}
-
-	if (partial_end)
-		page = find_lock_head(mapping, end);
-	if (page) {
-		if (!truncate_inode_partial_page(page, lstart, lend))
-			end = page->index;
-		unlock_page(page);
-		put_page(page);
-	}
-
 	index = start;
-	while (index < end) {
+	while (index <= end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, index, end - 1, &pvec,
-				indices)) {
+		if (!find_get_entries(mapping, index, end, &pvec, indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -418,22 +388,19 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			page = pvec.pages[i];
-
-			/* We rely upon deletion not changing page->index */
-			index = indices[i];
-
 			if (xa_is_value(page))
 				continue;
 
 			lock_page(page);
-			index = page->index + thp_nr_pages(page) - 1;
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
