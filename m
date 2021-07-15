Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1E3C96EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhGOEME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhGOEME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:12:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41C2C06175F;
        Wed, 14 Jul 2021 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1oPzmTcWDwHQdw75PYolhuv7fLZWOVFGSl3QsN5aXeg=; b=HGNxad1sGeexx4qEp/zR9kK6+h
        n0N26OveaAllKf3TtUG/Dsx7csnvQ8/rA6d1L91YcANlF+MfHhpsIOJXnI5zo7KxVg1eQfd/EumsU
        bmcLpjyk1jlkN4aPm42lTIm2PC5Ark9/3IwhGMl+c2zGhSLacfoHT5FCNNGJT2PabXp7QiYbQ+reA
        ZBc5GfZeo44aIngR/G+JBU8KVbXsITijVFNqDIwz0QKq4BTaf1clxcjBmjRny/KdnB4KUTdNgJ0IK
        bX0qGuC4o3OE/v7gD/SpgPXuf7xCWJgUP+PmLkhBgiG/2Wj1L1q6BoXGmXRddCiWKzomHTzskuH1x
        SQdSdCiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3ses-002wA4-BA; Thu, 15 Jul 2021 04:07:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 038/138] mm/memcg: Add folio_memcg() and related functions
Date:   Thu, 15 Jul 2021 04:35:24 +0100
Message-Id: <20210715033704.692967-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memcg information is only stored in the head page, so the memcg
subsystem needs to assure that all accesses are to the head page.
The first step is converting page_memcg() to folio_memcg().

