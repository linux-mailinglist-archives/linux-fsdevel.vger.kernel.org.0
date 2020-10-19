Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758EF292DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgJSS7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSS7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:59:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09382C0613CE;
        Mon, 19 Oct 2020 11:59:21 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so971625iow.6;
        Mon, 19 Oct 2020 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQFUXiA3CVc168Ax+F3zE3K0hjfpsoCD8RSBN8GOM0Q=;
        b=hQ6vOzRmW6IPAOwAcv/uAbA7blzdDR4KOZNDRoktVCexd0J63zWwEaduMgN0B+wxR8
         YU02OJ8giVloxMK89QZQH0tXdzng9JQnozRuq107BW2boWX3eQ0IbDV/pvlnwNkdtnSF
         /j+bIyfT/OntmfdxODSWJzngUdwl0A1zgTd4J9w4HrRCQTDk5f69u7TtJrpRL7p2xRMB
         UG9vU3FOnKwDyus+0EBtrhAOEWVQPPv8CUlefJ8t8afjiCSqDNaJjZbj95ZW3U/NDuAO
         a/DuIlCJ+CRpGKzYnzbsgQymzm2gh56sZJv2TjKhgxrycdJjkLiGuI9bPvhZoqbELinT
         AqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQFUXiA3CVc168Ax+F3zE3K0hjfpsoCD8RSBN8GOM0Q=;
        b=bveqkjdOTklhIH9zMVlO7Z949+a0YrvXTgc5P8uQu6XTrUW3tspqZclON1F5RQEdY+
         9DW21VLkCc1mthSw3owLtulq5x6s4ORCkmJ9T175wgC6Y0oggC+2Pt9FQdDchYk2H0ZJ
         1nZaj6KYohWpCKNUPRNBiNReQ06jjlCo2TLeOyumwb/dKLIvxUthz6RqFPLwKnEbdlOf
         mfXlV10kxWKBBSBjDkT5Mn0FY+fYg34jzqLtFbUxAztazkfz1ueG0/hP/PX9CAmXP58n
         4tBjWlN/DRETxw1FIkTxKvidVBL40flaHh4z+QAbWeEdrCfjwxKiP5L//DL+VLEXEtYD
         +PxQ==
X-Gm-Message-State: AOAM532DdlpL9krxnO0bnxRBJNj5JsPOoFLX9K7DZC9h4N8cGAiHu8Kp
        LAKl6YSfYjz37nkCmxyAhz+Rg9x4BQ==
X-Google-Smtp-Source: ABdhPJy0CNgeIv1MTTtEls/84tAIiZtbJw+IzM6wUa+0oOtaiWVNqFXN3JKed0L00xvWJnKUl9eWyQ==
X-Received: by 2002:a05:6602:2dce:: with SMTP id l14mr732539iow.198.1603133960261;
        Mon, 19 Oct 2020 11:59:20 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id t12sm538770ilh.18.2020.10.19.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:59:19 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/2] fs: kill add_to_page_cache_locked()
Date:   Mon, 19 Oct 2020 14:59:11 -0400
Message-Id: <20201019185911.2909471-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019185911.2909471-1-kent.overstreet@gmail.com>
References: <20201019185911.2909471-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No longer has any users, so remove it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/pagemap.h | 20 ++-----------
 mm/filemap.c            | 62 ++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 50 deletions(-)

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
index 82e5e0ba24..c562ad7e05 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -827,10 +827,10 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
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
@@ -841,6 +841,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
+	__SetPageLocked(page);
 	get_page(page);
 	page->mapping = mapping;
 	page->index = offset;
@@ -885,29 +886,30 @@ static int __add_to_page_cache_locked(struct page *page,
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
 	put_page(page);
+	__ClearPageLocked(page);
 	return error;
 }
-ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 
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

