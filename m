Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A546CC7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbhLHE3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbhLHE0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E9C0698D8
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G/mukvSZncXf2yTMkAGDJr68zKEeRGuzQ/EY/A/EV+Y=; b=Y2KXMUrgOkaFp/ihSr5h+aRaUT
        GfDxaR4ZCzRqdzeDB8rbpS1wVBUB58pbE3Gh8JKSk0BlG/IsvLcCBXXXJjndG2Gn+ktTsuL0cKqDO
        sZqG6nLS/sOftfm/iXdpBI669LoOfHs1gbI3+Qhptb2I15fp8hF6Y/4svUttikeDSK4yuH9S7J+mb
        f8L43FFuDZPAHcNXZANy6+0CTAPDi/bENyHgR8R+7ucl2IPUS3qtPyOkBqy1nu4XjsFL60Vszs1/D
        rlhqbJ+lk2DrzK64EeT19+RzN+6tshgnPB/a76mQPYiav8Im4uSW5ENW1isDtdTgySs9VNLR2HhcU
        eLZmv3pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU8-0084ec-R1; Wed, 08 Dec 2021 04:23:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 48/48] mm: Use multi-index entries in the page cache
Date:   Wed,  8 Dec 2021 04:22:56 +0000
Message-Id: <20211208042256.1923824-49-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently store large folios as 2^N consecutive entries.  While this
consumes rather more memory than necessary, it also turns out to be buggy.
A writeback operation which starts within a tail page of a dirty folio will
not write back the folio as the xarray's dirty bit is only set on the
head index.  With multi-index entries, the dirty bit will be found no
matter where in the folio the operation starts.

This does end up simplifying the page cache slightly, although not as
much as I had hoped.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 -------
 mm/filemap.c            | 61 ++++++++++++++++++++++++++---------------
 mm/huge_memory.c        | 20 +++++++++++---
 mm/khugepaged.c         | 12 +++++++-
 mm/migrate.c            |  8 ------
 mm/shmem.c              | 16 ++++-------
 6 files changed, 72 insertions(+), 55 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6e038811f4c8..704cb1b4b15d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1125,16 +1125,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
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
index 89a10624e361..9b5b2d962c37 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -135,7 +135,6 @@ static void page_cache_delete(struct address_space *mapping,
 	}
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(nr != 1 && shadow, folio);
 
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
@@ -286,7 +285,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 			     struct folio_batch *fbatch)
 {
 	XA_STATE(xas, &mapping->i_pages, fbatch->folios[0]->index);
-	int total_pages = 0;
+	long total_pages = 0;
 	int i = 0;
 	struct folio *folio;
 
@@ -313,18 +312,12 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
 
-		if (folio->index == xas.xa_index)
-			folio->mapping = NULL;
+		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
 
-		/*
-		 * Move to the next folio in the batch if this is a regular
-		 * folio or the index is of the last sub-page of this folio.
-		 */
-		if (folio->index + folio_nr_pages(folio) - 1 == xas.xa_index)
-			i++;
+		i++;
 		xas_store(&xas, NULL);
-		total_pages++;
+		total_pages += folio_nr_pages(folio);
 	}
 	mapping->nrpages -= total_pages;
 }
@@ -2089,24 +2082,27 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		indices[fbatch->nr] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
-		goto next;
+		continue;
 unlock:
 		folio_unlock(folio);
 put:
 		folio_put(folio);
-next:
-		if (!xa_is_value(folio) && folio_test_large(folio)) {
-			xas_set(&xas, folio->index + folio_nr_pages(folio));
-			/* Did we wrap on 32-bit? */
-			if (!xas.xa_index)
-				break;
-		}
 	}
 	rcu_read_unlock();
 
 	return folio_batch_count(fbatch);
 }
 
+static inline
+bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
+{
+	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
+		return false;
+	if (index >= max)
+		return false;
+	return index < folio->index + folio_nr_pages(folio) - 1;
+}
+
 /**
  * find_get_pages_range - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -2145,11 +2141,17 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
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
@@ -2207,9 +2209,15 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
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
@@ -2334,8 +2342,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (folio_test_readahead(folio))
 			break;
-		xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
-		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
+		xas_advance(&xas, folio->index + folio_nr_pages(folio) - 1);
 		continue;
 put_folio:
 		folio_put(folio);
@@ -3284,6 +3291,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 	do {
+again:
 		page = folio_file_page(folio, xas.xa_index);
 		if (PageHWPoison(page))
 			goto unlock;
@@ -3305,9 +3313,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
index e5483347291c..e57af3a0af43 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2614,6 +2614,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2678,16 +2679,24 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
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
 	}
@@ -2703,6 +2712,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
+			xas_split(&xas, head, thp_order(head));
 			if (PageSwapBacked(head)) {
 				__mod_lruvec_page_state(head, NR_SHMEM_THPS,
 							-nr);
@@ -2719,7 +2729,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
 		if (mapping)
-			xa_unlock(&mapping->i_pages);
+			xas_unlock(&xas);
 		local_irq_enable();
 		remap_page(head, thp_nr_pages(head));
 		ret = -EBUSY;
@@ -2733,6 +2743,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* Free any memory we didn't use */
+	xas_nomem(&xas, 0);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e99101162f1a..2e1911cc3466 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1667,7 +1667,10 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1892,6 +1895,9 @@ static void collapse_file(struct mm_struct *mm,
 			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
+	/* Join all the small entries into a single multi-index entry */
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_store(&xas, new_page);
 xa_locked:
 	xas_unlock_irq(&xas);
 xa_unlocked:
@@ -2013,6 +2019,10 @@ static void khugepaged_scan_file(struct mm_struct *mm,
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
index 311638177536..7079e6b7dbe7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -433,14 +433,6 @@ int folio_migrate_mapping(struct address_space *mapping,
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
index 7f0b07845c1f..4f80cf4c74d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -707,7 +707,6 @@ static int shmem_add_to_page_cache(struct page *page,
 				   struct mm_struct *charge_mm)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
-	unsigned long i = 0;
 	unsigned long nr = compound_nr(page);
 	int error;
 
@@ -736,18 +735,15 @@ static int shmem_add_to_page_cache(struct page *page,
 	do {
 		void *entry;
 		xas_lock_irq(&xas);
-		entry = xas_find_conflict(&xas);
-		if (entry != expected)
+		while ((entry = xas_find_conflict(&xas)) != NULL) {
+			if (entry == expected)
+				continue;
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
+		if (xas_error(&xas))
+			goto unlock;
 		if (PageTransHuge(page)) {
 			count_vm_event(THP_FILE_ALLOC);
 			__mod_lruvec_page_state(page, NR_SHMEM_THPS, nr);
-- 
2.33.0

