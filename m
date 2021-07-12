Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EDC3C424F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhGLDyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhGLDyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:54:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15CC0613DD;
        Sun, 11 Jul 2021 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5B9NLcbtY2KqatsUIEqn/NN7jlbYHuTY05ohZE/JpZc=; b=SJgvEDxmd+PpkTZtoazvtO/5RJ
        8/f0Yg7XR3wTQktPHMOmshTBYjX2iL81NwVFz4cq8Grm/UNQjjReEogbsew3oXm67vuSfVIroJaej
        VJH01rucgUCm0aclFQwaNW3ElymYs0cyBp53Yz6OjxPqreMYMcvrMi0lGTrFof+Tol525lFLuBV1l
        H9+uHtWqlUKSHjrftrdtYkbSo5JJ3gYXNFoGJAdU15E6ypDqizt0KsOrFxVTrnW+8c+3jSOsvf3ge
        lX2sAYOPD1q2iP5/qYu73RLqEpTFAKW+iWP7ZVKlZP8ihjEFXBJ/s4YiPyzXImIoL812MhXvk+iyo
        ILASZUFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2myF-00Gps6-8Y; Mon, 12 Jul 2021 03:51:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 082/137] mm/lru: Add folio_add_lru()
Date:   Mon, 12 Jul 2021 04:06:06 +0100
Message-Id: <20210712030701.4000097-83-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement lru_cache_add() as a wrapper around folio_add_lru().
Saves 159 bytes of kernel text due to removing calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h |  1 +
 mm/folio-compat.c    |  6 ++++++
 mm/swap.c            | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5e01675af7ab..81801ba78b1e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -351,6 +351,7 @@ extern unsigned long nr_free_buffer_pages(void);
 extern void lru_note_cost(struct lruvec *lruvec, bool file,
 			  unsigned int nr_pages);
 extern void lru_note_cost_folio(struct folio *);
+extern void folio_add_lru(struct folio *);
 extern void lru_cache_add(struct page *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index c1e01bc36d32..6de3cd78a4ae 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -102,3 +102,9 @@ bool redirty_page_for_writepage(struct writeback_control *wbc,
 	return folio_redirty_for_writepage(wbc, page_folio(page));
 }
 EXPORT_SYMBOL(redirty_page_for_writepage);
+
+void lru_cache_add(struct page *page)
+{
+	folio_add_lru(page_folio(page));
+}
+EXPORT_SYMBOL(lru_cache_add);
diff --git a/mm/swap.c b/mm/swap.c
index 42851b9d6316..bf1b90d1c2f0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -459,29 +459,29 @@ void folio_mark_accessed(struct folio *folio)
 EXPORT_SYMBOL(folio_mark_accessed);
 
 /**
- * lru_cache_add - add a page to a page list
- * @page: the page to be added to the LRU.
+ * folio_add_lru - Add a folio to an LRU list.
+ * @folio: The folio to be added to the LRU.
  *
- * Queue the page for addition to the LRU via pagevec. The decision on whether
+ * Queue the folio for addition to the LRU. The decision on whether
  * to add the page to the [in]active [file|anon] list is deferred until the
- * pagevec is drained. This gives a chance for the caller of lru_cache_add()
- * have the page added to the active list using mark_page_accessed().
+ * pagevec is drained. This gives a chance for the caller of folio_add_lru()
+ * have the folio added to the active list using folio_mark_accessed().
  */
-void lru_cache_add(struct page *page)
+void folio_add_lru(struct folio *folio)
 {
 	struct pagevec *pvec;
 
-	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	VM_BUG_ON_FOLIO(folio_active(folio) && folio_unevictable(folio), folio);
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
 
-	get_page(page);
+	folio_get(folio);
 	local_lock(&lru_pvecs.lock);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
-	if (pagevec_add_and_need_flush(pvec, page))
+	if (pagevec_add_and_need_flush(pvec, &folio->page))
 		__pagevec_lru_add(pvec);
 	local_unlock(&lru_pvecs.lock);
 }
-EXPORT_SYMBOL(lru_cache_add);
+EXPORT_SYMBOL(folio_add_lru);
 
 /**
  * lru_cache_add_inactive_or_unevictable
-- 
2.30.2

