Return-Path: <linux-fsdevel+bounces-6708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4281B7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4DE284307
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F837C675;
	Thu, 21 Dec 2023 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhngKLVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156467BF1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jT9hgLAowhp9EHvcWHW3pUvxomUXoaX+JM3H5DG5ux4=;
	b=JhngKLVGmicTwJY45qFQcOjC7W2s1h/lg5fitY+TDnE0PPvdx7gkz3mP0YdnnTp4jfQ69S
	9rNlGPir/i0oiR7+pPLkg0eAJKu6WfLgMZecwy6LL/nQkcrAC/8BN6FgtJUZuoEfRlz6/b
	MMozrbOqY0D8lzXOeKCcZbmRlOKx10c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-gPb8hKj2MmuordQYwQ69LQ-1; Thu, 21 Dec 2023 08:24:53 -0500
X-MC-Unique: gPb8hKj2MmuordQYwQ69LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF02A88CDCE;
	Thu, 21 Dec 2023 13:24:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBC5AC15968;
	Thu, 21 Dec 2023 13:24:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/40] netfs: Provide invalidate_folio and release_folio calls
Date: Thu, 21 Dec 2023 13:23:07 +0000
Message-ID: <20231221132400.1601991-13-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Provide default invalidate_folio and release_folio calls.  These will need
to interact with invalidation correctly at some point.  They will be needed
if netfslib is to make use of folio->private for its own purposes.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    Changes
    =======
    ver #5)
     - Removed ceph_fscache_note_page_release() also as that is now unused.
     - Added missing '*' to turn comment into kdoc.

 fs/9p/vfs_addr.c      | 33 ++-------------------------
 fs/afs/file.c         | 53 ++++---------------------------------------
 fs/ceph/addr.c        | 24 ++------------------
 fs/ceph/cache.h       | 10 --------
 fs/netfs/misc.c       | 42 ++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |  6 +++--
 6 files changed, 54 insertions(+), 114 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 131b83c31f85..055b672a247d 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -88,35 +88,6 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.issue_read		= v9fs_issue_read,
 };
 
-/**
- * v9fs_release_folio - release the private state associated with a folio
- * @folio: The folio to be released
- * @gfp: The caller's allocation restrictions
- *
- * Returns true if the page can be released, false otherwise.
- */
-
-static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
-{
-	if (folio_test_private(folio))
-		return false;
-#ifdef CONFIG_9P_FSCACHE
-	if (folio_test_fscache(folio)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		folio_wait_fscache(folio);
-	}
-	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(folio_inode(folio))));
-#endif
-	return true;
-}
-
-static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
-				 size_t length)
-{
-	folio_wait_fscache(folio);
-}
-
 #ifdef CONFIG_9P_FSCACHE
 static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
 				     bool was_async)
