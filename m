Return-Path: <linux-fsdevel+bounces-42674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DCA459BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9627A5C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AD720E702;
	Wed, 26 Feb 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IKCb3wXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763222425A;
	Wed, 26 Feb 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561309; cv=none; b=pZ6wdhsrZkaJ+h+dnhLUW12uu6QwSEA9QweyjQv+9nHoLWiVK6XFIbD5ZzDXrnj/w+fFHAnpXFR9VmJ+W5M43i69E3xFTLUqk21q+VGJ9XdYiKvY8TyH5eKPtR3YChDt03OCyAsTy38ipk8sZNFK9keHUnTIwmwGK+AR3rtRhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561309; c=relaxed/simple;
	bh=cptNBaPjfXOs+mUZpXk39DhGVRJDBidgxSQQ/bbllIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR6wPGd3axzfPDiJDlxoZUlwkvX9LHvKkjy+akCyvkqT4cipXGI63S1VqbzHZQjgBlgVv+a5GhiHufRgv4Qc2OZhTlFEUnGBjZg2k77WmVT4X4FeSHJqjH3TP4zquV83e9eZrdjUd6fYxkGvYqMb/H2qpJuQt2rR9HPF4CJQv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IKCb3wXp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XGsWM9L+qYvJDimG5h/hMNbfLficLp9CiD9G3jIK4HE=; b=IKCb3wXpZ3/ojY4p2OdH4mjsmu
	VoxPnOw0gDeLsprbjlAP1L6I96+f0cefDOtebdwN0h5zW5Hn9nxLlaUibRjDeDqz3iN5LxRe+o+S8
	zMu/0Y6yuiguMIQc444RnOOXryyhruGXcEmCTjSQWK00sNY1G1h3muIDd+K6p4DCRCAAKu0gj4V7V
	KjfeN+FPAsRlZ2JC8Qn9IiWgjG9SCipycMHB23CizWiEo4sEuStK5DNOzzv41LcoayTN1fMWa5qij
	c2j31kBSXKjthqND85cg4ejdzoMxByRMQnGzZv/cv2Skw3LSxixA9e/SrPd+G/O9Z//Q3q95VnEe0
	4qnmH4gg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnDVA-000s1G-A2; Wed, 26 Feb 2025 10:14:54 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v8] fuse: add more control over cache invalidation behaviour
Date: Wed, 26 Feb 2025 09:14:51 +0000
Message-ID: <20250226091451.11899-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently userspace is able to notify the kernel to invalidate the cache
for an inode.  This means that, if all the inodes in a filesystem need to
be invalidated, then userspace needs to iterate through all of them and do
this kernel notification separately.

This patch adds the concept of 'epoch': each fuse connection will have the
current epoch initialized and every new dentry will have it's d_time set to
the current epoch value.  A new operation will then allow userspace to
increment the epoch value.  Every time a dentry is d_revalidate()'ed, it's
epoch is compared with the current connection epoch and invalidated if it's
value is different.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
Nothing huge since v7, I just realized I forgot to bump the version number
while cleaning up a patch to prepare a libfuse MR.

* Changes since v7
- Bump FUSE interface minor number

* Changes since v6
- Major patch re-write, following a different approach suggested by Miklos
  and Dave.

* Changes since v5
- Added missing iput() in function fuse_reverse_inval_all()

* Changes since v4
- Replaced superblock inodes iteration by a single call to
  invalidate_inodes().  Also do the shrink_dcache_sb() first. (Dave Chinner)

* Changes since v3
- Added comments to clarify semantic changes in fuse_reverse_inval_inode()
  when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
- Added comments to inodes iteration loop to clarify __iget/iput usage
  (suggested by Joanne)
- Dropped get_fuse_mount() call -- fuse_mount can be obtained from
  fuse_ilookup() directly (suggested by Joanne)

(Also dropped the RFC from the subject.)

* Changes since v2
- Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
- Also updated patch description as per checkpatch.pl suggestion.

* Changes since v1
As suggested by Bernd, this patch v2 simply adds an helper function that
will make it easier to replace most of it's code by a call to function
super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.

[1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com

 fs/fuse/dev.c             | 16 ++++++++++++++++
 fs/fuse/dir.c             | 22 +++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  1 +
 fs/fuse/readdir.c         |  3 +++
 include/uapi/linux/fuse.h |  6 +++++-
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b5f789b37eb..e31a55ac3887 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1902,6 +1902,19 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 	return 0;
 }
 
