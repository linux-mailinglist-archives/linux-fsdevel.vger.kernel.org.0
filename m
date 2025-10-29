Return-Path: <linux-fsdevel+bounces-66095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C3C17C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF63A8ECC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7D2D8DDD;
	Wed, 29 Oct 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCqHjpCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D7212549;
	Wed, 29 Oct 2025 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700153; cv=none; b=pZ+avENhxilJJ7T3WpsejvpRB9rzML6kNkemQ9N9s4cWQd5WnSYsWroA2iW5tnpCTM30A5lXZX75eslSSU9hxYsmsM3xuhCyz8ZKsWIZU3qxL5CAJ5pfgIUOYp0VBRbDAm4UZ38YYKa2Tunnrxb++S9CiNllMhofgj9q+7/ICgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700153; c=relaxed/simple;
	bh=LFfyc7ZMBmjSEawERZ9ZCHrG1deHXmtl/p07woaYY7s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyBCwt4Z299hHIbtA0E8tRPWnhy3gEAFNuSwhMD1mAIvHtbR3MJSxBGUGt/DHZuUs9gYsjVn/kbcT0eXSvIHmXzVBZge7se9cAuUx88IX3ugiznHxaJR4LsXw64TzztSt8+sP6GxYxyOb034noXTZDIIQ4FeAmoEklQwPkNd4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCqHjpCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40672C4CEE7;
	Wed, 29 Oct 2025 01:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700153;
	bh=LFfyc7ZMBmjSEawERZ9ZCHrG1deHXmtl/p07woaYY7s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QCqHjpCZg64a4WUCw0JbA2MwF1YSz4x7GSf+ihsCsss3mYbp5zOx4EYsEWdzi3zQD
	 HG+e5dXuU6kiY4Y1RrcvkNc7Km1/aWMxkGo/yGcQuqHYpd/8QbhL+QWXsqR5IYWSBU
	 pVQKldWnvELViYPN5S4vFvWCzMF9YrzBvt3ylq6WsM+qjC5O1lot897jTGYEk2g+FY
	 PmRwpPIJ73umVNePtwFqOHKgTd1522s3q1qqXriz6zOiHC2IapY66hm6re6tHT2YqN
	 h3erajmKoc8yE4Pnz5zhQL+fiqTR+FD+omLwcdWmA2GM98ogZsiE9m1jxclbWzXSyE
	 Z5mkhC6KwvwNA==
Date: Tue, 28 Oct 2025 18:09:12 -0700
Subject: [PATCH 03/17] fuse2fs: implement iomap configuration
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817615.1429568.9957142817695871990.stgit@frogsfrogsfrogs>
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

Upload the filesystem geometry to the kernel when asked.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 misc/fuse2fs.c    |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 186 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index a03a74ee19c1a8..ff0f913997e3ba 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -196,6 +196,10 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 # define FL_ZERO_RANGE_FLAG (0)
 #endif
 
+#ifndef NSEC_PER_SEC
+# define NSEC_PER_SEC	(1000000000L)
+#endif
+
 errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
@@ -967,9 +971,9 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
 	get_now(&now);
 
-	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
-	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
-	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
+	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
@@ -6221,6 +6225,91 @@ static void op_iomap_end(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 
 	fuse_reply_err(req, 0);
 }
