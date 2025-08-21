Return-Path: <linux-fsdevel+bounces-58447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BFB2E9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1AFD4E1DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861541E493C;
	Thu, 21 Aug 2025 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eorD9ms9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE3C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737645; cv=none; b=a88na4QI9Dm7ozgNEsuBVH3UzuXSueuOewSspZqFNQ2FNLURuYmWGts9Xvp4Q6CkEdhWDCdHogPHjCw8IslrRIwEgXLDxifoNhDvddj47sfW5Y3N7JgZFjIJQy4iFWKyuyBUVgatgb7Nbfx2hy8DLHq4axkCN1tLh6Q+KrzhTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737645; c=relaxed/simple;
	bh=FxY4DALLZIvgeWI2CZyfjSWReOSv3jDsjtk47VJ1epA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBb+8N1a3scHkzEikSS6O6R222IAiogYe4x+RzPtmWXYa2DkkwJJrBTYoRH7Jea+PdLwMs6EbTrgDNG/y7WNmU6FjPMLOSI9f62G/Z/pM56FKuXcXS5Vc0S4M6HD6F4DmEMx+0TrTiiRpFrfR+SjDzlhjXL/32ROSVfpaVV2ODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eorD9ms9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74252C4CEEB;
	Thu, 21 Aug 2025 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737644;
	bh=FxY4DALLZIvgeWI2CZyfjSWReOSv3jDsjtk47VJ1epA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eorD9ms9NMh0HekLtD1b1DOPP1LR0jvWqnjK4ZlCom5p7NmClI9yEEWd8IHf6w4qC
	 93Qut/50y3JF+NC+vYy3e1msHNOQ20Cv+2dRPBNMHyDlxUy+MOoGvQPOpzAdu2W2Uy
	 MdyT2QvdVkd+PYj2S7Y6ArOjEhMhiypR48oecdMnV7GwNc6V7Utjk/TgNoE06rvulg
	 j+GLq1RCLI4gJRI/p0thZW8o2lY03Zd43Rlh35y+YuTbsveOdf6PsJj8xHRanZKFkT
	 +rzz+sLw26C/nMS8mCUoeeLC9rG1WldfhNc9vnsgwCz/nAWuLwXqs5GA0Fy9KBEBC6
	 3dZF4L/sv+ZtQ==
Date: Wed, 20 Aug 2025 17:54:04 -0700
Subject: [PATCH 06/23] fuse: add an ioctl to add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709244.17510.7992044692651721971.stgit@frogsfrogsfrogs>
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

Add an ioctl that allows fuse servers to register block devices for use
with iomap.  This is (for now) separate from the backing file open/close
ioctl (despite using the same struct) to keep the codepaths separate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h      |    9 +++++
 fs/fuse/fuse_trace.h  |   49 ++++++++++++++++++++++++++-
 fs/fuse/Kconfig       |    1 +
 fs/fuse/backing.c     |   19 ++++++++---
 fs/fuse/file_iomap.c  |   88 ++++++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/passthrough.c |   13 +++++++
 fs/fuse/trace.c       |    1 +
 7 files changed, 163 insertions(+), 17 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1762517a1b99c8..f4834a02d16c98 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -100,6 +100,10 @@ struct fuse_submount_lookup {
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	struct block_device *bdev;
+
+	unsigned int passthrough:1;
+	unsigned int iomap:1;
 
 	/** refcount */
 	refcount_t count;
@@ -1639,9 +1643,14 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 {
 	return get_fuse_conn_c(inode)->iomap;
 }
+
+int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *fb);
+int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
+# define fuse_iomap_backing_open(...)		(-EOPNOTSUPP)
+# define fuse_iomap_backing_close(...)		(-EOPNOTSUPP)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 660d9b5206a175..c3671a605a32f6 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -175,6 +175,13 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #ifdef CONFIG_FUSE_BACKING
+#define FUSE_BACKING_PASSTHROUGH	(1U << 0)
+#define FUSE_BACKING_IOMAP		(1U << 1)
+
+#define FUSE_BACKING_FLAG_STRINGS \
+	{ FUSE_BACKING_PASSTHROUGH,		"pass" }, \
+	{ FUSE_BACKING_IOMAP,			"iomap" }
+
 TRACE_EVENT(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
 		 const struct fuse_backing *fb),
@@ -184,7 +191,9 @@ TRACE_EVENT(fuse_backing_class,
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
 		__field(unsigned int,		idx)
+		__field(unsigned int,		flags)
 		__field(unsigned long,		ino)
+		__field(dev_t,			rdev)
 	),
 
 	TP_fast_assign(
@@ -193,12 +202,23 @@ TRACE_EVENT(fuse_backing_class,
 		__entry->connection	=	fc->dev;
 		__entry->idx		=	idx;
 		__entry->ino		=	inode->i_ino;
+		__entry->flags		=	0;
+		if (fb->passthrough)
+			__entry->flags	|=	FUSE_BACKING_PASSTHROUGH;
+		if (fb->iomap) {
+			__entry->rdev	=	inode->i_rdev;
+			__entry->flags	|=	FUSE_BACKING_IOMAP;
+		} else {
+			__entry->rdev	=	0;
+		}
 	),
 
-	TP_printk("connection %u idx %u ino 0x%lx",
+	TP_printk("connection %u idx %u flags (%s) ino 0x%lx rdev %u:%u",
 		  __entry->connection,
 		  __entry->idx,
-		  __entry->ino)
+		  __print_flags(__entry->flags, "|", FUSE_BACKING_FLAG_STRINGS),
+		  __entry->ino,
+		  MAJOR(__entry->rdev), MINOR(__entry->rdev))
 );
 #define DEFINE_FUSE_BACKING_EVENT(name)		\
 DEFINE_EVENT(fuse_backing_class, name,		\
@@ -210,7 +230,6 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
-
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -452,6 +471,30 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->written,
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
+		__field(dev_t,			connection)
+		__field(int,			fd)
+		__field(unsigned int,		flags)
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
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ebb9a2d76b532e..1ab3d3604c07d0 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,6 +75,7 @@ config FUSE_IOMAP
 	depends on FUSE_FS
 	depends on BLOCK
 	select FS_IOMAP
+	select FUSE_BACKING
 	help
 	  For supported fuseblk servers, this allows the file IO path to run
 	  through the kernel.
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c128bed95a76b8..c63990254649ca 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -67,16 +67,19 @@ static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
 
 static int fuse_backing_id_free(int id, void *p, void *data)
 {
+	struct fuse_conn *fc = data;
 	struct fuse_backing *fb = p;
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+
+	trace_fuse_backing_close(fc, id, fb);
 	fuse_backing_free(fb);
 	return 0;
 }
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
 	idr_destroy(&fc->backing_files_map);
 }
 
@@ -84,12 +87,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 {
 	struct file *file = NULL;
 	struct fuse_backing *fb = NULL;
-	int res, passthrough_res;
+	int res, passthrough_res, iomap_res;
 
 	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
 
 	res = -EPERM;
-	if (!fc->passthrough)
+	if (!fc->passthrough && !fc->iomap)
 		goto out;
 
 	res = -EINVAL;
@@ -125,10 +128,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	 * default.
 	 */
 	passthrough_res = fuse_passthrough_backing_open(fc, fb);
+	iomap_res = fuse_iomap_backing_open(fc, fb);
 
 	if (refcount_read(&fb->count) < 2) {
 		if (passthrough_res)
 			res = passthrough_res;
+		if (!res && iomap_res)
+			res = iomap_res;
 		if (!res)
 			res = -EPERM;
 		goto out_fb;
@@ -157,12 +163,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 {
 	struct fuse_backing *fb = NULL, *test_fb;
-	int err, passthrough_err;
+	int err, passthrough_err, iomap_err;
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
 	err = -EPERM;
-	if (!fc->passthrough)
+	if (!fc->passthrough && !fc->iomap)
 		goto out;
 
 	err = -EINVAL;
@@ -187,10 +193,13 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	 * error code will be passed up.  EBUSY is the default.
 	 */
 	passthrough_err = fuse_passthrough_backing_close(fc, fb);
+	iomap_err = fuse_iomap_backing_close(fc, fb);
 
 	if (refcount_read(&fb->count) > 1) {
 		if (passthrough_err)
 			err = passthrough_err;
+		if (!err && iomap_err)
+			err = iomap_err;
 		if (!err)
 			err = -EBUSY;
 		goto out_fb;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index fad5457d669baf..154c99399f48d2 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -319,10 +319,6 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		return false;
 	}
 
-	/* XXX: we don't support devices yet */
-	if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
-		return false;
-
 	/* No overflows in the device range, if supplied */
 	if (map->addr != FUSE_IOMAP_NULL_ADDR &&
 	    BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
@@ -334,6 +330,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 /* Convert a mapping from the server into something the kernel can use */
 static inline void fuse_iomap_from_server(struct inode *inode,
 					  struct iomap *iomap,
+					  const struct fuse_backing *fb,
 					  const struct fuse_iomap_io *fmap)
 {
 	iomap->addr = fmap->addr;
@@ -341,7 +338,9 @@ static inline void fuse_iomap_from_server(struct inode *inode,
 	iomap->length = fmap->length;
 	iomap->type = fuse_iomap_type_from_server(fmap->type);
 	iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
-	iomap->bdev = inode->i_sb->s_bdev; /* XXX */
+
+	iomap->bdev = fb ? fb->bdev : NULL;
+	iomap->dax_dev = NULL;
 }
 
 /* Convert a mapping from the server into something the kernel can use */
@@ -392,6 +391,32 @@ static inline bool fuse_is_iomap_file_write(unsigned int opflags)
 	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
 }
 
+static inline struct fuse_backing *
+fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
+{
+	struct fuse_backing *ret = NULL;
+
+	if (map->dev != FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
+		ret = fuse_backing_lookup(fc, map->dev);
+
+	switch (map->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(ret == NULL))
+			return ERR_PTR(-EFSCORRUPTED);
+		break;
+	}
+
+	/* Must be one of our open devices */
+	if (ret && BAD_DATA(ret->iomap == 0)) {
+		fuse_backing_put(ret);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
+	return ret;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -405,6 +430,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *read_dev = NULL;
+	struct fuse_backing *write_dev = NULL;
 	FUSE_ARGS(args);
 	int err;
 
@@ -431,24 +458,44 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	read_dev = fuse_iomap_find_dev(fm->fc, &outarg.read);
+	if (IS_ERR(read_dev))
+		return PTR_ERR(read_dev);
+
 	if (fuse_is_iomap_file_write(opflags) &&
 	    outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		/* open the write device */
+		write_dev = fuse_iomap_find_dev(fm->fc, &outarg.write);
+		if (IS_ERR(write_dev)) {
+			err = PTR_ERR(write_dev);
+			goto out_read_dev;
+		}
+
 		/*
 		 * For an out of place write, we must supply the write mapping
 		 * via @iomap, and the read mapping via @srcmap.
 		 */
-		fuse_iomap_from_server(inode, iomap, &outarg.write);
-		fuse_iomap_from_server(inode, srcmap, &outarg.read);
+		fuse_iomap_from_server(inode, iomap, write_dev, &outarg.write);
+		fuse_iomap_from_server(inode, srcmap, read_dev, &outarg.read);
 	} else {
 		/*
 		 * For everything else (reads, reporting, and pure overwrites),
 		 * we can return the sole mapping through @iomap and leave
 		 * @srcmap unchanged from its default (HOLE).
 		 */
-		fuse_iomap_from_server(inode, iomap, &outarg.read);
+		fuse_iomap_from_server(inode, iomap, read_dev, &outarg.read);
 	}
 
-	return 0;
+	/*
+	 * XXX: if we ever want to support closing devices, we need a way to
+	 * track the fuse_backing refcount all the way through bio endios.
+	 * For now we put the refcount here because you can't remove an iomap
+	 * device until unmount time.
+	 */
+	fuse_backing_put(write_dev);
+out_read_dev:
+	fuse_backing_put(read_dev);
+	return err;
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
@@ -523,3 +570,26 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
+
+int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	if (!fc->iomap)
+		return 0;
+
+	if (!S_ISBLK(file_inode(fb->file)->i_mode))
+		return -ENODEV;
+
+	fb->iomap = 1;
+	fb->bdev = I_BDEV(fb->file->f_mapping->host);
+	fuse_backing_get(fb);
+	return 0;
+}
+
+int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	if (!fb->iomap)
+		return 0;
+
+	/* We only support closing iomap block devices at unmount */
+	return -EBUSY;
+}
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index dfc61cc4bd21af..29de6de9f4b59b 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -168,6 +168,11 @@ struct fuse_backing *fuse_passthrough_open(struct file *file,
 	if (!fb)
 		goto out;
 
+	if (!fb->passthrough) {
+		fuse_backing_put(fb);
+		goto out;
+	}
+
 	/* Allocate backing file per fuse file to store fuse path */
 	backing_file = backing_file_open(&file->f_path, file->f_flags,
 					 &fb->file->f_path, fb->cred);
@@ -203,6 +208,9 @@ int fuse_passthrough_backing_open(struct fuse_conn *fc,
 {
 	struct super_block *backing_sb;
 
+	if (!fc->passthrough)
+		return 0;
+
 	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -211,6 +219,7 @@ int fuse_passthrough_backing_open(struct fuse_conn *fc,
 	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
 		return -ELOOP;
 
+	fb->passthrough = 1;
 	fuse_backing_get(fb);
 	return 0;
 }
@@ -218,10 +227,14 @@ int fuse_passthrough_backing_open(struct fuse_conn *fc,
 int fuse_passthrough_backing_close(struct fuse_conn *fc,
 				   struct fuse_backing *fb)
 {
+	if (!fb->passthrough)
+		return 0;
+
 	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	fb->passthrough = 0;
 	fuse_backing_put(fb);
 	return 0;
 }
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 93bd72efc98cd0..3b54f639a5423e 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -6,6 +6,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "iomap_priv.h"
 
 #include <linux/pagemap.h>
 


