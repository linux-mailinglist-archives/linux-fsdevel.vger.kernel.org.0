Return-Path: <linux-fsdevel+bounces-9458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B168414EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EC61F2591B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024F15AADB;
	Mon, 29 Jan 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Or9KKQbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B035159560;
	Mon, 29 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562416; cv=none; b=noSmrtN383DTT0ORB6kbLZMzuLfh70cCA/U6X6dd51NAJvtdvI1pN/O+prOOHDxHzjn1HhVtEJt85NWoNgmXF5cEVpLaEZvPoA2+QE7vOVRrrgM+3rHWVLdvb2NljQIpq89ASm9hUF0ZhcDEADN07KhBATY1EkB4GCqVf3m9elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562416; c=relaxed/simple;
	bh=qE6d84dw/RHBezptIMoCUSoZjf7hEPQsPy+jBZ/P/F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkdhiQCe55PgMBfERtOheghaATa20KcDVgBWTXq4xAPfYqTXKbmYdRDGB/kHT1lMLT5xTO2mNQaffPUgG2WDZQcdsWUnTzDcj++zTRUi+nMEztYcVNdMsoPIgQBZC5ib5KegkJ3AGeRgKoe84LEn4cqoG48/19H+ma6kOxaV5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Or9KKQbE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562411;
	bh=qE6d84dw/RHBezptIMoCUSoZjf7hEPQsPy+jBZ/P/F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Or9KKQbE01DFHpcvYQEjceuM4WZSaWEOvWctam+nWYmhRaiKWaY7y4HtQ+LAL/ra6
	 WnhCkdYwWZj1fXClvt1jc4U9MGLixIqC+hCRIm0pnM+eeQFIiNsW9gPQLzahPKQZip
	 vRvFUs1OQNbZHK4eqX9cfuOZsbhSkZk4y/WO9vHGSkKQ21R8iTopGgKUiPYn3cVKKy
	 NY2XTs9e84eCiZRaD6C5ObMVDsbSWAz48qTfj2g5hx+kNTA/IE6wmKHn6763C2ptlI
	 DRA6nvmFJIFA0Neet56IfoOGTJ7CVKcNye2U8woci47wLQIqX7JopQB0ezWkW1cJQy
	 Ap1Rsna8wszfQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17v02t7zVfq;
	Mon, 29 Jan 2024 16:06:50 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 6/7] fuse: Introduce fuse_dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:30 -0500
Message-Id: <20240129210631.193493-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() in addition to IS_ENABLED(CONFIG_FUSE_DAX) to
validate whether CONFIG_FUSE_DAX is enabled and the architecture does
not have virtually aliased caches.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches
(ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
---
 fs/fuse/file.c      |  2 +-
 fs/fuse/fuse_i.h    | 36 +++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c     | 47 +++++++++++++++++++++++----------------------
 fs/fuse/virtio_fs.c |  4 ++--
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..133ac8524064 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3247,6 +3247,6 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	init_waitqueue_head(&fi->page_waitq);
 	fi->writepages = RB_ROOT;
 
-	if (IS_ENABLED(CONFIG_FUSE_DAX))
+	if (fuse_dax_is_supported())
 		fuse_dax_inode_init(inode, flags);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..1cbe37106669 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -31,6 +31,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/dax.h>
 
 /** Default max number of pages that can be used in a single read request */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
@@ -979,6 +980,38 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_FUSE_DAX
+static inline struct fuse_inode_dax *fuse_inode_get_dax(struct fuse_inode *inode)
+{
+	return inode->dax;
+}
+
+static inline enum fuse_dax_mode fuse_conn_get_dax_mode(struct fuse_conn *fc)
+{
+	return fc->dax_mode;
+}
+
+static inline struct fuse_conn_dax *fuse_conn_get_dax(struct fuse_conn *fc)
+{
+	return fc->dax;
+}
+#else
+static inline struct fuse_inode_dax *fuse_inode_get_dax(struct fuse_inode *inode)
+{
+	return NULL;
+}
+
+static inline enum fuse_dax_mode fuse_conn_get_dax_mode(struct fuse_conn *fc)
+{
+	return FUSE_DAX_INODE_DEFAULT;
+}
+
+static inline struct fuse_conn_dax *fuse_conn_get_dax(struct fuse_conn *fc)
+{
+	return NULL;
+}
+#endif
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
@@ -1324,7 +1357,8 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
 
-#define FUSE_IS_DAX(inode) (IS_ENABLED(CONFIG_FUSE_DAX) && IS_DAX(inode))
+#define fuse_dax_is_supported()	(IS_ENABLED(CONFIG_FUSE_DAX) && dax_is_supported())
+#define FUSE_IS_DAX(inode) (fuse_dax_is_supported() && IS_DAX(inode))
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..030e6ce5486d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -108,7 +108,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (!fi->forget)
 		goto out_free;
 
-	if (IS_ENABLED(CONFIG_FUSE_DAX) && !fuse_dax_inode_alloc(sb, fi))
+	if (fuse_dax_is_supported() && !fuse_dax_inode_alloc(sb, fi))
 		goto out_free_forget;
 
 	return &fi->inode;
@@ -126,9 +126,8 @@ static void fuse_free_inode(struct inode *inode)
 
 	mutex_destroy(&fi->mutex);
 	kfree(fi->forget);
-#ifdef CONFIG_FUSE_DAX
-	kfree(fi->dax);
-#endif
+	if (fuse_dax_is_supported())
+		kfree(fuse_inode_get_dax(fi));
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -361,7 +360,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 
-	if (IS_ENABLED(CONFIG_FUSE_DAX))
+	if (fuse_dax_is_supported())
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
@@ -856,14 +855,16 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
 	}
