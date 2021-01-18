Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F169E2FA86D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407060AbhARRVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391575AbhARRCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:02:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B1C061574;
        Mon, 18 Jan 2021 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GiGV59fseE/dUGuOBWZVrWWnl8FxLW/HEwRXpXDCibY=; b=U5T8xGax/StZjW8cKV+M0UUYMa
        ES4mcbkGJPkHuRYCaaYSOTBMPKg7gR9F25yoWnhoiBYsEjRzTYRjbPu+yLtxardh3R4kb5p6cb1dA
        tp/E9mV+5pxhrGUsUj0iaqtvoVhj7+yrp1MH54/eRiNw8SJC3VPvdRBC4QisJAGj5JKry2TFZaK7I
        AwhWPSKRPjLdvuGOMlWvUCUtREJ4k586x43/h3JOxjPSbiyi90+gzylpY0f+xpl1un3fsBkDg4y/L
        cCV9KHhGVMO+D/KN1D7HPJnhC9zEN0asFqLtsa8XAKhmDtMZuvarzSS5wKlJwl2eZMUfzgcPghtcs
        Rk7MHMJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XuZ-00D7HK-6p; Mon, 18 Jan 2021 17:01:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/27] mm: Introduce struct folio
Date:   Mon, 18 Jan 2021 17:01:22 +0000
Message-Id: <20210118170148.3126186-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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
index a5d618d08506..0858af6479a3 100644
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
@@ -1615,6 +1640,7 @@ extern void pagefault_out_of_memory(void);
 
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

