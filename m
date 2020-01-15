Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15013B7CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgAOCiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgAOCit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Lf3LIidmtzhLradCtIzZCa/E4yScaYQG1zFtokMxyI=; b=CSnVza/DExA3BXgOaEyUvK2/Dt
        ViA6C+SrfkrcgYYwc4eTyJzzHH8N4WaKAG30TZXiMZqRf00eU4lmJVDmpRXufq2R117ytYWDJ9hk+
        wKtwV125l/dXdaeo0fV6R+BmMaXc40cxlO2vCZQlIQEe9HAmV2iIiXaE0Z5iiotNhLF2ysCU6Avvl
        k+8f7XQGZ2bQ6QqJ6H/XEjtzWA8D92e8fsmrNjGY/bqIyJsv6YKhPc3cDRNJ1fhZZsnfcxg7Sym6a
        nDFL2pNZrLrMc9/q3/rzd9xcr6Us64RYwJi9yFWrbNGV5tYYwzi2tzZ7N7UrRm4XUOzdYUWXZk5EX
        4JcfTWzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008B3-8Z; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 8/9] mm: Remove add_to_page_cache_locked
Date:   Tue, 14 Jan 2020 18:38:42 -0800
Message-Id: <20200115023843.31325-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The only remaining caller is add_to_page_cache(), and the only
caller of that is hugetlbfs, so move add_to_page_cache() into
filemap.c and call __add_to_page_cache_locked() directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 ++------------------
 mm/filemap.c            | 23 ++++++++---------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0821f584c43c..75075065dd0b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -604,8 +604,8 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 	return 0;
 }
 
-int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
+int add_to_page_cache(struct page *page, struct address_space *mapping,
+				pgoff_t index, gfp_t gfp);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern void delete_from_page_cache(struct page *page);
@@ -614,22 +614,6 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
-/*
- * Like add_to_page_cache_locked, but used to add newly allocated pages:
- * the page is new, so we can just run __SetPageLocked() against it.
- */
-static inline int add_to_page_cache(struct page *page,
-		struct address_space *mapping, pgoff_t offset, gfp_t gfp_mask)
-{
-	int error;
-
-	__SetPageLocked(page);
-	error = add_to_page_cache_locked(page, mapping, offset, gfp_mask);
-	if (unlikely(error))
-		__ClearPageLocked(page);
-	return error;
-}
-
 /*
  * Only call this from a ->readahead implementation.
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..fb87f5fa75e6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -913,25 +913,18 @@ static int __add_to_page_cache_locked(struct page *page,
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 
-/**
- * add_to_page_cache_locked - add a locked page to the pagecache
- * @page:	page to add
- * @mapping:	the page's address_space
- * @offset:	page index
- * @gfp_mask:	page allocation mode
- *
- * This function is used to add a page to the pagecache. It must be locked.
- * This function does not add the page to the LRU.  The caller must do that.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
+int add_to_page_cache(struct page *page, struct address_space *mapping,
 		pgoff_t offset, gfp_t gfp_mask)
 {
-	return __add_to_page_cache_locked(page, mapping, offset,
+	int err;
+
+	__SetPageLocked(page);
+	err = __add_to_page_cache_locked(page, mapping, offset,
 					  gfp_mask, NULL);
+	if (unlikely(err))
+		__ClearPageLocked(page);
+	return err;
 }
-EXPORT_SYMBOL(add_to_page_cache_locked);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t offset, gfp_t gfp_mask)
-- 
2.24.1

