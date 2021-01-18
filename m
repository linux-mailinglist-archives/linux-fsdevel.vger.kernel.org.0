Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D62FA6FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbhARRDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406858AbhARRDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B2C0613ED;
        Mon, 18 Jan 2021 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ufUXMOs3Jho3uC8zMy9YfnubEmaG7VdjjL2WDlyXjJo=; b=Pbm/dHPE9HRE7Ev8NizoeIXTaT
        NAHEBO4KsU6YDBQa9rUeUsRW7B1Khz4I1jGWxMosgFlJgKZZNHhHuImVQN0OXM8rEdjTEYtcmiWBj
        iyl04UWqpxrBQ9sLnXLdR6PymZnZ9MhI/0tSKsBOHH6HW6s0Xid1pcRH8ACsJn4zqynLqk+QXmfcR
        dY4cNp1fa7UiEKOsxr6atvf0nBtCe0aluknhb3iHNoTz4Cc3YGO1XiNmjpWgBKxSvsSr2nL1KRE8l
        6q4ZXap3CGflpvCOEw7T0jids5AU5nI9InzuBAKEkDu0QbECgnyYADJp10ZgSoRS1ewnu3hmByAU/
        Z9Z95LaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuk-00D7Ie-1n; Mon, 18 Jan 2021 17:02:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/27] mm: Handle per-folio private data
Date:   Mon, 18 Jan 2021 17:01:29 +0000
Message-Id: <20210118170148.3126186-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add folio_private() and set_folio_private() which mirror page_private()
and set_page_private() -- ie folio private data is the same as page
private data.

Turn attach_page_private() into attach_folio_private() and reimplement
attach_page_private() as a wrapper.  No filesystem which uses page private
data currently supports compound pages, so we're free to define the rules.
attach_page_private() may only be called on a head page; if you want
to add private data to a tail page, you can call set_page_private()
directly (and shouldn't increment the page refcount!  That should be
done when adding private data to the head page / folio).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 16 ++++++++++++++
 include/linux/pagemap.h  | 48 ++++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 875dc6cd6ad2..750184130074 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -258,6 +258,12 @@ static inline atomic_t *compound_pincount_ptr(struct page *page)
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
@@ -265,6 +271,16 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+static inline unsigned long folio_private(struct folio *folio)
+{
+	return folio->page.private;
+}
+
+static inline void set_folio_private(struct folio *folio, unsigned long v)
+{
+	folio->page.private = v;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4317f34866c7..a739ada01d27 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -245,42 +245,52 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 }
 
 /**
- * attach_page_private - Attach private data to a page.
- * @page: Page to attach data to.
- * @data: Data to attach to page.
+ * attach_folio_private - Attach private data to a folio.
+ * @folio: Folio to attach data to.
+ * @data: Data to attach to folio.
  *
- * Attaching private data to a page increments the page's reference count.
- * The data must be detached before the page will be freed.
+ * Attaching private data to a folio increments the page's reference count.
+ * The data must be detached before the folio will be freed.
  */
-static inline void attach_page_private(struct page *page, void *data)
+static inline void attach_folio_private(struct folio *folio, void *data)
 {
-	get_page(page);
-	set_page_private(page, (unsigned long)data);
-	SetPagePrivate(page);
+	get_folio(folio);
+	set_folio_private(folio, (unsigned long)data);
+	SetFolioPrivate(folio);
 }
 
 /**
- * detach_page_private - Detach private data from a page.
- * @page: Page to detach data from.
+ * detach_folio_private - Detach private data from a folio.
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
+static inline void *detach_folio_private(struct folio *folio)
 {
-	void *data = (void *)page_private(page);
+	void *data = (void *)folio_private(folio);
 
-	if (!PagePrivate(page))
+	if (!FolioPrivate(folio))
 		return NULL;
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
+	ClearFolioPrivate(folio);
+	set_folio_private(folio, 0);
+	put_folio(folio);
 
 	return data;
 }
 
+static inline void attach_page_private(struct page *page, void *data)
+{
+	attach_folio_private((struct folio *)page, data);
+}
+
+static inline void *detach_page_private(struct page *page)
+{
+	return detach_folio_private((struct folio *)page);
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
-- 
2.29.2

