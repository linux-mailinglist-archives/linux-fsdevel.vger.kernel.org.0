Return-Path: <linux-fsdevel+bounces-5918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEF811677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084731F21B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6B381CC;
	Wed, 13 Dec 2023 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St0qiU0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2A10F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yhsUpzLzPwpBfrpQlO8RphbApvPRXSAjecvAMUH8XM=;
	b=St0qiU0CPXTwSW33QFaYs+XenoERuLGzmbylpJZKrenXmE0W9NH8LyxXRyCccUW1WTJe8c
	ReYbAbnJP7CE27TTTtYuc3FYuXFos8dgex6b5e4ihofvsyc4AlOXa5sQL6RRoQGPPzc4uA
	kn1vUYXSHUE0c7eu4Ln0P+IRGZRR7/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_BZ3FQ8QOJKS9fPhjAjUbg-1; Wed, 13 Dec 2023 10:24:15 -0500
X-MC-Unique: _BZ3FQ8QOJKS9fPhjAjUbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CF6088F5AD;
	Wed, 13 Dec 2023 15:24:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FC511C060B1;
	Wed, 13 Dec 2023 15:24:11 +0000 (UTC)
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
Subject: [PATCH v4 05/39] netfs: Move pinning-for-writeback from fscache to netfs
Date: Wed, 13 Dec 2023 15:23:15 +0000
Message-ID: <20231213152350.431591-6-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Move the resource pinning-for-writeback from fscache code to netfslib code.
This is used to keep a cache backing object pinned whilst we have dirty
pages on the netfs inode in the pagecache such that VM writeback will be
able to reach it.

Whilst we're at it, switch the parameters of netfs_unpin_writeback() to
match ->write_inode() so that it can be used for that directly.

Note that this mechanism could be more generically useful than that for
network filesystems.  Quite often they have to keep around other resources
(e.g. authentication tokens or network connections) until the writeback is
complete.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_addr.c          | 33 ++++-----------
 fs/9p/vfs_inode.c         |  3 +-
 fs/9p/vfs_super.c         | 14 +------
 fs/afs/file.c             |  8 +---
 fs/afs/inode.c            |  2 +-
 fs/afs/internal.h         |  6 ---
 fs/afs/super.c            |  2 +-
 fs/afs/write.c            |  9 ----
 fs/ceph/cache.h           | 23 ++++-------
 fs/ceph/inode.c           |  2 +-
 fs/fs-writeback.c         | 10 ++---
 fs/netfs/Makefile         |  1 +
 fs/netfs/fscache_io.c     | 40 ------------------
 fs/netfs/misc.c           | 86 +++++++++++++++++++++++++++++++++++++++
 fs/smb/client/cifsfs.c    |  5 +--
 fs/smb/client/file.c      | 18 +-------
 include/linux/fs.h        |  2 +-
 include/linux/fscache.h   | 42 -------------------
 include/linux/netfs.h     |  3 ++
 include/linux/writeback.h |  2 +-
 20 files changed, 124 insertions(+), 187 deletions(-)
 create mode 100644 fs/netfs/misc.c

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 39db7c01e30a..131b83c31f85 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -317,30 +317,15 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	return copied;
 }
 
