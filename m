Return-Path: <linux-fsdevel+bounces-61650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96319B58AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC25524425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD81E1A3D;
	Tue, 16 Sep 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2J40f7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3073D561;
	Tue, 16 Sep 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984748; cv=none; b=e79Hcr8DQRCCamhoxwbvBKEYS/mxSyNLPRN0RXwMxSvGaxQM9QL+5d+mqNPMfJPIs6v9oRO0NQm5+AO17nMEg5vYBPVsR9Kknp1BlvQCJIz7KkYpeqbRTEHtYAGVtrwpDepi8YnRXn1Z0Iw4KT0R/p3VXXrahbc8tkkw7V9BgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984748; c=relaxed/simple;
	bh=uuo2YX21pOgY+QLg51ZB3B43Gbf/4U8Vqd4HxPnxfFw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV0/uoWCgXrqtxispNIXQau/5rpQ4Fnvfugr2aYNUxUTwYIKxekigSByLyQctEKR5z+I/Sy2AlEE5VEina7kSkz06SHymwbU9oFT6fjeDNrhDNBDvbPmGYQEOtkmA5L8HOjig4vBhnSGRo9VH+Ix4EQJo9jlfCI3eZNIGEXDShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2J40f7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6BFC4CEF1;
	Tue, 16 Sep 2025 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984747;
	bh=uuo2YX21pOgY+QLg51ZB3B43Gbf/4U8Vqd4HxPnxfFw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f2J40f7FrH5qoB1d2axLfwHLDPdcXH0kEBJZzGidLvilFbGj/moyxbn+AoKGbO9Hl
	 FrazQS1SZSLPuZthrzZfmm+Lm5GfYw1lu19PvLRYuYUDKgmZm7I9xtqfTlmF0p6pDe
	 6nIjHgTlUzXTVZTVs5sWCinUosrDIIeCR1XAoA4KiPasJWPv99Mdez01zRcc9i61pj
	 Dxq52v8HbX4RHHCLNSM2tEajGk0Wnfik5WuBhiMfXl8AlCZ0hUo0DEqw3mGCL4BPA+
	 NmSElsvpCPbhXyYoCLLvLJoB4LuZhHg6HwDqIkDBqzVxMWhOviMOGKV/qCGPk5SJ2N
	 qGdDeTAu+giSA==
Date: Mon, 15 Sep 2025 18:05:47 -0700
Subject: [PATCH 09/10] fuse2fs: skip the gdt write in op_destroy if syncfs is
 working
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162503.391272.6658964627154863656.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

As an umount-time performance enhancement, don't bother to write the
group descriptor tables in op_destroy if we know that op_syncfs will do
it for us.  That only happens if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   19 ++++++++++++++++---
 misc/fuse2fs.c    |   19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 25c19c0f0deca0..4f5618e64a93c3 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -268,6 +268,7 @@ struct fuse4fs {
 	int noblkdev;
 	int translate_inums;
 	int iomap_passthrough_options;
+	int write_gdt_on_destroy;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -1475,9 +1476,11 @@ static void op_destroy(void *userdata)
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5803,6 +5806,15 @@ static void op_syncfs(fuse_req_t req, fuse_ino_t ino)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse4fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	fuse_reply_err(req, -ret);
@@ -7497,6 +7509,7 @@ int main(int argc, char *argv[])
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
 		.translate_inums = 1,
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d4f1825dd695ad..b193e0b2c06b69 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -261,6 +261,7 @@ struct fuse2fs {
 	int unmount_in_destroy;
 	int noblkdev;
 	int iomap_passthrough_options;
+	int write_gdt_on_destroy;
 
 	enum fuse2fs_opstate opstate;
 	int logfd;
@@ -1301,9 +1302,11 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		if (fs->super->s_error_count)
 			fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(fs);
-		err = ext2fs_set_gdt_csum(fs);
-		if (err)
-			translate_error(fs, 0, err);
+		if (ff->write_gdt_on_destroy) {
+			err = ext2fs_set_gdt_csum(fs);
+			if (err)
+				translate_error(fs, 0, err);
+		}
 
 		err = ext2fs_flush2(fs, 0);
 		if (err)
@@ -5360,6 +5363,15 @@ static int op_syncfs(const char *path)
 		}
 	}
 
+	/*
+	 * When iomap is enabled, the kernel will call syncfs right before
+	 * calling the destroy method.  If any syncfs succeeds, then we know
+	 * that there will be a last syncfs and that it will write the GDT, so
+	 * destroy doesn't need to waste time doing that.
+	 */
+	if (fuse2fs_iomap_enabled(ff))
+		ff->write_gdt_on_destroy = 0;
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -6944,6 +6956,7 @@ int main(int argc, char *argv[])
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
+		.write_gdt_on_destroy = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


