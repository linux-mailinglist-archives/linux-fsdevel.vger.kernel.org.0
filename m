Return-Path: <linux-fsdevel+bounces-55322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55255B097DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3C165802
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB126CE13;
	Thu, 17 Jul 2025 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePYEYUFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E3241CAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794921; cv=none; b=UAy2Sk++6GnHGn/amqTTAUsa/36YZA0twVWWxlBH5G2Gd8MOIFeDxW/4/v7Co2wuKAOO+gmr+tnVQHDyQZGJeQG9vJiHpPTRfM86BtkrcBor2UimY9Z8hZmkwI2qqMuiRG6/TLD9ZVatqA6RuZu2IqDQfWXIhYHgFFk2FGsvgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794921; c=relaxed/simple;
	bh=bIO44M4iorNfvtN5lpmXZqYvy6G//VE/x037+7F4KiQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghMEacuBhYqheG5SJ9QDhI6LsHHJhwrYwr6wKR53C2DUNgQSW3fvjuzgBrXtwV9ARezqwNNVqjHD0iKloFlQfkT9dmxQb++vPI2MTyXji49+9XHRiQqpZCG8zty7rjNP2qHGnTNyGXKnMrLiVyEOPeJnKPCzt/9U+rN+N2lCkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePYEYUFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C534C4CEE3;
	Thu, 17 Jul 2025 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794921;
	bh=bIO44M4iorNfvtN5lpmXZqYvy6G//VE/x037+7F4KiQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ePYEYUFaw9nuY4F4q50Ibyd3vjy/5/Hs51oTg0IFUBcSWoI2XfffqykSZQYwZXyDY
	 +pKD8GNREUMYhsULxc81sgypq6ThBd02YEBY3R6dGpEQv9bIANok+tKgN6DhkuX3q4
	 NgK6pO88slGhdemt2rnM6K5N6Mn+fzGYqUVcUWrOLrUlumfg1NNnvRfZDeH3J6IfU+
	 SZ5iVu6Xm9WuT+f/VJmGptthMP1pgpJjJfOlWAugJHBAtjkq6splPcu9tWCbmQelab
	 DYt325wcxu9tQSXpgFkpRvJQPJHCIsSyewOt0W9FB36G0ue4nCF1S+VeMvnTonmYPI
	 5HF5DIWU1nOpg==
