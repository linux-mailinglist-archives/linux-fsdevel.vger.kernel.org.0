Return-Path: <linux-fsdevel+bounces-55364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A568B09836
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954D217B91E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2F244E8C;
	Thu, 17 Jul 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAhS+GZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D2241CAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795562; cv=none; b=bAk/Hvv7QZMY1Ckwi9SDb704Td0QcBCcy5trDpkAFUdDYZRMnU8Ys9lYjkoFG44BMVGybxdXIE08t/ZM1G4wMkO44ywXmY8HqSU/CgusGLreSl7n8YwKJDjtbQtwA95EtclLLk6oRLSYiTCSZeyw0tpHKaSdP9k3bVn2BRGj9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795562; c=relaxed/simple;
	bh=vkuDI8bD4ssE4U52dCUmzIQTyg3fMWgEJnSucBlUAVY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIw47EnqB59Roq/aDtg+DnSX7/3Acj7Qam9XdKTKu/disBiCI2KV1+xLWoe9wV9WyAhy5Pek1gm8kr9WlrOEAhCAVNqSC6sL8wwYN0T3qXbyDwE+Z4j+hU5GlrMCT5q7x1xzDbt7AJRRTtIkx6/yPLubmhRWTNgDHImF4XlErgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAhS+GZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB66C4CEE3;
	Thu, 17 Jul 2025 23:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795562;
	bh=vkuDI8bD4ssE4U52dCUmzIQTyg3fMWgEJnSucBlUAVY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IAhS+GZso5/UXGVrtnTX4op/ZwtyNpw54nXrvCbTnzLWGOt1MIXwS3YX/XzCaP2Xs
	 Waik0i74S3CDrmzF6mhE4RNliB+KvxkW3uNDKhk+sMtsXJHo77npd8h6ucLAk6374r
	 tyc4Ca+iD1z+jdT59OCvtH7af9JRZRATyLu6s2kngBorH9TK+2XAZTf6xBFvORx9ob
	 e/5zHsJkTWY39anKAAitoDoDUmsY8svb36N2slgTQvvkw206zoxzsnoia7fDqdrLPv
	 hdqt/xiqWFyki4OC5E6byUMB6n/aWMYbLFi1UvtzHjR3ExXdJVXhD4iFUUPo5dGRqH
	 toe5Fqauf0K0Q==
Date: Thu, 17 Jul 2025 16:39:22 -0700
Subject: [PATCH 4/4] libfuse: add upper level statx hooks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
Message-ID: <175279460448.714831.6057226933995944057.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Connect statx to the upper level library.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |   11 +++++++
 lib/fuse.c     |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index a59f43e0701e1a..03af42c9884acd 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -323,6 +323,7 @@ struct fuse_config {
 	uint64_t reserved[48];
 };
 
+struct statx;
 
 /**
  * The file system operations:
@@ -895,6 +896,16 @@ struct fuse_operations {
 	 * Flush the entire filesystem to disk.
 	 */
 	int (*syncfs) (const char *path);
+
+	/**
+	 * Return detailed attributes about a file.
+	 *
+	 * File information should be written to the statx struct.
+	 * The size parameter is the size of the statx structure.
+	 */
+	int (*statx) (const char *path, uint32_t statx_flags,
+		      uint32_t statx_mask, struct statx *statx, size_t size,
+		      struct fuse_file_info *fi);
 #endif /* FUSE_USE_VERSION >= 318 */
 };
 
diff --git a/lib/fuse.c b/lib/fuse.c
index c3fa6dad589cb0..41e37f2760356c 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -41,6 +41,8 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 #include <sys/file.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #define FUSE_NODE_SLAB 1
 
@@ -2897,6 +2899,24 @@ static int fuse_fs_syncfs(struct fuse_fs *fs, const char *path)
 	return fs->op.syncfs(path);
 }
 