@@ -324,8 +295,8 @@ const struct address_space_operations v9fs_addr_operations = {
 	.writepage	= v9fs_vfs_writepage,
 	.write_begin	= v9fs_write_begin,
 	.write_end	= v9fs_write_end,
-	.release_folio	= v9fs_release_folio,
-	.invalidate_folio = v9fs_invalidate_folio,
+	.release_folio	= netfs_release_folio,
+	.invalidate_folio = netfs_invalidate_folio,
 	.launder_folio	= v9fs_launder_folio,
 	.direct_IO	= v9fs_direct_IO,
 };
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0d783e5b2147..d152ba451f0e 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -20,9 +20,6 @@
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 static int afs_symlink_read_folio(struct file *file, struct folio *folio);
-static void afs_invalidate_folio(struct folio *folio, size_t offset,
-			       size_t length);
-static bool afs_release_folio(struct folio *folio, gfp_t gfp_flags);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
@@ -57,8 +54,8 @@ const struct address_space_operations afs_file_aops = {
 	.readahead	= netfs_readahead,
 	.dirty_folio	= netfs_dirty_folio,
 	.launder_folio	= afs_launder_folio,
-	.release_folio	= afs_release_folio,
-	.invalidate_folio = afs_invalidate_folio,
+	.release_folio	= netfs_release_folio,
+	.invalidate_folio = netfs_invalidate_folio,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
 	.writepages	= afs_writepages,
@@ -67,8 +64,8 @@ const struct address_space_operations afs_file_aops = {
 
 const struct address_space_operations afs_symlink_aops = {
 	.read_folio	= afs_symlink_read_folio,
-	.release_folio	= afs_release_folio,
-	.invalidate_folio = afs_invalidate_folio,
+	.release_folio	= netfs_release_folio,
+	.invalidate_folio = netfs_invalidate_folio,
 	.migrate_folio	= filemap_migrate_folio,
 };
 
@@ -386,48 +383,6 @@ const struct netfs_request_ops afs_req_ops = {
 	.issue_read		= afs_issue_read,
 };
 
-/*
- * invalidate part or all of a page
- * - release a page and clean up its private data if offset is 0 (indicating
- *   the entire page)
- */
-static void afs_invalidate_folio(struct folio *folio, size_t offset,
-			       size_t length)
-{
-	_enter("{%lu},%zu,%zu", folio->index, offset, length);
-
-	folio_wait_fscache(folio);
-	_leave("");
-}
-
-/*
- * release a page and clean up its private state if it's not busy
- * - return true if the page can now be released, false if not
- */
-static bool afs_release_folio(struct folio *folio, gfp_t gfp)
-{
-	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
-
-	_enter("{{%llx:%llu}[%lu],%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio), folio->flags,
-	       gfp);
-
-	/* deny if folio is being written to the cache and the caller hasn't
-	 * elected to wait */
-#ifdef CONFIG_AFS_FSCACHE
-	if (folio_test_fscache(folio)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		folio_wait_fscache(folio);
-	}
-	fscache_note_page_release(afs_vnode_cache(vnode));
-#endif
-
-	/* Indicate that the folio can be released */
-	_leave(" = T");
-	return true;
-}
-
 static void afs_add_open_mmap(struct afs_vnode *vnode)
 {
 	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3b8641febeac..8eedc62e7ac4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -159,27 +159,7 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 		ceph_put_snap_context(snapc);
 	}
 
-	folio_wait_fscache(folio);
-}
-
-static bool ceph_release_folio(struct folio *folio, gfp_t gfp)
-{
-	struct inode *inode = folio->mapping->host;
-	struct ceph_client *cl = ceph_inode_to_client(inode);
-
-	doutc(cl, "%llx.%llx idx %lu (%sdirty)\n", ceph_vinop(inode),
-	      folio->index, folio_test_dirty(folio) ? "" : "not ");
-
-	if (folio_test_private(folio))
-		return false;
-
-	if (folio_test_fscache(folio)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		folio_wait_fscache(folio);
-	}
-	ceph_fscache_note_page_release(inode);
-	return true;
+	netfs_invalidate_folio(folio, offset, length);
 }
 
 static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
@@ -1585,7 +1565,7 @@ const struct address_space_operations ceph_aops = {
 	.write_end = ceph_write_end,
 	.dirty_folio = ceph_dirty_folio,
 	.invalidate_folio = ceph_invalidate_folio,
-	.release_folio = ceph_release_folio,
+	.release_folio = netfs_release_folio,
 	.direct_IO = noop_direct_IO,
 };
 
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 8fc7d828d990..20efac020394 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -56,12 +56,6 @@ static inline bool ceph_is_cache_enabled(struct inode *inode)
 	return fscache_cookie_enabled(ceph_fscache_cookie(ceph_inode(inode)));
 }
 
-static inline void ceph_fscache_note_page_release(struct inode *inode)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-
-	fscache_note_page_release(ceph_fscache_cookie(ci));
-}
 #else /* CONFIG_CEPH_FSCACHE */
 static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc,
 					   struct fs_context *fc)
@@ -118,10 +112,6 @@ static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
 	return false;
 }
-
-static inline void ceph_fscache_note_page_release(struct inode *inode)
-{
-}
 #endif /* CONFIG_CEPH_FSCACHE */
 
 #endif
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 68baf55c47a4..45bb19ec9a63 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -84,3 +84,45 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 	}
 }
 EXPORT_SYMBOL(netfs_clear_inode_writeback);
+
+/**
+ * netfs_invalidate_folio - Invalidate or partially invalidate a folio
+ * @folio: Folio proposed for release
+ * @offset: Offset of the invalidated region
+ * @length: Length of the invalidated region
+ *
+ * Invalidate part or all of a folio for a network filesystem.  The folio will
+ * be removed afterwards if the invalidated region covers the entire folio.
+ */
+void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
+{
+	_enter("{%lx},%zx,%zx", folio_index(folio), offset, length);
+
+	folio_wait_fscache(folio);
+}
+EXPORT_SYMBOL(netfs_invalidate_folio);
+
+/**
+ * netfs_release_folio - Try to release a folio
+ * @folio: Folio proposed for release
+ * @gfp: Flags qualifying the release
+ *
+ * Request release of a folio and clean up its private state if it's not busy.
+ * Returns true if the folio can now be released, false if not
+ */
+bool netfs_release_folio(struct folio *folio, gfp_t gfp)
+{
+	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
+
+	if (folio_test_private(folio))
+		return false;
+	if (folio_test_fscache(folio)) {
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
+			return false;
+		folio_wait_fscache(folio);
+	}
+
+	fscache_note_page_release(netfs_i_cookie(ctx));
+	return true;
+}
+EXPORT_SYMBOL(netfs_release_folio);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 06f57d9d09f6..8efbfd3b2820 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -293,11 +293,13 @@ struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
-		struct address_space *, loff_t pos, unsigned int len,
-		struct folio **, void **fsdata);
+		      struct address_space *, loff_t pos, unsigned int len,
+		      struct folio **, void **fsdata);
 bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
 int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
+void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
+bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 
 void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,


