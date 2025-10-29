Return-Path: <linux-fsdevel+bounces-66096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E197C17C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436273ABB27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052142D8767;
	Wed, 29 Oct 2025 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMxNhBAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEE3A1CD;
	Wed, 29 Oct 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700169; cv=none; b=VRFTNJ3pZDnVpoRIA9ynWYab2nw7Vgqs8nuU+rn5XxnQIh7iuayeNxrue+bYzCxtoa6B3KGhRQDejA46VWSb3Z/aEBZyGIXp0EhWGOdsAaM/52j/XTzflP/rcISx4G+u+fzk/H1ojBs8W+fkBb9DOm+H9rpwFH0lEtaqajA+sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700169; c=relaxed/simple;
	bh=2bfJYO7dg2VYc7oRVwla1R7NhkmsTuDUtnXWm+98a6g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3HSwJu3aTDl/Qesi3KYP1Icszc31wHy9WhdXf+vz4azMVrjOL1nzEsIUfTDLzXts0YwIeojxBD5c1y4FSnxxDJVnh3BxB08yDH4jBnSJf43W9kumwL7hvPNMFK1G3MEFvE2oju0jtRwE1TujTRVoUXsXT6ToFDljWquVaDWqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMxNhBAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26A5C4CEE7;
	Wed, 29 Oct 2025 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700168;
	bh=2bfJYO7dg2VYc7oRVwla1R7NhkmsTuDUtnXWm+98a6g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iMxNhBAsfa0sTOFufj4Hf7C58xzHMyFeW2/jkdqPXsA/u8GzsQjvLNX01JyrgEXEN
	 pKZ9rTs9lg8b8XfK9iYMDcTUJdtzZP5DCKlnl0Y21Z2wyp6tgwUEfeesA3igWCU6MQ
	 HzZTx0hPAV88MZ4OIBlkCJ/cs4pxSqjqH2Ie1Ys80weNkSUZDwbBnWENggsFFx7qEn
	 E7KeEZ2T1JDIpDOVX+dCxut3ilDcZ+ZrxQQ0MPbLeZ2ZBRbPHeiOPqtKzeffoGo02G
	 fd5Dg3bc/kesZVf3Phm9Hzqbmchp94MBl9KC8NArZmwo/r4wjyzLpiJLM3UEqROb+f
	 dnu8k1n/6IgsQ==
Date: Tue, 28 Oct 2025 18:09:28 -0700
Subject: [PATCH 04/17] fuse2fs: register block devices for use with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817634.1429568.16689967129997099547.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
References: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Register the ext4 block device with the kernel for use with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |   42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index ff0f913997e3ba..fba04feaa5770b 100644
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
@@ -6015,7 +6016,7 @@ static errcode_t fuse4fs_iomap_begin_extent(struct fuse4fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE4FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE4FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE4FS_FSB_TO_B(ff, extent.e_len);
@@ -6048,13 +6049,14 @@ static int fuse4fs_iomap_begin_indirect(struct fuse4fs *ff, uint64_t ino,
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
@@ -6268,11 +6270,36 @@ static off_t fuse4fs_max_size(struct fuse4fs *ff, off_t upper_limit)
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
 
@@ -6307,8 +6334,16 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
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
 
@@ -6767,6 +6802,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a85af4518441d2..8738e0b78f45f2 100644
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
 	unsigned long offset;
@@ -5460,7 +5462,7 @@ static errcode_t fuse2fs_iomap_begin_extent(struct fuse2fs *ff, uint64_t ino,
 	}
 
 	/* Mapping overlaps startoff, report this. */
-	iomap->dev = FUSE_IOMAP_DEV_NULL;
+	iomap->dev = ff->iomap_dev;
 	iomap->addr = FUSE2FS_FSB_TO_B(ff, extent.e_pblk);
 	iomap->offset = FUSE2FS_FSB_TO_B(ff, extent.e_lblk);
 	iomap->length = FUSE2FS_FSB_TO_B(ff, extent.e_len);
@@ -5493,13 +5495,14 @@ static int fuse2fs_iomap_begin_indirect(struct fuse2fs *ff, uint64_t ino,
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
@@ -5712,11 +5715,36 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
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
 
@@ -5751,8 +5779,13 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
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
 
@@ -6118,6 +6151,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_IOMAP
 		.iomap_want = FT_DEFAULT,
 		.iomap_state = IOMAP_UNKNOWN,
+		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 	};
 	errcode_t err;


