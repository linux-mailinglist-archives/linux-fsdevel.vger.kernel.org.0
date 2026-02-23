Return-Path: <linux-fsdevel+bounces-78179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLYYJwjmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0317FD0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9719304C4B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E637FF58;
	Mon, 23 Feb 2026 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNrHFrY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B437B41C;
	Mon, 23 Feb 2026 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890172; cv=none; b=juca+Do1EqPoBJbWvCkiiYiD2W8uY2gcvM5pPqBTNFswwKYXh7k3V+yCQcJsM8X+BuPpCePyV6jPMRkl8XFMoLOkR0lCBLyjlEsXdD0w3XzhjzsSJAexah+gwH2L/Fx8jMEmmEt2RN3dioSJr451Luea4G2WvN7Hgql+zLvly5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890172; c=relaxed/simple;
	bh=YWA79m2BGh/ZxWq8MNQR2S9is+50k4FqAAzmRnk5/Gw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ic7YzOHk7fTyD79O3eB7GDMXiHUZt08391ei3i3dZP9toyV43xHpGO0J8xigRpkC9gs71gJLJHFz5X3EkiM8Cuj1wzLiIttbpbWqBphOm8u0qxlzrn3m8TpxsmPaCzOMT3U89EOAJHGj5X31iaOXoTA9H0ISIPX89BP+f3dL2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNrHFrY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B2C116C6;
	Mon, 23 Feb 2026 23:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890171;
	bh=YWA79m2BGh/ZxWq8MNQR2S9is+50k4FqAAzmRnk5/Gw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SNrHFrY0oKD5fuXkT5zYGGU12rZoH2jPwaVQrF4FhnS//bDd612s0ShDDtH8ZBhQg
	 K3B9dBF9yQ2iGvb6CkJxEGThFThJ9ssXVU/gAFpKHOtQQdM9VB88GxTt8R+Wecg1kG
	 0Gh2NLVfae10N5DU3gw6eaP1PcdqivtjThH6Zh7QkZjlfT5wkQee5n7gnbkx/Df9Ue
	 iaTOas3p9XR6oZIAiQ03VJ2l6EFbKSyWknDp+3XGKghIUfIGu02Djk+OHLliSy0b9t
	 RDT1+hAquuewttkMVqPCAxzpHIT+3TLeHLqCEp2U2NHJ6Y4tha40JsF6CYrVS7OvKm
	 GbROVRmumYf/g==
Date: Mon, 23 Feb 2026 15:42:50 -0800
Subject: [PATCH 06/10] fuse2fs: use coarse timestamps for iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745288.3944028.7178519912185806477.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78179-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47B0317FD0F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel is responsible for maintaining timestamps
because file writes don't upcall to fuse2fs.  The kernel's predicate for
deciding if [cm]time should be updated bases its decisions off [cm]time
being an exact match for the coarse clock (instead of checking that
[cm]time < coarse_clock) which means that fuse2fs setting a fine-grained
timestamp that is slightly ahead of the coarse clock can result in
timestamps appearing to go backwards.  generic/423 doesn't like seeing
btime > ctime from statx, so we'll use the coarse clock in iomap mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  110 +++++++++++++++++++++++++++++++----------------------
 misc/fuse2fs.c    |   34 ++++++++++++----
 2 files changed, 90 insertions(+), 54 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 97747d42a64a52..6cda267ad5cf40 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1004,8 +1004,24 @@ static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
 	ext2fs_extent_free(extents);
 }
 
-static void get_now(struct timespec *now)
+static void fuse4fs_get_now(struct fuse4fs *ff, struct timespec *now)
 {
+#ifdef CLOCK_REALTIME_COARSE
+	/*
+	 * In iomap mode, the kernel is responsible for maintaining timestamps
+	 * because file writes don't upcall to fuse4fs.  The kernel's predicate
+	 * for deciding if [cm]time should be updated bases its decisions off
+	 * [cm]time being an exact match for the coarse clock (instead of
+	 * checking that [cm]time < coarse_clock) which means that fuse4fs
+	 * setting a fine-grained timestamp that is slightly ahead of the
+	 * coarse clock can result in timestamps appearing to go backwards.
+	 * generic/423 doesn't like seeing btime > ctime from statx, so we'll
+	 * use the coarse clock in iomap mode.
+	 */
+	if (fuse4fs_iomap_enabled(ff) &&
+	    !clock_gettime(CLOCK_REALTIME_COARSE, now))
+		return;
+#endif
 #ifdef CLOCK_REALTIME
 	if (!clock_gettime(CLOCK_REALTIME, now))
 		return;
@@ -1028,11 +1044,12 @@ static void increment_version(struct ext2_inode_large *inode)
 		inode->i_version_hi = ver >> 32;
 }
 
-static void init_times(struct ext2_inode_large *inode)
+static void fuse4fs_init_timestamps(struct fuse4fs *ff,
+				    struct ext2_inode_large *inode)
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -1040,14 +1057,15 @@ static void init_times(struct ext2_inode_large *inode)
 	increment_version(inode);
 }
 
-static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse4fs_update_ctime(struct fuse4fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
-	errcode_t err;
 	struct timespec now;
 	struct ext2_inode_large inode;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -1071,12 +1089,13 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
 	return 0;
 }
 
-static int update_atime(ext2_filsys fs, ext2_ino_t ino)
+static int fuse4fs_update_atime(struct fuse4fs *ff, ext2_ino_t ino)
 {
-	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
+	ext2_filsys fs = ff->fs;
 	double datime, dmtime, dnow;
+	errcode_t err;
 
 	err = fuse4fs_read_inode(fs, ino, &inode);
 	if (err)
@@ -1085,7 +1104,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -1107,15 +1126,16 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	return 0;
 }
 
