Return-Path: <linux-fsdevel+bounces-54562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A81CB00F7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2741CA37F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957892D12E7;
	Thu, 10 Jul 2025 23:21:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808B29B8E2;
	Thu, 10 Jul 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189691; cv=none; b=towNWAP0So+QJmgUyy2D/rL26ub4nvMHpPP7i/trQ8lJM5k+uLNrm1hi3YHOdnk8yfV8O5QwUp5iWWcfKbqo1gpmwSrf0C4NAoPyhdvxF+zqtmTPo+tTeZGrCCGof8g971LwM6+o/PlfrzTHnkaZyXtsXYDfJwlQYoh8n3DcPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189691; c=relaxed/simple;
	bh=+U5PQ/KGriE6WpMxKjd1XC0845PzebZmM9gO3Du3gpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dss95YOuUhC0ecNvib0nnuMxVtIO1dK1M2KCVhCJITIod6VHm4tUFfM6+Ndke0+dPbr4EpU0cPA4k8fV9KBkNodrohvPAiVQZaQAUL0d9Otm0AxzdDt/1Ovh+6ZPRIMXoNXb8i+eYrEZTeboPaB8bPea738P0DGks4d7j9ApcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zp-001XFm-Ob;
	Thu, 10 Jul 2025 23:21:19 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
Date: Fri, 11 Jul 2025 09:03:31 +1000
Message-ID: <20250710232109.3014537-2-neil@brown.name>
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

If ovl_copy_up_data() fails the error is not immediately handled but the
code continues on to call ovl_start_write() and lock_rename(),
presumably because both of these locks are needed for the cleanup.
On then (if the lock was successful) is the error checked.

This makes the code a little hard to follow and could be fragile.

This patch changes to handle the error immediately.  A new
ovl_cleanup_unlocked() is created which takes the required directory
lock (though it doesn't take the write lock on the filesystem).  This
will be used extensively in later patches.

In general we need to check the parent is still correct after taking the
lock (as ovl_copy_up_workdir() does after a successful lock_rename()) so
that is included in ovl_cleanup_unlocked() using new lock_parent() and
unlock_parent() calls (it is planned to move this API into VFS code
eventually, though in a slightly different form).

A fresh cleanup block is added which doesn't share code with other
cleanup blocks.  It will get a new users in the next patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c   | 12 ++++++++++--
 fs/overlayfs/dir.c       | 15 +++++++++++++++
 fs/overlayfs/overlayfs.h |  6 ++++++
 fs/overlayfs/util.c      | 10 ++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8a3c0d18ec2e..5d21b8d94a0a 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -794,6 +794,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 */
 	path.dentry = temp;
 	err = ovl_copy_up_data(c, &path);
+	if (err)
+		goto cleanup_need_write;
+
 	/*
 	 * We cannot hold lock_rename() throughout this helper, because of
 	 * lock ordering with sb_writers, which shouldn't be held when calling
@@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		if (IS_ERR(trap))
 			goto out;
 		goto unlock;
-	} else if (err) {
-		goto cleanup;
 	}
 
 	err = ovl_copy_up_metadata(c, temp);
@@ -857,6 +858,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
 	goto unlock;
+
+cleanup_need_write:
+	ovl_start_write(c->dentry);
+	ovl_cleanup_unlocked(ofs, c->workdir, temp);
+	ovl_end_write(c->dentry);
+	dput(temp);
+	return err;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 4fc221ea6480..cee35d69e0e6 100644
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
+	err = parent_lock(workdir, wdentry);
+	if (err)
+		return err;
+
+	ovl_cleanup(ofs, workdir->d_inode, wdentry);
+	parent_unlock(workdir);
+
+	return err;
+}
+
 struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdir)
 {
 	struct dentry *temp;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 42228d10f6b9..68dc78c712a8 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 }
 
 /* util.c */
+int parent_lock(struct dentry *parent, struct dentry *child);
+static inline void parent_unlock(struct dentry *parent)
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
index 2b4754c645ee..a5105d68f6b4 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1544,3 +1544,13 @@ void ovl_copyattr(struct inode *inode)
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
 }
+
+int parent_lock(struct dentry *parent, struct dentry *child)
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


