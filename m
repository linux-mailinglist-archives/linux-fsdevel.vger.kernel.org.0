Return-Path: <linux-fsdevel+bounces-66115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B39C17D0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF6D405293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657B2DA763;
	Wed, 29 Oct 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+CmxSQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FF261B8A;
	Wed, 29 Oct 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700466; cv=none; b=E41FQ4Qg7X37HZ0tEgcPax3sNjfj+f8SYaZ6elTHMUJyulPsHcsxvUzEbSSQjkzCDQAJDn46PzQxJLV4/+c9qmrcm817Ch/sZvggknxn+FKva1SQfvnx9mR3FN7LcH4mAl2jnW5L9z3R22k+9JxFjZOv1OyOjQQnTcyYEaxYfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700466; c=relaxed/simple;
	bh=Q31X7LR8I+URwt/aEl67zRsX32q/g0wcnrxJTLySHRw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThXYoV78SJsTZjHVPAe5N/HYKqrZJXZBKaNu9cwe05+nW6r97sVZm2VrZX6BXDie9PxYCZRmdIbPZluNemCqUmEKD74e/bYm6n6ErfQ538KZwCkAL6+/6jLzqkOlUjYAnr1Cc5UwNc2xCWl1tMCSyxsi67MCuJ6I5vbXbsFSTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+CmxSQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F19C4CEE7;
	Wed, 29 Oct 2025 01:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700466;
	bh=Q31X7LR8I+URwt/aEl67zRsX32q/g0wcnrxJTLySHRw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H+CmxSQ3nykNRiQ0m+Z76s3X/nvLRY5EIVKJXONIrCN88w6jDKvatenFl2tzuwECR
	 gf/IrcZvKbooZDNzc9GAS5xt7hafnL19ho5LHNGxmABzs/b1GRVkE7lk4aUCTXenl3
	 5uDi1RleRafP4UEVvbEv9KNkboPw5BnBR9z3Sp+2vQLaqE7qDaIlX8QtcsJjFXzotf
	 oO/BQwtBe32Aah7TK1RgJ76ZAgWXJZpNxy2dGqy8OrYKDaGa5mJa5picI5Jh5DTuiV
	 kr5e3dEOM398hBUgykIV2UbICwcm6nv/rdiBoGNVKi5UGKpkZULssBwyoOG17yH/ac
	 x2wMXjbnB6Vrw==
Date: Tue, 28 Oct 2025 18:14:25 -0700
Subject: [PATCH 04/11] fuse2fs: better debugging for file mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818293.1430380.15266861328722867108.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
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
 fuse4fs/fuse4fs.c |   10 ++++++----
 misc/fuse2fs.c    |   12 +++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 74b262b293eabc..7570950ca2458d 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3908,6 +3908,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			 mode_t mode, struct ext2_inode_large *inode)
 {
 	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	mode_t new_mode;
 	int ret = 0;
 
 	dbg_printf(ff, "%s: ino=%d mode=0%o\n", __func__, ino, mode);
@@ -3934,11 +3935,12 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
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
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 30fe10ef25da1d..fe6410a42a17ff 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3601,6 +3601,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	errcode_t err;
 	ext2_ino_t ino;
 	struct ext2_inode_large inode;
+	mode_t new_mode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3639,11 +3640,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
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
@@ -3663,12 +3665,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 static int op_chown(const char *path, uid_t owner, gid_t group,
 		    struct fuse_file_info *fi)
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


