Return-Path: <linux-fsdevel+bounces-66109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0FC17CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F9500AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601202D94B5;
	Wed, 29 Oct 2025 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDUihVrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC441EF0B0;
	Wed, 29 Oct 2025 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700372; cv=none; b=OWqxPmuXrQLrPZonScn9TkDZcc5Nxs7orBM24isU0Qf8PseEyXqSWxolgbRfAM73Xi8lXeVyxK3FHuWIyMBXUnSve33fWKLbTOvUTQK+1ZZxaTzCAAC+cFcA9WcB5J5hpwtPLl0NYYM3TLEtqyOCjPJiCNZjP9D0nUEa2EkDuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700372; c=relaxed/simple;
	bh=a/O9OB3U7ib7uli0or+GNdj0EnY1+WgtsrgxCK935Ls=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+0zXS2dXmDgoWizpd+i+IDtBJ1mixfYOAcRJzfq0gGLb04V+zxeDIV23FNpXFpdjqN2sbzsj1qUQFgIj9pjBtVDkIxMpr/sZJ1KpOoIqoQuJmyWza+8XqlLYxEpgMaE+9SymIajNDWG2NBJlMqyl7LY/r3wZG0936xhqR/58yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDUihVrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31295C4CEE7;
	Wed, 29 Oct 2025 01:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700372;
	bh=a/O9OB3U7ib7uli0or+GNdj0EnY1+WgtsrgxCK935Ls=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bDUihVrJp6B/NmoJQ3DiOeme+e/0H7mqDiWh0+Tgo9SsHs3pPS3N3UYMPct0a3lbg
	 dilAyg3wL+GuyvKls8Y0jdtgeCERGJIscL+2Fv1bfvvbWuk7/y8FKgZycwVVGabaYS
	 8RkS19HnXdHDG8szoRZKcGahW3bR61ZVhRUT7VEBaxPoNPhUMDw8jrwjbccGfN9ver
	 75oWw/64aAav4KtKKbf0NMdo9ft++B6NLx5I+We2/RGaCIq9jxijKCWpOQUBtDBIIX
	 pQuWZVaeAmyIOjKh1aPMnwY7XdPb/j3eM2kjo8uGPQ3b36MwuAxEXovKwCs9mO1xlE
	 jcHsxyo7bX8og==
Date: Tue, 28 Oct 2025 18:12:51 -0700
Subject: [PATCH 17/17] fuse2fs: enable atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817873.1429568.4805622485351937995.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Advertise the single-fsblock atomic write capability that iomap can do.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse2fs.c    |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 564b3fc75a31c0..544ad9ecb06d45 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -285,6 +285,9 @@ struct fuse4fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -910,10 +913,22 @@ static inline bool fuse4fs_can_iomap(const struct fuse4fs *ff)
 {
 	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
 }
+
+static inline bool fuse4fs_iomap_supports_hw_atomic(const struct fuse4fs *ff)
+{
+	return fuse4fs_iomap_enabled(ff) &&
+	       (ff->iomap_cap & FUSE_IOMAP_SUPPORT_ATOMIC) &&
+#ifdef STATX_WRITE_ATOMIC
+		ff->awu_min > 0 && ff->awu_min > 0;
+#else
+		0;
+#endif
+}
 #else
 # define fuse4fs_iomap_enabled(...)	(0)
 # define fuse4fs_discover_iomap(...)	((void)0)
 # define fuse4fs_can_iomap(...)		(false)
+# define fuse4fs_iomap_supports_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
@@ -2109,8 +2124,12 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
 	fstat->iflags = 0;
 #ifdef HAVE_FUSE_IOMAP
-	if (fuse4fs_iomap_enabled(ff))
+	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP;
+
+		if (fuse4fs_iomap_supports_hw_atomic(ff))
+			fstat->iflags |= FUSE_IFLAG_ATOMIC;
+	}
 #endif
 
 	return 0;
@@ -2288,6 +2307,15 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse4fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse4fs_iomap_supports_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -6664,6 +6692,9 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -6828,6 +6859,38 @@ static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
 	return -EIO;
 }
 
