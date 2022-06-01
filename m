Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0353AD52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFATsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 15:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiFATsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:48:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A411AFF9
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QNvo9bDwqjOqKyKJfkpGoV4ohPgBkGeKrnqWtFP+ua4=; b=F+stxg/nAPiUl71HYMgRg2gfU5
        fgc+FsLvzL+Y7Kvl+0mYax25oSDXqwd0xWWH7x33KVel0tnw6bish4EVWptliv508fycKCuDUhWDW
        wKnN09nG+BfOePsGyjewHZLR/IG7T8kwxRf//kuu6kVG8JX+wboWZhnKsYDuFfCeq1zHBXM6s/cGT
        Uo54z+hVrw2gvv0iDwfTgyPN6KQebZDlHRh+KY0LJh82FVdxLIyh7LzfcyYAyCMIJzhr9nxjNZkPU
        YoT4/kU6Btl//NupBxH2OTBXtjVnXUOCu9AftpwP70LdVCPe4Kzsmx2FEUwddL652/rz5xVjw4YyN
        +HO3yuQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwTwM-006Y2f-C5; Wed, 01 Jun 2022 19:23:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/2] filemap: Remove add_to_page_cache() and add_to_page_cache_locked()
Date:   Wed,  1 Jun 2022 20:23:33 +0100
Message-Id: <20220601192333.1560777-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601192333.1560777-1-willy@infradead.org>
References: <20220601192333.1560777-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions have no more users, so delete them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../admin-guide/cgroup-v1/memcg_test.rst      |  2 +-
 include/linux/pagemap.h                       | 18 -----------------
 mm/filemap.c                                  | 20 -------------------
 mm/shmem.c                                    |  2 +-
 mm/swap_state.c                               |  2 +-
 5 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 45b94f7b3beb..a402359abb99 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -97,7 +97,7 @@ Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
 =============
 
 	Page Cache is charged at
-	- add_to_page_cache_locked().
+	- filemap_add_folio().
 
 	The logic is very clear. (About migration, see below)
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ce96866fbec4..5555689ea809 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1098,8 +1098,6 @@ size_t fault_in_subpage_writeable(char __user *uaddr, size_t size);
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
 size_t fault_in_readable(const char __user *uaddr, size_t size);
 
-int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-		pgoff_t index, gfp_t gfp);
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
@@ -1119,22 +1117,6 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp);
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 		int whence);
 
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
 /* Must be non-static for BPF error injection */
 int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp, void **shadowp);
diff --git a/mm/filemap.c b/mm/filemap.c
index 9daeaab36081..1e66eea98a7e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -929,26 +929,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
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
-		pgoff_t offset, gfp_t gfp_mask)
-{
-	return __filemap_add_folio(mapping, page_folio(page), offset,
-					  gfp_mask, NULL);
-}
-EXPORT_SYMBOL(add_to_page_cache_locked);
-
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..60fdfc0208fd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -693,7 +693,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * Like add_to_page_cache_locked, but error if expected item has gone.
+ * Like filemap_add_folio, but error if expected item has gone.
  */
 static int shmem_add_to_page_cache(struct folio *folio,
 				   struct address_space *mapping,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 778d57d2d92d..f5b6f5638908 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -95,7 +95,7 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
 }
 
 /*
- * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space,
+ * add_to_swap_cache resembles filemap_add_folio on swapper_space,
  * but sets SwapCache flag and private instead of mapping and index.
  */
 int add_to_swap_cache(struct page *page, swp_entry_t entry,
-- 
2.34.1

