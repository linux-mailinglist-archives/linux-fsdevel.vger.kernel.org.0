Return-Path: <linux-fsdevel+bounces-49478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0474ABCE83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983FD1887CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69C25A324;
	Tue, 20 May 2025 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WaqVG+oI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A025C6E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718178; cv=none; b=C0iw10vgB+u/C1qt6IkYxfIoatbT3f4YFfpIv1yFtBrqSsjKDzXZ4wnuWPGkqoPkuUd1CE/qmtnJvsBvmre+Kj213785khYRWIom/V6vEOmJI3TfEpYSArN/y8JdujxEUWl00tFmPYMFE/EPnCPU87il+Ok7MJRUj/8/TEM9eY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718178; c=relaxed/simple;
	bh=A9eJZ5jQiNjme2efRTyoSl9kLsZnk7LxjkDkCvQ0vkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DETJGPRjtkOZ+5+65ad+AUhLovw5qPS8MzJ0TO8Z67fQcdroc8ghaF3JMKi59vNKNSlHvQQ0twxHqE7bkYLSHeh/GmrIdypaWqBSm1jprBzRyy96qPPO9r4EqRYy8EiipilTvJHhZ/vki3ivYZ8ISvkvlOIdNOMsn+z5lWeiBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WaqVG+oI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747718173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L94gNOs1zA4JaSEM3Ng1trC1ToVPa//1ULc22IZviDk=;
	b=WaqVG+oIDhqyk1rF1Pk7+8U4rkTyUhC6VXGhhIMyvy4bRww/xIEjFHEfrYYctNdseflZ/L
	jlcwht3+T2RRGTtfbfKYaj3jgla3zZNVXYfxpb1o5W6lFmgHY2vWtqVDNeKaUNBfXhL91y
	mqYllNgKqSeGBqRXZTLpTl4dfS4TnDE=
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
Subject: [PATCH 4/6] fs: dcache locking for exlusion between overlayfs, casefolding
Date: Tue, 20 May 2025 01:15:56 -0400
Message-ID: <20250520051600.1903319-5-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
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

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/dcache.c            | 177 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  10 +++
 include/linux/fs.h     |   3 +
 3 files changed, 190 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index bd5aa136153a..971dd90bce26 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,9 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/rhashtable.h>
+#include <linux/darray.h>
+#include <linux/errname.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3141,6 +3144,176 @@ ino_t d_parent_ino(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_parent_ino);
 
+static DEFINE_MUTEX(no_casefold_dentries_lock);
+struct rhashtable no_casefold_dentries;
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
+	if (!(dentry->d_sb->s_flags & SB_CASEFOLD))
+		return;
+
+	guard(mutex)(&no_casefold_dentries_lock);
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
+	if (!(dentry->d_sb->s_flags & SB_CASEFOLD))
+		return 0;
+
+	guard(mutex)(&no_casefold_dentries_lock);
+
+	if (!(dentry->d_inode->i_flags & S_NO_CASEFOLD))
+		return -EINVAL;
+
+	return no_casefold_dentry_get(dentry, ref_casefold_disable);
+}
+EXPORT_SYMBOL_GPL(d_casefold_disabled_get);
+
+/**
+ * d_casefold_enable - check if casefolding may be enabled on a dentry
+ *
+ * Returns -EINVAL if casefolding has been disabled on any parent directory (by
+ * overlayfs).
+ *
+ * On success the inode will hase S_NO_CASEFOLD cleared.
+ */
+int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e)
+{
+	struct dentry *root = dentry->d_sb->s_root;
+	int ret = 0;
+
+	guard(mutex)(&no_casefold_dentries_lock);
+
+	for (struct dentry *i = dentry;
+	     i && i->d_inode->i_flags & S_NO_CASEFOLD;
+	     i = i != root ? i->d_parent : NULL) {
+		ret = darray_push(&e->refs, i);
+		if (ret)
+			goto err;
+
+		ret = no_casefold_dentry_get(i, ref_casefold_enable);
+		if (ret) {
+			darray_pop(&e->refs);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	darray_for_each(e->refs, i)
+		no_casefold_dentry_put(*i, ref_casefold_enable);
+	darray_exit(&e->refs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(d_casefold_enable);
+
+void d_casefold_enable_commit(struct d_casefold_enable *e, int ret)
+{
+	guard(mutex)(&no_casefold_dentries_lock);
+
+	darray_for_each(e->refs, i) {
+		if (!ret) {
+			struct inode *inode = (*i)->d_inode;
+
+			spin_lock(&inode->i_lock);
+			inode->i_flags &= ~S_NO_CASEFOLD;
+			spin_unlock(&inode->i_lock);
+		}
+
+		no_casefold_dentry_put(*i, ref_casefold_enable);
+	}
+	darray_exit(&e->refs);
+}
+EXPORT_SYMBOL_GPL(d_casefold_enable_commit);
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
@@ -3186,6 +3359,10 @@ static void __init dcache_init(void)
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_shortname.string);
 
+	int ret = rhashtable_init(&no_casefold_dentries, &no_casefold_dentries_params);
+	if (ret)
+		panic("error initializing no_casefold_dentries: %s\n", errname(ret));
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e9f07e37dd6f..a386f636b15d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -3,6 +3,7 @@
 #define __LINUX_DCACHE_H
 
 #include <linux/atomic.h>
+#include <linux/darray_types.h>
 #include <linux/list.h>
 #include <linux/math.h>
 #include <linux/rculist.h>
@@ -604,4 +605,13 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+void d_casefold_disabled_put(struct dentry *dentry);
+int d_casefold_disabled_get(struct dentry *dentry);
+
+struct d_casefold_enable {
+	DARRAY(struct dentry *)	refs;
+};
+int d_casefold_enable(struct dentry *dentry, struct d_casefold_enable *e);
+void d_casefold_enable_commit(struct d_casefold_enable *e, int ret);
+
 #endif	/* __LINUX_DCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba942cd2fea1..962a60c9b50d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -48,6 +48,7 @@
 #include <linux/rw_hint.h>
 #include <linux/file_ref.h>
 #include <linux/unicode.h>
+#include <linux/rhashtable-types.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1440,6 +1441,7 @@ struct super_block {
 
 	struct mutex		s_sync_lock;	/* sync serialisation lock */
 
+
 	/*
 	 * Indicates how deep in a filesystem stack this SB is
 	 */
@@ -2345,6 +2347,7 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_NO_CASEFOLD	(1 << 18) /* Directory, and all descendents, are not casefolded */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
-- 
2.49.0


