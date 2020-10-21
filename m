Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3D295330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441925AbgJUT56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440864AbgJUT5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:57:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64233C0613CE;
        Wed, 21 Oct 2020 12:57:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 140so3845829qko.2;
        Wed, 21 Oct 2020 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X6R3ybokdzO+BCIMBL1y55i8bHqH/2YQFnGxfZKL34=;
        b=CkoiRsI++rCjDYiIJl1olJeNut8FIz3NyvOYiad2KSCOXAu6uA5Q61/QDfMP/g8z8x
         BK9kuPR13g1uCs3yl805Tcgd1jLWXUOLOYPGHB85ARxomUQ2a4NZ5eJJtQip753wGxNA
         JnpWR96fF9cwUZ5HFBNUYL4EtSYx5pZ0/TIrQE/gw7jdKptDimpq9WCuoe2X8I28staA
         q44ju2RuDCFYlKZ2suWRyXWHekSLbQQgTCGSsYm7y3AkS6bmZZ5/6zzYEwk4mO9rTOEh
         WdM2rOMoTsIYzobiHKjuqH7EUMA5D3nQa0pZZd/CbANO+pf7CElYJpx25vHKA6qhNr1g
         9S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X6R3ybokdzO+BCIMBL1y55i8bHqH/2YQFnGxfZKL34=;
        b=dUuJAfaMSoLa6iY09b/gro+37nb+c/Ht6ISeMy7Egg3h6ygFW14uT/OgZgwPSonr8l
         zSoYEBVTXLqESmMJ/q9DKhRp3pF7wM3VZmmszyZmGPT2RdK8p8Z0KDSmPT6Yu9hbXgPT
         hrTZVMrUXDirjI4qu1cCAp6x72ox8GA8aJ3+dxQkpqXoF+I6o6dDGIsT5sBP7yE5VEr/
         1nR3fbLJ/It0iTY7GhEz+stz9QWh7ooAQaCkknpH9l/9JRCeu0PTiYa+nQd81ieFBScL
         bxxvLbtqxqpcnn9tISHqjcWx2Iti1jAjwYKNozGtAmx20QxGoF0Z+nuGC1OsVaefbg7r
         IY/A==
X-Gm-Message-State: AOAM532y8j5BQEzhuVjNyzTHg4QSJ92VteRv+Suz+SGIQjur1M+ClpxH
        LT/3MfeWi6h9YbV+K68GJ1tUztFITqsT
X-Google-Smtp-Source: ABdhPJy9dCBI2rw+hBFQAaFW9kDo4HWDgwt6wH4ypoi8GnwbwTttktrgHSgUxKNgjupNK+A/xT7a5Q==
X-Received: by 2002:a37:9acb:: with SMTP id c194mr4872762qke.288.1603310274303;
        Wed, 21 Oct 2020 12:57:54 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id 124sm1867603qkn.47.2020.10.21.12.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:57:53 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 2/2] fs: kill add_to_page_cache_locked()
Date:   Wed, 21 Oct 2020 15:57:45 -0400
Message-Id: <20201021195745.3420101-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021195745.3420101-1-kent.overstreet@gmail.com>
References: <20201021195745.3420101-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No longer has any users, so remove it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/pagemap.h | 20 ++-----------
 mm/filemap.c            | 64 ++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 51 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 434c9c34ae..aceaebfaab 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -689,8 +689,8 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 	return 0;
 }
 
-int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
+int add_to_page_cache(struct page *page, struct address_space *mapping,
+		      pgoff_t index, gfp_t gfp_mask);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern void delete_from_page_cache(struct page *page);
@@ -710,22 +710,6 @@ void page_cache_readahead_unbounded(struct address_space *, struct file *,
 		pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_count);
 
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
 /**
  * struct readahead_control - Describes a readahead request.
  *
diff --git a/mm/filemap.c b/mm/filemap.c
index bb71334fdd..b92ca48b90 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -827,20 +827,20 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-static int __add_to_page_cache_locked(struct page *page,
-				      struct address_space *mapping,
-				      pgoff_t offset, gfp_t gfp_mask,
-				      void **shadowp)
+static int __add_to_page_cache(struct page *page,
+			       struct address_space *mapping,
+			       pgoff_t offset, gfp_t gfp_mask,
+			       void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
 	int error;
 	void *old;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
+	__SetPageLocked(page);
 	get_page(page);
 	page->mapping = mapping;
 	page->index = offset;
@@ -885,29 +885,31 @@ static int __add_to_page_cache_locked(struct page *page,
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	put_page(page);
+	__ClearPageLocked(page);
 	return error;
 }
-ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
+ALLOW_ERROR_INJECTION(__add_to_page_cache, ERRNO);
 
 /**
- * add_to_page_cache_locked - add a locked page to the pagecache
+ * add_to_page_cache - add a newly allocated page to the pagecache
  * @page:	page to add
  * @mapping:	the page's address_space
  * @offset:	page index
  * @gfp_mask:	page allocation mode
  *
- * This function is used to add a page to the pagecache. It must be locked.
- * This function does not add the page to the LRU.  The caller must do that.
+ * This function is used to add a page to the pagecache. It must be newly
+ * allocated.  This function does not add the page to the LRU.  The caller must
+ * do that.
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-		pgoff_t offset, gfp_t gfp_mask)
+int add_to_page_cache(struct page *page, struct address_space *mapping,
+		      pgoff_t offset, gfp_t gfp_mask)
 {
-	return __add_to_page_cache_locked(page, mapping, offset,
-					  gfp_mask, NULL);
+	return __add_to_page_cache(page, mapping, offset, gfp_mask, NULL);
 }
-EXPORT_SYMBOL(add_to_page_cache_locked);
+EXPORT_SYMBOL(add_to_page_cache);
+ALLOW_ERROR_INJECTION(add_to_page_cache, ERRNO);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t offset, gfp_t gfp_mask)
@@ -915,26 +917,22 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 	void *shadow = NULL;
 	int ret;
 
-	__SetPageLocked(page);
-	ret = __add_to_page_cache_locked(page, mapping, offset,
-					 gfp_mask, &shadow);
+	ret = __add_to_page_cache(page, mapping, offset, gfp_mask, &shadow);
 	if (unlikely(ret))
-		__ClearPageLocked(page);
-	else {
-		/*
-		 * The page might have been evicted from cache only
-		 * recently, in which case it should be activated like
-		 * any other repeatedly accessed page.
-		 * The exception is pages getting rewritten; evicting other
-		 * data from the working set, only to cache data that will
-		 * get overwritten with something else, is a waste of memory.
-		 */
-		WARN_ON_ONCE(PageActive(page));
-		if (!(gfp_mask & __GFP_WRITE) && shadow)
-			workingset_refault(page, shadow);
-		lru_cache_add(page);
-	}
-	return ret;
+		return ret;
+
+	/*
+	 * The page might have been evicted from cache only recently, in which
+	 * case it should be activated like any other repeatedly accessed page.
+	 * The exception is pages getting rewritten; evicting other data from
+	 * the working set, only to cache data that will get overwritten with
+	 * something else, is a waste of memory.
+	 */
+	WARN_ON_ONCE(PageActive(page));
+	if (!(gfp_mask & __GFP_WRITE) && shadow)
+		workingset_refault(page, shadow);
+	lru_cache_add(page);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
-- 
2.28.0

