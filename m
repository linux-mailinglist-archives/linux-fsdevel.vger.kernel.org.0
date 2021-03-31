Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA93506D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhCaSwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhCaSvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:51:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC6C061574;
        Wed, 31 Mar 2021 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UWHeHsllT9ZiEOYro8cKQsTwlkHpjYHdXFC7Eo815rY=; b=R6hDd8dpqFqokWtY1cAjS6Bs5I
        7ZEUrDkQaRAk7HEDGHzW2AgeSAtfy4zWwQhOCF2JHPx4Jvkfiar53ymhDO2B3LneKLU/V+ZTbuB4S
        j1PdUxLDRdGHqhG7tn71iwxsgsWMY6f/888bzopq90/cgcRL+VVOhxGA+4mQzRv4uEw2MC1Lijnss
        jxWiy6L40LWBcHBtemouwhOQBy2Koz0+Re/IsWqi04w472dB/BPO15hQ+KVf1qEEUwqAxMw8LXgJk
        xRygUDitg+f6bTI2S3hjMtwWh3rHtSbJFH6hoQOXBK45H3v/n8J3cs6H+F9SiCoQkqSmIgRSvPDId
        ROpqkTlw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfum-004zP5-Ca; Wed, 31 Mar 2021 18:50:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 09/27] mm: Handle per-folio private data
Date:   Wed, 31 Mar 2021 19:47:10 +0100
Message-Id: <20210331184728.1188084-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add folio_private() and set_folio_private() which mirror page_private()
and set_page_private() -- ie folio private data is the same as page
private data.  The only difference is that these return a void *
instead of an unsigned long, which matches the majority of users.

Turn attach_page_private() into attach_folio_private() and reimplement
attach_page_private() as a wrapper.  No filesystem which uses page private
data currently supports compound pages, so we're free to define the rules.
attach_page_private() may only be called on a head page; if you want
to add private data to a tail page, you can call set_page_private()
directly (and shouldn't increment the page refcount!  That should be
done when adding private data to the head page / folio).

This saves 597 bytes of text with the distro-derived config that I'm
testing due to removing the calls to compound_head() in get_page()
& put_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_types.h | 16 ++++++++++++++
 include/linux/pagemap.h  | 48 ++++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a0c7894fad1d..1fe32ada3dab 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -307,6 +307,12 @@ static inline atomic_t *compound_pincount_ptr(struct page *page)
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
@@ -314,6 +320,16 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+static inline void *folio_private(struct folio *folio)
+{
+	return (void *)folio->private;
+}
+
+static inline void set_folio_private(struct folio *folio, void *v)
+{
+	folio->private = (unsigned long)v;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8c844ba67785..6676210addf6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -260,42 +260,52 @@ static inline int page_cache_add_speculative(struct page *page, int count)
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
+	set_folio_private(folio, data);
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
+	void *data = folio_private(folio);
 
-	if (!PagePrivate(page))
+	if (!FolioPrivate(folio))
 		return NULL;
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
+	ClearFolioPrivate(folio);
+	set_folio_private(folio, NULL);
+	put_folio(folio);
 
 	return data;
 }
 
+static inline void attach_page_private(struct page *page, void *data)
+{
+	attach_folio_private(page_folio(page), data);
+}
+
+static inline void *detach_page_private(struct page *page)
+{
+	return detach_folio_private(page_folio(page));
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
-- 
2.30.2

