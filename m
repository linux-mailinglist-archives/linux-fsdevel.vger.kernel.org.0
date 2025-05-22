Return-Path: <linux-fsdevel+bounces-49610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577AAC00EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB97F1697CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDC3D76;
	Thu, 22 May 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujVFhTG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D528FD;
	Thu, 22 May 2025 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872209; cv=none; b=uAeyxVpIwjto1vA0H5kbeNOapjsJ3XAxd2cYyNJpzu66pkjx+AXxjlBleQ0aiY+vXKdcHhlYQV9rKaEV0WuPN7bFMgPYfYG9KGILKKv+uO2INEVy4lYLy0q/tNmzu4YG8Actqf0M7MZVv6huRuL6uD9TktNw/Pfb2QoYaCvRgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872209; c=relaxed/simple;
	bh=DgfAFD0+/MxrP7Lbf8w9e0fVa3jVZ9vzC5dK6BHhUPA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahpp4Pih98Vh7a7l/avIW5yL7abQFgkZKJwXgDA/mZimJHymkN/mwKL//IbXwM7cCxmdW8Uall/TkMXPUz1QUMRM13dhAlucqf6pnEY3mwqI3hT/0lE2YQ2WHKFamEeWJXnUSZU+Al9j+rtzx9CQA/748jOTo5AKqMoXruz5CKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujVFhTG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A1C4CEE4;
	Thu, 22 May 2025 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872209;
	bh=DgfAFD0+/MxrP7Lbf8w9e0fVa3jVZ9vzC5dK6BHhUPA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ujVFhTG3HFx1MZiUYqhfE1Fpk5TqvGggGretLuYTvBdZ4QwpEnTsOcicoOXklPFs7
	 sYeMnVQMRuW1FK2J81fpmzkGUw/A3CD9un2MGZndxnpmin4P8SrLJgmKCiwFIgDDka
	 XrOLAz9UYDXT5RPReIYv+JNJ9jEEuuBn3caZuFfbIZ/qLbe1UEx7R0d7jYrzXebb2n
	 U87DTjAjBvZ6UHjZwQ91PpA0cxSbSk4iUaMej0v7hzLme8k7/Zh48GEEDZy7XBLvid
	 yu4lfFCW7ODpVQPyc3Jd0SF/ncV6elL9Eomi1zOXMXAdvh+5yJIY3lBIYFg1EpA8R4
	 fPo/eqpuEgE9A==
Date: Wed, 21 May 2025 17:03:28 -0700
Subject: [PATCH 04/11] fuse: add a notification to add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195651.1483178.3420885441625089259.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a new notification so that fuse servers can add extra block devices
to use with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   19 +++++++
 fs/fuse/fuse_trace.h      |   36 ++++++++++++++
 include/uapi/linux/fuse.h |    8 +++
 fs/fuse/dev.c             |   23 +++++++++
 fs/fuse/file_iomap.c      |  119 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |    9 +++
 6 files changed, 211 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index aa51f25856697d..4eb75ed90db300 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -619,6 +619,12 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+struct fuse_iomap {
+	/* array of file objects that reference block devices for iomap */
+	struct file **files;
+	unsigned int nr_files;
+};
+
 /**
  * A Fuse connection.
  *
@@ -970,6 +976,10 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+#ifdef CONFIG_FUSE_IOMAP
+	struct fuse_iomap iomap_conn;
+#endif
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1610,9 +1620,18 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 {
 	return get_fuse_conn_c(inode)->iomap;
 }
+
+void fuse_iomap_init_reply(struct fuse_mount *fm);
+void fuse_iomap_conn_put(struct fuse_conn *fc);
+
+int fuse_iomap_add_device(struct fuse_conn *fc,
+			  const struct fuse_iomap_add_device_out *outarg);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_init_reply(...)		((void)0)
+# define fuse_iomap_conn_put(...)		((void)0)
+# define fuse_iomap_add_device(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index f9a316c9788e06..e1a2e491d2581a 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -380,6 +380,42 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->pos, __entry->count, __entry->written,
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_dev_class,
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
+		 const struct file *file),
+
+	TP_ARGS(fc, idx, file),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(unsigned int,	idx)
+		__field(dev_t,		bdev)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = file_inode(file);
+
+		__entry->connection	=	fc->dev;
+		__entry->idx		=	idx;
+		if (S_ISBLK(inode->i_mode)) {
+			__entry->bdev	=	inode->i_rdev;
+		} else
+			__entry->bdev	=	0;
+	),
+
+	TP_printk("connection %u idx %u dev %u:%u",
+		  __entry->connection,
+		  __entry->idx,
+		  MAJOR(__entry->bdev), MINOR(__entry->bdev))
+);
+#define DEFINE_FUSE_IOMAP_DEV_EVENT(name)		\
+DEFINE_EVENT(fuse_iomap_dev_class, name,		\
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
+		 const struct file *file), \
+	TP_ARGS(fc, idx, file))
+DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_add_dev);
+DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_remove_dev);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index ce6c9960f2418f..ea8992e980a015 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -236,6 +236,7 @@
  *  7.44
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
+ *  - add FUSE_NOTIFY_ADD_IOMAP_DEVICE for multi-device filesystems
  */
 
 #ifndef _LINUX_FUSE_H
