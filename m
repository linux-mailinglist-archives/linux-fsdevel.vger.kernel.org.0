Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1A300A78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbhAVR4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbhAVRwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 975CE23A9A;
        Fri, 22 Jan 2021 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337882;
        bh=7c4C0NGnd1ycQrjwFvqo5QhpKG7ptm/awGcqztQqlCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3g9D5009TZiRfDlatB0eveoJ6x9PmEdzUnDdXYCrJ/gW6qkpsXdGCWTgmhfNFOuQ
         yzugITHigonLygkrGIn4HWtDHO9X9jcbBfmI5hUZ9qGNEBweh76aP/V6bCk5R94Mgp
         p3lfanhMdiNFT8Lgrh/YSA40M99dN4KbQxrxC98zA/eKs8TF/+wKA/8QPNC5mdNi1L
         2HDXBUcmiE0bax87LxHJpTqEUMgmLY6BRsYSMBTuSUf0o+esBKVZ3cQVKWDIYZst8J
         JuOeijk/3oXRoGDdnJcE+RsImRQhcgwYTjGGAHA0wpdPzht+fpACGz4GD/Gaj2EWCl
         EqEc3HSCMaS8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/6] ceph: disable old fscache readpage handling
Date:   Fri, 22 Jan 2021 12:51:13 -0500
Message-Id: <20210122175119.364381-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122175119.364381-1-jlayton@kernel.org>
References: <20210122175119.364381-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the new netfs read helper functions, we won't need a lot of this
infrastructure as it handles a the pagecache itself. Rip out the read
handling for now, and much of the old infrastructure that deals in
individual pages.

The cookie handling is mostly unchanged, however.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c  |  31 +-----------
 fs/ceph/cache.c | 123 ------------------------------------------------
 fs/ceph/cache.h |  91 +----------------------------------
 fs/ceph/caps.c  |   9 ----
 4 files changed, 3 insertions(+), 251 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 26e66436f005..e267aa60c8b6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -155,8 +155,6 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 		return;
 	}
 
-	ceph_invalidate_fscache_page(inode, page);
-
 	WARN_ON(!PageLocked(page));
 	if (!PagePrivate(page))
 		return;
@@ -175,10 +173,6 @@ static int ceph_releasepage(struct page *page, gfp_t g)
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
 
-	/* Can we release the page from the cache? */
-	if (!ceph_release_fscache_page(page, g))
-		return 0;
-
 	return !PagePrivate(page);
 }
 
@@ -213,10 +207,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 		return 0;
 	}
 
-	err = ceph_readpage_from_fscache(inode, page);
-	if (err == 0)
-		return -EINPROGRESS;
-
 	dout("readpage ino %llx.%llx file %p off %llu len %llu page %p index %lu\n",
 	     vino.ino, vino.snap, filp, off, len, page, page->index);
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len, 0, 1,
@@ -241,7 +231,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 	if (err == -ENOENT)
 		err = 0;
 	if (err < 0) {
-		ceph_fscache_readpage_cancel(inode, page);
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
 		goto out;
@@ -253,8 +242,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 		flush_dcache_page(page);
 
 	SetPageUptodate(page);
-	ceph_readpage_to_fscache(inode, page);
-
 out:
 	return err < 0 ? err : 0;
 }
@@ -294,10 +281,8 @@ static void finish_read(struct ceph_osd_request *req)
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = osd_data->pages[i];
 
-		if (rc < 0 && rc != -ENOENT) {
-			ceph_fscache_readpage_cancel(inode, page);
+		if (rc < 0 && rc != -ENOENT)
 			goto unlock;
-		}
 		if (bytes < (int)PAGE_SIZE) {
 			/* zero (remainder of) page */
 			int s = bytes < 0 ? 0 : bytes;
@@ -307,7 +292,6 @@ static void finish_read(struct ceph_osd_request *req)
 		     page->index);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
-		ceph_readpage_to_fscache(inode, page);
 unlock:
 		unlock_page(page);
 		put_page(page);
