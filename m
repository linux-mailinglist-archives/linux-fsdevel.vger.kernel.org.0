Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59837B10D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKVwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 17:52:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D823C061574;
        Tue, 11 May 2021 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q4P5rcvZaMp/bH4mFp4CQBNxqKbNEWy+bkY7S8vZvvE=; b=uRovZHWxrg9lRojuWj8OoQFK0V
        4xvZlfPne/uIMduO4m62JmKSpTKOOUOoT9ZZ/fE1Ox+w6twdW3O93CyyuV1AvDjNXIDc6qwxYMPw9
        RPpjIL+H4RjhOFVUhrzFJ/RSKxhWYcqsqdNekqubh6OrEdzvBx24lKvyPZX/wtYmHgFZqbKtOiTkN
        TLXa24X+skMuVuBqIk5ma7QGAyp9xj88beMx+Be2W4XEsOZmUzvC+EfY8uOGEftHeK7/a/uPbgzbr
        AmgEXsBwDawKS/Uvqw6500+noPUqFKpxUkgHlmP4tuxxqzB4gtjGoGtEwQHI9/VHXMZPa5pe37fsj
        XhdlbKFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaGc-007hmi-07; Tue, 11 May 2021 21:50:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 05/33] mm: Add folio reference count functions
Date:   Tue, 11 May 2021 22:47:07 +0100
Message-Id: <20210511214735.1836149-6-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
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
index 2a94e6164f80..5c459ee2acce 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -98,4 +98,5 @@ More Memory Management Functions
 .. kernel-doc:: include/linux/page-flags.h
 .. kernel-doc:: include/linux/mm.h
    :internal:
+.. kernel-doc:: include/linux/page_ref.h
 .. kernel-doc:: include/linux/mmzone.h
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