@@ -681,6 +682,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
+	FUSE_NOTIFY_ADD_IOMAP_DEVICE = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -1371,4 +1373,10 @@ struct fuse_iomap_end_in {
 	uint32_t map_dev;	/* device cookie * */
 };
 
+struct fuse_iomap_add_device_out {
+	int32_t fd;		/* fd of the open device to add */
+	uint32_t reserved;	/* must be zero */
+	uint32_t *map_dev;	/* location to receive device cookie */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6dcbaa218b7a16..9d7064ec170cf6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1824,6 +1824,26 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	return err;
 }
 
+static int fuse_notify_add_iomap_device(struct fuse_conn *fc, unsigned int size,
+					struct fuse_copy_state *cs)
+{
+	struct fuse_iomap_add_device_out outarg;
+	int err = -EINVAL;
+
+	if (size != sizeof(outarg))
+		goto err;
+
+	err = fuse_copy_one(cs, &outarg, sizeof(outarg));
+	if (err)
+		goto err;
+	fuse_copy_finish(cs);
+
+	return fuse_iomap_add_device(fc, &outarg);
+err:
+	fuse_copy_finish(cs);
+	return err;
+}
+
 struct fuse_retrieve_args {
 	struct fuse_args_pages ap;
 	struct fuse_notify_retrieve_in inarg;
@@ -2049,6 +2069,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_RESEND:
 		return fuse_notify_resend(fc);
 
+	case FUSE_NOTIFY_ADD_IOMAP_DEVICE:
+		return fuse_notify_add_iomap_device(fc, size, cs);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index dfa0c309803113..faefd29a273bf3 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -142,6 +142,26 @@ static inline int fuse_iomap_validate(const struct fuse_iomap_begin_out *outarg,
 	return 0;
 }
 
+static inline struct block_device *fuse_iomap_bdev(struct fuse_mount *fm,
+						   unsigned int idx)
+{
+	struct fuse_conn *fc = fm->fc;
+	struct file *file = NULL;
+
+	spin_lock(&fc->lock);
+	if (idx < fc->iomap_conn.nr_files)
+		file = fc->iomap_conn.files[idx];
+	spin_unlock(&fc->lock);
+
+	if (!file)
+		return NULL;
+
+	if (!S_ISBLK(file_inode(file)->i_mode))
+		return NULL;
+
+	return I_BDEV(file->f_mapping->host);
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -155,6 +175,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct block_device *read_bdev;
 	FUSE_ARGS(args);
 	int err;
 
@@ -181,8 +202,18 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	read_bdev = fuse_iomap_bdev(fm, outarg.read_dev);
+	if (!read_bdev)
+		return -ENODEV;
+
 	if ((opflags & IOMAP_WRITE) &&
 	    outarg.write_type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		struct block_device *write_bdev =
+			fuse_iomap_bdev(fm, outarg.write_dev);
+
+		if (!write_bdev)
+			return -ENODEV;
+
 		/*
 		 * For an out of place write, we must supply the write mapping
 		 * via @iomap, and the read mapping via @srcmap.
@@ -192,14 +223,14 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		iomap->length = outarg.length;
 		iomap->type = outarg.write_type;
 		iomap->flags = outarg.write_flags;
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->bdev = write_bdev;
 
 		srcmap->addr = outarg.read_addr;
 		srcmap->offset = outarg.offset;
 		srcmap->length = outarg.length;
 		srcmap->type = outarg.read_type;
 		srcmap->flags = outarg.read_flags;
-		srcmap->bdev = inode->i_sb->s_bdev;
+		srcmap->bdev = read_bdev;
 	} else {
 		/*
 		 * For everything else (reads, reporting, and pure overwrites),
@@ -211,7 +242,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		iomap->length = outarg.length;
 		iomap->type = outarg.read_type;
 		iomap->flags = outarg.read_flags;
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->bdev = read_bdev;
 	}
 
 	return 0;
@@ -278,3 +309,85 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
+
+void fuse_iomap_conn_put(struct fuse_conn *fc)
+{
+	unsigned int i;
+
+	for (i = 0; i < fc->iomap_conn.nr_files; i++) {
+		struct file *file = fc->iomap_conn.files[i];
+
+		trace_fuse_iomap_remove_dev(fc, i, file);
+
+		fc->iomap_conn.files[i] = NULL;
+		fput(file);
+	}
+
+	kfree(fc->iomap_conn.files);
+	fc->iomap_conn.nr_files = 0;
+}
+
+/* Add a bdev to the fuse connection, returns the index or a negative errno */
+static int __fuse_iomap_add_device(struct fuse_conn *fc, struct file *file)
+{
+	struct file **new_files;
+	int ret;
+
+	if (fc->iomap_conn.nr_files >= PAGE_SIZE / sizeof(unsigned int))
+		return -EMFILE;
+
+	new_files = krealloc_array(fc->iomap_conn.files,
+				   fc->iomap_conn.nr_files + 1,
+				   sizeof(struct file *),
+				   GFP_KERNEL | __GFP_ZERO);
+	if (!new_files)
+		return -ENOMEM;
+
+	spin_lock(&fc->lock);
+	fc->iomap_conn.files = new_files;
+	fc->iomap_conn.files[fc->iomap_conn.nr_files] = get_file(file);
+	ret = fc->iomap_conn.nr_files++;
+	spin_unlock(&fc->lock);
+
+	trace_fuse_iomap_add_dev(fc, ret, file);
+
+	return ret;
+}
+
+void fuse_iomap_init_reply(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+	struct super_block *sb = fm->sb;
+
+	if (sb->s_bdev)
+		__fuse_iomap_add_device(fc, sb->s_bdev_file);
+}
+
+int fuse_iomap_add_device(struct fuse_conn *fc,
+			  const struct fuse_iomap_add_device_out *outarg)
+{
+	struct file *file;
+	int ret;
+
+	if (!fc->iomap)
+		return -EINVAL;
+
+	if (outarg->reserved)
+		return -EINVAL;
+
+	CLASS(fd, somefd)(outarg->fd);
+	if (fd_empty(somefd))
+		return -EBADF;
+	file = fd_file(somefd);
+
+	if (!S_ISBLK(file_inode(file)->i_mode))
+		return -ENODEV;
+
+	down_read(&fc->killsb);
+	ret = __fuse_iomap_add_device(fc, file);
+	up_read(&fc->killsb);
+	if (ret < 0)
+		return ret;
+
+	return put_user(ret, outarg->map_dev);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 88730d26c9b5e2..84b7cd5ffe843b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1010,6 +1010,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 		struct fuse_iqueue *fiq = &fc->iq;
 		struct fuse_sync_bucket *bucket;
 
+		if (fc->iomap)
+			fuse_iomap_conn_put(fc);
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
 		if (fc->timeout.req_timeout)
@@ -1449,6 +1451,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap)
+			fuse_iomap_init_reply(fm);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -1886,6 +1891,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
  err_free_dax:
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
+	/*
+	 * No need to call fuse_iomap_conn_put here because we don't add
+	 * devices until the init reply.
+	 */
  err:
 	return err;
 }


