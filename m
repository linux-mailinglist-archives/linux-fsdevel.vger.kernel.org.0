Return-Path: <linux-fsdevel+bounces-73427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C537FD18EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D3A3106C0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E513904FC;
	Tue, 13 Jan 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvdciHHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9573904F1;
	Tue, 13 Jan 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308003; cv=none; b=KD+Z1XdOiaxFtMcyYulc5OmEgrDt9cNtB7/7jyvhIvYxOfCr0HSAIIWr114kf9Bvy0hfgG535jNtzG96JA87AJGZWO5C7XSKTJLiaDsT33cpw6d/sFmVVmAE7GsUrT+RpVhEt8+l4vrcLmRGDnDpGAbEw3jGYz/FzehhFoeQtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308003; c=relaxed/simple;
	bh=Wt6Yh87897ZptxoyPPMHRcb5zb0qjabk75+t0+TezLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/s3EE2gnGKRj1kSONRB93WbRYYdI74rYyOnSicfmXBjNLeoGXooxVOzHMK45qtJZWwW0A7Wa0nTbqByj6Vbv3X9UFLg5s2Ue/2mYWj+VDuZexn8/iP+DMkT68Ua1PC8WINpkDezPxwYGv+UTnwmcNaZWGCrzOueI4OIsyicaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvdciHHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67646C16AAE;
	Tue, 13 Jan 2026 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308003;
	bh=Wt6Yh87897ZptxoyPPMHRcb5zb0qjabk75+t0+TezLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvdciHHjIDf5cbQ0tw6POpsLnk2MtniC2ocNF3HVQCAFRd/SDImNxKA+1uxe6NsJb
	 Fj4CVCNfmfx3nh+pKUyPGrtV3o9RQdN9tll8/M15yM6eCy25Gt1rW0b1EWFMdPM5wB
	 BooC0cq0s/CXG4+q/CgAGdTl5PedYUDxRCbbZWveKi5YwNJBne4nALRjuoRJGMk42J
	 SsfEPaPtkujMZ8q0sYQVG4P4T9Frzv9xZrLOe/1DRJt6mYThTFxO+P+qdvJm4RhVWh
	 dodMKXHO6tngpDDfyV1X+dtT8R5MnL/zi+PArQho/sAcQ+oGAZc2VOv7ognvVip8XB
	 GAjOlZWp9104w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 2/4] fs: export may_create() as may_create_dentry()
Date: Tue, 13 Jan 2026 12:39:51 +0000
Message-ID: <ce5174bca079f4cdcbb8dd145f0924feb1f227cd.1768307858.git.fdmanana@suse.com>
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

For many years btrfs as been using a copy of may_create() in
fs/btrfs/ioctl.c:btrfs_may_create(). Everytime may_create() is updated we
need to update the btrfs copy, and this is a maintenance burden. Currently
there are minor differences between both because the btrfs side lacks
updates done in may_create().

Export may_create() so that btrfs can use it and with the less generic
name may_create_dentry().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/namei.c         | 19 ++++++++++---------
 include/linux/fs.h |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 28aebc786e8f..676b8c016839 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3657,8 +3657,8 @@ EXPORT_SYMBOL(may_delete_dentry);
  *  4. We should have write and exec permissions on dir
  *  5. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct mnt_idmap *idmap,
-			     struct inode *dir, struct dentry *child)
+int may_create_dentry(struct mnt_idmap *idmap,
+		      struct inode *dir, struct dentry *child)
 {
 	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
 	if (child->d_inode)
@@ -3670,6 +3670,7 @@ static inline int may_create(struct mnt_idmap *idmap,
 
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
+EXPORT_SYMBOL(may_create_dentry);
 
 // p1 != p2, both are on the same filesystem, ->s_vfs_rename_mutex is held
 static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
@@ -4116,7 +4117,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	struct inode *dir = d_inode(dentry->d_parent);
 	int error;
 
-	error = may_create(idmap, dir, dentry);
+	error = may_create_dentry(idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -4142,7 +4143,7 @@ int vfs_mkobj(struct dentry *dentry, umode_t mode,
 		void *arg)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	int error = may_create(&nop_mnt_idmap, dir, dentry);
+	int error = may_create_dentry(&nop_mnt_idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -4961,7 +4962,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	      struct delegated_inode *delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
-	int error = may_create(idmap, dir, dentry);
+	int error = may_create_dentry(idmap, dir, dentry);
 
 	if (error)
 		return error;
@@ -5107,7 +5108,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
-	error = may_create(idmap, dir, dentry);
+	error = may_create_dentry(idmap, dir, dentry);
 	if (error)
 		goto err;
 
@@ -5497,7 +5498,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int error;
 
-	error = may_create(idmap, dir, dentry);
+	error = may_create_dentry(idmap, dir, dentry);
 	if (error)
 		return error;
 
@@ -5605,7 +5606,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(idmap, dir, new_dentry);
+	error = may_create_dentry(idmap, dir, new_dentry);
 	if (error)
 		return error;
 
@@ -5822,7 +5823,7 @@ int vfs_rename(struct renamedata *rd)
 		return error;
 
 	if (!target) {
-		error = may_create(rd->mnt_idmap, new_dir, new_dentry);
+		error = may_create_dentry(rd->mnt_idmap, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 319aaeb876fd..558056e1e843 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2659,6 +2659,8 @@ int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 
 int may_delete_dentry(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir);
+int may_create_dentry(struct mnt_idmap *idmap,
+		      struct inode *dir, struct dentry *child);
 
 static inline bool execute_ok(struct inode *inode)
 {
-- 
2.47.2