Date: Thu, 17 Jul 2025 16:28:40 -0700
Subject: [PATCH 02/13] fuse: add an ioctl to add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449980.711291.5397428780418282445.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add an ioctl that allows fuse servers to register block devices for use
with iomap.  This is (for now) separate from the backing file open/close
ioctl (despite using the same struct) to keep the codepaths separate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   27 +++++
 fs/fuse/fuse_trace.h      |   62 +++++++++++
 include/uapi/linux/fuse.h |    3 +
 fs/fuse/dev.c             |   21 ++++
 fs/fuse/file_iomap.c      |  243 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   13 ++
 6 files changed, 361 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b6dc9226f3d77f..12c462a29fe0c4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -616,6 +616,19 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+struct fuse_iomap_conn {
+	struct idr device_map;
+};
+
+struct fuse_iomap_dev {
+	struct file *file;
+	struct block_device *bdev;
+
+	/** refcount */
+	refcount_t count;
+	struct rcu_head rcu;
+};
+
 /**
  * A Fuse connection.
  *
@@ -970,6 +983,10 @@ struct fuse_conn {
 	struct fuse_ring *ring;
 #endif
 
+#ifdef CONFIG_FUSE_IOMAP
+	struct fuse_iomap_conn iomap_conn;
+#endif
+
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
@@ -1616,9 +1633,19 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 {
 	return get_fuse_conn_c(inode)->iomap;
 }
+
+bool fuse_iomap_fill_super(struct fuse_mount *fm);
+int fuse_iomap_conn_alloc(struct fuse_conn *fc);
+void fuse_iomap_conn_put(struct fuse_conn *fc);
+
+int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_fill_super(...)		(true)
+# define fuse_iomap_conn_alloc(...)		(0)
+# define fuse_iomap_conn_put(...)		((void)0)
+# define fuse_iomap_dev_add(...)		(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index ecf9332321a1e6..5c8533053f8eed 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -410,6 +410,68 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->pos, __entry->count, __entry->written,
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_dev_add,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_backing_map *map),
+
+	TP_ARGS(fc, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(int,		fd)
+		__field(unsigned int,	flags)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->fd		=	map->fd;
+		__entry->flags		=	map->flags;
+	),
+
+	TP_printk("connection %u fd %d flags 0x%x",
+		  __entry->connection,
+		  __entry->fd,
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_dev_class,
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
+		 const struct fuse_iomap_dev *fb),
+
+	TP_ARGS(fc, idx, fb),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(unsigned int,	idx)
+		__field(dev_t,		bdev)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->idx		=	idx;
+
+		if (fb) {
+			struct inode *inode = file_inode(fb->file);
+
+			__entry->bdev	=	inode->i_rdev;
+		} else {
+			__entry->bdev	=	0;
+		}
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
+		 const struct fuse_iomap_dev *fb), \
+	TP_ARGS(fc, idx, fb))
+DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_add_dev);
+DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_remove_dev);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 501f4d838e654f..2fe83fc196b021 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -239,6 +239,7 @@
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} handlers for FIEMAP and
  *    SEEK_{DATA,HOLE} support
+ *  - add FUSE_DEV_IOC_IOMAP_DEV_ADD to configure block devices for iomap
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1136,6 +1137,8 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_IOMAP_DEV_ADD	_IOW(FUSE_DEV_IOC_MAGIC, 3, \
+					     struct fuse_backing_map)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8dd74cbfbcc6fc..49ff2c6654e768 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2633,6 +2633,24 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	return fuse_backing_open(fud->fc, &map);
 }
 
+static long fuse_dev_ioctl_iomap_dev_add(struct file *file,
+					 struct fuse_backing_map __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing_map map;
+
+	if (!fud)
+		return -EPERM;
+
+	if (!IS_ENABLED(CONFIG_FUSE_IOMAP))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&map, argp, sizeof(map)))
+		return -EFAULT;
+
+	return fuse_iomap_dev_add(fud->fc, &map);
+}
+
 static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
@@ -2665,6 +2683,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_IOMAP_DEV_ADD:
+		return fuse_dev_ioctl_iomap_dev_add(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index a206a9254df3fe..535429023d37e7 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -189,9 +189,6 @@ fuse_iomap_begin_validate(const struct fuse_iomap_begin_out *outarg,
 		return -EIO;
 	}
 
-	/* XXX: Check the device cookie */
-	ASSERT(outarg->read_dev == 0);
-
 	/* No overflows in the device range, if supplied */
 	if (outarg->read_addr != FUSE_IOMAP_NULL_ADDR &&
 	    BAD_DATA(check_add_overflow(outarg->read_addr, outarg->length, &end)))
@@ -220,6 +217,98 @@ static inline bool fuse_is_iomap_file_write(unsigned int opflags)
 	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
 }
 
