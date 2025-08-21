Return-Path: <linux-fsdevel+bounces-58446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7934B2E9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE9C5C85A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD821E493C;
	Thu, 21 Aug 2025 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8M5F3FM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06EC2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737629; cv=none; b=MhF22AuqAwFJXNxawwge86tIzOys0Vdyq1IpRX8EcCWPCky1lSc6TVgoLHF+lD8+Jm7PZ5siZmUSk2tsHgQd2qDwEB/46h8NDjKw2pIBo8eTuhz75xB5KLZFGhNHqIHPpWFX6HlfCcou2PNYVQ84KcyLe4RTkOBbz+p4LYgqTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737629; c=relaxed/simple;
	bh=9nrD5KCYt1Uv9BFSd56iqv/atX2M+gIaoGPNPdx2jgw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyOouVTOCXCWMrcAGBCx5JhLpnVqDxvpqrsfYNfobkgXf+SFEb7Q6G2yRXZRBy513ANYW0mKKkL82B7sN3GUQQ8U8k9VniF0fXuuyybDKGdCKxncxRIKHpzycEZzYBs+A3YOa+zMiFmFVCD9KDLhp85G/CB452J/TiLcYs9uDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8M5F3FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ED2C4CEE7;
	Thu, 21 Aug 2025 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737628;
	bh=9nrD5KCYt1Uv9BFSd56iqv/atX2M+gIaoGPNPdx2jgw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o8M5F3FM+Y/iT+mP4ZqA/CklpImqkefGtwL4OD/eeQhoSsKU2oNj2/ni3XybrIXos
	 zFBQh2y8P5BZ3nqQXtHdsy+lzBC96sqK9cBvkpcxijTMxrXtbSrk69rBqjYMxE8wUK
	 34AZ2Se/0fl6UpByPekIi0wfKn2pSfhEWqHZ0SmW9blrVXb/r2x+BKg7zRBt8rGsxS
	 N7J0eJNXRQalGRM7XUr1PKPIuox0qqvZKBesLRY/MBAb6CvZEdr1coFfD1FseK/cZ6
	 hi5BHeMO5vSnH9bKLwUkizggPn7+3srjdqvfMwmxVx/tPrgY+UjzkztGKhghDepMlg
	 jn91C774go3NA==
Date: Wed, 20 Aug 2025 17:53:48 -0700
Subject: [PATCH 05/23] fuse: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709222.17510.17568403217413241879.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In preparation for iomap, move the passthrough-specific validation code
back to passthrough.c and create a new Kconfig item for conditional
compilation of backing.c.  In the next patch, iomap will share the
backing structures.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h      |   14 ++++++
 fs/fuse/fuse_trace.h  |   35 ++++++++++++++++
 fs/fuse/Kconfig       |    4 ++
 fs/fuse/Makefile      |    3 +
 fs/fuse/backing.c     |  106 +++++++++++++++++++++++++++++++++++++------------
 fs/fuse/dev.c         |    4 +-
 fs/fuse/inode.c       |    4 +-
 fs/fuse/passthrough.c |   28 +++++++++++++
 8 files changed, 165 insertions(+), 33 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2be2cbdf060536..1762517a1b99c8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -958,7 +958,7 @@ struct fuse_conn {
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
 
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
@@ -1536,7 +1536,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
 /* backing.c */
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
@@ -1596,6 +1596,16 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 #endif
 }
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
+int fuse_passthrough_backing_open(struct fuse_conn *fc,
+				  struct fuse_backing *fb);
+int fuse_passthrough_backing_close(struct fuse_conn *fc,
+				   struct fuse_backing *fb);
+#else
+# define fuse_passthrough_backing_open(...)	(-EOPNOTSUPP)
+# define fuse_passthrough_backing_close(...)	(-EOPNOTSUPP)
+#endif
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 2389072b734636..660d9b5206a175 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -174,6 +174,41 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+#ifdef CONFIG_FUSE_BACKING
+TRACE_EVENT(fuse_backing_class,
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
+		 const struct fuse_backing *fb),
+
+	TP_ARGS(fc, idx, fb),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(unsigned int,		idx)
+		__field(unsigned long,		ino)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = file_inode(fb->file);
+
+		__entry->connection	=	fc->dev;
+		__entry->idx		=	idx;
+		__entry->ino		=	inode->i_ino;
+	),
+
+	TP_printk("connection %u idx %u ino 0x%lx",
+		  __entry->connection,
+		  __entry->idx,
+		  __entry->ino)
+);
+#define DEFINE_FUSE_BACKING_EVENT(name)		\
+DEFINE_EVENT(fuse_backing_class, name,		\
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
+		 const struct fuse_backing *fb), \
+	TP_ARGS(fc, idx, fb))
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
+#endif
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 
 /* tracepoint boilerplate so we don't have to keep doing this */
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 6be74396ef5198..ebb9a2d76b532e 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
 	default y
 	depends on FUSE_FS
 	select FS_STACK
+	select FUSE_BACKING
 	help
 	  This allows bypassing FUSE server by mapping specific FUSE operations
 	  to be performed directly on a backing file.
 
 	  If you want to allow passthrough operations, answer Y.
 
+config FUSE_BACKING
+	bool
+
 config FUSE_IOMAP
 	bool "FUSE file IO over iomap"
 	default y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index c79f786d0c90c3..27be39317701d6 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -14,7 +14,8 @@ fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
 fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
-fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_FUSE_BACKING) += backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 fuse-$(CONFIG_FUSE_IOMAP) += file_iomap.o
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index ddb23b7400fc72..c128bed95a76b8 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/file.h>
 
