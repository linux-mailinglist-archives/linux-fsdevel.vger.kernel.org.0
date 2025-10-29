Return-Path: <linux-fsdevel+bounces-66137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE8C17D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609C0425EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26792D94A3;
	Wed, 29 Oct 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avgDw7os"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08361268C40;
	Wed, 29 Oct 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700811; cv=none; b=CXNirwSjLaz0bYyXBBlmQrJNQFbIt/n8P9BJ2D39qxt+OFnFcz6LqO0Ep/5matvjG2n0PUbpkdiS2w0E3nrCTabhSBhgHJRfbi03d7Pvy/F+ZJS4+6ZhmCXs51Q/4Wkr913/o8xkXjIoXEpXSlGyFYCBa22c7OwgJHjbC+2VQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700811; c=relaxed/simple;
	bh=Ya5qsFpkVLiBC/e8Qmh0f+1AY7qhSuiX7Twkm4nSZ6o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfrTnbBEyCCrRLmENTEjgFvtSqcJaJ/eb0ZFC2WOm4Dof5lgvDT4T6mNhTl4b3fL6PS5LnQT3ddkKDSnFVSz1UMleMcBYIUlTOOVo8HCmWzXUEIz2inzFvnGt66pQzH689l4zTmy2E8U/LjEhfwPORclZuihEl3nKngHGtxq/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avgDw7os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04D0C4CEE7;
	Wed, 29 Oct 2025 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700810;
	bh=Ya5qsFpkVLiBC/e8Qmh0f+1AY7qhSuiX7Twkm4nSZ6o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=avgDw7os7ck8l8C4smo/oe9ipnx9Uu6b06QV+Djgm0XBEF3X89YZ9fSyDefmqmWb3
	 elmTXyv3Ypn9tfT63C3hTIWZ39UqQU/lPz9cGb6dB2p/y3JyyrC90X/D+BcvygrMZ5
	 FxZHRT6Jw/05gQXZysd3spHPqnD/hkQD4U6xdLRQQXmqgLiRlCRkDVZRcGr9MNpQMJ
	 SG7GTW3VOu6sYMU65hvIDsdUJnS/cFpKmYY2ZhlpIw11xPjigYQz67uYT4JoIozGQm
	 cpF6gyg36x/jOL/O8y7l8/xW+wILogwqSw2YrKF18/ddOcF61lL4nCs3908ZR+cq1P
	 wRBcp3FSjvm+Q==
Date: Tue, 28 Oct 2025 18:20:10 -0700
Subject: [PATCH 6/7] fuse4fs: make MMP work correctly in safe service mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819142.1431292.10699965435104310373.stgit@frogsfrogsfrogs>
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

Normally, the libext2fs MMP code open()s a complete separate file
descriptor to read and write the MMP block so that it can have its own
private open file with its own access mode and file position.  However,
if the unixfd IO manager is in use, it will reuse the io channel, which
means that MMP and the unixfd share the same open file and hence the
access mode and file position.

MMP requires directio access to block devices so that changes are
immediately visible on other nodes.  Therefore, we need the IO channel
(and thus the filesystem) to be running in directio mode if MMP is in
use.

To make this work correctly with the sole unixfd IO manager user
(fuse4fs in unprivileged service mode), we must set O_DIRECT on the
bdev fd and mount the filesystem in directio mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 7edebf6776208a..6ce3dbbec78a8f 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1559,13 +1559,57 @@ static int fuse4fs_service_get_config(struct fuse4fs *ff)
 }
 
 static errcode_t fuse4fs_service_openfs(struct fuse4fs *ff, char *options,
-					int flags)
+					int *flags)
 {
+	struct stat statbuf;
 	char path[32];
+	errcode_t retval;
+	int ret;
+
+	ret = fstat(ff->bdev_fd, &statbuf);
+	if (ret)
+		return errno;
 
 	snprintf(path, sizeof(path), "%d", ff->bdev_fd);
 	iocache_set_backing_manager(unixfd_io_manager);
-	return ext2fs_open2(path, options, flags, 0, 0, iocache_io_manager,
+
+	/*
+	 * Open the filesystem with SKIP_MMP so that we can find out if the
+	 * filesystem actually has MMP.
+	 */
+	retval = ext2fs_open2(path, options, *flags | EXT2_FLAG_SKIP_MMP, 0, 0,
+			      iocache_io_manager, &ff->fs);
+	if (retval)
+		return retval;
+
+	/*
+	 * If the fs doesn't have MMP then we're good to go.  Otherwise close
+	 * the filesystem so that we can reopen it with MMP enabled.
+	 */
+	if (!ext2fs_has_feature_mmp(ff->fs->super))
+		return 0;
+
+	retval = ext2fs_close_free(&ff->fs);
+	if (retval)
+		return retval;
+
+	/*
+	 * If the filesystem is not on a regular file, MMP will share the same
+	 * fd as the unixfd IO channel.  We need to set O_DIRECT on the bdev_fd
+	 * and open the filesystem in directio mode.
+	 */
+	if (!S_ISREG(statbuf.st_mode)) {
+		int fflags = fcntl(ff->bdev_fd, F_GETFL);
+
+		ret = fcntl(ff->bdev_fd, F_SETFL, fflags | O_DIRECT);
+		if (ret)
+			return EXT2_ET_MMP_OPEN_DIRECT;
+
+		ff->directio = 1;
+		*flags |= EXT2_FLAG_DIRECT_IO;
+	}
+
+	return ext2fs_open2(path, options, *flags, 0, 0, iocache_io_manager,
 			&ff->fs);
 }
 
@@ -1846,7 +1890,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
 	do {
 		if (fuse4fs_is_service(ff))
-			err = fuse4fs_service_openfs(ff, options, flags);
+			err = fuse4fs_service_openfs(ff, options, &flags);
 		else
 			err = ext2fs_open2(fuse4fs_device(ff), options, flags,
 					   0, 0, iocache_io_manager, &ff->fs);


