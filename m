Return-Path: <linux-fsdevel+bounces-42181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1492AA3E121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F151175E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC6212FA6;
	Thu, 20 Feb 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f6nbWaKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C21DF75B;
	Thu, 20 Feb 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069811; cv=none; b=gOBi+qIXgwAel+QycMhGxAm6qmG5ULfA6RZe9NkKXISXiwtRS0CogVrBDBNybkVDZS3/gv/ZaAadC3WxYY/P37wOi1J9x+y1H+sGvyQAH7cMl9mZtHyqJZnNWzhwFYo201kG7D6p28zxRW/OECi9SfoJysUlFW7skH7VwuPJZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069811; c=relaxed/simple;
	bh=phxcr1cxH4tRKwtEfmiV/Qbkt/JDOYi2XFaLYGMjwbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9aU7bcW7n5I7ufXBg6nnwxyErwJw9zq0Htw8r4uIGuFUG9JOeQ+xjLI50S5fpqksqGw16aemhoX2vhZk8BEL6AkmbPfQvu5IvTkMkWaxt9e2n9L9mQal7BHJ/f1BPuFTFxO1blX4+nr5RQY7eglDOdWvs3Cd1YI6EwrhXG6Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f6nbWaKL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y7LQRfx7NavRP4OmSyJx+0zxVZNt31eC/zx9JMiQjZE=; b=f6nbWaKL9Fa0i7Z84YvVtiEtPm
	XhcbHZ/VNymg4/HSYUUPhJ5ZqcM4t1eSgVQhInYfCJJVINeNh5K1ZDExgF+N2SSEBW+cew7iCBDjw
	3j1S6v3MXi7hohojmC2kVm+UTPqBQmlweAKCguS0Zu3DZaFFgi/vWR4OlK3cCuUnAOppksCMEn1Cx
	osVB76WVuq4xgNy5tQO/62/FpMGIQ1R/k9mlOond+YfrIEWSN6c6gyr/6vlqT5E/hY2h3VJ6YfUzE
	XrAau7oKxwWdyO1KH93QCLzqDbMyXKfWPdz1cmVtmRvBal5AY7bNLkt22RuQrIojvJo9Nu4+puGMY
	CyRei/uw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl9dm-00FSMu-TV; Thu, 20 Feb 2025 17:43:16 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v7] fuse: add more control over cache invalidation behaviour
Date: Thu, 20 Feb 2025 16:43:13 +0000
Message-ID: <20250220164313.12932-1-luis@igalia.com>
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
Hi!

Here's a new version of this patch.  I've left an 'XXX' comment about
adding an explicit call to shrink_dcache_sb() in the new notify operation
function.

[ That function fuse_notify_update_epoch() could actually be inlined into
  fuse_notify() if nothing else is added there. ]

Obviously, I'll also need to take care of adding the new operation to the
userspace libfuse.

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
 include/uapi/linux/fuse.h |  1 +
 6 files changed, 43 insertions(+), 3 deletions(-)

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
index 5e0eb41d967e..4c84af7cbd0e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -666,6 +666,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
+	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 

