Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FD738C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFUQqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjFUQqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302161BD5;
        Wed, 21 Jun 2023 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6bhEYpaGLo7Jfiv7Oy69a9Rbop+oIUfrkuAWfFjKyOQ=; b=fVZ+hZCi7U6/W3v6NYZl+xn2jM
        1lVvZ/cm5oqnPHkQ4EN7CqyGeAw3OMc02BCqfH3FTZmTMHtCBD4UugTykydjG+4AmzTCgaS9E8NLc
        wKJc9To6lc+TRJYTmbE9iZpa5GxvUxBx93xjO14Of2MZUZKkLfhAFBexr19TA9W5Gd5B2U373kAvV
        GmaNimalG9cGk8dLFYvIyCnvuLSvif6kbPYg/4lQKcbQpvf5FV10wKGWpAg6nhnlY9wVPc67Bm56J
        qj3Q3UL1kqOhdvt6U+UEl8OlB/v8JQGW4W3cGebFFTHD4WcBZZyOxiaJ0GfE+kgOuTUknBoJ8vlyb
        be8Lx8Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y2-00EjEj-HR; Wed, 21 Jun 2023 16:46:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 12/13] mm: Remove references to pagevec
Date:   Wed, 21 Jun 2023 17:45:56 +0100
Message-Id: <20230621164557.3510324-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230621164557.3510324-1-willy@infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of these should just refer to the LRU cache rather than the
data structure used to implement the LRU cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c    | 2 +-
 mm/khugepaged.c     | 6 +++---
 mm/ksm.c            | 6 +++---
 mm/memory.c         | 6 +++---
 mm/migrate_device.c | 2 +-
 mm/swap.c           | 2 +-
 mm/truncate.c       | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e94fe292f30a..eb3678360b97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1344,7 +1344,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	/*
 	 * See do_wp_page(): we can only reuse the folio exclusively if
 	 * there are no additional references. Note that we always drain
-	 * the LRU pagevecs immediately after adding a THP.
+	 * the LRU cache immediately after adding a THP.
 	 */
 	if (folio_ref_count(folio) >
 			1 + folio_test_swapcache(folio) * folio_nr_pages(folio))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5ef1e08b2a06..3beb4ad2ee5e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1051,7 +1051,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 	if (pte)
 		pte_unmap(pte);
 
-	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
+	/* Drain LRU cache to remove extra pin on the swapped in pages */
 	if (swapped_in)
 		lru_add_drain();
 
@@ -1972,7 +1972,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
-				/* drain pagevecs to help isolate_lru_page() */
+				/* drain lru cache to help isolate_lru_page() */
 				lru_add_drain();
 				page = folio_file_page(folio, index);
 			} else if (trylock_page(page)) {
@@ -1988,7 +1988,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  end - index);
-				/* drain pagevecs to help isolate_lru_page() */
+				/* drain lru cache to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
 				if (unlikely(page == NULL)) {
diff --git a/mm/ksm.c b/mm/ksm.c
index d995779dc1fe..ba266359da55 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -932,7 +932,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 		 * The stable node did not yet appear stale to get_ksm_page(),
 		 * since that allows for an unmapped ksm page to be recognized
 		 * right up until it is freed; but the node is safe to remove.
-		 * This page might be in a pagevec waiting to be freed,
+		 * This page might be in an LRU cache waiting to be freed,
 		 * or it might be PageSwapCache (perhaps under writeback),
 		 * or it might have been removed from swapcache a moment ago.
 		 */
@@ -2303,8 +2303,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
 
 		/*
-		 * A number of pages can hang around indefinitely on per-cpu
-		 * pagevecs, raised page count preventing write_protect_page
+		 * A number of pages can hang around indefinitely in per-cpu
+		 * LRU cache, raised page count preventing write_protect_page
 		 * from merging them.  Though it doesn't really matter much,
 		 * it is puzzling to see some stuck in pages_volatile until
 		 * other activity jostles them out, and they also prevented
diff --git a/mm/memory.c b/mm/memory.c
index 9f2723749f55..d034c52071f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3404,8 +3404,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			goto copy;
 		if (!folio_test_lru(folio))
 			/*
-			 * Note: We cannot easily detect+handle references from
-			 * remote LRU pagevecs or references to LRU folios.
+			 * We cannot easily detect+handle references from
+			 * remote LRU caches or references to LRU folios.
 			 */
 			lru_add_drain();
 		if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
@@ -3883,7 +3883,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * If we want to map a page that's in the swapcache writable, we
 		 * have to detect via the refcount if we're really the exclusive
 		 * owner. Try removing the extra reference from the local LRU
-		 * pagevecs if required.
+		 * caches if required.
 		 */
 		if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
 		    !folio_test_ksm(folio) && !folio_test_lru(folio))
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 02d272b909b5..8365158460ed 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -376,7 +376,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 		/* ZONE_DEVICE pages are not on LRU */
 		if (!is_zone_device_page(page)) {
 			if (!PageLRU(page) && allow_drain) {
-				/* Drain CPU's pagevec */
+				/* Drain CPU's lru cache */
 				lru_add_drain_all();
 				allow_drain = false;
 			}
diff --git a/mm/swap.c b/mm/swap.c
index 10348c1cf9c5..cd8f0150ba3a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -76,7 +76,7 @@ static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
 
 /*
  * This path almost never happens for VM activity - pages are normally freed
- * via pagevecs.  But it gets used by networking - and for compound pages.
+ * in batches.  But it gets used by networking - and for compound pages.
  */
 static void __page_cache_release(struct folio *folio)
 {
diff --git a/mm/truncate.c b/mm/truncate.c
index 4a917570887f..95d1291d269b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -565,7 +565,7 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave pages behind because
  * shrink_page_list() has a temp ref on them, or because they're transiently
- * sitting in the folio_add_lru() pagevecs.
+ * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
 					struct folio *folio)
-- 
2.39.2

