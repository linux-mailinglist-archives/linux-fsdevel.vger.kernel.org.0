Return-Path: <linux-fsdevel+bounces-49651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CDFAC014D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB19E602E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448D134CF;
	Thu, 22 May 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Yt546W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54679D0;
	Thu, 22 May 2025 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872902; cv=none; b=biYiSbEY2SMH2ZEtjwMPW3+BLbaVxSCl4H48umzTSlx8egYmXaQS7W9TKdQDZ58QBMoYXnohmI1DxR1iQ6KIAzB4mNsP31QYTuo9coxoONOJkrisCuOyOGdEuzOJy8Q9cxAb6YpBdyoVf7eAjB1Yaj2W9LCkI8DPDA56ayEbpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872902; c=relaxed/simple;
	bh=UCd8z743pU+4RFzhNZIpkGUQglsN1Jn9IyShAEKzGlU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpvwTriUGbMcgIBScIZtnlBGI3a23rlJVN9hgL4uDkbiI7VVcXuPGoF7VTMQaHDCgulFSwuSE9GV3I1iFVrMDv594CXPbk+PzBvHGhZKL1K4WT+ExBX+nl0ywfPQpm4bT91P1RybcOxF67Abh/jmuYznVGFwG2g8FUytBQyMH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Yt546W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EBEC4CEE4;
	Thu, 22 May 2025 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872901;
	bh=UCd8z743pU+4RFzhNZIpkGUQglsN1Jn9IyShAEKzGlU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e0Yt546WwwB/1IHkFwxyad3DQi7u7fxYx3rXgw0YxmSNqiWbvPcKKbrctrRSKEzPe
	 12bps+z+kpu4N53rIcUetKNTxB+LS8UrxqRoEmLqMdEVBwYnHushoSHXlSDBFKbO6S
	 zpYsYzTnTDIjYHl3lMpDBBf4rTRRWHBOFIs70WQLgTMzw8doEiTVyqjTfBauwVKUDB
	 qm0Un2J6e00ZuOdjG6MMt6FaFnGWyKc+Tm3Z0RgTxBalLfd6v6KRC0mhxacX5AJytT
	 kFBO1gX6OVKdT6UtogWTfyj5mvWz2H9CrDBmCPSjIc69wi8cmTU+1Ei8G35ltUbbCr
	 X6MXEx2bjr5ug==
Date: Wed, 21 May 2025 17:15:01 -0700
Subject: [PATCH 16/16] fuse2fs: avoid fuseblk mode if fuse-iomap support is
 likely
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198722.1484996.6270446674052578513.stgit@frogsfrogsfrogs>
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

Since fuse in iomap mode guarantees that op_destroy will be called
before umount returns, we don't need to use fuseblk mode to get that
guarantee.  Disable fuseblk mode, which saves us the trouble of closing
and reopening the device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f31aee5af5aad9..28385d654f5e05 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -787,6 +787,8 @@ static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
+	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
 	if (err) {
@@ -6153,6 +6155,18 @@ int main(int argc, char *argv[])
 		ret = 32;
 		goto out;
 	}
+#ifdef HAVE_FUSE_IOMAP
+	if (is_bdev && fuse_discover_iomap()) {
+		/*
+		 * fuse-iomap guarantees that op_destroy is called before the
+		 * filesystem is unmounted, so we don't need fuseblk mode.
+		 * This save us the trouble of reopening the filesystem later,
+		 * and means that fuse2fs itself owns the exclusive lock on the
+		 * block device.
+		 */
+		is_bdev = 0;
+	}
+#endif
 
 	blksize = fctx.fs->blocksize;
 
@@ -6171,14 +6185,14 @@ int main(int argc, char *argv[])
 
 	/* Set up default fuse parameters */
 	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "attr_timeout=0" FUSE_PLATFORM_OPTS,
-		 get_subtype(argv[0]));
+		 "attr_timeout=0,fsname=%s" FUSE_PLATFORM_OPTS,
+		 get_subtype(argv[0]), fctx.device);
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
 
 	if (is_bdev) {
-		snprintf(extra_args, BUFSIZ, "-ofsname=%s,blkdev,blksize=%u",
-			 fctx.device, blksize);
+		snprintf(extra_args, BUFSIZ, "-oblkdev,blksize=%u",
+			 blksize);
 		fuse_opt_add_arg(&args, extra_args);
 	}
 


