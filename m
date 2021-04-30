Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A2370042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhD3SNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3SNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:13:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6509C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wla73m9GMI3KT+/OIb8Q28JScvTBCk88HDin7LzBIB8=; b=fww5W1qakJb18a7fC19uiwFd8u
        YUYmXF+nt2WMi0nSLbHJdntbcD1Du6yjQrU+bwc+JLqcWONG55qa/MX5bXmqIZXIc7V8zHtrZuWNK
        sw/3Vkv57KiI2m/uMi0Z2cYpbiY4CDcq/bLHWWaFDwR7eWURre89iZBIPkDnfH8ZvDI3nbwqnfQhR
        x7XyV2erfdzFIrG+34cbdX3MNnDuI6ePIUGvoJDR/wZU2/0+pyZuQg71jasajYuvL3ZO+Mg908vXF
        YNwiX8lJExs6WpEycTp3e3aAykPNKpJsbo9Cu6C3ywdx4cC99WgJ3SJpRQATOseEh7GSmh7pxBxRB
        +MJn/gng==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXbZ-00BMWl-3T; Fri, 30 Apr 2021 18:11:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 05/31] mm: Add folio reference count functions
Date:   Fri, 30 Apr 2021 19:07:14 +0100
Message-Id: <20210430180740.2707166-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions mirror their page reference counterparts.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/core-api/mm-api.rst |  1 +
 include/linux/page_ref.h          | 88 ++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index cbf5858dadac..88545b2dce98 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -98,3 +98,4 @@ More Memory Management Functions
 .. kernel-doc:: include/linux/page-flags.h
 .. kernel-doc:: include/linux/mm.h
    :internal:
+.. kernel-doc:: include/linux/page_ref.h
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 7ad46f45df39..85816b2c0496 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -67,9 +67,31 @@ static inline int page_ref_count(const struct page *page)
 	return atomic_read(&page->_refcount);
 }
 
+/**
+ * folio_ref_count - The reference count on this folio.
+ * @folio: The folio.
+ *
+ * The refcount is usually incremented by calls to folio_get() and
+ * decremented by calls to folio_put().  Some typical users of the
+ * folio refcount:
+ *
+ * - Each reference from a page table
+ * - The page cache
+ * - Filesystem private data
+ * - The LRU list
+ * - Pipes
+ * - Direct IO which references this page in the process address space
+ *
+ * Return: The number of references to this folio.
+ */
+static inline int folio_ref_count(const struct folio *folio)
+{
+	return page_ref_count(&folio->page);
+}
+
 static inline int page_count(const struct page *page)
 {
-	return atomic_read(&compound_head(page)->_refcount);
+	return folio_ref_count(page_folio(page));
 }
 
 static inline void set_page_count(struct page *page, int v)
@@ -79,6 +101,11 @@ static inline void set_page_count(struct page *page, int v)
 		__page_ref_set(page, v);
 }
 
+static inline void folio_set_count(struct folio *folio, int v)
+{
+	set_page_count(&folio->page, v);
+}
+
 /*
  * Setup the page count before being freed into the page allocator for
  * the first time (boot or memory hotplug)
@@ -95,6 +122,11 @@ static inline void page_ref_add(struct page *page, int nr)
 		__page_ref_mod(page, nr);
 }
 
+static inline void folio_ref_add(struct folio *folio, int nr)
+{
+	page_ref_add(&folio->page, nr);
+}
+
 static inline void page_ref_sub(struct page *page, int nr)
 {
 	atomic_sub(nr, &page->_refcount);
@@ -102,6 +134,11 @@ static inline void page_ref_sub(struct page *page, int nr)
 		__page_ref_mod(page, -nr);
 }
 
+static inline void folio_ref_sub(struct folio *folio, int nr)
+{
+	page_ref_sub(&folio->page, nr);
+}
+
 static inline int page_ref_sub_return(struct page *page, int nr)
 {
 	int ret = atomic_sub_return(nr, &page->_refcount);
@@ -111,6 +148,11 @@ static inline int page_ref_sub_return(struct page *page, int nr)
 	return ret;
 }
 
+static inline int folio_ref_sub_return(struct folio *folio, int nr)
+{
+	return page_ref_sub_return(&folio->page, nr);
+}
+
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
@@ -118,6 +160,11 @@ static inline void page_ref_inc(struct page *page)
 		__page_ref_mod(page, 1);
 }
 
+static inline void folio_ref_inc(struct folio *folio)
+{
+	page_ref_inc(&folio->page);
+}
+
 static inline void page_ref_dec(struct page *page)
 {
 	atomic_dec(&page->_refcount);
@@ -125,6 +172,11 @@ static inline void page_ref_dec(struct page *page)
 		__page_ref_mod(page, -1);
 }
 
+static inline void folio_ref_dec(struct folio *folio)
+{
+	page_ref_dec(&folio->page);
+}
+
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
 	int ret = atomic_sub_and_test(nr, &page->_refcount);
@@ -134,6 +186,11 @@ static inline int page_ref_sub_and_test(struct page *page, int nr)
 	return ret;
 }
 
+static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
+{
+	return page_ref_sub_and_test(&folio->page, nr);
+}
+
 static inline int page_ref_inc_return(struct page *page)
 {
 	int ret = atomic_inc_return(&page->_refcount);
@@ -143,6 +200,11 @@ static inline int page_ref_inc_return(struct page *page)
 	return ret;
 }
 
+static inline int folio_ref_inc_return(struct folio *folio)
+{
+	return page_ref_inc_return(&folio->page);
+}
+
 static inline int page_ref_dec_and_test(struct page *page)
 {
 	int ret = atomic_dec_and_test(&page->_refcount);
@@ -152,6 +214,11 @@ static inline int page_ref_dec_and_test(struct page *page)
 	return ret;
 }
 
+static inline int folio_ref_dec_and_test(struct folio *folio)
+{
+	return page_ref_dec_and_test(&folio->page);
+}
+
 static inline int page_ref_dec_return(struct page *page)
 {
 	int ret = atomic_dec_return(&page->_refcount);
@@ -161,6 +228,11 @@ static inline int page_ref_dec_return(struct page *page)
 	return ret;
 }
 
+static inline int folio_ref_dec_return(struct folio *folio)
+{
+	return page_ref_dec_return(&folio->page);
+}
+
 static inline int page_ref_add_unless(struct page *page, int nr, int u)
 {
 	int ret = atomic_add_unless(&page->_refcount, nr, u);
@@ -170,6 +242,11 @@ static inline int page_ref_add_unless(struct page *page, int nr, int u)
 	return ret;
 }
 
+static inline int folio_ref_add_unless(struct folio *folio, int nr, int u)
+{
+	return page_ref_add_unless(&folio->page, nr, u);
+}
+
 static inline int page_ref_freeze(struct page *page, int count)
 {
 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
@@ -179,6 +256,11 @@ static inline int page_ref_freeze(struct page *page, int count)
 	return ret;
 }
 
+static inline int folio_ref_freeze(struct folio *folio, int count)
+{
+	return page_ref_freeze(&folio->page, count);
+}
+
 static inline void page_ref_unfreeze(struct page *page, int count)
 {
 	VM_BUG_ON_PAGE(page_count(page) != 0, page);
@@ -189,4 +271,8 @@ static inline void page_ref_unfreeze(struct page *page, int count)
 		__page_ref_unfreeze(page, count);
 }
 
+static inline void folio_ref_unfreeze(struct folio *folio, int count)
+{
+	page_ref_unfreeze(&folio->page, count);
+}
 #endif
-- 
2.30.2

