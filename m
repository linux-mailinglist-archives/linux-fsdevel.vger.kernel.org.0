Return-Path: <linux-fsdevel+bounces-58518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C6B2EA3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AF45E283A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4A1F8676;
	Thu, 21 Aug 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh7qVrJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA555FEE6;
	Thu, 21 Aug 2025 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738755; cv=none; b=N86wMQSuzsORpTFGTsqPgoaDEFiWrt3+Jqct4iPTruv3YaRsSQiAgxaBwvMxlzi8kifpiofyOgDMjTwN1OVAjpWFw95xpxuiOkBz5merBWwcoU1t/iL6um8Z+NByN4qhjKqH7bjJ5m0qjnnH9t11wTSv3E9ogJAu+etUgCJ837I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738755; c=relaxed/simple;
	bh=LOj7HHCfQdDb843+OqvACigpr1JaCwZpO9fMJJWEaxE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaZ9ABvlg+5KBWPwA6hhiYHbh5B+rahXCnXVWSI3s054ovvEnOT6HRcq61m4u+GtV34HbUtao/sPABpvfCXVfXpAnlbp3yo9IFTjADoP0/wI92HN6JIQ8wQ9YbD1p4EJoZdarv6OooxKzvHUEJB2kpnD6S+CLx4vfBFldN1bduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh7qVrJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46AC4CEE7;
	Thu, 21 Aug 2025 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738754;
	bh=LOj7HHCfQdDb843+OqvACigpr1JaCwZpO9fMJJWEaxE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oh7qVrJrkFqzvVvl6UfB0KsCymr4g5mVcuTM0IRELk5/UHCcI7Rn4iJC0HS+iH7t8
	 wt8G6xjL3PZgyYrVxv6gnWZUpfWZVkBcz8GP4gLTDCf/ezamLBwm3s8t6IemafT2z+
	 6RiuMjI7xnxjISdYjcyiggLffAhifCdsBUHaSaZAfWc9NxUEZxflVv9j769ZA+gKa/
	 1JPypp0L47ha/GLij0I5tmMDTSJN5l5tv6Zv/kLAONGNrpdADY8GXjxyTMQuoIF/FH
	 5YmVPUWnHb6cmXW/sbBMIAROpj40Hi7+5JOOPn+V1YiIzNYutcJqWqi8URpD1gzZYN
	 WTGzU9fWhvuVA==
Date: Wed, 20 Aug 2025 18:12:34 -0700
Subject: [PATCH 18/20] fuse4fs: use the orphaned inode list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713131.20753.249562496853950632.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
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
 misc/fuse4fs.c |  181 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 3 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index e2a9e7bfe54b00..1d1797a483a139 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -955,6 +955,13 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
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
@@ -2140,9 +2147,80 @@ static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -2159,7 +2237,6 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		return 0; /* XXX: already done? */
 	case 1:
 		inode.i_links_count--;
-		ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 		break;
 	default:
 		inode.i_links_count--;
@@ -2172,6 +2249,26 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
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
@@ -2191,6 +2288,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 			return translate_error(fs, ino, err);
 	}
 
+	ext2fs_set_dtime(fs, EXT2_INODE(&inode));
 	ext2fs_inode_alloc_stats2(fs, ino, -1,
 				  LINUX_S_ISDIR(inode.i_mode));
 
@@ -2735,6 +2833,16 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
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
@@ -3015,7 +3123,8 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino, struct fuse_file_info *fp)
+			     ext2_ino_t ino,
+			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
@@ -3089,6 +3198,8 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	file->fi->i_open_count++;
 
 	fuse4fs_set_handle(fp, file);
+	dbg_printf(ff, "%s: ino=%d fh=%p opencount=%d\n", __func__, ino, file,
+		   file->fi->i_open_count);
 
 out:
 	if (ret)
@@ -3105,6 +3216,8 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 
 	FUSE4FS_CHECK_CONTEXT(req);
 	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+
 	fuse4fs_start(ff);
 	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
 	fuse4fs_finish(ff, ret);
@@ -3253,6 +3366,55 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
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
@@ -3264,9 +3426,21 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 
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
@@ -3275,6 +3449,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+out_iput:
 	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);


