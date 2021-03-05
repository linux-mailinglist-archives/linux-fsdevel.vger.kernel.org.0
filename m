Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC40F32E080
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEETO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEETN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA715C061756;
        Thu,  4 Mar 2021 20:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A+aKTxH1jcd4vDiytddTmJl7H4EV0ZPBIjE0cYaDNCI=; b=A4wG4jzqn9eHv9/2JTAvx+xA/U
        25l66qpt/vLi9bDvZsHz9Zc3oJklrTMd2Qx8/HTrr6MrO4d9oq69lXC2c6GlXZ5akGhJBeKCvWudU
        9Qncc7ku0kF+vAVL0yvGEFAfaiIzukYjYQ59Z49VvZIL3qRXCbtcHaMBYXXDrgOrjqLkLTRsmMBnw
        gs8as3GeHsTDPDENrkLFJQywPSh4JC1y9dULBcEowIIHUJbZMzGoJBi+2cyhFnERZLK1wFFhU8DjC
        AZgUqKCQQQSfvuURYACDnr3WUwcyvYDmmhbJqAwB4qriB3jednMywuMUxrNd2M6a/vlRfj6GDl/mM
        +XTB+qdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vg-00A3SJ-7k; Fri, 05 Mar 2021 04:19:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/25] mm: Introduce struct folio
Date:   Fri,  5 Mar 2021 04:18:37 +0000
Message-Id: <20210305041901.2396498-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A struct folio refers to an entire (possibly compound) page.  A function
which takes a struct folio argument declares that it will operate on the
entire compound page, not just PAGE_SIZE bytes.  In return, the caller
guarantees that the pointer it is passing does not point to a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 30 ++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 17 +++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..a46e5a4385b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -927,6 +927,11 @@ static inline unsigned int compound_order(struct page *page)
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
@@ -1518,6 +1523,30 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
+static inline unsigned long folio_nr_pages(struct folio *folio)
+{
+	return compound_nr(&folio->page);
+}
+
+static inline struct folio *next_folio(struct folio *folio)
+{
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
+#else
+	return folio + folio_nr_pages(folio);
+#endif
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
 /*
  * Some inline functions in vmstat.h depend on page_zone()
  */
@@ -1623,6 +1652,7 @@ extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0974ad501a47..a311cb48526f 100644
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
2.30.0

