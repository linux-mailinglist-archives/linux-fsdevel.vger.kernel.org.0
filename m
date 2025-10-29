Return-Path: <linux-fsdevel+bounces-66132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BEBC17D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5055D3B6EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD728467C;
	Wed, 29 Oct 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx7nq5uQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEE2741DA;
	Wed, 29 Oct 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700733; cv=none; b=kHV4P83upXJzEPiBdFFVHwnYELJZ4XeJHwgqrrsSh7iPDMMt2xVG3QiiW+EBBPnCq6ZjoaA3nBjQ3lvrCJ6Cn3FJ2I7g1Otl9M8LyW594+fmogk1s+XVO2j6JnRDHw7rk2AWAnMfEXpFuaeKnPhmCWwIXCProGV/+6NWV37Q3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700733; c=relaxed/simple;
	bh=iKwdM78UESvRs4jkIc0G1Sl3rAUVRHF+YbD4p3gK06s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fa1ACowuT11M/CCD3uBqeKmJnMLwRao2djPtBPy+TDLG3wrV4HOcOkBzBZbJgf1ZiMXfTR5K0vUqNFLOqKzCT04ERRIek4Qp1U53Bku/QRIEmyjqNqoaYzkJTGbHb5vU2r0jzUwJuNwMAupp7VpUlfGxzeJHKLmoVxG7ZbptMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx7nq5uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF45EC4CEE7;
	Wed, 29 Oct 2025 01:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700732;
	bh=iKwdM78UESvRs4jkIc0G1Sl3rAUVRHF+YbD4p3gK06s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Kx7nq5uQ6S+blu/1J5V7F9krUnUxU3LeVsKOMqgGDwk9pth8HmUYUk/Gjxy9UWjWQ
	 vHyFg84R7+gdfgN4D6FIKfyIqLYxMCWnsp7HMiyDvd9LIrpU3isVZ8MdFUpfcvlDWz
	 CkXXk7m0za4riKZ1yXf5TBykIVXZh+bC4z6vQgCfabYsVQkINosl0ELoaccs6p+Bvm
	 fhtrKTMwSk7rmmjQo0pB3/10BEEqz771K+2zOPa8vJBwNw48Gls9jB9wBCujGCl3pH
	 qyKyXjT+3lAWn5n+oMO14F3PRCG2nYVBzcyFt5H/ug0a3f9kl4Ax+zBhqV580oSGmE
	 mUbZZjnnzxIxQ==
Date: Tue, 28 Oct 2025 18:18:52 -0700
Subject: [PATCH 1/7] libext2fs: fix MMP code to work with unixfd IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819048.1431292.632116172556190002.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
References: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The MMP code wants to be able to read and write the MMP block directly
to storage so that the pagecache does not get in the way.  This is
critical for correct operation of MMP, because it is guarding against
two cluster nodes trying to change the filesystem at the same time.

Unfortunately there's no convenient way to tell an IO manager to perform
a particular IO in directio mode, so the MMP code open()s the filesystem
source device a second time so that it can set O_DIRECT and maintain its
own file position independently of the IO channel.  This is a gross
layering violation.

For unprivileged containerized fuse4fs, we're going to have a privileged
mount helper pass us the fd to the block device, so we'll be using the
unixfd IO manager.  Unfortunately, if the unixfd IO manager is in use,
the filesystem "source" will be a string representation of the fd
number, and MMP breaks.

Fix this (sort of) by detecting the unixfd IO manager and duplicating
the open fd if it's in use.  This adds a requirement that the unixfd
originally be opened in O_DIRECT mode if the filesystem is on a block
device, but that's the best we can do here.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h |    1 +
 lib/ext2fs/mmp.c    |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 38d6074fdbbc87..23b0695a32d150 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -229,6 +229,7 @@ typedef struct ext2_file *ext2_file_t;
  * Internal flags for use by the ext2fs library only
  */
 #define EXT2_FLAG2_USE_FAKE_TIME	0x000000001
