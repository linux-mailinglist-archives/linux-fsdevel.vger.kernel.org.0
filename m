Return-Path: <linux-fsdevel+bounces-49637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF82AC0122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F741BC4501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394F20EB;
	Thu, 22 May 2025 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZe7CtCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C7645;
	Thu, 22 May 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872682; cv=none; b=mU2ld6/4Llwq1B//h1rMH3ZUzC9GpypCnkuGBJ5RZGN8F5AzxZjCRJku+pzOqTmm3omkOSIz0dftDhbvHjOXVMFfzK+CcNAQMEW/Th+kQdiMfwMnMx5tz/WxtvRiKXMRYfdcCZfvRyxTHGNpiDsH0znr21QF54NxgKxRH9IrMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872682; c=relaxed/simple;
	bh=Q9xfaabmNivQn0ShM+iA2MVuTaQl/v/MPjHePUA0XDE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqJ98kFrE8EcIUfvpcF4kb5QeRDZi9D6KjV5+EQOJvvSH2TaD8o0GwIj2nHD6XGHgcHzicB2/HamsJSrorPl8A/CuISCuwxmffPgMf9Q8/P14ysDazIkiwUn6fJ4PEPrc4GAg07j6yCTOmRqu4RPtBDPtS/uSMdkTL9n/ufBhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZe7CtCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A5DC4CEE4;
	Thu, 22 May 2025 00:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872682;
	bh=Q9xfaabmNivQn0ShM+iA2MVuTaQl/v/MPjHePUA0XDE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LZe7CtCf0tbmFYofc21LrcswtdeKLDD7LXWENEGeK5M4qkQkRbHR2CBNMiT4dKbYi
	 vhrOZghEnCiw2rXBmWC4a2pe7HJQL5dDI9exkI9HOFI0QiSWd3bXtql7Ntt5F483OU
	 DSUyt6bKv/z4nl5ZBRlqPA0g6n6IcSe/eu8qEZ6Ict55tVIj27ozt/fZ8jzaqnQP1U
	 2TX8zuW98q9A0ItmyJeoNGbWRvjBV+SjXx1ta6KEFV3jDH/ygZ8oAJkNewhyh4hk5h
	 UtN26J9UjNKVnp/Yr5W3DXuEtOLHsWKHOn9o+0JMRe7dWpEFDetjTGpzdd26zekXZ5
	 O2fgRsQifC8Mw==
Date: Wed, 21 May 2025 17:11:22 -0700
Subject: [PATCH 02/16] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198469.1484996.12724065306079911174.stgit@frogsfrogsfrogs>
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

Register the ext4 block device with the kernel for use with iomap.  For
now this is redundant with using fuseblk mode because the kernel
automatically registers any fuseblk devices, but eventually we'll go
back to regular fuse mode and we'll have to pin the bdev ourselves.
In theory this interface supports strange beasts where the metadata can
exist somewhere else entirely (or be made up by AI) while the file data
persists to real disks.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f9eed078d91152..92a80753f4f1e8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -36,6 +36,7 @@
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
 #include <fuse.h>
+#include <fuse_lowlevel.h>
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -179,6 +180,7 @@ struct fuse2fs {
 	int blocklog;
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse2fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	int retcode;
@@ -4638,7 +4640,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 static void handle_iomap_hole(struct fuse2fs *ff, struct fuse_iomap *iomap,
 			      off_t pos, uint64_t count)
 {
-	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE_IOMAP_NULL_ADDR;
 	iomap->offset = pos;
 	iomap->length = count;
@@ -4815,7 +4817,7 @@ static errcode_t extent_iomap_begin(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -4846,7 +4848,7 @@ static int indirect_iomap_begin(struct fuse2fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->dev = ff->iomap_dev;
 	iomap->offset = pos;
 	iomap->flags |= FUSE_IOMAP_F_MERGED;
 	if (startblock) {
@@ -4884,7 +4886,7 @@ static int indirect_iomap_begin(struct fuse2fs *ff, uint64_t ino,
 static int inline_iomap_begin(struct fuse2fs *ff, off_t pos, uint64_t count,
 			      struct fuse_iomap *iomap)
 {
-	iomap->dev = FUSE_IOMAP_DEV_FUSEBLK;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE_IOMAP_NULL_ADDR;
 	iomap->offset = pos;
 	iomap->length = count;
@@ -4925,6 +4927,31 @@ static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	return -ENOSYS;
 }
 
+static errcode_t config_iomap_devices(struct fuse_context *ctxt,
+				      struct fuse2fs *ff)
+{
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+	errcode_t err;
+	int fd;
+	int ret;
+
+	err = io_channel_fd(ff->fs->io, &fd);
+	if (err)
+		return err;
+
+	ret = fuse_lowlevel_notify_iomap_add_device(se, fd, &ff->iomap_dev);
+
+	dbg_printf(ff, "%s: registering iomap dev fd=%d ret=%d iomap_dev=%u\n",
+		   __func__, fd, ret, ff->iomap_dev);
+
+	if (ret)
+		return ret;
+	if (ff->iomap_dev == FUSE_IOMAP_DEV_NULL)
+		return -EIO;
+
+	return 0;
+}
+
 static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			  off_t pos, uint64_t count, uint32_t opflags,
 			  struct fuse_iomap *read_iomap,
@@ -4951,6 +4978,14 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   (unsigned long long)count,
 		   opflags);
 
+	if (ff->iomap_dev == FUSE_IOMAP_DEV_NULL) {
+		err = config_iomap_devices(ctxt, ff);
+		if (err) {
+			ret = translate_error(fs, attr_ino, err);
+			goto out_unlock;
+		}
+	}
+
 	err = fuse2fs_read_inode(fs, attr_ino, &inode);
 	if (err) {
 		ret = translate_error(fs, attr_ino, err);
@@ -5285,6 +5320,7 @@ int main(int argc, char *argv[])
 		.magic = FUSE2FS_MAGIC,
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


