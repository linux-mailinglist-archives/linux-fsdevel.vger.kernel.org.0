Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5513B7C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAOCir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOCiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DylBmngUm5zkbhQxU3yncnTrsHanHBApne+CYo1JZUc=; b=gjPmbmyhS3zmvAS7pVCbBARoiu
        575g/8UosIM8ZxYcU5V0YFcQDZG4gsmpRUtGZfvZLaQytJLxbdqCY+23sHa34cHoGfSN+Yb84GkCJ
        yg9aiuRvUQ2ReX8j1DvVtk+h6kwee43+htmiMdSrRNbAUqb1dXD+qb3NG8SJ16ssg2Qq26V277Y64
        BlylH2J56oQiOTs+g5c8VW9vkAd8y6Kju7P5aWxKwh/2L4MF1NxFEDRVzJ3mYKzkyoLqjoLw7QGJc
        6qX7Nh7/iMBu6FAxDUgFciX6vmT9QomJT8Bej9Dl3SycDkWhScqpuGxf8t09MQYEmJBS7eJiK94Ix
        AeIJl2nA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008B7-9Y; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 9/9] mm: Unify all add_to_page_cache variants
Date:   Tue, 14 Jan 2020 18:38:43 -0800
Message-Id: <20200115023843.31325-10-willy@infradead.org>
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

We already have various bits of add_to_page_cache() executed conditionally
on !PageHuge(page); add the add_to_page_cache_lru() pieces as some
more code which isn't executed for huge pages.  This lets us remove
the old add_to_page_cache() and rename __add_to_page_cache_locked() to
add_to_page_cache().  Include a compatibility define so we don't have
to change all 20+ callers of add_to_page_cache_lru().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  5 ++--
 mm/filemap.c            | 65 ++++++++++++-----------------------------
 2 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 75075065dd0b..637770fa283f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -606,14 +606,15 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp);
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
 extern void delete_from_page_cache(struct page *page);
 extern void __delete_from_page_cache(struct page *page, void *shadow);
 int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
+#define add_to_page_cache_lru(page, mapping, index, gfp) \
+	add_to_page_cache(page, mapping, index, gfp)
+
 /*
  * Only call this from a ->readahead implementation.
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index fb87f5fa75e6..83f45f31a00a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -847,19 +847,18 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-static int __add_to_page_cache_locked(struct page *page,
-				      struct address_space *mapping,
-				      pgoff_t offset, gfp_t gfp_mask,
-				      void **shadowp)
+int add_to_page_cache(struct page *page, struct address_space *mapping,
+		pgoff_t offset, gfp_t gfp_mask)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
 	struct mem_cgroup *memcg;
 	int error;
-	void *old;
+	void *old, *shadow = NULL;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
+	__SetPageLocked(page);
 	mapping_set_update(&xas, mapping);
 
 	if (!huge) {
@@ -884,8 +883,7 @@ static int __add_to_page_cache_locked(struct page *page,
 
 		if (xa_is_value(old)) {
 			mapping->nrexceptional--;
-			if (shadowp)
-				*shadowp = old;
+			shadow = old;
 		}
 		mapping->nrpages++;
 
@@ -899,45 +897,8 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (xas_error(&xas))
 		goto error;
 
-	if (!huge)
+	if (!huge) {
 		mem_cgroup_commit_charge(page, memcg, false, false);
-	trace_mm_filemap_add_to_page_cache(page);
-	return 0;
-error:
-	page->mapping = NULL;
-	/* Leave page->index set: truncation relies upon it */
-	if (!huge)
-		mem_cgroup_cancel_charge(page, memcg, false);
-	put_page(page);
-	return xas_error(&xas);
-}
-ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
-
-int add_to_page_cache(struct page *page, struct address_space *mapping,
-		pgoff_t offset, gfp_t gfp_mask)
-{
-	int err;
-
-	__SetPageLocked(page);
-	err = __add_to_page_cache_locked(page, mapping, offset,
-					  gfp_mask, NULL);
-	if (unlikely(err))
-		__ClearPageLocked(page);
-	return err;
-}
-
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
-{
-	void *shadow = NULL;
-	int ret;
-
-	__SetPageLocked(page);
-	ret = __add_to_page_cache_locked(page, mapping, offset,
-					 gfp_mask, &shadow);
-	if (unlikely(ret))
-		__ClearPageLocked(page);
-	else {
 		/*
 		 * The page might have been evicted from cache only
 		 * recently, in which case it should be activated like
@@ -951,9 +912,19 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 			workingset_refault(page, shadow);
 		lru_cache_add(page);
 	}
-	return ret;
+	trace_mm_filemap_add_to_page_cache(page);
+	return 0;
+error:
+	page->mapping = NULL;
+	/* Leave page->index set: truncation relies upon it */
+	if (!huge)
+		mem_cgroup_cancel_charge(page, memcg, false);
+	put_page(page);
+	__ClearPageLocked(page);
+	return xas_error(&xas);
 }
-EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
+ALLOW_ERROR_INJECTION(add_to_page_cache, ERRNO);
+EXPORT_SYMBOL_GPL(add_to_page_cache);
 
 #ifdef CONFIG_NUMA
 struct page *__page_cache_alloc(gfp_t gfp)
-- 
2.24.1

