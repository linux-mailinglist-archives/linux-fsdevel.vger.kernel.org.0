Return-Path: <linux-fsdevel+bounces-55068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92992B06AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BC74A0D22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF31D5151;
	Wed, 16 Jul 2025 00:47:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A56191F91;
	Wed, 16 Jul 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626868; cv=none; b=qrwim6qvWmV1MQUaVF5hZOuJn5+oXTZ+NZ+ctQzCyB0G7gRUWJ9G5spRG4ZAwLtu/LmeKuyMYxZjAvn+zpgW9YS7dHT3OxSo9AbmCJUOxdHfpIdcdbjQtKQ2wgUUDB4R+4+fIdd6Oy7P6C2RFvEygQjCuwVfIzw1Ao4EMQBqDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626868; c=relaxed/simple;
	bh=c6Mt4Lk1PjH9Jsh9NbGPjoFSR5VJjwwXA/5IhSwrUg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUF0AL4+kFPJxZzuyR+I+2d1OxdBGUC1zbIOkuWf6DiQF9256sw47QrvBmmfg8z2d1mgEff2SC0VnaNSM4VBCfh3FhLAWdIaIkRfv/4CkEwoCWWeZ6jE9px9XKGtBpl7XmD76hHHw3vrFYzbLJB9hH8Hs3kPXqFR9l9HveauS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJD-002ACL-JN;
	Wed, 16 Jul 2025 00:47:45 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 21/21] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
Date: Wed, 16 Jul 2025 10:44:32 +1000
Message-ID: <20250716004725.1206467-22-neil@brown.name>
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

The only remaining user of ovl_cleanup() is ovl_cleanup_locked(), so we
no longer need both.

This patch renames ovl_cleanup() to ovl_cleanup_locked() and makes it
static.
ovl_cleanup_unlocked() is renamed to ovl_cleanup().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   |  4 ++--
 fs/overlayfs/dir.c       | 27 ++++++++++++++-------------
 fs/overlayfs/overlayfs.h |  3 +--
 fs/overlayfs/readdir.c   | 10 +++++-----
 fs/overlayfs/super.c     |  4 ++--
 fs/overlayfs/util.c      |  2 +-
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8f8dbe8a1d54..c4d7c281d473 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -569,7 +569,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	ovl_parent_unlock(indexdir);
 out:
 	if (err)
-		ovl_cleanup_unlocked(ofs, indexdir, temp);
+		ovl_cleanup(ofs, indexdir, temp);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -854,7 +854,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 cleanup:
 	unlock_rename(c->workdir, c->destdir);
 cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	ovl_cleanup(ofs, c->workdir, temp);
 	dput(temp);
 	goto out;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index dedf89546e5f..30619777f0f6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -24,7 +24,8 @@ MODULE_PARM_DESC(redirect_max,
 
 static int ovl_set_redirect(struct dentry *dentry, bool samedir);
 
-int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
+static int ovl_cleanup_locked(struct ovl_fs *ofs, struct inode *wdir,
+			      struct dentry *wdentry)
 {
 	int err;
 
@@ -43,8 +44,8 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
-			 struct dentry *wdentry)
+int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
+		struct dentry *wdentry)
 {
 	int err;
 
@@ -52,7 +53,7 @@ int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
 	if (err)
 		return err;
 
-	ovl_cleanup(ofs, workdir->d_inode, wdentry);
+	ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
 	ovl_parent_unlock(workdir);
 
 	return 0;
@@ -149,14 +150,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
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
 
@@ -351,7 +352,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	return 0;
 
 out_cleanup:
-	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+	ovl_cleanup(ofs, upperdir, newdentry);
 	dput(newdentry);
 	return err;
 }
@@ -411,7 +412,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_cleanup_unlocked;
 
 	ovl_cleanup_whiteouts(ofs, upper, list);
-	ovl_cleanup_unlocked(ofs, workdir, upper);
+	ovl_cleanup(ofs, workdir, upper);
 
 	/* dentry's upper doesn't match now, get rid of it */
 	d_drop(dentry);
@@ -421,7 +422,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 out_cleanup:
 	unlock_rename(workdir, upperdir);
 out_cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, workdir, opaquedir);
+	ovl_cleanup(ofs, workdir, opaquedir);
 	dput(opaquedir);
 out:
 	return ERR_PTR(err);
@@ -516,7 +517,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup_unlocked;
 
-		ovl_cleanup_unlocked(ofs, workdir, upper);
+		ovl_cleanup(ofs, workdir, upper);
 	} else {
 		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
 		unlock_rename(workdir, upperdir);
@@ -526,7 +527,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	ovl_dir_modified(dentry->d_parent, false);
 	err = ovl_instantiate(dentry, inode, newdentry, hardlink, NULL);
 	if (err) {
-		ovl_cleanup_unlocked(ofs, upperdir, newdentry);
+		ovl_cleanup(ofs, upperdir, newdentry);
 		dput(newdentry);
 	}
 out_dput:
@@ -541,7 +542,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 out_cleanup:
 	unlock_rename(workdir, upperdir);
 out_cleanup_unlocked:
-	ovl_cleanup_unlocked(ofs, workdir, newdentry);
+	ovl_cleanup(ofs, workdir, newdentry);
 	dput(newdentry);
 	goto out_dput;
 }
@@ -1268,7 +1269,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		goto out_revert_creds;
 
 	if (cleanup_whiteout)
-		ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
+		ovl_cleanup(ofs, old_upperdir, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b1e31e060157..56de6e83d24e 100644
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
index ecbf39a49d57..b65cdfce31ce 100644
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
 
 	err = ovl_parent_lock(parent, dentry);
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
index 9fd0b3acd1a4..4afa91882075 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -600,11 +600,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
index 3df0f3efe592..62f809cf8ba9 100644
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


