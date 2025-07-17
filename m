Return-Path: <linux-fsdevel+bounces-55371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76127B0984C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41C65802AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08715242D7F;
	Thu, 17 Jul 2025 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLpda7+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C8FBF6;
	Thu, 17 Jul 2025 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795672; cv=none; b=cnKRqCgdOwE1ar4Yk+GuZefZBAyeXMiUMzBZfreXC84ICPvVoi/P+3G1CuBBDC1A7jFJJ4mDQ5GkbawBkgIygs4WgCYKfv4fz7FhEWUc3Lj5HR++fgw6wXSye9cnQ5Yxl1TOYwNdEBdqEycc7lDpvuQFJviPnco36EOLX5iZdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795672; c=relaxed/simple;
	bh=gpwqj29tQ3/KzHW12jDfHZu6Pz59nuxYKv9oCToKUmE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dW1yQrh8J1GHx9TQ7UeS8vWVR4MS7I5k9Q5fvZ6RBxkqv8EIzTJ8a99qvjTlAt2e3DMGURJIcvTgX7G7jFGmY3tl6/bNWCcMRdvv0N4gq/aGGtFD5Mz11Kv4gewduhH1eaX4SYr6F+RvxS5+jDfQiMYiNiE92VFN/Tf2QdDxLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLpda7+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0F2C4CEE3;
	Thu, 17 Jul 2025 23:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795671;
	bh=gpwqj29tQ3/KzHW12jDfHZu6Pz59nuxYKv9oCToKUmE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RLpda7+vMtQchkjbPi3Ej5ycDB42DKRHTgetChKyg4RuDMAw3GwORJDxhIE+GvA1K
	 tWDgc/WG2uB6zcgybYtOA02PV+1SjzOoav+ycvenI1Y9If+EymcIBl11fdPnV0KkV6
	 lBDJsIKvx8aiKhIYdxnGEZ7/FHpIQZWM/wtc6IpAlRTBTLn5rqI0xhP0H32aU/KGe0
	 fCybziqGBmy2cKDMPYp6p7A6N9lUUF1UR39PxH5YnSu0esafCw3BPuTHaw/5RwlfP9
	 JvGxuC8VSB8HFNy+gcDiOKWUv7Kz7XjfuZgDenn3rKgdpReA5g0MNnpZIcNdjAYP5J
	 GQXxoUxH2xdWA==
Date: Thu, 17 Jul 2025 16:41:11 -0700
Subject: [PATCH 07/22] fuse2fs: use tagged block IO for zeroing sub-block
 regions
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461160.715479.13568163826938358865.stgit@frogsfrogsfrogs>
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

Change the punch hole helpers to use the tagged block IO commands now
that libext2fs uses tagged block IO commands for file IO.  We'll need
this in the next patch when we turn on selective IO manager cache
clearing and invalidation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 209858aeb9307c..64aca0f962daaf 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4675,13 +4675,13 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_tagblk(fs->io, ino, blk, 1, *buf);
 	if (err)
 		return err;
 
 	memset(*buf + residue, 0, len);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
 
 static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
@@ -4709,7 +4709,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_tagblk(fs->io, ino, blk, 1, *buf);
 	if (err)
 		return err;
 	if (!blk || (retflags & BMAP_RET_UNINIT))
@@ -4720,7 +4720,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	else
 		memset(*buf + residue, 0, fs->blocksize - residue);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
 
 static int fuse2fs_punch_range(struct fuse2fs *ff,


