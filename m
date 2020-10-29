Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E29F554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgJ2TeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJ2TeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6AC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E8k46S1XYZz+Wfo1T6X7i3JTr3IK8+TDAKapZ72AyOs=; b=udw+dk7pm/N9ER8Rl8D/7iZ91T
        vy9wV4X2NqwNDf3Q77wj1o8eS7ZSHJgHgKRHrIbJ9zK4/RwGHpEcuEiTDmmiiWTotgMYiy79/nT05
        RrQVLhYuRgcje3nI+rGkTFtWv3T4zXjq5vGCF0N2bklEvMGQwO8NjwEBDGldpWwymrFN+Bwc+rxJX
        C9uxsWbTwuZqiby4mmJaXjDZdpxeo4jfx10zwdVHO+MbMDaSn6I879b2CERo7DlEufGTyFEakUddy
        yxdcs4jVHbYGCrIuVNecavjfHY2hztxRK9P5kbmaQ9JS1rHixWjN+14L4pBxWZXA7eet1o3ZoLznm
        V5wC3Mew==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgV-0007b8-Uo; Thu, 29 Oct 2020 19:34:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/19] mm: Use multi-index entries in the page cache
Date:   Thu, 29 Oct 2020 19:33:48 +0000
Message-Id: <20201029193405.29125-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently store order-N THPs as 2^N consecutive entries.  While this
consumes rather more memory than necessary, it also turns out to be buggy.
A writeback operation which starts in the middle of a dirty THP will not
notice as the dirty bit is only set on the head index.  With multi-index
entries, the dirty bit will be found no matter where in the THP the
iteration starts.

This does end up simplifying the page cache slightly, although not as
much as I had hoped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 -------
 mm/filemap.c            | 62 ++++++++++++++++++++++++-----------------
 mm/huge_memory.c        | 19 ++++++++++---
 mm/khugepaged.c         | 12 +++++++-
 mm/migrate.c            |  8 ------
 mm/shmem.c              | 11 ++------
 6 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 62b759f92e36..00288ed24698 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -912,16 +912,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		array[i++] = page;
 		rac->_batch_count += thp_nr_pages(page);
-
-		/*
-		 * The page cache isn't using multi-index entries yet,
-		 * so the xas cursor needs to be manually moved to the
-		 * next index.  This can be removed once the page cache
-		 * is converted.
-		 */
-		if (PageHead(page))
-			xas_set(&xas, rac->_index + rac->_batch_count);
-
 		if (i == array_sz)
 			break;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c4db536fff4..8537ee86f99f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -127,13 +127,12 @@ static void page_cache_delete(struct address_space *mapping,
 
 	/* hugetlb pages are represented by a single entry in the xarray */
 	if (!PageHuge(page)) {
-		xas_set_order(&xas, page->index, compound_order(page));
-		nr = compound_nr(page);
+		xas_set_order(&xas, page->index, thp_order(page));
+		nr = thp_nr_pages(page);
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
@@ -311,19 +310,12 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!PageLocked(page));
 
-		if (page->index == xas.xa_index)
-			page->mapping = NULL;
+		page->mapping = NULL;
 		/* Leave page->index set: truncation lookup relies on it */
 
-		/*
-		 * Move to the next page in the vector if this is a regular
-		 * page or the index is of the last sub-page of this compound
-		 * page.
-		 */
-		if (page->index + compound_nr(page) - 1 == xas.xa_index)
-			i++;
+		i++;
 		xas_store(&xas, NULL);
-		total_pages++;
+		total_pages += thp_nr_pages(page);
 	}
 	mapping->nrpages -= total_pages;
 }
@@ -1956,20 +1948,24 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		indices[pvec->nr] = xas.xa_index;
 		if (!pagevec_add(pvec, page))
 			break;
-		goto next;
+		continue;
 unlock:
 		unlock_page(page);
 put:
 		put_page(page);
-next:
-		if (!xa_is_value(page) && PageTransHuge(page))
-			xas_set(&xas, page->index + thp_nr_pages(page));
 	}
 	rcu_read_unlock();
 
 	return pagevec_count(pvec);
 }
 
+static inline bool thp_last_tail(struct page *head, pgoff_t index)
+{
+	if (!PageTransCompound(head) || PageHuge(head))
+		return true;
+	return index == head->index + thp_nr_pages(head) - 1;
+}
+
 /**
  * find_get_pages_range - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -2008,11 +2004,17 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 		if (xa_is_value(page))
 			continue;
 
+again:
 		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
 		}
+		if (!thp_last_tail(page, xas.xa_index)) {
+			xas.xa_index++;
+			page_ref_inc(page);
+			goto again;
+		}
 	}
 
 	/*
@@ -3018,6 +3020,12 @@ void filemap_map_pages(struct vm_fault *vmf,
 	struct page *head, *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 
+	max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+	if (max_idx == 0)
+		return;
+	if (end_pgoff >= max_idx)
+		end_pgoff = max_idx - 1;
+
 	rcu_read_lock();
 	xas_for_each(&xas, head, end_pgoff) {
 		if (xas_retry(&xas, head))
@@ -3037,20 +3045,16 @@ void filemap_map_pages(struct vm_fault *vmf,
 		/* Has the page moved or been split? */
 		if (unlikely(head != xas_reload(&xas)))
 			goto skip;
