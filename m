Return-Path: <linux-fsdevel+bounces-54565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E0AB00F84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F3F1CA3516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE72D29A9;
	Thu, 10 Jul 2025 23:21:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE22BEFFF;
	Thu, 10 Jul 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189692; cv=none; b=d0NQ6kOeEPRUbxkcmT4l0NwL0gni4AaI9Nmbvl2wJcakDAlh6hrMw6Wx8aPjndNdTGsLssQr8EtP6jodedPzaHcugg52m8qBX/4ZtYqnO9qqRXG34gkHUgRoJLZX2x6VVtVHgcVoKCXHF8jVFi6Bqnxd1OWBYjhwissqP4RSK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189692; c=relaxed/simple;
	bh=cvlH1oiikmqZK8toYpBEgVpq62Q2TA/9RcJhChfkIbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivKYTEff7++PVrdmtv3+A29Vyofy9/0HvOohS+C4JqhEwBSt0RMgysE60yklHStpMDrdjhO6dwzqrmhiY1fJjYgM0xhJ/g8z34y/CDw3bZZymmk+Wx1MSu7AD0HKzvqTbkcXr116luuAA0z7839K2EQDKg67/DKRrsN+GjwYO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zy-001XHY-F0;
	Thu, 10 Jul 2025 23:21:28 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/20] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
Date: Fri, 11 Jul 2025 09:03:50 +1000
Message-ID: <20250710232109.3014537-21-neil@brown.name>
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

The only remaining user of ovl_cleanup() is ovl_cleanup_locked(), so we
no longer need both.

This patch moves ovl_cleanup() code into ovl_cleanup_locked(), and then
renames ovl_cleanup_locked() to ovl_cleanup().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   |  6 ++---
 fs/overlayfs/dir.c       | 52 ++++++++++++++++------------------------
 fs/overlayfs/overlayfs.h |  3 +--
 fs/overlayfs/readdir.c   | 10 ++++----
 fs/overlayfs/super.c     |  4 ++--
 fs/overlayfs/util.c      |  2 +-
 6 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7b84a39c081f..f345f2899ccf 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -570,7 +570,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	parent_unlock(indexdir);
 out:
 	if (err)
-		ovl_cleanup_unlocked(ofs, indexdir, temp);
+		ovl_cleanup(ofs, indexdir, temp);
 	ovl_end_write(dentry);
 	dput(temp);
 free_name:
@@ -856,13 +856,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 cleanup:
 	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
 	goto out;
 
 cleanup_need_write:
 	ovl_start_write(c->dentry);
