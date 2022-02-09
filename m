Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE494AFE5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiBIUXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA4E040DE7
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oCUv2IUH5VCMbGfIH7nBvFke6NfgOrAzY5qz8pdqKfQ=; b=pkoFqUq/oyJD7zlPMSvyH9j45u
        vY29EkI89Z4XFH0SZY1XhbfIYKJoNHFOZms2ebalUMJ/om5IbkBj4jFJhv4XhGGmF8NvlOwHy7NXO
        HvgBDzMEd9tjmAxhsfUCjrLhgCgw+HrNdEtodEzDCUUueD4crGtKEpjERg4UMyJ1hTaWicbwU/oDK
        MVrxYchi0gjHqfsll6/Da6XQ+OKdPOHjX3RTxDsXZBWdllkDCPCYiy0PKZ/tVQ00xGmPqc26Gmhja
        scnnebqzNIZAryAkYH/uOE2S0wrMSMOZXmRBfIhQ5jLhrdVCWInWoRfZn4jj67n5a/heWzE0GGOHJ
        4QNzoC/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008csa-TK; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 42/56] fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()
Date:   Wed,  9 Feb 2022 20:22:01 +0000
Message-Id: <20220209202215.2055748-43-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Convert all users of fscache_set_page_dirty to use fscache_dirty_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../filesystems/caching/netfs-api.rst         |  7 +++--
 fs/9p/vfs_addr.c                              | 10 +++----
 fs/afs/file.c                                 |  2 +-
 fs/afs/internal.h                             |  4 +--
 fs/afs/write.c                                |  5 ++--
 fs/ceph/addr.c                                | 27 +++++++++---------
 fs/ceph/cache.h                               | 13 +++++----
 fs/cifs/file.c                                | 11 ++++----
 fs/fscache/io.c                               | 28 ++++++++++---------
 include/linux/fscache.h                       |  8 ++++--
 10 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index f84e9ffdf0b4..5066113acad5 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -345,8 +345,9 @@ The following facilities are provided to manage this:
 
 To support this, the following functions are provided::
 
-	int fscache_set_page_dirty(struct page *page,
-				   struct fscache_cookie *cookie);
+	bool fscache_dirty_folio(struct address_space *mapping,
+				 struct folio *folio,
+				 struct fscache_cookie *cookie);
 	void fscache_unpin_writeback(struct writeback_control *wbc,
 				     struct fscache_cookie *cookie);
 	void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
@@ -354,7 +355,7 @@ To support this, the following functions are provided::
 					   const void *aux);
 
 The *set* function is intended to be called from the filesystem's
-``set_page_dirty`` address space operation.  If ``I_PINNING_FSCACHE_WB`` is not
+``dirty_folio`` address space operation.  If ``I_PINNING_FSCACHE_WB`` is not
 set, it sets that flag and increments the use count on the cookie (the caller
 must already have called ``fscache_use_cookie()``).
 
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a4a9075890d5..76956c9d2af9 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -359,20 +359,20 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
  * Mark a page as having been made dirty and thus needing writeback.  We also
  * need to pin the cache object to write back to.
  */
-static int v9fs_set_page_dirty(struct page *page)
+static bool v9fs_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct v9fs_inode *v9inode = V9FS_I(page->mapping->host);
+	struct v9fs_inode *v9inode = V9FS_I(mapping->host);
 
-	return fscache_set_page_dirty(page, v9fs_inode_cookie(v9inode));
+	return fscache_dirty_folio(mapping, folio, v9fs_inode_cookie(v9inode));
 }
 #else
