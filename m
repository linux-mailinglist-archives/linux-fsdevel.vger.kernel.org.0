Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219303C96FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhGOEOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhGOEOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34BC06175F;
        Wed, 14 Jul 2021 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FsFx6Bi/ua4uermKj44n4uT/d8N1GdioFQ96wCTnh5U=; b=GvhVNnDG5MJN44qdOjJwr/zP+F
        8VTJiOvSTxBuMsZCtH8Pp8jvFck7bakefHwTdP1T3ag0a7QUHS0lM+7rxxCxBAiU+gNT6TxVeANTI
        0d8zkLwcxAwqdZK1COSc3+Jlik9SVbhqEVBWYwo98qfuF+RaA67EPx+zfEnWC6SGnpo+NrQxow7h5
        XfQ9IrEPbc8baoAWywAoirh+eApbdgwo8AAqYa9dodvrGpeUzMlj1O2UXhEmKWIgpm0dnlTQ8rokA
        LmlZLAh2f1Lkuo1T/dxjc/IRcvNBdg0aR/gK8EgbEyo1DK8HoyOAITBRkYQXC++sIF7tHE2qgziiI
        SFlhCk4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3shh-002wIG-FC; Thu, 15 Jul 2021 04:10:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 042/138] mm/memcg: Convert mem_cgroup_uncharge() to take a folio
Date:   Thu, 15 Jul 2021 04:35:28 +0100
Message-Id: <20210715033704.692967-43-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert all the callers to call page_folio().  Most of them were already
using a head page, but a few of them I can't prove were, so this may
actually fix a bug.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h |  4 ++--
 mm/filemap.c               |  2 +-
 mm/khugepaged.c            |  4 ++--
 mm/memcontrol.c            | 14 +++++++-------
 mm/memory-failure.c        |  2 +-
 mm/memremap.c              |  2 +-
 mm/page_alloc.c            |  2 +-
 mm/swap.c                  |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fb7b87d8e794..941a1a7131c9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -709,7 +709,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
-void mem_cgroup_uncharge(struct page *page);
+void mem_cgroup_uncharge(struct folio *folio);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
@@ -1206,7 +1206,7 @@ static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 {
 }
 
-static inline void mem_cgroup_uncharge(struct page *page)
+static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 525f69316522..31d4ecd4268e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -923,7 +923,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
 		if (charged)
-			mem_cgroup_uncharge(page);
+			mem_cgroup_uncharge(page_folio(page));
 		goto error;
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8f6d7fdea9f4..6b9c98ddcd09 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1211,7 +1211,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	mmap_write_unlock(mm);
 out_nolock:
 	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
+		mem_cgroup_uncharge(page_folio(*hpage));
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
 }
@@ -1975,7 +1975,7 @@ static void collapse_file(struct mm_struct *mm,
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
 	if (!IS_ERR_OR_NULL(*hpage))
-		mem_cgroup_uncharge(*hpage);
+		mem_cgroup_uncharge(page_folio(*hpage));
 	/* TODO: tracepoints */
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c257cb71a3b0..fc94048e6451 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6897,24 +6897,24 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 }
 
 /**
- * mem_cgroup_uncharge - uncharge a page
- * @page: page to uncharge
+ * mem_cgroup_uncharge - Uncharge a folio.
+ * @folio: Folio to uncharge.
  *
- * Uncharge a page previously charged with mem_cgroup_charge().
+ * Uncharge a folio previously charged with folio_charge_cgroup().
  */
-void mem_cgroup_uncharge(struct page *page)
+void mem_cgroup_uncharge(struct folio *folio)
 {
 	struct uncharge_gather ug;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page_memcg(page))
+	/* Don't touch folio->lru of any random page, pre-check: */
+	if (!folio_memcg(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
-	uncharge_folio(page_folio(page), &ug);
+	uncharge_folio(folio, &ug);
 	uncharge_batch(&ug);
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eefd823deb67..9ae7a57a4cc0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -763,7 +763,7 @@ static int delete_from_lru_cache(struct page *p)
 		 * Poisoned page might never drop its ref count to 0 so we have
 		 * to uncharge it manually from its memcg.
 		 */
-		mem_cgroup_uncharge(p);
+		mem_cgroup_uncharge(page_folio(p));
 
 		/*
 		 * drop the page count elevated by isolate_lru_page()
diff --git a/mm/memremap.c b/mm/memremap.c
index 15a074ffb8d7..6eac40f9f62a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -508,7 +508,7 @@ void free_devmap_managed_page(struct page *page)
 
 	__ClearPageWaiters(page);
 
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 
 	/*
 	 * When a device_private page is freed, the page->mapping field
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..d72a0d9d4184 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -726,7 +726,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
 
 void free_compound_page(struct page *page)
 {
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 	free_the_page(page, compound_order(page));
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 095a5ec6f986..11ff40104a2c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void __page_cache_release(struct page *page)
 static void __put_single_page(struct page *page)
 {
 	__page_cache_release(page);
-	mem_cgroup_uncharge(page);
+	mem_cgroup_uncharge(page_folio(page));
 	free_unref_page(page, 0);
 }
 
-- 
2.30.2

