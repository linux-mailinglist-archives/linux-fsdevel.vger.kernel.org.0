Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654A42DC641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgLPSZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252DC061248;
        Wed, 16 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RO/BuKa7UlTykAgrNcwGk1HeYTiXH3dtFW90nMZoh8o=; b=VRP6TyoyCleiTSotfMCR/lnRV3
        06+f756XjVFFDC+VzfRfKkdx7BqU207EOf2VCd8ZL0Eq2Puq18LiMrsaqTYeisdcYEJjRBSPv3HB6
        H0p75ynmpXFvVp005wmiPdz7ppv8rISiTO3p8gYawrljpyZWaIo1WwGAFZ15QG83FbE9/m0TZLUR/
        PCTc4a8Y0BIIWfeB1fOcgro23h25YsnBz6pu0+CxsVubnnXujsXI2ejBhZNOGcDDUMieyhaH/3Vvq
        CUoQxj78uSvRxnbUChziLT2AodP/ikaDKdUodIRCjM146pinZ0VDEBIOlbDfxam9PTtBfRtjEp7Ov
        UBKBvsJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSd-00076n-Dp; Wed, 16 Dec 2020 18:23:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] mm: Convert __page_cache_alloc to return a folio
Date:   Wed, 16 Dec 2020 18:23:19 +0000
Message-Id: <20201216182335.27227-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the users turn it back into a struct page pointer, but
some can make use of it as a folio immediately.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/dir.c            |  2 +-
 fs/btrfs/compression.c  |  4 ++--
 fs/cachefiles/rdwr.c    |  6 ++++--
 fs/ceph/addr.c          |  2 +-
 fs/ceph/file.c          |  2 +-
 include/linux/pagemap.h |  8 ++++----
 mm/filemap.c            | 16 ++++++++--------
 mm/readahead.c          |  2 +-
 net/ceph/pagelist.c     |  4 ++--
 net/ceph/pagevec.c      |  2 +-
 10 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9068d5578a26..52e9da468787 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -272,7 +272,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 				afs_stat_v(dvnode, n_inval);
 
 			ret = -ENOMEM;
-			req->pages[i] = __page_cache_alloc(gfp);
+			req->pages[i] = &__page_cache_alloc(gfp, 0)->page;
 			if (!req->pages[i])
 				goto error;
 			ret = add_to_page_cache_lru(req->pages[i],
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5ae3fa0386b7..3309a973b678 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -532,8 +532,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			goto next;
 		}
 
-		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
-								 ~__GFP_FS));
+		page = &__page_cache_alloc(mapping_gfp_constraint(mapping,
+						 ~__GFP_FS), 0)->page;
 		if (!page)
 			break;
 
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8bda092e60c5..268fbcac4afb 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -260,7 +260,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 			goto backing_page_already_present;
 
 		if (!newpage) {
-			newpage = __page_cache_alloc(cachefiles_gfp);
+			newpage = &__page_cache_alloc(cachefiles_gfp, 0)->page;
 			if (!newpage)
 				goto nomem_monitor;
 		}
@@ -497,7 +497,9 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 				goto backing_page_already_present;
 
 			if (!newpage) {
-				newpage = __page_cache_alloc(cachefiles_gfp);
+				struct folio *folio;
+				folio = __page_cache_alloc(cachefiles_gfp, 0);
+				newpage = &folio->page;
 				if (!newpage)
 					goto nomem;
 			}
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 950552944436..5b2873b12904 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1760,7 +1760,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		if (len > PAGE_SIZE)
 			len = PAGE_SIZE;
 	} else {
-		page = __page_cache_alloc(GFP_NOFS);
+		page = &__page_cache_alloc(GFP_NOFS, 0)->page;
 		if (!page) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 209535d5b8d3..f8e1482ea7c1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1587,7 +1587,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		struct page *page = NULL;
 		loff_t i_size;
 		if (retry_op == READ_INLINE) {
-			page = __page_cache_alloc(GFP_KERNEL);
+			page = &__page_cache_alloc(GFP_KERNEL, 0)->page;
 			if (!page)
 				return -ENOMEM;
 		}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5acebbb75d41..317f17e98412 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -282,17 +282,17 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-extern struct page *__page_cache_alloc(gfp_t gfp);
+extern struct folio *__page_cache_alloc(gfp_t gfp, unsigned int order);
 #else
-static inline struct page *__page_cache_alloc(gfp_t gfp)
+static inline struct folio *__page_cache_alloc(gfp_t gfp, unsigned int order)
 {
-	return alloc_pages(gfp, 0);
+	return alloc_folio(gfp, order);
 }
 #endif
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return __page_cache_alloc(mapping_gfp_mask(x));
+	return &__page_cache_alloc(mapping_gfp_mask(x), 0)->page;
 }
 
 static inline gfp_t readahead_gfp_mask(struct address_space *x)
