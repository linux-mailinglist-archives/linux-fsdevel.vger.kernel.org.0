Return-Path: <linux-fsdevel+bounces-61646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AEB58A9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226C03A0403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC001D63CD;
	Tue, 16 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suM+zTGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA638DDB;
	Tue, 16 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984701; cv=none; b=WYMzekW3/jhVdBvyT/x75ppAjpq5glfFL9Rn75FQtRoYFY4lUUaa0IPThNAakoMeFdN6I5Ff1pz/56Um1y+EEQCZDonrtoWkZ4JF9cwQEuGyuOvo3HoPu1k9Fio6/n0ONaqHaIA1eKrf1NC6uA4jCjRCz2KN9P7XYAnHhXQF3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984701; c=relaxed/simple;
	bh=o+zfia5GOGhY7MFBEif/Vn9ykg24Sl6UTGu9S2pHMhI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw8tIPc/9jqU7qSdX9whjwYHle3jaVuAQporL0KYP7lJFQMWM/Dkw612+eprvWFVzl6Yf+nisADDwwfoCIemr0ttpIbSv8sHiEJE+Z1xgh/V2nVDJCIay0WEJmG7LoVx3qTBWMWUNv9tf6rygJJ638n5iulnQwRbzTHgz/d7XOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suM+zTGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD538C4CEF1;
	Tue, 16 Sep 2025 01:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984700;
	bh=o+zfia5GOGhY7MFBEif/Vn9ykg24Sl6UTGu9S2pHMhI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=suM+zTGEJZsoQuxP8D08F5KSJMohC1i6h2uZaqurrRb494p01q4w3iCeFLU1QHIOk
	 Vix9Zq4O3bQRppfYyLbfHASHftex0V8Sdn4kxVEi31LzymKpwIVIOYDgX2pitZ4/6a
	 dKmyK6dsxVloPGKem0g8KeKfTOA97yUgdFmC6kpbmgeeXwoK3GVHrfSUF28p/3aIID
	 B5r/ZMO3ZJn0+WOeWXfd1OyQ2f7jWwCcNylmjutuwzwfMKsqzne3Iu/sdUUUg3YoIM
	 QK7cl0Io2fblXcGDKdfwYMA88oFixUJWl0fKqxhNyajcYxD6t9ZfSbqJVBK0+7RB56
	 kGnxVXITwj8pg==
Date: Mon, 15 Sep 2025 18:05:00 -0700
Subject: [PATCH 06/10] fuse2fs: use coarse timestamps for iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162448.391272.14129412588364074302.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
index ab807f1479870c..5673a545b06b31 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -827,8 +827,24 @@ static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -851,11 +867,12 @@ static void increment_version(struct ext2_inode_large *inode)
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
@@ -863,14 +880,15 @@ static void init_times(struct ext2_inode_large *inode)
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
@@ -894,12 +912,13 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
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
@@ -908,7 +927,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -930,15 +949,16 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
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
@@ -949,7 +969,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -2054,7 +2074,7 @@ static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 	buf[len] = 0;
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse4fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2323,7 +2343,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2346,7 +2366,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2408,7 +2428,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2434,7 +2454,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2775,7 +2795,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -2846,7 +2866,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, ext2_ino_t parent,
 		goto out;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out;
 out:
@@ -2985,7 +3005,7 @@ static int fuse4fs_rmdir(struct fuse4fs *ff, ext2_ino_t parent,
 		}
 		if (inode.i_links_count > 1)
 			inode.i_links_count--;
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse4fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse4fs_write_inode(fs, rds.parent, &inode);
@@ -3089,7 +3109,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3112,7 +3132,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3303,11 +3323,11 @@ static void op_rename(fuse_req_t req, fuse_ino_t from_parent, const char *from,
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
 
@@ -3381,7 +3401,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 	}
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, child, &inode);
+	ret = fuse4fs_update_ctime(ff, child, &inode);
 	if (ret)
 		goto out2;
 
@@ -3398,7 +3418,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3634,7 +3654,7 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse4fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -3836,7 +3856,7 @@ static void op_read(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	}
 
 	if (fh->check_flags != X_OK && fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse4fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -3910,7 +3930,7 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse4fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4357,7 +4377,7 @@ static void op_setxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4451,7 +4471,7 @@ static void op_removexattr(fuse_req_t req, fuse_ino_t fino, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4598,7 +4618,7 @@ static void __op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
 	}
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse4fs_update_atime(i.ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4698,7 +4718,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 			goto out2;
 		}
 
-		ret = update_mtime(fs, parent, NULL);
+		ret = fuse4fs_update_mtime(ff, parent, NULL);
 		if (ret)
 			goto out2;
 	} else {
@@ -4739,7 +4759,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4818,7 +4838,7 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	int ret = 0;
 
 	if (to_set & (FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW))
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 
 	if (to_set & FUSE_SET_ATTR_ATIME_NOW) {
 		atime = now;
@@ -4956,7 +4976,7 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	}
 
 	/* Update ctime for any attribute change */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -5038,7 +5058,7 @@ static int ioctl_setflags(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5091,7 +5111,7 @@ static int ioctl_setversion(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	inode.i_generation = *indata;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5227,7 +5247,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5520,7 +5540,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -5693,7 +5713,7 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -7819,7 +7839,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index aedd1add48db82..fa4359133a79fc 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -662,8 +662,24 @@ static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -691,7 +707,7 @@ static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -710,7 +726,7 @@ static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 	struct ext2_inode_large inode;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -756,7 +772,7 @@ static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -791,7 +807,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 
 	if (pinode) {
-		get_now(&now);
+		fuse2fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -806,7 +822,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -4548,9 +4564,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
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
@@ -7259,7 +7275,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;