-#define v9fs_set_page_dirty __set_page_dirty_nobuffers
+#define v9fs_dirty_folio filemap_dirty_folio
 #endif
 
 const struct address_space_operations v9fs_addr_operations = {
 	.readpage = v9fs_vfs_readpage,
 	.readahead = v9fs_vfs_readahead,
-	.set_page_dirty = v9fs_set_page_dirty,
+	.dirty_folio = v9fs_dirty_folio,
 	.writepage = v9fs_vfs_writepage,
 	.write_begin = v9fs_write_begin,
 	.write_end = v9fs_write_end,
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 56b20b922751..0f9fdb284a20 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -54,7 +54,7 @@ const struct inode_operations afs_file_inode_operations = {
 const struct address_space_operations afs_file_aops = {
 	.readpage	= afs_readpage,
 	.readahead	= afs_readahead,
-	.set_page_dirty	= afs_set_page_dirty,
+	.dirty_folio	= afs_dirty_folio,
 	.launder_folio	= afs_launder_folio,
 	.releasepage	= afs_releasepage,
 	.invalidate_folio = afs_invalidate_folio,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4023d8e6ab30..dc5032e10244 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1521,9 +1521,9 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
  * write.c
  */
 #ifdef CONFIG_AFS_FSCACHE
-extern int afs_set_page_dirty(struct page *);
+bool afs_dirty_folio(struct address_space *, struct folio *);
 #else
-#define afs_set_page_dirty __set_page_dirty_nobuffers
+#define afs_dirty_folio filemap_dirty_folio
 #endif
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 5864411bd006..88861613734e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -22,9 +22,10 @@ static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len
  * Mark a page as having been made dirty and thus needing writeback.  We also
  * need to pin the cache object to write back to.
  */
-int afs_set_page_dirty(struct page *page)
+bool afs_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	return fscache_set_page_dirty(page, afs_vnode_cache(AFS_FS_I(page->mapping->host)));
+	return fscache_dirty_folio(mapping, folio,
+				afs_vnode_cache(AFS_FS_I(mapping->host)));
 }
 static void afs_folio_start_fscache(bool caching, struct folio *folio)
 {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 09fd7a02586c..f40c34f4f526 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -76,18 +76,17 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
  */
-static int ceph_set_page_dirty(struct page *page)
+static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
 
-	if (PageDirty(page)) {
-		dout("%p set_page_dirty %p idx %lu -- already dirty\n",
-		     mapping->host, page, page->index);
-		BUG_ON(!PagePrivate(page));
-		return 0;
+	if (folio_test_dirty(folio)) {
+		dout("%p dirty_folio %p idx %lu -- already dirty\n",
+		     mapping->host, folio, folio->index);
+		BUG_ON(!folio_get_private(folio));
+		return false;
 	}
 
 	inode = mapping->host;
@@ -111,22 +110,22 @@ static int ceph_set_page_dirty(struct page *page)
 	if (ci->i_wrbuffer_ref == 0)
 		ihold(inode);
 	++ci->i_wrbuffer_ref;
-	dout("%p set_page_dirty %p idx %lu head %d/%d -> %d/%d "
+	dout("%p dirty_folio %p idx %lu head %d/%d -> %d/%d "
 	     "snapc %p seq %lld (%d snaps)\n",
-	     mapping->host, page, page->index,
+	     mapping->host, folio, folio->index,
 	     ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref_head-1,
 	     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
 	     snapc, snapc->seq, snapc->num_snaps);
 	spin_unlock(&ci->i_ceph_lock);
 
 	/*
-	 * Reference snap context in page->private.  Also set
+	 * Reference snap context in folio->private.  Also set
 	 * PagePrivate so that we get invalidate_folio callback.
 	 */
-	BUG_ON(PagePrivate(page));
-	attach_page_private(page, snapc);
+	BUG_ON(folio_get_private(folio));
+	folio_attach_private(folio, snapc);
 
-	return ceph_fscache_set_page_dirty(page);
+	return ceph_fscache_dirty_folio(mapping, folio);
 }
 
 /*
@@ -1376,7 +1375,7 @@ const struct address_space_operations ceph_aops = {
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
-	.set_page_dirty = ceph_set_page_dirty,
+	.dirty_folio = ceph_dirty_folio,
 	.invalidate_folio = ceph_invalidate_folio,
 	.releasepage = ceph_releasepage,
 	.direct_IO = noop_direct_IO,
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 09164389fa66..d41bbba26b71 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -54,12 +54,12 @@ static inline void ceph_fscache_unpin_writeback(struct inode *inode,
 	fscache_unpin_writeback(wbc, ceph_fscache_cookie(ceph_inode(inode)));
 }
 
-static inline int ceph_fscache_set_page_dirty(struct page *page)
+static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_inode_info *ci = ceph_inode(mapping->host);
 
-	return fscache_set_page_dirty(page, ceph_fscache_cookie(ci));
+	return fscache_dirty_folio(mapping, folio, ceph_fscache_cookie(ci));
 }
 
 static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
@@ -133,9 +133,10 @@ static inline void ceph_fscache_unpin_writeback(struct inode *inode,
 {
 }
 
-static inline int ceph_fscache_set_page_dirty(struct page *page)
+static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	return __set_page_dirty_nobuffers(page);
+	return filemap_dirty_folio(folio);
 }
 
 static inline bool ceph_is_cache_enabled(struct inode *inode)
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3fe3c5552b39..8a2e9025bdb3 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4939,12 +4939,13 @@ static void cifs_swap_deactivate(struct file *file)
  * need to pin the cache object to write back to.
  */
 #ifdef CONFIG_CIFS_FSCACHE
-static int cifs_set_page_dirty(struct page *page)
+static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	return fscache_set_page_dirty(page, cifs_inode_cookie(page->mapping->host));
+	return fscache_dirty_folio(mapping, folio,
+					cifs_inode_cookie(mapping->host));
 }
 #else
-#define cifs_set_page_dirty __set_page_dirty_nobuffers
+#define cifs_dirty_folio filemap_dirty_folio
 #endif
 
 const struct address_space_operations cifs_addr_ops = {
@@ -4954,7 +4955,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.set_page_dirty = cifs_set_page_dirty,
+	.dirty_folio = cifs_dirty_folio,
 	.releasepage = cifs_release_page,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
@@ -4979,7 +4980,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.set_page_dirty = cifs_set_page_dirty,
+	.dirty_folio = cifs_dirty_folio,
 	.releasepage = cifs_release_page,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 7a769ea57720..c8c7fe9e9a6e 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -159,27 +159,29 @@ int __fscache_begin_write_operation(struct netfs_cache_resources *cres,
 EXPORT_SYMBOL(__fscache_begin_write_operation);
 
 /**
- * fscache_set_page_dirty - Mark page dirty and pin a cache object for writeback
- * @page: The page being dirtied
+ * fscache_dirty_folio - Mark folio dirty and pin a cache object for writeback
+ * @mapping: The mapping the folio belongs to.
+ * @folio: The folio being dirtied.
  * @cookie: The cookie referring to the cache object
  *
- * Set the dirty flag on a page and pin an in-use cache object in memory when
- * dirtying a page so that writeback can later write to it.  This is intended
- * to be called from the filesystem's ->set_page_dirty() method.
+ * Set the dirty flag on a folio and pin an in-use cache object in memory
+ * so that writeback can later write to it.  This is intended
+ * to be called from the filesystem's ->dirty_folio() method.
  *
- *  Returns 1 if PG_dirty was set on the page, 0 otherwise.
+ * Return: true if the dirty flag was set on the folio, false otherwise.
  */
-int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie)
+bool fscache_dirty_folio(struct address_space *mapping, struct folio *folio,
+				struct fscache_cookie *cookie)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = mapping->host;
 	bool need_use = false;
 
 	_enter("");
 
-	if (!__set_page_dirty_nobuffers(page))
-		return 0;
+	if (!filemap_dirty_folio(mapping, folio))
+		return false;
 	if (!fscache_cookie_valid(cookie))
-		return 1;
+		return true;
 
 	if (!(inode->i_state & I_PINNING_FSCACHE_WB)) {
 		spin_lock(&inode->i_lock);
@@ -192,9 +194,9 @@ int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie)
 		if (need_use)
 			fscache_use_cookie(cookie, true);
 	}
-	return 1;
+	return true;
 }
-EXPORT_SYMBOL(fscache_set_page_dirty);
+EXPORT_SYMBOL(fscache_dirty_folio);
 
 struct fscache_write_request {
 	struct netfs_cache_resources cache_resources;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 296c5f1d9f35..d44ff747a657 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -616,9 +616,11 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 }
 
 #if __fscache_available
-extern int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie);
+bool fscache_dirty_folio(struct address_space *mapping, struct folio *folio,
+		struct fscache_cookie *cookie);
 #else
-#define fscache_set_page_dirty(PAGE, COOKIE) (__set_page_dirty_nobuffers((PAGE)))
+#define fscache_dirty_folio(MAPPING, FOLIO, COOKIE) \
+		filemap_dirty_folio(MAPPING, FOLIO)
 #endif
 
 /**
@@ -626,7 +628,7 @@ extern int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cook
  * @wbc: The writeback control
  * @cookie: The cookie referring to the cache object
  *
- * Unpin the writeback resources pinned by fscache_set_page_dirty().  This is
+ * Unpin the writeback resources pinned by fscache_dirty_folio().  This is
  * intended to be called by the netfs's ->write_inode() method.
  */
 static inline void fscache_unpin_writeback(struct writeback_control *wbc,
-- 
2.34.1