+/*
+ * Increments the fuse connection epoch.  This will result of dentries from
+ * previous epochs to be invalidated.
+ *
+ * XXX optimization: add call to shrink_dcache_sb()?
+ */
+static int fuse_notify_inc_epoch(struct fuse_conn *fc)
+{
+	atomic_inc(&fc->epoch);
+
+	return 0;
+}
+
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
@@ -1930,6 +1943,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	case FUSE_NOTIFY_RESEND:
 		return fuse_notify_resend(fc);
 
+	case FUSE_NOTIFY_INC_EPOCH:
+		return fuse_notify_inc_epoch(fc);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b086ff..5291deeb191f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -200,9 +200,14 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 {
 	struct inode *inode;
 	struct fuse_mount *fm;
+	struct fuse_conn *fc;
 	struct fuse_inode *fi;
 	int ret;
 
+	fc = get_fuse_conn_super(dir->i_sb);
+	if (entry->d_time < atomic_read(&fc->epoch))
+		goto invalid;
+
 	inode = d_inode_rcu(entry);
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
@@ -415,16 +420,20 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  unsigned int flags)
 {
-	int err;
 	struct fuse_entry_out outarg;
+	struct fuse_conn *fc;
 	struct inode *inode;
 	struct dentry *newent;
+	int err, epoch;
 	bool outarg_valid = true;
 	bool locked;
 
 	if (fuse_is_bad(dir))
 		return ERR_PTR(-EIO);
 
+	fc = get_fuse_conn_super(dir->i_sb);
+	epoch = atomic_read(&fc->epoch);
+
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
 			       &outarg, &inode);
@@ -446,6 +455,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	entry = newent ? newent : entry;
+	entry->d_time = epoch;
 	if (outarg_valid)
 		fuse_change_entry_timeout(entry, &outarg);
 	else
@@ -619,7 +629,6 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 			    struct dentry *entry, struct file *file,
 			    unsigned int flags, umode_t mode, u32 opcode)
 {
-	int err;
 	struct inode *inode;
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
@@ -629,11 +638,13 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	int epoch, err;
 	bool trunc = flags & O_TRUNC;
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
 
+	epoch = atomic_read(&fm->fc->epoch);
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
 	if (!forget)
@@ -702,6 +713,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	kfree(forget);
 	d_instantiate(entry, inode);
+	entry->d_time = epoch;
 	fuse_change_entry_timeout(entry, &outentry);
 	fuse_dir_changed(dir);
 	err = generic_file_open(inode, file);
@@ -788,12 +800,14 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	struct dentry *d;
-	int err;
 	struct fuse_forget_link *forget;
+	int epoch, err;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	epoch = atomic_read(&fm->fc->epoch);
+
 	forget = fuse_alloc_forget();
 	if (!forget)
 		return -ENOMEM;
@@ -836,9 +850,11 @@ static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
 		return PTR_ERR(d);
 
 	if (d) {
+		d->d_time = epoch;
 		fuse_change_entry_timeout(d, &outarg);
 		dput(d);
 	} else {
+		entry->d_time = epoch;
 		fuse_change_entry_timeout(entry, &outarg);
 	}
 	fuse_dir_changed(dir);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..06eecc125f89 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -611,6 +611,9 @@ struct fuse_conn {
 	/** Number of fuse_dev's */
 	atomic_t dev_count;
 
+	/** Current epoch for up-to-date dentries */
+	atomic_t epoch;
+
 	struct rcu_head rcu;
 
 	/** The user id for this mount */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..5d2d29fad658 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -959,6 +959,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
+	atomic_set(&fc->epoch, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..46b7146f2c0d 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -161,6 +161,7 @@ static int fuse_direntplus_link(struct file *file,
 	struct fuse_conn *fc;
 	struct inode *inode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	int epoch;
 
 	if (!o->nodeid) {
 		/*
@@ -190,6 +191,7 @@ static int fuse_direntplus_link(struct file *file,
 		return -EIO;
 
 	fc = get_fuse_conn(dir);
+	epoch = atomic_read(&fc->epoch);
 
 	name.hash = full_name_hash(parent, name.name, name.len);
 	dentry = d_lookup(parent, &name);
@@ -256,6 +258,7 @@ static int fuse_direntplus_link(struct file *file,
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
+	dentry->d_time = epoch;
 	fuse_change_entry_timeout(dentry, o);
 
 	dput(dentry);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..15991728a894 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -229,6 +229,9 @@
  *    - FUSE_URING_IN_OUT_HEADER_SZ
  *    - FUSE_URING_OP_IN_OUT_SZ
  *    - enum fuse_uring_cmd
+ *
+ *  7.43
+ *  - add FUSE_NOTIFY_INC_EPOCH
  */
 
 #ifndef _LINUX_FUSE_H
@@ -264,7 +267,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 42
+#define FUSE_KERNEL_MINOR_VERSION 43
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -666,6 +669,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
+	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 