-#ifdef CONFIG_9P_FSCACHE
-/*
- * Mark a page as having been made dirty and thus needing writeback.  We also
- * need to pin the cache object to write back to.
- */
-static bool v9fs_dirty_folio(struct address_space *mapping, struct folio *folio)
-{
-	struct v9fs_inode *v9inode = V9FS_I(mapping->host);
-
-	return fscache_dirty_folio(mapping, folio, v9fs_inode_cookie(v9inode));
-}
-#else
-#define v9fs_dirty_folio filemap_dirty_folio
-#endif
-
 const struct address_space_operations v9fs_addr_operations = {
-	.read_folio = netfs_read_folio,
-	.readahead = netfs_readahead,
-	.dirty_folio = v9fs_dirty_folio,
-	.writepage = v9fs_vfs_writepage,
-	.write_begin = v9fs_write_begin,
-	.write_end = v9fs_write_end,
-	.release_folio = v9fs_release_folio,
+	.read_folio	= netfs_read_folio,
+	.readahead	= netfs_readahead,
+	.dirty_folio	= netfs_dirty_folio,
+	.writepage	= v9fs_vfs_writepage,
+	.write_begin	= v9fs_write_begin,
+	.write_end	= v9fs_write_end,
+	.release_folio	= v9fs_release_folio,
 	.invalidate_folio = v9fs_invalidate_folio,
-	.launder_folio = v9fs_launder_folio,
-	.direct_IO = v9fs_direct_IO,
+	.launder_folio	= v9fs_launder_folio,
+	.direct_IO	= v9fs_direct_IO,
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..74122540e00f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -376,8 +376,7 @@ void v9fs_evict_inode(struct inode *inode)
 
 #ifdef CONFIG_9P_FSCACHE
 	version = cpu_to_le32(v9inode->qid.version);
-	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
-				      &version);
+	netfs_clear_inode_writeback(inode, &version);
 #endif
 
 	clear_inode(inode);
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 73db55c050bf..941f7d0e0bfa 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -289,31 +289,21 @@ static int v9fs_drop_inode(struct inode *inode)
 static int v9fs_write_inode(struct inode *inode,
 			    struct writeback_control *wbc)
 {
-	struct v9fs_inode *v9inode;
-
 	/*
 	 * send an fsync request to server irrespective of
 	 * wbc->sync_mode.
 	 */
 	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
-
-	v9inode = V9FS_I(inode);
-	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
-
-	return 0;
+	return netfs_unpin_writeback(inode, wbc);
 }
 
 static int v9fs_write_inode_dotl(struct inode *inode,
 				 struct writeback_control *wbc)
 {
-	struct v9fs_inode *v9inode;
 
-	v9inode = V9FS_I(inode);
 	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
 
-	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
-
-	return 0;
+	return netfs_unpin_writeback(inode, wbc);
 }
 
 static const struct super_operations v9fs_super_ops = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0326ae21fbea..c09e881da5d2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -55,7 +55,7 @@ const struct inode_operations afs_file_inode_operations = {
 const struct address_space_operations afs_file_aops = {
 	.read_folio	= netfs_read_folio,
 	.readahead	= netfs_readahead,
-	.dirty_folio	= afs_dirty_folio,
+	.dirty_folio	= netfs_dirty_folio,
 	.launder_folio	= afs_launder_folio,
 	.release_folio	= afs_release_folio,
 	.invalidate_folio = afs_invalidate_folio,
@@ -383,12 +383,6 @@ const struct netfs_request_ops afs_req_ops = {
 	.issue_read		= afs_issue_read,
 };
 
-int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	fscache_unpin_writeback(wbc, afs_vnode_cache(AFS_FS_I(inode)));
-	return 0;
-}
-
 /*
  * Adjust the dirty region of the page on truncation or full invalidation,
  * getting rid of the markers altogether if the region is entirely invalidated.
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 12b90d680fb6..de3e8fec54b7 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -647,7 +647,7 @@ void afs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 
 	afs_set_cache_aux(vnode, &aux);
-	fscache_clear_inode_writeback(afs_vnode_cache(vnode), inode, &aux);
+	netfs_clear_inode_writeback(inode, &aux);
 	clear_inode(inode);
 
 	while (!list_empty(&vnode->wb_keys)) {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f360726f6082..379fcd698062 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1166,7 +1166,6 @@ extern int afs_release(struct inode *, struct file *);
 extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
 extern struct afs_read *afs_alloc_read(gfp_t);
 extern void afs_put_read(struct afs_read *);
-extern int afs_write_inode(struct inode *, struct writeback_control *);
 
 static inline struct afs_read *afs_get_read(struct afs_read *req)
 {
@@ -1658,11 +1657,6 @@ bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 /*
  * write.c
  */
-#ifdef CONFIG_AFS_FSCACHE
-bool afs_dirty_folio(struct address_space *, struct folio *);
-#else
-#define afs_dirty_folio filemap_dirty_folio
-#endif
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index ae2d66a52add..f3ba1c3e72f5 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -55,7 +55,7 @@ int afs_net_id;
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
 	.alloc_inode	= afs_alloc_inode,
-	.write_inode	= afs_write_inode,
+	.write_inode	= netfs_unpin_writeback,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
 	.free_inode	= afs_free_inode,
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 61d34ad2ca7d..62e1cc5985c4 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -23,15 +23,6 @@ static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len
 			       loff_t i_size, bool caching);
 
 #ifdef CONFIG_AFS_FSCACHE
