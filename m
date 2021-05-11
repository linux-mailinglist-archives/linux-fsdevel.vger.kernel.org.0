Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9819E37B0FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKVtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 17:49:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BC8C061574;
        Tue, 11 May 2021 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VsWmwPE6feLkmo3kik9m561VbErymgVmAmnlVHgf2Go=; b=Ecam7vnyf2ZpS4rHIdurHNb/6C
        XOOUlF+XkitVkgWDhgsNrI9Wd1OFhDBaCfDJzbrBehKgudyGwCK/NFLYN+a922nP6n0RI+mqJ2phI
        vx2GAWIzTJgmE3nhVUbD3KzKC3dl49UMp4nDr2PIDiFbnuvUbIMi9G1wNJUgnOJnK/zc1YUMFXzq1
        W/TVxcTSkzrJgxCWuU6vyfr3MOvKC79RxzGBTrq0RwIY7b/DzQkKYz30wufZB5hAnfB0+wmUeYbQ5
        EJyCHKgW8RbPdLoFuz410DYnpEoq4BUNPjLyEQKIULy7lwF0kBqn1fP+2TInT5Dg2R+0zHwfN+VsG
        L54xmFXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaEQ-007hhY-TQ; Tue, 11 May 2021 21:48:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 01/33] mm: Introduce struct folio
Date:   Tue, 11 May 2021 22:47:03 +0100
Message-Id: <20210511214735.1836149-2-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A struct folio is a new abstraction to replace the venerable struct page.
A function which takes a struct folio argument declares that it will
operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
In return, the caller guarantees that the pointer it is passing does
not point to a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/core-api/mm-api.rst |  1 +
 include/linux/mm.h                | 74 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h          | 60 +++++++++++++++++++++++++
 include/linux/page-flags.h        | 27 +++++++++++
 4 files changed, 162 insertions(+)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index a42f9baddfbf..2a94e6164f80 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -95,6 +95,7 @@ More Memory Management Functions
 .. kernel-doc:: mm/mempolicy.c
 .. kernel-doc:: include/linux/mm_types.h
    :internal:
+.. kernel-doc:: include/linux/page-flags.h
 .. kernel-doc:: include/linux/mm.h
    :internal:
 .. kernel-doc:: include/linux/mmzone.h
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2327f99b121f..b29c86824e6b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -950,6 +950,20 @@ static inline unsigned int compound_order(struct page *page)
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
@@ -1595,6 +1609,65 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
+	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
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
@@ -1699,6 +1772,7 @@ extern void pagefault_out_of_memory(void);
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
 
 /*
  * Flags passed to show_mem() and show_free_areas() to suppress output in
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..3118ba8b5a4e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -224,6 +224,66 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/**
+ * struct folio - Represents a contiguous set of bytes.
+ * @flags: Identical to the page flags.
+ * @lru: Least Recently Used list; tracks how recently this folio was used.
+ * @mapping: The file this page belongs to, or refers to the anon_vma for
+ *    anonymous pages.
+ * @index: Offset within the file, in units of pages.  For anonymous pages,
+ *    this is the index from the beginning of the mmap.
+ * @private: Filesystem per-folio data (see folio_attach_private()).
+ *    Used for swp_entry_t if folio_swapcache().
+ * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
+ *    find out how many times this folio is mapped by userspace.
+ * @_refcount: Do not access this member directly.  Use folio_ref_count()
+ *    to find how many references there are to this folio.
+ * @memcg_data: Memory Control Group data.
+ *
+ * A folio is a physically, virtually and logically contiguous set
+ * of bytes.  It is a power-of-two in size, and it is aligned to that
+ * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
+ * in the page cache, it is at a file offset which is a multiple of that
+ * power-of-two.  It may be mapped into userspace at an address which is
+ * at an arbitrary page offset, but its kernel virtual address is aligned
+ * to its size.
+ */
+struct folio {
+	/* private: don't document the anon union */
+	union {
+		struct {
+	/* public: */
+			unsigned long flags;
+			struct list_head lru;
+			struct address_space *mapping;
+			pgoff_t index;
+			void *private;
+			atomic_t _mapcount;
+			atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+			unsigned long memcg_data;
+#endif
+	/* private: the union with struct page is transitional */
+		};
+		struct page page;
+	};
+};
+
+static_assert(sizeof(struct page) == sizeof(struct folio));
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
+FOLIO_MATCH(flags, flags);
+FOLIO_MATCH(lru, lru);
+FOLIO_MATCH(compound_head, lru);
+FOLIO_MATCH(index, index);
+FOLIO_MATCH(private, private);
+FOLIO_MATCH(_mapcount, _mapcount);
+FOLIO_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+FOLIO_MATCH(memcg_data, memcg_data);
+#endif
+#undef FOLIO_MATCH
+
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
 {
 	return &page[1].compound_mapcount;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d8e26243db25..e069aa8b11b7 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -188,6 +188,33 @@ static inline unsigned long _compound_head(const struct page *page)
 
 #define compound_head(page)	((typeof(page))_compound_head(page))
 
+/**
+ * page_folio - Converts from page to folio.
+ * @p: The page.
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
+#define page_folio(p)		(_Generic((p),				\
+	const struct page *:	(const struct folio *)_compound_head(p), \
+	struct page *:		(struct folio *)_compound_head(p)))
+
+/**
+ * folio_page - Return a page from a folio.
+ * @folio: The folio.
+ * @n: The page number to return.
+ *
+ * @n is relative to the start of the folio.  It should be between
+ * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
+ */
+#define folio_page(folio, n)	nth_page(&(folio)->page, n)
+
 static __always_inline int PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1;
-- 
2.30.2

