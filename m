Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B935342AF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCTFmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCTFlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:41:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B572C061763;
        Fri, 19 Mar 2021 22:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7i7dpiy20TKP25FraTQAvT/YVqPPPkqepGxh3hoJGwk=; b=pxLGcFecXlUmulJi2BC09lxW/R
        VZYE6xVdRIAJPV3kYfnprew0orCAbk294CswkmdkckVpSvlcjeDj522lcVgAAlSrlsEAeOHPz2YpW
        tRukWhDrVG/PXw9wc7GsirH8KixAbQ3pk0eYj5TG3kyOUGcv9wrtJN2tEzmAZ4ioJNKj1BNPauJan
        +DG4jhc8icpmbnO6h/3pvKpFTjR9arvrUJGE6jN4C6IX0rTFFMluCopQEWZanpMf6c+xm8EPQSXSg
        7e6zmEDCoIVvuw7vA4XJN4gQckXgTtamDxgtnggVb75S+HicBqDMBbbOvCZ8T0fgUep2oA3z4CPkq
        MrP21kIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMn-005SRq-9S; Sat, 20 Mar 2021 05:41:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 04/27] mm: Introduce struct folio
Date:   Sat, 20 Mar 2021 05:40:41 +0000
Message-Id: <20210320054104.1300774-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A struct folio is a new abstraction for a head-or-single page.  A function
which takes a struct folio argument declares that it will operate on the
entire (possibly compound) page, not just PAGE_SIZE bytes.  In return,
the caller guarantees that the pointer it is passing does not point to
a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 78 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 36 +++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb1e191da319..9b7e3fa12fd3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -934,6 +934,20 @@ static inline unsigned int compound_order(struct page *page)
 	return page[1].compound_order;
 }
 
+/**
+ * folio_order - The allocation order of a folio.
+ * @folio: The folio.
+ *
+ * A folio is composed of 2^order pages.  See get_order() for the definition
+ * of order.
+ *
+ * Return: The order of the folio.
+ */
+static inline unsigned int folio_order(struct folio *folio)
+{
+	return compound_order(&folio->page);
+}
+
 static inline bool hpage_pincount_available(struct page *page)
 {
 	/*
@@ -1579,6 +1593,69 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
+/**
+ * folio_nr_pages - The number of pages in the folio.
+ * @folio: The folio.
+ *
+ * Return: A number which is a power of two.
+ */
+static inline unsigned long folio_nr_pages(struct folio *folio)
+{
+	return compound_nr(&folio->page);
+}
+
+/**
+ * folio_next - Move to the next physical folio.
+ * @folio: The folio we're currently operating on.
+ *
+ * If you have physically contiguous memory which may span more than
+ * one folio (eg a &struct bio_vec), use this function to move from one
+ * folio to the next.  Do not use it if the memory is only virtually
+ * contiguous as the folios are almost certainly not adjacent to each
+ * other.  This is the folio equivalent to writing ``page++``.
+ *
+ * Context: We assume that the folios are refcounted and/or locked at a
+ * higher level and do not adjust the reference counts.
+ * Return: The next struct folio.
+ */
+static inline struct folio *folio_next(struct folio *folio)
+{
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
+#else
+	return folio + folio_nr_pages(folio);
+#endif
+}
+
+/**
+ * folio_shift - The number of bits covered by this folio.
+ * @folio: The folio.
+ *
+ * A folio contains a number of bytes which is a power-of-two in size.
+ * This function tells you which power-of-two the folio is.
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The base-2 logarithm of the size of this folio.
+ */
+static inline unsigned int folio_shift(struct folio *folio)
+{
+	return PAGE_SHIFT + folio_order(folio);
+}
+
+/**
+ * folio_size - The number of bytes in a folio.
+ * @folio: The folio.
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The number of bytes in this folio.
+ */
+static inline size_t folio_size(struct folio *folio)
+{
+	return PAGE_SIZE << folio_order(folio);
+}
+
 /*
  * Some inline functions in vmstat.h depend on page_zone()
  */
@@ -1683,6 +1760,7 @@ extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..4fc0b230d3ea 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -224,6 +224,42 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/**
+ * struct folio - Represents a contiguous set of bytes.
+ * @page: Either a base (order-0) page or the head page of a compound page.
+ *
+ * A folio is a physically, virtually and logically contiguous set
+ * of bytes.  It is a power-of-two in size, and it is aligned to that
+ * same power-of-two.  If it is found in the page cache, it is at a file
+ * offset which is a multiple of that power-of-two.  It is at least as
+ * large as PAGE_SIZE.
+ */
+struct folio {
+	struct page page;
+};
+
+/**
+ * page_folio - Converts from page to folio.
+ * @page: The page.
+ *
+ * Every page is part of a folio.  This function cannot be called on a
+ * NULL pointer.
+ *
+ * Context: No reference, nor lock is required on @page.  If the caller
+ * does not hold a reference, this call may race with a folio split, so
+ * it should re-check the folio still contains this page after gaining
+ * a reference on the folio.
+ * Return: The folio which contains this page.
+ */
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
2.30.2

