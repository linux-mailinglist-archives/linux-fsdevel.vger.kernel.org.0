Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A863C41E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhGLDdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGLDdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:33:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4244C0613DD;
        Sun, 11 Jul 2021 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3GvyyjM48baLTpa97ADBxL023rhcXs1ZJlneYXhdyQc=; b=hhYrHPNAZ7BkPI5kHSMCDswosK
        xnhvA7BS+wpJBeo16WInVxvsBRtMpSk2gTEQ3lmcoWV4X2DigLg52/oMI02l0GTS7jYjMnIaoeu3K
        2wHNNGDN9RJLpXrlwrRU398Baqq5T0olQc9pz909xEp7rdDw2Sv2bK28X9oYJxyb7795FOUjBc5F9
        XmIgI/xtBFQqffK1w+nqXGb+Q57195MSPHKqdr0MSE5+N0hXQXLq5ne3MXxP7JjTYoMljwpEUUUXo
        mgus8vWNdi9onUx0P+/qF1Pez+85wBA6nxovEL7Q8wn4TC/7hqECZfzdorpnaipzRHp1aLPL4piST
        d2q2lSOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2md3-00GoLl-BM; Mon, 12 Jul 2021 03:29:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 041/137] mm/memcg: Convert uncharge_page() to uncharge_folio()
Date:   Mon, 12 Jul 2021 04:05:25 +0100
Message-Id: <20210712030701.4000097-42-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a folio rather than a page to ensure that we're only operating on
base or head pages, and not tail pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ebad42c55f76..2436ad3841d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6832,24 +6832,23 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	memcg_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
-	/* drop reference from uncharge_page */
+	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
 }
 
-static void uncharge_page(struct page *page, struct uncharge_gather *ug)
+static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
-	struct folio *folio = page_folio(page);
 	unsigned long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg = PageMemcgKmem(page);
+	bool use_objcg = folio_memcg_kmem(folio);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page memcg or objcg at this point, we have fully
-	 * exclusive access to the page.
+	 * folio memcg or objcg at this point, we have fully
+	 * exclusive access to the folio.
 	 */
 	if (use_objcg) {
 		objcg = __folio_objcg(folio);
@@ -6871,19 +6870,19 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = memcg;
-		ug->nid = page_to_nid(page);
+		ug->nid = folio_nid(folio);
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&memcg->css);
 	}
 
-	nr_pages = compound_nr(page);
+	nr_pages = folio_nr_pages(folio);
 
 	if (use_objcg) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
-		page->memcg_data = 0;
+		folio->memcg_data = 0;
 		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
@@ -6891,7 +6890,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
-		page->memcg_data = 0;
+		folio->memcg_data = 0;
 	}
 
 	css_put(&memcg->css);
@@ -6915,7 +6914,7 @@ void mem_cgroup_uncharge(struct page *page)
 		return;
 
 	uncharge_gather_clear(&ug);
-	uncharge_page(page, &ug);
+	uncharge_folio(page_folio(page), &ug);
 	uncharge_batch(&ug);
 }
 
@@ -6929,14 +6928,14 @@ void mem_cgroup_uncharge(struct page *page)
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 	struct uncharge_gather ug;
-	struct page *page;
+	struct folio *folio;
 
 	if (mem_cgroup_disabled())
 		return;
 
 	uncharge_gather_clear(&ug);
-	list_for_each_entry(page, page_list, lru)
-		uncharge_page(page, &ug);
+	list_for_each_entry(folio, page_list, lru)
+		uncharge_folio(folio, &ug);
 	if (ug.memcg)
 		uncharge_batch(&ug);
 }
-- 
2.30.2

