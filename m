Return-Path: <linux-fsdevel+bounces-61526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A971B58993
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F89E169A16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148F78F29;
	Tue, 16 Sep 2025 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1g0nGri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62C1BC5C;
	Tue, 16 Sep 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982776; cv=none; b=T/JAKFyvct8zscTy0QtMTooCmSEeBZdBISPBk9flI+3BzLGMlMRV29eN4zPrW9Voik6duKiXZu1L0ySWtB/yQUP7FmVoar+54OlzFfUACm0DPi8XKakyn7Il8TRIJLetRhOzoOOdE+AGf8iPRwotmA38aeSTuofc8b41LdA3JXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982776; c=relaxed/simple;
	bh=snpgPKAq3hBxO96io8Xqo8uV0/t1IXNbViLyCA9j+Jw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRJ5MgIxaFeMMl5coKGoVR+Gut8MspPUx75zy8QZU8LZzsF5l2FjUW45yVB5MGhYGCyV0lJln83PY/Unwr323m4um9iu/A/T0ipoG8cO7nMSjhvIOqs1Rv3+WjTbhEybNPPOeBFjZ3li2JMaW7XhJ4zhanfuK3R63LgPFvg20l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1g0nGri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B489C4CEF1;
	Tue, 16 Sep 2025 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982776;
	bh=snpgPKAq3hBxO96io8Xqo8uV0/t1IXNbViLyCA9j+Jw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f1g0nGri9WffgMQFZDtHoRpUiwQHrqH9aQtwOYVWYyDBt1y+OyL22n4pLgCHrfzvb
	 814Rz+5hSmb9DBi2HNlAfxruMy6NrPQuHbfkBkCqh/CV8kR/FvZyWfOCF4O/nOinxm
	 vihvzjzeZxrd0TK2qVvFSKNvkMrEpfCUCwcE5V4yV3uJaadY/mMduF9aWXHfxYuDGM
	 d0NNPZkWb5jE6f/vDluXTEYpmrwZgmf4vLBMGIxXPzCpRFzkdBQZ6x9qIkDr04Rw6r
	 25/A54zdR0MRQ2AFNoCKh9rdh8qKOZxajwkQXoiZJh9TL4ux1JfWmngBttb7pzByCn
	 lzFzVScmXYmhA==
Date: Mon, 15 Sep 2025 17:32:55 -0700
Subject: [PATCH 19/28] fuse: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151673.382724.12664577971132099150.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new upcall to the fuse server so that the kernel can request
filesystem geometry bits when iomap mode is in use.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   10 ++-
 include/uapi/linux/fuse.h |   39 ++++++++++++
 fs/fuse/file_iomap.c      |  147 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   42 ++++++++++---
 4 files changed, 227 insertions(+), 11 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 82191e92c21097..e45780f6fe9e39 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1019,6 +1019,9 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+	/** How many subsystems still need initialization? */
+	atomic_t need_init;
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1431,6 +1434,7 @@ struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
+void fuse_finish_init(struct fuse_conn *fc, bool ok);
 
 /**
  * Fill in superblock and initialize fuse connection
@@ -1739,7 +1743,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
-void fuse_iomap_mount(struct fuse_mount *fm);
+int fuse_iomap_mount(struct fuse_mount *fm);
+void fuse_iomap_mount_async(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
 
 void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags);
@@ -1787,7 +1792,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
-# define fuse_iomap_mount(...)			((void)0)
+# define fuse_iomap_mount(...)			(0)
+# define fuse_iomap_mount_async(...)		((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 675b1d4fdff8db..19c1ac5006faa9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -239,6 +239,7 @@
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
+ *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  */
 
 #ifndef _LINUX_FUSE_H
@@ -666,6 +667,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 
+	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
@@ -1425,4 +1427,41 @@ struct fuse_iomap_ioend_in {
 	uint32_t reserved1;	/* zero */
 };
 
