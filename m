Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AD306E1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhA1HGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhA1HFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EFC06178A;
        Wed, 27 Jan 2021 23:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iqkQaWeyoHOy6D3n24uPSldV+G8EzYaMTJdnrQd1oFM=; b=hqLlrWnm/3wL84VUJncMPeb50C
        MhGUJ1wPmyt1brdyse75jItBRtwofknrzISTsQ+NVWu4Jpb0gSDUgt7Qzbe0U4tmVubeXQW1/lom9
        r9enylvn5Y3qBWrfeFZZuDPINe8llGTRxi3LPty8l+yuYzGGnfzjXpq19ix4maX3G55c3Q3td4GfO
        4Q65dLTzfaQSB10cQ8G0CE0HvEiUQXCLsmGIgC6MTCYjB/QenxJ/bCbe4W10pcKbteWZzdx8Klhme
        Rrdp4sOzjGJ4TmP9wZyfUrK4EySktFF7eQmv2CWMiGqxRN6IbpA43b0PvnqB1G2DnGrLhySfjERPo
        bDgOpsZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Ln-00847O-2J; Thu, 28 Jan 2021 07:04:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/25] mm: Handle per-folio private data
Date:   Thu, 28 Jan 2021 07:03:47 +0000
Message-Id: <20210128070404.1922318-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index fda84e88b2ba..83d24b41fb04 100644
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