The callers of page_memcg() and PageMemcgKmem() are not yet ready to be
converted to use folios, so retain them as wrappers around folio_memcg()
and folio_memcg_kmem().  They will be converted in a later patch set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h | 109 ++++++++++++++++++++++---------------
 mm/memcontrol.c            |  21 ++++---
 2 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..eabae5874161 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -372,6 +372,7 @@ enum page_memcg_data_flags {
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
 static inline bool PageMemcgKmem(struct page *page);
+static inline bool folio_memcg_kmem(struct folio *folio);
 
 /*
  * After the initialization objcg->memcg is always pointing at
@@ -386,73 +387,77 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __page_memcg - get the memory cgroup associated with a non-kmem page
- * @page: a pointer to the page struct
+ * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
+ * @folio: Pointer to the folio.
  *
- * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function assumes that the page is known to have a
+ * Returns a pointer to the memory cgroup associated with the folio,
+ * or NULL. This function assumes that the folio is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages or
- * kmem pages.
+ * against some type of folios, e.g. slab folios or ex-slab folios or
+ * kmem folios.
  */
-static inline struct mem_cgroup *__page_memcg(struct page *page)
+static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 {
-	unsigned long memcg_data = page->memcg_data;
+	unsigned long memcg_data = folio->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
 /*
- * __page_objcg - get the object cgroup associated with a kmem page
- * @page: a pointer to the page struct
+ * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * @folio: Pointer to the folio.
  *
- * Returns a pointer to the object cgroup associated with the page,
- * or NULL. This function assumes that the page is known to have a
+ * Returns a pointer to the object cgroup associated with the folio,
+ * or NULL. This function assumes that the folio is known to have a
  * proper object cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages or
- * LRU pages.
+ * against some type of folios, e.g. slab folios or ex-slab folios or
+ * LRU folios.
  */
-static inline struct obj_cgroup *__page_objcg(struct page *page)
+static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 {
-	unsigned long memcg_data = page->memcg_data;
+	unsigned long memcg_data = folio->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(page), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
-	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
+	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
+	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
+	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
 /*
- * page_memcg - get the memory cgroup associated with a page
- * @page: a pointer to the page struct
+ * folio_memcg - Get the memory cgroup associated with a folio.
+ * @folio: Pointer to the folio.
  *
- * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function assumes that the page is known to have a
+ * Returns a pointer to the memory cgroup associated with the folio,
+ * or NULL. This function assumes that the folio is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages.
+ * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
+ * For a non-kmem folio any of the following ensures folio and memcg binding
  * stability:
  *
- * - the page lock
+ * - the folio lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
  *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * For a kmem folio a caller should hold an rcu read lock to protect memcg
+ * associated with a kmem folio from being released.
  */
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	if (folio_memcg_kmem(folio))
+		return obj_cgroup_memcg(__folio_objcg(folio));
+	return __folio_memcg(folio);
+}
+
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
-	if (PageMemcgKmem(page))
-		return obj_cgroup_memcg(__page_objcg(page));
-	else
-		return __page_memcg(page);
+	return folio_memcg(page_folio(page));
 }
 
 /*
@@ -525,17 +530,18 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 
 #ifdef CONFIG_MEMCG_KMEM
 /*
- * PageMemcgKmem - check if the page has MemcgKmem flag set
- * @page: a pointer to the page struct
+ * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
+ * @folio: Pointer to the folio.
  *
- * Checks if the page has MemcgKmem flag set. The caller must ensure that
- * the page has an associated memory cgroup. It's not safe to call this function
- * against some types of pages, e.g. slab pages.
+ * Checks if the folio has MemcgKmem flag set. The caller must ensure
+ * that the folio has an associated memory cgroup. It's not safe to call
+ * this function against some types of folios, e.g. slab folios.
  */
-static inline bool PageMemcgKmem(struct page *page)
+static inline bool folio_memcg_kmem(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(page->memcg_data & MEMCG_DATA_OBJCGS, page);
-	return page->memcg_data & MEMCG_DATA_KMEM;
+	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
+	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJCGS, folio);
+	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
 /*
@@ -579,7 +585,7 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 }
 
 #else
-static inline bool PageMemcgKmem(struct page *page)
+static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	return false;
 }
@@ -595,6 +601,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 }
 #endif
 
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return folio_memcg_kmem(page_folio(page));
+}
+
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
 {
 	if (idx == MEMCG_PERCPU_B)
@@ -1106,6 +1117,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 #define MEM_CGROUP_ID_SHIFT	0
 #define MEM_CGROUP_ID_MAX	0
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
 	return NULL;
@@ -1122,6 +1138,11 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return NULL;
 }
 
+static inline bool folio_memcg_kmem(struct folio *folio)
+{
+	return false;
+}
+
 static inline bool PageMemcgKmem(struct page *page)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1a049bfa0e0a..f0f781dde37a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3050,15 +3050,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
+	struct folio *folio = page_folio(page);
 	struct obj_cgroup *objcg;
 	unsigned int nr_pages = 1 << order;
 
-	if (!PageMemcgKmem(page))
+	if (!folio_memcg_kmem(folio))
 		return;
 
-	objcg = __page_objcg(page);
+	objcg = __folio_objcg(folio);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
-	page->memcg_data = 0;
+	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
 
@@ -3290,17 +3291,18 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
  */
 void split_page_memcg(struct page *head, unsigned int nr)
 {
-	struct mem_cgroup *memcg = page_memcg(head);
+	struct folio *folio = page_folio(head);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 	int i;
 
 	if (mem_cgroup_disabled() || !memcg)
 		return;
 
 	for (i = 1; i < nr; i++)
-		head[i].memcg_data = head->memcg_data;
+		folio_page(folio, i)->memcg_data = folio->memcg_data;
 
-	if (PageMemcgKmem(head))
-		obj_cgroup_get_many(__page_objcg(head), nr - 1);
+	if (folio_memcg_kmem(folio))
+		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
 	else
 		css_get_many(&memcg->css, nr - 1);
 }
@@ -6835,6 +6837,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
+	struct folio *folio = page_folio(page);
 	unsigned long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
@@ -6848,14 +6851,14 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	 * exclusive access to the page.
 	 */
 	if (use_objcg) {
-		objcg = __page_objcg(page);
+		objcg = __folio_objcg(folio);
 		/*
 		 * This get matches the put at the end of the function and
 		 * kmem pages do not hold memcg references anymore.
 		 */
 		memcg = get_mem_cgroup_from_objcg(objcg);
 	} else {
-		memcg = __page_memcg(page);
+		memcg = __folio_memcg(folio);
 	}
 
 	if (!memcg)
-- 
2.30.2

