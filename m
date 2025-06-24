Return-Path: <linux-fsdevel+bounces-52828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC823AE72E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E205172ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4525B313;
	Tue, 24 Jun 2025 23:07:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C07254AF0;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806441; cv=none; b=kUP1P3/KSB6rN8UKHLhfBdSi4poV74c7OwcBHUdrl6J4Y4QtmnPxG48mjU7dguXlOC/CZBNVrNuhz01RgV+Ko0fp/wn5o1EBcE71+m0dwnnUlVRXAioIflMTQdUvEs7udQqvNCuxlZ2Pf8IGAfG8cCnPcSENHc5H2kOmKwlVaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806441; c=relaxed/simple;
	bh=R3fI79ZD1ePnB6LW6FCY/oMXDVVTk0SNNV3MCyG06NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8+s/BQ7FMXw2tqasSJHKNLwgHdS73SqyhgCtshPET6RyfbJb6r41uwil0rnU3CJFizCvy1Mtbgzyv0gA+6p5RTd79gX117wLgxmcuA05phWVl/3pc8NlXjn9MJH7W8A+mqUbSzf1hNfqMKV6MNB76Ol3RsnzOQkttfLN638zI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjV-0045ch-44;
	Tue, 24 Jun 2025 23:07:17 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] ovl: whiteout locking changes
Date: Wed, 25 Jun 2025 08:55:05 +1000
Message-ID: <20250624230636.3233059-10-neil@brown.name>
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

ovl_writeout() relies on the workdir i_rwsem to provide exclusive access
to ofs->writeout which it manipulates.  Rather than depending on this,
add a new mutex, "writeout_lock" to explicitly provide the required
locking.

Then take the lock on workdir only when needed - to lookup the temp name
and to do the whiteout or link.  So ovl_writeout() and similarly
ovl_cleanup_and_writeout() and ovl_workdir_cleanup() are now called
without the lock held.  This requires changes to
ovl_remove_and_whiteout(), ovl_cleanup_index(), ovl_indexdir_cleanup(),
and ovl_workdir_create().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c       | 71 +++++++++++++++++++++-------------------
 fs/overlayfs/overlayfs.h |  2 +-
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    |  2 ++
 fs/overlayfs/readdir.c   | 31 ++++++++++--------
 fs/overlayfs/super.c     |  9 +++--
 fs/overlayfs/util.c      |  7 ++--
 7 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 5afe17cee305..78b0d956b0ac 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -77,7 +77,6 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 	return temp;
 }
 
-/* caller holds i_mutex on workdir */
 static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 {
 	int err;
@@ -85,47 +84,51 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
 
+	mutex_lock(&ofs->whiteout_lock);
 	if (!ofs->whiteout) {
+		inode_lock(wdir);
 		whiteout = ovl_lookup_temp(ofs, workdir);
+		if (!IS_ERR(whiteout)) {
+			err = ovl_do_whiteout(ofs, wdir, whiteout);
+			if (err) {
+				dput(whiteout);
+				whiteout = ERR_PTR(err);
+			}
+		}
+		inode_unlock(wdir);
 		if (IS_ERR(whiteout))
 			goto out;
-
-		err = ovl_do_whiteout(ofs, wdir, whiteout);
-		if (err) {
-			dput(whiteout);
-			whiteout = ERR_PTR(err);
-			goto out;
-		}
 		ofs->whiteout = whiteout;
 	}
 
 	if (!ofs->no_shared_whiteout) {
+		inode_lock(wdir);
 		whiteout = ovl_lookup_temp(ofs, workdir);
-		if (IS_ERR(whiteout))
-			goto out;
-
-		err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
-		if (!err)
+		if (!IS_ERR(whiteout)) {
+			err = ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
+			if (err) {
+				dput(whiteout);
+				whiteout = ERR_PTR(err);
+			}
+		}
+		inode_unlock(wdir);
+		if (!IS_ERR(whiteout) || PTR_ERR(whiteout) != -EMLINK)
 			goto out;
 
-		if (err != -EMLINK) {
-			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%i)\n",
-				ofs->whiteout->d_inode->i_nlink, err);
-			ofs->no_shared_whiteout = true;
-		}
-		dput(whiteout);
+		pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%i)\n",
+			ofs->whiteout->d_inode->i_nlink, err);
+		ofs->no_shared_whiteout = true;
 	}
 	whiteout = ofs->whiteout;
 	ofs->whiteout = NULL;
 out:
+	mutex_unlock(&ofs->whiteout_lock);
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
@@ -138,18 +141,26 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
+	err = ovl_lock_rename_workdir(ofs->workdir, dir);
+	if (!err) {
+		if (whiteout->d_parent == ofs->workdir)
+			err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir,
+					    dentry, flags);
+		else
+			err = -EINVAL;
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
 
@@ -777,15 +788,11 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 			goto out;
 	}
 
-	err = ovl_lock_rename_workdir(workdir, upperdir);
-	if (err)
-		goto out_dput;
-
-	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
-				 dentry->d_name.len);
+	upper = ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upperdir,
+					  dentry->d_name.len);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_unlock;
+		goto out_dput;
 
 	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
@@ -803,8 +810,6 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 	d_drop(dentry);
 out_dput_upper:
 	dput(upper);