@@ -81,16 +82,14 @@ void fuse_backing_files_free(struct fuse_conn *fc)
 
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 {
-	struct file *file;
-	struct super_block *backing_sb;
+	struct file *file = NULL;
 	struct fuse_backing *fb = NULL;
-	int res;
+	int res, passthrough_res;
 
 	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	res = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+	if (!fc->passthrough)
 		goto out;
 
 	res = -EINVAL;
@@ -102,46 +101,68 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!file)
 		goto out;
 
-	backing_sb = file_inode(file)->i_sb;
-	res = -ELOOP;
-	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
-		goto out_fput;
-
 	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
 	res = -ENOMEM;
 	if (!fb)
-		goto out_fput;
+		goto out_file;
 
+	/* fb now owns file */
 	fb->file = file;
+	file = NULL;
 	fb->cred = prepare_creds();
 	refcount_set(&fb->count, 1);
 
+	/*
+	 * Each _backing_open function should either:
+	 *
+	 * 1. Take a ref to fb if it wants the file and return 0.
+	 * 2. Return 0 without taking a ref if the backing file isn't needed.
+	 * 3. Return an errno explaining why it couldn't attach.
+	 *
+	 * If at least one subsystem bumps the reference count to open it,
+	 * we'll install it into the index and return the index.  If nobody
+	 * opens the file, the error code will be passed up.  EPERM is the
+	 * default.
+	 */
+	passthrough_res = fuse_passthrough_backing_open(fc, fb);
+
+	if (refcount_read(&fb->count) < 2) {
+		if (passthrough_res)
+			res = passthrough_res;
+		if (!res)
+			res = -EPERM;
+		goto out_fb;
+	}
+
 	res = fuse_backing_id_alloc(fc, fb);
-	if (res < 0) {
-		fuse_backing_free(fb);
-		fb = NULL;
-	}
+	if (res < 0)
+		goto out_fb;
+
+	trace_fuse_backing_open(fc, res, fb);
 
-out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
-
+	fuse_backing_put(fb);
 	return res;
 
-out_fput:
-	fput(file);
-	goto out;
+out_fb:
+	fuse_backing_free(fb);
+out_file:
+	if (file)
+		fput(file);
+out:
+	pr_debug("%s: ret=%i\n", __func__, res);
+	return res;
 }
 
 int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 {
-	struct fuse_backing *fb = NULL;
-	int err;
+	struct fuse_backing *fb = NULL, *test_fb;
+	int err, passthrough_err;
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	err = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+	if (!fc->passthrough)
 		goto out;
 
 	err = -EINVAL;
@@ -149,12 +170,45 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 		goto out;
 
 	err = -ENOENT;
-	fb = fuse_backing_id_remove(fc, backing_id);
+	fb = fuse_backing_lookup(fc, backing_id);
 	if (!fb)
 		goto out;
 
+	/*
+	 * Each _backing_close function should either:
+	 *
+	 * 1. Release the ref that it took in _backing_open and return 0.
+	 * 2. Don't release the ref if the backing file is busy, and return 0.
+	 * 2. Return an errno explaining why it couldn't detach.
+	 *
+	 * If there are no more active references to the backing file, it will
+	 * be closed and removed from the index.  If there are still active
+	 * references to the backing file other than the one we just took, the
+	 * error code will be passed up.  EBUSY is the default.
+	 */
+	passthrough_err = fuse_passthrough_backing_close(fc, fb);
+
+	if (refcount_read(&fb->count) > 1) {
+		if (passthrough_err)
+			err = passthrough_err;
+		if (!err)
+			err = -EBUSY;
+		goto out_fb;
+	}
+
+	trace_fuse_backing_close(fc, backing_id, fb);
+
+	err = -ENOENT;
+	test_fb = fuse_backing_id_remove(fc, backing_id);
+	if (!test_fb)
+		goto out_fb;
+
+	WARN_ON(fb != test_fb);
+	pr_debug("%s: fb=0x%p, err=0\n", __func__, fb);
+	fuse_backing_put(fb);
+	return 0;
+out_fb:
 	fuse_backing_put(fb);
-	err = 0;
 out:
 	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dbde17fff0cda9..31d9f006836ac1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2623,7 +2623,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	if (!fud)
 		return -EPERM;
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&map, argp, sizeof(map)))
@@ -2640,7 +2640,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (!fud)
 		return -EPERM;
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (get_user(backing_id, argp))
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9448a11c828fef..1f3f91981410aa 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -993,7 +993,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
 
 	INIT_LIST_HEAD(&fc->mounts);
@@ -1030,7 +1030,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 			WARN_ON(atomic_read(&bucket->count) != 1);
 			kfree(bucket);
 		}
-		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		if (IS_ENABLED(CONFIG_FUSE_BACKING))
 			fuse_backing_files_free(fc);
 		call_rcu(&fc->rcu, delayed_release);
 	}
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index e0b8d885bc81f3..dfc61cc4bd21af 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -197,3 +197,31 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
 	put_cred(ff->cred);
 	ff->cred = NULL;
 }
+
+int fuse_passthrough_backing_open(struct fuse_conn *fc,
+				  struct fuse_backing *fb)
+{
+	struct super_block *backing_sb;
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	backing_sb = file_inode(fb->file)->i_sb;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		return -ELOOP;
+
+	fuse_backing_get(fb);
+	return 0;
+}
+
+int fuse_passthrough_backing_close(struct fuse_conn *fc,
+				   struct fuse_backing *fb)
+{
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	fuse_backing_put(fb);
+	return 0;
+}


