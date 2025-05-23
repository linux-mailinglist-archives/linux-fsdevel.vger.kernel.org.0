Return-Path: <linux-fsdevel+bounces-49757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D030AC223A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442D53B4A0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50889236451;
	Fri, 23 May 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPY3DcK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650022A1E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001294; cv=none; b=DPiCcINeWrfUnADkFcEbSTw8a1FQxLbovQAL2DTuOrLgO55jzoKeOUqQhxcAvXndG3Aa06J/pffeuzEKVuGAaIc87Tu2GXSmo+vAFKh5vSDbb1VJqL4d5n5liRbSBMhmnnGAxdPb0Mc8F+gNZ7oMT0dvdAqXVX2qTbmL6vrzA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001294; c=relaxed/simple;
	bh=C35yRaL5tY0JLVLlAqHYlEZODlTqaIBr3GbgwbPcy+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSd6ilQK0Rlz10qGexOCDIyxaLEWhYbpYn6oJgiDWcHQpoQ3z0GO8tztGoKQWFZP9okPgE1YSjixHuPleervXAZsZbZXz1k8PhpFh8WWH9VmfdPlaf6LrQX3Zm57T5MAjMUvpSZKovlI0bQnOn1HJl+GaI/cVfFwRwuq/QL97No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPY3DcK4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748001288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9181g7QwrmXTo7V8SLmNc23UjiXBHZW7pmfawKP0VaM=;
	b=RPY3DcK4lVmBw4J/vHr2EFFo2A9uMjX5xoY/Oy3G7YbJA71h0SQV3xgn6DPdO7QEc1wCEV
	ri+uOQClFA9te9nRpwfYQ0kjQHhJ/bdlbea19MUeY+SCICP2fxH1TSN5cKnqdx398FWNDz
	GKo28c+A+/aQbYlYdtSC2Y29ZixIswk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] fs: dcache exlusion between overlayfs, casefolding
Date: Fri, 23 May 2025 07:54:42 -0400
Message-ID: <20250523115442.3583342-1-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-5-kent.overstreet@linux.dev>
References: <20250520051600.1903319-5-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow casefolding to be used on the same filesystem as overlayfs.

Overlayfs cannot handle a directory that has been casefolding, so this
implements locking between enabling casefolding and overlayfs.

The underlying filesystem mus also track, for each directory, whether
casefolding has been enabled on any subdirectory, and provide this
information to the VFS with the S_NO_CASEFOLD flag.

Since we can't inflate struct dentry for this, add a separate rhashtable
that functions as a per-dentry "casefolding disabled" ref.

New helpers, for overlayfs:
- d_casefold_disabled_put()
- d_casefold_disabled_get()

These acquire and release refs that check that S_NO_CASEFOLD is set on a
directory, and prevent it from being cleared while the ref exists.

For the underlying filesystem:

- d_casefolding_enable()
- d_casefolding_enable_commit()

This is for the underlying filesystem that implements casefolding, in
settar and rename. d_casefolding_enable() checks for conflicting refs
held by overlayfs and acquires refs while the rename or setatr is being
done, d_casefolding_enable_commit() releases those refs and clears the
S_NO_CASEFOLD flag.

Implementation -

We can't inflate struct dentry for this, so references are tracked in a
separate rhashtable.

To guard against races with rename(), d_casefolding_enable() must take
refs (which in turn call dget()) on all dentries with inodes that need
S_NO_CASEFOLD flipped; these dget() refs are released by commit().

d_casefold_disabled_get/put take dget() refs for the duration of the
union mount, but this is unchanged because unionfs already holds a path
ref for the duration of the mount.

Changes since v1:

- Fix "walk up the tree" synchronization

  s_vfs_rename_mutex is required: we can't allow an operation enabling
  casefolding (via fileattr_set) to race with a rename moving it into a
  tree exported by overlayfs.

  d_casefold_enable() has a new @rename parameter: if set, we check that
  s_vfs_rename_mutex is held, if not (called from fileattr_set), we
  acquire it and release it in d_casefold_enable_commit().

  Also, use dget_parent().

- no_casefold_dentries_lock -> sb->s_casefold_enable_lock

- d_casefold_enable() now bails out early if called on non-directory, or
  if S_NO_CASEFOLD is not set.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/dcache.c            | 266 +++++++++++++++++++++++++++++++++++++++++
 fs/super.c             |   1 +
 include/linux/dcache.h |  12 ++
 include/linux/fs.h     |   4 +
 4 files changed, 283 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index bd5aa136153a..d29faa6f9ec8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,8 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/rhashtable.h>
+#include <linux/darray.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3141,6 +3143,266 @@ ino_t d_parent_ino(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_parent_ino);
 
