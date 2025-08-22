Return-Path: <linux-fsdevel+bounces-58714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43311B30A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CACD2A340E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2613AA2F;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F217D2;
	Fri, 22 Aug 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821484; cv=none; b=HhU4EZ9QxaBJP42LhLL/79vtyGlnhOwOr7DjWv5nyjjQCtAI/fCfoEk2EFE06T4hKgY3aEumTSGNtTQvqxB1JNGXkKkjJKiigwU8LeZd5lOEt9MIgxIxyXpemAyzRo2+XDwjp6J0PIT27V4hLT0h4MLtR5h6MzocTLEiTVEWq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821484; c=relaxed/simple;
	bh=y082QnXc1Odi3N9LpWJbT1+h9NTlVBg0Oum3Z+maln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCkSVQo/64MQv07eKJzfn14PaW3L/3yIG3wOJzqTS862I7uBbis5bhru9PtWRxwnaD4IdUe8aozIscryYAIpOdXj4G/Db/7w0PC5UyIoskXA5x9lbgyUdTPkBM0BD//KCAjuQ5KTOU+oisOj0qW+lhEBTMVCjySQ5M8YxKANeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFNA-006nan-2D;
	Fri, 22 Aug 2025 00:11:13 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/16] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
Date: Fri, 22 Aug 2025 10:00:23 +1000
Message-ID: <20250822000818.1086550-6-neil@brown.name>
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

lookup_one_qstr_excl() is used for lookups prior to directory
modifications, whether create, remove or rename.

To prepare for allowing modification to happen in parallel, change
lookup_one_qstr_excl() to use d_alloc_parallel().

As a result, ->lookup is now only ever called with a d_in_lookup()
dentry.  Consequently we can remove the d_in_lookup() check from
d_add_ci() which is only used in ->lookup.

If LOOKUP_EXCL or LOOKUP_RENAME_TARGET is passed, the caller must ensure
d_lookup_done() is called at an appropriate time, and must not assume
that it can test for positive or negative dentries without confirming
that the dentry is no longer d_in_lookup() - unless it is filesystem
code acting on itself and *knows* that ->lookup() always completes the
lookup (currently true for all filesystems other than NFS).

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 12 +++++++++++
 fs/dcache.c                           | 16 ++++----------
 fs/namei.c                            | 30 ++++++++++++++++++---------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 96107c15e928..1d3c1e9b6cf3 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1291,3 +1291,15 @@ parameters for the file system to set this state.
 
 d_alloc_parallel() signature has changed - it no longer receives a
 waitqueue_head.  It uses one from an internal table when needed.
+
+---
+
+** mandatory**
+
+kern_path_create() and user_path_create() can return a d_in_lookup()
+dentry as can lookup_one_qstr_excl() if passed "O_CREATE|O_EXCL" or
+"O_RENAME_TARGET".  This can currently only happen if the target
+filesystem is NFS.
+
+inode_operations.lookup() is now only ever called with a d_in_lookup()
+dentry (i.e. DCACHE_PAR_LOOKUP will be set).
diff --git a/fs/dcache.c b/fs/dcache.c
index df9306c63581..034726ab058e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2136,18 +2136,10 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		iput(inode);
 		return found;
 	}
-	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name);
-		if (IS_ERR(found) || !d_in_lookup(found)) {
-			iput(inode);
-			return found;
-		}
-	} else {
-		found = d_alloc(dentry->d_parent, name);
-		if (!found) {
-			iput(inode);
-			return ERR_PTR(-ENOMEM);
-		}
+	found = d_alloc_parallel(dentry->d_parent, name);
+	if (IS_ERR(found) || !d_in_lookup(found)) {
+		iput(inode);
+		return found;
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
diff --git a/fs/namei.c b/fs/namei.c
index 7a2d72ee1af1..b785bf7a9344 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1666,13 +1666,14 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
- * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
- * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * Parent directory has inode locked.
+ * d_lookup_done() must be called before the dentry is dput()
+ * if LOOKUP_EXCL or LOOKUP_RENAME_TARGET is set.
+ * If the dentry is not d_in_lookup():
+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.
+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
+ * If it is d_in_lookup() then these conditions can only be checked by the
+ * file system when carrying out the intent (create or rename).
  */
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base, unsigned int flags)
@@ -1690,18 +1691,27 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
-		return ERR_PTR(-ENOMEM);
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR(dentry)))
+		return dentry;
+	if (unlikely(!d_in_lookup(dentry)))
+		/* Raced with another thread which did the lookup */
+		goto found;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
 found:
 	if (IS_ERR(dentry))
 		return dentry;
+	if (d_in_lookup(dentry))
+		/* We cannot check for errors - the caller will have to
+		 * wait for any create-etc attempt to get relevant errors.
+		 */
+		return dentry;
 	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
 		dput(dentry);
 		return ERR_PTR(-ENOENT);
-- 
2.50.0.107.gf914562f5916.dirty


