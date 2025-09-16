Return-Path: <linux-fsdevel+bounces-61626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77009B58A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269642A3CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8F41DF265;
	Tue, 16 Sep 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3YzzTUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43802BB13;
	Tue, 16 Sep 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984386; cv=none; b=cr/tGmjBmxrav08Ud7Xq8QNfzH+M8H1hMi8ZizzQmg6Lw8rvFLJlhG+MRI4k8SVLfblr9NqnkRqJ+8LEZIhbKa9aD7HDzD8p41BWkEaJo47xak8M77B5BmV3VvGLdydQk6YFq1t/qRR5i/aTcJBBr8+vuo8nWrUZLEzUGKWNDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984386; c=relaxed/simple;
	bh=WN4lJKDilNLpkveaCPI4gHfypk0UpNBBXpGIUvHY1MY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeXNjXf6RnJsUb7p+W3t014VPBkWqAMzLrFYspmtO5uT6jMhMynmmVX2mbO9H9k0sLA46HOQWNAob0plXXB5wn9+5QdZnmYxKIZiezCg6wel5dtm7q5WTibOLoAeqVe78Pl7a48sPwUUYuqL6ElpL14f5AuhplpRnlXALUH6ofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3YzzTUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A5CC4CEF1;
	Tue, 16 Sep 2025 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984386;
	bh=WN4lJKDilNLpkveaCPI4gHfypk0UpNBBXpGIUvHY1MY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q3YzzTUQfryyM6JF+1XdX1NwwVAFxItY1BOEYOH7KZ8Cc8KvhRA9hYK7uUkXxiwAk
	 5wTL2LcSyTpkwcsNYoHilwq6jgx7Mux7oeZeLOx7349yCmEoNO9OTBa0SHZ9qa5rxy
	 q/UvJXavhnjNlxGwntIaENKIqamn3c754GnLZIlUKJqaFML/PQ1QMBBVuDU6GoQ6Wh
	 f0yEa6ri00y4b0FTqeRqESEzyO2bVcnBpi6eTrUxysqXF6lYOBP3C0Ft/84sgRmLSI
	 E50fr+jQapPVGGalVy8q4iIS8R7q29ZbDh4GS1VTubIhFIA6eK77Iwf1XYZLXXtNNS
	 oJDtUzYS8cDQg==
Date: Mon, 15 Sep 2025 17:59:46 -0700
Subject: [PATCH 04/17] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161791.390496.7528679358464800707.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 66683a416749d8..958427efef04b7 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -272,6 +272,7 @@ struct fuse4fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse4fs_feature_toggle iomap_want;
 	enum fuse4fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5712,7 +5713,7 @@ static errcode_t fuse4fs_iomap_begin_extent(struct fuse4fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE4FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE4FS_FSB_TO_B(ff, extent.e_len);
@@ -5745,13 +5746,14 @@ static int fuse4fs_iomap_begin_indirect(struct fuse4fs *ff, uint64_t ino,
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
@@ -5965,11 +5967,36 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
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
 
@@ -6004,8 +6031,16 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
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
 
@@ -6414,6 +6449,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5b5a0934062b64..adaa25718ddaaf 100644
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
@@ -265,6 +266,7 @@ struct fuse2fs {
 #ifdef HAVE_FUSE_IOMAP
 	enum fuse2fs_feature_toggle iomap_want;
 	enum fuse2fs_iomap_state iomap_state;
+	uint32_t iomap_dev;
 #endif
 	unsigned int blockmask;
 	unsigned long offset;
@@ -5153,7 +5155,7 @@ static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -5186,13 +5188,14 @@ static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
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
@@ -5405,11 +5408,36 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
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
 
@@ -5444,8 +5472,13 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
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
 
@@ -5752,6 +5785,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