+
+/*
+ * Maximal extent format file size.
+ * Resulting logical blkno at s_maxbytes must fit in our on-disk
+ * extent format containers, within a sector_t, and within i_blocks
+ * in the vfs.  ext4 inode has 48 bits of i_block in fsblock units,
+ * so that won't be a limiting factor.
+ *
+ * However there is other limiting factor. We do store extents in the form
+ * of starting block and length, hence the resulting length of the extent
+ * covering maximum file size must fit into on-disk format containers as
+ * well. Given that length is always by 1 unit bigger than max unit (because
+ * we count 0 as well) we have to lower the s_maxbytes by one fs block.
+ *
+ * Note, this does *not* consider any metadata overhead for vfs i_blocks.
+ */
+static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
+{
+	off_t res;
+
+	if (!ext2fs_has_feature_huge_file(ff->fs->super)) {
+		upper_limit = (1LL << 32) - 1;
+
+		/* total blocks in file system block size */
+		upper_limit >>= (ff->blocklog - 9);
+		upper_limit <<= ff->blocklog;
+	}
+
+	/*
+	 * 32-bit extent-start container, ee_block. We lower the maxbytes
+	 * by one fs block, so ee_len can cover the extent of maximum file
+	 * size
+	 */
+	res = (1LL << 32) - 1;
+	res <<= ff->blocklog;
+
+	/* Sanity check against vm- & vfs- imposed limits */
+	if (res > upper_limit)
+		res = upper_limit;
+
+	return res;
+}
+
+static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
+{
+	struct fuse_iomap_config cfg = { };
+	struct fuse4fs *ff = fuse4fs_get(req);
+	ext2_filsys fs;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+		   (unsigned long long)flags,
+		   (unsigned long long)maxbytes);
+	fs = fuse4fs_start(ff);
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_UUID;
+	memcpy(cfg.s_uuid, fs->super->s_uuid, sizeof(cfg.s_uuid));
+	cfg.s_uuid_len = sizeof(fs->super->s_uuid);
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg.s_blocksize = FUSE4FS_FSB_TO_B(ff, 1);
+
+	/*
+	 * If there inode is large enough to house i_[acm]time_extra then we
+	 * can turn on nanosecond timestamps; i_crtime was the next field added
+	 * after i_atime_extra.
+	 */
+	cfg.flags |= FUSE_IOMAP_CONFIG_TIME;
+	if (fs->super->s_inode_size >=
+	    offsetof(struct ext2_inode_large, i_crtime)) {
+		cfg.s_time_gran = 1;
+		cfg.s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+	} else {
+		cfg.s_time_gran = NSEC_PER_SEC;
+		cfg.s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+	}
+	cfg.s_time_min = EXT4_TIMESTAMP_MIN;
+
+	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg.s_maxbytes = fuse4fs_max_size(ff, maxbytes);
+
+	fuse4fs_finish(ff, 0);
+	fuse_reply_iomap_config(req, &cfg);
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_lowlevel_ops fs_ops = {
@@ -6269,6 +6358,7 @@ static struct fuse_lowlevel_ops fs_ops = {
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
+	.iomap_config = op_iomap_config,
 #endif /* HAVE_FUSE_IOMAP */
 };
 
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a368c3a8d5eac9..a85af4518441d2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -190,6 +190,10 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 # define FL_ZERO_RANGE_FLAG (0)
 #endif
 
+#ifndef NSEC_PER_SEC
+# define NSEC_PER_SEC	(1000000000L)
+#endif
+
 errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
@@ -805,9 +809,9 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
 	get_now(&now);
 
-	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
-	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
-	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
+	dnow = now.tv_sec + ((double)now.tv_nsec / NSEC_PER_SEC);
 
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
@@ -5665,6 +5669,91 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 
 	return 0;
 }
+
+/*
+ * Maximal extent format file size.
+ * Resulting logical blkno at s_maxbytes must fit in our on-disk
+ * extent format containers, within a sector_t, and within i_blocks
+ * in the vfs.  ext4 inode has 48 bits of i_block in fsblock units,
+ * so that won't be a limiting factor.
+ *
+ * However there is other limiting factor. We do store extents in the form
+ * of starting block and length, hence the resulting length of the extent
+ * covering maximum file size must fit into on-disk format containers as
+ * well. Given that length is always by 1 unit bigger than max unit (because
+ * we count 0 as well) we have to lower the s_maxbytes by one fs block.
+ *
+ * Note, this does *not* consider any metadata overhead for vfs i_blocks.
+ */
+static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
+{
+	off_t res;
+
+	if (!ext2fs_has_feature_huge_file(ff->fs->super)) {
+		upper_limit = (1LL << 32) - 1;
+
+		/* total blocks in file system block size */
+		upper_limit >>= (ff->blocklog - 9);
+		upper_limit <<= ff->blocklog;
+	}
+
+	/*
+	 * 32-bit extent-start container, ee_block. We lower the maxbytes
+	 * by one fs block, so ee_len can cover the extent of maximum file
+	 * size
+	 */
+	res = (1LL << 32) - 1;
+	res <<= ff->blocklog;
+
+	/* Sanity check against vm- & vfs- imposed limits */
+	if (res > upper_limit)
+		res = upper_limit;
+
+	return res;
+}
+
+static int op_iomap_config(uint64_t flags, off_t maxbytes,
+			   struct fuse_iomap_config *cfg)
+{
+	struct fuse2fs *ff = fuse2fs_get();
+	ext2_filsys fs;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+		   (unsigned long long)flags,
+		   (unsigned long long)maxbytes);
+	fs = fuse2fs_start(ff);
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_UUID;
+	memcpy(cfg->s_uuid, fs->super->s_uuid, sizeof(cfg->s_uuid));
+	cfg->s_uuid_len = sizeof(fs->super->s_uuid);
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_BLOCKSIZE;
+	cfg->s_blocksize = FUSE2FS_FSB_TO_B(ff, 1);
+
+	/*
+	 * If there inode is large enough to house i_[acm]time_extra then we
+	 * can turn on nanosecond timestamps; i_crtime was the next field added
+	 * after i_atime_extra.
+	 */
+	cfg->flags |= FUSE_IOMAP_CONFIG_TIME;
+	if (fs->super->s_inode_size >=
+	    offsetof(struct ext2_inode_large, i_crtime)) {
+		cfg->s_time_gran = 1;
+		cfg->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+	} else {
+		cfg->s_time_gran = NSEC_PER_SEC;
+		cfg->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+	}
+	cfg->s_time_min = EXT4_TIMESTAMP_MIN;
+
+	cfg->flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
+	cfg->s_maxbytes = fuse2fs_max_size(ff, maxbytes);
+
+	fuse2fs_finish(ff, 0);
+	return 0;
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_operations fs_ops = {
@@ -5711,6 +5800,7 @@ static struct fuse_operations fs_ops = {
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
+	.iomap_config = op_iomap_config,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


