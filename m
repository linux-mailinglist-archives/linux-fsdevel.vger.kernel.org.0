Return-Path: <linux-fsdevel+bounces-55064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050EB06ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899FC3BFD26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3E1C5D5A;
	Wed, 16 Jul 2025 00:47:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BE1B87EB;
	Wed, 16 Jul 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626864; cv=none; b=bMuACYza1M+4httLuggYewVFFRvCVWHo5C4qGjTR05RymQToM+Ov+uGoaMBApQrhbmZRXI+dUxOuwpH51PvrIO5uWCO6ce6P+JBCKFlGCPs3R7FpEW0+w2nkVxEcR4S27yRQ33P0M9EolreHy0Ep7UWtKcJCY4zTtYoRZRX47XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626864; c=relaxed/simple;
	bh=vq8EMbP1jGnyTVsMFGLxuACTO+2h+l8rtZgziuw8tQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp23cuLZwAr7ijm02mM9VZYK9RzUiTSW2Jk74+rONcp1uSXZpwG08qQpMAzm/NRRPGTCoxR6T9X4aqEYzw2dSdXY/KSmCxxBmKpPtIDYEtlYkPghCWvySszyetf+jtd0YsiW0oKwegl833uGShaUSKeiN4E2CWuT8ethjigFeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ9-002ABq-NR;
	Wed, 16 Jul 2025 00:47:41 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 17/21] ovl: change ovl_cleanup_and_whiteout() to take rename lock as needed
Date: Wed, 16 Jul 2025 10:44:28 +1000
Message-ID: <20250716004725.1206467-18-neil@brown.name>
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

Rather than locking the directory(s) before calling
ovl_cleanup_and_whiteout(), change it (and ovl_whiteout()) to do the
locking, so the locking can be fine grained as will be needed for
proposed locking changes.

Sometimes this is called to whiteout something in the index dir, in
which case only that dir must be locked.  In one case it is called on
something in an upperdir, so two directories must be locked.  We use
ovl_lock_rename_workdir() for this and remove the restriction that
upperdir cannot be indexdir - because now sometimes it is.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c     | 20 +++++++++-----------
 fs/overlayfs/readdir.c |  6 +-----
 fs/overlayfs/util.c    | 12 ++----------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 340f8679b6e7..6a70faeee6fa 100644
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
 
@@ -783,16 +786,11 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
-	if (err)
-		goto out_dput_upper;
-
 	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
 	if (!err)
 		ovl_dir_modified(dentry->d_parent, true);
 
 	d_drop(dentry);
-	unlock_rename(workdir, upperdir);
 out_dput_upper:
 	dput(upper);
 out_dput:
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e2d0c314df6c..ecbf39a49d57 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1230,11 +1230,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
-			err = ovl_parent_lock(indexdir, index);
-			if (!err) {
-				err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
-				ovl_parent_unlock(indexdir);
-			}
+			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
 			err = ovl_cleanup_unlocked(ofs, indexdir, index);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b06136bbe170..3df0f3efe592 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1112,12 +1112,8 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		index = NULL;
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
-		err = ovl_parent_lock(indexdir, index);
-		if (!err) {
-			err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
-						       indexdir, index);
-			ovl_parent_unlock(indexdir);
-		}
+		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
+					       indexdir, index);
 	} else {
 		/* Cleanup orphan index entries */
 		err = ovl_cleanup_unlocked(ofs, indexdir, index);
@@ -1225,10 +1221,6 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
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


