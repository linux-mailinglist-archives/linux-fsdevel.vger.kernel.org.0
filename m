Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D994A3C970F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhGOEVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhGOEVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:21:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78CC06175F;
        Wed, 14 Jul 2021 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VXeGg211zIjtnWWOnpiVKQ/aALQg7bI4I+excloMB0I=; b=BJktQAtc+74uctXV2T+HsZ1Wa8
        bThnRegP9VVYw55EYK5BSMzSa1Z23JCJkZGO19mupFWVTxe3xbLLIqh7eAfpKq3WTqWix94nfyDLq
        ORgGHnnBgdQv5UC3KZFX6v8SdM7Z8yCWIQUFAyzmbqM7my8krSy143JJxcfbYojGj4ojbtR6D5Mf1
        0CqLBaa+LtBiA1J8KjTiRJn9imMQhfqOR+NtwsIcuG+q6mOiEjXjvML4qqDXXuTSgrUhrBb9VQUsu
        9Y19BWShWbfKId1hGbWIYvnoVLHx+n/E5NXp8NkrWrXLqarmKTynLumu2m2CmAIod9zdUCTA/OELC
        QOT3kPGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sni-002wcf-Jt; Thu, 15 Jul 2021 04:16:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 050/138] mm/workingset: Convert workingset_activation to take a folio
Date:   Thu, 15 Jul 2021 04:35:36 +0100
Message-Id: <20210715033704.692967-51-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page.  No real
change here, except that thp_nr_pages() compiles away on kernels with
THP compiled out while folio_nr_pages() is always present.  Also convert
page_memcg_rcu() to folio_memcg_rcu().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h | 18 +++++++++---------
 include/linux/swap.h       |  2 +-
 mm/swap.c                  |  2 +-
 mm/workingset.c            | 11 ++++-------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6511f89ad454..2dd660185bb3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -461,19 +461,19 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 }
 
 /*
- * page_memcg_rcu - locklessly get the memory cgroup associated with a page
- * @page: a pointer to the page struct
+ * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
+ * @folio: Pointer to the folio.
  *
- * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function assumes that the page is known to have a
+ * Returns a pointer to the memory cgroup associated with the folio,
+ * or NULL. This function assumes that the folio is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages.
+ * against some type of folios, e.g. slab folios or ex-slab folios.
  */
-static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
+static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
-	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
@@ -1129,7 +1129,7 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
-static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
+static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	return NULL;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8394716a002b..989d8f78c256 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -330,7 +330,7 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
 void workingset_refault(struct page *page, void *shadow);
-void workingset_activation(struct page *page);
+void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
diff --git a/mm/swap.c b/mm/swap.c
index aa9c32b714c5..85969b36b636 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -451,7 +451,7 @@ void mark_page_accessed(struct page *page)
 		else
 			__lru_cache_activate_page(page);
 		ClearPageReferenced(page);
-		workingset_activation(page);
+		workingset_activation(page_folio(page));
 	}
 	if (page_is_idle(page))
 		clear_page_idle(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index e62c0f2084a2..39bb60d50217 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -392,13 +392,11 @@ void workingset_refault(struct page *page, void *shadow)
 
 /**
  * workingset_activation - note a page activation
- * @page: page that is being activated
+ * @folio: Folio that is being activated.
  */
-void workingset_activation(struct page *page)
+void workingset_activation(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	/*
@@ -408,11 +406,10 @@ void workingset_activation(struct page *page)
 	 * XXX: See workingset_refault() - this should return
 	 * root_mem_cgroup even for !CONFIG_MEMCG.
 	 */
-	memcg = page_memcg_rcu(page);
+	memcg = folio_memcg_rcu(folio);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
-	lruvec = folio_lruvec(folio);
-	workingset_age_nonresident(lruvec, thp_nr_pages(page));
+	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
 out:
 	rcu_read_unlock();
 }
-- 
2.30.2

