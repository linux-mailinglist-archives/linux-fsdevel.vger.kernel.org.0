Return-Path: <linux-fsdevel+bounces-55570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D06B0BF57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4A17A6AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F728A40A;
	Mon, 21 Jul 2025 08:45:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14EE2877DD;
	Mon, 21 Jul 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087540; cv=none; b=FDmFLhc0jYExYUl4kGiURne8mnfbuREI3Gb1b6mYqt+Lb75zAoWc6TsEcVhRXSfibeYzlx+vCrhrKf30aDoeKqLTBouIF2K2Qiq+vnW9S4gv27UluoiH6wjZEMovezbtS9GrLveKE5IANZ5hact5sRK0kcVT1KNQsdUvUAPPhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087540; c=relaxed/simple;
	bh=x12wTCgNX61cbCA8ZuNPRpQgNjL9DwU8174S+N2rU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRk0QTl4Ev5KkHYhvIk6GMiJVzJlXLcpgLKYg5TLGfegfIDX3GkWB8WPLTr1YA5tx0P8QEd1ZUlLN22rTgvr7MO++G0Py5GjKxHyA1/7Nl5coRU3fAQBDYG4jSNZw6cO3k5SNRzpdG4TwXxpyPbl2VJUaaBRWthv4doEjNmOpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1udm9G-002pfr-C9;
	Mon, 21 Jul 2025 08:45:28 +0000
From: NeilBrown <neil@brown.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] VFS: introduce done_dentry_lookup()
Date: Mon, 21 Jul 2025 17:59:58 +1000
Message-ID: <20250721084412.370258-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

done_dentry_lookup() is the first step in introducing a new API for
locked operation on names in directories - those that create or remove
names.  Rename operations will also be part of this API but will
use separate interfaces.

The plan is to lock just the dentry (or dentries), not the whole
directory.  A "dentry_lookup()" operation will perform the locking and
lookup with a corresponding "done_dentry_lookup()" releasing the
resulting dentry and dropping any locks.

This done_dentry_lookup() can immediately be used to complete updates
started with kern_path_locked() (much as done_path_create() already
completes operations started with kern_path_create()).

So this patch adds done_dentry_lookup() and uses it where
kern_path_locked() is used.  It also adds done_dentry_lookup_return()
which returns a reference to the dentry rather than dropping it.  This
is a less common need in existing code, but still worth its own interface.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/base/devtmpfs.c |  7 ++-----
 fs/bcachefs/fs-ioctl.c  |  3 +--
 fs/namei.c              | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h   |  3 +++
 kernel/audit_fsnotify.c |  9 ++++-----
 kernel/audit_watch.c    |  3 +--
 6 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 31bfb3194b4c..47bee8166c8d 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -265,8 +265,7 @@ static int dev_rmdir(const char *name)
 	else
 		err = -EPERM;
 
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
+	done_dentry_lookup(dentry);
 	path_put(&parent);
 	return err;
 }
@@ -349,9 +348,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 		if (!err || err == -ENOENT)
 			deleted = 1;
 	}
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
-
+	done_dentry_lookup(dentry);
 	path_put(&parent);
 	if (deleted && strchr(nodename, '/'))
 		delete_path(nodename);
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 4e72e654da96..8077ddf4ddc4 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -351,8 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		d_invalidate(victim);
 	}
 err:
-	inode_unlock(dir);
-	dput(victim);
+	done_dentry_lookup(victim);
 	path_put(&path);
 	return ret;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 1c80445693d4..da160a01e23d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1714,6 +1714,44 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+/**
+ * done_dentry_lookup - finish a lookup used for create/delete
+ * @dentry:  the target dentry
+ *
+ * After locking the directory and lookup or validating a dentry
+ * an attempt can be made to create (including link) or remove (including
+ * rmdir) a dentry.  After this, done_dentry_lookup() can be used to both
+ * unlock the parent directory and dput() the dentry.
+ *
+ * This interface allows a smooth transition from parent-dir based
+ * locking to dentry based locking.
+ */
+void done_dentry_lookup(struct dentry *dentry)
+{
+	inode_unlock(dentry->d_parent->d_inode);
+	dput(dentry);
+}
+EXPORT_SYMBOL(done_dentry_lookup);
+
+/**
+ * done_dentry_lookup_return - finish a lookup sequence, returning the dentry
+ * @dentry:  the target dentry
+ *
+ * After locking the directory and lookup or validating a dentry
+ * an attempt can be made to create (including link) or remove (including
+ * rmdir) a dentry.  After this, done_dentry_lookup_return() can be used to
+ * unlock the parent directory.  The dentry is returned for further use.
+ *
+ * This interface allows a smooth transition from parent-dir based
+ * locking to dentry based locking.
+ */
+struct dentry *done_dentry_lookup_return(struct dentry *dentry)
+{
+	inode_unlock(dentry->d_parent->d_inode);
+	return dentry;
+}
+EXPORT_SYMBOL(done_dentry_lookup_return);
+
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
  * @nd: current nameidata
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..e097f11587c9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,6 +81,9 @@ struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
 
+void done_dentry_lookup(struct dentry *dentry);
+struct dentry *done_dentry_lookup_return(struct dentry *dentry);
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..170836c3520f 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -85,8 +85,8 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	dentry = kern_path_locked(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	inode = igrab(dentry->d_inode);
+	done_dentry_lookup(dentry);
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -97,17 +97,16 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
 	audit_mark->mark.mask = AUDIT_FS_EVENTS;
 	audit_mark->path = pathname;
-	audit_update_mark(audit_mark, dentry->d_inode);
+	audit_update_mark(audit_mark, inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
 	path_put(&path);
 	return audit_mark;
 }
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 0ebbbe37a60f..f6ecac2109d4 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -359,8 +359,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
 
-	inode_unlock(d_backing_inode(parent->dentry));
-	dput(d);
+	done_dentry_lookup(d);
 	return 0;
 }
 
-- 
2.49.0


