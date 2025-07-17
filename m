Return-Path: <linux-fsdevel+bounces-55327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106CBB09807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A7189C537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EDB25A322;
	Thu, 17 Jul 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foWUU6TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888424A046
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794999; cv=none; b=Cl6RnqpnGGUQvBmZh6X3T7Le+vZ8NbYa9+jKom52qxj9FQarWon+6ps6NHR9DTFIhJx18tRv2MBPw5Zl0ZhKUFDSrn8yYjVVn5TKzGFUOzekm6rhLL+TyLzqsC16xpctwRvQ2bjp8Re/5LTw6Ft/MWcFFGGyOn0HqF5UOj7JQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794999; c=relaxed/simple;
	bh=6v+ULURStghMrh7NkMJg7BlmwXzs27wkvBcBCFXRcrE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZJ2UxpR1kJo6nNjLiYmZVcv0uJ/Fav9q1zctd2c4Ohc3x6I/3oQTIt1TNQHbI8YIFVH+Vn9hokQ3xxWVKSQyapPmhFuJd3l++85IK4iiMceNEaiZlBnIzynw2NFCWJtOJLROwt/ZsMA+60h/3/+fxUN87v+tDjvMv2Ghj/Le5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foWUU6TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE4AC4CEE3;
	Thu, 17 Jul 2025 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794999;
	bh=6v+ULURStghMrh7NkMJg7BlmwXzs27wkvBcBCFXRcrE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=foWUU6TFUNGpSMk2cYsPG9N/+2JLAvR2B1ucX4TWDsnj8Y61FzqtgkSysk6OTjYKh
	 IH8aa8iKT+zTv/ysSgxLfDj0EA14dXLEcZfzfDKDfvYUERlPpG2PK9DOeiuCTINOTw
	 WoXHXACGUpfKKoelTOZ3OPotW+gWudhRm0rDWy+5aqfSTCO1oUABS2ukyz4BGUSp0h
	 hsNAkXpa2NW1AMCSKXcimfwZVaklA57p24g/xoqHItUwGyx2BAnCWbyNvajEw5dm5p
	 53l/DXmTWTTwpRk/JU0fEUixlZ5OMjEBoMPOxWZpebhuH5aPRbKQGxYfM5dljOqgBU
	 FmM3lc/AjLB5g==
Date: Thu, 17 Jul 2025 16:29:59 -0700
Subject: [PATCH 07/13] fuse: enable caching of timestamps
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450089.711291.6942139776135831778.stgit@frogsfrogsfrogs>
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

Cache the timestamps in the kernel so that the kernel sends FUSE_SETATTR
calls to the fuse server after writes, because the iomap infrastructure
won't do that for us.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c        |    3 ++-
 fs/fuse/file.c       |   19 +++++++++++++------
 fs/fuse/file_iomap.c |    6 ++++++
 fs/fuse/inode.c      |   13 +++++++------
 4 files changed, 28 insertions(+), 13 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7a398e42e9818b..1e9d5bf1811c6a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1964,7 +1964,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
 	bool is_truncate = false;
-	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
+	bool is_wb = S_ISREG(inode->i_mode) &&
+			(fuse_has_iomap_fileio(inode) || fc->writeback_cache);
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2dd4e5c2933c0f..207836e2e09cc4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -238,7 +238,8 @@ static int fuse_open(struct inode *inode, struct file *file)
 	struct fuse_file *ff;
 	int err;
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
-	bool is_wb_truncate = is_truncate && fc->writeback_cache;
+	bool is_wb_truncate = is_truncate && (fuse_has_iomap_fileio(inode) ||
+					      fc->writeback_cache);
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
@@ -458,7 +459,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+	if ((ff->open_flags & FOPEN_NOFLUSH) &&
+	    !fm->fc->writeback_cache &&
+	    !fuse_has_iomap_fileio(inode))
 		return 0;
 
 	err = write_inode_now(inode, 1);
@@ -494,7 +497,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	 * In memory i_blocks is not maintained by fuse, if writeback cache is
 	 * enabled, i_blocks from cached attr may not be accurate.
 	 */
-	if (!err && fm->fc->writeback_cache)
+	if (!err && (fuse_has_iomap_fileio(inode) || fm->fc->writeback_cache))
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
 	return err;
 }
@@ -792,8 +795,10 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * If writeback_cache is enabled, a short read means there's a hole in
 	 * the file.  Some data after the hole is in page cache, but has not
 	 * reached the client fs yet.  So the hole is not present there.
+	 * If iomap is enabled, a short read means we hit EOF so there's
+	 * nothing to adjust.
 	 */
-	if (!fc->writeback_cache) {
+	if (!fc->writeback_cache && !fuse_has_iomap_fileio(inode)) {
 		loff_t pos = folio_pos(ap->folios[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
@@ -1935,7 +1940,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	 * Do this only if writeback_cache is not enabled.  If writeback_cache
 	 * is enabled, we trust local ctime/mtime.
 	 */
-	if (!fc->writeback_cache)
+	if (!fc->writeback_cache && !fuse_has_iomap_fileio(inode))
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
 	fi->writectr--;
@@ -2266,6 +2271,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	int err = -ENOMEM;
 
 	WARN_ON(!fc->writeback_cache);
+	WARN_ON(fuse_has_iomap_fileio(mapping->host));
 
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
@@ -3108,7 +3114,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
-	bool is_unstable = (!fc->writeback_cache) &&
+	bool is_unstable = (!fc->writeback_cache &&
+			    !fuse_has_iomap_fileio(inode_out)) &&
 			   ((pos_out + len) > inode_out->i_size);
 
 	if (fc->no_copy_file_range)
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ab0dee6460a7dd..112cbb6cabb015 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1342,6 +1342,12 @@ static inline void fuse_iomap_set_fileio(struct inode *inode)
 
 	ASSERT(get_fuse_conn_c(inode)->iomap_fileio);
 
+	/*
+	 * Manage timestamps ourselves, don't make the fuse server do it.  This
+	 * is critical for mtime updates to work correctly with page_mkwrite.
+	 */
+	inode->i_flags &= ~S_NOCMTIME;
+	inode->i_flags &= ~S_NOATIME;
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3e92a29d1030c9..d67cc635612cff 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -328,10 +328,11 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
-		return 0;
+	if (S_ISREG(inode->i_mode) &&
+	    (fuse_has_iomap_fileio(inode) || fc->writeback_cache))
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