+static struct fuse_iomap_dev *fuse_iomap_dev_get(struct fuse_iomap_dev *fb)
+{
+	if (fb && refcount_inc_not_zero(&fb->count))
+		return fb;
+	return NULL;
+}
+
+static void fuse_iomap_dev_free(struct fuse_iomap_dev *fb)
+{
+	if (fb->file)
+		fput(fb->file);
+	kfree_rcu(fb, rcu);
+}
+
+static void fuse_iomap_dev_put(struct fuse_iomap_dev *fb)
+{
+	if (fb && refcount_dec_and_test(&fb->count))
+		fuse_iomap_dev_free(fb);
+}
+
+static int fuse_iomap_dev_id_alloc(struct fuse_conn *fc,
+				   struct fuse_iomap_dev *fb)
+{
+	int id;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->lock);
+	id = idr_alloc_cyclic(&fc->iomap_conn.device_map, fb, 1, 0,
+			      GFP_ATOMIC);
+	spin_unlock(&fc->lock);
+	idr_preload_end();
+
+	trace_fuse_iomap_add_dev(fc, id, fb);
+
+	return id;
+}
+
+static struct fuse_iomap_dev *fuse_iomap_dev_id_remove(struct fuse_conn *fc,
+						       int id)
+{
+	struct fuse_iomap_dev *fb;
+
+	spin_lock(&fc->lock);
+	fb = idr_remove(&fc->iomap_conn.device_map, id);
+	spin_unlock(&fc->lock);
+
+	if (fb)
+		trace_fuse_iomap_remove_dev(fc, id, fb);
+
+	return fb;
+}
+
+static inline struct fuse_iomap_dev *
+fuse_iomap_dev_id_find(struct fuse_conn *fc, int idx)
+{
+	struct fuse_iomap_dev *fb;
+
+	rcu_read_lock();
+	fb = idr_find(&fc->iomap_conn.device_map, idx);
+	fb = fuse_iomap_dev_get(fb);
+	rcu_read_unlock();
+
+	return fb;
+}
+
+static inline struct fuse_iomap_dev *
+fuse_iomap_find_dev(struct fuse_conn *fc, uint16_t map_type, uint32_t map_dev)
+{
+	struct fuse_iomap_dev *ret = NULL;
+
+	if (map_dev != FUSE_IOMAP_DEV_NULL && map_dev < INT_MAX)
+		ret = fuse_iomap_dev_id_find(fc, map_dev);
+
+	switch (map_type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(ret == NULL))
+			return ERR_PTR(-EIO);
+		break;
+	}
+
+	return ret;
+}
+
+static inline void
+fuse_iomap_set_device(struct iomap *iomap, const struct fuse_iomap_dev *fb)
+{
+	iomap->bdev = fb ? fb->bdev : NULL;
+	iomap->dax_dev = NULL;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -233,6 +322,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_iomap_dev *read_dev = NULL;
+	struct fuse_iomap_dev *write_dev = NULL;
 	FUSE_ARGS(args);
 	int err;
 
@@ -259,8 +350,21 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	read_dev = fuse_iomap_find_dev(fm->fc, outarg.read_type,
+				       outarg.read_dev);
+	if (IS_ERR(read_dev))
+		return PTR_ERR(read_dev);
+
 	if (fuse_is_iomap_file_write(opflags) &&
 	    outarg.write_type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+
+		write_dev = fuse_iomap_find_dev(fm->fc, outarg.write_type,
+						outarg.write_dev);
+		if (IS_ERR(write_dev)) {
+			err = PTR_ERR(write_dev);
+			goto out_read_dev;
+		}
+
 		/*
 		 * For an out of place write, we must supply the write mapping
 		 * via @iomap, and the read mapping via @srcmap.
@@ -270,14 +374,14 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		iomap->length = outarg.length;
 		iomap->type = outarg.write_type;
 		iomap->flags = outarg.write_flags;
-		iomap->bdev = inode->i_sb->s_bdev;
+		fuse_iomap_set_device(iomap, write_dev);
 
 		srcmap->addr = outarg.read_addr;
 		srcmap->offset = outarg.offset;
 		srcmap->length = outarg.length;
 		srcmap->type = outarg.read_type;
 		srcmap->flags = outarg.read_flags;
-		srcmap->bdev = inode->i_sb->s_bdev;
+		fuse_iomap_set_device(srcmap, read_dev);
 	} else {
 		/*
 		 * For everything else (reads, reporting, and pure overwrites),
@@ -289,10 +393,19 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		iomap->length = outarg.length;
 		iomap->type = outarg.read_type;
 		iomap->flags = outarg.read_flags;
-		iomap->bdev = inode->i_sb->s_bdev;
+		fuse_iomap_set_device(iomap, read_dev);
 	}
 
-	return 0;
+	/*
+	 * XXX: if we ever want to support closing devices, we need a way to 
+	 * track the fuse_iomap_dev refcount all the way through bio endios.
+	 * For now we put the refcount here because you can't remove an iomap
+	 * device until unmount time.
+	 */
+	fuse_iomap_dev_put(write_dev);
+out_read_dev:
+	fuse_iomap_dev_put(read_dev);
+	return err;
 }
 
 static bool fuse_want_iomap_end(const struct iomap *iomap, unsigned int opflags,
@@ -356,3 +469,119 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
+
+int fuse_iomap_conn_alloc(struct fuse_conn *fc)
+{
+	idr_init(&fc->iomap_conn.device_map);
+	return 0;
+}
+
+static int fuse_iomap_dev_id_free(int id, void *p, void *data)
+{
+	struct fuse_iomap_dev *fb = p;
+	struct fuse_conn *fc = data;
+
+	trace_fuse_iomap_remove_dev(fc, id, fb);
+
+	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+	fuse_iomap_dev_free(fb);
+	return 0;
+}
+
+void fuse_iomap_conn_put(struct fuse_conn *fc)
+{
+	idr_for_each(&fc->iomap_conn.device_map, fuse_iomap_dev_id_free, fc);
+	idr_destroy(&fc->iomap_conn.device_map);
+}
+
+static struct fuse_iomap_dev *fuse_iomap_dev_alloc(struct file *file)
+{
+	struct fuse_iomap_dev *fb =
+			kmalloc(sizeof(struct fuse_iomap_dev), GFP_KERNEL);
+
+	if (!fb)
+		return NULL;
+
+	fb->file = file;
+	fb->bdev = I_BDEV(file->f_mapping->host);
+	refcount_set(&fb->count, 1);
+
+	return fb;
+}
+
+bool fuse_iomap_fill_super(struct fuse_mount *fm)
+{
+	struct fuse_conn *fc = fm->fc;
+	struct super_block *sb = fm->sb;
+	int res;
+
+	if (sb->s_bdev) {
+		/*
+		 * Try to install s_bdev as the first iomap device, if this
+		 * is a block-device filesystem.
+		 */
+		struct fuse_iomap_dev *fb =
+					fuse_iomap_dev_alloc(sb->s_bdev_file);
+
+		if (!fb)
+			return false;
+
+		res = fuse_iomap_dev_id_alloc(fc, fb);
+		if (res < 0)
+			return false;
+		if (res != 1) {
+			struct fuse_iomap_dev *bad =
+					fuse_iomap_dev_id_remove(fc, res);
+
+			ASSERT(res == 1);
+			ASSERT(bad == fb);
+			fuse_iomap_dev_put(bad);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map)
+{
+	struct file *file;
+	struct fuse_iomap_dev *fb = NULL;
+	int res;
+
+	trace_fuse_iomap_dev_add(fc, map);
+
+	res = -EPERM;
+	if (!fc->iomap)
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
+	res = -ENODEV;
+	if (!S_ISBLK(file_inode(file)->i_mode))
+		goto out_fput;
+
+	fb = fuse_iomap_dev_alloc(file);
+	if (!fb)
+		goto out_fput;
+
+	res = fuse_iomap_dev_id_alloc(fc, fb);
+	if (res < 0) {
+		fuse_iomap_dev_free(fb);
+		goto out;
+	}
+
+	return res;
+
+out_fput:
+	fput(file);
+out:
+	return res;
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6173795d3826d0..8266f30bc8a954 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1015,6 +1015,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		struct fuse_iqueue *fiq = &fc->iq;
 		struct fuse_sync_bucket *bucket;
 
+		fuse_iomap_conn_put(fc);
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
 		if (fc->timeout.req_timeout)
@@ -1454,6 +1455,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		init_server_timeout(fc, timeout);
 
+		if (fc->iomap && !fuse_iomap_fill_super(fm))
+			ok = false;
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
@@ -1823,10 +1827,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	sb->s_subtype = ctx->subtype;
 	ctx->subtype = NULL;
+
+	err = fuse_iomap_conn_alloc(fc);
+	if (err)
+		goto err;
+
 	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
 		err = fuse_dax_conn_alloc(fc, ctx->dax_mode, ctx->dax_dev);
 		if (err)
-			goto err;
+			goto err_free_iomap;
 	}
 
 	if (ctx->fudptr) {
@@ -1888,6 +1897,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
  err_dev_free:
 	if (fud)
 		fuse_dev_free(fud);
+ err_free_iomap:
+	fuse_iomap_conn_put(fc);
  err_free_dax:
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);