-	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	ovl_cleanup(ofs, c->workdir, temp);
 	ovl_end_write(c->dentry);
 	dput(temp);
 	return err;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 58078ce67d6a..7e7f701c7ae4 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -24,16 +24,21 @@ MODULE_PARM_DESC(redirect_max,
 
 static int ovl_set_redirect(struct dentry *dentry, bool samedir);
 
-int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
+int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
+			 struct dentry *wdentry)
 {
 	int err;
 
-	dget(wdentry);
-	if (d_is_dir(wdentry))
-		err = ovl_do_rmdir(ofs, wdir, wdentry);
-	else
-		err = ovl_do_unlink(ofs, wdir, wdentry);
-	dput(wdentry);
+	err = parent_lock(workdir, wdentry);
+	if (!err) {
+		dget(wdentry);
+		if (d_is_dir(wdentry))
+			err = ovl_do_rmdir(ofs, workdir->d_inode, wdentry);
+		else
+			err = ovl_do_unlink(ofs, workdir->d_inode, wdentry);
+		dput(wdentry);
+		parent_unlock(workdir);
+	}
 
 	if (err) {
 		pr_err("cleanup of '%pd2' failed (%i)\n",
@@ -43,21 +48,6 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
-			 struct dentry *wdentry)
-{
-	int err;
-
-	err = parent_lock(workdir, wdentry);
-	if (err)
-		return err;
-
-	ovl_cleanup(ofs, workdir->d_inode, wdentry);
-	parent_unlock(workdir);
-
-	return err;
-}
-
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 {
 	struct dentry *temp;
@@ -148,14 +138,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (err)
 		goto kill_whiteout;
 	if (flags)
-		ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
+		ovl_cleanup(ofs, ofs->workdir, dentry);
 
 out:
 	dput(whiteout);
 	return err;
 
 kill_whiteout:
-	ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
+	ovl_cleanup(ofs, ofs->workdir, whiteout);
 	goto out;
 }
 
@@ -350,7 +340,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	return 0;
 
 out_cleanup:
-	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+	ovl_cleanup(ofs, upperdir, newdentry);
 	dput(newdentry);
 	return err;
 }
@@ -409,7 +399,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	unlock_rename(workdir, upperdir);
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup_unlocked(ofs, workdir, upper);
+	ovl_cleanup(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
@@ -419,7 +409,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 out_cleanup:
 	unlock_rename(workdir, upperdir);
 out_cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, workdir, opaquedir);
+	ovl_cleanup(ofs, workdir, opaquedir);
 	dput(opaquedir);
 out:
 	return ERR_PTR(err);
@@ -514,7 +504,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		ovl_cleanup_unlocked(ofs, workdir, upper);
+		ovl_cleanup(ofs, workdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		unlock_rename(workdir, upperdir);
@@ -524,7 +514,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
-		ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+		ovl_cleanup(ofs, upperdir, newdentry);
 		dput(newdentry);
 	}
 out_dput:
@@ -539,7 +529,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 out_cleanup_locked:
 	unlock_rename(workdir, upperdir);
 out_cleanup:
-	ovl_cleanup_unlocked(ofs, workdir, newdentry);
+	ovl_cleanup(ofs, workdir, newdentry);
 	dput(newdentry);
 	goto out_dput;
 }
@@ -1266,7 +1256,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	unlock_rename(new_upperdir, old_upperdir);
 
 	if (cleanup_whiteout)
-		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
+		ovl_cleanup(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index bda25287c510..1bebfdcd4d90 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -857,8 +857,7 @@ struct ovl_cattr {
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct dentry *parent, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
-int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *dentry);
-int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
+int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 4127d1f160b3..5a05842c60c5 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1048,7 +1048,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 			continue;
 		}
 		if (dentry->d_inode)
-			ovl_cleanup_unlocked(ofs, upper, dentry);
+			ovl_cleanup(ofs, upper, dentry);
 		dput(dentry);
 	}
 }
@@ -1156,7 +1156,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 	int err;
 
 	if (!d_is_dir(dentry) || level > 1)
-		return ovl_cleanup_unlocked(ofs, parent, dentry);
+		return ovl_cleanup(ofs, parent, dentry);
 
 	err = parent_lock(parent, dentry);
 	if (err)
@@ -1168,7 +1168,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 
 		err = ovl_workdir_cleanup_recurse(ofs, &path, level + 1);
 		if (!err)
-			err = ovl_cleanup_unlocked(ofs, parent, dentry);
+			err = ovl_cleanup(ofs, parent, dentry);
 	}
 
 	return err;
@@ -1217,7 +1217,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup_unlocked(ofs, indexdir, index);
+			err = ovl_cleanup(ofs, indexdir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1233,7 +1233,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup_unlocked(ofs, indexdir, index);
+			err = ovl_cleanup(ofs, indexdir, index);
 		}
 
 		if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3c012c8f7c88..e3dd60c459e2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -603,11 +603,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 	/* Best effort cleanup of whiteout and temp file */
 	if (err)
-		ovl_cleanup_unlocked(ofs, workdir, whiteout);
+		ovl_cleanup(ofs, workdir, whiteout);
 	dput(whiteout);
 
 cleanup_temp:
-	ovl_cleanup_unlocked(ofs, workdir, temp);
+	ovl_cleanup(ofs, workdir, temp);
 	release_dentry_name_snapshot(&name);
 	dput(temp);
 	dput(dest);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 5218a477551b..c91c3a9187b0 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1116,7 +1116,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 					       indexdir, index);
 	} else {
 		/* Cleanup orphan index entries */
-		err = ovl_cleanup_unlocked(ofs, indexdir, index);
+		err = ovl_cleanup(ofs, indexdir, index);
 	}
 	if (err)
 		goto fail;
-- 
2.49.0