-		page = find_subpage(head, xas.xa_index);
-
-		if (!PageUptodate(head) ||
-				PageReadahead(page) ||
-				PageHWPoison(page))
+		if (!PageUptodate(head) || PageReadahead(head))
 			goto skip;
 		if (!trylock_page(head))
 			goto skip;
-
 		if (head->mapping != mapping || !PageUptodate(head))
 			goto unlock;
 
-		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
-		if (xas.xa_index >= max_idx)
+		page = find_subpage(head, xas.xa_index);
+again:
+		if (PageHWPoison(page))
 			goto unlock;
 
 		if (mmap_miss > 0)
@@ -3062,6 +3066,14 @@ void filemap_map_pages(struct vm_fault *vmf,
 		last_pgoff = xas.xa_index;
 		if (alloc_set_pte(vmf, page))
 			goto unlock;
+		if (!thp_last_tail(head, xas.xa_index)) {
+			xas.xa_index++;
+			page++;
+			page_ref_inc(head);
+			if (xas.xa_index >= end_pgoff)
+				goto unlock;
+			goto again;
+		}
 		unlock_page(head);
 		goto next;
 unlock:
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f99167d74cbc..0e900e594e77 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2626,6 +2626,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct page *head = compound_head(page);
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2690,19 +2691,28 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
+	if (mapping) {
+		xas_split_alloc(&xas, head, thp_order(head),
+				mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);
+		if (xas_error(&xas)) {
+			ret = xas_error(&xas);
+			goto out_unlock;
+		}
+	}
+
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
 	spin_lock_irqsave(&pgdata->lru_lock, flags);
 
 	if (mapping) {
-		XA_STATE(xas, &mapping->i_pages, page_index(head));
-
 		/*
 		 * Check if the head page is present in page cache.
 		 * We assume all tail are present too, if head is there.
 		 */
-		xa_lock(&mapping->i_pages);
+		xas_lock(&xas);
+		xas_reset(&xas);
 		if (xas_load(&xas) != head)
 			goto fail;
+		xas_split(&xas, head, thp_order(head));
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
@@ -2735,7 +2745,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
-			xa_unlock(&mapping->i_pages);
+			xas_unlock(&xas);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
 		remap_page(head, thp_nr_pages(head));
 		ret = -EBUSY;
@@ -2749,6 +2759,7 @@ fail:		if (mapping)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	xas_destroy(&xas);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2cb93aa8bf84..230e62a92ae7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1645,7 +1645,10 @@ static void collapse_file(struct mm_struct *mm,
 	}
 	count_memcg_page_event(new_page, THP_COLLAPSE_ALLOC);
 
-	/* This will be less messy when we use multi-index entries */
+	/*
+	 * Ensure we have slots for all the pages in the range.  This is
+	 * almost certainly a no-op because most of the pages must be present
+	 */
 	do {
 		xas_lock_irq(&xas);
 		xas_create_range(&xas);
@@ -1851,6 +1854,9 @@ static void collapse_file(struct mm_struct *mm,
 			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
+	/* Join all the small entries into a single multi-index entry */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, new_page);
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
@@ -1972,6 +1978,10 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 			continue;
 		}
 
+		/*
+		 * XXX: khugepaged should compact smaller compound pages
+		 * into a PMD sized page
+		 */
 		if (PageTransCompound(page)) {
 			result = SCAN_PAGE_COMPOUND;
 			break;
diff --git a/mm/migrate.c b/mm/migrate.c
index d1ca7bdc80ca..39663dfbc273 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -460,14 +460,6 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	}
 
 	xas_store(&xas, newpage);
-	if (PageTransHuge(page)) {
-		int i;
-
-		for (i = 1; i < HPAGE_PMD_NR; i++) {
-			xas_next(&xas);
-			xas_store(&xas, newpage);
-		}
-	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
diff --git a/mm/shmem.c b/mm/shmem.c
index d1068c6d731d..e9ab59caae50 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -670,7 +670,6 @@ static int shmem_add_to_page_cache(struct page *page,
 				   struct mm_struct *charge_mm)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
-	unsigned long i = 0;
 	unsigned long nr = compound_nr(page);
 	int error;
 
@@ -700,17 +699,11 @@ static int shmem_add_to_page_cache(struct page *page,
 		void *entry;
 		xas_lock_irq(&xas);
 		entry = xas_find_conflict(&xas);
-		if (entry != expected)
+		if (entry != expected) {
 			xas_set_err(&xas, -EEXIST);
-		xas_create_range(&xas);
-		if (xas_error(&xas))
 			goto unlock;
-next:
-		xas_store(&xas, page);
-		if (++i < nr) {
-			xas_next(&xas);
-			goto next;
 		}
+		xas_store(&xas, page);
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_ALLOC);
 			__inc_lruvec_page_state(page, NR_SHMEM_THPS);
-- 
2.28.0