+static int fuse_fs_statx(struct fuse_fs *fs, const char *path,
+			 uint32_t statx_flags, uint32_t statx_mask,
+			 struct statx *statx, size_t size,
+			 struct fuse_file_info *fi)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.statx)
+		return -ENOSYS;
+	if (fs->debug) {
+		char buf[10];
+
+		fuse_log(FUSE_LOG_DEBUG, "statx[%s] 0x%x 0x%x\n",
+			file_info_string(fi, buf, sizeof(buf)),
+			statx_flags, statx_mask);
+	}
+	return fs->op.statx(path, statx_flags, statx_mask, statx, size, fi);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
@@ -4703,6 +4723,74 @@ static void fuse_lib_syncfs(fuse_req_t req, fuse_ino_t ino)
 	reply_err(req, err);
 }
 
+#ifdef STATX_BASIC_STATS
+static void from_statx(struct stat *buf, const struct statx *stx)
+{
+	buf->st_dev		= makedev(stx->stx_dev_major,
+					  stx->stx_dev_minor);
+	buf->st_ino		= stx->stx_ino;
+	buf->st_mode		= stx->stx_mode;
+	buf->st_nlink		= stx->stx_nlink;
+	buf->st_uid		= stx->stx_uid;
+	buf->st_gid		= stx->stx_gid;
+	buf->st_rdev		= makedev(stx->stx_rdev_major,
+					  stx->stx_rdev_minor);
+	buf->st_size		= stx->stx_size;
+	buf->st_blksize		= stx->stx_blksize;
+	buf->st_blocks		= stx->stx_blocks;
+
+	buf->st_atime		= stx->stx_atime.tv_sec;
+	buf->st_mtime		= stx->stx_mtime.tv_sec;
+	buf->st_ctime		= stx->stx_ctime.tv_sec;
+
+	/* XXX do we care about tv_nsec? */
+}
+
+static void fuse_lib_statx(fuse_req_t req, fuse_ino_t ino, uint32_t statx_flags,
+			   uint32_t statx_mask, struct fuse_file_info *fi)
+{
+	struct fuse *f = req_fuse_prepare(req);
+	struct node *node;
+	struct fuse_intr_data d;
+	struct statx statx = { };
+	struct stat buf = { };
+	char *path;
+	int err;
+
+	if (fi != NULL)
+		err = get_path_nullok(f, ino, &path);
+	else
+		err = get_path(f, ino, &path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	fuse_prepare_interrupt(f, req, &d);
+	err = fuse_fs_statx(f->fs, path, statx_flags, statx_mask, &statx,
+			    sizeof(statx), fi);
+	fuse_finish_interrupt(f, req, &d);
+	free_path(f, ino, path);
+	if (err) {
+		reply_err(req, err);
+		return;
+	}
+
+	pthread_mutex_lock(&f->lock);
+	node = get_node(f, ino);
+	if (node->is_hidden && statx.stx_nlink > 0)
+		statx.stx_nlink--;
+	from_statx(&buf, &statx);
+	if (f->conf.auto_cache)
+		update_stat(node, &buf);
+	pthread_mutex_unlock(&f->lock);
+	set_stat(f, ino, &buf);
+	fuse_reply_statx(req, &statx, sizeof(statx), f->conf.attr_timeout);
+}
+#else
+# define fuse_lib_statx		NULL
+#endif /* STATX_BASIC_STATS */
+
 static int clean_delay(struct fuse *f)
 {
 	/*
@@ -4802,6 +4890,7 @@ static struct fuse_lowlevel_ops fuse_path_ops = {
 	.copy_file_range = fuse_lib_copy_file_range,
 	.lseek = fuse_lib_lseek,
 	.syncfs = fuse_lib_syncfs,
+	.statx = fuse_lib_statx,
 	.iomap_begin = fuse_lib_iomap_begin,
 	.iomap_end = fuse_lib_iomap_end,
 	.iomap_ioend = fuse_lib_iomap_ioend,