@@ -408,7 +392,6 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 		     page->index);
 		if (add_to_page_cache_lru(page, &inode->i_data, page->index,
 					  GFP_KERNEL)) {
-			ceph_fscache_uncache_page(inode, page);
 			put_page(page);
 			dout("start_read %p add_to_page_cache failed %p\n",
 			     inode, page);
@@ -440,10 +423,8 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 	return nr_pages;
 
 out_pages:
-	for (i = 0; i < nr_pages; ++i) {
-		ceph_fscache_readpage_cancel(inode, pages[i]);
+	for (i = 0; i < nr_pages; ++i)
 		unlock_page(pages[i]);
-	}
 	ceph_put_page_vector(pages, nr_pages, false);
 out_put:
 	ceph_osdc_put_request(req);
@@ -471,12 +452,6 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
 		return -EINVAL;
 
-	rc = ceph_readpages_from_fscache(mapping->host, mapping, page_list,
-					 &nr_pages);
-
-	if (rc == 0)
-		goto out;
-
 	rw_ctx = ceph_find_rw_context(fi);
 	max = fsc->mount_options->rsize >> PAGE_SHIFT;
 	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
@@ -487,8 +462,6 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 			goto out;
 	}
 out:
-	ceph_fscache_readpages_cancel(inode, page_list);
-
 	dout("readpages %p file %p ret %d\n", inode, file, rc);
 	return rc;
 }
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 2f5cb6bc78e1..bd185faeeb8e 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -205,108 +205,6 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
 	}
 }
 
-static void ceph_readpage_from_fscache_complete(struct page *page, void *data, int error)
-{
-	if (!error)
-		SetPageUptodate(page);
-
-	unlock_page(page);
-}
-
-static inline bool cache_valid(struct ceph_inode_info *ci)
-{
-	return ci->i_fscache_gen == ci->i_rdcache_gen;
-}
-
-
-/* Atempt to read from the fscache,
- *
- * This function is called from the readpage_nounlock context. DO NOT attempt to
- * unlock the page here (or in the callback).
- */
-int ceph_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	int ret;
-
-	if (!cache_valid(ci))
-		return -ENOBUFS;
-
-	ret = fscache_read_or_alloc_page(ci->fscache, page,
-					 ceph_readpage_from_fscache_complete, NULL,
-					 GFP_KERNEL);
-
-	switch (ret) {
-		case 0: /* Page found */
-			dout("page read submitted\n");
-			return 0;
-		case -ENOBUFS: /* Pages were not found, and can't be */
-		case -ENODATA: /* Pages were not found */
-			dout("page/inode not in cache\n");
-			return ret;
-		default:
-			dout("%s: unknown error ret = %i\n", __func__, ret);
-			return ret;
-	}
-}
-
-int ceph_readpages_from_fscache(struct inode *inode,
-				  struct address_space *mapping,
-				  struct list_head *pages,
-				  unsigned *nr_pages)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	int ret;
-
-	if (!cache_valid(ci))
-		return -ENOBUFS;
-
-	ret = fscache_read_or_alloc_pages(ci->fscache, mapping, pages, nr_pages,
-					  ceph_readpage_from_fscache_complete,
-					  NULL, mapping_gfp_mask(mapping));
-
-	switch (ret) {
-		case 0: /* All pages found */
-			dout("all-page read submitted\n");
-			return 0;
-		case -ENOBUFS: /* Some pages were not found, and can't be */
-		case -ENODATA: /* some pages were not found */
-			dout("page/inode not in cache\n");
-			return ret;
-		default:
-			dout("%s: unknown error ret = %i\n", __func__, ret);
-			return ret;
-	}
-}
-
-void ceph_readpage_to_fscache(struct inode *inode, struct page *page)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	int ret;
-
-	if (!PageFsCache(page))
-		return;
-
-	if (!cache_valid(ci))
-		return;
-
-	ret = fscache_write_page(ci->fscache, page, i_size_read(inode),
-				 GFP_KERNEL);
-	if (ret)
-		 fscache_uncache_page(ci->fscache, page);
-}
-
-void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-
-	if (!PageFsCache(page))
-		return;
-
-	fscache_wait_on_page_write(ci->fscache, page);
-	fscache_uncache_page(ci->fscache, page);
-}
-
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
 {
 	if (fscache_cookie_valid(fsc->fscache)) {
@@ -329,24 +227,3 @@ void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
 	}
 	fsc->fscache = NULL;
 }
-
-/*
- * caller should hold CEPH_CAP_FILE_{RD,CACHE}
- */
-void ceph_fscache_revalidate_cookie(struct ceph_inode_info *ci)
-{
-	if (cache_valid(ci))
-		return;
-
-	/* resue i_truncate_mutex. There should be no pending
-	 * truncate while the caller holds CEPH_CAP_FILE_RD */
-	mutex_lock(&ci->i_truncate_mutex);
-	if (!cache_valid(ci)) {
-		if (fscache_check_consistency(ci->fscache, &ci->i_vino))
-			fscache_invalidate(ci->fscache);
-		spin_lock(&ci->i_ceph_lock);
-		ci->i_fscache_gen = ci->i_rdcache_gen;
-		spin_unlock(&ci->i_ceph_lock);
-	}
-	mutex_unlock(&ci->i_truncate_mutex);
-}
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 89dbdd1eb14a..10c21317b62f 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -29,13 +29,10 @@ int ceph_readpages_from_fscache(struct inode *inode,
 				struct address_space *mapping,
 				struct list_head *pages,
 				unsigned *nr_pages);
-void ceph_readpage_to_fscache(struct inode *inode, struct page *page);
-void ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
 
 static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
 {
 	ci->fscache = NULL;
-	ci->i_fscache_gen = 0;
 }
 
 static inline void ceph_fscache_invalidate(struct inode *inode)
@@ -43,40 +40,6 @@ static inline void ceph_fscache_invalidate(struct inode *inode)
 	fscache_invalidate(ceph_inode(inode)->fscache);
 }
 
-static inline void ceph_fscache_uncache_page(struct inode *inode,
-					     struct page *page)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	return fscache_uncache_page(ci->fscache, page);
-}
-
-static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
-{
-	struct inode* inode = page->mapping->host;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	return fscache_maybe_release_page(ci->fscache, page, gfp);
-}
-
-static inline void ceph_fscache_readpage_cancel(struct inode *inode,
-						struct page *page)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	if (fscache_cookie_valid(ci->fscache) && PageFsCache(page))
-		__fscache_uncache_page(ci->fscache, page);
-}
-
-static inline void ceph_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	return fscache_readpages_cancel(ci->fscache, pages);
-}
-
-static inline void ceph_disable_fscache_readpage(struct ceph_inode_info *ci)
-{
-	ci->i_fscache_gen = ci->i_rdcache_gen - 1;
-}
-
 #else
 
 static inline int ceph_fscache_register(void)
@@ -115,62 +78,10 @@ static inline void ceph_fscache_file_set_cookie(struct inode *inode,
 {
 }
 
-static inline void ceph_fscache_revalidate_cookie(struct ceph_inode_info *ci)
-{
-}
-
-static inline void ceph_fscache_uncache_page(struct inode *inode,
-					     struct page *pages)
-{
-}
-
-static inline int ceph_readpage_from_fscache(struct inode* inode,
-					     struct page *page)
-{
-	return -ENOBUFS;
-}
-
-static inline int ceph_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return -ENOBUFS;
-}
-
-static inline void ceph_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-}
-
 static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 }
 
-static inline void ceph_invalidate_fscache_page(struct inode *inode,
-						struct page *page)
-{
-}
-
-static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
-{
-	return 1;
-}
-
-static inline void ceph_fscache_readpage_cancel(struct inode *inode,
-						struct page *page)
-{
-}
-
-static inline void ceph_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
-{
-}
-
-static inline void ceph_disable_fscache_readpage(struct ceph_inode_info *ci)
-{
-}
-
 #endif
 
-#endif
+#endif /* _CEPH_CACHE_H */
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index abbf48fc6230..21ba949ca2c3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2730,10 +2730,6 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 				*got = need | want;
 			else
 				*got = need;
-			if (S_ISREG(inode->i_mode) &&
-			    (need & CEPH_CAP_FILE_RD) &&
-			    !(*got & CEPH_CAP_FILE_CACHE))
-				ceph_disable_fscache_readpage(ci);
 			ceph_take_cap_refs(ci, *got, true);
 			ret = 1;
 		}
@@ -2983,11 +2979,6 @@ int ceph_get_caps(struct file *filp, int need, int want,
 		}
 		break;
 	}
-
-	if (S_ISREG(ci->vfs_inode.i_mode) &&
-	    (_got & CEPH_CAP_FILE_RD) && (_got & CEPH_CAP_FILE_CACHE))
-		ceph_fscache_revalidate_cookie(ci);
-
 	*got = _got;
 	return 0;
 }
-- 
2.29.2

