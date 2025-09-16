Return-Path: <linux-fsdevel+bounces-61640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE2B58A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945BA1B268F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA121C5F23;
	Tue, 16 Sep 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o07+L/dR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9718C933;
	Tue, 16 Sep 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984607; cv=none; b=ujMddAXSA732iVsqeqo3hsNpB3n6SVlaAqdGLEjvsrkH+jo6B4/BGJ6hVNZqj6p3G8mnqvlR29pHpdVcFUr088Pgk+K/mQGk+eC0YH72/h4ETf3gzEXnPU9/eeif8vAXs18udA2ejzOuPnJzWpQho+Nn+3lfU8g7HbqjOJpsZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984607; c=relaxed/simple;
	bh=IIiIoS+EmCtU9anbhB55+yUgjAxV+/szo4XH3HWQkjY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M14rF5xCytz0LBWWYliPqYiKj31coDiimPp0ANur1MyU6apxERealoVsqFNOTcts5qoEXK+7uYKOmvsaTDfPq6IMCk3zntbMFAgMrwp7T7QyALXG+tSSwnnmfk4I2bXTbbGK+bdutKOq4pOOh9agiOvGgJHCoiA03s4/gos40Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o07+L/dR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ED8C4CEF1;
	Tue, 16 Sep 2025 01:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984607;
	bh=IIiIoS+EmCtU9anbhB55+yUgjAxV+/szo4XH3HWQkjY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o07+L/dRXaIMCZ7OtIjVbeQuMQsTUOxNnYGEM7ndQevrmpu3rzNd5LHA2zfBHrYdN
	 ZLckb/np5xT855ni8ERmjZJ0VkP5TM+Ac6UyVpOiMmRlRfOUXjo34V1XnVe52K7vnu
	 SYWXwJmTlxKSk5WEiiGcFQeNUDZwpAaEW4PURdx/Dara7C2HKvOLYKQ7kYuLeuRB7t
	 2Gr6Lwp80imyKj9Pf6dPFGjwNm0tn7g9lmh+DXYn8rQ4AptDVeLhkodSwzHJFGJhdM
	 /wiRH6a1tAVkfvrDS7IWQ6LtBG488FGtYNL0UJ3/mxWe1pEihe4x5+7DcorzZZKwbk
	 dekqkoppgLhmQ==
Date: Mon, 15 Sep 2025 18:03:26 -0700
Subject: [PATCH 1/1] fuse4fs: don't use inode number translation when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162169.391172.13973491473334264179.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162150.391172.13020654147286034076.stgit@frogsfrogsfrogs>
References: <175798162150.391172.13020654147286034076.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Prior to the integration of iomap into fuse, the fuse client (aka the
kernel) required that the root directory have an inumber of
FUSE_ROOT_ID, which is 1.  However, the ext2 filesystem defines the root
inode number to be EXT2_ROOT_INO, which is 2.  This dissonance means
that we have to have translator functions, and that any access to
inumber 1 (the ext2 badblocks file) will instead redirect to the root
directory.

That's horrible.  Use the new mount option to set the root directory
nodeid to EXT2_ROOT_INO so that we don't need this translation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index abbc67bccef786..3be19f59fc3976 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -266,6 +266,7 @@ struct fuse4fs {
 	int dirsync;
 	int unmount_in_destroy;
 	int noblkdev;
+	int translate_inums;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -335,17 +336,19 @@ struct fuse4fs {
 #define FUSE4FS_CHECK_CONTEXT_ABORT(ff) \
 	__FUSE4FS_CHECK_CONTEXT((ff), abort(), abort())
 
-static inline void fuse4fs_ino_from_fuse(ext2_ino_t *inop, fuse_ino_t fino)
+static inline void fuse4fs_ino_from_fuse(const struct fuse4fs *ff,
+					 ext2_ino_t *inop, fuse_ino_t fino)
 {
-	if (fino == FUSE_ROOT_ID)
+	if (ff->translate_inums && fino == FUSE_ROOT_ID)
 		*inop = EXT2_ROOT_INO;
 	else
 		*inop = fino;
 }
 
-static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
+static inline void fuse4fs_ino_to_fuse(const struct fuse4fs *ff,
+				       fuse_ino_t *finop, ext2_ino_t ino)
 {
-	if (ino == EXT2_ROOT_INO)
+	if (ff->translate_inums && ino == EXT2_ROOT_INO)
 		*finop = FUSE_ROOT_ID;
 	else
 		*finop = ino;
@@ -361,7 +364,7 @@ static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
 			fuse_reply_err((req), EIO); \
 			return; \
 		} \
-		fuse4fs_ino_from_fuse(ext2_inop, fuse_ino); \
+		fuse4fs_ino_from_fuse(fuse4fs_get(req), ext2_inop, fuse_ino); \
 	} while (0)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
@@ -1765,7 +1768,7 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inodep->i_block[1];
 	}
 
-	fuse4fs_ino_to_fuse(&entry->ino, ino);
+	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
@@ -7410,6 +7413,7 @@ int main(int argc, char *argv[])
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
+		.translate_inums = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
@@ -7511,6 +7515,19 @@ int main(int argc, char *argv[])
 		fctx.unmount_in_destroy = 1;
 	}
 
+	if (iomap_detected) {
+		/*
+		 * The root_nodeid mount option was added when iomap support
+		 * was added to fuse.  This enables us to control the root
+		 * nodeid in the kernel, which enables a 1:1 translation of
+		 * ext2 to kernel inumbers.
+		 */
+		snprintf(extra_args, BUFSIZ, "-oroot_nodeid=%d",
+			 EXT2_ROOT_INO);
+		fuse_opt_add_arg(&args, extra_args);
+		fctx.translate_inums = 0;
+	}
+
 	if (!fctx.cache_size)
 		fctx.cache_size = default_cache_size();
 	if (fctx.cache_size) {