+struct fuse_iomap_config_in {
+	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
+	int64_t maxbytes;	/* maximum supported file size */
+	uint64_t padding[6];	/* zero */
+};
+
+/* Which fields are set in fuse_iomap_config_out? */
+#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
+#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
+#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
+#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
+#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
+#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+
+struct fuse_iomap_config_out {
+	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
+
+	char s_id[32];		/* Informational name */
+	char s_uuid[16];	/* UUID */
+
+	uint8_t s_uuid_len;	/* length of s_uuid */
+
+	uint8_t s_pad[3];	/* must be zeroes */
+
+	uint32_t s_blocksize;	/* fs block size */
+	uint32_t s_max_links;	/* max hard links */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	uint32_t s_time_gran;
+
+	/* Time limits for c/m/atime in seconds */
+	int64_t s_time_min;
+	int64_t s_time_max;
+
+	int64_t s_maxbytes;	/* max file size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 5cefceb267f8f1..abba22107718d9 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -708,14 +708,103 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.post_open = fuse_iomap_post_open,
 };
 
-void fuse_iomap_mount(struct fuse_mount *fm)
+struct fuse_iomap_config_args {
+	struct fuse_args args;
+	struct fuse_iomap_config_in inarg;
+	struct fuse_iomap_config_out outarg;
+};
+
+#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_SID | \
+			       FUSE_IOMAP_CONFIG_UUID | \
+			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
+			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
+			       FUSE_IOMAP_CONFIG_TIME | \
+			       FUSE_IOMAP_CONFIG_MAXBYTES)
+
+static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
+				     const struct fuse_iomap_config_out *outarg)
 {
+	struct super_block *sb = fm->sb;
+
+	switch (error) {
+	case 0:
+		break;
+	case -ENOSYS:
+		return 0;
+	default:
+		return error;
+	}
+
+	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
+		return -EINVAL;
+
+	if (outarg->s_uuid_len > sizeof(outarg->s_uuid))
+		return -EINVAL;
+
+	if (memchr_inv(outarg->s_pad, 0, sizeof(outarg->s_pad)))
+		return -EINVAL;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE) {
+		if (sb->s_bdev) {
+#ifdef CONFIG_BLOCK
+			if (!sb_set_blocksize(sb, outarg->s_blocksize))
+				return -EINVAL;
+#else
+			/*
+			 * XXX: how do we have a bdev filesystem without
+			 * CONFIG_BLOCK???
+			 */
+			return -EINVAL;
+#endif
+		} else {
+			sb->s_blocksize = outarg->s_blocksize;
+			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
+		}
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)
+		memcpy(sb->s_id, outarg->s_id, sizeof(sb->s_id));
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_UUID) {
+		memcpy(&sb->s_uuid, outarg->s_uuid, outarg->s_uuid_len);
+		sb->s_uuid_len = outarg->s_uuid_len;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
+		sb->s_max_links = outarg->s_max_links;
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_TIME) {
+		sb->s_time_gran = outarg->s_time_gran;
+		sb->s_time_min = outarg->s_time_min;
+		sb->s_time_max = outarg->s_time_max;
+	}
+
+	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
+		sb->s_maxbytes = outarg->s_maxbytes;
+
+	return 0;
+}
+
+static void fuse_iomap_config_reply(struct fuse_mount *fm,
+				    struct fuse_args *args, int error)
+{
+	struct fuse_iomap_config_args *ia =
+		container_of(args, struct fuse_iomap_config_args, args);
 	struct fuse_conn *fc = fm->fc;
 	struct super_block *sb = fm->sb;
 	struct backing_dev_info *old_bdi = sb->s_bdi;
 	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	bool ok = true;
 	int res;
 
+	res = fuse_iomap_process_config(fm, error, &ia->outarg);
+	if (res) {
+		printk(KERN_ERR "%s: could not configure iomap, err=%d",
+		       sb->s_id, res);
+		ok = false;
+		goto done;
+	}
+
 	/*
 	 * sb->s_bdi points to the initial private bdi.  However, we want to
 	 * redirect it to a new private bdi with default dirty and readahead
@@ -741,6 +830,62 @@ void fuse_iomap_mount(struct fuse_mount *fm)
 	fc->sync_fs = true;
 	fc->iomap_conn.no_end = 0;
 	fc->iomap_conn.no_ioend = 0;
+
+done:
+	kfree(ia);
+	fuse_finish_init(fc, ok);
+}
+
+static struct fuse_iomap_config_args *
+fuse_iomap_new_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia;
+
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
+	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
+
+	ia->args.opcode = FUSE_IOMAP_CONFIG;
+	ia->args.nodeid = 0;
+	ia->args.in_numargs = 1;
+	ia->args.in_args[0].size = sizeof(ia->inarg);
+	ia->args.in_args[0].value = &ia->inarg;
+	ia->args.out_argvar = true;
+	ia->args.out_numargs = 1;
+	ia->args.out_args[0].size = sizeof(ia->outarg);
+	ia->args.out_args[0].value = &ia->outarg;
+	ia->args.force = true;
+	ia->args.nocreds = true;
+
+	return ia;
+}
+
+int fuse_iomap_mount(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(fm->fc->sync_init);
+
+	err = fuse_simple_request(fm, &ia->args);
+	/* Ignore size of iomap_config reply */
+	if (err > 0)
+		err = 0;
+	fuse_iomap_config_reply(fm, &ia->args, err);
+	return err;
+}
+
+void fuse_iomap_mount_async(struct fuse_mount *fm)
+{
+	struct fuse_iomap_config_args *ia = fuse_iomap_new_mount(fm);
+	int err;
+
+	ASSERT(!fm->fc->sync_init);
+
+	ia->args.end = fuse_iomap_config_reply;
+	err = fuse_simple_background(fm, &ia->args, GFP_KERNEL);
+	if (err)
+		fuse_iomap_config_reply(fm, &ia->args, -ENOTCONN);
 }
 
 void fuse_iomap_unmount(struct fuse_mount *fm)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4f348fc575a5c3..beb9ee62b6b861 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1319,6 +1319,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_init_out *arg = &ia->out;
 	bool ok = true;
 
