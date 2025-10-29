Return-Path: <linux-fsdevel+bounces-66111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C45C17CC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3C150175F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C32D9ED7;
	Wed, 29 Oct 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORCBDHC2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77E2147E6;
	Wed, 29 Oct 2025 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700404; cv=none; b=DGe/iR49gYBTt+Icmq1TpSsrVMA+idfLolJeJIidUI01dDtRzj8mIyA7JZTCIe54MdpjhHnQBpvSazMb9s+0d1lfXu+qOWY6+sO1ekwlAMVOBFZYbOlIV2K92CMbqL5FCwRr4+LwX8B1jqvZ7IbLx817tNEfnC3jKTx+6egLNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700404; c=relaxed/simple;
	bh=0FT26uZazs9wMfPcZIIckh2r1Bm63O2DPbtVEASIo6Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efkSLk03jkH17+4KRcua9UjKTUhfG6i0EuxIlhb4XGnw0aMvD3zhufw+NXII/cc2Qre60utV3p4SFWU86x3zM10+8b6leq17ZScsnO2DfdV+14MUNJRrzmoYAqyBz4T+AZGUazxK98ZqZzWDLbh45a9/UJYODRGjefRXWvaRxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORCBDHC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80327C4CEFD;
	Wed, 29 Oct 2025 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700403;
	bh=0FT26uZazs9wMfPcZIIckh2r1Bm63O2DPbtVEASIo6Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ORCBDHC2J/J2SphaBGF4hVzkcw078xK8SKqiwxdM+LcJGC6ZpSAyu9wL+mMwE2nb/
	 AoayhHLNXB1XbfTMRoFn3y5w5JnIux/qBUClf2BABl86QQIBP6X5dTtVmrqamVGCrh
	 pdGUyQ6btgLwpCmbJ5dTH9qpDzD8LHiToSmnnaMFCLIeUJzWzo3q9WZ9zbozewr//L
	 jpqYrKexvdS1uqBUgiRJ0CZdbyaUuvjJ9dys70p3Yx+7DpYWSSU1SZbmvMi7oThgix
	 VW4uGGBkYKWvO2Hl99kdocN4RSVcVkRTelbhhYWBj+TKTBym29MXGBrgTUts2+tURv
	 aiUAJYQxmdNfw==
Date: Tue, 28 Oct 2025 18:13:23 -0700
Subject: [PATCH 2/2] fuse4fs: don't use inode number translation when possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818036.1430244.10231877682343965113.stgit@frogsfrogsfrogs>
In-Reply-To: <176169817993.1430244.1454665580135941500.stgit@frogsfrogsfrogs>
References: <176169817993.1430244.1454665580135941500.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 26b9c6340b73a1..d45163e3295168 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -273,6 +273,7 @@ struct fuse4fs {
 	int directio;
 	int acl;
 	int dirsync;
+	int translate_inums;
 
 	enum fuse4fs_opstate opstate;
 	int logfd;
@@ -345,17 +346,19 @@ struct fuse4fs {
 #define FUSE4FS_CHECK_CONTEXT_INIT(req) \
 	__FUSE4FS_CHECK_CONTEXT((req), abort(), abort())
 
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
@@ -371,7 +374,7 @@ static inline void fuse4fs_ino_to_fuse(fuse_ino_t *finop, ext2_ino_t ino)
 			fuse_reply_err((req), EIO); \
 			return; \
 		} \
-		fuse4fs_ino_from_fuse(ext2_inop, fuse_ino); \
+		fuse4fs_ino_from_fuse(fuse4fs_get(req), ext2_inop, fuse_ino); \
 	} while (0)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
@@ -2118,7 +2121,7 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 			statbuf->st_rdev = inodep->i_block[1];
 	}
 
-	fuse4fs_ino_to_fuse(&entry->ino, ino);
+	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
 	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
 	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
@@ -7773,6 +7776,20 @@ static void fuse4fs_compute_libfuse_args(struct fuse4fs *ff,
  "-oallow_other,default_permissions,suid,dev");
 	}
 
+	if (fuse4fs_can_iomap(ff)) {
+		/*
+		 * The root_nodeid mount option was added when iomap support
+		 * was added to fuse.  This enables us to control the root
+		 * nodeid in the kernel, which enables a 1:1 translation of
+		 * ext2 to kernel inumbers.
+		 */
+		snprintf(extra_args, BUFSIZ, "-oroot_nodeid=%d",
+			 EXT2_ROOT_INO);
+		fuse_opt_add_arg(args, extra_args);
+		ff->translate_inums = 0;
+	}
+
+
 	if (ff->debug) {
 		int	i;
 
@@ -7950,6 +7967,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_FUSE_LOOPDEV
 		.loop_fd = -1,
 #endif
+		.translate_inums = 1,
 	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;