-#ifdef CONFIG_FUSE_DAX
-	if (fc->dax_mode == FUSE_DAX_ALWAYS)
-		seq_puts(m, ",dax=always");
-	else if (fc->dax_mode == FUSE_DAX_NEVER)
-		seq_puts(m, ",dax=never");
-	else if (fc->dax_mode == FUSE_DAX_INODE_USER)
-		seq_puts(m, ",dax=inode");
-#endif
+	if (fuse_dax_is_supported()) {
+		enum fuse_dax_mode dax_mode = fuse_conn_get_dax_mode(fc);
+
+		if (dax_mode == FUSE_DAX_ALWAYS)
+			seq_puts(m, ",dax=always");
+		else if (dax_mode == FUSE_DAX_NEVER)
+			seq_puts(m, ",dax=never");
+		else if (dax_mode == FUSE_DAX_INODE_USER)
+			seq_puts(m, ",dax=inode");
+	}
 
 	return 0;
 }
@@ -936,7 +937,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		struct fuse_iqueue *fiq = &fc->iq;
 		struct fuse_sync_bucket *bucket;
 
-		if (IS_ENABLED(CONFIG_FUSE_DAX))
+		if (fuse_dax_is_supported())
 			fuse_dax_conn_free(fc);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
@@ -1264,7 +1265,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					min_t(unsigned int, fc->max_pages_limit,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
-			if (IS_ENABLED(CONFIG_FUSE_DAX)) {
+			if (fuse_dax_is_supported()) {
 				if (flags & FUSE_MAP_ALIGNMENT &&
 				    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
 					ok = false;
@@ -1331,12 +1332,12 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
-#ifdef CONFIG_FUSE_DAX
-	if (fm->fc->dax)
-		flags |= FUSE_MAP_ALIGNMENT;
-	if (fuse_is_inode_dax_mode(fm->fc->dax_mode))
-		flags |= FUSE_HAS_INODE_DAX;
-#endif
+	if (fuse_dax_is_supported()) {
+		if (fuse_conn_get_dax(fm->fc))
+			flags |= FUSE_MAP_ALIGNMENT;
+		if (fuse_is_inode_dax_mode(fuse_conn_get_dax_mode(fm->fc)))
+			flags |= FUSE_HAS_INODE_DAX;
+	}
 	if (fm->fc->auto_submounts)
 		flags |= FUSE_SUBMOUNTS;
 
@@ -1643,7 +1644,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	sb->s_subtype = ctx->subtype;
 	ctx->subtype = NULL;
-	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
+	if (fuse_dax_is_supported()) {
 		err = fuse_dax_conn_alloc(fc, ctx->dax_mode, ctx->dax_dev);
 		if (err)
 			goto err;
@@ -1709,7 +1710,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (fud)
 		fuse_dev_free(fud);
  err_free_dax:
-	if (IS_ENABLED(CONFIG_FUSE_DAX))
+	if (fuse_dax_is_supported())
 		fuse_dax_conn_free(fc);
  err:
 	return err;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..99f8f2a18ee4 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -801,7 +801,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	struct dev_pagemap *pgmap;
 	bool have_cache;
 
-	if (!IS_ENABLED(CONFIG_FUSE_DAX))
+	if (fuse_dax_is_supported())
 		return 0;
 
 	/* Get cache region */
@@ -1366,7 +1366,7 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
 	/* Stop dax worker. Soon evict_inodes() will be called which
 	 * will free all memory ranges belonging to all inodes.
 	 */
-	if (IS_ENABLED(CONFIG_FUSE_DAX))
+	if (fuse_dax_is_supported())
 		fuse_dax_cancel_work(fc);
 
 	/* Stop forget queue. Soon destroy will be sent */
-- 
2.39.2


