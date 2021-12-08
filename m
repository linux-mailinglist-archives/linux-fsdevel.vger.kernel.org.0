Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5946CC62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhLHE1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA2C0698CD
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GCpZGNOUxHLLTl2217lTyxFtrl9wPCCH15JN3JPxAik=; b=bK2RtpqLE9Nfi/4mSmw4BFp9S5
        9G0YigUiEge2HdJJqbBeu7vEJ99CtCEqyMRbScZRYO6b/bUklsKV94PL9kwg9HCTqyDfas+633Y8O
        vHKaJWCLvuOaxg/EvOgck8B+elIHB9xeuNR9/PW82TgtU3HgU5vF99d3qWdqh4TDxx2nk5/IZMIOJ
        BqAlfxI6gLLvJ99Oc4+Oo2gPvkUQaG/WfzhErUNbrvXFNxm/Cy0jsOjAzVv8DXn/LprAUQKNQZe63
        Vev6m+LjrswnsVDdb1tQQbcQ86dNI4XCBzslbyS1Jwln1wewnq03lMBC5b+Dwtcl2OwM/C+N38P86
        CDF4ontA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084Zt-JY; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 31/48] filemap: Add filemap_release_folio()
Date:   Wed,  8 Dec 2021 04:22:39 +0000
Message-Id: <20211208042256.1923824-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement try_to_release_page() as a wrapper around
filemap_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  1 -
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 39 +++++++++++++++++++--------------------
 mm/folio-compat.c       |  6 ++++++
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 72ca04f16711..145f045b0ddc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1970,7 +1970,6 @@ int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
 			struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
-extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
 extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7bef50ea5435..eb6e58e106c8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -939,6 +939,8 @@ static inline void __delete_from_page_cache(struct page *page, void *shadow)
 void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
+int try_to_release_page(struct page *page, gfp_t gfp);
+bool filemap_release_folio(struct folio *folio, gfp_t gfp);
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 		int whence);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 4ae9d5befffa..7a418f0012e5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3920,33 +3920,32 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 EXPORT_SYMBOL(generic_file_write_iter);
 
 /**
- * try_to_release_page() - release old fs-specific metadata on a page
+ * filemap_release_folio() - Release fs-specific metadata on a folio.
+ * @folio: The folio which the kernel is trying to free.
+ * @gfp: Memory allocation flags (and I/O mode).
  *
- * @page: the page which the kernel is trying to free
- * @gfp_mask: memory allocation flags (and I/O mode)
+ * The address_space is trying to release any data attached to a folio
+ * (presumably at folio->private).
  *
- * The address_space is to try to release any data against the page
- * (presumably at page->private).
+ * This will also be called if the private_2 flag is set on a page,
+ * indicating that the folio has other metadata associated with it.
  *
- * This may also be called if PG_fscache is set on a page, indicating that the
- * page is known to the local caching routines.
+ * The @gfp argument specifies whether I/O may be performed to release
+ * this page (__GFP_IO), and whether the call may block
+ * (__GFP_RECLAIM & __GFP_FS).
  *
- * The @gfp_mask argument specifies whether I/O may be performed to release
- * this page (__GFP_IO), and whether the call may block (__GFP_RECLAIM & __GFP_FS).
- *
- * Return: %1 if the release was successful, otherwise return zero.
+ * Return: %true if the release was successful, otherwise %false.
  */
-int try_to_release_page(struct page *page, gfp_t gfp_mask)
+bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct address_space * const mapping = page->mapping;
+	struct address_space * const mapping = folio->mapping;
 
-	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
-		return 0;
+	BUG_ON(!folio_test_locked(folio));
+	if (folio_test_writeback(folio))
+		return false;
 
 	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
-	return try_to_free_buffers(page);
+		return mapping->a_ops->releasepage(&folio->page, gfp);
+	return try_to_free_buffers(&folio->page);
 }
-
-EXPORT_SYMBOL(try_to_release_page);
+EXPORT_SYMBOL(filemap_release_folio);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 749a695b4217..749555a232a8 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -145,3 +145,9 @@ void delete_from_page_cache(struct page *page)
 {
 	return filemap_remove_folio(page_folio(page));
 }
+
+int try_to_release_page(struct page *page, gfp_t gfp)
+{
+	return filemap_release_folio(page_folio(page), gfp);
+}
+EXPORT_SYMBOL(try_to_release_page);
-- 
2.33.0

