Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15873A703C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhFNU0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhFNUZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:25:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0396C061574;
        Mon, 14 Jun 2021 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zne2/nkNs6lDVdViSWPCepYlaJz7fewXhdWxIYhx5r4=; b=mkgRS/T4yUY9qJuhe+r7hskTn3
        8K4cKz8YsNQd66XEJYyB3yViM7xLbB8S5OLhqSZDKnUSu6GRiWRbj+vQIizbtzRv2lJ0BXyi39Tc7
        MOM9Up/kBo43yfeoRixxso8x9Wh95sc7fM74JIffNSw4aPEyzcXGGgDAmUg6rQZpFITRiGN9JX38g
        wFvuT5fBuAhPva6U9srgkAs2uiDVSPM6u1MUJWkTxJ4ZfBoEuMTvSydReFaiUcXGhcWxl31YE3BdE
        rlMA5At9IxOUsD+d1zgJCfRDDD9gOZUKsAcxRZlcig3IUa277IzqzLsVk8pNovUbdT9TbH9HHxJwO
        cQn2vPYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lst6r-005nVA-Ql; Mon, 14 Jun 2021 20:23:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 12/33] mm: Handle per-folio private data
Date:   Mon, 14 Jun 2021 21:14:14 +0100
Message-Id: <20210614201435.1379188-13-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add folio_get_private() which mirrors page_private() -- ie folio private
data is the same as page private data.  The only difference is that these
return a void * instead of an unsigned long, which matches the majority
of users.

Turn attach_page_private() into folio_attach_private() and reimplement
attach_page_private() as a wrapper.  No filesystem which uses page private
data currently supports compound pages, so we're free to define the rules.
attach_page_private() may only be called on a head page; if you want
to add private data to a tail page, you can call set_page_private()
directly (and shouldn't increment the page refcount!  That should be
done when adding private data to the head page / folio).

This saves 813 bytes of text with the distro-derived config that I'm
testing due to removing the calls to compound_head() in get_page()
& put_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm_types.h | 11 +++++++++
 include/linux/pagemap.h  | 48 ++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3118ba8b5a4e..943854268986 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -302,6 +302,12 @@ static inline atomic_t *compound_pincount_ptr(struct page *page)
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
+/*
+ * page_private can be used on tail pages.  However, PagePrivate is only
+ * checked by the VM on the head page.  So page_private on the tail pages
+ * should be used for data that's ancillary to the head page (eg attaching
+ * buffer heads to tail pages after attaching buffer heads to the head page)
+ */
 #define page_private(page)		((page)->private)
 
 static inline void set_page_private(struct page *page, unsigned long private)
@@ -309,6 +315,11 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+static inline void *folio_get_private(struct folio *folio)
+{
+	return folio->private;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c34abf2acc8b..91aaf3207ad0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -184,42 +184,52 @@ static inline bool page_cache_get_speculative(struct page *page)
 }
 
 /**
- * attach_page_private - Attach private data to a page.
- * @page: Page to attach data to.
- * @data: Data to attach to page.
+ * folio_attach_private - Attach private data to a folio.
+ * @folio: Folio to attach data to.
+ * @data: Data to attach to folio.
  *
- * Attaching private data to a page increments the page's reference count.
- * The data must be detached before the page will be freed.
+ * Attaching private data to a folio increments the page's reference count.
+ * The data must be detached before the folio will be freed.
  */
-static inline void attach_page_private(struct page *page, void *data)
+static inline void folio_attach_private(struct folio *folio, void *data)
 {
-	get_page(page);
-	set_page_private(page, (unsigned long)data);
-	SetPagePrivate(page);
+	folio_get(folio);
+	folio->private = data;
+	folio_set_private_flag(folio);
 }
 
 /**
- * detach_page_private - Detach private data from a page.
- * @page: Page to detach data from.
+ * folio_detach_private - Detach private data from a folio.
+ * @folio: Folio to detach data from.
  *
- * Removes the data that was previously attached to the page and decrements
+ * Removes the data that was previously attached to the folio and decrements
  * the refcount on the page.
  *
- * Return: Data that was attached to the page.
+ * Return: Data that was attached to the folio.
  */
-static inline void *detach_page_private(struct page *page)
+static inline void *folio_detach_private(struct folio *folio)
 {
-	void *data = (void *)page_private(page);
+	void *data = folio_get_private(folio);
 
-	if (!PagePrivate(page))
+	if (!folio_private(folio))
 		return NULL;
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
+	folio_clear_private_flag(folio);
+	folio->private = NULL;
+	folio_put(folio);
 
 	return data;
 }
 
+static inline void attach_page_private(struct page *page, void *data)
+{
+	folio_attach_private(page_folio(page), data);
+}
+
+static inline void *detach_page_private(struct page *page)
+{
+	return folio_detach_private(page_folio(page));
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
-- 
2.30.2

