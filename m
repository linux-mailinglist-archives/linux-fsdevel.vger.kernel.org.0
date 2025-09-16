Return-Path: <linux-fsdevel+bounces-61558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56238B589E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95052188B893
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23851B394F;
	Tue, 16 Sep 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ3SQJ5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837DD528;
	Tue, 16 Sep 2025 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983277; cv=none; b=XaZDS1/tQxtXY1Ty7wEHPIY688bksoFfL49BX+LQv11gs+Zay+HDyoEQ962mmfXx3P2yYDKvQqmpFt6Kq6N7zXvrH64Q92lpXq/SOcH2Zzg+IRNcOrbWiSRdNXm2EcxeF2ha52RiE52TBF6E3Ht1/zaeWQaklV1O63NiRCHmlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983277; c=relaxed/simple;
	bh=2so56jrXsUh4w/OfyCKrbB3Ys610yM/yLjOokTYp9UY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOtBgA1L9LVnpp9/OxF67Fwg4uueAFmzYj3UQZtkTiBXyBAXgPttjtKYSZBU5O7QknGRSSsqSlH7mNsg/jQBDVGfBMfgBLn6Cl6F/2kLvsj45RT3D8au+pjfpMu3us6ccMimxbS4CMHIdcFypCF3FcXklj0akTpTvcO5/O/6l1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ3SQJ5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B810C4CEF1;
	Tue, 16 Sep 2025 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983276;
	bh=2so56jrXsUh4w/OfyCKrbB3Ys610yM/yLjOokTYp9UY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kQ3SQJ5SaJH95PvIsYsBT7Qyo+Z5/ZSsQMDYcYqnD6tgewK5iMzydMIKwYVlSXoF6
	 WQaZTfs0VnGltBWL9+i0EvEJRjtclejvdDJJWEX0ykThuvC0Es5WrrhDlpC1gyj6k3
	 ao+1+3FGGaY74bxFshxOgNY9mcbzKe5HgsoOEth/5tyi6zlUCIUNqiACQpV9k3WDbM
	 CPRQcd6VJdJYWYXf0O7d10xVaDHXhZyEhZpeajA29Ij76INW/C5bu1cnkwpSrKfzVG
	 TAS+K4lJhQCoYT+HFtQ9A1lkaiscJeqbG6QxD1wH+JuneRwCVL+rFROhQziuZYAsd6
	 /5R6dp8KBk2+g==
Date: Mon, 15 Sep 2025 17:41:16 -0700
Subject: [PATCH 1/2] fuse: allow privileged mount helpers to pre-approve iomap
 usage
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153385.384981.17488509562555925832.stgit@frogsfrogsfrogs>
In-Reply-To: <175798153353.384981.9881071302133055510.stgit@frogsfrogsfrogs>
References: <175798153353.384981.9881071302133055510.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

For the upcoming safemount functionality in libfuse, we will create a
privileged "mount.safe" helper that starts the fuse server in a
completely unprivileged systemd container.  The mount helper will pass
the mount options and fds for /dev/fuse and any other files requested by
the fuse server into the container via a Unix socket.

Currently, the ability to turn on iomap for fuse depends on a module
parameter and the process that calls mount() having the CAP_SYS_RAWIO
capability.  However, the unprivilged fuse server might want to query
the /dev/fuse fd for iomap capabilities before mount or FUSE_INIT so
that it can get ready.

Similar to FUSE_DEV_SYNC_INIT, add a new bit for iomap that can be
squirreled away in file->private_data and an ioctl to set that bit.
That way the privileged mount helper can pass its iomap privilege to the
contained fuse server without the fuse server needing to have
CAP_SYS_RAWIO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_dev_i.h      |   32 +++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |    9 +++++++++
 include/uapi/linux/fuse.h |    1 +
 fs/fuse/dev.c             |   11 +++++------
 fs/fuse/file_iomap.c      |   43 ++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   18 ++++++++++++------
 6 files changed, 98 insertions(+), 16 deletions(-)


diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 6e8373f970409e..783ab1432c8691 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,8 +39,10 @@ struct fuse_copy_state {
 	} ring;
 };
 
-#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
-#define FUSE_DEV_PTR_MASK (~1UL)
+#define FUSE_DEV_SYNC_INIT	(1UL << 0)
+#define FUSE_DEV_INHERIT_IOMAP	(1UL << 1)
+#define FUSE_DEV_FLAGS_MASK	(FUSE_DEV_SYNC_INIT | FUSE_DEV_INHERIT_IOMAP)
+#define FUSE_DEV_PTR_MASK	(~FUSE_DEV_FLAGS_MASK)
 
 static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
@@ -50,7 +52,31 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	 */
 	struct fuse_dev *fud = READ_ONCE(file->private_data);
 
