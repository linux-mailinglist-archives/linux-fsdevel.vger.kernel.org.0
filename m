Return-Path: <linux-fsdevel+bounces-61611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D0B58A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C82A32F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445791C5F23;
	Tue, 16 Sep 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWQz5joI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF09FC1D;
	Tue, 16 Sep 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984152; cv=none; b=cdjqDOPIqTeNWrQUKVJTBdL7Oblp6AXFJIzJnYIUjs/ilbUiSteEZWPtji0WtscwJbGi48+LIwEvuc49Ku3k43OUMAdm1U99pDCaKtvtwuSroAkNQKlVYAc4BewIil8C1sGTc6iqaRaDzT4l6nncCgLXScPzgJcFOxQrODyHqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984152; c=relaxed/simple;
	bh=HQptioKNmZQjX3Az/dPOEoOVuh/a5GW+SasoqVSp1Ko=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq/t+MaNRxIlJAythdiPjiaHxGdff8d6crPOwVRRbBahM2uswdjENTPEZ/dYxk1UnvRGtfKn+HSqBEFvHvF5lgp//7vpvgJw36PbadJetvQ+R1dvdaE/QPcQE0VDIC09OeG+1QozqPU1f/4b9cRRRetCuJnW4FIFrotG65NBeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWQz5joI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27578C4CEF1;
	Tue, 16 Sep 2025 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984152;
	bh=HQptioKNmZQjX3Az/dPOEoOVuh/a5GW+SasoqVSp1Ko=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cWQz5joIaGGsCJhWVWmbO2tHRRwUr7lvHOs5roePUzjoRlZktDRF+HfW2jbBTHYsG
	 5mYUceW8WaWzE7XLtREg+KHEuyj+a7HXqZiCY4+MPat9brfsTeLU9nOOTd+LK8BXdl
	 35dIGrXng6nuzWV0EVSoHzyuuQFRse/aTt63QDdSt2wdQQ4lwhfqIL+ItldekyvrjO
	 umnYf5ZyTmUUo4wxAhH07hGDnxs20lAqQ5vsnEDoeBKUzNkH8VZx31+V+yvarXtjZz
	 o+t5NH/gg4eUjQvI7uiYx3/U4N9Zd+QCoYTqlNtY1zQUyw6M8RgmvsoNWRf0SjLK4c
	 rzQ8O1LW9HPVw==
Date: Mon, 15 Sep 2025 17:55:51 -0700
Subject: [PATCH 20/21] fuse4fs: implement FUSE_TMPFILE
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161135.389252.12261810645392092283.stgit@frogsfrogsfrogs>
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

Allow creation of O_TMPFILE files now that we know how to use the
unlinked list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   93 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 26 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e046c782957e60..1015b13f4adac7 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -902,22 +902,25 @@ static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
 
 /* Test for append permission */
 #define A_OK	16
+/* Test for linked file */
+#define L_OK	32
 
 static int fuse4fs_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
 				 const struct ext2_inode *inode, int mask)
 {
-	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
+	EXT2FS_BUILD_BUG_ON(((A_OK | L_OK) & (R_OK | W_OK | X_OK | F_OK)) != 0);
 
 	/* no writing or metadata changes to read-only or broken fs */
 	if ((mask & (W_OK | A_OK)) && !fuse4fs_is_writeable(ff))
 		return -EROFS;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s iflags=0x%x\n",
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s%s iflags=0x%x\n",
 		   ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
 		   (mask & A_OK ? "a" : ""),
+		   (mask & L_OK ? "l" : ""),
 		   inode->i_flags);
 
 	/* is immutable? */
@@ -950,21 +953,31 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		return translate_error(fs, ino, err);
 	perms = inode.i_mode & 0777;
 
-	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s perms=0%o iflags=0x%x "
+	dbg_printf(ff, "access ino=%d mask=e%s%s%s%s%s perms=0%o iflags=0x%x "
 		   "fuid=%d fgid=%d uid=%d gid=%d\n", ino,
 		   (mask & R_OK ? "r" : ""),
 		   (mask & W_OK ? "w" : ""),
 		   (mask & X_OK ? "x" : ""),
 		   (mask & A_OK ? "a" : ""),
+		   (mask & L_OK ? "l" : ""),
 		   perms, inode.i_flags,
 		   inode_uid(inode), inode_gid(inode),
 		   ctxt->uid, ctxt->gid);
 
