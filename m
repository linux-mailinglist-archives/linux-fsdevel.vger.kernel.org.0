Return-Path: <linux-fsdevel+bounces-78046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGp2HiLenGm4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:09:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D917EE45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9508530E66F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39ED37E2F2;
	Mon, 23 Feb 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNPA2y0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0683783BB;
	Mon, 23 Feb 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888105; cv=none; b=bRfnz6KvYnCxrR5Z2r34ZYHJM3Um1mEEaqdVV36rBcIE1wap5viudxrEkOCCq/F88xh3lg5W3kaCh00mCfopbRT8I8cQoeUAo4Wf0kpc8ugQ/Gu/L8wzILBN/rVZJ2v78zomCauO0jzyP8ZxJrHnYrVIfbG+cDzDSApWMl5zvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888105; c=relaxed/simple;
	bh=Ml59iL/iHWogIlgWJ0gB99a+2rWDh8FPUAp+B4sYt4w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohWqt1tUWwjsg4d2yriDK3XoCW6ySWZOmcHoX8yKZx9RUyM7PsrGCxye8O02y2QhvXrvc58fTj0qyhnq6QC0T5KowSgsrLyy6RMjXJ8GJoaaUhWhTcA680T6LIjC9CDpQI9FrMKTV0Ve6ijTUwiLTA9Be1lcnLfBgzx1h80h1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNPA2y0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A7EC116C6;
	Mon, 23 Feb 2026 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888105;
	bh=Ml59iL/iHWogIlgWJ0gB99a+2rWDh8FPUAp+B4sYt4w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SNPA2y0kA9Lqf2r9JCj5obit83lAslXVfmd476yU0/J/MKmdwGp6WMn69dLjgw51Q
	 liKd3TYyFmRHpgH1R2pzDi/0H5yz33pZbu+/wKpKWcOMFbHssdq+EAGIeWQTwv2pdI
	 svgWaG7/IYyTy7sXlIUa2ysNuXtpScVhdTxmMfS267yPh2VXEzAT4FocnSG6bU3WYu
	 L29NcQCPnktgsXiJ1of1D9e/8Oy3uqY5LBJxkAla1a6cN1RVqdtWjonkbHfM1v2D2u
	 u6uLTBN1PBjgnGlxWO7cfhQk5bmXehulY1IVDmE/ZURZKRxGfEc5wAhbaPpHn4O+Yz
	 1Xf6BdnZEy3tg==
Date: Mon, 23 Feb 2026 15:08:24 -0800
Subject: [PATCH 1/2] fuse: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188733729.3935601.5908754477618852520.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733698.3935601.154959695370946923.stgit@frogsfrogsfrogs>
References: <177188733698.3935601.154959695370946923.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78046-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 182D917EE45
X-Rspamd-Action: no action

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
index 77b581ecf48a16..3373252ccd1678 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -103,10 +103,23 @@ struct fuse_submount_lookup {
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
@@ -981,7 +994,7 @@ struct fuse_conn {
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
 
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
@@ -1594,10 +1607,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
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
@@ -1652,6 +1667,10 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
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
index d95dfa48483f0a..adb4d2ebb21379 100644
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
 
 	fb = kmalloc_obj(struct fuse_backing);
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
+	struct fuse_backing *fb = NULL, *test_fb;
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
index ac9d7a7b3f5e68..a3d762fd4d9a86 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2646,7 +2646,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&map, argp, sizeof(map)))
@@ -2663,7 +2663,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (get_user(backing_id, argp))
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ff8b94cb02e63c..9012f4e8d68338 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1005,7 +1005,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
 
 	INIT_LIST_HEAD(&fc->mounts);
@@ -1045,7 +1045,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		WARN_ON(atomic_read(&bucket->count) != 1);
 		kfree(bucket);
 	}
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
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


