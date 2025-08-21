Return-Path: <linux-fsdevel+bounces-58554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A7B2EA89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36ACD4E3E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A0211A11;
	Thu, 21 Aug 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmkYdw95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A499204F99;
	Thu, 21 Aug 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739318; cv=none; b=s1k4+jFkocN4A61RG1fzOSVzoKrlWZHmtNUYLJPo2mU5IB95ytPazgOAED4a1LMaYg3Le8FJESTLbUU5wPJuY72WfuF1UaGK7KBl4RGex/cVs9rV4TFhz5ETNSUTRLKU+lrJ278xw4T+wTHeVxuf4czctGFLNXvWz9KiXayzILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739318; c=relaxed/simple;
	bh=WI8pK67IN3oJ3gFH4l1NEMfOyFdW1wXKg0esjHnrxyI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SehwS7qocwvoRMQM+bjZpyo9bkKq+e0D/71iEEbE25YIuCveUmVIVPkz4Tz83i+G9OM3lTGKPyO2pMPYP2QxZ7GVpPF90i34LmPaMDYjPePEWV9zJcUhbyqZx0SqHpdJPyudz1uSk3ulRXEun0zhYKA1CjZnLBfdr4ycGI/n4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmkYdw95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217FFC4CEE7;
	Thu, 21 Aug 2025 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739318;
	bh=WI8pK67IN3oJ3gFH4l1NEMfOyFdW1wXKg0esjHnrxyI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NmkYdw95LQTJV01HUBq+82H8twrtSYe10KU7RDXU3eqq0OKQAiJUEV7LbUuUo72AV
	 GjEdNiv2Z5q06GpRaAy/lT2UQefyqsz7fbyKwcE9sJsAu76m8Mojpp5UtEZSqtzaGJ
	 rrDZk7J9svO0P++AduBckszWTj++F/VsgHVcWKWXxFCxdZ1/joJV2JjpjCEzcNW4Ao
	 4GdAPzzXLs0wIurxlh2IeEArz+WNOhnFUhXb1x2A/Jv+a/i0hIFRDb2J4zbrxDJWSV
	 Duv0892BexvuLXVvZTAJjHYWMtvdPamGMDUWSh1Z59hJCDgpn876DBlpeioH+Eew71
	 ItuQAK0xAN2Uw==
Date: Wed, 20 Aug 2025 18:21:57 -0700
Subject: [PATCH 3/8] fuse2fs: better debugging for file mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714446.22854.17340819202248729756.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Improve the tracing of a chmod operation so that we can debug file mode
updates.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 +++++++-----
 misc/fuse4fs.c |   10 ++++++----
 2 files changed, 13 insertions(+), 9 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 11ddf6a4001955..44f76e9bed5f42 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3195,6 +3195,7 @@ static int op_chmod(const char *path, mode_t mode
 	errcode_t err;
 	ext2_ino_t ino;
 	struct ext2_inode_large inode;
+	mode_t new_mode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3233,11 +3234,12 @@ static int op_chmod(const char *path, mode_t mode
 			mode &= ~S_ISGID;
 	}
 
-	inode.i_mode &= ~0xFFF;
-	inode.i_mode |= mode & 0xFFF;
+	new_mode = (inode.i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
-		   path, inode.i_mode, ino);
+	dbg_printf(ff, "%s: path=%s old_mode=0%o new_mode=0%o ino=%d\n",
+		   __func__, path, inode.i_mode, new_mode, ino);
+
+	inode.i_mode = new_mode;
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
@@ -3260,12 +3262,12 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 #endif
 			)
 {
+	struct ext2_inode_large inode;
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
-	struct ext2_inode_large inode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index ef6f3b33db99fd..b68573f654279d 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -3463,6 +3463,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			 mode_t mode, struct ext2_inode_large *inode)
 {
 	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	mode_t new_mode;
 	int ret = 0;
 
 	dbg_printf(ff, "%s: ino=%d mode=0%o\n", __func__, ino, mode);
@@ -3489,11 +3490,12 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			mode &= ~S_ISGID;
 	}
 
-	inode->i_mode &= ~0xFFF;
-	inode->i_mode |= mode & 0xFFF;
+	new_mode = (inode->i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: ino=%d new_mode=0%o\n",
-		   __func__, ino, inode->i_mode);
+	dbg_printf(ff, "%s: ino=%d old_mode=0%o new_mode=0%o\n",
+		   __func__, ino, inode->i_mode, new_mode);
+
+	inode->i_mode = new_mode;
 
 	return 0;
 }


