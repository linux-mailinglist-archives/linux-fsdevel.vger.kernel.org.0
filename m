Return-Path: <linux-fsdevel+bounces-58556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C8B2EA93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4361C5E049D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF8212FA0;
	Thu, 21 Aug 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBS+C8ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457B205E25;
	Thu, 21 Aug 2025 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739349; cv=none; b=sBJ/5HWQ6n6fSZCseBj2rKU+La8BBvH82znQkk+efXOMG8lhkMMrKP6jYagsjt0YczY6aKUfGzRxEx7VXQ9VbIJ6DMoawgdA1S3XCHhyg+bWeHbHAu08kht1rlIUPGaPN/IjssSNvJoxEyYN076wMjOMCJoRqYRsVOcluDR40g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739349; c=relaxed/simple;
	bh=8GPF+j/ergfkdmPeUQSJsG0WxaJeaHh3j3OrTbZeaII=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyW0N72zcVp2hSt5ISfybdzIUzPH9JZZJ7iVCNY3RX0uxtmgjvUwnL3rmilIDSBu8q1jnpK4ZPCMSzqKayNZt6kMNBMzJv5fxpblGMEByUhPUWrRUmyhtw9J+5MSnaFV4eXktaKK/OWwzsibqYkqZv6d1aXgvm/be0lgpBwnLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBS+C8ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CD8C4CEE7;
	Thu, 21 Aug 2025 01:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739349;
	bh=8GPF+j/ergfkdmPeUQSJsG0WxaJeaHh3j3OrTbZeaII=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YBS+C8ERLiH8UATwyeysQuOZk5bmiPML7alJYI0zJxO307iIKT0WU8vCy0payab1w
	 /RHRPGIFNNIIGKw00b3pyK2I7WruusTJzFtjFJUAxjIPCmbYQZr0aSUvgVj6vBQIoi
	 kiDBcDciUGG4cja457eH5rj5+R8OjC9f0dQURyRRaHxW6AOlHM7lJh5qxejQava0HD
	 HvjrDKSJNzpUTcPnb4JJ0wvbCDkebTnZ5Srur0KH+tW0kS8xyW04oJktNXIWoKJvXb
	 CUMVcTva8CPH5wGj4w81ZF5wzfKuzqhgEZOB+mYE3W073yAUq+p7Fe9v1tmFhyBWOS
	 nizRfStB9lgyg==