-out_unlock:
-	unlock_rename(workdir, upperdir);
 out_dput:
 	dput(opaquedir);
 out:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 508003e26e08..25378b81251e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -732,7 +732,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 void ovl_cache_free(struct list_head *list);
 void ovl_dir_cache_free(struct inode *inode);
 int ovl_check_d_type_supported(const struct path *realpath);
-int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
+int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 			struct vfsmount *mnt, struct dentry *dentry, int level);
 int ovl_indexdir_cleanup(struct ovl_fs *ofs);
 
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index afb7762f873f..4c1bae935ced 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -88,6 +88,7 @@ struct ovl_fs {
 	/* Shared whiteout cache */
 	struct dentry *whiteout;
 	bool no_shared_whiteout;
+	struct mutex whiteout_lock;
 	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
 	errseq_t errseq;
 };
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index f42488c01957..cb1a17c066cd 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -797,6 +797,8 @@ int ovl_init_fs_context(struct fs_context *fc)
 	fc->s_fs_info		= ofs;
 	fc->fs_private		= ctx;
 	fc->ops			= &ovl_context_ops;
+
+	mutex_init(&ofs->whiteout_lock);
 	return 0;
 
 out_err:
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 2a222b8185a3..fd98444dacef 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1141,7 +1141,8 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 		if (IS_ERR(dentry))
 			continue;
 		if (dentry->d_inode)
-			err = ovl_workdir_cleanup(ofs, dir, path->mnt, dentry, level);
+			err = ovl_workdir_cleanup(ofs, path->dentry, path->mnt,
+						  dentry, level);
 		dput(dentry);
 		if (err)
 			break;
@@ -1152,24 +1153,27 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	return err;
 }
 
-int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
+int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
 			struct vfsmount *mnt, struct dentry *dentry, int level)
 {
 	int err;
 
 	if (!d_is_dir(dentry) || level > 1) {
-		return ovl_cleanup(ofs, dir, dentry);
+		return ovl_cleanup_unlocked(ofs, parent, dentry);
 	}
 
-	err = ovl_do_rmdir(ofs, dir, dentry);
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (dentry->d_parent == parent)
+		err = ovl_do_rmdir(ofs, parent->d_inode, dentry);
+	else
+		err = -EINVAL;
+	inode_unlock(parent->d_inode);
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
@@ -1180,7 +1184,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	int err;
 	struct dentry *indexdir = ofs->workdir;
 	struct dentry *index = NULL;
-	struct inode *dir = indexdir->d_inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = indexdir };
 	LIST_HEAD(list);
 	struct ovl_cache_entry *p;
@@ -1194,7 +1197,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	if (err)
 		goto out;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 	list_for_each_entry(p, &list, l_node) {
 		if (p->name[0] == '.') {
 			if (p->len == 1)
@@ -1202,7 +1204,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			if (p->len == 2 && p->name[1] == '.')
 				continue;
 		}
-		index = ovl_lookup_upper(ofs, p->name, indexdir, p->len);
+		index = ovl_lookup_upper_unlocked(ofs, p->name, indexdir,
+						  p->len);
 		if (IS_ERR(index)) {
 			err = PTR_ERR(index);
 			index = NULL;
@@ -1210,7 +1213,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		}
 		/* Cleanup leftover from index create/cleanup attempt */
 		if (index->d_name.name[0] == '#') {
-			err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
+			err = ovl_workdir_cleanup(ofs, indexdir, path.mnt,
+						  index, 1);
 			if (err)
 				break;
 			goto next;
@@ -1220,7 +1224,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1236,7 +1240,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup(ofs, dir, index);
+			err = ovl_cleanup_unlocked(ofs, indexdir, index);
 		}
 
 		if (err)
@@ -1247,7 +1251,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		index = NULL;
 	}
 	dput(index);
-	inode_unlock(dir);
 out:
 	ovl_cache_free(&list);
 	if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 576b5c3b537c..3583e359655f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	int err;
 	bool retried = false;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 retry:
+	inode_lock_nested(dir, I_MUTEX_PARENT);
 	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
 
 	if (!IS_ERR(work)) {
@@ -311,6 +311,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		if (work->d_inode) {
 			err = -EEXIST;
+			inode_unlock(dir);
 			if (retried)
 				goto out_dput;
 
@@ -318,7 +319,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 				goto out_unlock;
 
 			retried = true;
-			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
+			err = ovl_workdir_cleanup(ofs, ofs->workbasedir, mnt,
+						  work, 0);
 			dput(work);
 			if (err == -EINVAL) {
 				work = ERR_PTR(err);
@@ -328,6 +330,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -365,11 +368,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		if (err)
 			goto out_dput;
 	} else {
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		goto out_err;
 	}
 out_unlock:
-	inode_unlock(dir);
 	return work;
 
 out_dput:
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2b4754c645ee..565f7d8c0147 100644
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
@@ -1107,8 +1106,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		goto out;
 	}
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
+	index = ovl_lookup_upper_unlocked(ofs, name.name, indexdir, name.len);
 	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
 		index = NULL;
@@ -1118,10 +1116,9 @@ static void ovl_cleanup_index(struct dentry *dentry)
 					       indexdir, index);
 	} else {
 		/* Cleanup orphan index entries */
-		err = ovl_cleanup(ofs, dir, index);
+		err = ovl_cleanup_unlocked(ofs, indexdir, index);
 	}
 
-	inode_unlock(dir);
 	if (err)
 		goto fail;
 
-- 
2.49.0


