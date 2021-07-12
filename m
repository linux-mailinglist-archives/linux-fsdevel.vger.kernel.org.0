Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429873C4248
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGLDx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhGLDx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:53:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB77C0613E8;
        Sun, 11 Jul 2021 20:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JhtfPH9Xb9wxADuDYqjB1VTp3pxNkaZWkV5grlJol7o=; b=hLdHhRT59ueh/nIjlYgJq7IEk/
        P4Ezy775KtzR1PV9ljlJm99Rar0FpBvOKKUpbXzf96FtOKkoTUkxeIW8uXHjOo7HXK9CeQLwXYTnD
        MzYbYR6V27UGvLWXyzkACaOx4lJ2jtMudrJOQfpaBtQdG3eDIoCnv4E4ysxb/e4Q/yJf45DXv9EcO
        FReN2WUcIaTVYXRZcDnD83ZAEv8Y2xe0Yhs7CGc5oY5SMZRCSWIKHmkOkn0bGijuvYGU+dNEnRTqv
        f6QGuJxAA2i+TowDBQaSs+r7uQmRE2maE/FJRjchDcCmrZt+yNS813Y9lTZuqezCO5kFHxBfk5I9L
        wl38xlyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mws-00Gplp-Oh; Mon, 12 Jul 2021 03:49:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 079/137] mm/workingset: Convert workingset_refault() to take a folio
Date:   Mon, 12 Jul 2021 04:06:03 +0100
Message-Id: <20210712030701.4000097-80-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This nets us 178 bytes of savings from removing calls to compound_head.
The three callers all grow a little, but each of them will be converted
to use folios soon, so that's fine.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h |  4 ++--
 mm/filemap.c         |  2 +-
 mm/memory.c          |  3 ++-
 mm/swap.c            |  7 +++----
 mm/swap_state.c      |  2 +-
 mm/workingset.c      | 34 +++++++++++++++++-----------------
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index c7a4c0a5863d..5e01675af7ab 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -329,7 +329,7 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
 /* linux/mm/workingset.c */
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
-void workingset_refault(struct page *page, void *shadow);
+void workingset_refault(struct folio *folio, void *shadow);
 void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
@@ -350,7 +350,7 @@ extern unsigned long nr_free_buffer_pages(void);
 /* linux/mm/swap.c */
 extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
-extern void lru_note_cost_page(struct page *);
+extern void lru_note_cost_folio(struct folio *);
 extern void lru_cache_add(struct page *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
diff --git a/mm/filemap.c b/mm/filemap.c
index b04c91ad294c..b0c9b4030144 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -981,7 +981,7 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		 */
 		WARN_ON_ONCE(PageActive(page));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
-			workingset_refault(page, shadow);
+			workingset_refault(page_folio(page), shadow);
 		lru_cache_add(page);
 	}
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 614418e26e2c..627e7836ade6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3538,7 +3538,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
-					workingset_refault(page, shadow);
+					workingset_refault(page_folio(page),
+								shadow);
 
 				lru_cache_add(page);
 
diff --git a/mm/swap.c b/mm/swap.c
index b49e10e75af5..fe177a16de84 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -315,11 +315,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 	} while ((lruvec = parent_lruvec(lruvec)));
 }
 
-void lru_note_cost_page(struct page *page)
+void lru_note_cost_folio(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	lru_note_cost(folio_lruvec(folio),
-		      page_is_file_lru(page), thp_nr_pages(page));
+	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
+			folio_nr_pages(folio));
 }
 
 static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c56aa9ac050d..1a29b4f98208 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -498,7 +498,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	mem_cgroup_swapin_uncharge_swap(entry);
 
 	if (shadow)
-		workingset_refault(page, shadow);
+		workingset_refault(page_folio(page), shadow);
 
 	/* Caller will initiate read into locked page */
 	lru_cache_add(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index 39bb60d50217..9d86ea344656 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -273,17 +273,17 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 }
 
 /**
- * workingset_refault - evaluate the refault of a previously evicted page
- * @page: the freshly allocated replacement page
- * @shadow: shadow entry of the evicted page
+ * workingset_refault - evaluate the refault of a previously evicted folio
+ * @page: the freshly allocated replacement folio
+ * @shadow: shadow entry of the evicted folio
  *
  * Calculates and evaluates the refault distance of the previously
- * evicted page in the context of the node and the memcg whose memory
+ * evicted folio in the context of the node and the memcg whose memory
  * pressure caused the eviction.
  */
-void workingset_refault(struct page *page, void *shadow)
+void workingset_refault(struct folio *folio, void *shadow)
 {
-	bool file = page_is_file_lru(page);
+	bool file = folio_is_file_lru(folio);
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
@@ -301,10 +301,10 @@ void workingset_refault(struct page *page, void *shadow)
 	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
-	 * have been deleted since the page's eviction.
+	 * have been deleted since the folio's eviction.
 	 *
 	 * Note that in rare events the ID could have been recycled
-	 * for a new cgroup that refaults a shared page. This is
+	 * for a new cgroup that refaults a shared folio. This is
 	 * impossible to tell from the available data. However, this
 	 * should be a rare and limited disturbance, and activations
 	 * are always speculative anyway. Ultimately, it's the aging
@@ -340,14 +340,14 @@ void workingset_refault(struct page *page, void *shadow)
 	refault_distance = (refault - eviction) & EVICTION_MASK;
 
 	/*
-	 * The activation decision for this page is made at the level
+	 * The activation decision for this folio is made at the level
 	 * where the eviction occurred, as that is where the LRU order
-	 * during page reclaim is being determined.
+	 * during folio reclaim is being determined.
 	 *
-	 * However, the cgroup that will own the page is the one that
+	 * However, the cgroup that will own the folio is the one that
 	 * is actually experiencing the refault event.
 	 */
-	memcg = page_memcg(page);
+	memcg = folio_memcg(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
@@ -375,15 +375,15 @@ void workingset_refault(struct page *page, void *shadow)
 	if (refault_distance > workingset_size)
 		goto out;
 
-	SetPageActive(page);
-	workingset_age_nonresident(lruvec, thp_nr_pages(page));
+	folio_set_active_flag(folio);
+	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
 	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file);
 
-	/* Page was active prior to eviction */
+	/* Folio was active prior to eviction */
 	if (workingset) {
-		SetPageWorkingset(page);
+		folio_set_workingset_flag(folio);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		lru_note_cost_page(page);
+		lru_note_cost_folio(folio);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
 	}
 out:
-- 
2.30.2