+#ifdef STATX_WRITE_ATOMIC
+static void fuse4fs_configure_atomic_write(struct fuse4fs *ff, int bdev_fd)
+{
+	struct statx devx;
+	unsigned int awu_min, awu_max;
+	int ret;
+
+	if (!ext2fs_has_feature_extents(ff->fs->super))
+		return;
+
+	ret = statx(bdev_fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &devx);
+	if (ret)
+		return;
+	if (!(devx.stx_mask & STATX_WRITE_ATOMIC))
+		return;
+
+	awu_min = max(ff->fs->blocksize, devx.stx_atomic_write_unit_min);
+	awu_max = min(ff->fs->blocksize, devx.stx_atomic_write_unit_max);
+	if (awu_min > awu_max)
+		return;
+
+	log_printf(ff, "%s awu_min: %u, awu_max: %u\n",
+		   _("Supports (experimental) DIO atomic writes"),
+		   awu_min, awu_max);
+
+	ff->awu_min = awu_min;
+	ff->awu_max = awu_max;
+}
+#else
+# define fuse4fs_configure_atomic_write(...)	((void)0)
+#endif
+
 static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 {
 	errcode_t err;
@@ -6852,6 +6915,8 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse4fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a8887c9ead9d9b..e6853a9be7dd03 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -279,6 +279,9 @@ struct fuse2fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -749,10 +752,22 @@ static inline bool fuse2fs_can_iomap(const struct fuse2fs *ff)
 {
 	return ff->iomap_cap & FUSE_IOMAP_SUPPORT_FILEIO;
 }
+
+static inline bool fuse2fs_iomap_supports_hw_atomic(const struct fuse2fs *ff)
+{
+	return fuse2fs_iomap_enabled(ff) &&
+	       (ff->iomap_cap & FUSE_IOMAP_SUPPORT_ATOMIC) &&
+#ifdef STATX_WRITE_ATOMIC
+		ff->awu_min > 0 && ff->awu_min > 0;
+#else
+		0;
+#endif
+}
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
 # define fuse2fs_discover_iomap(...)	((void)0)
 # define fuse2fs_can_iomap(...)		(false)
+# define fuse2fs_iomap_supports_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1980,14 +1995,19 @@ static int op_getattr(const char *path, struct stat *statbuf,
 static int op_getattr_iflags(const char *path, struct stat *statbuf,
 			     unsigned int *iflags, struct fuse_file_info *fi)
 {
+	struct fuse2fs *ff = fuse2fs_get();
 	int ret = op_getattr(path, statbuf, fi);
 
 	if (ret)
 		return ret;
 
-	if (fuse_fs_can_enable_iomap(statbuf))
+	if (fuse_fs_can_enable_iomap(statbuf)) {
 		*iflags |= FUSE_IFLAG_IOMAP;
 
+		if (fuse2fs_iomap_supports_hw_atomic(ff))
+			*iflags |= FUSE_IFLAG_ATOMIC;
+	}
+
 	return 0;
 }
 #endif
@@ -2096,6 +2116,16 @@ static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse2fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse_fs_can_enable_iomapx(stx) &&
+	    fuse2fs_iomap_supports_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -6195,6 +6225,9 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6356,6 +6389,38 @@ static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
 	return -EIO;
 }
 
+#ifdef STATX_WRITE_ATOMIC
+static void fuse2fs_configure_atomic_write(struct fuse2fs *ff, int bdev_fd)
+{
+	struct statx devx;
+	unsigned int awu_min, awu_max;
+	int ret;
+
+	if (!ext2fs_has_feature_extents(ff->fs->super))
+		return;
+
+	ret = statx(bdev_fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &devx);
+	if (ret)
+		return;
+	if (!(devx.stx_mask & STATX_WRITE_ATOMIC))
+		return;
+
+	awu_min = max(ff->fs->blocksize, devx.stx_atomic_write_unit_min);
+	awu_max = min(ff->fs->blocksize, devx.stx_atomic_write_unit_max);
+	if (awu_min > awu_max)
+		return;
+
+	log_printf(ff, "%s awu_min: %u, awu_max: %u\n",
+		   _("Supports (experimental) DIO atomic writes"),
+		   awu_min, awu_max);
+
+	ff->awu_min = awu_min;
+	ff->awu_max = awu_max;
+}
+#else
+# define fuse2fs_configure_atomic_write(...)	((void)0)
+#endif
+
 static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 {
 	errcode_t err;
@@ -6380,6 +6445,8 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse2fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }


