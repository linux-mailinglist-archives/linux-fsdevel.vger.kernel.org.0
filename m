Return-Path: <linux-fsdevel+bounces-54559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9151B00F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AD73BA5AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3652C2ACE;
	Thu, 10 Jul 2025 23:21:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD029CB40;
	Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189690; cv=none; b=X74ywnofuPLuKZxG037lPvUVsNmEjxort+dX1QYV5KIZjwHCWZd5trVEnGnCkvyh9t2D3IJGMV445wCIrtEYh8PeAV5yp0HI2oe+ovKJwsT4GsPpKBbH0TMMTdrYoxCm0gtX+QAYuXn1gX3MFeMDtDeCh2t94CJTGcSiepLnxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189690; c=relaxed/simple;
	bh=p9l3AYV1I6kZ4Nn81L4FwB1yGq7882FIaQrtooZ39fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF3hsbU4q2T6PhismptXhm3fH3uXJnVXFJD1XnsOA3tXkDwsBoOa7rzKbd1UALK3c0tbxczszpX1aQI7zK09zMjCoOF5LAE32iJoSYjvjph6Dvjzb6KyGw0szKTNUaXOnBAFCRJSrYKpeswSP8Kg8KAki24vjVf+wh0sjSAApsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zw-001XHA-Jj;
	Thu, 10 Jul 2025 23:21:26 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/20] ovl: change ovl_cleanup_and_whiteout() to take rename lock as needed
Date: Fri, 11 Jul 2025 09:03:46 +1000
Message-ID: <20250710232109.3014537-17-neil@brown.name>
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

Rather than locking the directory(s) before calling
ovl_cleanup_and_whiteout(), change it (and ovl_whiteout()) to do the
locking, so the locking can be fine grained as will be needed for
proposed locking changes.

Sometimes this is called to whiteout something in the index dir, in
which case only that dir must be locked.  In one case it is called on
something in an upperdir, so two directories must be locked.  We use
ovl_lock_rename_workdir() for this and remove the restriction that
upperdir cannot be indexdir - because now sometimes it is.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c     | 20 +++++++++-----------
 fs/overlayfs/readdir.c |  3 ---
 fs/overlayfs/util.c    |  7 -------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8580cd5c61e4..086719129be3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -77,7 +77,6 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 	return temp;
 }
 
-/* caller holds i_mutex on workdir */
 static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 {
 	int err;
@@ -85,6 +84,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
 
+	inode_lock_nested(wdir, I_MUTEX_PARENT);
 	if (!ofs->whiteout) {
 		whiteout = ovl_lookup_temp(ofs, workdir);
 		if (IS_ERR(whiteout))
@@ -118,14 +118,13 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	whiteout = ofs->whiteout;
 	ofs->whiteout = NULL;
 out:
+	inode_unlock(wdir);
 	return whiteout;
 }
 
-/* Caller must hold i_mutex on both workdir and dir */
 int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 			     struct dentry *dentry)
 {
-	struct inode *wdir = ofs->workdir->d_inode;
 	struct dentry *whiteout;
 	int err;
 	int flags = 0;
@@ -138,18 +137,22 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
+	err = ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dentry);
+	if (!err) {
+		err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
+		unlock_rename(ofs->workdir, dir);
+	}
 	if (err)
 		goto kill_whiteout;
 	if (flags)
-		ovl_cleanup(ofs, wdir, dentry);
+		ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
 
 out:
 	dput(whiteout);
 	return err;
 
 kill_whiteout:
-	ovl_cleanup(ofs, wdir, whiteout);
+	ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
 	goto out;
 }
 
@@ -782,10 +785,6 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
-	if (err)
-		goto out_dput_upper;
-
 	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
 	if (err)
 		goto out_d_drop;
@@ -793,7 +792,6 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 	ovl_dir_modified(dentry->d_parent, true);
 out_d_drop:
 	d_drop(dentry);
-	unlock_rename(workdir, upperdir);
 out_dput_upper:
 	dput(upper);
 out_dput:
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 6cc5f885e036..4127d1f160b3 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1179,7 +1179,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	int err;
 	struct dentry *indexdir = ofs->workdir;
 	struct dentry *index = NULL;
-	struct inode *dir = indexdir->d_inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = indexdir };
 	LIST_HEAD(list);
 	struct ovl_cache_entry *p;
@@ -1231,9 +1230,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
-			inode_lock_nested(dir, I_MUTEX_PARENT);
 			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
-			inode_unlock(dir);
 		} else {
 			/* Cleanup orphan index entries */
 			err = ovl_cleanup_unlocked(ofs, indexdir, index);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7369193b11ec..5218a477551b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1071,7 +1071,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
-	struct inode *dir = indexdir->d_inode;
 	struct dentry *lowerdentry = ovl_dentry_lower(dentry);
 	struct dentry *upperdentry = ovl_dentry_upper(dentry);
 	struct dentry *index = NULL;
@@ -1113,10 +1112,8 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		index = NULL;
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
-		inode_lock_nested(dir, I_MUTEX_PARENT);
 		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
 					       indexdir, index);
-		inode_unlock(dir);
 	} else {
 		/* Cleanup orphan index entries */
 		err = ovl_cleanup_unlocked(ofs, indexdir, index);
@@ -1224,10 +1221,6 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
 {
 	struct dentry *trap;
 
-	/* Workdir should not be the same as upperdir */
-	if (workdir == upperdir)
-		goto err;
-
 	/* Workdir should not be subdir of upperdir and vice versa */
 	trap = lock_rename(workdir, upperdir);
 	if (IS_ERR(trap))
-- 
2.49.0


