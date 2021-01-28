Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C38306E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhA1HE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhA1HEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:04:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE61C061574;
        Wed, 27 Jan 2021 23:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y+IJTZXb0Cg+ALK4Crpw/iefcNYCXEYM2oo87sfTNr8=; b=sl6I6JpaLUsw6i/CYiDvTC4/SR
        gj907r2zLX0OMCD+k6kDyTkHlliXDNHpL47tnbB+b8Zl26qqqNzSjfMWTGm86gD8V0yl6tc1slYUk
        9wiXV5X1kiFE+KP6t526NJ+dFCDXczTk+69xoXhi2piz1k+NY+DjDqCpkt7DkaXs+UUKe21uxhwtW
        cAO2vkL0Z+2lXlIWnZRQdwO9tjekq0EChcDGrbXIdQ1cF6dV3bvbZFeM0XgmDnvSVnoUSDDfpMAgk
        lJ57YrI39gc6alPvTaoMAlQ9Tl2jpUPu9KqlNVhWkWXOh6KDmJx8rYwVENMCbrqlcTkDcssYN584z
        DHSuPT3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51La-008461-Rp; Thu, 28 Jan 2021 07:04:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/25] mm: Introduce struct folio
Date:   Thu, 28 Jan 2021 07:03:40 +0000
Message-Id: <20210128070404.1922318-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
 include/linux/mm.h       | 26 ++++++++++++++++++++++++++
 include/linux/mm_types.h | 17 +++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d6e715ab8ea..f20504017adf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -924,6 +924,11 @@ static inline unsigned int compound_order(struct page *page)
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
@@ -975,6 +980,26 @@ static inline unsigned int page_shift(struct page *page)
 
 void free_compound_page(struct page *page);
 
+static inline unsigned long folio_nr_pages(struct folio *folio)
+{
+	return compound_nr(&folio->page);
+}
+
+static inline struct folio *next_folio(struct folio *folio)
+{
+	return folio + folio_nr_pages(folio);
+}
+
+static inline unsigned int folio_shift(struct folio *folio)
+{
+	return PAGE_SHIFT + folio_order(folio);
+}
+
+static inline size_t folio_size(struct folio *folio)
+{
+	return PAGE_SIZE << folio_order(folio);
+}
+
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
@@ -1618,6 +1643,7 @@ extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 07d9acb5b19c..875dc6cd6ad2 100644
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
-- 
2.29.2

