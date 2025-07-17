Return-Path: <linux-fsdevel+bounces-55368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9AB09840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183C017CDA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB72451C8;
	Thu, 17 Jul 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoeBL0gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEB1FCFF8;
	Thu, 17 Jul 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795625; cv=none; b=oG5ZmHX5pBvbn7NwyfYDIJJdKsMJG5e+pCPOPPaD5HDWsyHGkvBmu9C/nGGShyDLN7zio1FNtap8sXnfJd5ekquOU8LrMxGV7xxj/rhKGI3sEbJRRco23S7aFF8fJOihFJXiah1iMAXW8kvYU4N3rJSC7Hsc3b6Ixw7eapx6Ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795625; c=relaxed/simple;
	bh=fgmvU3fyEplQ2fznRseQHVv0lUSgJe6mlPP7JBVFd6c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwkPGnF9suCJikrfMjLvkPEofhSDRY7lcdixrNq91aGLSS2DtIdU6y4+5SCXqfgXLdl7Q/l8LADYL3it3Hj1aVowQiWGvcgUGrQYOMfMiSIJAxkp896qusqvd7Mwdc28gJbgbw+VEgLAoCvla8zI6y4I2lhTvl55g4ZHEjJdLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoeBL0gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2900C4CEE3;
	Thu, 17 Jul 2025 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795625;
	bh=fgmvU3fyEplQ2fznRseQHVv0lUSgJe6mlPP7JBVFd6c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XoeBL0gy4WoyEFXWc9szH3qUPJI0htSrbfAbAudAVauEBsAl5zPVQMa8jFLeP9r+t
	 lZXSMQJ17hne5JdSaxNlrDCzUkVjOLAHv390kO19KqFAiOjYuQ/Olo+Ztj1TR3MT0L
	 fx4pY+LiifBn3ToTviJTNgRkOTYyKFj3Zu8UoZt8TDiwPDn6CXK1IKtmiDhpiQr9/W
	 I0vLFRIQvKwKJxQkcuwOUYKJzL/C4AQHux55L/YewRn8jiE9z6VFoCIOV20IK+3tPM
	 BPddeKuP7RTyJeF1nd1z8y0FFhBv+N9QdPdptWNm3Kor3jLJczc28AIpMHFuCiaJuf
	 AU3k8JuBVpP4w==
Date: Thu, 17 Jul 2025 16:40:24 -0700
Subject: [PATCH 04/22] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461105.715479.3013611859177576387.stgit@frogsfrogsfrogs>
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

Register the ext4 block device with the kernel for use with iomap.  For
now this is redundant with using fuseblk mode because the kernel
automatically registers any fuseblk devices, but eventually we'll go
back to regular fuse mode and we'll have to pin the bdev ourselves.
In theory this interface supports strange beasts where the metadata can
exist somewhere else entirely (or be made up by AI) while the file data
persists to real disks.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fb71886b58f215..9eb067e1737054 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -40,6 +40,7 @@
 # define _FILE_OFFSET_BITS 64
 #endif /* _FILE_OFFSET_BITS */
 #include <fuse.h>
+#include <fuse_lowlevel.h>
 #ifdef __SET_FOB_FOR_FUSE
 # undef _FILE_OFFSET_BITS
 #endif /* __SET_FOB_FOR_FUSE */
@@ -265,6 +266,7 @@ struct fuse2fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	int retcode;
@@ -5032,7 +5034,7 @@ static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -5064,13 +5066,14 @@ static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
 	if (err)
 		return translate_error(fs, ino, err);
 
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
 	iomap->offset = pos;
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
@@ -5275,12 +5278,38 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+static errcode_t fuse2fs_iomap_config_devices(struct fuse_context *ctxt,
+					      struct fuse2fs *ff)
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
+	ret = fuse_iomap_add_device(se, fd, 0);
+
+	dbg_printf(ff, "%s: registering iomap dev fd=%d ret=%d iomap_dev=%u\n",
+		   __func__, fd, ret, ff->iomap_dev);
+
+	if (ret < 1)
+		return -EIO;
+
+	ff->iomap_dev = ret;
+	return 0;
+}
+
 static int op_iomap_config(uint32_t flags, off_t maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
+	errcode_t err;
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5314,8 +5343,15 @@ static int op_iomap_config(uint32_t flags, off_t maxbytes,
 	cfg->flags |= FUSE_IOMAP_CONFIG_MAXBYTES;
 	cfg->s_maxbytes = fuse2fs_max_size(ff, maxbytes);
 
-	fuse2fs_finish(ff, 0);
-	return 0;
+	err = fuse2fs_iomap_config_devices(ctxt, ff);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out_unlock;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 #endif /* HAVE_FUSE_IOMAP */
 
@@ -5633,6 +5669,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


