Return-Path: <linux-fsdevel+bounces-61639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4712B58A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E6165318
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A81BD9CE;
	Tue, 16 Sep 2025 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcQ+vPMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9F18C933;
	Tue, 16 Sep 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984591; cv=none; b=Z1u1yJebQrAq+mw309Ype2RorpAejdoBpL4HAw4C4hdWXRfTW2RoHRR7yVtW28zJyXNfoiqx5WFIh4BnphQgoA4j6VdXjCV9mdgL00IILARtcp07FbNgwcRYiJULM1GhHKLgwZjq1USNzvGFXKsqJv2JTPd7xgm+bcg3CQxHHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984591; c=relaxed/simple;
	bh=aF1xnkwvj91MR9Bd64+rX43m8nNY6Oh+ALq68MkOBNc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkH3yCsl7Y2QtzD6QfM0U7babbHD3Le/u3nLmFjBER5dyPkq3l4CjiQ+nxtxRsTX8z7X+DXVqXa2GyBNzGFfSsuY0G0WH/1XL4IZIvaesSu3zbQZTZPx//bncpCOnxVeBAdTT1C+iqCFDt7PSFu/zBxCgjeAu2JmgF9BTRwdFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcQ+vPMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E6C4CEF1;
	Tue, 16 Sep 2025 01:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984591;
	bh=aF1xnkwvj91MR9Bd64+rX43m8nNY6Oh+ALq68MkOBNc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bcQ+vPMAtCcZA7EQXVES2eVe+vEsOnE3zZKVqjAUy+u4w05X5JAtnlQEpWqwVOkhB
	 0G8I9poeu9Qh4f4LOzvUiV8JMLEupBhBVznfjSPLJJXNXmJaWdsok1DpUt98NC9OK7
	 VnHp7GRwrdGa30Cpi+G8vEBCLTl5m0o7n3p1b1hMYlR5Bh2XI3zoubcD3Twu06cY2k
	 zPcAgnyK7xQ2EvGnckHVdRU+fqksQbmhabZxkWcwUiZwmFdTb9m59bhuHFyFhsHWS8
	 /z5Uj9WHCduKnSaLdDRCdbd9nLhTw2OG/fCTR6jUw91gsxCR6mC2+0yIz3qifE87vL
	 zg+QYLdqGPOpA==
Date: Mon, 15 Sep 2025 18:03:11 -0700
Subject: [PATCH 17/17] fuse2fs: enable atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162027.390496.6384168639395184998.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 misc/fuse2fs.c    |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 6c3e2992a04211..abbc67bccef786 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -278,6 +278,9 @@ struct fuse4fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -736,8 +739,20 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
 {
 	return ff->iomap_state >= IOMAP_ENABLED;
 }
+
+static inline int fuse4fs_iomap_can_hw_atomic(const struct fuse4fs *ff)
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
+# define fuse4fs_iomap_can_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
@@ -1757,8 +1772,12 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
 	fstat->iflags = 0;
 #ifdef HAVE_FUSE_IOMAP
-	if (fuse4fs_iomap_enabled(ff))
+	if (fuse4fs_iomap_enabled(ff)) {
 		fstat->iflags |= FUSE_IFLAG_IOMAP;
+
+		if (fuse4fs_iomap_can_hw_atomic(ff))
+			fstat->iflags |= FUSE_IFLAG_ATOMIC;
+	}
 #endif
 
 	return 0;
@@ -1933,6 +1952,15 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse4fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse4fs_iomap_can_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -6255,6 +6283,9 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -6419,6 +6450,38 @@ static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
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
@@ -6443,6 +6506,8 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse4fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d6bf7357653acd..0832a758bdad79 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -272,6 +272,9 @@ struct fuse2fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -573,9 +576,21 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 {
 	return ff->iomap_state >= IOMAP_ENABLED;
 }
+
+static inline int fuse2fs_iomap_can_hw_atomic(const struct fuse2fs *ff)
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
 # define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_iomap_can_hw_atomic(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -1627,14 +1642,19 @@ static int op_getattr(const char *path, struct stat *statbuf,
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
 
+		if (fuse2fs_iomap_can_hw_atomic(ff))
+			*iflags |= FUSE_IFLAG_ATOMIC;
+	}
+
 	return 0;
 }
 #endif
@@ -1740,6 +1760,15 @@ static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
 
 	fuse2fs_statx_directio(ff, stx);
 
+#ifdef STATX_WRITE_ATOMIC
+	if (fuse_fs_can_enable_iomapx(stx) && fuse2fs_iomap_can_hw_atomic(ff)) {
+		stx->stx_mask |= STATX_WRITE_ATOMIC;
+		stx->stx_atomic_write_unit_min = ff->awu_min;
+		stx->stx_atomic_write_unit_max = ff->awu_max;
+		stx->stx_atomic_write_segments_max = 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -5783,6 +5812,9 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -5944,6 +5976,38 @@ static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
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
@@ -5968,6 +6032,8 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse2fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }


