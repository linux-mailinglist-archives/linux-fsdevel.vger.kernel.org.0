Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702033C42C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhGLERg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGLERf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:17:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E99C0613DD;
        Sun, 11 Jul 2021 21:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x3mI5CwCLF5t+/7CDmT9rprszNrZLtPbImFZdCpMib8=; b=TFk3pQtIyMHt6vOGaPOwlANx0g
        ZFtfWUNQpU+rQ7xLCwXEjBcVKI8AhfIyNgxwVWuewpGv4DGPaFhQ14p15UjLMZQ+7EtrJpHnjFEQS
        Sh3a0zXZok9hCsPqQr/rxUieaMXjldH9jzGfl9u8uCH/6i98cnWkH+maavvG1xPOMTJZofXvptK+b
        AJeXWr9W15zcVrD13SO4ls5VlvCxqtsKrrbhCdeMs++/NkHu9pk2BL1ZQ/yP/nDkRwvICUn9WbmPw
        bBTwTsKZ7u6fZK3S/K1ZitQvHpTBb3CwSVo70f+pb7Jka3lZWzh7EeTWRVgBl1gq7Fy1rq09ZBhi7
        U2a3Xwqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nJr-00GrRi-PF; Mon, 12 Jul 2021 04:14:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 126/137] mm: Use multi-index entries in the page cache
Date:   Mon, 12 Jul 2021 04:06:50 +0100
Message-Id: <20210712030701.4000097-127-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
 mm/filemap.c            | 63 +++++++++++++++++++++++++----------------
 mm/huge_memory.c        | 20 ++++++++++---
 mm/khugepaged.c         | 12 +++++++-
 mm/migrate.c            |  8 ------
 mm/shmem.c              | 11 ++-----
 6 files changed, 68 insertions(+), 56 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 90935f231419..26a001ea7869 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1078,16 +1078,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
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
index aaed0396db28..ab3503493975 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,7 +134,6 @@ static void page_cache_delete(struct address_space *mapping,
 	}
 
 	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
-	VM_BUG_ON_FOLIO(nr != 1 && shadow, folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
@@ -276,8 +275,7 @@ void filemap_remove_folio(struct folio *folio)
  * from the mapping. The function expects @pvec to be sorted by page index
  * and is optimised for it to be dense.
  * It tolerates holes in @pvec (mapping entries at those indices are not
- * modified). The function expects only THP head pages to be present in the
- * @pvec.
+ * modified). The function expects only folios to be present in the @pvec.
  *
  * The function expects the i_pages lock to be held.
  */
@@ -312,20 +310,12 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_locked(folio));
 
-		if (folio->index == xas.xa_index)
-			folio->mapping = NULL;
-		/* Leave page->index set: truncation lookup relies on it */
+		folio->mapping = NULL;
+		/* Leave folio->index set: truncation lookup relies on it */
 
-		/*
-		 * Move to the next page in the vector if this is a regular
-		 * page or the index is of the last sub-page of this compound
-		 * page.
-		 */
-		if (folio->index + folio_nr_pages(folio) - 1 ==
-								xas.xa_index)
-			i++;
+		i++;
 		xas_store(&xas, NULL);
-		total_pages++;
+		total_pages += folio_nr_pages(folio);
 	}
 	mapping->nrpages -= total_pages;
 }
@@ -2027,24 +2017,27 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		indices[pvec->nr] = xas.xa_index;
 		if (!pagevec_add(pvec, &folio->page))
 			break;
-		goto next;
+		continue;
 unlock:
 		folio_unlock(folio);
 put:
 		folio_put(folio);
-next:
-		if (!xa_is_value(folio) && folio_multi(folio)) {
-			xas_set(&xas, folio->index + folio_nr_pages(folio));
-			/* Did we wrap on 32-bit? */
-			if (!xas.xa_index)
-				break;
-		}
 	}
 	rcu_read_unlock();
 
 	return pagevec_count(pvec);
 }
 
+static inline
+bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
+{
+	if (folio_single(folio) || folio_hugetlb(folio))
+		return false;
+	if (index >= max)
+		return false;
+	return index < folio->index + folio_nr_pages(folio) - 1;
+}
+
 /**
  * find_get_pages_range - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -2083,11 +2076,17 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 		if (xa_is_value(folio))
 			continue;
 
+again:
 		pages[ret] = folio_file_page(folio, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
 		}
+		if (folio_more_pages(folio, xas.xa_index, end)) {
+			xas.xa_index++;
+			folio_ref_inc(folio);
+			goto again;
+		}
 	}
 
 	/*
@@ -2145,9 +2144,15 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		if (unlikely(folio != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret] = &folio->page;
+again:
+		pages[ret] = folio_file_page(folio, xas.xa_index);
 		if (++ret == nr_pages)
 			break;
+		if (folio_more_pages(folio, xas.xa_index, ULONG_MAX)) {
+			xas.xa_index++;
+			folio_ref_inc(folio);
+			goto again;
+		}
 		continue;
 put_page:
 		folio_put(folio);
@@ -3169,6 +3174,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
+again:
 		page = folio_file_page(folio, xas.xa_index);
 		if (PageHWPoison(page))
 			goto unlock;
@@ -3190,9 +3196,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		do_set_pte(vmf, page, addr);
 		/* no need to invalidate: a not-present page won't be cached */
 		update_mmu_cache(vma, addr, vmf->pte);
+		if (folio_more_pages(folio, xas.xa_index, end_pgoff)) {
+			xas.xa_index++;
+			folio_ref_inc(folio);
+			goto again;
+		}
 		folio_unlock(folio);
 		continue;
 unlock:
+		if (folio_more_pages(folio, xas.xa_index, end_pgoff)) {
+			xas.xa_index++;
+			goto again;
+		}
 		folio_unlock(folio);
 		folio_put(folio);
 	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 763bf687ca92..7ea0052172a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2638,6 +2638,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2700,18 +2701,27 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 	unmap_page(head);
 
+	if (mapping) {
+		xas_split_alloc(&xas, head, compound_order(head),
+				mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);
+		if (xas_error(&xas)) {
+			ret = xas_error(&xas);
+			goto out_unlock;
+		}
+	}
+
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
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
@@ -2739,7 +2749,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
 		if (mapping)
-			xa_unlock(&mapping->i_pages);
+			xas_unlock(&xas);
 		local_irq_enable();
 		remap_page(head, thp_nr_pages(head));
 		ret = -EBUSY;
@@ -2753,6 +2763,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* Free any memory we didn't use */
+	xas_nomem(&xas, 0);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9c98ddcd09..949b583f22c0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1664,7 +1664,10 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1884,6 +1887,9 @@ static void collapse_file(struct mm_struct *mm,
 			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
+	/* Join all the small entries into a single multi-index entry */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, new_page);
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
@@ -2005,6 +2011,10 @@ static void khugepaged_scan_file(struct mm_struct *mm,
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
index 942a5ce11f39..594a19a888de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -439,14 +439,6 @@ int folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	xas_store(&xas, newfolio);
-	if (nr > 1) {
-		int i;
-
-		for (i = 1; i < nr; i++) {
-			xas_next(&xas);
-			xas_store(&xas, newfolio);
-		}
-	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
diff --git a/mm/shmem.c b/mm/shmem.c
index 337680a01f2a..bdfa60416d68 100644
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
 			__mod_lruvec_page_state(page, NR_SHMEM_THPS, nr);
-- 
2.30.2

