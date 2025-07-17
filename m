Return-Path: <linux-fsdevel+bounces-55393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88CB09892
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C3017044E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2A24110F;
	Thu, 17 Jul 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuL9JnJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E661EBA07;
	Thu, 17 Jul 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796019; cv=none; b=VaT/M4EVdlwruTSDXGQkig7jcEclg89Ld96gxHWBe8B/O0hKrKygXy9WhdruhgyJhobwofj+zIPZm7ObPB9EtF413MqHV4m4JgyT48EnJWsel/sRH5qA3qLAgCIQiVcUD3lp4iaLNgHdiRfIoXjX+xTdp2r21KW2qkSdJf8HleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796019; c=relaxed/simple;
	bh=4Vlec3eqA7LAxtFjuVLzNL76odycl5rFPghU7ZpK7vc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ozdr3e/4bDWKnaK5FUnUJhmkFgH/L81leEfeJVduC++9cgOtnT0F8WZ1YFUBB3FtLF3qZhb5UXmbdwEjQD/5XfoHfFU6vyVvJU1bksaQLoc7Pzl3u9kndJHZzeyvo4BLLFQ7jF/+pbN0kTBLHLu4GXXuWYfvi2Xf7a6oBIA2/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuL9JnJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E9CC4CEE3;
	Thu, 17 Jul 2025 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796017;
	bh=4Vlec3eqA7LAxtFjuVLzNL76odycl5rFPghU7ZpK7vc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GuL9JnJqLb1GCY6Fmbhd3JeckY+ngQVN216Gq3VfRNTUSLWVUu3HrlLco2/0WOIwQ
	 cG7JltGW/HBe26oIn3vGbhkmh/dsql4MMdWzViP9J9avweMUsow4JB6LjI5ACpy6A8
	 zCQHdfVt8VNcDez690n+FeW4Cbf/WIGv/4cX9rRgXkI1Cb0BaP56QVg46gyrQXgiLk
	 Vqb4XiFtNE75e03p6oT24CbZDv7EYnzQ2gVjbwt86PToXTTDQ+PEUCZP3Uiu/Gq75y
	 znf5GQsz8VPJto0AZMYi77IxLKNj/jOs07hAmQ2gHBUPCm0CsVvIP8RhMFRpn+ir9U
	 gNRoFtsdQB4MA==
Date: Thu, 17 Jul 2025 16:46:57 -0700
Subject: [PATCH 06/10] fuse2fs: use coarse timestamps for iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461828.716436.6399243218938406982.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ddc647f32c5df6..54f501b36d808b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -575,8 +575,24 @@ static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
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
+	if (fuse2fs_iomap_does_fileio(ff) &&
+	    !clock_gettime(CLOCK_REALTIME_COARSE, now))
+		return;
+#endif
 #ifdef CLOCK_REALTIME
 	if (!clock_gettime(CLOCK_REALTIME, now))
 		return;
@@ -604,7 +620,7 @@ static void fuse2fs_init_timestamps(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	struct timespec now;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_atime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, inode);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, inode);
@@ -623,7 +639,7 @@ static int fuse2fs_update_ctime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 	struct ext2_inode_large inode;
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	/* If user already has a inode buffer, just update that */
 	if (pinode) {
@@ -669,7 +685,7 @@ static int fuse2fs_update_atime(struct fuse2fs *ff, ext2_ino_t ino)
 	pinode = &inode;
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 
 	datime = atime.tv_sec + ((double)atime.tv_nsec / NSEC_PER_SEC);
 	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / NSEC_PER_SEC);
@@ -704,7 +720,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	struct timespec now;
 
 	if (pinode) {
-		get_now(&now);
+		fuse2fs_get_now(ff, &now);
 		EXT4_INODE_SET_XTIME(i_mtime, &now, pinode);
 		EXT4_INODE_SET_XTIME(i_ctime, &now, pinode);
 		increment_version(pinode);
@@ -719,7 +735,7 @@ static int fuse2fs_update_mtime(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	EXT4_INODE_SET_XTIME(i_mtime, &now, &inode);
 	EXT4_INODE_SET_XTIME(i_ctime, &now, &inode);
 	increment_version(&inode);
@@ -4380,9 +4396,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
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
@@ -6917,7 +6933,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			error_message(err), func, line);
 
 	/* Make a note in the error log */
-	get_now(&now);
+	fuse2fs_get_now(ff, &now);
 	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;


