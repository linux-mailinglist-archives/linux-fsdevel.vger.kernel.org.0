Return-Path: <linux-fsdevel+bounces-52830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FCAE72E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B3E5A3CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412425BEEC;
	Tue, 24 Jun 2025 23:07:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387125CC5D;
	Tue, 24 Jun 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806442; cv=none; b=B+rFuYO+noYZO0ZVSnzyoIy6Z8amD5VUcByCNrLb/bivmKAmlJaBfsTaE82BWUJeFdI8JBhRlRQkaiMF4Lrm9ITxzg/n+tog8iOfpDSZjpyudR2Se6hM+4qqH63avXNgRC+gXdxqmRkctXishlzlyEMJog2lDwA2ssrhvitZiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806442; c=relaxed/simple;
	bh=iUVEklrtkaq4dKuIywXOr7zXPJxqhttChONuC8AUeAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFwmOsR8CfvjoDYQKXiZVkOM9AoSO50yBwk+uJUeKYyt0TGtvryAi6BRGyd6rL4S6T3jNPjiLXRlUIh1NRPZmJScRjOEz7HjkviIwyRQb6mghQpl2JMuUE70REvMVe+11QLK5CgaLBRsIQuR0eNsVXBkJUPAsGWgKwc2Cy82qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjW-0045d0-Mo;
	Tue, 24 Jun 2025 23:07:18 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
Date: Wed, 25 Jun 2025 08:55:08 +1000
Message-ID: <20250624230636.3233059-13-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
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
 fs/overlayfs/copy_up.c   |  4 +--
 fs/overlayfs/dir.c       | 55 ++++++++++++++++++----------------------
 fs/overlayfs/overlayfs.h |  3 +--
 fs/overlayfs/readdir.c   | 10 ++++----
 fs/overlayfs/super.c     |  4 +--
 fs/overlayfs/util.c      |  2 +-
 6 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 884c738b67ff..baaa46d00de6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -569,7 +569,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	unlock_rename(indexdir, indexdir);
 out:
 	if (err)
-		ovl_cleanup_unlocked(ofs, indexdir, temp);
+		ovl_cleanup(ofs, indexdir, temp);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -856,7 +856,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 cleanup:
 	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
 	goto out;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 9a43ab23cf01..77a09b0190a2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -24,16 +24,24 @@ MODULE_PARM_DESC(redirect_max,
 
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
+	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
+	if (wdentry->d_parent == workdir) {
+		struct inode *wdir = workdir->d_inode;
+
+		dget(wdentry);
+		if (d_is_dir(wdentry))
+			err = ovl_do_rmdir(ofs, wdir, wdentry);
+		else
+			err = ovl_do_unlink(ofs, wdir, wdentry);
+		dput(wdentry);
+	} else
+		err = -EINVAL;
+	inode_unlock(workdir->d_inode);
 
 	if (err) {
 		pr_err("cleanup of '%pd2' failed (%i)\n",
@@ -43,21 +51,6 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
-			 struct dentry *wdentry)
-{
-	int err;
-
-	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
-	if (wdentry->d_parent == workdir)
-		ovl_cleanup(ofs, workdir->d_inode, wdentry);
-	else
-		err = -EINVAL;
-	inode_unlock(workdir->d_inode);
-
-	return err;
-}
-
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 {
 	struct dentry *temp;
@@ -153,14 +146,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
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
 
@@ -357,7 +350,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	return err;
 
 out_cleanup:
-	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+	ovl_cleanup(ofs, upperdir, newdentry);
 	dput(newdentry);
 	goto out;
 }
@@ -422,7 +415,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	unlock_rename(workdir, upperdir);
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup_unlocked(ofs, workdir, upper);
+	ovl_cleanup(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
@@ -432,7 +425,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 out_cleanup:
 	unlock_rename(workdir, upperdir);
 out_cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, workdir, opaquedir);
+	ovl_cleanup(ofs, workdir, opaquedir);
 	dput(opaquedir);
 out:
 	return ERR_PTR(err);
@@ -527,7 +520,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		ovl_cleanup_unlocked(ofs, workdir, upper);
+		ovl_cleanup(ofs, workdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		unlock_rename(workdir, upperdir);
@@ -537,7 +530,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
-		ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+		ovl_cleanup(ofs, upperdir, newdentry);
 		dput(newdentry);
 	}
 out_dput:
@@ -552,7 +545,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 out_cleanup_locked:
 	unlock_rename(workdir, upperdir);
 out_cleanup:
-	ovl_cleanup_unlocked(ofs, workdir, newdentry);
+	ovl_cleanup(ofs, workdir, newdentry);
 	dput(newdentry);
 	goto out_dput;
 }
@@ -1279,7 +1272,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	unlock_rename(new_upperdir, old_upperdir);
 
 	if (cleanup_whiteout)
-		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
+		ovl_cleanup(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 3d89e1c8d565..2f09c3c825f2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -851,8 +851,7 @@ struct ovl_cattr {
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
index fd98444dacef..9af73da04d2a 100644
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
@@ -1159,7 +1159,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 	int err;
 
 	if (!d_is_dir(dentry) || level > 1) {
-		return ovl_cleanup_unlocked(ofs, parent, dentry);
+		return ovl_cleanup(ofs, parent, dentry);
 	}
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
@@ -1173,7 +1173,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 
 		err = ovl_workdir_cleanup_recurse(ofs, &path, level + 1);
 		if (!err)
-			err = ovl_cleanup_unlocked(ofs, parent, dentry);
+			err = ovl_cleanup(ofs, parent, dentry);
 	}
 
 	return err;
@@ -1224,7 +1224,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup_unlocked(ofs, indexdir, index);
+			err = ovl_cleanup(ofs, indexdir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1240,7 +1240,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup_unlocked(ofs, indexdir, index);
+			err = ovl_cleanup(ofs, indexdir, index);
 		}
 
 		if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1ba1bffc4547..6dbfbad8aeca 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -594,11 +594,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
index 565f7d8c0147..b2c3e7be957b 100644
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
-- 
2.49.0