-	/* linked files cannot be on the unlinked list or deleted */
-	if (inode.i_dtime != 0) {
-		dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
-			   __func__, ino, inode.i_dtime);
-		return -ENOENT;
+	if (mask & L_OK) {
+		/* linked files cannot be on the unlinked list or deleted */
+		if (inode.i_dtime != 0) {
+			dbg_printf(ff, "%s: unlinked ino=%d dtime=0x%x\n",
+				   __func__, ino, inode.i_dtime);
+			return -ENOENT;
+		}
+	} else {
+		/* unlinked files cannot be deleted */
+		if (inode.i_dtime >= fs->super->s_inodes_count) {
+			dbg_printf(ff, "%s: deleted ino=%d dtime=0x%x\n",
+				   __func__, ino, inode.i_dtime);
+			return -ENOENT;
+		}
 	}
 
 	/* existence check */
@@ -3152,7 +3165,7 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino,
+			     ext2_ino_t ino, bool linked,
 			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
@@ -3182,6 +3195,9 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		break;
 	}
 
+	if (linked)
+		check |= L_OK;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.
@@ -3250,7 +3266,7 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
 	fuse4fs_start(ff);
-	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
+	ret = fuse4fs_open_file(ff, ctxt, ino, true, fp);
 	fuse4fs_finish(ff, ret);
 
 	if (ret)
@@ -4159,22 +4175,28 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	dbg_printf(ff, "%s: creating dir=%d name='%s' child=%d\n",
-		   __func__, parent, name, child);
-	err = ext2fs_link(fs, parent, name, child,
-			  filetype | EXT2FS_LINK_EXPAND);
-	if (err) {
-		ret = translate_error(fs, parent, err);
-		goto out2;
+	if (name) {
+		dbg_printf(ff, "%s: creating dir=%d name='%s' child=%d\n",
+			   __func__, parent, name, child);
+
+		err = ext2fs_link(fs, parent, name, child,
+				  filetype | EXT2FS_LINK_EXPAND);
+		if (err) {
+			ret = translate_error(fs, parent, err);
+			goto out2;
+		}
+
+		ret = update_mtime(fs, parent, NULL);
+		if (ret)
+			goto out2;
+	} else {
+		dbg_printf(ff, "%s: creating dir=%d tempfile=%d\n",
+			   __func__, parent, child);
 	}
 
-	ret = update_mtime(fs, parent, NULL);
-	if (ret)
-		goto out2;
-
 	memset(&inode, 0, sizeof(inode));
 	inode.i_mode = mode;
-	inode.i_links_count = 1;
+	inode.i_links_count = name ? 1 : 0;
 	fuse4fs_set_extra_isize(ff, child, &inode);
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
@@ -4192,6 +4214,12 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		ext2fs_extent_free(handle);
 	}
 
+	if (!name) {
+		ret = fuse4fs_add_to_orphans(ff, child, &inode);
+		if (ret)
+			goto out2;
+	}
+
 	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4213,13 +4241,15 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 
 	fp->flags &= ~O_TRUNC;
-	ret = fuse4fs_open_file(ff, ctxt, child, fp);
+	ret = fuse4fs_open_file(ff, ctxt, child, name != NULL, fp);
 	if (ret)
 		goto out2;
 
-	ret = fuse4fs_dirsync_flush(ff, parent, NULL);
-	if (ret)
-		goto out2;
+	if (name) {
+		ret = fuse4fs_dirsync_flush(ff, parent, NULL);
+		if (ret)
+			goto out2;
+	}
 
 	ret = fuse4fs_stat_inode(ff, child, NULL, &fstat);
 	if (ret)
@@ -4234,6 +4264,14 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 		fuse_reply_create(req, &fstat.entry, fp);
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+static void op_tmpfile(fuse_req_t req, fuse_ino_t fino, mode_t mode,
+		       struct fuse_file_info *fp)
+{
+	op_create(req, fino, NULL, mode, fp);
+}
+#endif
+
 enum fuse4fs_time_action {
 	TA_NOW,		/* set to current time */
 	TA_OMIT,	/* do not set timestamp */
@@ -5225,6 +5263,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	.tmpfile = op_tmpfile,
+#endif
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,


