Return-Path: <linux-fsdevel+bounces-66001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A628C179C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8E03ACF32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654452D3A77;
	Wed, 29 Oct 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAD0mMpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D827B34F;
	Wed, 29 Oct 2025 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698682; cv=none; b=jlFmVkxrS7BvgASAF1/CXXHCoxrP6r6lB6QjZ4vts0qcmUUQh2OWo4YDC2s0smbtLSicsukPhuWfiHrwC5BvOBFB/YCtPSBmhI6R/OQdK9Dk2snxOgMdDC1zbY+482qm1A9PQOM2q6PNxo5H7r20QgG60sFBTO3bZapkb9q/K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698682; c=relaxed/simple;
	bh=dExakFZInlzqfLC/uoCIzK60o4H4Fut5Hpa9CEBbIuo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlk8hG1aAAjQ44v0ZHFqzJJPF2X7siAr5YW6yfV/UcB5LTIMNdggrZBVHo3ZVan9As0T23FyHMTG9P19xkOtflLcnN/lhzXOhtShmJwmzK/7HB5g6CjJGDIUouR4WOy5uSBlV9YkdCuPCscbVMZ5aFcurEQ7mysS/HBUUqkYrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAD0mMpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C15C4CEE7;
	Wed, 29 Oct 2025 00:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698682;
	bh=dExakFZInlzqfLC/uoCIzK60o4H4Fut5Hpa9CEBbIuo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fAD0mMpGnDyT0gw3Fbg4wA5tKnlqxjyI0uLSIbVeCExpiPHmaiilZWNPjuS7ST2DH
	 kXgzT91dVwSYVd7/MpH7CWxZ8SF0CdHSE5rh9ddpuLScSdAusL6y+OhrW5vzXxZ3c4
	 IPWO7Je47icubym7/EJVATGIiklBaTQy/q26KXerKU/+MJJ9wvis4Emr/bd8X365AG
	 tX0yTNYy20brGByQs+E8RmjV4CUiBXHLp7WkfoyBf7nnvGQTNJbkywSTiicX4SHccU
	 BwLkXblPZuSfAfNecUypMZa6OxIGnibp1SOObrLcBMSrQqy0UOSagCcj78TAGoaU5i
	 w6l6u7hhKpgSQ==
Date: Tue, 28 Oct 2025 17:44:41 -0700
Subject: [PATCH 1/2] fuse: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809828.1424693.658681539435984766.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
References: <176169809796.1424693.4820699158982303428.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |   25 ++++++++++-
 include/uapi/linux/fuse.h |    8 +++-
 fs/fuse/Kconfig           |    4 ++
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |   98 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev.c             |    4 +-
 fs/fuse/inode.c           |    4 +-
 fs/fuse/passthrough.c     |   38 +++++++++++++++++
 8 files changed, 149 insertions(+), 35 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1316c3853f68dc..7c7d255d817f1e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -96,10 +96,23 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+struct fuse_conn;
+
+/** Operations for subsystems that want to use a backing file */
+struct fuse_backing_ops {
+	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
+	int (*may_open)(struct fuse_conn *fc, struct file *file);
+	int (*may_close)(struct fuse_conn *fc, struct file *file);
+	unsigned int type;
+	int id_start;
+	int id_end;
+};
+
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	const struct fuse_backing_ops *ops;
 
 	/** refcount */
 	refcount_t count;
@@ -972,7 +985,7 @@ struct fuse_conn {
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
 
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
@@ -1588,10 +1601,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
 /* backing.c */
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
-struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
+					 const struct fuse_backing_ops *ops,
+					 int backing_id);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1646,6 +1661,10 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 #endif
 }
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
+extern const struct fuse_backing_ops fuse_passthrough_backing_ops;
+#endif
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12bd..18713cfaf09171 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1126,9 +1126,15 @@ struct fuse_notify_prune_out {
 	uint64_t	spare;
 };
 
+#define FUSE_BACKING_TYPE_MASK		(0xFF)
+#define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_PASSTHROUGH)
+
+#define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
+
 struct fuse_backing_map {
 	int32_t		fd;
-	uint32_t	flags;
+	uint32_t	flags; /* FUSE_BACKING_* */
 	uint64_t	padding;
 };
 
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 3a4ae632c94aa8..290d1c09e0b924 100644
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
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4b8..46041228e5be2c 100644
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
 
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4afda419dd1416..f5efbffd0f456b 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/file.h>
 
@@ -44,7 +45,8 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	id = idr_alloc_cyclic(&fc->backing_files_map, fb, fb->ops->id_start,
+			      fb->ops->id_end, GFP_ATOMIC);
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -69,32 +71,53 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 	struct fuse_backing *fb = p;
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+
 	fuse_backing_free(fb);
 	return 0;
 }
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
 	idr_destroy(&fc->backing_files_map);
 }
 
