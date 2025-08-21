Return-Path: <linux-fsdevel+bounces-58546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98470B2EA76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A9165FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941A1FAC42;
	Thu, 21 Aug 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/U5PQsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321041CAA92;
	Thu, 21 Aug 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739193; cv=none; b=s+P4iC/MpQexZgn5UAp2bSsZo60iK+UNEQHZwy5RfHaU26JFaiSiy/j3bTXD5/REEo1GCDzNBmopxi41hvXWHIynx4LZuTK61Yzz+cAc58yBoWWlOe1+UpuK2KmQjJiEJ4rtO/2NS6231KFnHE1Qxo5a+yeN9lrZgkvn2FmzLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739193; c=relaxed/simple;
	bh=4k5jjkMalVv5sIM8rwERuOHJ0kf2SJfDNMzWHSEKNC4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqxsdkaM+DBRqKamN0DNP7y3DmmBA9CW9xNqPK2J8ezKiQh52wAFLzfjoNQy/Q5fpEFqMzi9SKKz9iAct+clhwbEKXuJSwVGRu+cHKWzLC0Y4Tj/kS+rA1CWGobvMypqkO4jojVelAT6af9iVWcJlRxICUgP0jcrqlz5lgCOVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/U5PQsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01333C4CEE7;
	Thu, 21 Aug 2025 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739193;
	bh=4k5jjkMalVv5sIM8rwERuOHJ0kf2SJfDNMzWHSEKNC4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D/U5PQsLfJRK/nN7iOtQxqPE7c+WCkmHY7YQjyg4CEPWya/RViDwapWvix+hux4Tf
	 DFO7+dbtmvtnmeS1SIStarawRiqB9re6cdOx7QO9i5G0rHlULmIHgGhq3aCeHZZPHP
	 sX4zz39FglQAXcKqhDYwErgBOdHjNedvV9PJV+bkkpJxe5CpTReRZJmsCbZ8GPBbde
	 0d4wVbP83qRtKdJN3LWTL5HkZXxYRbTLn6/pK82/Wxs5doyE5WUGBXRndCIppCWzsi
	 DiCvVs9M0tFSDrDcJ5p9DO6IH9RyxKkXWeAuysLtPQuZj54xp1oD0ie5ZIdL90TZR1
	 MYjBn8W3qccXg==
Date: Wed, 20 Aug 2025 18:19:52 -0700
Subject: [PATCH 16/19] fuse4fs: don't use inode number translation when
 possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714019.21970.16728228028493607539.stgit@frogsfrogsfrogs>
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
 misc/fuse4fs.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 304bac191e7c4c..5127712e19e6f9 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -263,6 +263,7 @@ struct fuse4fs {
 	uint8_t unmount_in_destroy;
 	uint8_t noblkdev;
 	uint8_t iomap_passthrough_options;
+	uint8_t translate_inums;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -324,17 +325,19 @@ struct fuse4fs {
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
@@ -350,7 +353,7 @@ static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
 			fuse_reply_err((req), EIO); \
 			return; \
 		} \
-		fuse4fs_ino_from_fuse(ext2_inop, fuse_ino); \
+		fuse4fs_ino_from_fuse(fuse4fs_get(req), ext2_inop, fuse_ino); \
 	} while (0)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
@@ -1723,7 +1726,7 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inodep->i_block[1];
 	}
 
-	fuse4fs_ino_to_fuse(&entry->ino, ino);
+	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
@@ -7101,6 +7104,7 @@ int main(int argc, char *argv[])
 		.iomap_state = IOMAP_UNKNOWN,
 		.iomap_dev = FUSE_IOMAP_DEV_NULL,
 #endif
+		.translate_inums = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
@@ -7206,6 +7210,19 @@ int main(int argc, char *argv[])
 		goto out;
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


