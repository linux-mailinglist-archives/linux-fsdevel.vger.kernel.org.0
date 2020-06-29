Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F320E32E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgF2VMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgF2S5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C62C030793
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HPtuNowuEy22hYW/7Sdfs5gnhvuh51nym0Qx9CBBMvw=; b=JoQ9h1kObLFPxml4Xc3ZnOKRov
        gfk91esL/rVW8HkydjAGjm3RjUpoHiaZPrrm4JPiIMeuwVaUPWqxn0sjR15oHaa/JhIpsSRix0V2r
        7RH/HrATbRCAdAEqQasB94anSbNTGIEc4kOPTIB0hcGg4U7At+e+ON9vExoV/RPvl1RHoHSTF+OhR
        3UYrazMhp1XpgKYNqfYOILGdWUgWxi8gpiFQ48IOmK93uJCjExRcdWzApLAyq7W2/0GhgnHXPPuvF
        uCsXoOHEkgjVETuB5W1V1sYbsOOKm9/7op9SCZdEcPlgQZJtErFaPat8lJqhhsSUjYF4T9f10mmh7
        bCFTx5iA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvaG-0004F1-GJ; Mon, 29 Jun 2020 15:20:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 2/2] mm: Use multi-index entries in the page cache
Date:   Mon, 29 Jun 2020 16:20:33 +0100
Message-Id: <20200629152033.16175-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629152033.16175-1-willy@infradead.org>
References: <20200629152033.16175-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently store order-N THPs as 2^N consecutive entries.  While this
consumes rather more memory than necessary, it also turns out to be
buggy for filesystems which track dirty pages as a writeback operation
which starts in the middle of a dirty THP will not notice as the dirty
bit is only set on the head index.  With multi-index entries, the dirty
bit will be found on the head index.

This does end up simplifying the page cache slightly, although not as
much as I had hoped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c     | 42 +++++++++++++++++++-----------------------
 mm/huge_memory.c | 21 +++++++++++++++++----
 mm/khugepaged.c  | 12 +++++++++++-
 mm/shmem.c       | 11 ++---------
 4 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 80ce3658b147..28859bc43a3a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -126,13 +126,12 @@ static void page_cache_delete(struct address_space *mapping,
 
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
@@ -322,19 +321,12 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
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
@@ -851,20 +843,24 @@ static int __add_to_page_cache_locked(struct page *page,
 	}
 
 	do {
-		xas_lock_irq(&xas);
-		old = xas_load(&xas);
-		if (old && !xa_is_value(old))
-			xas_set_err(&xas, -EEXIST);
-		xas_store(&xas, page);
-		if (xas_error(&xas))
-			goto unlock;
+		unsigned long exceptional = 0;
 
-		if (xa_is_value(old)) {
-			mapping->nrexceptional--;
+		xas_lock_irq(&xas);
+		xas_for_each_conflict(&xas, old) {
+			if (!xa_is_value(old)) {
+				xas_set_err(&xas, -EEXIST);
+				goto unlock;
+			}
+			exceptional++;
 			if (shadowp)
 				*shadowp = old;
 		}
-		mapping->nrpages++;
+
+		xas_store(&xas, page);
+		if (xas_error(&xas))
+			goto unlock;
+		mapping->nrexceptional -= exceptional;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..7e5ff05ceeaa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2603,6 +2603,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct page *head = compound_head(page);
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	XA_STATE_ORDER(xas, &head->mapping->i_pages, head->index,
+				compound_order(head));
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2667,19 +2669,28 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
+	if (mapping) {
+		/* XXX: Need better GFP flags here */
+		xas_split_alloc(&xas, head, 0, GFP_ATOMIC);
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
+		xas_split(&xas, head, 0);
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
@@ -2717,7 +2728,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:		if (mapping)
-			xa_unlock(&mapping->i_pages);
+			xas_unlock(&xas);
 		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
 		remap_page(head);
 		ret = -EBUSY;
@@ -2731,6 +2742,8 @@ fail:		if (mapping)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* Free any memory we didn't use */
+	xas_nomem(&xas, 0);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b043c40a21d4..52dcec90e1c3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1638,7 +1638,10 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1844,6 +1847,9 @@ static void collapse_file(struct mm_struct *mm,
 			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
+	/* Join all the small entries into a single multi-index entry */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, new_page);
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
@@ -1965,6 +1971,10 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 			continue;
 		}
 
+		/*
+		 * XXX: khugepaged should compact smaller compound pages
+		 * into a PMD sized page
+		 */
 		if (PageTransCompound(page)) {
 			result = SCAN_PAGE_COMPOUND;
 			break;
diff --git a/mm/shmem.c b/mm/shmem.c
index a0dbe62f8042..030cc483dd3f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -608,7 +608,6 @@ static int shmem_add_to_page_cache(struct page *page,
 				   struct mm_struct *charge_mm)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
-	unsigned long i = 0;
 	unsigned long nr = compound_nr(page);
 	int error;
 
@@ -638,17 +637,11 @@ static int shmem_add_to_page_cache(struct page *page,
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
 			__inc_node_page_state(page, NR_SHMEM_THPS);
-- 
2.27.0

