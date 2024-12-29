Return-Path: <linux-fsdevel+bounces-38215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CE9FDDEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8471A7A1343
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB970810;
	Sun, 29 Dec 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nD+PxA5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96729405
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459947; cv=none; b=KWQAkYrA19rSme7lrLbf/SAMJ30pw3Ar2+qEM8nI566w7eI+R+YcwTtIsrzrhIr23gedBw1FHunt9uR+0L8InDB4xqkiEavFg5YnZqjVqyAXcZtl2z4yZqPCv+TcogG74la6SgIS2NX0PlqAP0ctKz0T1YY7XhdcJYVW3huTD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459947; c=relaxed/simple;
	bh=mF1DYcKwmwmj0cdZ2PLb24xaC2VuFVDOvA0YG1a0YLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq6cfzXvVrMRZ0B8MerW0lqCE+0C7Hbd3/Ee58ZFgWGCNQQQC4lh431zoRph8rhCZtEeWuu37Rmrj7WtnXU6kiaD+/KDPftLXqvLAX4Mqc+q5p+uFeqm1hUseIycDB9uC7iNR11mJwwpq8B0t7fyqNHriY29/E6v1iJEG+keDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nD+PxA5g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=217eNT9h1MysEDLiZAZMgWoFtig9G2cqVr6UBldbtB4=; b=nD+PxA5gt4mh/IDloujhPvSbEr
	w678ifa2MQLAudTJV/7MD0NRrlaHJ6xr+aOwk+EMliGSPrkcCBom1lqkqcYG3dgxojqnvIJ1Kl5DG
	MUFGBa4/92J1y/w1GIRSwl/vbaX7833UdQCf3hH9nRm3oGKbwFZao0WYQvemdBfIrqDjti6knicl3
	Cjc5xTTBJIZjdFY9Vx/WZe0GW+NJHI73ptdFyxCG1e3F2aoUX87PkGl/mt39cbKkWenXQhyu3+ZHS
	G1n3yrRkrAzHISj5s/Nr2KT3gPvgoVmJLyPAAmJXLhxYIMzmlGsdguUWkV+Xf1yFooTLTOOepEL6a
	Rp2g/BwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPP-0000000DOht-2ziG;
	Sun, 29 Dec 2024 08:12:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 03/20] debugfs: move ->automount into debugfs_inode_info
Date: Sun, 29 Dec 2024 08:12:06 +0000
Message-ID: <20241229081223.3193228-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and don't bother with debugfs_fsdata for those.  Life's
simpler that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c    | 21 +++++----------------
 fs/debugfs/internal.h | 19 +++++++++----------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 6194c1cd87b9..82155dc0bff3 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -246,8 +246,8 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
-	if (fsd && (fsd->real_fops || fsd->short_fops)) {
+	/* check it wasn't a dir or automount (no fsdata) */
+	if (fsd) {
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
@@ -257,9 +257,9 @@ static void debugfs_release_dentry(struct dentry *dentry)
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+	struct inode *inode = path->dentry->d_inode;
 
-	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
+	return DEBUGFS_I(inode)->automount(path->dentry, inode->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -645,23 +645,13 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
-	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
-	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
-	if (!fsd) {
-		failed_creating(dentry);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	fsd->automount = f;
-
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
-		kfree(fsd);
 		return ERR_PTR(-EPERM);
 	}
 
@@ -669,14 +659,13 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
 		       name);
-		kfree(fsd);
 		return failed_creating(dentry);
 	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = fsd;
+	DEBUGFS_I(inode)->automount = f;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 0926d865cd81..a0d9eb3fa67d 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -13,6 +13,9 @@ struct file_operations;
 
 struct debugfs_inode_info {
 	struct inode vfs_inode;
+	union {
+		debugfs_automount_t automount;
+	};
 };
 
 static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
@@ -28,17 +31,13 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
 	const struct debugfs_short_fops *short_fops;
-	union {
-		/* automount_fn is used when real_fops is NULL */
-		debugfs_automount_t automount;
-		struct {
-			refcount_t active_users;
-			struct completion active_users_drained;
+	struct {
+		refcount_t active_users;
+		struct completion active_users_drained;
 
-			/* protect cancellations */
-			struct mutex cancellations_mtx;
-			struct list_head cancellations;
-		};
+		/* protect cancellations */
+		struct mutex cancellations_mtx;
+		struct list_head cancellations;
 	};
 };
 
-- 
2.39.5


