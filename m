Return-Path: <linux-fsdevel+bounces-72840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A68D045BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D644F324BD17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E984963CE;
	Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNvRcuTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBE48165D;
	Thu,  8 Jan 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879449; cv=none; b=XtcKMPTvx1NsAxOdY0FFYQgotDzSBwchTOW+f66QzJLtnEtnKvR1BXhyi8HzUbewK9RbWZJqj9sem+48bufikfVpUps6poWgvFSXjR4mUOvtYEDH8kmD6cfwjdIOUYaXHpnFjjs+5qyXapKbWebLypsYVP3eevJ2i1dPQbwmV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879449; c=relaxed/simple;
	bh=Wt6Yh87897ZptxoyPPMHRcb5zb0qjabk75+t0+TezLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6MgEfqGIYWdrcgyunl10jf9LZVeGVpEo5yJDTIXplrka+0wW97ne/JXnJfSBbV9muMHVu0i//suoP4dlr3rzlN4j30eyrcxOncj057OYgO7TbdXyJg53AMMHoazyqpGHAYPgMU/2Mw5yLNf2YY5krL96jADRhDUEqRythhR3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNvRcuTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA5C19422;
	Thu,  8 Jan 2026 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879449;
	bh=Wt6Yh87897ZptxoyPPMHRcb5zb0qjabk75+t0+TezLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNvRcuTOs69GlvJyHflyZPmnfZShIj/eUF7HaVwGluyJspEUFdEzLf7Gk3cRYcUOj
	 abgz6L8gXt4evXrbqBWCt/zqtv3LdX2552DAvI3aQVeD4pp+oV3NEFtnGzof/Tudx0
	 SMXBVn40M9ZBMJkZLDCS0XgQZN1ttjvKlgI0PZk8TPfvTB4Z2wzd+8XJ2Q5syLfOdD
	 wyT4wCSlEGpKCTx+NnAEEUBO/+VWSr+I/9bsBoxGYlZBl5bUOq3ctfBkTnAZOTuJum
	 qjEnOJNDS5cXdeP+TS/q2v0hEsV5Q+76BFvzZ/NOdgQLB6/UGaLkyD6SMSt8RSGzpE
	 8TujJ+HNCCS6w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4] fs: export may_create() as may_create_dentry()
Date: Thu,  8 Jan 2026 13:35:32 +0000
Message-ID: <ce5174bca079f4cdcbb8dd145f0924feb1f227cd.1767801889.git.fdmanana@suse.com>
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


