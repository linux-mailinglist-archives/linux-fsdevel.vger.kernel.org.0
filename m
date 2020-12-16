Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15E2DC643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgLPSZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA333C0611C5;
        Wed, 16 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+l4PSg9LRLq5JV1LxjBLu8ocwanQ7rBdRiAM4Vwc710=; b=aEZARXEJD/4PkvJxS1NfCTdcG8
        7YQWHdIp9H9OCl3hS6zOu95T6qgG3M83TyJq0r+XYVdkQlMrrZwCA+ELcHanwyYGOWd6Qo410YRwG
        HlkPrPfX2eW1c/0nXxu1iMbALgjat9Li+0Yt9hvvYLAy5m7MYV0xrJTkwFH52pq11wsgwUlyHONq6
        ylbGBPYieMT6HcMjfmjO0Xe0WgWZ2yJvVOkZAzv71NqbWmX22LEVMG69EXncLJMUI1ioKG0Ci6sBN
        hrwFLTRHy1LkI6TFBtZ4KH91zDorMmj8ZkK8L/q4RihpNjd7t1a7dYmbE8mkCZzsH6cmX0Fu4LimS
        xGUBwtrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSa-00075x-Tr; Wed, 16 Dec 2020 18:23:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] mm: Introduce struct folio
Date:   Wed, 16 Dec 2020 18:23:11 +0000
Message-Id: <20201216182335.27227-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have trouble keeping track of whether we've already called
compound_head() to ensure we're not operating on a tail page.  Further,
it's never clear whether we intend a struct page to refer to PAGE_SIZE
bytes or page_size(compound_head(page)).

Introduce a new type 'struct folio' that always refers to an entire
(possibly compound) page, and points to the head page (or base page).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 10 ++++++++++
 include/linux/mm_types.h | 17 +++++++++++++++++
 include/linux/pagemap.h  | 14 ++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5299b90a6c40..ed20fd0c6169 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -916,6 +916,11 @@ static inline unsigned int compound_order(struct page *page)
 	return page[1].compound_order;
 }
 
+static inline unsigned int folio_order(struct folio *folio)
+{
+	return compound_order(&folio->page);
+}
+
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
@@ -967,6 +972,11 @@ static inline unsigned int page_shift(struct page *page)
 
 void free_compound_page(struct page *page);
 
+static inline unsigned long folio_nr_pages(struct folio *folio)
+{
+	return compound_nr(&folio->page);
+}
+
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 65df8abd90bd..d7e487d9998f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -223,6 +223,23 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/*
+ * A struct folio is either a base (order-0) page or the head page of
+ * a compound page.
+ */
+struct folio {
+	struct page page;
+};
+
+static inline struct folio *page_folio(struct page *page)
+{
+	unsigned long head = READ_ONCE(page->compound_head);
+
+	if (unlikely(head & 1))
+		return (struct folio *)(head - 1);
+	return (struct folio *)page;
+}
+
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
 {
 	return &page[1].compound_mapcount;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f18857c79478..b5af2c3719ab 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -437,6 +437,20 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
 	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
 }
 
+static inline pgoff_t folio_index(struct folio *folio)
+{
+        if (unlikely(FolioSwapCache(folio)))
+                return __page_file_index(&folio->page);
+        return folio->page.index;
+}
+
+static inline struct page *folio_page(struct folio *folio, pgoff_t index)
+{
+	index -= folio_index(folio);
+	VM_BUG_ON_PAGE(index >= folio_nr_pages(folio), &folio->page);
+	return &folio->page + index;
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.29.2