+static struct rhashtable no_casefold_dentries;
+
+enum no_casefold_dentry_ref {
+	ref_casefold_disable,
+	ref_casefold_enable,
+};
+
+struct no_casefold_dentry {
+	struct rhash_head	hash;
+	struct dentry		*dentry;
+	unsigned long		ref[2];
+};
+
+static const struct rhashtable_params no_casefold_dentries_params = {
+	.head_offset		= offsetof(struct no_casefold_dentry, hash),
+	.key_offset		= offsetof(struct no_casefold_dentry, dentry),
+	.key_len		= sizeof(struct dentry *),
+	.automatic_shrinking	= true,
+};
+
+static int no_casefold_dentry_get(struct dentry *dentry,
+				  enum no_casefold_dentry_ref ref)
+{
+	struct no_casefold_dentry *n =
+		rhashtable_lookup_fast(&no_casefold_dentries,
+				       &dentry,
+				       no_casefold_dentries_params);
+	if (n) {
+		if (n->ref[!ref])
+			return -EINVAL;
+
+		n->ref[ref]++;
+		return 0;
+	}
+
+	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	if (!n)
+		return -ENOMEM;
+
+	n->dentry = dget(dentry);
+	n->ref[ref]++;
+
+	int ret = rhashtable_lookup_insert_fast(&no_casefold_dentries,
+				&n->hash, no_casefold_dentries_params);
+	if (WARN_ON(ret)) {
+		kfree(n);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void no_casefold_dentry_put(struct dentry *dentry,
+				   enum no_casefold_dentry_ref ref)
+{
+	struct no_casefold_dentry *n =
+		rhashtable_lookup_fast(&no_casefold_dentries,
+				       &dentry,
+				       no_casefold_dentries_params);
+	if (WARN_ON(!n))
+		return;
+
+	if (--n->ref[ref])
+		return;
+
+	dput(n->dentry);
+	int ret = rhashtable_remove_fast(&no_casefold_dentries,
+					 &n->hash, no_casefold_dentries_params);
+	WARN_ON(ret);
+}
+
+/**
+ * d_casefold_disabled_put - drop a "casefold disabled" ref
+ *
+ * Only for overlayfs.
+ */
+void d_casefold_disabled_put(struct dentry *dentry)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	if (!(sb->s_flags & SB_CASEFOLD))
+		return;
+
+	guard(mutex)(&sb->s_casefold_enable_lock);
+	no_casefold_dentry_put(dentry, ref_casefold_disable);
+}
+EXPORT_SYMBOL_GPL(d_casefold_disabled_put);
+
+/**
+ * d_casefold_disabled_get - attempt to disable casefold on a tree
+ *
+ * Only for overlayfs.
+ *
+ * Returns -EINVAL if casefolding is in use on any subdirectory; this must be
+ * tracked by the filesystem.
+ *
+ * On success, returns with a reference held that must be released by
+ * d_casefold_disabled_put(); this ref blocks casefold from being enabled
+ * by d_casefold_enable().
+ */
+int d_casefold_disabled_get(struct dentry *dentry)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	if (!(sb->s_flags & SB_CASEFOLD))
+		return 0;
+
+	guard(mutex)(&sb->s_casefold_enable_lock);
+
+	if (!(dentry->d_inode->i_flags & S_NO_CASEFOLD))
+		return -EINVAL;
+
+	return no_casefold_dentry_get(dentry, ref_casefold_disable);
+}
+EXPORT_SYMBOL_GPL(d_casefold_disabled_get);
+
+/* Crabwalk: releases @dentry after getting ref on parent */
+static struct dentry *dget_parent_this_sb(struct dentry *dentry)
+{
+	struct dentry *parent = dentry != dentry->d_sb->s_root
+		? dget_parent(dentry)
+		: NULL;
+	dput(dentry);
+	return parent;
+}
+
+/**
+ * d_casefold_enable - check if casefolding may be enabled on a dentry
+ *
+ * @dentry:	dentry to enable casefolding on
+ * @e:		state object, released by d_casefold_enable_commit()
+ * @rename:	Are we in the rename path?
+ *		If so, we expect s_vfs_rename_mutex to be held, if not (called
+ *		from setflags), we aquire it if necessary, and release in
+ *		commit.
+ *
+ * The rename mutex is required because we're operating on a whole path,
+ * potentially up to the filesystem root, and we need it to be stable until
+ * commit (i.e. we don't want to be renamed into a tree overlayfs is exporting
+ * after we've returned success).
+ *
+ * For rename, this should only be called for cross-directory rename.
+ * S_NO_CASEFOLD doesn't need to change on rename within a directory, and
+ * s_vfs_rename_mutex won't be held on non cross-directory rename.
+ *
+ * Returns -EINVAL if casefolding has been disabled on any parent directory (by
+ * overlayfs).
+ *
+ * On success, the d_casefold_enable object must be committed with
+ * d_casefold_enable_commit(), after the filesystem has updated its internal
+ * state.
+ *
+ * Commit will clear S_NO_CASEFOLD on all inodes up to the filesystem root,
+ * informing overlayfs that this tree has casefolding enabled somewhere in it.
+ */
+int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e,
+		      bool rename)
+{
+	int ret = 0;
+
+	memset(e, 0, sizeof(*e));
+	e->sb = dentry->d_sb;
+
+	if (!(e->sb->s_flags & SB_CASEFOLD))
+		return 0;
+
+	if (!S_ISDIR(dentry->d_inode->i_mode))
+		return 0;
+
+	/*
+	 * On rename, we're passed the dentry being renamed (the filesystem is
+	 * not passed the dentry of the directory we're renaming to), but it's
+	 * the parent that may need to have S_NO_CASEFOLD cleared:
+	 */
+	dentry = rename
+		? dget_parent(dentry)
+		: dget(dentry);
+
+	if (!(dentry->d_inode->i_flags & S_NO_CASEFOLD)) {
+		dput(dentry);
+		return 0;
+	}
+
+	if (rename) {
+		lockdep_assert_held(&e->sb->s_vfs_rename_mutex);
+	} else {
+		mutex_lock(&e->sb->s_vfs_rename_mutex);
+		e->rename_mutex_held = true;
+	}
+
+	guard(mutex)(&e->sb->s_casefold_enable_lock);
+
+	for (struct dentry *i = dentry; i; i = dget_parent_this_sb(i)) {
+		if (!(i->d_inode->i_flags & S_NO_CASEFOLD)) {
+			dput(i);
+			break;
+		}
+
+		ret = darray_push(&e->refs, i);
+		if (ret) {
+			dput(i);
+			goto err;
+		}
+
+		ret = no_casefold_dentry_get(i, ref_casefold_enable);
+		if (ret) {
+			dput(i);
+			--e->refs.nr;
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	darray_for_each(e->refs, i)
+		no_casefold_dentry_put(*i, ref_casefold_enable);
+	darray_exit(&e->refs);
+
+	if (e->rename_mutex_held)
+		mutex_unlock(&e->sb->s_vfs_rename_mutex);
+	e->rename_mutex_held = false;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(d_casefold_enable);
+
+/**
+ * d_casefold_enable_commit - finish operation started by d_casefold_enable()
+ *
+ * @e:		state object, started by d_casefold_enable_commit()
+ * @ret:	Success or failure of the operation, from the filesystem
+ *
+ * On success (@ret == 0), clear S_NO_CASEFOLD on all inodes up to the
+ * filesystem root that have it set, which d_casefold_enable() previously took
+ * references to.
+ */
+void d_casefold_enable_commit(struct d_casefold_enable *e, int ret)
+{
+	if (e->refs.nr) {
+		guard(mutex)(&e->sb->s_casefold_enable_lock);
+
+		darray_for_each(e->refs, i) {
+			if (!ret) {
+				struct inode *inode = (*i)->d_inode;
+
+				spin_lock(&inode->i_lock);
+				inode->i_flags &= ~S_NO_CASEFOLD;
+				spin_unlock(&inode->i_lock);
+			}
+
+			no_casefold_dentry_put(*i, ref_casefold_enable);
+		}
+		darray_exit(&e->refs);
+	}
+
+	if (e->rename_mutex_held)
+		mutex_unlock(&e->sb->s_vfs_rename_mutex);
+	e->rename_mutex_held = false;
+}
+EXPORT_SYMBOL_GPL(d_casefold_enable_commit);
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
@@ -3186,6 +3448,10 @@ static void __init dcache_init(void)
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
 
+	int ret = rhashtable_init(&no_casefold_dentries, &no_casefold_dentries_params);
+	if (ret)
+		panic("error initializing no_casefold_dentries: %i\n", ret);
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
diff --git a/fs/super.c b/fs/super.c
index 97a17f9d9023..2ba3446f09d6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -368,6 +368,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
 	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
+	mutex_init(&s->s_casefold_enable_lock);
 	init_rwsem(&s->s_dquot.dqio_sem);
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e9f07e37dd6f..fb78de44a929 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -3,6 +3,7 @@
 #define __LINUX_DCACHE_H
 
 #include <linux/atomic.h>
+#include <linux/darray_types.h>
 #include <linux/list.h>
 #include <linux/math.h>
 #include <linux/rculist.h>
@@ -604,4 +605,15 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+void d_casefold_disabled_put(struct dentry *dentry);
+int d_casefold_disabled_get(struct dentry *dentry);
+
+struct d_casefold_enable {
+	DARRAY(struct dentry *)	refs;
+	struct super_block	*sb;
+	bool			rename_mutex_held;
+};
+int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e, bool);
+void d_casefold_enable_commit(struct d_casefold_enable *e, int ret);
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba942cd2fea1..7ee0cd7bc15b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -48,6 +48,7 @@
 #include <linux/rw_hint.h>
 #include <linux/file_ref.h>
 #include <linux/unicode.h>
+#include <linux/rhashtable-types.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1397,6 +1398,7 @@ struct super_block {
 	 * even looking at it. You had been warned.
 	 */
 	struct mutex s_vfs_rename_mutex;	/* Kludge */
+	struct mutex s_casefold_enable_lock;
 
 	/*
 	 * Filesystem subtype.  If non-empty the filesystem type field
@@ -1440,6 +1442,7 @@ struct super_block {
 
 	struct mutex		s_sync_lock;	/* sync serialisation lock */
 
+
 	/*
 	 * Indicates how deep in a filesystem stack this SB is
 	 */
@@ -2345,6 +2348,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_NO_CASEFOLD	(1 << 18) /* Directory, and all descendents, are not casefolded */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
-- 
2.49.0