+#define EXT2_FLAG2_MMP_USE_IOCHANNEL	0x000000002
 
 /*
  * Special flag in the ext2 inode i_flag field that means that this is
diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index e2823732e2b6a2..5e7c0be5a48aeb 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
@@ -48,6 +49,74 @@ errcode_t ext2fs_mmp_get_mem(ext2_filsys fs, void **ptr)
 	return ext2fs_get_memalign(fs->blocksize, align, ptr);
 }
 
+static int possibly_unixfd(ext2_filsys fs)
+{
+	char *endptr = NULL;
+
+	if (fs->io->manager == unixfd_io_manager)
+		return 1;
+
+	/*
+	 * Due to the possibility of stacking IO managers, it's possible that
+	 * there's a unixfd IO manager under all of this.  We can guess the
+	 * presence of one if the device_name is a string representation of an
+	 * integer (fd) number.
+	 */
+	errno = 0;
+	strtol(fs->device_name, &endptr, 10);
+	return !errno && endptr == fs->device_name + strlen(fs->device_name);
+}
+
+static int ext2fs_mmp_open_device(ext2_filsys fs, int flags)
+{
+	struct stat st;
+	int maybe_fd = -1;
+	int new_fd;
+	int want_directio = 1;
+	int ret;
+	errcode_t retval = 0;
+
+	/*
+	 * If the unixfd IO manager is in use, extract the fd number from the
+	 * unixfd IO manager so we can reuse it below.
+	 *
+	 * If that fails, fall back to opening the filesystem device, which is
+	 * the preferred method.
+	 */
+	if (possibly_unixfd(fs))
+		retval = io_channel_get_fd(fs->io, &maybe_fd);
+	if (retval || maybe_fd < 0)
+		return open(fs->device_name, flags);
+
+	/*
+	 * We extracted the fd from the unixfd IO manager.  Skip directio if
+	 * this is a regular file, just ext2fs_mmp_read does.
+	 */
+	ret = fstat(maybe_fd, &st);
+	if (ret == 0 && S_ISREG(st.st_mode))
+		want_directio = 0;
+
+	/* Duplicate the fd so that the MMP code can close it later */
+	new_fd = dup(maybe_fd);
+	if (new_fd < 0)
+		return -1;
+
+	/* Make sure we actually got directio if that's required */
+	if (want_directio) {
+		ret = fcntl(new_fd, F_GETFL);
+		if (ret < 0 || !(ret & O_DIRECT))
+			return -1;
+	}
+
+	/*
+	 * The MMP fd is a duplicate of the io channel fd, so we must use that
+	 * for all MMP block accesses because the two fds share the same file
+	 * position and O_DIRECT state.
+	 */
+	fs->flags2 |= EXT2_FLAG2_MMP_USE_IOCHANNEL;
+	return new_fd;
+}
+
 errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 {
 #ifdef CONFIG_MMP
@@ -77,7 +146,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 		    S_ISREG(st.st_mode))
 			flags &= ~O_DIRECT;
 
-		fs->mmp_fd = open(fs->device_name, flags);
+		fs->mmp_fd = ext2fs_mmp_open_device(fs, flags);
 		if (fs->mmp_fd < 0) {
 			retval = EXT2_ET_MMP_OPEN_DIRECT;
 			goto out;
@@ -90,6 +159,15 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 			return retval;
 	}
 
+	if (fs->flags2 & EXT2_FLAG2_MMP_USE_IOCHANNEL) {
+		retval = io_channel_read_blk64(fs->io, mmp_blk, -fs->blocksize,
+					       fs->mmp_cmp);
+		if (retval)
+			return retval;
+
+		goto read_compare;
+	}
+
 	if ((blk64_t) ext2fs_llseek(fs->mmp_fd, mmp_blk * fs->blocksize,
 				    SEEK_SET) !=
 	    mmp_blk * fs->blocksize) {
@@ -102,6 +180,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 		goto out;
 	}
 
+read_compare:
 	mmp_cmp = fs->mmp_cmp;
 
 	if (!(fs->flags & EXT2_FLAG_IGNORE_CSUM_ERRORS) &&
@@ -428,6 +507,7 @@ errcode_t ext2fs_mmp_stop(ext2_filsys fs)
 
 mmp_error:
 	if (fs->mmp_fd > 0) {
+		fs->flags2 &= ~EXT2_FLAG2_MMP_USE_IOCHANNEL;
 		close(fs->mmp_fd);
 		fs->mmp_fd = -1;
 	}


