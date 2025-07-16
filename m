Return-Path: <linux-fsdevel+bounces-55062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF845B06AE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E496A173263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986B189513;
	Wed, 16 Jul 2025 00:47:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380E1B4121;
	Wed, 16 Jul 2025 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626862; cv=none; b=BBhcTmgyVgfycsM6mS0OBGcPmrkVSJCv09FZCHZe2MXt0eqvEyCYGC/+O7MDiuuQ4e3hlnWmVZVK3OhLy3LybmCA8Zk/VDADaJzYdISh5tuSCsQ53BbPQGOG5YCwf347Ra+DQcXg9xPQMLDp+hJYyEzCcfaFlJdDyd/rtA9ULMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626862; c=relaxed/simple;
	bh=xD1ZN3Bay6tha3W+1gJDOErZi6Qgz5JAyX8BjPeJ4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEZEJZnRuBdzfKdaQ0kAYCbtfwrWpgZxg05X2qDqDxQ/3kEJTkV4RQL/bAE/ttBPykL6d5QdlsoBYsl9yG0rh/BZVH/62/eWeMH3U11oi7dcheWiA1o8HDAnR7iB9xjxJnfmVtl+RIXZir8/+KesbG83usyKeVFjMptpyTGAGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ7-002ABe-Qn;
	Wed, 16 Jul 2025 00:47:39 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 15/21] ovl: change ovl_workdir_cleanup() to take dir lock as needed.
Date: Wed, 16 Jul 2025 10:44:26 +1000
Message-ID: <20250716004725.1206467-16-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than calling ovl_workdir_cleanup() with the dir already locked,
change it to take the dir lock only when needed.

Also change ovl_workdir_cleanup() to take a dentry for the parent rather
than an inode.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/readdir.c   | 36 +++++++++++++-----------------------
 fs/overlayfs/super.c     |  6 +-----
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index cff5bb625e9d..f6023442a45c 100644
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
index b0f9e5a00c1a..e2d0c314df6c 100644
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
@@ -1139,14 +1138,9 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 		dentry = ovl_lookup_upper_unlocked(ofs, p->name, path->dentry, p->len);
 		if (IS_ERR(dentry))
 			continue;
-		if (dentry->d_inode) {
-			err = ovl_parent_lock(path->dentry, dentry);
-			if (!err) {
-				err = ovl_workdir_cleanup(ofs, dir, path->mnt,
-							  dentry, level);
-				ovl_parent_unlock(path->dentry);
-			}
-		}
+		if (dentry->d_inode)
+			err = ovl_workdir_cleanup(ofs, path->dentry, path->mnt,
+						  dentry, level);
 		dput(dentry);
 		if (err)
 			break;
@@ -1156,24 +1150,25 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
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
+	err = ovl_parent_lock(parent, dentry);
+	if (err)
+		return err;
+	err = ovl_do_rmdir(ofs, parent->d_inode, dentry);
+	ovl_parent_unlock(parent);
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
@@ -1184,7 +1179,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	int err;
 	struct dentry *indexdir = ofs->workdir;
 	struct dentry *index = NULL;
-	struct inode *dir = indexdir->d_inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = indexdir };
 	LIST_HEAD(list);
 	struct ovl_cache_entry *p;
@@ -1213,11 +1207,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		}
 		/* Cleanup leftover from index create/cleanup attempt */
 		if (index->d_name.name[0] == '#') {
-			err = ovl_parent_lock(indexdir, index);
-			if (!err) {
-				err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
-				ovl_parent_unlock(indexdir);
-			}
+			err = ovl_workdir_cleanup(ofs, indexdir, path.mnt, index, 1);
 			if (err)
 				break;
 			goto next;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cb2551a155d8..4c3736bf2db4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -319,11 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 				return work;
 
 			retried = true;
-			err = ovl_parent_lock(ofs->workbasedir, work);
-			if (!err) {
-				err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
-				ovl_parent_unlock(ofs->workbasedir);
-			}
+			err = ovl_workdir_cleanup(ofs, ofs->workbasedir, mnt, work, 0);
 			dput(work);
 			if (err == -EINVAL)
 				return ERR_PTR(err);
-- 
2.49.0