diff --git a/mm/filemap.c b/mm/filemap.c
index dd26b50e3676..6012e8a7bd6c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -960,22 +960,22 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
 #ifdef CONFIG_NUMA
-struct page *__page_cache_alloc(gfp_t gfp)
+struct folio *__page_cache_alloc(gfp_t gfp, unsigned int order)
 {
 	int n;
-	struct page *page;
+	struct folio *folio;
 
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			page = __alloc_pages_node(n, gfp, 0);
-		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
+			folio = __alloc_folio_node(n, gfp, order);
+		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
-		return page;
+		return folio;
 	}
-	return alloc_pages(gfp, 0);
+	return alloc_folio(gfp, order);
 }
 EXPORT_SYMBOL(__page_cache_alloc);
 #endif
@@ -1801,7 +1801,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		if (fgp_flags & FGP_NOFS)
 			gfp_mask &= ~__GFP_FS;
 
-		page = __page_cache_alloc(gfp_mask);
+		page = &__page_cache_alloc(gfp_mask, 0)->page;
 		if (!page)
 			return NULL;
 
@@ -3192,7 +3192,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 repeat:
 	page = find_get_page(mapping, index);
 	if (!page) {
-		page = __page_cache_alloc(gfp);
+		page = &__page_cache_alloc(gfp, 0)->page;
 		if (!page)
 			return ERR_PTR(-ENOMEM);
 		err = add_to_page_cache_lru(page, mapping, index, gfp);
diff --git a/mm/readahead.c b/mm/readahead.c
index c5b0457415be..d7a5424e3d0d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -213,7 +213,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		page = __page_cache_alloc(gfp_mask);
+		page = &__page_cache_alloc(gfp_mask, 0)->page;
 		if (!page)
 			break;
 		if (mapping->a_ops->readpages) {
diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
index 65e34f78b05d..bde78f5eea33 100644
--- a/net/ceph/pagelist.c
+++ b/net/ceph/pagelist.c
@@ -56,7 +56,7 @@ static int ceph_pagelist_addpage(struct ceph_pagelist *pl)
 	struct page *page;
 
 	if (!pl->num_pages_free) {
-		page = __page_cache_alloc(GFP_NOFS);
+		page = &__page_cache_alloc(GFP_NOFS, 0)->page;
 	} else {
 		page = list_first_entry(&pl->free_list, struct page, lru);
 		list_del(&page->lru);
@@ -107,7 +107,7 @@ int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space)
 	space = (space + PAGE_SIZE - 1) >> PAGE_SHIFT;   /* conv to num pages */
 
 	while (space > pl->num_pages_free) {
-		struct page *page = __page_cache_alloc(GFP_NOFS);
+		struct page *page = &__page_cache_alloc(GFP_NOFS, 0)->page;
 		if (!page)
 			return -ENOMEM;
 		list_add_tail(&page->lru, &pl->free_list);
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 64305e7056a1..8e5f70b8fa10 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -45,7 +45,7 @@ struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags)
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 	for (i = 0; i < num_pages; i++) {
-		pages[i] = __page_cache_alloc(flags);
+		pages[i] = &__page_cache_alloc(flags, 0)->page;
 		if (pages[i] == NULL) {
 			ceph_release_page_vector(pages, i);
 			return ERR_PTR(-ENOMEM);
-- 
2.29.2

