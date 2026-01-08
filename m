Return-Path: <linux-fsdevel+bounces-72839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD27D04195
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBC4830650BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95874831E0;
	Thu,  8 Jan 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwxMG2cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4447F2E4;
	Thu,  8 Jan 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879448; cv=none; b=Qe0DXxr1aEtkJ6y2RKGcHrLAHW8eXLjWrG3w34FxwSghNOhQ6BPX+tfB/Einqes1EoyVMz5l40ilf7aRuXCsQxTBZqqSLI9//sDnRJcPAuNDaGp8ELcQ/G3naX/QHl0G7atf9jfDSxVgiJjOLsqmo1D0w+in3spc2mbtKR2YRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879448; c=relaxed/simple;
	bh=CziPONQGMZ6pGNhZmKWF+1FWgqqVSfYV591RzVNuX9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD9BmadAa5ZDmwRBGpVO/ZhcuNksgUV1zn8D+uMX4BvHVDC3kk4sIcmsEs8voTzGQB8x+HtByizIieQ7T2u31dJgRWCYWgBfDEOaF1YDMYDzRCeqEpLDtU7M4dKwcgndb0y3xXc0ZDWRZ7dtt9OJ+Y15oMgDSrUcbKhEkntTwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwxMG2cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBA2C116C6;
	Thu,  8 Jan 2026 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879447;
	bh=CziPONQGMZ6pGNhZmKWF+1FWgqqVSfYV591RzVNuX9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwxMG2clAp5V4BA4dOxy8NPrCUK5FGPkuacrUK7WX5ueV5ffXvhtXzBVEMXY2VKry
	 d1upMzb/6maxL3gzjn+4N4PiX97ogSmfPCJwbgQ2av8sLPlf7qrc86zuoH1JU15QqS
	 b7H/RxgoWKoug1/DjNIL7/8RCSMnDCy7oj+fnXbaD5UH99OL+89jlKxXc416ZANl5t
	 jNkn4ezD8/JMeX8DQp0LWdWvEToMuGUGngcCvoRZfHrLIld8wYPcBGRhr18b4qtz5F
	 KXUpZ927cOusXItwASeEzBVZ+AiViBRNzz0+r2uWOht7AQnMcm8J6UHG+g6ug5d88P
	 mw0ouu8SW06Xg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/4] fs: export may_delete() as may_delete_dentry()
Date: Thu,  8 Jan 2026 13:35:31 +0000
Message-ID: <e09128fd53f01b19d0a58f0e7d24739f79f47f6d.1767801889.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1767801889.git.fdmanana@suse.com>
References: <cover.1767801889.git.fdmanana@suse.com>
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