+	atomic_inc(&fc->need_init);
+
 	if (error || arg->major != FUSE_KERNEL_VERSION)
 		ok = false;
 	else {
@@ -1466,9 +1468,6 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
-		if (fc->iomap)
-			fuse_iomap_mount(fm);
-
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -1478,13 +1477,27 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	}
 	kfree(ia);
 
-	if (!ok) {
+	if (!ok)
 		fc->conn_init = 0;
+
+	if (ok && fc->iomap) {
+		atomic_inc(&fc->need_init);
+		if (!fc->sync_init)
+			fuse_iomap_mount_async(fm);
+	}
+
+	fuse_finish_init(fc, ok);
+}
+
+void fuse_finish_init(struct fuse_conn *fc, bool ok)
+{
+	if (!ok)
 		fc->conn_error = 1;
-	}
 
-	fuse_set_initialized(fc);
-	wake_up_all(&fc->blocked_waitq);
+	if (atomic_dec_and_test(&fc->need_init)) {
+		fuse_set_initialized(fc);
+		wake_up_all(&fc->blocked_waitq);
+	}
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
@@ -1974,7 +1987,20 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	fm = get_fuse_mount_super(sb);
 
-	return fuse_send_init(fm);
+	err = fuse_send_init(fm);
+	if (err)
+		return err;
+
+	if (fm->fc->conn_init && fm->fc->sync_init && fm->fc->iomap) {
+		err = fuse_iomap_mount(fm);
+		if (err)
+			return err;
+	}
+
+	if (fm->fc->conn_error)
+		return -EIO;
+
+	return 0;
 }
 
 /*