-/*
- * Mark a page as having been made dirty and thus needing writeback.  We also
- * need to pin the cache object to write back to.
- */
-bool afs_dirty_folio(struct address_space *mapping, struct folio *folio)
-{
-	return fscache_dirty_folio(mapping, folio,
-				afs_vnode_cache(AFS_FS_I(mapping->host)));
-}
 static void afs_folio_start_fscache(bool caching, struct folio *folio)
 {
 	if (caching)
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index b804f1094764..8fc7d828d990 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -43,19 +43,13 @@ static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
 	}
 }
 
-static inline void ceph_fscache_unpin_writeback(struct inode *inode,
+static inline int ceph_fscache_unpin_writeback(struct inode *inode,
 						struct writeback_control *wbc)
 {
-	fscache_unpin_writeback(wbc, ceph_fscache_cookie(ceph_inode(inode)));
+	return netfs_unpin_writeback(inode, wbc);
 }
 
-static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	struct ceph_inode_info *ci = ceph_inode(mapping->host);
-
-	return fscache_dirty_folio(mapping, folio, ceph_fscache_cookie(ci));
-}
+#define ceph_fscache_dirty_folio netfs_dirty_folio
 
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
@@ -112,16 +106,13 @@ static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
 {
 }
 
-static inline void ceph_fscache_unpin_writeback(struct inode *inode,
-						struct writeback_control *wbc)
+static inline int ceph_fscache_unpin_writeback(struct inode *inode,
+					       struct writeback_control *wbc)
 {
+	return 0;
 }
 
-static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	return filemap_dirty_folio(mapping, folio);
-}
+#define ceph_fscache_dirty_folio filemap_dirty_folio
 
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 0679240f06db..3149d79a9dbe 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -694,7 +694,7 @@ void ceph_evict_inode(struct inode *inode)
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_FSCACHE_WB)
+	if (inode->i_state & I_PINNING_NETFS_WB)
 		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a66c9d0556dc..3c9e4256a6d3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1675,11 +1675,11 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		inode->i_state |= I_DIRTY_PAGES;
-	else if (unlikely(inode->i_state & I_PINNING_FSCACHE_WB)) {
+	else if (unlikely(inode->i_state & I_PINNING_NETFS_WB)) {
 		if (!(inode->i_state & I_DIRTY_PAGES)) {
-			inode->i_state &= ~I_PINNING_FSCACHE_WB;
-			wbc->unpinned_fscache_wb = true;
-			dirty |= I_PINNING_FSCACHE_WB; /* Cause write_inode */
+			inode->i_state &= ~I_PINNING_NETFS_WB;
+			wbc->unpinned_netfs_wb = true;
+			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
 		}
 	}
 
@@ -1691,7 +1691,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 		if (ret == 0)
 			ret = err;
 	}
-	wbc->unpinned_fscache_wb = false;
+	wbc->unpinned_netfs_wb = false;
 	trace_writeback_single_inode(inode, wbc, nr_to_write);
 	return ret;
 }
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index b57162ef9cfb..a84fe9bbd3c4 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -5,6 +5,7 @@ netfs-y := \
 	io.o \
 	iterator.o \
 	main.o \
