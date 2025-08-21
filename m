Return-Path: <linux-fsdevel+bounces-58534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B7B2EA5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB313B98B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E91FE455;
	Thu, 21 Aug 2025 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHHsv9/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE91CAA92;
	Thu, 21 Aug 2025 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739005; cv=none; b=AqF8YOqUusNXJYf6AI3hxMWhciwWOQaKLItPsBPLHj0FyYYFUS+oQYjYlMfWM95RTVdq8mU8+fFzLNje3Pn+TfufQBCNQa5Z2ChfkpTqUjQi7wWztAoddnkpY6H3NV70Vh9LPRXJFFcnkKWtlwxqtWSH8nvS7PNTslBIr9HtkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739005; c=relaxed/simple;
	bh=fjFdJJ/G1CFWUgdzlekvmnAsvJYhLRTVXdKOcD+W/eg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIzy728Q6HLquPvMAsEYHAU1LXQg461W/XCYEzxTuzyLYGmqqGwjUGual2BwnB+shdF48grx1nL+UvxohXP0vbZMneqxIIiQ7iV7uBna6u2yw9givAu4C4eSOZeaMdRCEXfWydiB+i2KsBuzxhmF/qCaf0JxN5vC+Gdj1OvRHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHHsv9/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F482C4CEE7;
	Thu, 21 Aug 2025 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739005;
	bh=fjFdJJ/G1CFWUgdzlekvmnAsvJYhLRTVXdKOcD+W/eg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LHHsv9/jYfVgdFplPmPOdcPVt/bZ7fgEkXIjMzlAWkq0YO/yAEysFXeox0UlWyVVr
	 nMGGizjwLioggXrpw3nXp2Hk7InarblVi3//ROP+Ist4SzLwGJToaAcbk4nmOaDlQj
	 4OwvkH9DCUF+vxB30UcJadfTcFj7CY3X9sOLMjRhwuPfRdOnj1PVt2Dun3afRYaYKR
	 ZS0URxNrQtmzDt6fU0swcP6Uo7MftP2uIHleU0wrsZm15ohyM0H9MFbqSSORgkPuJA
	 7wZoDjECbkxC0tkdMjp0Vume/wTjZcmOwgukArTQbCRSRre2BWqxyHReY7hXHzrwjr
	 pdKBbS9lSk9Hw==
Date: Wed, 20 Aug 2025 18:16:44 -0700
Subject: [PATCH 04/19] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713801.21970.16168253173987085433.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   42 ++++++++++++++++++++++++++++++++++++++----
 misc/fuse4fs.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5b17aadc006560..8bf0fbcff093a7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -41,6 +41,7 @@
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
 #include <fuse.h>
+#include <fuse_lowlevel.h>
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -273,6 +274,7 @@ struct fuse2fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5235,7 +5237,7 @@ static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -5268,13 +5270,14 @@ static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, startoff);
 	iomap->flags |= FUSE_IOMAP_F_MERGED;
 	if (startblock) {
+		iomap->dev = ff->iomap_dev;
 		iomap->addr = FUSE2FS_FSB_TO_B(ff, startblock);
 		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
 	} else {
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
 		iomap->addr = FUSE_IOMAP_NULL_ADDR;
 		iomap->type = FUSE_IOMAP_TYPE_HOLE;
 	}
@@ -5487,11 +5490,36 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+static int fuse2fs_iomap_config_devices(struct fuse2fs *ff)
+{
+	errcode_t err;
+	int fd;
+	int ret;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	ret = fuse_fs_iomap_device_add(fd, 0);
+	if (ret < 0) {
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
+			   __func__, fd, -ret);
+		return translate_error(ff->fs, 0, -ret);
+	}
+
+	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
+		   __func__, fd, ff->iomap_dev);
+
+	ff->iomap_dev = ret;
+	return 0;
+}
+
 static int op_iomap_config(uint64_t flags, off_t maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5526,8 +5554,13 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 	cfg->flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
 	cfg->s_maxbytes = fuse2fs_max_size(ff, maxbytes);
 
-	fuse2fs_finish(ff, 0);
-	return 0;
+	ret = fuse2fs_iomap_config_devices(ff);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 #endif /* HAVE_FUSE_IOMAP */
 
@@ -5853,6 +5886,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 5876af19387c96..5debaf892b2113 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -269,6 +269,7 @@ struct fuse4fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5644,7 +5645,7 @@ static errcode_t fuse4fs_iomap_begin_extent(struct fuse4fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE4FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE4FS_FSB_TO_B(ff, extent.e_len);
@@ -5677,13 +5678,14 @@ static int fuse4fs_iomap_begin_indirect(struct fuse4fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, startoff);
 	iomap->flags |= FUSE_IOMAP_F_MERGED;
 	if (startblock) {
+		iomap->dev = ff->iomap_dev;
 		iomap->addr = FUSE4FS_FSB_TO_B(ff, startblock);
 		iomap->type = FUSE_IOMAP_TYPE_MAPPED;
 	} else {
+		iomap->dev = FUSE_IOMAP_DEV_NULL;
 		iomap->addr = FUSE_IOMAP_NULL_ADDR;
 		iomap->type = FUSE_IOMAP_TYPE_HOLE;
 	}
@@ -5897,11 +5899,36 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
 	return res;
 }
 
+static int fuse4fs_iomap_config_devices(struct fuse4fs *ff)
+{
+	errcode_t err;
+	int fd;
+	int ret;
+
+	err = io_channel_get_fd(ff->fs->io, &fd);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	ret = fuse_lowlevel_iomap_device_add(ff->fuse, fd, 0);
+	if (ret < 0) {
+		dbg_printf(ff, "%s: cannot register iomap dev fd=%d, err=%d\n",
+			   __func__, fd, -ret);
+		return translate_error(ff->fs, 0, -ret);
+	}
+
+	dbg_printf(ff, "%s: registered iomap dev fd=%d iomap_dev=%u\n",
+		   __func__, fd, ff->iomap_dev);
+
+	ff->iomap_dev = ret;
+	return 0;
+}
+
 static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
 	struct fuse4fs *ff = fuse4fs_get(req);
 	ext2_filsys fs;
+	int ret = 0;
 
 	FUSE4FS_CHECK_CONTEXT(req);
 
@@ -5936,8 +5963,16 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 	cfg.flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
 	cfg.s_maxbytes = fuse4fs_max_size(ff, maxbytes);
 
-	fuse4fs_finish(ff, 0);
-	fuse_reply_iomap_config(req, &cfg);
+	ret = fuse4fs_iomap_config_devices(ff);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	if (ret)
+		fuse_reply_err(req, -ret);
+	else
+		fuse_reply_iomap_config(req, &cfg);
 }
 #endif /* HAVE_FUSE_IOMAP */
 
@@ -6345,6 +6380,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


