Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63B7BD5D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411321AbfIYAwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411314AbfIYAwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Ix+rtdReVpr8/SR97OGNImGLNvgwHl+UyKKIKsaKkA=; b=fLE+BnENwkn3sUfzaA5z8CuT+r
        Be5iNPaViRlrUw+WAU59Nk8I17KZr/+h8+MXkPaBLlD7tH4U1aD7CrcPwSC/SAKNtuevnrzEWVt2W
        5IbOU9J2PlawK466boFdlugxGvR6Ic9ddf1G+k4xEu5auD6F4aGrnAN3uUMwt2IEiivIQCy1e4RYp
        pkvm9w5XVb3ujNdYSBJQZMCS4QNeVwFFm1qHWLvxUaCBrKDt/tqioBuri4s+3mr5AOxfL5W1Bxzc6
        SZxCRgWEDlNAvj8TNdv//vCox6ob3janG2IaVAI0AAcMoHldLHDqWSqkRkTYZNuBm/gugv5pNlKC+
        KnG52EEg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076r-Kb; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/15] mm: Allow find_get_page to be used for large pages
Date:   Tue, 24 Sep 2019 17:52:09 -0700
Message-Id: <20190925005214.27240-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Add FGP_PMD to indicate that we're trying to find-or-create a page that
is at least PMD_ORDER in size.  The internal 'conflict' entry usage
is modelled after that in DAX, but the implementations are different
due to DAX using multi-order entries and the page cache using multiple
order-0 entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 ++++++
 mm/filemap.c            | 99 +++++++++++++++++++++++++++++++++++------
 2 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d610a49be571..d6d97f9fb762 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -248,6 +248,19 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_NOFS		0x00000010
 #define FGP_NOWAIT		0x00000020
 #define FGP_FOR_MMAP		0x00000040
+/*
+ * If you add more flags, increment FGP_ORDER_SHIFT (no further than 25).
+ * Do not insert flags above the FGP order bits.
+ */
+#define FGP_ORDER_SHIFT		7
+#define FGP_PMD			((PMD_SHIFT - PAGE_SHIFT) << FGP_ORDER_SHIFT)
+#define FGP_PUD			((PUD_SHIFT - PAGE_SHIFT) << FGP_ORDER_SHIFT)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define fgp_order(fgp)		((fgp) >> FGP_ORDER_SHIFT)
+#else
+#define fgp_order(fgp)		0
+#endif
 
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		int fgp_flags, gfp_t cache_gfp_mask);
diff --git a/mm/filemap.c b/mm/filemap.c
index afe8f5d95810..8eca91547e40 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1576,7 +1576,71 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 
 	return page;
 }
-EXPORT_SYMBOL(find_get_entry);
+
+static bool pagecache_is_conflict(struct page *page)
+{
+	return page == XA_RETRY_ENTRY;
+}
+
+/**
+ * __find_get_page - Find and get a page cache entry.
+ * @mapping: The address_space to search.
+ * @offset: The page cache index.
+ * @order: The minimum order of the entry to return.
+ *
+ * Looks up the page cache entries at @mapping between @offset and
+ * @offset + 2^@order.  If there is a page cache page, it is returned with
+ * an increased refcount unless it is smaller than @order.
+ *
+ * If the slot holds a shadow entry of a previously evicted page, or a
+ * swap entry from shmem/tmpfs, it is returned.
+ *
+ * Return: the found page, a value indicating a conflicting page or %NULL if
+ * there are no pages in this range.
+ */
+static struct page *__find_get_page(struct address_space *mapping,
+		unsigned long offset, unsigned int order)
+{
+	XA_STATE(xas, &mapping->i_pages, offset);
+	struct page *page;
+
+	rcu_read_lock();
+repeat:
+	xas_reset(&xas);
+	page = xas_find(&xas, offset | ((1UL << order) - 1));
+	if (xas_retry(&xas, page))
+		goto repeat;
+	/*
+	 * A shadow entry of a recently evicted page, or a swap entry from
+	 * shmem/tmpfs.  Skip it; keep looking for pages.
+	 */
+	if (xa_is_value(page))
+		goto repeat;
+	if (!page)
+		goto out;
+	if (compound_order(page) < order) {
+		page = XA_RETRY_ENTRY;
+		goto out;
+	}
+
+	if (!page_cache_get_speculative(page))
+		goto repeat;
+
+	/*
+	 * Has the page moved or been split?
+	 * This is part of the lockless pagecache protocol. See
+	 * include/linux/pagemap.h for details.
+	 */
+	if (unlikely(page != xas_reload(&xas))) {
+		put_page(page);
+		goto repeat;
+	}
+	page = find_subpage(page, offset);
+out:
+	rcu_read_unlock();
+
+	return page;
+}
 
 /**
  * find_lock_entry - locate, pin and lock a page cache entry
@@ -1618,12 +1682,12 @@ EXPORT_SYMBOL(find_lock_entry);
  * pagecache_get_page - find and get a page reference
  * @mapping: the address_space to search
  * @offset: the page index
- * @fgp_flags: PCG flags
+ * @fgp_flags: FGP flags
  * @gfp_mask: gfp mask to use for the page cache data page allocation
  *
  * Looks up the page cache slot at @mapping & @offset.
  *
- * PCG flags modify how the page is returned.
+ * FGP flags modify how the page is returned.
  *
  * @fgp_flags can be:
  *
@@ -1636,6 +1700,10 @@ EXPORT_SYMBOL(find_lock_entry);
  * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
  *   its own locking dance if the page is already in cache, or unlock the page
  *   before returning if we had to add the page to pagecache.
+ * - FGP_PMD: We're only interested in pages at PMD granularity.  If there
+ *   is no page here (and FGP_CREATE is set), we'll create one large enough.
+ *   If there is a smaller page in the cache that overlaps the PMD page, we
+ *   return %NULL and do not attempt to create a page.
  *
  * If FGP_LOCK or FGP_CREAT are specified then the function may sleep even
  * if the GFP flags specified for FGP_CREAT are atomic.
@@ -1649,10 +1717,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 {
 	struct page *page;
 
+	BUILD_BUG_ON(((63 << FGP_ORDER_SHIFT) >> FGP_ORDER_SHIFT) != 63);
 repeat:
-	page = find_get_entry(mapping, offset);
-	if (xa_is_value(page))
-		page = NULL;
+	page = __find_get_page(mapping, offset, fgp_order(fgp_flags));
+	if (pagecache_is_conflict(page))
+		return NULL;
 	if (!page)
 		goto no_page;
 
@@ -1686,7 +1755,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		if (fgp_flags & FGP_NOFS)
 			gfp_mask &= ~__GFP_FS;
 
-		page = __page_cache_alloc(gfp_mask);
+		page = __page_cache_alloc_order(gfp_mask, fgp_order(fgp_flags));
 		if (!page)
 			return NULL;
 
@@ -1704,13 +1773,17 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 			if (err == -EEXIST)
 				goto repeat;
 		}
+		if (page) {
+			if (fgp_order(fgp_flags))
+				count_vm_event(THP_FILE_ALLOC);
 
-		/*
-		 * add_to_page_cache_lru locks the page, and for mmap we expect
-		 * an unlocked page.
-		 */
-		if (page && (fgp_flags & FGP_FOR_MMAP))
-			unlock_page(page);
+			/*
+			 * add_to_page_cache_lru locks the page, and
+			 * for mmap we expect an unlocked page.
+			 */
+			if (fgp_flags & FGP_FOR_MMAP)
+				unlock_page(page);
+		}
 	}
 
 	return page;
-- 
2.23.0

