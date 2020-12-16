Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072C52DC656
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgLPSZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgLPSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA637C0619D8;
        Wed, 16 Dec 2020 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RdyivPfF1XxebAgMwXc1gArJ4xZBCPZRrVtSLGLS4Xo=; b=mg+B1nwVMrShfRS/0bDkxkgykr
        gLg+xgu0FmfQ1q/Hoo7TF0zVkrANfkZJwR9e3akVUJp2zLr/4ybhI/aEZOJQvpz3SsR/74dzf1XhP
        NiF4ekFXFl2MwnX4+dsGhrQfDyCMM5YEbHxTWr1z65MJ5NTuB8m3fE6xExa4wXdincQRcmLt1G2cj
        6y3SMuEUy6E/6fvRerGxUeen6+jbPMaPZ7XbxZTNjUOgun2q/Fzutz2IxIJOjyiizhptTVd2hLyAz
        wLg80SPdeLQDP31C3BMn4mLK+8AiYS4x/5tpeNA8g7zCdq1yi4rtU/TnnoDDuc1KzswKnQ/DvrNLy
        Wf/O6Crg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSj-000797-CC; Wed, 16 Dec 2020 18:23:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] mm: Add read_cache_folio and read_mapping_folio
Date:   Wed, 16 Dec 2020 18:23:34 +0000
Message-Id: <20201216182335.27227-25-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement read_cache_page() as a wrapper around read_cache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 17 ++++++++-
 mm/filemap.c            | 81 +++++++++++++++++++----------------------
 2 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 22f9774d8a83..ae20b6fa46f0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -518,19 +518,32 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 	return find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
 }
 
-extern struct page * read_cache_page(struct address_space *mapping,
-				pgoff_t index, filler_t *filler, void *data);
+struct folio *read_cache_folio(struct address_space *mapping, pgoff_t index,
+		filler_t *filler, void *data);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
 
+static inline struct page *read_cache_page(struct address_space *mapping,
+				pgoff_t index, filler_t *filler, void *data)
+{
+	struct folio *folio = read_cache_folio(mapping, index, filler, data);
+	return folio_page(folio, index);
+}
+
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
 {
 	return read_cache_page(mapping, index, NULL, data);
 }
 
+static inline struct folio *read_mapping_folio(struct address_space *mapping,
+				pgoff_t index, void *data)
+{
+	return read_cache_folio(mapping, index, NULL, data);
+}
+
 /*
  * Get index of the page with in radix-tree
  * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
diff --git a/mm/filemap.c b/mm/filemap.c
index a5925450ee13..0131208e45f7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3174,32 +3174,20 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-static struct page *wait_on_page_read(struct page *page)
-{
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			put_page(page);
-			page = ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
-static struct page *do_read_cache_page(struct address_space *mapping,
+static struct folio *do_read_cache_folio(struct address_space *mapping,
 		pgoff_t index, filler_t filler, void *data, gfp_t gfp)
 {
-	struct page *page;
+	struct folio *folio;
 	int err;
 repeat:
-	page = find_get_page(mapping, index);
-	if (!page) {
-		page = &__page_cache_alloc(gfp, 0)->page;
-		if (!page)
+	folio = find_get_folio(mapping, index);
+	if (!folio) {
+		folio = __page_cache_alloc(gfp, 0);
+		if (!folio)
 			return ERR_PTR(-ENOMEM);
-		err = add_to_page_cache_lru(page, mapping, index, gfp);
+		err = folio_add_to_page_cache(folio, mapping, index, gfp);
 		if (unlikely(err)) {
-			put_page(page);
+			put_folio(folio);
 			if (err == -EEXIST)
 				goto repeat;
 			/* Presumably ENOMEM for xarray node */
@@ -3208,21 +3196,24 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 filler:
 		if (filler)
-			err = filler(data, page_folio(page));
+			err = filler(data, folio);
 		else
-			err = mapping->a_ops->readpage(data, page_folio(page));
+			err = mapping->a_ops->readpage(data, folio);
 
 		if (err < 0) {
-			put_page(page);
+			put_folio(folio);
 			return ERR_PTR(err);
 		}
 
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
+		wait_on_folio_locked(folio);
+		if (!FolioUptodate(folio)) {
+			put_folio(folio);
+			return ERR_PTR(-EIO);
+		}
+
 		goto out;
 	}
-	if (PageUptodate(page))
+	if (FolioUptodate(folio))
 		goto out;
 
 	/*
@@ -3256,23 +3247,23 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 	 * avoid spurious serialisations and wakeups when multiple processes
 	 * wait on the same page for IO to complete.
 	 */
-	wait_on_page_locked(page);
-	if (PageUptodate(page))
+	wait_on_folio_locked(folio);
+	if (FolioUptodate(folio))
 		goto out;
 
 	/* Distinguish between all the cases under the safety of the lock */
-	lock_page(page);
+	lock_folio(folio);
 
 	/* Case c or d, restart the operation */
-	if (!page->mapping) {
-		unlock_page(page);
-		put_page(page);
+	if (!folio->page.mapping) {
+		unlock_folio(folio);
+		put_folio(folio);
 		goto repeat;
 	}
 
 	/* Someone else locked and filled the page in a very small window */
-	if (PageUptodate(page)) {
-		unlock_page(page);
+	if (FolioUptodate(folio)) {
+		unlock_folio(folio);
 		goto out;
 	}
 
@@ -3282,16 +3273,16 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 	 * Clear page error before actual read, PG_error will be
 	 * set again if read page fails.
 	 */
-	ClearPageError(page);
+	ClearFolioError(folio);
 	goto filler;
 
 out:
-	mark_page_accessed(page);
-	return page;
+	mark_folio_accessed(folio);
+	return folio;
 }
 
 /**
- * read_cache_page - read into page cache, fill it if needed
+ * read_cache_folio - read into page cache, fill it if needed
  * @mapping:	the page's address_space
  * @index:	the page index
  * @filler:	function to perform the read
@@ -3304,13 +3295,13 @@ static struct page *do_read_cache_page(struct address_space *mapping,
  *
  * Return: up to date page on success, ERR_PTR() on failure.
  */
-struct page *read_cache_page(struct address_space *mapping, pgoff_t index,
+struct folio *read_cache_folio(struct address_space *mapping, pgoff_t index,
 		filler_t filler, void *data)
 {
-	return do_read_cache_page(mapping, index, filler, data,
+	return do_read_cache_folio(mapping, index, filler, data,
 			mapping_gfp_mask(mapping));
 }
-EXPORT_SYMBOL(read_cache_page);
+EXPORT_SYMBOL(read_cache_folio);
 
 /**
  * read_cache_page_gfp - read into page cache, using specified page allocation flags.
@@ -3329,7 +3320,11 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index,
 				gfp_t gfp)
 {
-	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
+	struct folio *folio = do_read_cache_folio(mapping, index, NULL, NULL,
+									gfp);
+	if (IS_ERR(folio))
+		return &folio->page;
+	return folio_page(folio, index);
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-- 
2.29.2

