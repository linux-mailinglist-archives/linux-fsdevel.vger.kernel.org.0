Return-Path: <linux-fsdevel+bounces-55682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C64B0DA52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A335452E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F982EA14C;
	Tue, 22 Jul 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo0HIeSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C622E9753;
	Tue, 22 Jul 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189103; cv=none; b=lQYSsgFLJcJBqXE79ZC8oHX9E1VRORheNS53Ta5d7wI53GYoFZc/fUvuW1Iq/kXv3j7G5nx0Gl5WMRm5lTTvoECkfZ0+oDD7fuhiNZmbyEJOan70UZXDj+HQ3zkaBQzAgz6LJv9sIyTXbGH2iRiVvJLC9JszDDU/pAOmapBCBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189103; c=relaxed/simple;
	bh=M1JrxORjq+najwI2hYxDssi6uDtg4kLG51+LNk968qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNDuCY577NymP/KP8V9pkQOBwnPL+BBHPILsfYYge6hFpMo91FBHrvWGsa3uMXPnIYXk1V/QpL4uryYaD7WSVOIeDeMckDGjcI9kS4G+vnVSzyNf1nApvQKGzIuIeut93kirDM85QUEzpmp/hIi/kWDo0ez5K/mCcVFKwvpFUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo0HIeSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42818C4CEEB;
	Tue, 22 Jul 2025 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189102;
	bh=M1JrxORjq+najwI2hYxDssi6uDtg4kLG51+LNk968qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oo0HIeSIRahn7SlH5SUkZZLwYMyzsg7nbDRnBmDhBdyXF0B5mN0lL03d+LjcDeXWn
	 YKMeEscxXxj0s3emR8xc7Xl2UslmnhVOgNvztmb/L6GjeDca0FfjEMGkY8gumH9NZb
	 f0Um3mClSo2hEKRVG04xw02HkOEUsfwTg7x4RL4trCH/mUt1rfEHGy38fQQ1ROVLK0
	 jUpzQVgovUyDsEtkPeJLzOiAyw8mkxRpFR5AavrMDP1pj3q2zjVBYX/uVN/NfDojYK
	 5QMvuo1Mjnk+5qNkdnEi2NqBYXBQEuy7MblYz3TTzd3iMVKHci6O4DN2FI7XO4tTc7
	 5i0shsQfkjqbw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 12/13] f2fs: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 14:57:18 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-12-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3903; i=brauner@kernel.org; h=from:subject:message-id; bh=M1JrxORjq+najwI2hYxDssi6uDtg4kLG51+LNk968qY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd22e91w3Yk6STimTRmOSmUU1+/7KryoluZzpTbML/ vw9s7qoo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLFgYwMjUp1c1MWuMc0vr+w O+bkwUzeP8u0OSaqT7tW9+5EZTZrOCPDwsN92n9WR+1WPi+Xr2kru3b1r2nWTuWPzrzobT1f0+X PAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/file.c  |  4 ++++
 fs/f2fs/namei.c | 16 ++++++++++++++++
 fs/f2fs/super.c |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 152990273c68..c43f8be39cef 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -908,6 +908,9 @@ struct f2fs_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_fscrypt_info; /* filesystem encryption info */
 #endif
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_fsverity_info;
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f0003672a42c..dee7ac9e27bb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1153,6 +1153,10 @@ const struct inode_operations f2fs_file_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 998b0c31f728..e30a55fb71bb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1337,6 +1337,10 @@ const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.get_link	= f2fs_encrypted_get_link,
 	.getattr	= f2fs_encrypted_symlink_getattr,
@@ -1348,6 +1352,10 @@ const struct inode_operations f2fs_dir_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.create		= f2fs_create,
 	.lookup		= f2fs_lookup,
@@ -1373,6 +1381,10 @@ const struct inode_operations f2fs_symlink_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.get_link	= f2fs_get_link,
 	.getattr	= f2fs_getattr,
@@ -1384,6 +1396,10 @@ const struct inode_operations f2fs_special_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9f8e5ae13dc9..b88d446b3970 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1456,6 +1456,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_FS_ENCRYPTION
 	fi->i_fscrypt_info = NULL;
 #endif
+#ifdef CONFIG_FS_VERITY
+	fi->i_fsverity_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }

-- 
2.47.2


