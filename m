Return-Path: <linux-fsdevel+bounces-61504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EEEB58948
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087AF1B25291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F91B5EC8;
	Tue, 16 Sep 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUt1k+RN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24891AAE28;
	Tue, 16 Sep 2025 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982432; cv=none; b=LzFuO7zFzzK2zMMbp6xqjjuUisqFBr6C2J1u+2v5jqb1HohgbOHa3InT8Pp+evesbNqOg7Uarg+unWRxgUXne6OGM+xMy8GBSxhb3+w6NKsmDUGaR3dTaNyALKVO40bOGIXwr9riCHqbjKf0is/GXEyoVa/wjJXGKR0+gErxovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982432; c=relaxed/simple;
	bh=youpep7M63m7nJook+erxMJg5Q55c3y6rQ842QdeGAE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6/oQHlJgJ8Gmd97IZrwxi5XeL87X6uQIyN1l4eNgXT6BDgbrNd+x521CB6IiRTMFkdi4enlstK4MMqbsh4ELJsTuZcCKp7vNgP3tI4lnngY22QyQLIldFO42rR3goZ/ot/sa6UvoT0yiLmP5hBGLtJcIRqqOxGxZoRD1DtCEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUt1k+RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2802BC4CEF1;
	Tue, 16 Sep 2025 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982432;
	bh=youpep7M63m7nJook+erxMJg5Q55c3y6rQ842QdeGAE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lUt1k+RNBV4xbId4vZ4IZuoOgzU7w1Iqj+LIjYrlFNNxVhaKgXJD4fHD7ecMPQ+7S
	 5/NMgOPp/zKfRRg23aIvKL2phe/Z2qf9Fe3TGPWJWgX5Cg53FDy3ljTAYhK5dcqAgL
	 OB+TFyGA1bEPpB3/fXrB6HUmSwVlvOyZBy9HLMzM+eFJya6PL3Wlt6ze/CDi4ftp9O
	 BKo4s241j9RbMvQJILBcUXpPNkDdFfejpy3bjtSsK89uHk6kbzud2GE41n3IqC47NM
	 ap5Hk76V8C1XUd2cahgHBYi1V7+T8PcmHscJJuEWWEXg40GEGcpKONP+pkZ6lyF6Kz
	 B8bpuqip28pcw==
Date: Mon, 15 Sep 2025 17:27:11 -0700
Subject: [PATCH 2/5] fuse: move the backing file idr and code into a new
 source file
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: amir73il@gmail.com, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
 John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 joannelkoong@gmail.com
Message-ID: <175798150753.382479.16281159359397027377.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

iomap support for fuse is also going to want the ability to attach
backing files to a fuse filesystem.  Move the fuse_backing code into a
separate file so that both can use it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/fuse_i.h      |   47 +++++++------
 fs/fuse/Makefile      |    2 -
 fs/fuse/backing.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/passthrough.c |  163 ---------------------------------------------
 4 files changed, 208 insertions(+), 183 deletions(-)
 create mode 100644 fs/fuse/backing.c


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 02f0138e2fe443..52db609e63eb54 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1570,29 +1570,11 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
-/* passthrough.c */
-static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
-{
-#ifdef CONFIG_FUSE_PASSTHROUGH
-	return READ_ONCE(fi->fb);
-#else
-	return NULL;
-#endif
-}
-
-static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
-							  struct fuse_backing *fb)
-{
-#ifdef CONFIG_FUSE_PASSTHROUGH
-	return xchg(&fi->fb, fb);
-#else
-	return NULL;
-#endif
-}
-
+/* backing.c */
 #ifdef CONFIG_FUSE_PASSTHROUGH
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1603,6 +1585,11 @@ static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 static inline void fuse_backing_put(struct fuse_backing *fb)
 {
 }
+static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
+						       int backing_id)
+{
+	return NULL;
+}
 #endif
 
 void fuse_backing_files_init(struct fuse_conn *fc);