-	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
+	return (typeof(fud)) ((uintptr_t)fud & FUSE_DEV_PTR_MASK);
+}
+
+static inline struct fuse_dev *__fuse_get_dev_and_flags(struct file *file,
+							uintptr_t *flagsp)
+{
+	/*
+	 * Lockless access is OK, because file->private data is set
+	 * once during mount and is valid until the file is released.
+	 */
+	struct fuse_dev *fud = READ_ONCE(file->private_data);
+
+	*flagsp = ((uintptr_t)fud) & FUSE_DEV_FLAGS_MASK;
+	return (typeof(fud)) ((uintptr_t) fud & FUSE_DEV_PTR_MASK);
+}
+
+static inline int __fuse_set_dev_flags(struct file *file, uintptr_t flag)
+{
+	uintptr_t old_flags = 0;
+
+	if (__fuse_get_dev_and_flags(file, &old_flags))
+		return -EINVAL;
+
+	WRITE_ONCE(file->private_data, (struct fuse_dev *)(old_flags | flag));
+	return 0;
 }
 
 struct fuse_dev *fuse_get_dev(struct file *file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8238c1cfd9c481..1a965d3dee6479 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -984,6 +984,13 @@ struct fuse_conn {
 	/* Enable fs/iomap for file operations */
 	unsigned int iomap:1;
 
+	/*
+	 * Are filesystems using this connection allowed to use iomap?  This is
+	 * determined by the privilege level of the process that initiated the
+	 * mount() call.
+	 */
+	unsigned int may_iomap:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1843,6 +1850,7 @@ void fuse_iomap_open_truncate(struct inode *inode);
 void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 				  size_t written);
 
+int fuse_dev_ioctl_add_iomap(struct file *file);
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
 int fuse_iomap_dev_inval(struct fuse_conn *fc,
@@ -1892,6 +1900,7 @@ int fuse_iomap_inval(struct fuse_conn *fc,
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_iomap_open_truncate(...)		((void)0)
 # define fuse_iomap_copied_file_range(...)	((void)0)
+# define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5c2c594fc87892..b59ce131513efd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1187,6 +1187,7 @@ struct fuse_iomap_support {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 99)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b144f67f06160f..7a24fbcdb2f919 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1556,7 +1556,7 @@ struct fuse_dev *fuse_get_dev(struct file *file)
 		return fud;
 
 	err = wait_event_interruptible(fuse_dev_waitq,
-				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+				       __fuse_get_dev(file) != NULL);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2752,13 +2752,10 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
-	int err = -EINVAL;
+	int err;
 
 	mutex_lock(&fuse_mutex);
-	if (!__fuse_get_dev(file)) {
-		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
-		err = 0;
-	}
+	err = __fuse_set_dev_flags(file, FUSE_DEV_SYNC_INIT);
 	mutex_unlock(&fuse_mutex);
 	return err;
 }
@@ -2783,6 +2780,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	case FUSE_DEV_IOC_IOMAP_SUPPORT:
 		return fuse_dev_ioctl_iomap_support(file, argp);
+	case FUSE_DEV_IOC_ADD_IOMAP:
+		return fuse_dev_ioctl_add_iomap(file);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 261490a322c289..70b01638006a2e 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -9,6 +9,7 @@
 #include <linux/falloc.h>
 #include <linux/fadvise.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
 
@@ -114,6 +115,12 @@ bool fuse_iomap_enabled(void)
 	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
 }
 
+static inline bool fuse_iomap_may_enable(void)
+{
+	/* Same as above, but this time we log the denial in audit log */
+	return enable_iomap && capable(CAP_SYS_RAWIO);
+}
+
 /* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
 #define XMAP(word) \
 	case IOMAP_##word: \
@@ -2367,12 +2374,46 @@ fuse_iomap_fallocate(
 	return 0;
 }
 
+int fuse_dev_ioctl_add_iomap(struct file *file)
+{
+	uintptr_t flags = 0;
+	struct fuse_dev *fud;
+	int ret = 0;
+
+	mutex_lock(&fuse_mutex);
+	fud = __fuse_get_dev_and_flags(file, &flags);
+	if (fud) {
+		if (!fud->fc->may_iomap && !fuse_iomap_may_enable()) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		fud->fc->may_iomap = 1;
+		goto out_unlock;
+	}
+
+	if (!(flags & FUSE_DEV_INHERIT_IOMAP) && !fuse_iomap_may_enable()) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
+	ret = __fuse_set_dev_flags(file, FUSE_DEV_INHERIT_IOMAP);
+
+out_unlock:
+	mutex_unlock(&fuse_mutex);
+	return ret;
+}
+
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp)
 {
 	struct fuse_iomap_support ios = { };
+	uintptr_t flags = 0;
+	struct fuse_dev *fud = __fuse_get_dev_and_flags(file, &flags);
 
-	if (fuse_iomap_enabled())
+	if ((!fud && (flags & FUSE_DEV_INHERIT_IOMAP)) ||
+	    (fud && fud->fc->may_iomap) ||
+	    fuse_iomap_enabled())
 		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
 			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c29a8cbc55fa27..19b385b79f7cbe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1022,6 +1022,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 	fc->root_nodeid = FUSE_ROOT_ID;
+	fc->may_iomap = fuse_iomap_enabled();
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1481,7 +1482,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
 
-			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
+			if ((flags & FUSE_IOMAP) && fc->may_iomap) {
 				fc->local_fs = 1;
 				fc->iomap = 1;
 				printk(KERN_WARNING
@@ -1569,7 +1570,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	 */
 	if (fuse_uring_enabled())
 		flags |= FUSE_OVER_IO_URING;
-	if (fuse_iomap_enabled())
+	if (fm->fc->may_iomap)
 		flags |= FUSE_IOMAP;
 
 	ia->in.flags = flags;
@@ -1955,11 +1956,16 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr) {
-		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT) {
-			fc->sync_init = 1;
-		} else
+	if (ctx->fudptr) {
+		uintptr_t raw = (uintptr_t)(*ctx->fudptr);
+		uintptr_t flags = raw & FUSE_DEV_FLAGS_MASK;
+
+		if (raw & FUSE_DEV_PTR_MASK)
 			goto err_unlock;
+		if (flags & FUSE_DEV_SYNC_INIT)
+			fc->sync_init = 1;
+		if (flags & FUSE_DEV_INHERIT_IOMAP)
+			fc->may_iomap = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);