+static inline const struct fuse_backing_ops *
+fuse_backing_ops_from_map(const struct fuse_backing_map *map)
+{
+	switch (map->flags & FUSE_BACKING_TYPE_MASK) {
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	case FUSE_BACKING_TYPE_PASSTHROUGH:
+		return &fuse_passthrough_backing_ops;
+#endif
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 {
 	struct file *file;
-	struct super_block *backing_sb;
 	struct fuse_backing *fb = NULL;
+	const struct fuse_backing_ops *ops = fuse_backing_ops_from_map(map);
+	uint32_t op_flags = map->flags & ~FUSE_BACKING_TYPE_MASK;
 	int res;
 
 	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	res = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+	res = -EOPNOTSUPP;
+	if (!ops)
+		goto out;
+	WARN_ON(ops->type != (map->flags & FUSE_BACKING_TYPE_MASK));
+
+	res = ops->may_admin ? ops->may_admin(fc, op_flags) : 0;
+	if (res)
 		goto out;
 
 	res = -EINVAL;
-	if (map->flags || map->padding)
+	if (map->padding)
 		goto out;
 
 	file = fget_raw(map->fd);
@@ -102,14 +125,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!file)
 		goto out;
 
-	/* read/write/splice/mmap passthrough only relevant for regular files */
-	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
-	if (!d_is_reg(file->f_path.dentry))
-		goto out_fput;
-
-	backing_sb = file_inode(file)->i_sb;
-	res = -ELOOP;
-	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+	res = ops->may_open ? ops->may_open(fc, file) : 0;
+	if (res)
 		goto out_fput;
 
 	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
@@ -119,14 +136,15 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 
 	fb->file = file;
 	fb->cred = prepare_creds();
+	fb->ops = ops;
 	refcount_set(&fb->count, 1);
 
 	res = fuse_backing_id_alloc(fc, fb);
 	if (res < 0) {
 		fuse_backing_free(fb);
 		fb = NULL;
+		goto out;
 	}
-
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -137,41 +155,71 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	goto out;
 }
 
+static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc,
+						  int backing_id)
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
+
 int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 {
-	struct fuse_backing *fb = NULL;
+	struct fuse_backing *fb, *test_fb;
+	const struct fuse_backing_ops *ops;
 	int err;
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	err = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
-		goto out;
-
 	err = -EINVAL;
 	if (backing_id <= 0)
 		goto out;
 
 	err = -ENOENT;
-	fb = fuse_backing_id_remove(fc, backing_id);
+	fb = __fuse_backing_lookup(fc, backing_id);
 	if (!fb)
 		goto out;
+	ops = fb->ops;
 
-	fuse_backing_put(fb);
+	err = ops->may_admin ? ops->may_admin(fc, 0) : 0;
+	if (err)
+		goto out_fb;
+
+	err = ops->may_close ? ops->may_close(fc, fb->file) : 0;
+	if (err)
+		goto out_fb;
+
+	err = -ENOENT;
+	test_fb = fuse_backing_id_remove(fc, backing_id);
+	if (!test_fb)
+		goto out_fb;
+
+	WARN_ON(fb != test_fb);
 	err = 0;
+	fuse_backing_put(test_fb);
+out_fb:
+	fuse_backing_put(fb);
 out:
 	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
 
 	return err;
 }
 
-struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
+					 const struct fuse_backing_ops *ops,
+					 int backing_id)
 {
 	struct fuse_backing *fb;
 
 	rcu_read_lock();
 	fb = idr_find(&fc->backing_files_map, backing_id);
+	if (fb && fb->ops != ops)
+		fb = NULL;
 	fb = fuse_backing_get(fb);
 	rcu_read_unlock();
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ecc0a5304c59d1..12cc673df99151 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2662,7 +2662,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&map, argp, sizeof(map)))
@@ -2679,7 +2679,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (get_user(backing_id, argp))
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 76e5b7f5c980c2..0cac7164afa298 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1004,7 +1004,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
 
 	INIT_LIST_HEAD(&fc->mounts);
@@ -1041,7 +1041,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 			WARN_ON(atomic_read(&bucket->count) != 1);
 			kfree(bucket);
 		}
-		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		if (IS_ENABLED(CONFIG_FUSE_BACKING))
 			fuse_backing_files_free(fc);
 		call_rcu(&fc->rcu, delayed_release);
 	}
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 72de97c03d0eeb..e1619bffb5d125 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -162,7 +162,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 		goto out;
 
 	err = -ENOENT;
-	fb = fuse_backing_lookup(fc, backing_id);
+	fb = fuse_backing_lookup(fc, &fuse_passthrough_backing_ops, backing_id);
 	if (!fb)
 		goto out;
 
@@ -195,3 +195,39 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
 	put_cred(ff->cred);
 	ff->cred = NULL;
 }
+
+static int fuse_passthrough_may_admin(struct fuse_conn *fc, unsigned int flags)
+{
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int fuse_passthrough_may_open(struct fuse_conn *fc, struct file *file)
+{
+	struct super_block *backing_sb;
+	int res;
+
+	/* read/write/splice/mmap passthrough only relevant for regular files */
+	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
+	if (!d_is_reg(file->f_path.dentry))
+		return res;
+
+	backing_sb = file_inode(file)->i_sb;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		return -ELOOP;
+
+	return 0;
+}
+
+const struct fuse_backing_ops fuse_passthrough_backing_ops = {
+	.type = FUSE_BACKING_TYPE_PASSTHROUGH,
+	.id_start = 1,
+	.may_admin = fuse_passthrough_may_admin,
+	.may_open = fuse_passthrough_may_open,
+};


