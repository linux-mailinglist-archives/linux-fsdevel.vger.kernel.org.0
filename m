Return-Path: <linux-fsdevel+bounces-61610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D8B58A44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F45188AC7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF91C5F23;
	Tue, 16 Sep 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVBCA2Yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225283A1D2;
	Tue, 16 Sep 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984138; cv=none; b=SAh3wyQZarfM6aKxyaBTG0FLSypyZATt/St2GpHmkQse1iUr6LnJQ17aRoOPAGrFDasvUHBuvk/ysv11BjYi4vTDnNu8WlpkatH0jEUIUsy4JW26N4l5/CAYiEGUqU67lY+io0kt+lu7MbGxW4w3kX0THf8VZffgsKkvi5aCGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984138; c=relaxed/simple;
	bh=2jAlUggacIeUpapaufumP3mAoK3sSl7nXHn1cBmGDdg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSZMXSjdwqor5SEtokPY6Ql+JV3QtGlgd46J/noNhPnX+gahu8A8TLGnCykbXhCKZ5rvgdj4khX1XbGGRRMWBg6yxvmXbIZ9WsugFYSqwKateapE7xnOQ1ZeZ9LSicNYBFQTXXNsKe16V1vlVUtoCxthJtOnIHeAQxnozzMxlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVBCA2Yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814F8C4CEF1;
	Tue, 16 Sep 2025 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984136;
	bh=2jAlUggacIeUpapaufumP3mAoK3sSl7nXHn1cBmGDdg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BVBCA2Yrl++9biqJfe4tD8y9IXYlbk6bWvqey9dyK3vRrXlT6vOLOB35pqirnkoaO
	 iuHukiOp+Dnp+Jl8oWtoXKTuT0XsoP6W8w78yPkMqj/uVJRYCoAeLfIk8wUUpERtZh
	 1mIdxWvhwXKdCTLQdcHfDtPFvJWxcXNBKz2qiFGedGm8LwXdcmHRY3poO6O50zoVVn
	 UB1XBHWGDbEUIr/IL/bm2i8dKU+evoZvCGA/aqcRbtu3BiNbPIXuVVJM6a4EhWy+4a
	 pijDBSt9q2Bks3WkjVYs8x8mHJh99ULusSYo1fKGAxmNLIOKXDLmxRkZmJGBnfNNxW
	 b2y47nLnwXlqA==
Date: Mon, 15 Sep 2025 17:55:36 -0700
Subject: [PATCH 19/21] fuse4fs: use the orphaned inode list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161117.389252.3955203958973693102.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Put open but unlinked files on the orphan list, and remove them when the
last open fd releases the inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 5b06e5a5b9668e..e046c782957e60 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -960,6 +960,13 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		   inode_uid(inode), inode_gid(inode),
 		   ctxt->uid, ctxt->gid);
 
+	/* linked files cannot be on the unlinked list or deleted */
+	if (inode.i_dtime != 0) {
+		dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
+			   __func__, ino, inode.i_dtime);
+		return -ENOENT;
+	}
+
 	/* existence check */
 	if (mask == 0)
 		return 0;
@@ -2162,9 +2169,80 @@ static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+				  struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+
+	dbg_printf(ff, "%s: orphan ino=%d dtime=%d next=%d\n",
+		   __func__, ino, inode->i_dtime, fs->super->s_last_orphan);
+
+	inode->i_dtime = fs->super->s_last_orphan;
+	fs->super->s_last_orphan = ino;
+	ext2fs_mark_super_dirty(fs);
+
+	return 0;
+}
+
+static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+				       struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	ext2_ino_t prev_orphan;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: super=%d ino=%d next=%d\n",
+		   __func__, fs->super->s_last_orphan, ino, inode->i_dtime);
+
+	/* If we're lucky, the ondisk superblock points to us */
+	if (fs->super->s_last_orphan == ino) {
+		dbg_printf(ff, "%s: superblock\n", __func__);
+
+		fs->super->s_last_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+		ext2fs_mark_super_dirty(fs);
+		return 0;
+	}
+
+	/* Otherwise walk the ondisk orphan list. */
+	prev_orphan = fs->super->s_last_orphan;
+	while (prev_orphan != 0) {
+		struct ext2_inode_large orphan;
+
+		err = fuse4fs_read_inode(fs, prev_orphan, &orphan);
+		if (err)
+			return translate_error(fs, prev_orphan, err);
+
+		if (orphan.i_dtime == prev_orphan)
+			return translate_error(fs, prev_orphan,
+					       EXT2_ET_FILESYSTEM_CORRUPTED);
+
+		if (orphan.i_dtime == ino) {
+			dbg_printf(ff, "%s: prev=%d\n",
+				   __func__, prev_orphan);
+
+			orphan.i_dtime = inode->i_dtime;
+			inode->i_dtime = 0;
+
+			err = fuse4fs_write_inode(fs, prev_orphan, &orphan);
+			if (err)
+				return translate_error(fs, prev_orphan, err);
+
+			return 0;
+		}
+
+		dbg_printf(ff, "%s: orphan=%d next=%d\n",
+			   __func__, prev_orphan, orphan.i_dtime);
+		prev_orphan = orphan.i_dtime;
+	}
+
+	return translate_error(fs, ino, EXT2_ET_FILESYSTEM_CORRUPTED);
+}
+
 static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 {
 	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
 	errcode_t err;
 	struct ext2_inode_large inode;
 	int ret = 0;
@@ -2181,7 +2259,6 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		return 0; /* XXX: already done? */
 	case 1:
 		inode.i_links_count--;
-		ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 		break;
 	default:
 		inode.i_links_count--;
@@ -2194,6 +2271,26 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	dbg_printf(ff, "%s: put ino=%d opencount=%d\n", __func__, ino,
+		   fi->i_open_count);
+
+	/*
+	 * The file is unlinked but still open; add it to the orphan list and
+	 * free it later.
+	 */
+	if (fi->i_open_count > 0) {
+		fuse4fs_iput(ff, fi);
+		ret = fuse4fs_add_to_orphans(ff, ino, &inode);
+		if (ret)
+			return ret;
+
+		goto write_out;
+	}
+	fuse4fs_iput(ff, fi);
 
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
@@ -2213,6 +2310,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 			return translate_error(fs, ino, err);
 	}
 
