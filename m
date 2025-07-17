Return-Path: <linux-fsdevel+bounces-55379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D4B0985D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93A81735AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D9241676;
	Thu, 17 Jul 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA9HmQ1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423CFBF6;
	Thu, 17 Jul 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795800; cv=none; b=rIZOwjBR92TJ/+NVZQ8nwAMSBDU4yV5urQlleJ4kIfoBld2Nb1WxUoY1yPxErgLtI7DYM7tWY8NOF+s2hI35mbg2Qs6zTn4Xb+R65i83F/QnNGOYd2hQXZl+5SuyuUD5E3R1GNMULHJCLbPz5wzzXAAi/J0qf+O3SwBAA/5fJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795800; c=relaxed/simple;
	bh=JPDSE4Twtaml7MWFJInhOk+0BUjIHDmNlYoE+86Je2U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXFGGQabCO6n07QngXXIF6fVnL6wDZuFY2kAr3Rv+4TvORaYUgTLZYSe9ySn0KVG0n0s9GecErRnranimMj+ZJZApTeUCiRBTYXWF4DjQ+MPpnRUt8ICwITPwtByUv4gOkQSv9+QqcF5hel9OW+OeCAemJVvVWErE6QCUGKP7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA9HmQ1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24690C4CEE3;
	Thu, 17 Jul 2025 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795798;
	bh=JPDSE4Twtaml7MWFJInhOk+0BUjIHDmNlYoE+86Je2U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fA9HmQ1JR51mbNKyZYwo4qK6HbiZMGXovghrRZHJ6Rfxu/xjdWRRNAlGq3Qpmja1G
	 63kjLFaWf7hqhPLEgtbvpyZ3gE+5C3LY8c2DBULSktiyTXD1PyXPEN/0k8+HuBtOIr
	 buRIEaOFIw5jIoSdf1E/hmhC04OpWh/ibKCBDmszztyPogbIhul1RCPpQxAm8x5TQw
	 xw94AIdroJZ5dGhPEnieeGZz0eQewOQMJkx6bNlNArAkfHNeHy7ZjMVO0CWIEqLxu0
	 i0z8pmbuHvzt/rSuCA9NG+zvPghHM0m4XI5LSKCagpk9pS45qwAinpRBKBFSu8IkQs
	 afI7Lsm5rp8cg==
Date: Thu, 17 Jul 2025 16:43:17 -0700
Subject: [PATCH 15/22] fuse2fs: disable most io channel flush/invalidate in
 iomap pagecache mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461304.715479.1053791364664462528.stgit@frogsfrogsfrogs>
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

Now that fuse2fs uses iomap for pagecache IO, all regular file IO goes
directly to the disk.  There is no need to flush the unix IO manager's
disk cache (or invalidate it) because it does not contain file data.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 989f9f17cae0a9..9604f06e69bc90 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5295,9 +5295,11 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 		return -ENOSYS;
 
 	/* flush dirty io_channel buffers to disk before iomap reads them */
-	err = io_channel_flush_tag(ff->fs->io, ino);
-	if (err)
-		return translate_error(ff->fs, ino, err);
+	if (!fuse2fs_iomap_does_fileio(ff)) {
+		err = io_channel_flush_tag(ff->fs->io, ino);
+		if (err)
+			return translate_error(ff->fs, ino, err);
+	}
 
 	if (inode->i_flags & EXT4_EXTENTS_FL)
 		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
@@ -5393,9 +5395,11 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	 * flush and invalidate the file's io_channel buffers before iomap
 	 * writes them
 	 */
-	err = io_channel_invalidate_tag(ff->fs->io, ino);
-	if (err)
-		return translate_error(ff->fs, ino, err);
+	if (!fuse2fs_iomap_does_fileio(ff)) {
+		err = io_channel_invalidate_tag(ff->fs->io, ino);
+		if (err)
+			return translate_error(ff->fs, ino, err);
+	}
 
 	return 0;
 }
@@ -5972,7 +5976,7 @@ static int op_iomap_ioend(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	 * flush and invalidate the file's io_channel buffers again now that
 	 * iomap wrote them
 	 */
-	if (written > 0) {
+	if (written > 0 && !fuse2fs_iomap_does_fileio(ff)) {
 		err = io_channel_invalidate_tag(ff->fs->io, attr_ino);
 		if (err) {
 			ret = translate_error(ff->fs, attr_ino, err);


