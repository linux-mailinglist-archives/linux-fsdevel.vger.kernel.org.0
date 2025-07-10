Return-Path: <linux-fsdevel+bounces-54575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF0B00F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33DA1CA3ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6C2D3EFD;
	Thu, 10 Jul 2025 23:21:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485D2BE7CB;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189695; cv=none; b=qYTihv5y7KW7kDRurkGi7EfZuLYqepDzhC38fFGNH5lDqdS5v9obeCAAHqYh4zK53UbpyJoqzjBs37PxNXlI9S7j3B5Hy/rbHPAlT/3DD2ieC5pQSuGEQ5BQVZSp6HwNyEwjTewU9hrP6jnoIF0MUvQSQX0K+y+mKIQXterV0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189695; c=relaxed/simple;
	bh=3QbTVgQq8wp7WBeKhXaTTP4PVdGzjV1VA3EyVBQY/p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX7HGs6t9+PbJrr2heEOZrOZLUmtRM2zasnGK138moFOMMZv/3BFQUhvA9Z0PGMBhNisH5J/4xLds4ECFqVw1wPixzW1mhE9brY3HI8bxFSL49rsabDtn1xqVOg9vspF6/sRxdxGOXdOFMortKVlixpr4e7EpU3Mqp3LSGXjo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zv-001XGy-Kk;
	Thu, 10 Jul 2025 23:21:25 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/20] ovl: change ovl_workdir_cleanup() to take dir lock as needed.
Date: Fri, 11 Jul 2025 09:03:44 +1000
Message-ID: <20250710232109.3014537-15-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than calling ovl_workdir_cleanup() with the dir already locked,
change it to take the dir lock only when needed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/readdir.c   | 30 +++++++++++++-----------------
 fs/overlayfs/super.c     |  4 +---
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ec804d6bb2ef..ca74be44dddd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -738,7 +738,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 void ovl_cache_free(struct list_head *list);
 void ovl_dir_cache_free(struct inode *inode);
 int ovl_check_d_type_supported(const struct path *realpath);
-int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
+int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 			struct vfsmount *mnt, struct dentry *dentry, int level);
 int ovl_indexdir_cleanup(struct ovl_fs *ofs);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b3d44bf56c78..6cc5f885e036 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1096,7 +1096,6 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 				       int level)
 {
 	int err;
-	struct inode *dir = path->dentry->d_inode;
 	LIST_HEAD(list);
 	struct ovl_cache_entry *p;
 	struct ovl_readdir_data rdd = {
@@ -1139,11 +1138,9 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 		dentry = ovl_lookup_upper_unlocked(ofs, p->name, path->dentry, p->len);
 		if (IS_ERR(dentry))
 			continue;
-		if (dentry->d_inode) {
-			inode_lock_nested(dir, I_MUTEX_PARENT);
-			err = ovl_workdir_cleanup(ofs, dir, path->mnt, dentry, level);
-			inode_unlock(dir);
-		}
+		if (dentry->d_inode)
+			err = ovl_workdir_cleanup(ofs, path->dentry, path->mnt,
+						  dentry, level);
 		dput(dentry);
 		if (err)
 			break;
@@ -1153,24 +1150,25 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	return err;
 }
 
-int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
+int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 			struct vfsmount *mnt, struct dentry *dentry, int level)
 {
 	int err;
 
-	if (!d_is_dir(dentry) || level > 1) {
-		return ovl_cleanup(ofs, dir, dentry);
-	}
+	if (!d_is_dir(dentry) || level > 1)
+		return ovl_cleanup_unlocked(ofs, parent, dentry);
 
-	err = ovl_do_rmdir(ofs, dir, dentry);
+	err = parent_lock(parent, dentry);
+	if (err)
+		return err;
+	err = ovl_do_rmdir(ofs, parent->d_inode, dentry);
+	parent_unlock(parent);
 	if (err) {
 		struct path path = { .mnt = mnt, .dentry = dentry };
 
-		inode_unlock(dir);
 		err = ovl_workdir_cleanup_recurse(ofs, &path, level + 1);
-		inode_lock_nested(dir, I_MUTEX_PARENT);
 		if (!err)
-			err = ovl_cleanup(ofs, dir, dentry);
+			err = ovl_cleanup_unlocked(ofs, parent, dentry);
 	}
 
 	return err;
@@ -1210,9 +1208,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		}
 		/* Cleanup leftover from index create/cleanup attempt */
 		if (index->d_name.name[0] == '#') {
-			inode_lock_nested(dir, I_MUTEX_PARENT);
-			err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
-			inode_unlock(dir);
+			err = ovl_workdir_cleanup(ofs, indexdir, path.mnt, index, 1);
 			if (err)
 				break;
 			goto next;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 239ae1946edf..23f43f8131dd 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -319,9 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 				goto out;
 
 			retried = true;
-			inode_lock_nested(dir, I_MUTEX_PARENT);
-			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
-			inode_unlock(dir);
+			err = ovl_workdir_cleanup(ofs, ofs->workbasedir, mnt, work, 0);
 			dput(work);
 			if (err == -EINVAL) {
 				work = ERR_PTR(err);
-- 
2.49.0


