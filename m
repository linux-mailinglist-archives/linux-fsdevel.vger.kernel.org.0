Return-Path: <linux-fsdevel+bounces-55378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D77B0985B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2AE161A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B754241676;
	Thu, 17 Jul 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbVDSEny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818BFBF6;
	Thu, 17 Jul 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795783; cv=none; b=GViGpjZZ19SlVE4sstLAgLDV6ONPeQPAWitjxVBejNLQwILLhG9W3rA8YMYK3/x3iL8jFuRrDfR4A5c8MU5P9PqeOyzjKtJ6Bvv6A5P4Pt9ku3Fd2Fg71//oWRGPkKAn0ubU8aEGsXsjX6sRFX25qorb9cuM/1vSy8J9Mmggqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795783; c=relaxed/simple;
	bh=UDlDGcawb3Zl5tMZxPV1ng7cFPJNtiyAKetEV4z7UAw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOujZp5lCSAWKOysUZxhSIuLcNyRpEMfK7i7+yjcs9cLP70qGHR5gQIPNHySvHodkNLkAtxGrD1BTasIF71GRtFiLuvvIP3aI1sHWuOz/brswMp/T6rIca5trBKrnSZ6VfJzRTwVf44B/hAWJ+WnauDH0ULt+wWUr43yTl3VpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbVDSEny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E0C4CEF0;
	Thu, 17 Jul 2025 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795782;
	bh=UDlDGcawb3Zl5tMZxPV1ng7cFPJNtiyAKetEV4z7UAw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mbVDSEnyjvCzTBMM0LUUVaYFV5i7ME4sVwzk7H8wOF5xG9Abvmx/wReJdDAFW7yni
	 fXwKt3KcQZqowSsEpKDLNLVaAXfwiHbeYEIIc1U0FMyxqpqrJPFKqJii9Nk2h613ns
	 7Rz6BvTbb4v5tdSJ60FclSUt4yCo8u/BKsm/kVxJAfsNy+lpHxkZXITiChAZp0x4Sv
	 bhfphd7toZ5JkluMJ3GY7/aPxktptQcn2IHTRF6Th3xwVCDCxeEkE7tAI3Xu5j6QMF
	 9gMIjHhwM1BXFQoWOkscJLkCTkJ/fUvPOY7tl3IhFz757lOhAKrPrUIbZe6NbBGMgb
	 MeY95A3unpGTg==
Date: Thu, 17 Jul 2025 16:43:02 -0700
Subject: [PATCH 14/22] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461286.715479.6258457930261353040.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When iomap is in use for the page cache, the kernel will take care of
all the file data block IO for us, including zeroing of punched ranges
and post-EOF bytes.  fuse2fs only needs to do IO for inline data.

Therefore, set the NOBLOCKIO ext2_file flag so that libext2fs will not
do any regular file IO to or from disk blocks at all.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 45eec59d85faf4..989f9f17cae0a9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3059,9 +3059,14 @@ static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	if (fuse2fs_iomap_does_fileio(ff))
+		flags |= EXT2_FILE_NOBLOCKIO;
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -3181,6 +3186,9 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		file->open_flags |= EXT2_FILE_WRITE;
 		break;
 	}
+	/* the kernel handles all block IO for us in iomap mode */
+	if (fuse2fs_iomap_does_fileio(ff))
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
 	if (fp->flags & O_APPEND) {
 		/* the kernel doesn't allow truncation of an append-only file */
 		if (fp->flags & O_TRUNC) {


