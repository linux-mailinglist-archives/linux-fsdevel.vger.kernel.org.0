Return-Path: <linux-fsdevel+bounces-61503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF570B58946
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB4F1B25C09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F021E00B4;
	Tue, 16 Sep 2025 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSVpndUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1711B0420;
	Tue, 16 Sep 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982417; cv=none; b=j+JclNtnyNRy/uAnINRLJKLau3JEQ/4X/eNaQBXfQCIwnDx8yZ//pe6Lktd0wEZmzTu2Phxwyu0CroG6AzPb6n/vu1ewNhn2wOGVzGcpTx1iuQWA/Ngatgpn4hWy9qqtXdQ1nktdsGEdsRusfP3jlUrug6HWbchIe69eIGGeGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982417; c=relaxed/simple;
	bh=zqRPnHv9dL/xOJ4e3Myolb8ppbJVvfa7Z3Rv9OpiOXY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jto00WBpkp1uNwAL36iHuGTGU0KFrbWBdXRthezS0tM15jZ8PVu7yKcyGFAtjJ/EJ8TXvi55OlRvgPMRKz8v9fbJeC4sw7RqlLAmQjJJ9rmEHXrZxN6IqkVLV1lNCy6O127rhoZBW/Geb3xT383IsGl5ECtJRSN7pUFfaqBqhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSVpndUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E755C4CEF1;
	Tue, 16 Sep 2025 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982416;
	bh=zqRPnHv9dL/xOJ4e3Myolb8ppbJVvfa7Z3Rv9OpiOXY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PSVpndUelCH7mO6xS4LSuxVEpZ/JhnA8tFtOmvFpxsFOYvBWtZ7y3YERBcGzsZ2gd
	 wXI/N1vBvTKeCAgyYzhKZoVh2GaMIUUsNAcdcdEoRVZoSUjLcENFAuQL+PMt3CdZY/
	 Plq7wbwhXDq4HxkOSlTlEAySXxK3H9psCMe1JpM4+h5+pL3Rz/3klqdsasE0HWMd08
	 Rqs87GVCfPhw7N0XCLU78CF0ggW+uLcANxzpn9YZOIoQ1bF4lgXBldNhtbtJwUEPL/
	 xTHNgrSzn5tuPJLjHZAFjXtOERWskmhVyE+uZo7/V9bi8cBjN/4JHi2oQXPTQsezdK
	 6eqaFtwyJ+Axg==
Date: Mon, 15 Sep 2025 17:26:56 -0700
Subject: [PATCH 1/5] fuse: allow synchronous FUSE_INIT
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: mszeredi@redhat.com, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
 John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 joannelkoong@gmail.com
Message-ID: <175798150731.382479.12549018102254808407.stgit@frogsfrogsfrogs>
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

From: Miklos Szeredi <mszeredi@redhat.com>

FUSE_INIT has always been asynchronous with mount.  That means that the
server processed this request after the mount syscall returned.

This means that FUSE_INIT can't supply the root inode's ID, hence it
currently has a hardcoded value.  There are other limitations such as not
being able to perform getxattr during mount, which is needed by selinux.

To remove these limitations allow server to process FUSE_INIT while
initializing the in-core super block for the fuse filesystem.  This can
only be done if the server is prepared to handle this, so add
FUSE_DEV_IOC_SYNC_INIT ioctl, which

 a) lets the server know whether this feature is supported, returning
 ENOTTY othewrwise.

 b) lets the kernel know to perform a synchronous initialization

The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
only during super block creation.  This is solved by setting the private
data of the fuse device file to a special value ((struct fuse_dev *) 1) and
waiting for this to be turned into a proper fuse_dev before commecing with
operations on the device file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_dev_i.h      |   13 +++++++-
 fs/fuse/fuse_i.h          |    5 ++-
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/cuse.c            |    3 +-
 fs/fuse/dev.c             |   74 +++++++++++++++++++++++++++++++++------------
 fs/fuse/dev_uring.c       |    4 +-
 fs/fuse/inode.c           |   50 ++++++++++++++++++++++++------
 7 files changed, 115 insertions(+), 35 deletions(-)


diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 5a9bd771a3193d..6e8373f970409e 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -12,6 +12,8 @@
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
 
+extern struct wait_queue_head fuse_dev_waitq;
+
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
@@ -37,15 +39,22 @@ struct fuse_copy_state {
 	} ring;
 };
 
-static inline struct fuse_dev *fuse_get_dev(struct file *file)
+#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
+#define FUSE_DEV_PTR_MASK (~1UL)
+
+static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
 	/*
 	 * Lockless access is OK, because file->private data is set
 	 * once during mount and is valid until the file is released.
 	 */
-	return READ_ONCE(file->private_data);
+	struct fuse_dev *fud = READ_ONCE(file->private_data);
+
+	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
 }
 
+struct fuse_dev *fuse_get_dev(struct file *file);
+
 unsigned int fuse_req_hash(u64 unique);
 struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b9306678dcda0d..02f0138e2fe443 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -909,6 +909,9 @@ struct fuse_conn {
 	/* Should this filesystem behave like a local filesystem? */
 	unsigned int local_fs:1;
 
+	/* Is synchronous FUSE_INIT allowed? */
+	unsigned int sync_init:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1366,7 +1369,7 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
-void fuse_send_init(struct fuse_mount *fm);
+int fuse_send_init(struct fuse_mount *fm);
 
 /**
  * Fill in superblock and initialize fuse connection
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 122d6586e8d4da..1d76d0332f46f6 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1126,6 +1126,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b39844d75a806f..28c96961e85d1c 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -52,6 +52,7 @@
 #include <linux/user_namespace.h>
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #define CUSE_CONNTBL_LEN	64
 
@@ -547,7 +548,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
  */
 static int cuse_channel_release(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = file->private_data;
+	struct fuse_dev *fud = __fuse_get_dev(file);
 	struct cuse_conn *cc = fc_to_cc(fud->fc);
 
 	/* remove from the conntbl, no more access from this point on */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f06208e4364642..e5aaf0c668bc11 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1548,14 +1548,34 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+struct fuse_dev *fuse_get_dev(struct file *file)
+{
+	struct fuse_dev *fud = __fuse_get_dev(file);
+	int err;
+
+	if (likely(fud))
+		return fud;
+
+	err = wait_event_interruptible(fuse_dev_waitq,
+				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+	if (err)
+		return ERR_PTR(err);
+
+	fud = __fuse_get_dev(file);
+	if (!fud)
+		return ERR_PTR(-EPERM);
+
+	return fud;
+}
+
 static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct fuse_copy_state cs;
 	struct file *file = iocb->ki_filp;
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!user_backed_iter(to))
 		return -EINVAL;
@@ -1575,8 +1595,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(in);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
@@ -2251,8 +2271,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(iocb->ki_filp);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!user_backed_iter(from))
 		return -EINVAL;
@@ -2276,8 +2296,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	ssize_t ret;
 
 	fud = fuse_get_dev(out);
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	pipe_lock(pipe);
 
@@ -2361,7 +2381,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 	struct fuse_iqueue *fiq;
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
+	if (IS_ERR(fud))
 		return EPOLLERR;
 
 	fiq = &fud->fc->iq;
@@ -2540,7 +2560,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_dev *fud = __fuse_get_dev(file);
 
 	if (fud) {
 		struct fuse_conn *fc = fud->fc;
@@ -2571,8 +2591,8 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	/* No locking - fasync_helper does its own locking */
 	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
@@ -2582,7 +2602,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 {
 	struct fuse_dev *fud;
 
-	if (new->private_data)
+	if (__fuse_get_dev(new))
 		return -EINVAL;
 
 	fud = fuse_dev_alloc_install(fc);
@@ -2613,7 +2633,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	 * uses the same ioctl handler.
 	 */
 	if (fd_file(f)->f_op == file->f_op)
-		fud = fuse_get_dev(fd_file(f));
+		fud = __fuse_get_dev(fd_file(f));
 
 	res = -EINVAL;
 	if (fud) {
@@ -2631,8 +2651,8 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	struct fuse_dev *fud = fuse_get_dev(file);
 	struct fuse_backing_map map;
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		return -EOPNOTSUPP;
@@ -2648,8 +2668,8 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	struct fuse_dev *fud = fuse_get_dev(file);
 	int backing_id;
 
-	if (!fud)
-		return -EPERM;
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
 	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		return -EOPNOTSUPP;
@@ -2660,6 +2680,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static long fuse_dev_ioctl_sync_init(struct file *file)
+{
+	int err = -EINVAL;
+
+	mutex_lock(&fuse_mutex);
+	if (!__fuse_get_dev(file)) {
+		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
+		err = 0;
+	}
+	mutex_unlock(&fuse_mutex);
+	return err;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2675,6 +2708,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_SYNC_INIT:
+		return fuse_dev_ioctl_sync_init(file);
+
 	default:
 		return -ENOTTY;
 	}
@@ -2683,7 +2719,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 #ifdef CONFIG_PROC_FS
 static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
 {
-	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_dev *fud = __fuse_get_dev(file);
 	if (!fud)
 		return;
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b541aeea1813f..6862fe6b7799a7 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1140,9 +1140,9 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		return -EINVAL;
 
 	fud = fuse_get_dev(cmd->file);
-	if (!fud) {
+	if (IS_ERR(fud)) {
 		pr_info_ratelimited("No fuse device found\n");
-		return -ENOTCONN;
+		return PTR_ERR(fud);
 	}
 	fc = fud->fc;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 869d8a87bfb628..14c35ce12b87d6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "dev_uring_i.h"
 
 #include <linux/dax.h>
@@ -34,6 +35,7 @@ MODULE_LICENSE("GPL");
 static struct kmem_cache *fuse_inode_cachep;
 struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
+DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
@@ -1472,7 +1474,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	wake_up_all(&fc->blocked_waitq);
 }
 
-void fuse_send_init(struct fuse_mount *fm)
+static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 {
 	struct fuse_init_args *ia;
 	u64 flags;
@@ -1531,10 +1533,29 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
 	ia->args.nocreds = true;
-	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
-		process_init_reply(fm, &ia->args, -ENOTCONN);
+	return ia;
+}
+
+int fuse_send_init(struct fuse_mount *fm)
+{
+	struct fuse_init_args *ia = fuse_new_init(fm);
+	int err;
+
+	if (fm->fc->sync_init) {
+		err = fuse_simple_request(fm, &ia->args);
+		/* Ignore size of init reply */
+		if (err > 0)
+			err = 0;
+	} else {
+		ia->args.end = process_init_reply;
+		err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+		if (!err)
+			return 0;
+		err = -ENOTCONN;
+	}
+	process_init_reply(fm, &ia->args, err);
+	return err;
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
@@ -1877,8 +1898,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr)
-		goto err_unlock;
+	if (ctx->fudptr && *ctx->fudptr) {
+		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT) {
+			fc->sync_init = 1;
+		} else
+			goto err_unlock;
+	}
 
 	err = fuse_ctl_add_conn(fc);
 	if (err)
@@ -1886,8 +1911,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr)
+	if (ctx->fudptr) {
 		*ctx->fudptr = fud;
+		wake_up_all(&fuse_dev_waitq);
+	}
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
@@ -1908,6 +1935,7 @@ EXPORT_SYMBOL_GPL(fuse_fill_super_common);
 static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
+	struct fuse_mount *fm;
 	int err;
 
 	if (!ctx->file || !ctx->rootmode_present ||
@@ -1928,8 +1956,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 		return err;
 	/* file->private_data shall be visible on all CPUs after this */
 	smp_mb();
-	fuse_send_init(get_fuse_mount_super(sb));
-	return 0;
+
+	fm = get_fuse_mount_super(sb);
+
+	return fuse_send_init(fm);
 }
 
 /*
@@ -1990,7 +2020,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 	 * Allow creating a fuse mount with an already initialized fuse
 	 * connection
 	 */
-	fud = READ_ONCE(ctx->file->private_data);
+	fud = __fuse_get_dev(ctx->file);
 	if (ctx->file->f_op == &fuse_dev_operations && fud) {
 		fsc->sget_key = fud->fc;
 		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);


