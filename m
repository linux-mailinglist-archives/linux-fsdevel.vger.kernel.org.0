Return-Path: <linux-fsdevel+bounces-46408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE4A88CE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC99B7A59D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFF1C9B9B;
	Mon, 14 Apr 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIlMgvTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECD2DFA22
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661622; cv=none; b=VoUOd11QqTpKMcgZb1ESH7pjFQl32lyYXVtgvn9QH6UpG+GwJtAMHMLShOBwRp1ZBhY1qu/4NG5rAsE+7cof5GrLIaxOvGD5TH5Z3WCP7JZHkSEH0iJXVpKln+7UD/KaU3PNCKUMXvNJ5HTvrVRm54FYyC7PYcn45tnNuLWBZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661622; c=relaxed/simple;
	bh=d8Y6wthc1JjgyPqLaN5LAy0yZkWm7PL29JwXM+1QA9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8rC06uiqE3N8Qub9e50NwKPxXO3ESlV0WZ1wIeaJempVv2OEiA0lwEyG3JDncZucZv1NFWJDoopvIoFiCNALTJ+HyQ9g+76s4dpUOGYIusAPMUFSDyerhQa0uXDV9F4/6yO4FB6thTE2f8g7X4DhLbwPKlA2dVCrhZBIXKyl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIlMgvTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391AEC4CEE2;
	Mon, 14 Apr 2025 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744661621;
	bh=d8Y6wthc1JjgyPqLaN5LAy0yZkWm7PL29JwXM+1QA9A=;
	h=From:To:Cc:Subject:Date:From;
	b=IIlMgvTfLGt5JKxbwSux5BJECqvZDGSuHkFNcNY+a4A0W1QWFLRKycQilQpUK01dv
	 pAZ0FpSqI+8uoNXtiEitoOXCcBs9I4LcR/OrrUqMhqslakC0SSG3Kzyg7KC5buOwpX
	 gwG8NaTYmD5VLJd7r5niU/h0yXMg06aCYXjc9SAZMCqKKt4MSTLDzZ66T7Uz8JWiaB
	 SX/utIzictVqJBZTbF9+5JdJCY1kkf6ErWYsJT6gVdDPODsgh49zEr01vHfKjs5V/9
	 cwgC20kLt+NH6XhiIwniWJD3JZNoAfnteGOGJ7vpo1Q6/g+z9HCz88IzKOuAxz/S6v
	 tbeAs9ZEWRtCg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] fs: add kern_path_locked_negative()
Date: Mon, 14 Apr 2025 22:13:33 +0200
Message-ID: <20250414-rennt-wimmeln-f186c3a780f1@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6161; i=brauner@kernel.org; h=from:subject:message-id; bh=d8Y6wthc1JjgyPqLaN5LAy0yZkWm7PL29JwXM+1QA9A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/zck3iEzW0e5cLZu8ZeWD+NnfROdODTSeu9JeuXkSX 0S141+mjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk4zWD4H/DUdX/qrYc7IuIm 7pd5Y9R7TPLMTUsP7a0/L8Qt+vUtJYqRYXpJYsWv1M7j8xYsenRx7pnKs56MfzPPqSwNlTwcbsK kzgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The audit code relies on the fact that kern_path_locked() returned a
path even for a negative dentry. If it doesn't find a valid dentry it
immediately calls:

    audit_find_parent(d_backing_inode(parent_path.dentry));

which assumes that parent_path.dentry is still valid. But it isn't since
kern_path_locked() has been changed to path_put() also for a negative
dentry.

Fix this by adding a helper that implements the required audit semantics
and allows us to fix the immediate bleeding. We can find a unified
solution for this afterwards.

Fixes: 1c3cb50b58c3 ("VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c            | 65 ++++++++++++++++++++++++++++++++-----------
 include/linux/namei.h |  1 +
 kernel/audit_watch.c  | 16 +++++++----
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..2c5ca9ef6811 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1665,27 +1665,20 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 	return dentry;
 }
 
-/*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
- */
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base,
-				    unsigned int flags)
+static struct dentry *lookup_one_qstr_excl_raw(const struct qstr *name,
+					       struct dentry *base,
+					       unsigned int flags)
 {
-	struct dentry *dentry = lookup_dcache(name, base, flags);
+	struct dentry *dentry;
 	struct dentry *old;
-	struct inode *dir = base->d_inode;
+	struct inode *dir;
 
+	dentry = lookup_dcache(name, base, flags);
 	if (dentry)
-		goto found;
+		return dentry;
 
 	/* Don't create child dentry for a dead directory. */
+	dir = base->d_inode;
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
@@ -1698,7 +1691,24 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 		dput(dentry);
 		dentry = old;
 	}
-found:
+	return dentry;
+}
+
+/*
+ * Parent directory has inode locked exclusive.  This is one
+ * and only case when ->lookup() gets called on non in-lookup
+ * dentries - as the matter of fact, this only gets called
+ * when directory is guaranteed to have no in-lookup children
+ * at all.
+ * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ */
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base, unsigned int flags)
+{
+	struct dentry *dentry;
+
+	dentry = lookup_one_qstr_excl_raw(name, base, flags);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
@@ -2762,6 +2772,29 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	return d;
 }
 
+struct dentry *kern_path_locked_negative(const char *name, struct path *path)
+{
+	struct filename *filename __free(putname) = getname_kernel(name);
+	struct dentry *d;
+	struct qstr last;
+	int type, error;
+
+	error = filename_parentat(AT_FDCWD, filename, 0, path, &last, &type);
+	if (error)
+		return ERR_PTR(error);
+	if (unlikely(type != LAST_NORM)) {
+		path_put(path);
+		return ERR_PTR(-EINVAL);
+	}
+	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl_raw(&last, path->dentry, 0);
+	if (IS_ERR(d)) {
+		inode_unlock(path->dentry->d_inode);
+		path_put(path);
+	}
+	return d;
+}
+
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e3042176cdf4..bbaf55fb3101 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -62,6 +62,7 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+extern struct dentry *kern_path_locked_negative(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 367eaf2c78b7..0ebbbe37a60f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -347,12 +347,17 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 /* Get path information necessary for adding watches. */
 static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
-	struct dentry *d = kern_path_locked(watch->path, parent);
+	struct dentry *d;
+
+	d = kern_path_locked_negative(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	/* update watch filter fields */
-	watch->dev = d->d_sb->s_dev;
-	watch->ino = d_backing_inode(d)->i_ino;
+
+	if (d_is_positive(d)) {
+		/* update watch filter fields */
+		watch->dev = d->d_sb->s_dev;
+		watch->ino = d_backing_inode(d)->i_ino;
+	}
 
 	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
@@ -418,11 +423,10 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
 
-	if (ret && ret != -ENOENT) {
+	if (ret) {
 		audit_put_watch(watch);
 		return ret;
 	}
-	ret = 0;
 
 	/* either find an old parent or attach a new one */
 	parent = audit_find_parent(d_backing_inode(parent_path.dentry));
-- 
2.47.2