Date: Wed, 20 Aug 2025 18:22:28 -0700
Subject: [PATCH 5/8] fuse2fs: use coarse timestamps for iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714483.22854.14628412268085357386.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   34 +++++++++++++----
 misc/fuse4fs.c |  110 +++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 90 insertions(+), 54 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fe7d6a2568dcf0..df84884ba6b7d0 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -669,8 +669,24 @@ static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
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
@@ -698,7 +714,7 @@ static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -717,7 +733,7 @@ static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 	struct ext2_inode_large inode;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -763,7 +779,7 @@ static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -798,7 +814,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 
 	if (pinode) {
-		get_now(&now);
+		fuse2fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -813,7 +829,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -4657,9 +4673,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
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
@@ -7389,7 +7405,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index b68573f654279d..a06e963eab6afd 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -823,8 +823,24 @@ static inline void fuse4fs_dump_extents(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -847,11 +863,12 @@ static void increment_version(struct ext2_inode_large *inode)
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
@@ -859,14 +876,15 @@ static void init_times(struct ext2_inode_large *inode)
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
@@ -890,12 +908,13 @@ static int update_ctime(ext2_filsys fs, ext2_ino_t ino,
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
@@ -904,7 +923,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -926,15 +945,16 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
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
@@ -945,7 +965,7 @@ static int update_mtime(ext2_filsys fs, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -2029,7 +2049,7 @@ static void op_readlink(fuse_req_t req, fuse_ino_t fino)
 	buf[len] = 0;
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, ino);
+		ret = fuse4fs_update_atime(ff, ino);
 		if (ret)
 			goto out;
 	}
@@ -2298,7 +2318,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2321,7 +2341,7 @@ static void op_mknod(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -2383,7 +2403,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -2409,7 +2429,7 @@ static void op_mkdir(fuse_req_t req, fuse_ino_t fino, const char *name,
 	if (parent_sgid)
 		inode.i_mode |= S_ISGID;
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -2750,7 +2770,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 		inode.i_links_count--;
 	}
 
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		return ret;
 
@@ -2821,7 +2841,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, ext2_ino_t parent,
 		goto out;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out;
 out:
@@ -2960,7 +2980,7 @@ static int fuse4fs_rmdir(struct fuse4fs *ff, ext2_ino_t parent,
 		}
 		if (inode.i_links_count > 1)
 			inode.i_links_count--;
-		ret = update_mtime(fs, rds.parent, &inode);
+		ret = fuse4fs_update_mtime(ff, rds.parent, &inode);
 		if (ret)
 			goto out;
 		err = fuse4fs_write_inode(fs, rds.parent, &inode);
@@ -3060,7 +3080,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	}
 
 	/* Update parent dir's mtime */
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3083,7 +3103,7 @@ static void op_symlink(fuse_req_t req, const char *target, fuse_ino_t fino,
 	fuse4fs_set_uid(&inode, ctxt->uid);
 	fuse4fs_set_gid(&inode, gid);
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
@@ -3274,11 +3294,11 @@ static void op_rename(fuse_req_t req, fuse_ino_t from_parent, const char *from,
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
 
@@ -3352,7 +3372,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 	}
 
 	inode.i_links_count++;
-	ret = update_ctime(fs, child, &inode);
+	ret = fuse4fs_update_ctime(ff, child, &inode);
 	if (ret)
 		goto out2;
 
@@ -3369,7 +3389,7 @@ static void op_link(fuse_req_t req, fuse_ino_t child_fino,
 		goto out2;
 	}
 
-	ret = update_mtime(fs, parent, NULL);
+	ret = fuse4fs_update_mtime(ff, parent, NULL);
 	if (ret)
 		goto out2;
 
@@ -3602,7 +3622,7 @@ static int fuse4fs_truncate(struct fuse4fs *ff, ext2_ino_t ino, off_t new_size)
 	if (err)
 		return translate_error(fs, ino, err);
 
-	ret = update_mtime(fs, ino, NULL);
+	ret = fuse4fs_update_mtime(ff, ino, NULL);
 	if (ret)
 		return ret;
 
@@ -3802,7 +3822,7 @@ static void op_read(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 	}
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(fs, fh->ino);
+		ret = fuse4fs_update_atime(ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -3876,7 +3896,7 @@ static void op_write(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 		goto out;
 	}
 
-	ret = update_mtime(fs, fh->ino, NULL);
+	ret = fuse4fs_update_mtime(ff, fh->ino, NULL);
 	if (ret)
 		goto out;
 
@@ -4323,7 +4343,7 @@ static void op_setxattr(fuse_req_t req, fuse_ino_t fino, const char *key,
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (!ret && err)
@@ -4417,7 +4437,7 @@ static void op_removexattr(fuse_req_t req, fuse_ino_t fino, const char *key)
 		goto out2;
 	}
 
-	ret = update_ctime(fs, ino, NULL);
+	ret = fuse4fs_update_ctime(ff, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
 	if (err && !ret)
@@ -4564,7 +4584,7 @@ static void __op_readdir(fuse_req_t req, fuse_ino_t fino, size_t size,
 	}
 
 	if (fuse4fs_is_writeable(ff)) {
-		ret = update_atime(i.fs, fh->ino);
+		ret = fuse4fs_update_atime(i.ff, fh->ino);
 		if (ret)
 			goto out;
 	}
@@ -4664,7 +4684,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 			goto out2;
 		}
 
-		ret = update_mtime(fs, parent, NULL);
+		ret = fuse4fs_update_mtime(ff, parent, NULL);
 		if (ret)
 			goto out2;
 	} else {
@@ -4705,7 +4725,7 @@ static void op_create(fuse_req_t req, fuse_ino_t fino, const char *name,
 	}
 
 	inode.i_generation = ff->next_generation++;
-	init_times(&inode);
+	fuse4fs_init_timestamps(ff, &inode);
 	err = fuse4fs_write_inode(fs, child, &inode);
 	if (err) {
 		ret = translate_error(fs, child, err);
@@ -4784,7 +4804,7 @@ static int fuse4fs_utimens(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	int ret = 0;
 
 	if (to_set & (FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW))
-		get_now(&now);
+		fuse4fs_get_now(ff, &now);
 
 	if (to_set & FUSE_SET_ATTR_ATIME_NOW) {
 		atime = now;
@@ -4922,7 +4942,7 @@ static void op_setattr(fuse_req_t req, fuse_ino_t fino, struct stat *attr,
 	}
 
 	/* Update ctime for any attribute change */
-	ret = update_ctime(fs, ino, &inode);
+	ret = fuse4fs_update_ctime(ff, ino, &inode);
 	if (ret)
 		goto out;
 
@@ -5004,7 +5024,7 @@ static int ioctl_setflags(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ret)
 		return ret;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5057,7 +5077,7 @@ static int ioctl_setversion(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 
 	inode.i_generation = *indata;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5168,7 +5188,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 	if (ext2fs_inode_includes(inode_size, i_projid))
 		inode.i_projid = fsx->fsx_projid;
 
-	ret = update_ctime(fs, fh->ino, &inode);
+	ret = fuse4fs_update_ctime(ff, fh->ino, &inode);
 	if (ret)
 		return ret;
 
@@ -5453,7 +5473,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
 		}
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -5626,7 +5646,7 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
 			return translate_error(fs, fh->ino, err);
 	}
 
-	err = update_mtime(fs, fh->ino, &inode);
+	err = fuse4fs_update_mtime(ff, fh->ino, &inode);
 	if (err)
 		return err;
 
@@ -7788,7 +7808,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse4fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;