+	misc.o \
 	objects.o
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 0d2b8dec8f82..79171a687930 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -158,46 +158,6 @@ int __fscache_begin_write_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_write_operation);
 
-/**
- * fscache_dirty_folio - Mark folio dirty and pin a cache object for writeback
- * @mapping: The mapping the folio belongs to.
- * @folio: The folio being dirtied.
- * @cookie: The cookie referring to the cache object
- *
- * Set the dirty flag on a folio and pin an in-use cache object in memory
- * so that writeback can later write to it.  This is intended
- * to be called from the filesystem's ->dirty_folio() method.
- *
- * Return: true if the dirty flag was set on the folio, false otherwise.
- */
-bool fscache_dirty_folio(struct address_space *mapping, struct folio *folio,
-				struct fscache_cookie *cookie)
-{
-	struct inode *inode = mapping->host;
-	bool need_use = false;
-
-	_enter("");
-
-	if (!filemap_dirty_folio(mapping, folio))
-		return false;
-	if (!fscache_cookie_valid(cookie))
-		return true;
-
-	if (!(inode->i_state & I_PINNING_FSCACHE_WB)) {
-		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_FSCACHE_WB)) {
-			inode->i_state |= I_PINNING_FSCACHE_WB;
-			need_use = true;
-		}
-		spin_unlock(&inode->i_lock);
-
-		if (need_use)
-			fscache_use_cookie(cookie, true);
-	}
-	return true;
-}
-EXPORT_SYMBOL(fscache_dirty_folio);
-
 struct fscache_write_request {
 	struct netfs_cache_resources cache_resources;
 	struct address_space	*mapping;
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
new file mode 100644
index 000000000000..68baf55c47a4
--- /dev/null
+++ b/fs/netfs/misc.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Miscellaneous routines.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/swap.h>
+#include "internal.h"
+
+/**
+ * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
+ * @mapping: The mapping the folio belongs to.
+ * @folio: The folio being dirtied.
+ *
+ * Set the dirty flag on a folio and pin an in-use cache object in memory so
+ * that writeback can later write to it.  This is intended to be called from
+ * the filesystem's ->dirty_folio() method.
+ *
+ * Return: true if the dirty flag was set on the folio, false otherwise.
+ */
+bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(ictx);
+	bool need_use = false;
+
+	_enter("");
+
+	if (!filemap_dirty_folio(mapping, folio))
+		return false;
+	if (!fscache_cookie_valid(cookie))
+		return true;
+
+	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+		spin_lock(&inode->i_lock);
+		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+			inode->i_state |= I_PINNING_NETFS_WB;
+			need_use = true;
+		}
+		spin_unlock(&inode->i_lock);
+
+		if (need_use)
+			fscache_use_cookie(cookie, true);
+	}
+	return true;
+}
+EXPORT_SYMBOL(netfs_dirty_folio);
+
+/**
+ * netfs_unpin_writeback - Unpin writeback resources
+ * @inode: The inode on which the cookie resides
+ * @wbc: The writeback control
+ *
+ * Unpin the writeback resources pinned by netfs_dirty_folio().  This is
+ * intended to be called as/by the netfs's ->write_inode() method.
+ */
+int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc)
+{
+	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
+
+	if (wbc->unpinned_netfs_wb)
+		fscache_unuse_cookie(cookie, NULL, NULL);
+	return 0;
+}
+EXPORT_SYMBOL(netfs_unpin_writeback);
+
+/**
+ * netfs_clear_inode_writeback - Clear writeback resources pinned by an inode
+ * @inode: The inode to clean up
+ * @aux: Auxiliary data to apply to the inode
+ *
+ * Clear any writeback resources held by an inode when the inode is evicted.
+ * This must be called before clear_inode() is called.
+ */
+void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
+{
+	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
+
+	if (inode->i_state & I_PINNING_NETFS_WB) {
+		loff_t i_size = i_size_read(inode);
+		fscache_unuse_cookie(cookie, aux, &i_size);
+	}
+}
+EXPORT_SYMBOL(netfs_clear_inode_writeback);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2131638f26d0..96a65cf9b5ec 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -429,7 +429,7 @@ static void
 cifs_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_FSCACHE_WB)
+	if (inode->i_state & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
@@ -792,8 +792,7 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 
 static int cifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-	fscache_unpin_writeback(wbc, cifs_inode_cookie(inode));
-	return 0;
+	return netfs_unpin_writeback(inode, wbc);
 }
 
 static int cifs_drop_inode(struct inode *inode)
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 45ca492c141c..b25cace63768 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -5041,27 +5041,13 @@ static void cifs_swap_deactivate(struct file *file)
 	/* do we need to unpin (or unlock) the file */
 }
 
-/*
- * Mark a page as having been made dirty and thus needing writeback.  We also
- * need to pin the cache object to write back to.
- */
-#ifdef CONFIG_CIFS_FSCACHE
-static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
-{
-	return fscache_dirty_folio(mapping, folio,
-					cifs_inode_cookie(mapping->host));
-}
-#else
-#define cifs_dirty_folio filemap_dirty_folio
-#endif
-
 const struct address_space_operations cifs_addr_ops = {
 	.read_folio = cifs_read_folio,
 	.readahead = cifs_readahead,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.dirty_folio = cifs_dirty_folio,
+	.dirty_folio = netfs_dirty_folio,
 	.release_folio = cifs_release_folio,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
@@ -5085,7 +5071,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
-	.dirty_folio = cifs_dirty_folio,
+	.dirty_folio = netfs_dirty_folio,
 	.release_folio = cifs_release_folio,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 897c63c64556..f4fd7f80ce93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2373,7 +2373,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
-#define I_PINNING_FSCACHE_WB	(1 << 18)
+#define I_PINNING_NETFS_WB	(1 << 18)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9ed6696aee7a..6e8562cbcc43 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -626,48 +626,6 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 
 }
 
-#if __fscache_available
-bool fscache_dirty_folio(struct address_space *mapping, struct folio *folio,
-		struct fscache_cookie *cookie);
-#else
-#define fscache_dirty_folio(MAPPING, FOLIO, COOKIE) \
-		filemap_dirty_folio(MAPPING, FOLIO)
-#endif
-
-/**
- * fscache_unpin_writeback - Unpin writeback resources
- * @wbc: The writeback control
- * @cookie: The cookie referring to the cache object
- *
- * Unpin the writeback resources pinned by fscache_dirty_folio().  This is
- * intended to be called by the netfs's ->write_inode() method.
- */
-static inline void fscache_unpin_writeback(struct writeback_control *wbc,
-					   struct fscache_cookie *cookie)
-{
-	if (wbc->unpinned_fscache_wb)
-		fscache_unuse_cookie(cookie, NULL, NULL);
-}
-
-/**
- * fscache_clear_inode_writeback - Clear writeback resources pinned by an inode
- * @cookie: The cookie referring to the cache object
- * @inode: The inode to clean up
- * @aux: Auxiliary data to apply to the inode
- *
- * Clear any writeback resources held by an inode when the inode is evicted.
- * This must be called before clear_inode() is called.
- */
-static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
-						 struct inode *inode,
-						 const void *aux)
-{
-	if (inode->i_state & I_PINNING_FSCACHE_WB) {
-		loff_t i_size = i_size_read(inode);
-		fscache_unuse_cookie(cookie, aux, &i_size);
-	}
-}
-
 /**
  * fscache_note_page_release - Note that a netfs page got released
  * @cookie: The cookie corresponding to the file
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9bd91cd615d5..32faf6c89702 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -288,6 +288,9 @@ int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
 		struct address_space *, loff_t pos, unsigned int len,
 		struct folio **, void **fsdata);
+bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
+int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
+void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 
 void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index f47701c114dd..4148d8ffff26 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -60,7 +60,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
-	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
+	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the


