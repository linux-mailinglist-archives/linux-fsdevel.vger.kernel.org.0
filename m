Return-Path: <linux-fsdevel+bounces-55048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B5B06AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C4F3A2B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E418FC80;
	Wed, 16 Jul 2025 00:47:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1821E86E;
	Wed, 16 Jul 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626854; cv=none; b=HQTCkEweVwf8xdaslLDBsQDuecaoAygDMIeXiRARVtapUUVD0OX2GzFSKwsylT/40CAacqecc2wAKNGCgWkxIypq6tMG6D+VJDM/V2eJ8fllQbDsEsqdzf5vCLRKUE61zf48fAYuCSVUL49ZLS0npUOYgG5iP51azYF7yntUq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626854; c=relaxed/simple;
	bh=lxBcVG0R0VOH/NGmtnN/Djfma256EQURgN06rwyC5TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra588HonRaYZW7OyjSw0U6BZuvk50bITosk3H4ZUlS1pxuwLUYauIDFAXm+E0VJYMRM2ZQyt7SfI5Wf68HIBfVYCMQH82LdKYqLbtgdY30WA9TjPtZE2XbtTeCF4hjTHM4kEQGWTKKJ51nUtHfRdU1Eon4RIHgS7vIsYqOtK/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqIz-002AAH-A8;
	Wed, 16 Jul 2025 00:47:31 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/21] ovl: simplify an error path in ovl_copy_up_workdir()
Date: Wed, 16 Jul 2025 10:44:12 +1000
Message-ID: <20250716004725.1206467-2-neil@brown.name>
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

If ovl_copy_up_data() fails the error is not immediately handled but the
code continues on to call ovl_start_write() and lock_rename(),
presumably because both of these locks are needed for the cleanup.
Only then (if the lock was successful) is the error checked.

This makes the code a little hard to follow and could be fragile.

This patch changes to handle the error after the ovl_start_write()
(which cannot fail, so there aren't multiple errors to deail with).  A
new ovl_cleanup_unlocked() is created which takes the required directory
lock.  This will be used extensively in later patches.

In general we need to check the parent is still correct after taking the
lock (as ovl_copy_up_workdir() does after a successful lock_rename()) so
that is included in ovl_cleanup_unlocked() using new ovl_parent_lock()
and ovl_parent_unlock() calls (it is planned to move this API into VFS code
eventually, though in a slightly different form).

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   | 20 +++++++++++---------
 fs/overlayfs/dir.c       | 15 +++++++++++++++
 fs/overlayfs/overlayfs.h |  6 ++++++
 fs/overlayfs/util.c      | 10 ++++++++++
 4 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8a3c0d18ec2e..79f41ef6ffa7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -794,23 +794,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 */
 	path.dentry = temp;
 	err = ovl_copy_up_data(c, &path);
+	ovl_start_write(c->dentry);
+	if (err)
+		goto cleanup_unlocked;
+
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
 	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
 	 * temp wasn't moved before copy up completion or cleanup.
 	 */
-	ovl_start_write(c->dentry);
 	trap = lock_rename(c->workdir, c->destdir);
 	if (trap || temp->d_parent != c->workdir) {
 		/* temp or workdir moved underneath us? abort without cleanup */
 		dput(temp);
 		err = -EIO;
-		if (IS_ERR(trap))
-			goto out;
-		goto unlock;
-	} else if (err) {
-		goto cleanup;
+		if (!IS_ERR(trap))
+			unlock_rename(c->workdir, c->destdir);
+		goto out;
 	}
 
 	err = ovl_copy_up_metadata(c, temp);
@@ -846,7 +847,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
-unlock:
 	unlock_rename(c->workdir, c->destdir);
 out:
 	ovl_end_write(c->dentry);
@@ -854,9 +854,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	return err;
 
 cleanup:
-	ovl_cleanup(ofs, wdir, temp);
+	unlock_rename(c->workdir, c->destdir);
+cleanup_unlocked:
+	ovl_cleanup_unlocked(ofs, c->workdir, temp);
 	dput(temp);
-	goto unlock;
+	goto out;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 4fc221ea6480..67cad3dba8ad 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
+int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
+			 struct dentry *wdentry)
+{
+	int err;
+
+	err = ovl_parent_lock(workdir, wdentry);
+	if (err)
+		return err;
+
+	ovl_cleanup(ofs, workdir->d_inode, wdentry);
+	ovl_parent_unlock(workdir);
+
+	return 0;
+}
+
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 {
 	struct dentry *temp;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 42228d10f6b9..6737a4692eb2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 }
 
 /* util.c */
+int ovl_parent_lock(struct dentry *parent, struct dentry *child);
+static inline void ovl_parent_unlock(struct dentry *parent)
+{
+	inode_unlock(parent->d_inode);
+}
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
 void ovl_start_write(struct dentry *dentry);
@@ -843,6 +848,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *dentry);
+int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, struct dentry *dentry);
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2b4754c645ee..f4944f11d5eb 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1544,3 +1544,13 @@ void ovl_copyattr(struct inode *inode)
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
 }
+
+int ovl_parent_lock(struct dentry *parent, struct dentry *child)
+{
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (!child || child->d_parent == parent)
+		return 0;
+
+	inode_unlock(parent->d_inode);
+	return -EINVAL;
+}
-- 
2.49.0


