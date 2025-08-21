Return-Path: <linux-fsdevel+bounces-58519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C7B2EA32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171577B8498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34881F78E6;
	Thu, 21 Aug 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2uwZ1gR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA445FEE6;
	Thu, 21 Aug 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738770; cv=none; b=L9Ld7BlAyGiDi4AELTtR12wKLT40znzkFBwrkC78CdkVflIrd2EkLiNa4RLia48Yjl12xgnnktihky74FS/ps+Iz94M0C1JHhvMJhcqqNKyEeM2XNQmMgYiCMVAP/7KBmNM+QM24lrwb9xYC99d9+QRHgP1/WK+MHU/2R8Dq+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738770; c=relaxed/simple;
	bh=Umet8DtOkxOIUhigosai572holc7Mp/rM32XMr7tsM4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LV54xj7DfoOLIMNaaMoP4YrakM9AIvX53jiPtMhm4qHpfENBWSKZlo0EJVZsPvJqEj9+lqGgESN5xh3StjkuFKxYtXfV5IBOA8bRmJx/txiAOqTuvPPZ1KdTMyPi3j7QqViN0UU1/8ytCRP81R1iXchmURFewYAxf7ytEqw5cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2uwZ1gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21290C4CEE7;
	Thu, 21 Aug 2025 01:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738770;
	bh=Umet8DtOkxOIUhigosai572holc7Mp/rM32XMr7tsM4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C2uwZ1gRTVoQBt64eArM+d2c3pnhO4HlBjS8mcszFwFS6z/Woq1oBzgHBwaaqmALw
	 D95MpSeSSyzrreVsJBF+eR4uPcTSPck/ZV9OOLGFB1DSAV/S4qpTZMI/H1tNs8tx3A
	 eIZt73by+Ay/de4w8VuIG8Si6g21lmR1jYj/09QZuyDTfs9iTGFFn7eEjzvRdQS9iv
	 TfOj+FJj62+n6wRTMWFYBUBV5ETyW1L38k/z1Bg4Gau7AN+9bVwkQIoe+GISLbd+5s
	 KKeNJuALZ3hRFWND6JW0ftLxZwSgufTuNuePrpVv6E9FvSnD5SIfbevBybQKisAxiD
	 59hR584kCPvFQ==
Date: Wed, 20 Aug 2025 18:12:49 -0700
Subject: [PATCH 19/20] fuse4fs: implement FUSE_TMPFILE
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713150.20753.7509097760351998845.stgit@frogsfrogsfrogs>
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

Allow creation of O_TMPFILE files now that we know how to use the
unlinked list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse4fs.c |   93 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 26 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 1d1797a483a139..3f88e98a20c203 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -897,22 +897,25 @@ static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
 
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
@@ -945,21 +948,31 @@ static int fuse4fs_inum_access(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
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
@@ -3123,7 +3136,7 @@ static void detect_linux_executable_open(int kernel_flags, int *access_check,
 #endif /* __linux__ */
 
 static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
-			     ext2_ino_t ino,
+			     ext2_ino_t ino, bool linked,
 			     struct fuse_file_info *fp)
 {
 	ext2_filsys fs = ff->fs;
@@ -3153,6 +3166,9 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 		break;
 	}
 
+	if (linked)
+		check |= L_OK;
+
 	/*
 	 * If the caller wants to truncate the file, we need to ask for full
 	 * write access even if the caller claims to be appending.
@@ -3219,7 +3235,7 @@ static void op_open(fuse_req_t req, fuse_ino_t fino, struct fuse_file_info *fp)
 	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
 
 	fuse4fs_start(ff);
-	ret = fuse4fs_open_file(ff, ctxt, ino, fp);
+	ret = fuse4fs_open_file(ff, ctxt, ino, true, fp);
 	fuse4fs_finish(ff, ret);
 
 	if (ret)
@@ -4128,22 +4144,28 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
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
@@ -4161,6 +4183,12 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
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
@@ -4182,13 +4210,15 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
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
@@ -4203,6 +4233,14 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
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
@@ -5161,6 +5199,9 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	.tmpfile = op_tmpfile,
+#endif
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,


