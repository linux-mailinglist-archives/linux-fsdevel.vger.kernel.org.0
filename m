Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA93D0FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhGUNGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238755AbhGUNFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJF6irQE00ShIEgld85BW9bY0f39qS1KE4GzM9lKwvI=;
        b=U1fbpGogSGVgzNDfQ0WSUoexX79vrwqSc8Rw4bGDVSanowJ6qk4flk6aUHOgpqnEN5ImNO
        FLhMzx/+LDVsog5sVWvW46V4wU2InH0hkw7UoM65UMYjExIvvVpQ6EqDGhIXB6MOvCfEt2
        QM2Zz5vHhdLeKHa8RbRWxJxNATHs1YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-0ZU9Yv9pPY-NZ_7LkAyTLg-1; Wed, 21 Jul 2021 09:46:05 -0400
X-MC-Unique: 0ZU9Yv9pPY-NZ_7LkAyTLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFEBC93920;
        Wed, 21 Jul 2021 13:46:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A515560C59;
        Wed, 21 Jul 2021 13:45:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/12] netfs: Add a netfs inode context
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:45:52 +0100
Message-ID: <162687515266.276387.1299416976214634692.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a netfs_i_context struct that should be included in the network
filesystem's own inode struct wrapper, directly after the VFS's inode
struct, e.g.:

	struct my_inode {
		struct {
			struct inode		vfs_inode;
			struct netfs_i_context	netfs_ctx;
		};
	};

The netfs_i_context struct contains two fields for the network filesystem
to use:

	struct netfs_i_context {
		...
		struct fscache_cookie	*cache;
		unsigned long		flags;
	#define NETFS_ICTX_NEW_CONTENT	0
	};

There's a pointer to the cache cookie and a flag to indicate that the
content in the file is locally generated and entirely new (ie. the file was
just created locally or was truncated to nothing).

