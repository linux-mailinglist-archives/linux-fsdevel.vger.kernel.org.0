Return-Path: <linux-fsdevel+bounces-58549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F1B2EA8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE6E1C85720
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB020A5C4;
	Thu, 21 Aug 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxssTC+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40197F9EC;
	Thu, 21 Aug 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739240; cv=none; b=l1POmIcYhJ7ozRR5qPtzkuvhooQQp104TAKKjhtDVLXazfd8hBg0Y6QwjzM6FeVXVR0dkTUqcDr4tF74AXvxP8rVkGIijesuxgKdTAvN9cZUqTFqcElcS5AwLL1mcWPR7h3LdZMVKeKQmvzt8m1091bAH/7PWdFfwEDpjLGxwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739240; c=relaxed/simple;
	bh=tU/UXxpgsphrSjJ5qcDzD9D2+prd/X+X4NHvnP95WQc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROsrJlMVVF0693FRI78IhboSlEM4HjA7JfQiSh3JcA9APHvoQn922kCoqBrIiBd4FVFMpjvRKbGwcYlibX0IGVSYRfPbdX3zbBiR9ZIQuxvbIVzOuYtgh1f/aTXmNNcgwf/I5b13pp+oDUpN/KLl+I5jq9bCV4JWvl1K8Jso094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxssTC+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156CCC4CEE7;
	Thu, 21 Aug 2025 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739240;
	bh=tU/UXxpgsphrSjJ5qcDzD9D2+prd/X+X4NHvnP95WQc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jxssTC+TU/h3Vzkb86vFwlKTut2XMbxZn7I3B4ah0Y7ZRX1Tgrzy3ltAEAXEl9LW/
	 B5ABB9PISx3uZZQgtV6uqJgzJCdPqxbl27tt1N9LRsTacZpgXbNf0egyM93MMTFaa0
	 BEerGgaTgAKRqzRyME0JK/H9OVi8GC+knCqZ8legB/qnUm7HkZ/S+Jke7IL3uAEjlO
	 PMS037DpzwHfwnnMsrPxiejlwD+i9mv1lFsYN6RtaJE/DVeGtYhk44Bjpqy9O29g1a
	 g4YJgm4gTLQ3kpWegure7EnV1Xmd1bhpNyZn2Y6oT6ydnMLrba/Hktbg7XSCxrRh3q
	 Fg5yCsfWzijyg==
Date: Wed, 20 Aug 2025 18:20:39 -0700
Subject: [PATCH 19/19] fuse2fs: enable atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714074.21970.8939552485779174661.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 misc/fuse4fs.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a00c32e9f2cae8..04bb96f3438f23 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -281,6 +281,9 @@ struct fuse2fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -580,9 +583,21 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
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
@@ -1631,14 +1646,19 @@ static int op_getattr(const char *path, struct stat *statbuf
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
@@ -1744,6 +1764,15 @@ static int fuse2fs_statx(struct fuse2fs *ff, ext2_ino_t ino, int statx_mask,
 
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
 
@@ -5868,6 +5897,9 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read->flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6027,6 +6059,38 @@ static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
 	return EIO;
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
@@ -6051,6 +6115,8 @@ static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse2fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index b45f92a1cdbe25..43fc21149ba564 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -277,6 +277,9 @@ struct fuse4fs {
 	void (*old_alloc_stats)(ext2_filsys fs, blk64_t blk, int inuse);
 	void (*old_alloc_stats_range)(ext2_filsys fs, blk64_t blk, blk_t num,
 				      int inuse);
+#ifdef STATX_WRITE_ATOMIC
+	unsigned int awu_min, awu_max;
+#endif
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -735,8 +738,20 @@ static inline int fuse4fs_iomap_enabled(const struct fuse4fs *ff)
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
@@ -1737,8 +1752,12 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
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
@@ -1913,6 +1932,15 @@ static int fuse4fs_statx(struct fuse4fs *ff, ext2_ino_t ino, int statx_mask,
 
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
 
@@ -6193,6 +6221,9 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 		}
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -6355,6 +6386,38 @@ static int fuse4fs_set_bdev_blocksize(struct fuse4fs *ff, int fd)
 	return EIO;
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
@@ -6379,6 +6442,8 @@ static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
 	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
 		   __func__, fd, ff->iomap_dev);
 
+	fuse4fs_configure_atomic_write(ff, fd);
+
 	ff->iomap_dev = ret;
 	return 0;
 }


