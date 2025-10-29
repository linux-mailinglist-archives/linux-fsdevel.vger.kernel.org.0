Return-Path: <linux-fsdevel+bounces-66006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55510C179E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0014F3A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAE2D29A9;
	Wed, 29 Oct 2025 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGM1g+W0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5141C62;
	Wed, 29 Oct 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698760; cv=none; b=snJ2DUho/PjmNp3287fMaxB0Wh2EIyIjpDvAckn/YnCOPjZfkKwA3lOBhAV8n146EhnZhn1yJPUPzHekGvUrD9Ujuhec1xAr5MS/xJiEo4sP9TrWgnkejdoJ4oMAFdcjOGNV+pEhM58Xr8F3ZT7o97cJOIArTM0nMfwfpXN80RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698760; c=relaxed/simple;
	bh=ysXbfxYOzz2c0n9llovm7lCJWIm73hiRqnOrO6R+0nY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBMAQZYUkObena1Hwsi1ZBMRWRJkrbY+9ILaVLv4UZzuN384tcBw2SLhNPYBvX51UObClqx8rfFPOFs5HNlwaG5D7hf2fyTzqL3u7/L7XwhMbuQImXbMafar+CDUqp5Ie38mEzNQIRY8PeTZVT8JNvXyozxPxvsrpDX4GeHug0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGM1g+W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88532C4CEE7;
	Wed, 29 Oct 2025 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698760;
	bh=ysXbfxYOzz2c0n9llovm7lCJWIm73hiRqnOrO6R+0nY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EGM1g+W0y+qQ7++HtIgYNkc4TYuYW3BFMMMXDnngAJveAEhYvY0o6IZs8eyDkoA72
	 ib3/TQp/6v80xp6IXzdxViE9h4uMFPTUvuKjRxwlG2UE8zXDk1vXBxzCeCYlFQOiJH
	 7xEXV+4Btftlj2k4IA44SNz2wDhcS0V5tQDH5qTOZ6uvBtpt0ihyNpIRfRz0hGPDHr
	 gUuwF/TZWQPW2zzEhJhDVjy/rjcynknb6HIyX7GUT4NWBsmVynq4vgi010ZOBKkPFp
	 0Ja25JUcOTP8VKsHB8ySZQpyuo58OXSzZrrIb9Un/ZgD1Z2UMMlj3994JrpWlTijtG
	 RfiqnPiN7Rz1w==
Date: Tue, 28 Oct 2025 17:46:00 -0700
Subject: [PATCH 04/31] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add
 new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810437.1424854.11837235220839490843.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable the use of the backing file open/close ioctls so that fuse
servers can register block devices for use with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    5 ++
 include/uapi/linux/fuse.h |    3 +
 fs/fuse/Kconfig           |    1 
 fs/fuse/backing.c         |   12 +++++
 fs/fuse/file_iomap.c      |  101 +++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/trace.c           |    1 
 6 files changed, 113 insertions(+), 10 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 61fb65f3604d61..274de907257d94 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -97,12 +97,14 @@ struct fuse_submount_lookup {
 };
 
 struct fuse_conn;
+struct fuse_backing;
 
 /** Operations for subsystems that want to use a backing file */
 struct fuse_backing_ops {
 	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
 	int (*may_open)(struct fuse_conn *fc, struct file *file);
 	int (*may_close)(struct fuse_conn *fc, struct file *file);
+	int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
 	unsigned int type;
 	int id_start;
 	int id_end;
@@ -112,6 +114,7 @@ struct fuse_backing_ops {
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	struct block_device *bdev;
 	const struct fuse_backing_ops *ops;
 
 	/** refcount */
@@ -1706,6 +1709,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 {
 	return get_fuse_conn(inode)->iomap;
 }
+
+extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7d709cf12b41a7..e571f8ceecbfad 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1136,7 +1136,8 @@ struct fuse_notify_prune_out {
 
 #define FUSE_BACKING_TYPE_MASK		(0xFF)
 #define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
-#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_PASSTHROUGH)
+#define FUSE_BACKING_TYPE_IOMAP		(1)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_IOMAP)
 
 #define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
 
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index bb867afe6e867c..52803c533f47f9 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,6 +75,7 @@ config FUSE_IOMAP
 	depends on FUSE_FS
 	depends on BLOCK
 	select FS_IOMAP
+	select FUSE_BACKING
 	help
 	  Enable fuse servers to operate the regular file I/O path through
 	  the fs-iomap library in the kernel.  This enables higher performance
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index b83a3c1b2dff7a..7786f6e5fd02f2 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -90,6 +90,10 @@ fuse_backing_ops_from_map(const struct fuse_backing_map *map)
 #ifdef CONFIG_FUSE_PASSTHROUGH
 	case FUSE_BACKING_TYPE_PASSTHROUGH:
 		return &fuse_passthrough_backing_ops;
+#endif
+#ifdef CONFIG_FUSE_IOMAP
+	case FUSE_BACKING_TYPE_IOMAP:
+		return &fuse_iomap_backing_ops;
 #endif
 	default:
 		break;
@@ -138,8 +142,16 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	fb->file = file;
 	fb->cred = prepare_creds();
 	fb->ops = ops;
+	fb->bdev = NULL;
 	refcount_set(&fb->count, 1);
 
+	res = ops->post_open ? ops->post_open(fc, fb) : 0;
+	if (res) {
+		fuse_backing_free(fb);
+		fb = NULL;
+		goto out;
+	}
+
 	res = fuse_backing_id_alloc(fc, fb);
 	if (res < 0) {
 		fuse_backing_free(fb);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index b6fc70068c5542..e4fea3bdc0c2ce 100644
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
 
 /* Convert a mapping from the kernel into something the server can use */
@@ -392,6 +391,27 @@ static inline bool fuse_is_iomap_file_write(unsigned int opflags)
 	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
 }
 
+static inline struct fuse_backing *
+fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
+{
+	struct fuse_backing *ret = NULL;
+
+	if (map->dev != FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
+		ret = fuse_backing_lookup(fc, &fuse_iomap_backing_ops,
+					  map->dev);
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
+	return ret;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -405,6 +425,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *read_dev = NULL;
+	struct fuse_backing *write_dev = NULL;
 	FUSE_ARGS(args);
 	int err;
 
@@ -431,24 +453,44 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
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
@@ -523,3 +565,44 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
+
+static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
+{
+	if (!fc->iomap)
+		return -EPERM;
+
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int fuse_iomap_may_open(struct fuse_conn *fc, struct file *file)
+{
+	if (!S_ISBLK(file_inode(file)->i_mode))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int fuse_iomap_post_open(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	fb->bdev = I_BDEV(fb->file->f_mapping->host);
+	return 0;
+}
+
+static int fuse_iomap_may_close(struct fuse_conn *fc, struct file *file)
+{
+	/* We only support closing iomap block devices at unmount */
+	return -EBUSY;
+}
+
+const struct fuse_backing_ops fuse_iomap_backing_ops = {
+	.type = FUSE_BACKING_TYPE_IOMAP,
+	.id_start = 1,
+	.id_end = 1025,		/* maximum 1024 block devices */
+	.may_admin = fuse_iomap_may_admin,
+	.may_open = fuse_iomap_may_open,
+	.may_close = fuse_iomap_may_close,
+	.post_open = fuse_iomap_post_open,
+};
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 93bd72efc98cd0..68d2eecb8559a5 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -6,6 +6,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "iomap_i.h"
 
 #include <linux/pagemap.h>
 