@@ -1610,6 +1597,26 @@ void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
+/* passthrough.c */
+static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return READ_ONCE(fi->fb);
+#else
+	return NULL;
+#endif
+}
+
+static inline struct fuse_backing *fuse_inode_backing_set(struct fuse_inode *fi,
+							  struct fuse_backing *fb)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return xchg(&fi->fb, fb);
+#else
+	return NULL;
+#endif
+}
+
 struct fuse_backing *fuse_passthrough_open(struct file *file,
 					   struct inode *inode,
 					   int backing_id);
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3f0f312a31c1cc..8ddd8f0b204ee5 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
-fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
new file mode 100644
index 00000000000000..4afda419dd1416
--- /dev/null
+++ b/fs/fuse/backing.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE passthrough to backing file.
+ *
+ * Copyright (c) 2023 CTERA Networks.
+ */
+
+#include "fuse_i.h"
+
+#include <linux/file.h>
+
+struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
+{
+	if (fb && refcount_inc_not_zero(&fb->count))
+		return fb;
+	return NULL;
+}
+
+static void fuse_backing_free(struct fuse_backing *fb)
+{
+	pr_debug("%s: fb=0x%p\n", __func__, fb);
+
+	if (fb->file)
+		fput(fb->file);
+	put_cred(fb->cred);
+	kfree_rcu(fb, rcu);
+}
+
+void fuse_backing_put(struct fuse_backing *fb)
+{
+	if (fb && refcount_dec_and_test(&fb->count))
+		fuse_backing_free(fb);
+}
+
+void fuse_backing_files_init(struct fuse_conn *fc)
+{
+	idr_init(&fc->backing_files_map);
+}
+
+static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	int id;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->lock);
+	/* FIXME: xarray might be space inefficient */
+	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	spin_unlock(&fc->lock);
+	idr_preload_end();
+
+	WARN_ON_ONCE(id == 0);
+	return id;
+}
+
+static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
+						   int id)
+{
+	struct fuse_backing *fb;
+
+	spin_lock(&fc->lock);
+	fb = idr_remove(&fc->backing_files_map, id);
+	spin_unlock(&fc->lock);
+
+	return fb;
+}
+
+static int fuse_backing_id_free(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+
+	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+	fuse_backing_free(fb);
+	return 0;
+}
+
+void fuse_backing_files_free(struct fuse_conn *fc)
+{
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_destroy(&fc->backing_files_map);
+}
+
+int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
+{
+	struct file *file;
+	struct super_block *backing_sb;
+	struct fuse_backing *fb = NULL;
+	int res;
+
+	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	res = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	res = -EINVAL;
+	if (map->flags || map->padding)
+		goto out;
+
+	file = fget_raw(map->fd);
+	res = -EBADF;
+	if (!file)
+		goto out;
+
+	/* read/write/splice/mmap passthrough only relevant for regular files */
+	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
+	if (!d_is_reg(file->f_path.dentry))
+		goto out_fput;
+
+	backing_sb = file_inode(file)->i_sb;
+	res = -ELOOP;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		goto out_fput;
+
+	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
+	res = -ENOMEM;
+	if (!fb)
+		goto out_fput;
+
+	fb->file = file;
+	fb->cred = prepare_creds();
+	refcount_set(&fb->count, 1);
+
+	res = fuse_backing_id_alloc(fc, fb);
+	if (res < 0) {
+		fuse_backing_free(fb);
+		fb = NULL;
+	}
+
+out:
+	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
+
+	return res;
+
+out_fput:
+	fput(file);
+	goto out;
+}
+
+int fuse_backing_close(struct fuse_conn *fc, int backing_id)
+{
+	struct fuse_backing *fb = NULL;
+	int err;
+
+	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	err = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	err = -EINVAL;
+	if (backing_id <= 0)
+		goto out;
+
+	err = -ENOENT;
+	fb = fuse_backing_id_remove(fc, backing_id);
+	if (!fb)
+		goto out;
+
+	fuse_backing_put(fb);
+	err = 0;
+out:
+	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
+
+	return err;
+}
+
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
+{
+	struct fuse_backing *fb;
+
+	rcu_read_lock();
+	fb = idr_find(&fc->backing_files_map, backing_id);
+	fb = fuse_backing_get(fb);
+	rcu_read_unlock();
+
+	return fb;
+}
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index eb97ac009e75d9..e0b8d885bc81f3 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -144,163 +144,6 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	return backing_file_mmap(backing_file, vma, &ctx);
 }
 
-struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
-{
-	if (fb && refcount_inc_not_zero(&fb->count))
-		return fb;
-	return NULL;
-}
-
-static void fuse_backing_free(struct fuse_backing *fb)
-{
-	pr_debug("%s: fb=0x%p\n", __func__, fb);
-
-	if (fb->file)
-		fput(fb->file);
-	put_cred(fb->cred);
-	kfree_rcu(fb, rcu);
-}
-
-void fuse_backing_put(struct fuse_backing *fb)
-{
-	if (fb && refcount_dec_and_test(&fb->count))
-		fuse_backing_free(fb);
-}
-
-void fuse_backing_files_init(struct fuse_conn *fc)
-{
-	idr_init(&fc->backing_files_map);
-}
-
-static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
-{
-	int id;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock(&fc->lock);
-	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
-	spin_unlock(&fc->lock);
-	idr_preload_end();
-
-	WARN_ON_ONCE(id == 0);
-	return id;
-}
-
-static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
-						   int id)
-{
-	struct fuse_backing *fb;
-
-	spin_lock(&fc->lock);
-	fb = idr_remove(&fc->backing_files_map, id);
-	spin_unlock(&fc->lock);
-
-	return fb;
-}
-
-static int fuse_backing_id_free(int id, void *p, void *data)
-{
-	struct fuse_backing *fb = p;
-
-	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
-	fuse_backing_free(fb);
-	return 0;
-}
-
-void fuse_backing_files_free(struct fuse_conn *fc)
-{
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
-	idr_destroy(&fc->backing_files_map);
-}
-
-int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
-{
-	struct file *file;
-	struct super_block *backing_sb;
-	struct fuse_backing *fb = NULL;
-	int res;
-
-	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
-
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	res = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
-		goto out;
-
-	res = -EINVAL;
-	if (map->flags || map->padding)
-		goto out;
-
-	file = fget_raw(map->fd);
-	res = -EBADF;
-	if (!file)
-		goto out;
-
-	/* read/write/splice/mmap passthrough only relevant for regular files */
-	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
-	if (!d_is_reg(file->f_path.dentry))
-		goto out_fput;
-
-	backing_sb = file_inode(file)->i_sb;
-	res = -ELOOP;
-	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
-		goto out_fput;
-
-	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
-	res = -ENOMEM;
-	if (!fb)
-		goto out_fput;
-
-	fb->file = file;
-	fb->cred = prepare_creds();
-	refcount_set(&fb->count, 1);
-
-	res = fuse_backing_id_alloc(fc, fb);
-	if (res < 0) {
-		fuse_backing_free(fb);
-		fb = NULL;
-	}
-
-out:
-	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
-
-	return res;
-
-out_fput:
-	fput(file);
-	goto out;
-}
-
-int fuse_backing_close(struct fuse_conn *fc, int backing_id)
-{
-	struct fuse_backing *fb = NULL;
-	int err;
-
-	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
-
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	err = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
-		goto out;
-
-	err = -EINVAL;
-	if (backing_id <= 0)
-		goto out;
-
-	err = -ENOENT;
-	fb = fuse_backing_id_remove(fc, backing_id);
-	if (!fb)
-		goto out;
-
-	fuse_backing_put(fb);
-	err = 0;
-out:
-	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
-
-	return err;
-}
-
 /*
  * Setup passthrough to a backing file.
  *
@@ -320,12 +163,8 @@ struct fuse_backing *fuse_passthrough_open(struct file *file,
 	if (backing_id <= 0)
 		goto out;
 
-	rcu_read_lock();
-	fb = idr_find(&fc->backing_files_map, backing_id);
-	fb = fuse_backing_get(fb);
-	rcu_read_unlock();
-
 	err = -ENOENT;
+	fb = fuse_backing_lookup(fc, backing_id);
 	if (!fb)
 		goto out;
 