Two functions are provided to help with this:

 (1) void netfs_i_context_init(struct inode *inode,
			       const struct netfs_request_ops *ops);

     Initialise the netfs context and set the operations.

 (2) struct netfs_i_context *netfs_i_context(struct inode *inode);

     Find the netfs context from the inode struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c      |    2 -
 fs/afs/dir.c           |    2 -
 fs/afs/dynroot.c       |    1 
 fs/afs/file.c          |   29 ++---------
 fs/afs/inode.c         |   10 ++--
 fs/afs/internal.h      |   13 ++---
 fs/afs/super.c         |    2 -
 fs/afs/write.c         |    7 +--
 fs/ceph/addr.c         |    2 -
 fs/netfs/internal.h    |   11 ++++
 fs/netfs/read_helper.c |  124 ++++++++++++++++++++++--------------------------
 fs/netfs/stats.c       |    1 
 include/linux/netfs.h  |   66 +++++++++++++++++++++-----
 13 files changed, 146 insertions(+), 124 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 7d9b23d981bf..0d4b9678ad22 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -41,7 +41,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 {
 	_enter("");
 
-	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	clear_bit(NETFS_ICTX_NEW_CONTENT, &netfs_i_context(&vnode->vfs_inode)->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
 		afs_clear_permits(vnode);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ac829e63c570..a4c9cd6de622 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1350,7 +1350,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 	}
 
 	vnode = AFS_FS_I(inode);
-	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	set_bit(NETFS_ICTX_NEW_CONTENT, &netfs_i_context(&vnode->vfs_inode)->flags);
 	if (!op->error)
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index db832cc931c8..f120bcb8bf73 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -76,6 +76,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	/* there shouldn't be an existing inode */
 	BUG_ON(!(inode->i_state & I_NEW));
 
+	netfs_i_context_init(inode, NULL);
 	inode->i_size		= 0;
 	inode->i_mode		= S_IFDIR | S_IRUGO | S_IXUGO;
 	if (root) {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 82e945dbe379..1861e4ecc2ce 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -18,13 +18,11 @@
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_readpage(struct file *file, struct page *page);
 static int afs_symlink_readpage(struct file *file, struct page *page);
 static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
-static void afs_readahead(struct readahead_control *ractl);
 static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 const struct file_operations afs_file_operations = {
@@ -48,8 +46,8 @@ const struct inode_operations afs_file_inode_operations = {
 };
 
 const struct address_space_operations afs_file_aops = {
-	.readpage	= afs_readpage,
-	.readahead	= afs_readahead,
+	.readpage	= netfs_readpage,
+	.readahead	= netfs_readahead,
 	.set_page_dirty	= afs_set_page_dirty,
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
@@ -153,7 +151,8 @@ int afs_open(struct inode *inode, struct file *file)
 	}
 
 	if (file->f_flags & O_TRUNC)
-		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+		set_bit(NETFS_ICTX_NEW_CONTENT,
+			&netfs_i_context(&vnode->vfs_inode)->flags);
 
 	fscache_use_cookie(afs_vnode_cache(vnode), file->f_mode & FMODE_WRITE);
 
@@ -351,13 +350,6 @@ static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
 	rreq->netfs_priv = key_get(afs_file_key(file));
 }
 
-static bool afs_is_cache_enabled(struct inode *inode)
-{
-	struct fscache_cookie *cookie = afs_vnode_cache(AFS_FS_I(inode));
-
-	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
-}
-
 static int afs_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
@@ -378,25 +370,14 @@ static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 	key_put(netfs_priv);
 }
 
-const struct netfs_read_request_ops afs_req_ops = {
+const struct netfs_request_ops afs_req_ops = {
 	.init_rreq		= afs_init_rreq,
-	.is_cache_enabled	= afs_is_cache_enabled,
 	.begin_cache_operation	= afs_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
 	.issue_op		= afs_req_issue_op,
 	.cleanup		= afs_priv_cleanup,
 };
 
-static int afs_readpage(struct file *file, struct page *page)
-{
-	return netfs_readpage(file, page, &afs_req_ops, NULL);
-}
-
-static void afs_readahead(struct readahead_control *ractl)
-{
-	netfs_readahead(ractl, &afs_req_ops, NULL);
-}
-
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	fscache_unpin_writeback(wbc, afs_vnode_cache(AFS_FS_I(inode)));
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index cf7b66957c6f..3e9e388245a1 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -430,7 +430,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	struct afs_vnode_cache_aux aux;
 
 	if (vnode->status.type != AFS_FTYPE_FILE) {
-		vnode->cache = NULL;
+		vnode->netfs_ctx.cache = NULL;
 		return;
 	}
 
@@ -440,7 +440,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	key.vnode_id_ext[1]	= htonl(vnode->fid.vnode_hi);
 	afs_set_cache_aux(vnode, &aux);
 
-	vnode->cache = fscache_acquire_cookie(
+	vnode->netfs_ctx.cache = fscache_acquire_cookie(
 		vnode->volume->cache,
 		vnode->status.type == AFS_FTYPE_FILE ? 0 : FSCACHE_ADV_SINGLE_CHUNK,
 		&key, sizeof(key),
@@ -479,6 +479,7 @@ struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param *vp)
 		return inode;
 	}
 
+	netfs_i_context_init(inode, &afs_req_ops);
 	ret = afs_inode_init_from_status(op, vp, vnode);
 	if (ret < 0)
 		goto bad_inode;
@@ -535,6 +536,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	_debug("GOT ROOT INODE %p { vl=%llx }", inode, as->volume->vid);
 
 	BUG_ON(!(inode->i_state & I_NEW));
+	netfs_i_context_init(inode, &afs_req_ops);
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_break = as->volume->cb_v_break,
@@ -803,9 +805,9 @@ void afs_evict_inode(struct inode *inode)
 	}
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(vnode->cache,
+	fscache_relinquish_cookie(vnode->netfs_ctx.cache,
 				  test_bit(AFS_VNODE_DELETED, &vnode->flags));
-	vnode->cache = NULL;
+	vnode->netfs_ctx.cache = NULL;
 #endif
 
 	afs_prune_wb_keys(vnode);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ccdde00ada8a..e0204dde4b50 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -615,15 +615,15 @@ enum afs_lock_state {
  * leak from one inode to another.
  */
 struct afs_vnode {
-	struct inode		vfs_inode;	/* the VFS's inode record */
+	struct {
+		struct inode	vfs_inode;	/* the VFS's inode record */
+		struct netfs_i_context netfs_ctx; /* Netfslib context */
+	};
 
 	struct afs_volume	*volume;	/* volume on which vnode resides */
 	struct afs_fid		fid;		/* the file identifier for this inode */
 	struct afs_file_status	status;		/* AFS status info for this file */
 	afs_dataversion_t	invalid_before;	/* Child dentries are invalid before this */
-#ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
-#endif
 	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtained */
 	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
 	struct rw_semaphore	validate_lock;	/* lock for validating this vnode */
@@ -640,7 +640,6 @@ struct afs_vnode {
 #define AFS_VNODE_MOUNTPOINT	5		/* set if vnode is a mountpoint symlink */
 #define AFS_VNODE_AUTOCELL	6		/* set if Vnode is an auto mount point */
 #define AFS_VNODE_PSEUDODIR	7 		/* set if Vnode is a pseudo directory */
-#define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/trunc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted */
 #define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification op */
 
@@ -666,7 +665,7 @@ struct afs_vnode {
 static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vnode)
 {
 #ifdef CONFIG_AFS_FSCACHE
-	return vnode->cache;
+	return vnode->netfs_ctx.cache;
 #else
 	return NULL;
 #endif
@@ -1054,7 +1053,7 @@ extern const struct address_space_operations afs_file_aops;
 extern const struct address_space_operations afs_symlink_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
-extern const struct netfs_read_request_ops afs_req_ops;
+extern const struct netfs_request_ops afs_req_ops;
 
 extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 85e52c78f44f..29c1178beb72 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -692,7 +692,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->lock_key		= NULL;
 	vnode->permit_cache	= NULL;
 #ifdef CONFIG_AFS_FSCACHE
-	vnode->cache		= NULL;
+	vnode->netfs_ctx.cache	= NULL;
 #endif
 
 	vnode->flags		= 1 << AFS_VNODE_UNSET;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 3be3a594124c..a244187f3503 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -49,8 +49,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	ret = netfs_write_begin(file, mapping, pos, len, flags, &page, fsdata,
-				&afs_req_ops, NULL);
+	ret = netfs_write_begin(file, mapping, pos, len, flags, &page, fsdata);
 	if (ret < 0)
 		return ret;
 
@@ -76,7 +75,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		 * spaces to be merged into writes.  If it's not, only write
 		 * back what the user gives us.
 		 */
-		if (!test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags) &&
+		if (!test_bit(NETFS_ICTX_NEW_CONTENT, &vnode->netfs_ctx.flags) &&
 		    (to < f || from > t))
 			goto flush_conflicting_write;
 	}
@@ -557,7 +556,7 @@ static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
 	unsigned long priv;
 	unsigned int offset, to, len, max_len;
 	loff_t i_size = i_size_read(&vnode->vfs_inode);
-	bool new_content = test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	bool new_content = test_bit(NETFS_ICTX_NEW_CONTENT, &vnode->netfs_ctx.flags);
 	long count = wbc->nr_to_write;
 	int ret;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a1e2813731d1..a8a41254e691 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -305,7 +305,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
 		ceph_put_cap_refs(ci, got);
 }
 
-static const struct netfs_read_request_ops ceph_netfs_read_ops = {
+static const struct netfs_request_ops ceph_netfs_read_ops = {
 	.init_rreq		= ceph_init_rreq,
 	.is_cache_enabled	= ceph_is_cache_enabled,
 	.begin_cache_operation	= ceph_begin_cache_operation,
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index b7f2c4459f33..4805d9fc8808 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -5,6 +5,10 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/netfs.h>
+#include <linux/fscache.h>
+#include <trace/events/netfs.h>
+
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
@@ -50,6 +54,13 @@ static inline void netfs_stat_d(atomic_t *stat)
 	atomic_dec(stat);
 }
 
+static inline bool netfs_is_cache_enabled(struct inode *inode)
+{
+	struct fscache_cookie *cookie = netfs_i_cookie(inode);
+
+	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
+}
+
 #else
 #define netfs_stat(x) do {} while(0)
 #define netfs_stat_d(x) do {} while(0)
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index b03bc5b0da5a..aa98ecf6df6b 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -14,7 +14,6 @@
 #include <linux/uio.h>
 #include <linux/sched/mm.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/netfs.h>
 #include "internal.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/netfs.h>
@@ -38,26 +37,27 @@ static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_read_request *netfs_alloc_read_request(
-	const struct netfs_read_request_ops *ops, void *netfs_priv,
-	struct file *file)
+static struct netfs_read_request *netfs_alloc_read_request(struct address_space *mapping,
+							   struct file *file)
 {
 	static atomic_t debug_ids;
+	struct inode *inode = file ? file_inode(file) : mapping->host;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
 	struct netfs_read_request *rreq;
 
 	rreq = kzalloc(sizeof(struct netfs_read_request), GFP_KERNEL);
 	if (rreq) {
-		rreq->netfs_ops	= ops;
-		rreq->netfs_priv = netfs_priv;
-		rreq->inode	= file_inode(file);
-		rreq->i_size	= i_size_read(rreq->inode);
+		rreq->mapping	= mapping;
+		rreq->inode	= inode;
+		rreq->netfs_ops	= ctx->ops;
+		rreq->i_size	= i_size_read(inode);
 		rreq->debug_id	= atomic_inc_return(&debug_ids);
 		xa_init(&rreq->buffer);
 		INIT_LIST_HEAD(&rreq->subrequests);
 		INIT_WORK(&rreq->work, netfs_rreq_work);
 		refcount_set(&rreq->usage, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		ops->init_rreq(rreq, file);
+		ctx->ops->init_rreq(rreq, file);
 		netfs_stat(&netfs_n_rh_rreq);
 	}
 
@@ -971,8 +971,6 @@ static int netfs_rreq_set_up_buffer(struct netfs_read_request *rreq,
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
  *
  * Fulfil a readahead request by drawing data from the cache if possible, or
  * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
@@ -980,34 +978,31 @@ static int netfs_rreq_set_up_buffer(struct netfs_read_request *rreq,
  * readahead window can be expanded in either direction to a more convenient
  * alighment for RPC efficiency or to make storage in the cache feasible.
  *
- * The calling netfs must provide a table of operations, only one of which,
- * issue_op, is mandatory.  It may also be passed a private token, which will
- * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup().
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
  */
-void netfs_readahead(struct readahead_control *ractl,
-		     const struct netfs_read_request_ops *ops,
-		     void *netfs_priv)
+void netfs_readahead(struct readahead_control *ractl)
 {
 	struct netfs_read_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(ractl->mapping->host);
 	unsigned int debug_index = 0;
 	int ret;
 
 	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
 
 	if (readahead_count(ractl) == 0)
-		goto cleanup;
+		return;
 
-	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
+	rreq = netfs_alloc_read_request(ractl->mapping, ractl->file);
 	if (!rreq)
-		goto cleanup;
-	rreq->mapping	= ractl->mapping;
+		return;
 	rreq->start	= readahead_pos(ractl);
 	rreq->len	= readahead_length(ractl);
 
-	if (ops->begin_cache_operation) {
-		ret = ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto cleanup_free;
 	}
@@ -1039,10 +1034,6 @@ void netfs_readahead(struct readahead_control *ractl,
 cleanup_free:
 	netfs_put_read_request(rreq, false);
 	return;
-cleanup:
-	if (netfs_priv)
-		ops->cleanup(ractl->mapping, netfs_priv);
-	return;
 }
 EXPORT_SYMBOL(netfs_readahead);
 
@@ -1050,43 +1041,34 @@ EXPORT_SYMBOL(netfs_readahead);
  * netfs_readpage - Helper to manage a readpage request
  * @file: The file to read from
  * @page: The page to read
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
  *
  * Fulfil a readpage request by drawing data from the cache if possible, or the
  * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requests
  * from different sources will get munged together.
  *
- * The calling netfs must provide a table of operations, only one of which,
- * issue_op, is mandatory.  It may also be passed a private token, which will
- * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup().
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
  */
-int netfs_readpage(struct file *file,
-		   struct page *page,
-		   const struct netfs_read_request_ops *ops,
-		   void *netfs_priv)
+int netfs_readpage(struct file *file, struct page *page)
 {
+	struct address_space *mapping = page_file_mapping(page);
 	struct netfs_read_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
 	unsigned int debug_index = 0;
 	int ret;
 
 	_enter("%lx", page_index(page));
 
-	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
-	if (!rreq) {
-		if (netfs_priv)
-			ops->cleanup(netfs_priv, page_file_mapping(page));
-		unlock_page(page);
-		return -ENOMEM;
-	}
-	rreq->mapping	= page_file_mapping(page);
+	rreq = netfs_alloc_read_request(mapping, file);
+	if (!rreq)
+		goto nomem;
 	rreq->start	= page_file_offset(page);
 	rreq->len	= thp_size(page);
 
-	if (ops->begin_cache_operation) {
-		ret = ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS) {
 			unlock_page(page);
 			goto out;
@@ -1128,6 +1110,9 @@ int netfs_readpage(struct file *file,
 out:
 	netfs_put_read_request(rreq, false);
 	return ret;
+nomem:
+	unlock_page(page);
+	return -ENOMEM;
 }
 EXPORT_SYMBOL(netfs_readpage);
 
@@ -1136,6 +1121,7 @@ EXPORT_SYMBOL(netfs_readpage);
  * @page: page being prepared
  * @pos: starting position for the write
  * @len: length of write
+ * @always_fill: T if the page should always be completely filled/cleared
  *
  * In some cases, write_begin doesn't need to read at all:
  * - full page write
@@ -1145,14 +1131,24 @@ EXPORT_SYMBOL(netfs_readpage);
  * If any of these criteria are met, then zero out the unwritten parts
  * of the page and return true. Otherwise, return false.
  */
-static bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
+static bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len,
+				 bool always_fill)
 {
 	struct inode *inode = page->mapping->host;
 	loff_t i_size = i_size_read(inode);
 	size_t offset = offset_in_thp(page, pos);
+	size_t plen = thp_size(page);
+
+	if (unlikely(always_fill)) {
+		if (pos - offset + len <= i_size)
+			return false; /* Page entirely before EOF */
+		zero_user_segment(page, 0, plen);
+		SetPageUptodate(page);
+		return true;
+	}
 
 	/* Full page write */
-	if (offset == 0 && len >= thp_size(page))
+	if (offset == 0 && len >= plen)
 		return true;
 
 	/* pos beyond last page in the file */
@@ -1165,7 +1161,7 @@ static bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
 
 	return false;
 zero_out:
-	zero_user_segments(page, 0, offset, offset + len, thp_size(page));
+	zero_user_segments(page, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -1178,8 +1174,6 @@ static bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
  * @flags: AOP_* flags
  * @_page: Where to put the resultant page
  * @_fsdata: Place for the netfs to store a cookie
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
  *
  * Pre-read data for a write-begin request by drawing data from the cache if
  * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
@@ -1198,17 +1192,19 @@ static bool netfs_skip_page_read(struct page *page, loff_t pos, size_t len)
  * should go ahead; unlock the page and return -EAGAIN to cause the page to be
  * regot; or return an error.
  *
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
+ *
  * This is usable whether or not caching is enabled.
  */
 int netfs_write_begin(struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, unsigned int flags,
-		      struct page **_page, void **_fsdata,
-		      const struct netfs_read_request_ops *ops,
-		      void *netfs_priv)
+		      struct page **_page, void **_fsdata)
 {
 	struct netfs_read_request *rreq;
 	struct page *page, *xpage;
 	struct inode *inode = file_inode(file);
+	struct netfs_i_context *ctx = netfs_i_context(inode);
 	unsigned int debug_index = 0;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
@@ -1220,9 +1216,9 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	if (!page)
 		return -ENOMEM;
 
-	if (ops->check_write_begin) {
+	if (ctx->ops->check_write_begin) {
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
-		ret = ops->check_write_begin(file, pos, len, page, _fsdata);
+		ret = ctx->ops->check_write_begin(file, pos, len, page, _fsdata);
 		if (ret < 0) {
 			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			if (ret == -EAGAIN)
@@ -1238,25 +1234,23 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
-	if (!ops->is_cache_enabled(inode) &&
-	    netfs_skip_page_read(page, pos, len)) {
+	if (!netfs_is_cache_enabled(inode) &&
+	    netfs_skip_page_read(page, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_page_no_wait;
 	}
 
 	ret = -ENOMEM;
-	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
+	rreq = netfs_alloc_read_request(mapping, file);
 	if (!rreq)
 		goto error;
-	rreq->mapping		= page->mapping;
 	rreq->start		= page_offset(page);
 	rreq->len		= thp_size(page);
 	rreq->no_unlock_page	= page->index;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);
-	netfs_priv = NULL;
 
-	if (ops->begin_cache_operation) {
-		ret = ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
 		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 			goto error_put;
 	}
@@ -1314,8 +1308,6 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	if (ret < 0)
 		goto error;
 have_page_no_wait:
-	if (netfs_priv)
-		ops->cleanup(netfs_priv, mapping);
 	*_page = page;
 	_leave(" = 0");
 	return 0;
@@ -1325,8 +1317,6 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 error:
 	unlock_page(page);
 	put_page(page);
-	if (netfs_priv)
-		ops->cleanup(netfs_priv, mapping);
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 9ae538c85378..5510a7a14a40 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -7,7 +7,6 @@
 
 #include <linux/export.h>
 #include <linux/seq_file.h>
-#include <linux/netfs.h>
 #include "internal.h"
 
 atomic_t netfs_n_rh_readahead;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 815001fe7a76..35bcd916c3a0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -157,14 +157,25 @@ struct netfs_read_request {
 #define NETFS_RREQ_DONT_UNLOCK_PAGES	3	/* Don't unlock the pages on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
-	const struct netfs_read_request_ops *netfs_ops;
+	const struct netfs_request_ops *netfs_ops;
+};
+
+/*
+ * Per-inode description.  This must be directly after the inode struct.
+ */
+struct netfs_i_context {
+	const struct netfs_request_ops *ops;
+#ifdef CONFIG_FSCACHE
+	struct fscache_cookie	*cache;
+#endif
+	unsigned long		flags;
+#define NETFS_ICTX_NEW_CONTENT	0		/* Set if file has new content (create/trunc-0) */
 };
 
 /*
  * Operations the network filesystem can/must provide to the helpers.
  */
-struct netfs_read_request_ops {
-	bool (*is_cache_enabled)(struct inode *inode);
+struct netfs_request_ops {
 	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_read_request *rreq);
 	void (*expand_readahead)(struct netfs_read_request *rreq);
@@ -218,20 +229,49 @@ struct netfs_cache_ops {
 };
 
 struct readahead_control;
-extern void netfs_readahead(struct readahead_control *,
-			    const struct netfs_read_request_ops *,
-			    void *);
-extern int netfs_readpage(struct file *,
-			  struct page *,
-			  const struct netfs_read_request_ops *,
-			  void *);
+extern void netfs_readahead(struct readahead_control *);
+extern int netfs_readpage(struct file *, struct page *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct page **,
-			     void **,
-			     const struct netfs_read_request_ops *,
-			     void *);
+			     void **);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
 
+/**
+ * netfs_i_context - Get the netfs inode context from the inode
+ * @inode: The inode to query
+ *
+ * This function gets the netfs lib inode context from the network filesystem's
+ * inode.  It expects it to follow on directly from the VFS inode struct.
+ */
+static inline struct netfs_i_context *netfs_i_context(struct inode *inode)
+{
+	return (struct netfs_i_context *)(inode + 1);
+}
+
+static inline void netfs_i_context_init(struct inode *inode,
+					const struct netfs_request_ops *ops)
+{
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+
+	ctx->ops = ops;
+}
+
+/**
+ * netfs_i_cookie - Get the cache cookie from the inode
+ * @inode: The inode to query
+ *
+ * Get the caching cookie (if enabled) from the network filesystem's inode.
+ */
+static inline struct fscache_cookie *netfs_i_cookie(struct inode *inode)
+{
+#ifdef CONFIG_FSCACHE
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+	return ctx->cache;
+#else
+	return NULL;
+#endif
+}
+
 #endif /* _LINUX_NETFS_H */


