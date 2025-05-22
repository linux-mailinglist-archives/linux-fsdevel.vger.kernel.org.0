Return-Path: <linux-fsdevel+bounces-49648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DFAC0138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C66717522E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A070920EB;
	Thu, 22 May 2025 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUdDh1fA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08571383;
	Thu, 22 May 2025 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872855; cv=none; b=JGTCbNmhD+GxFxNXqCseZWokq1DvkGw2crpabudwooIKoEm9gIcfykFgaW4PDkDKaOXfMs0n6OAF6aNVK/fq1g9QxSs4S7RI5jrLBMLQw9UHRzfN4ZsbKgqVmA3l5LzgOxY3arzLWAGywGpuiwY0rJYEYOeF4q6ObiRhLw3nvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872855; c=relaxed/simple;
	bh=cVF+dqIPU24/O/Yr2b8q60wS21pO/+Zw/4kBxCDJwSU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM4tbwyBJml7feFo+S03jKAZGDs6Z7dU8ehYMidEVOBKXl3ohjmQlIsQWGSK0qEdcwuzpE8EP40vhyv/aS9Q0S+FKF9aJzOnFO6WH3feRYWL/UHUK0CqoupzvaN3u9U7VqxIEt4e3rxwya663oeOKOihnAvwV1z/IU2K8ba0ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUdDh1fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05A5C4CEE4;
	Thu, 22 May 2025 00:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872854;
	bh=cVF+dqIPU24/O/Yr2b8q60wS21pO/+Zw/4kBxCDJwSU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mUdDh1fA7nlCWvA5GYBAgjHFnywEqVC78Pmz6k/jtJMIMlNYFGY5HCgeg5uzzpVbJ
	 6Sg74fBuTurdi5o/6VH13FSivDjT1ZRwxOCmohfCu808wBcCSx9BoP4YujWHRKp9b8
	 0GZ/4TnFeWOt1EkPvwOEKzMOJ1AyTkuGwXPaX+ZXiwurii8+y/B6Ur1P8Sy+eG7y6d
	 L+Aq5itx8VWUwZojn6U+qOGxjTgk9W0KiNpNnWfNVX2wyTJApurwfpqWiuQiz2kEkp
	 5ygnd0Mhkb3cR3XR7PR1MRKHLplhG9L/fN0kJpCSwdrTGCvF3/+32LxFRPDdK4n1zv
	 ZvYq+bwZg0lcQ==
Date: Wed, 21 May 2025 17:14:14 -0700
Subject: [PATCH 13/16] fuse2fs: don't do file data block IO when iomap is
 enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198668.1484996.15426837869307835566.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
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
index aeb2b6fbc28401..842ea3a191fa44 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2863,9 +2863,14 @@ static int truncate_helper(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	ext2_file_t file;
 	__u64 old_isize;
 	errcode_t err;
+	int flags = EXT2_FILE_WRITE;
 	int ret = 0;
 
-	err = ext2fs_file_open(fs, ino, EXT2_FILE_WRITE, &file);
+	/* the kernel handles all eof zeroing for us in iomap mode */
+	if (iomap_does_fileio(ff))
+		flags |= EXT2_FILE_NOBLOCKIO;
+
+	err = ext2fs_file_open(fs, ino, flags, &file);
 	if (err)
 		return translate_error(fs, ino, err);
 
@@ -2987,6 +2992,9 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		file->open_flags |= EXT2_FILE_WRITE;
 		break;
 	}
+	/* the kernel handles all block IO for us in iomap mode */
+	if (iomap_does_fileio(ff))
+		file->open_flags |= EXT2_FILE_NOBLOCKIO;
 	if (fp->flags & O_APPEND) {
 		/* the kernel doesn't allow truncation of an append-only file */
 		if (fp->flags & O_TRUNC) {