+	ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	ext2fs_inode_alloc_stats2(fs, ino, -1,
 				  LINUX_S_ISDIR(inode.i_mode));
 
@@ -2761,6 +2859,16 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 	if (ret)
 		goto out2;
 
+	/*
+	 * Linking a file back into the filesystem requires removing it from
+	 * the orphan list.
+	 */
+	if (inode.i_links_count == 0) {
+		ret = fuse4fs_remove_from_orphans(ff, child, &inode);
+		if (ret)
+			goto out2;
+	}
+
 	inode.i_links_count++;
 	ret = update_ctime(fs, child, &inode);
 	if (ret)
@@ -3044,7 +3152,8 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino, struct fuse_file_info *fp)
+			     ext2_ino_t ino,
+			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -3120,6 +3229,8 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	file->check_flags = check;
 	fuse4fs_set_handle(fp, file);
+	dbg_printf(ff, "%s: ino=%d fh=%p opencount=%d\n", __func__, ino, file,
+		   file->fi->i_open_count);
 
 out:
 	if (ret)
@@ -3136,6 +3247,8 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+
 	fuse4fs_start(ff);
 	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
 	fuse4fs_finish(ff, ret);
@@ -3284,6 +3397,55 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		fuse_reply_err(req, -ret);
 }
 
+static int fuse4fs_free_unlinked(struct fuse4fs *ff, ext2_ino_t ino)
+{
+	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	if (inode.i_links_count > 0)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%d links=%d\n", __func__, ino,
+		   inode.i_links_count);
+
+	if (ext2fs_has_feature_ea_inode(fs->super)) {
+		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
+		if (ret)
+			return ret;
+	}
+
+	/* Nobody holds this file; free its blocks! */
+	err = ext2fs_free_ext_attr(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	if (ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode))) {
+		err = ext2fs_punch(fs, ino, EXT2_INODE(&inode), NULL,
+				   0, ~0ULL);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	ret = fuse4fs_remove_from_orphans(ff, ino, &inode);
+	if (ret)
+		return ret;
+
+	ext2fs_set_dtime(fs, EXT2_INODE(&inode));
+	ext2fs_inode_alloc_stats2(fs, ino, -1, LINUX_S_ISDIR(inode.i_mode));
+
+	err = fuse4fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		       struct fuse_file_info *fp)
 {
@@ -3295,9 +3457,21 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CHECK_HANDLE(req, fh);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	dbg_printf(ff, "%s: ino=%d fh=%p opencount=%u\n",
+		   __func__, fh->ino, fh, fh->fi->i_open_count);
+
 	fs = fuse4fs_start(ff);
 
+	/*
+	 * If the file is no longer open and is unlinked, free it, which
+	 * removes it from the ondisk list.
+	 */
+	if (--fh->fi->i_open_count == 0) {
+		ret = fuse4fs_free_unlinked(ff, fh->ino);
+		if (ret)
+			goto out_iput;
+	}
+
 	if ((fp->flags & O_SYNC) &&
 	    fuse4fs_is_writeable(ff) &&
 	    (fh->open_flags & EXT2_FILE_WRITE)) {
@@ -3306,6 +3480,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+out_iput:
 	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);


