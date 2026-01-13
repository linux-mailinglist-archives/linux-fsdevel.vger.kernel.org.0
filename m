Return-Path: <linux-fsdevel+bounces-73426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7ED18E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCCD304C00A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F13904E8;
	Tue, 13 Jan 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUl+VT07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C43904CF;
	Tue, 13 Jan 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308002; cv=none; b=jThwqRLQFpqZr03asax18qzlymRqs85dWZMYFluovGdX/dRtqNHAHYw0WBwxJg/lYn25GkMR19ajrXvzFYNvy4RD/Kh5fkM7Y5zNu52s04qi5KZcQEmGjjmFvLsDC1/y0tSjiXxeHgNxLy87gYK3JgEDaLFGS5vj/nzYAxvRqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308002; c=relaxed/simple;
	bh=CziPONQGMZ6pGNhZmKWF+1FWgqqVSfYV591RzVNuX9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO7RJ6uYSWdfXW6Eer3uQZ4FifCNfUW5yt6XTYq8uMT6Faadx6RUdiNIR2/QMHSCKTp5zJqLznuyykPy6OB4ft3pn+by1yxB9TEDPl0u/EYoqaM1/fg3+2jU77Pqr3TUowmDmE2iOxfkKh0274QOcXbcITnLGSLxZVoqazIXid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUl+VT07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2E7C16AAE;
	Tue, 13 Jan 2026 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308002;
	bh=CziPONQGMZ6pGNhZmKWF+1FWgqqVSfYV591RzVNuX9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUl+VT07tJvLLKmrzGcs9sUzLcql8qP/sqKwsa/isyrTkMXYM8JPBojETs5WPDVf0
	 56ijxzI30Pzp2ArWJNxhlJ3pziz3fnLN0li1Bo8LYKwfkLD2bcgPU/YwjbJwNQ+qxC
	 QEoZhw10FXJJCUgQRkSodDJde8F/KxLpd/DAHJefQ3xKww8xDE41sUIHY4TPb9BnE9
	 n72v6ZxvwI2RSoD5gTNVRw39sZVfCSmkTSU1snWvE1tkBPTLFr3cAFP4dHzd91KHyC
	 c7rUENv50t6ZGNIVj1pDBLvaRBgMQhPelSpTugDFES49tTZmSep2alJtOL6dYIlnCD
	 4YyhgbD55hKJg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/4] fs: export may_delete() as may_delete_dentry()
Date: Tue, 13 Jan 2026 12:39:50 +0000
Message-ID: <e09128fd53f01b19d0a58f0e7d24739f79f47f6d.1768307858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768307858.git.fdmanana@suse.com>
References: <cover.1768307858.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

For many years btrfs as been using a copy of may_delete() in
fs/btrfs/ioctl.c:btrfs_may_delete(). Everytime may_delete() is updated we
need to update the btrfs copy, and this is a maintenance burden. Currently
there are minor differences between both because the btrfs side lacks
updates done in may_delete().

Export may_delete() so that btrfs can use it and with the less generic
name may_delete_dentry(). While at it change the calls in vfs_rmdir() to
pass a boolean literal instead of 1 and 0 as the last argument since the
argument has a bool type.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/namei.c         | 17 +++++++++--------
 include/linux/fs.h |  3 +++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..28aebc786e8f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3604,7 +3604,7 @@ EXPORT_SYMBOL(__check_sticky);
  * 11. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
+int may_delete_dentry(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir)
 {
 	struct inode *inode = d_backing_inode(victim);
@@ -3646,6 +3646,7 @@ static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 		return -EBUSY;
 	return 0;
 }
+EXPORT_SYMBOL(may_delete_dentry);
 
 /*	Check whether we can create an object with dentry child in directory
  *  dir.
@@ -5209,7 +5210,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
-	int error = may_delete(idmap, dir, dentry, 1);
+	int error = may_delete_dentry(idmap, dir, dentry, true);
 
 	if (error)
 		return error;
@@ -5344,7 +5345,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(idmap, dir, dentry, 0);
+	int error = may_delete_dentry(idmap, dir, dentry, false);
 
 	if (error)
 		return error;
@@ -5816,7 +5817,7 @@ int vfs_rename(struct renamedata *rd)
 	if (source == target)
 		return 0;
 
-	error = may_delete(rd->mnt_idmap, old_dir, old_dentry, is_dir);
+	error = may_delete_dentry(rd->mnt_idmap, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
@@ -5826,11 +5827,11 @@ int vfs_rename(struct renamedata *rd)
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(rd->mnt_idmap, new_dir,
-					   new_dentry, is_dir);
+			error = may_delete_dentry(rd->mnt_idmap, new_dir,
+						  new_dentry, is_dir);
 		else
-			error = may_delete(rd->mnt_idmap, new_dir,
-					   new_dentry, new_is_dir);
+			error = may_delete_dentry(rd->mnt_idmap, new_dir,
+						  new_dentry, new_is_dir);
 	}
 	if (error)
 		return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5c9cf28c4dc..319aaeb876fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2657,6 +2657,9 @@ static inline int path_permission(const struct path *path, int mask)
 int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode);
 
+int may_delete_dentry(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *victim, bool isdir);
+
 static inline bool execute_ok(struct inode *inode)
 {
 	return (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode);
-- 
2.47.2


