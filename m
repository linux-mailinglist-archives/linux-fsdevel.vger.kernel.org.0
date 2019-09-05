Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEDEAAAD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfIESXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:23:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389837AbfIESXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1QLSFFXUGzf9sZNnPcKI2Z9BvmtAY43QLuh0XGQS/rg=; b=ZlX5W95i+L/mDBug7zVcWALuB9
        Qg/q/3eWRr0nv2cDXYn6ZFCg4/Du+aym+zSHkwl8AsIVMGRepn8UGpe+JoypvYYv5rJraeLr2nveS
        OdUU8FrnozHR6LrZc7E8lHd95iL+kwR9hyl1bY47vCMwt82nAjczOXkVALyrJVgPC+ZSucSp8Vrtb
        8kMF/ytkkNjm6kLQZzO7axSvYdfkc2E/6yu1+sVO7GZMNjmuvMpASP9SkGiakcWQOiFf0CPtxFhbj
        5tPMedyzTimhnkRVi3AKHsT+XbX2t+FqukqQ6GudbnTxAh4guTnVHBqBq9gKHE29W6MVWuuoZQIfQ
        Vttqkz4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wQA-0001Uq-Uc; Thu, 05 Sep 2019 18:23:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 3/3] mm: Allow find_get_page to be used for large pages
Date:   Thu,  5 Sep 2019 11:23:48 -0700
Message-Id: <20190905182348.5319-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905182348.5319-1-willy@infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
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
 include/linux/pagemap.h |  9 +++++
 mm/filemap.c            | 82 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d2147215d415..72101811524c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -248,6 +248,15 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
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
+#define fgp_order(fgp)		((fgp) >> FGP_ORDER_SHIFT)
 
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		int fgp_flags, gfp_t cache_gfp_mask);
diff --git a/mm/filemap.c b/mm/filemap.c
index ae3c0a70a8e9..904dfabbea52 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1572,7 +1572,71 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 
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
@@ -1614,12 +1678,12 @@ EXPORT_SYMBOL(find_lock_entry);
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
@@ -1632,6 +1696,10 @@ EXPORT_SYMBOL(find_lock_entry);
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
@@ -1646,9 +1714,9 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 	struct page *page;
 
 repeat:
-	page = find_get_entry(mapping, offset);
-	if (xa_is_value(page))
-		page = NULL;
+	page = __find_get_page(mapping, offset, fgp_order(fgp_flags));
+	if (pagecache_is_conflict(page))
+		return NULL;
 	if (!page)
 		goto no_page;
 
@@ -1682,7 +1750,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		if (fgp_flags & FGP_NOFS)
 			gfp_mask &= ~__GFP_FS;
 
-		page = __page_cache_alloc(gfp_mask);
+		page = __page_cache_alloc_order(gfp_mask, fgp_order(fgp_flags));
 		if (!page)
 			return NULL;
 
-- 
2.23.0.rc1

