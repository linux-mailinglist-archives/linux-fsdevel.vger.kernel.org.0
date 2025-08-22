Return-Path: <linux-fsdevel+bounces-58717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1CB30A16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D2A1D061DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB117A2F0;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC728F5;
	Fri, 22 Aug 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821485; cv=none; b=FbUl9E7q2gNkr/xcOgsmjH/d0dnb+QSmnW2Cvka6Hwc2J/vYtX5X00ONlLAr5GNyy2nOyZQsbzKkGrwguMHR+HSbJTo7fMiMM3bvt+J55WmH8b9Jimw/uaDZi3gUUpW34t76rh7ZHbBFZMCDV5sBxE7t+cUUHzSyTOJ7h95ZPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821485; c=relaxed/simple;
	bh=wjv05qWFt0qPZ3AOnvrdkXePFJHOTSlN7tSG1qIL/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUJcC9d2Sc8A6xvjH7WlVd0Kxy/K3t6hyva6phN9eZ1vABoFAAQ3v73oWYrcoqIeg4lW5XnGLen6KbGXPILbq/uVsgY9YxA7uxtGA5ErqMrWjV4hyj8OT77QOnRubLCCBq2jO5ROzN0FmBlax8s4gPfeZ8fNOotUUEtpVGDKpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNB-006nb1-Gx;
	Fri, 22 Aug 2025 00:11:15 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/16] VFS: implement simple_start_creating() with start_dirop()
Date: Fri, 22 Aug 2025 10:00:26 +1000
Message-ID: <20250822000818.1086550-9-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

simple_start_creating() now uses start_dirop(), which further
centralised locking rules.
start_dirop() and lookup_noperm_common() are not available
via fs/internal.h.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/internal.h |  3 +++
 fs/libfs.c    | 36 +++++++++++++++++-------------------
 fs/namei.c    |  6 +++---
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..baeaaf3747e3 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
 struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags);
+int lookup_noperm_common(struct qstr *qname, struct dentry *base);
 
 /*
  * namespace.c
diff --git a/fs/libfs.c b/fs/libfs.c
index ce8c496a6940..63c1a4186206 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
 	cmpxchg(stashed, dentry, NULL);
 }
 
-/* parent must be held exclusive */
+/**
+ * simple_start_creating - prepare to create a given name
+ * @parent - directory in which to prepare to create the name
+ * @name - the name to be created
+ *
+ * Locks are taken and a lookup in performed prior to creating
+ * an object in a directory.  No permission checking is performed.
+ *
+ * Returns: a negative dentry on which vfs_create() or similar may
+ *  be attempted, or an error.
+ */
 struct dentry *simple_start_creating(struct dentry *parent, const char *name)
 {
-	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
+	struct qstr qname = QSTR(name);
+	int err;
 
-	inode_lock(dir);
-	if (unlikely(IS_DEADDIR(dir))) {
-		inode_unlock(dir);
-		return ERR_PTR(-ENOENT);
-	}
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(dir);
-		return dentry;
-	}
-	if (dentry->d_inode) {
-		dput(dentry);
-		inode_unlock(dir);
-		return ERR_PTR(-EEXIST);
-	}
-	return dentry;
+	err = lookup_noperm_common(&qname, parent);
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
 }
 EXPORT_SYMBOL(simple_start_creating);
diff --git a/fs/namei.c b/fs/namei.c
index 8121550f20aa..c1e39c985f1f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2765,8 +2765,8 @@ static int filename_parentat(int dfd, struct filename *name,
  * Returns: a locked dentry, or an error.
  *
  */
-static struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
-				  unsigned int lookup_flags)
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags)
 {
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
@@ -2931,7 +2931,7 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
+int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 {
 	const char *name = qname->name;
 	u32 len = qname->len;
-- 
2.50.0.107.gf914562f5916.dirty