-static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
-			struct ext2_inode_large *pinode)
+static int fuse4fs_update_mtime(struct fuse4fs *ff, ext2_ino_t ino,
+				struct ext2_inode_large *pinode)
 {
-	errcode_t err;
 	struct ext2_inode_large inode;
 	struct timespec now;
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
 
 	if (pinode) {
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -1126,7 +1146,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -2422,7 +2442,7 @@ static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 	buf[len] = 0;
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse4fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2691,7 +2711,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2714,7 +2734,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2776,7 +2796,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2802,7 +2822,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3153,7 +3173,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -3225,7 +3245,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, ext2_ino_t parent,
 		goto out;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out;
 out:
@@ -3359,7 +3379,7 @@ static int fuse4fs_rmdir(struct fuse4fs *ff, ext2_ino_t parent,
 			goto out;
 		}
 		ext2fs_dec_nlink(EXT2_INODE(&inode));
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse4fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse4fs_write_inode(fs, rds.parent, &inode);
@@ -3463,7 +3483,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3486,7 +3506,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3717,11 +3737,11 @@ static void op_rename(fuse_req_t req, fuse_ino_t from_parent, const char *from,
 	}
 
 	/* Update timestamps */
-	ret = update_ctime(fs, from_ino, NULL);
+	ret = fuse4fs_update_ctime(ff, from_ino, NULL);
 	if (ret)
 		goto out;
 
-	ret = update_mtime(fs, to_dir_ino, NULL);
+	ret = fuse4fs_update_mtime(ff, to_dir_ino, NULL);
 	if (ret)
 		goto out;
 
@@ -3800,7 +3820,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 	}
 
 	ext2fs_inc_nlink(fs, EXT2_INODE(&inode));
-	ret = update_ctime(fs, child, &inode);
+	ret = fuse4fs_update_ctime(ff, child, &inode);
 	if (ret)
 		goto out2;
 
@@ -3817,7 +3837,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -4053,7 +4073,7 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse4fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -4262,7 +4282,7 @@ static void op_read(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	}
 
 	if (fh->check_flags != X_OK && fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse4fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4336,7 +4356,7 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse4fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4783,7 +4803,7 @@ static void op_setxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4877,7 +4897,7 @@ static void op_removexattr(fuse_req_t req, fuse_ino_t fino, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -5024,7 +5044,7 @@ static void __op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
 	}
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse4fs_update_atime(i.ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -5124,7 +5144,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 			goto out2;
 		}
 
-		ret = update_mtime(fs, parent, NULL);
+		ret = fuse4fs_update_mtime(ff, parent, NULL);
 		if (ret)
 			goto out2;
 	} else {
@@ -5165,7 +5185,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -5244,7 +5264,7 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	int ret = 0;
 
 	if (to_set & (FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW))
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 
 	if (to_set & FUSE_SET_ATTR_ATIME_NOW) {
 		atime = now;
@@ -5382,7 +5402,7 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	}
 
 	/* Update ctime for any attribute change */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -5464,7 +5484,7 @@ static int ioctl_setflags(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5517,7 +5537,7 @@ static int ioctl_setversion(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	inode.i_generation = *indata;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5653,7 +5673,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5949,7 +5969,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -6122,7 +6142,7 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -8329,7 +8349,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 21e27efb835659..9b536fe77dda37 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -840,8 +840,24 @@ static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
 	ext2fs_extent_free(extents);
 }
 
-static void get_now(struct timespec *now)
+static void fuse2fs_get_now(struct fuse2fs *ff, struct timespec *now)
 {
+#ifdef CLOCK_REALTIME_COARSE
+	/*
+	 * In iomap mode, the kernel is responsible for maintaining timestamps
+	 * because file writes don't upcall to fuse2fs.  The kernel's predicate
+	 * for deciding if [cm]time should be updated bases its decisions off
+	 * [cm]time being an exact match for the coarse clock (instead of
+	 * checking that [cm]time < coarse_clock) which means that fuse2fs
+	 * setting a fine-grained timestamp that is slightly ahead of the
+	 * coarse clock can result in timestamps appearing to go backwards.
+	 * generic/423 doesn't like seeing btime > ctime from statx, so we'll
+	 * use the coarse clock in iomap mode.
+	 */
+	if (fuse2fs_iomap_enabled(ff) &&
+	    !clock_gettime(CLOCK_REALTIME_COARSE, now))
+		return;
+#endif
 #ifdef CLOCK_REALTIME
 	if (!clock_gettime(CLOCK_REALTIME, now))
 		return;
@@ -869,7 +885,7 @@ static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -888,7 +904,7 @@ static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 	struct ext2_inode_large inode;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -934,7 +950,7 @@ static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -969,7 +985,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 
 	if (pinode) {
-		get_now(&now);
+		fuse2fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -984,7 +1000,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -4978,9 +4994,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
 	tv[1] = ctv[1];
 #ifdef UTIME_NOW
 	if (tv[0].tv_nsec == UTIME_NOW)
-		get_now(tv);
+		fuse2fs_get_now(ff, tv);
 	if (tv[1].tv_nsec == UTIME_NOW)
-		get_now(tv + 1);
+		fuse2fs_get_now(ff, tv + 1);
 #endif /* UTIME_NOW */
 #ifdef UTIME_OMIT
 	if (tv[0].tv_nsec != UTIME_OMIT)
@@ -7736,7 +7752,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;


