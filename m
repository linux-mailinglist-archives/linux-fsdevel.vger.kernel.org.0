Return-Path: <linux-fsdevel+bounces-61539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E6B589B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8B7AE854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B21A0711;
	Tue, 16 Sep 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+zVBj3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5E7483;
	Tue, 16 Sep 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982980; cv=none; b=MX/didTQXcvMGhp6lDRGKTXYDYIeWCNvvWhw4d+sPVsnkmLp5Tb/Q2zDh3cMPMruddkpkoJ2jWOPINhK7svoyoFWQWvWZIEUDfZEJADVJYlf4X4F5x5rdVNItusu5d4kzxa5sKYw1XWIXjk5WQw0a1fTguaCC3lmGoNepPtg9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982980; c=relaxed/simple;
	bh=9r7UkBaW4i9MbAe3OT8AB+//bT6Yqdhpg4n3zeWxHDc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDp0jFnWDJpxFNPDBMnCkGklzv+xvS5PCuMQaYkPd0A467TrP8JHn+Bfb1ftYZYShP6HdJ5agCTuRhcSAsTphvcGNJ0WM5idNbZSYUShMZFzdDhpffqvEhmPsf30usiHyozyCk0LV4ZtWUMf3lVChgW6oYSjKYn9kzW+OXxwWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+zVBj3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B0C4CEF1;
	Tue, 16 Sep 2025 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982979;
	bh=9r7UkBaW4i9MbAe3OT8AB+//bT6Yqdhpg4n3zeWxHDc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W+zVBj3E0ecJyntXo+HBYkFxYjlK/eshseEfxjr9t+5kSxmr9njzrM8q8K2llrJbe
	 K77D7p0NkIr2wSoT9rD4IegxSDHbZs+Pwk1b6R5kPC+s2q0Fj5jv9L8lkzfPF0Z2Bt
	 VsN0HVcCa0ofGJPt75SdD5LKqjGDPlXps5jYwjLex+mKKZLYhG8i+2Jvo4N3Hlr3So
	 A8GKIdt+yhZnyKZ22siXMLCgchBdoIiQmKNRcNRlF4hX3B312ZXOl97IF4gFyieZ8G
	 qQpiArcJgVAgPUq6UwczWjfbQUHfUPdnxSblXmUDHcjvQO9rcFa5ji+ckVf8kqG+a5
	 AYyjP3Kt2vtvQ==
Date: Mon, 15 Sep 2025 17:36:18 -0700
Subject: [PATCH 1/9] fuse: enable caching of timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152460.383971.1076928224351513871.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the timestamps in the kernel so that the kernel sends FUSE_SETATTR
calls to the fuse server after writes, because the iomap infrastructure
won't do that for us.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    5 ++++-
 fs/fuse/file.c       |   18 ++++++++++++------
 fs/fuse/file_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   13 +++++++------
 4 files changed, 29 insertions(+), 13 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c6e83b724f8cd0..380559950c3444 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2062,7 +2062,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_attr_out outarg;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
-	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
+	bool is_wb = (is_iomap || fc->writeback_cache) &&
+		     S_ISREG(inode->i_mode);
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb;
@@ -2196,6 +2197,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
+		if ((attr->ia_valid & ATTR_ATIME) && is_iomap)
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 		if (attr->ia_valid & ATTR_MTIME)
 			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 		if (attr->ia_valid & ATTR_CTIME)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9476f14035bb7f..0ed13082d0d00d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -240,7 +240,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	int err;
 	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
-	bool is_wb_truncate = is_truncate && fc->writeback_cache;
+	bool is_wb_truncate = is_truncate && (is_iomap || fc->writeback_cache);
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
@@ -453,12 +453,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_flush_in inarg;
 	FUSE_ARGS(args);
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+	if ((ff->open_flags & FOPEN_NOFLUSH) &&
+	    !fm->fc->writeback_cache && !is_iomap)
 		return 0;
 
 	err = write_inode_now(inode, 1);
@@ -494,7 +496,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	 * In memory i_blocks is not maintained by fuse, if writeback cache is
 	 * enabled, i_blocks from cached attr may not be accurate.
 	 */
-	if (!err && fm->fc->writeback_cache)
+	if (!err && (is_iomap || fm->fc->writeback_cache))
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
 	return err;
 }
@@ -796,8 +798,10 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * If writeback_cache is enabled, a short read means there's a hole in
 	 * the file.  Some data after the hole is in page cache, but has not
 	 * reached the client fs yet.  So the hole is not present there.
+	 * If iomap is enabled, a short read means we hit EOF so there's
+	 * nothing to adjust.
 	 */
-	if (!fc->writeback_cache) {
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode)) {
 		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
@@ -1412,6 +1416,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	WARN_ON(fuse_inode_has_iomap(inode));
+
 	iomap->type = IOMAP_MAPPED;
 	iomap->length = length;
 	iomap->offset = offset;
@@ -1979,7 +1985,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	 * Do this only if writeback_cache is not enabled.  If writeback_cache
 	 * is enabled, we trust local ctime/mtime.
 	 */
-	if (!fc->writeback_cache)
+	if (!fc->writeback_cache && !fuse_inode_has_iomap(inode))
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
 	fi->writectr--;
@@ -3065,7 +3071,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
 	const bool is_iomap = fuse_inode_has_iomap(inode_out);
-	bool is_unstable = (!fc->writeback_cache) &&
+	bool is_unstable = (!fc->writeback_cache && !is_iomap) &&
 			   ((pos_out + len) > inode_out->i_size);
 
 	if (fc->no_copy_file_range)
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 524c26e53674f2..1fc9a9b7b75094 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1769,6 +1769,12 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
 
 	ASSERT(fuse_has_iomap(inode));
 
+	/*
+	 * Manage timestamps ourselves, don't make the fuse server do it.  This
+	 * is critical for mtime updates to work correctly with page_mkwrite.
+	 */
+	inode->i_flags &= ~S_NOCMTIME;
+	inode->i_flags &= ~S_NOATIME;
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e74d39ac05a570..b63e4e1d8f45ce 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -328,10 +328,11 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
-		return 0;
+	if (S_ISREG(inode->i_mode) &&
+	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
-	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
+	return 0;
 }
 
 static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr,
@@ -346,9 +347,9 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 
 	spin_lock(&fi->lock);
 	/*
-	 * In case of writeback_cache enabled, writes update mtime, ctime and
-	 * may update i_size.  In these cases trust the cached value in the
-	 * inode.
+	 * In case of writeback_cache or iomap enabled, writes update mtime,
+	 * ctime and may update i_size.  In these cases trust the cached value
+	 * in the inode.
 	 */
 	cache_mask = fuse_get_cache_mask(inode);
 	if (cache_mask & STATX_SIZE)


