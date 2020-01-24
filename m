Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD051485B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgAXNN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 08:13:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51729 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389191AbgAXNN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:13:28 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym6-0003aL-DT; Fri, 24 Jan 2020 14:13:26 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0006ZV-5c; Fri, 24 Jan 2020 14:13:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH 8/8] ubifs: Add quota support
Date:   Fri, 24 Jan 2020 14:13:23 +0100
Message-Id: <20200124131323.23885-9-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124131323.23885-1-s.hauer@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces poor man's quota support for UBIFS. Unlike other
implementations we never store anything on the flash. This has two
big advantages:

- No possible regressions with a changed on-disk format
- no quota files can get out of sync.

There are downsides as well:

- During mount the whole index must be scanned which takes some time
- The quota limits must be set manually each time a filesystem is mounted.

UBIFS is targetted for embedded systems and quota limits are likely not
changed interactively, so having to restore the quota limits with a
script shouldn't be a big deal. The mount time penalty is a price we
must pay, but for that we get a simple and straight forward
implementation for this rather rarely used feature.

The quota data itself is stored in a red-black tree in memory. It is
implemented as a quota format. When enabled with the "quota" mount
option all three quota types (user, group, project) are enabled.

The quota integration into UBIFS is taken from a series posted earlier
by Dongsheng Yang. Like the earlier series we only account regular files
for quota. All others are counted in the number of files, but do not
require any quota space.

Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/filesystems/ubifs.txt |   7 +-
 fs/ubifs/Makefile                   |   1 +
 fs/ubifs/dir.c                      |  18 +-
 fs/ubifs/file.c                     |  43 ++
 fs/ubifs/ioctl.c                    |  32 ++
 fs/ubifs/journal.c                  |   2 +
 fs/ubifs/quota.c                    | 603 ++++++++++++++++++++++++++++
 fs/ubifs/super.c                    |  86 +++-
 fs/ubifs/tnc.c                      |   2 +-
 fs/ubifs/ubifs.h                    |  36 ++
 include/uapi/linux/quota.h          |   1 +
 11 files changed, 826 insertions(+), 5 deletions(-)
 create mode 100644 fs/ubifs/quota.c

diff --git a/Documentation/filesystems/ubifs.txt b/Documentation/filesystems/ubifs.txt
index acc80442a3bb..86285aa17cd8 100644
--- a/Documentation/filesystems/ubifs.txt
+++ b/Documentation/filesystems/ubifs.txt
@@ -98,7 +98,12 @@ auth_key=		specify the key used for authenticating the filesystem.
 auth_hash_name=		The hash algorithm used for authentication. Used for
 			both hashing and for creating HMACs. Typical values
 			include "sha256" or "sha512"
-
+usrquota		Enable user disk quota support
+			(requires CONFIG_QUOTA).
+grpquota		Enable group disk quota support
+			(requires CONFIG_QUOTA).
+prjquota		Enable project disk quota support
+			(requires CONFIG_QUOTA).
 
 Quick usage instructions
 ========================
diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 5c4b845754a7..07f657f5ea8f 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -9,3 +9,4 @@ ubifs-y += misc.o
 ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
+ubifs-$(CONFIG_QUOTA) += quota.o
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 06d9192000cb..a4522bb34ca8 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -118,6 +118,11 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	else
 		ui->projid = make_kprojid(&init_user_ns, UBIFS_DEF_PROJID);
 
+	dquot_initialize(inode);
+	err = dquot_alloc_inode(inode);
+	if (err)
+		goto fail_drop;
+
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_mapping->a_ops = &ubifs_file_address_operations;
@@ -158,8 +163,8 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			spin_unlock(&c->cnt_lock);
 			ubifs_err(c, "out of inode numbers");
 			make_bad_inode(inode);
-			iput(inode);
-			return ERR_PTR(-EINVAL);
+			err = -EINVAL;
+			goto fail_free;
 		}
 		ubifs_warn(c, "running out of inode numbers (current %lu, max %u)",
 			   (unsigned long)c->highest_inum, INUM_WATERMARK);
@@ -187,6 +192,13 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	}
 
 	return inode;
+
+fail_free:
+	dquot_free_inode(inode);
+fail_drop:
+	dquot_drop(inode);
+	iput(inode);
+	return ERR_PTR(err);
 }
 
 static int dbg_check_name(const struct ubifs_info *c,
@@ -776,6 +788,8 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 	unsigned int saved_nlink = inode->i_nlink;
 	struct fscrypt_name nm;
 
+	dquot_initialize(inode);
+
 	/*
 	 * Budget request settings: deletion direntry, deletion inode (+1 for
 	 * @dirtied_ino), changing the parent directory inode. If budgeting
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585c8f4f..9ae998febcf1 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -427,8 +427,10 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int quota_size = 0;
 	int skipped_read = 0;
 	struct page *page;
+	int ret = 0;
 
 	ubifs_assert(c, ubifs_inode(inode)->ui_size == inode->i_size);
 	ubifs_assert(c, !c->ro_media && !c->ro_mount);
@@ -436,6 +438,16 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	if (unlikely(c->ro_error))
 		return -EROFS;
 
+	quota_size = ((pos + len) - inode->i_size);
+	if (quota_size < 0)
+		quota_size = 0;
+	if (S_ISREG(inode->i_mode)) {
+		dquot_initialize(inode);
+		ret = dquot_alloc_space_nodirty(inode, quota_size);
+		if (unlikely(ret))
+			return ret;
+	}
+
 	/* Try out the fast-path part first */
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (unlikely(!page))
@@ -541,6 +553,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	loff_t end_pos = pos + len;
+	int quota_size = 0;
 	int appending = !!(end_pos > inode->i_size);
 
 	dbg_gen("ino %lu, pos %llu, pg %lu, len %u, copied %d, i_size %lld",
@@ -559,6 +572,11 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		dbg_gen("copied %d instead of %d, read page and repeat",
 			copied, len);
 		cancel_budget(c, page, ui, appending);
+		quota_size = ((pos + len) - inode->i_size);
+		if (quota_size < 0)
+			quota_size = 0;
+		if (S_ISREG(inode->i_mode))
+			dquot_free_space_nodirty(inode, quota_size);
 		ClearPageChecked(page);
 
 		/*
@@ -1115,6 +1133,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 	int err;
 	struct ubifs_budget_req req;
 	loff_t old_size = inode->i_size, new_size = attr->ia_size;
+	loff_t quota_size = (old_size - new_size);
 	int offset = new_size & (UBIFS_BLOCK_SIZE - 1), budgeted = 1;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
@@ -1194,6 +1213,10 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 	do_attr_changes(inode, attr);
 	err = ubifs_jnl_truncate(c, inode, old_size, new_size);
 	mutex_unlock(&ui->ui_mutex);
+	if (quota_size < 0)
+		quota_size = 0;
+	if (S_ISREG(inode->i_mode))
+		dquot_free_space_nodirty(inode, quota_size);
 
 out_budg:
 	if (budgeted)
@@ -1230,6 +1253,17 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 
 	if (attr->ia_valid & ATTR_SIZE) {
 		dbg_gen("size %lld -> %lld", inode->i_size, new_size);
+		if (S_ISREG(inode->i_mode)) {
+			if (new_size > inode->i_size) {
+				err = dquot_alloc_space_nodirty(inode, new_size - inode->i_size);
+				if (err) {
+					ubifs_release_budget(c, &req);
+					return err;
+				}
+			} else {
+				dquot_free_space_nodirty(inode, inode->i_size - new_size);
+			}
+		}
 		truncate_setsize(inode, new_size);
 	}
 
@@ -1281,6 +1315,15 @@ int ubifs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
+	if (is_quota_modification(inode, attr))
+		dquot_initialize(inode);
+	if ((attr->ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
+	    (attr->ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
+		err = dquot_transfer(inode, attr);
+		if (err)
+			return err;
+	}
+
 	if ((attr->ia_valid & ATTR_SIZE) && attr->ia_size < inode->i_size)
 		/* Truncation to a smaller size */
 		err = do_truncation(c, inode, attr);
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index e5c684b6d7a7..c2c10ebe5780 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -133,16 +133,48 @@ static __u32 ubifs_iflags_to_xflags(unsigned long flags)
         return xflags;
 }
 
+#ifdef CONFIG_QUOTA
+static int ubifs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	struct dquot *transfer_to[MAXQUOTAS] = {};
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct super_block *sb = c->vfs_sb;
+	int err = 0;
+
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
+	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
+	if (!IS_ERR(transfer_to[PRJQUOTA])) {
+		err = __dquot_transfer(inode, transfer_to);
+		dqput(transfer_to[PRJQUOTA]);
+	}
+
+	return err;
+}
+#else
+static int ubifs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	return 0;
+}
+#endif
+
 static int ubifs_ioc_setproject(struct file *file, __u32 projid)
 {
 	struct inode *inode = file_inode(file);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	kprojid_t kprojid;
+	int err;
 
 	kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
 	if (projid_eq(kprojid, ui->projid))
 		return 0;
 
+	err = ubifs_transfer_project_quota(inode, kprojid);
+	if (err)
+		return err;
+
 	ui->projid = kprojid;
 
 	return 0;
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 0a46eefd98a0..efd54dc22c88 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -630,6 +630,8 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 			goto out_finish;
 		}
 		ui->del_cmtno = c->cmt_no;
+		if (S_ISREG(inode->i_mode))
+			dquot_free_space_nodirty((struct inode *)inode, inode->i_size);
 	}
 
 	err = write_head(c, BASEHD, dent, len, &lnum, &dent_offs, sync);
diff --git a/fs/ubifs/quota.c b/fs/ubifs/quota.c
new file mode 100644
index 000000000000..f6a64762d573
--- /dev/null
+++ b/fs/ubifs/quota.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2019 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ */
+#include "ubifs.h"
+
+struct ubifs_dqblk {
+	struct mem_dqblk dqblk;
+	struct rb_node rb;
+	struct kqid kqid;
+};
+
+/**
+ * ubifs_dqblk_insert - find qid in tree
+ * @c: UBIFS file-system description object
+ * @new: The new entry to insert
+ *
+ * This inserts a new entry to the dqblk tree which is sorted by qids. Caller
+ * must make sure this entry doesn't exist already.
+ */
+static void ubifs_dqblk_insert(struct ubifs_info *c, struct ubifs_dqblk *new)
+{
+	struct rb_root *root = &c->dqblk_tree[new->kqid.type];
+	struct rb_node **link = &root->rb_node, *parent = NULL;
+	struct ubifs_dqblk *ud;
+
+	/* Go to the bottom of the tree */
+	while (*link) {
+		parent = *link;
+
+		ud = rb_entry(parent, struct ubifs_dqblk, rb);
+
+		if (qid_lt(new->kqid, ud->kqid))
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
+	}
+
+	/* Put the new node there */
+	rb_link_node(&new->rb, parent, link);
+	rb_insert_color(&new->rb, root);
+}
+
+/**
+ * ubifs_dqblk_find_next - find the next qid
+ * @c: UBIFS file-system description object
+ * @qid: The qid to look for
+ *
+ * Find the next dqblk entry with a qid that is bigger or equally big than the
+ * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
+ * with a qid that is at least equally big.
+ */
+static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
+						 struct kqid qid)
+{
+	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
+	struct ubifs_dqblk *next = NULL;
+
+	while (node) {
+		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
+
+		if (qid_eq(qid, ud->kqid))
+			return ud;
+
+		if (qid_lt(qid, ud->kqid)) {
+			next = ud;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+
+	return next;
+}
+
+/**
+ * ubifs_dqblk_find - find qid in tree
+ * @c: UBIFS file-system description object
+ * @qid: The qid to look for
+ *
+ * This walks the dqblk tree and searches a given qid. Returns the dqblk entry
+ * when found or NULL otherwise.
+ */
+static struct ubifs_dqblk *ubifs_dqblk_find(struct ubifs_info *c,
+					    struct kqid qid)
+{
+	struct ubifs_dqblk *next;
+
+	next = ubifs_dqblk_find_next(c, qid);
+
+	if (next && qid_eq(qid, next->kqid))
+		return next;
+
+	return NULL;
+}
+
+/**
+ * ubifs_dqblk_get - get dqblk entry for given qid
+ * @c: UBIFS file-system description object
+ * @qid: The qid to look for
+ *
+ * This searches the given qid in the dqblk tree and returns it if found. If not,
+ * a new dqblk entry is created, inserted into the dqblk tree and returned.
+ */
+static struct ubifs_dqblk *ubifs_dqblk_get(struct ubifs_info *c,
+					   struct kqid qid)
+{
+	struct ubifs_dqblk *ud;
+
+	ud = ubifs_dqblk_find(c, qid);
+	if (ud)
+		return ud;
+
+	ud = kzalloc(sizeof(*ud), GFP_KERNEL);
+	if (!ud)
+		return NULL;
+
+	ud->kqid = qid;
+
+	ubifs_dqblk_insert(c, ud);
+
+	return ud;
+}
+
+/**
+ * ubifs_check_quota_file - check if quota file is valid for this format
+ * @sb: The superblock
+ * @type: Quota type
+ *
+ * We currently do not store any quota file on flash. It's completely in RAM and
+ * thus always valid.
+ */
+static int ubifs_check_quota_file(struct super_block *sb, int type)
+{
+	return 1;
+}
+
+/**
+ * ubifs_read_file_info - read quota file info
+ * @sb: The superblock
+ * @type: Quota type
+ *
+ * We currently do not store any quota info on flash. Just fill in default
+ * values.
+ */
+static int ubifs_read_file_info(struct super_block *sb, int type)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct mem_dqinfo *info = &dqopt->info[type];
+
+	down_read(&dqopt->dqio_sem);
+
+	/*
+	 * Used space is stored as unsigned 64-bit value in bytes but
+	 * quota core supports only signed 64-bit values so use that
+	 * as a limit
+	 */
+	info->dqi_max_spc_limit = 0x7fffffffffffffffLL; /* 2^63-1 */
+	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
+	info->dqi_bgrace = 0;
+	info->dqi_igrace = 0;
+	info->dqi_flags = 0;
+
+	up_read(&dqopt->dqio_sem);
+
+	return 0;
+}
+
+/**
+ * ubifs_write_file_info - write quota file to device
+ * @sb: The superblock
+ * @type: Quota type
+ *
+ * We currently do not store any quota file on flash. Nothing to do here.
+ */
+static int ubifs_write_file_info(struct super_block *sb, int type)
+{
+	return 0;
+}
+
+/**
+ * ubifs_read_dquot - read dquot from device
+ * @dquot: The dquot entry to read
+ *
+ * For us this means finding the entry in the dquot tree.
+ */
+static int ubifs_read_dquot(struct dquot *dquot)
+{
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct ubifs_info *c = dquot->dq_sb->s_fs_info;
+	struct ubifs_dqblk *ud;
+	int ret = 0;
+
+	down_read(&dqopt->dqio_sem);
+
+	ud = ubifs_dqblk_find(c, dquot->dq_id);
+	if (ud)
+		dquot->dq_dqb = ud->dqblk;
+	else
+		ret = -ENOENT;
+
+	up_read(&dqopt->dqio_sem);
+
+	return 0;
+}
+
+/**
+ * ubifs_write_dquot - write dquot to device
+ * @dquot: The dquot entry to read
+ *
+ * For us this means finding or creating the entry in the dquot tree and setting
+ * it to the dquots contents.
+ */
+static int ubifs_write_dquot(struct dquot *dquot)
+{
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct ubifs_info *c = dquot->dq_sb->s_fs_info;
+	int ret = 0;
+	struct ubifs_dqblk *ud;
+
+	down_write(&dqopt->dqio_sem);
+
+	ud = ubifs_dqblk_get(c, dquot->dq_id);
+	if (!ud) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ud->dqblk = dquot->dq_dqb;
+
+out:
+	up_write(&dqopt->dqio_sem);
+
+	return ret;
+}
+
+/**
+ * ubifs_release_dquot - release memory associated to a dquot entry
+ * @dquot: The dquot entry
+ *
+ * Nothing to do here, we didn't allocate anything. Our data is freed at unmount
+ * time.
+ */
+static int ubifs_release_dquot(struct dquot *dquot)
+{
+	return 0;
+}
+
+/**
+ * ubifs_free_file_info - free memory allocated during reading the file info
+ * @sb: The superblock
+ * @type: Quota type
+ *
+ * Nothing to do here.
+ */
+static int ubifs_free_file_info(struct super_block *sb, int type)
+{
+	return 0;
+}
+
+static int ubifs_get_next_id(struct super_block *sb, struct kqid *qid)
+{
+	struct quota_info *dqopt = sb_dqopt(sb);
+	struct ubifs_info *c = sb->s_fs_info;
+	struct ubifs_dqblk *ud;
+	int ret = 0;
+
+	down_read(&dqopt->dqio_sem);
+
+	ud = ubifs_dqblk_find_next(c, *qid);
+	if (!ud) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	*qid = ud->kqid;
+out:
+	up_read(&dqopt->dqio_sem);
+
+	return ret;
+}
+
+static const struct quota_format_ops ubifs_format_ops = {
+	.check_quota_file	= ubifs_check_quota_file,
+	.read_file_info		= ubifs_read_file_info,
+	.write_file_info	= ubifs_write_file_info,
+	.free_file_info		= ubifs_free_file_info,
+	.read_dqblk		= ubifs_read_dquot,
+	.commit_dqblk		= ubifs_write_dquot,
+	.release_dqblk		= ubifs_release_dquot,
+	.get_next_id		= ubifs_get_next_id,
+};
+
+/**
+ * add_inode_quota - read quota informations for an inode
+ * @c: UBIFS file-system description object
+ * @zbr: The zbranch to read the inode from
+ *
+ * This reads the inode as referred to by @zbr from the medium and
+ * extracts the quota relevant informations. Returns 0 for success
+ * or a negative error code otherwise.
+ */
+static int add_inode_quota(struct ubifs_info *c, struct ubifs_zbranch *zbr)
+{
+	struct ubifs_ino_node *ino;
+	int err, type = key_type(c, &zbr->key);
+	struct kqid qid[MAXQUOTAS];
+	kprojid_t kprojid;
+	kgid_t kgid;
+	kuid_t kuid;
+	int i;
+
+	if (type != UBIFS_INO_KEY) {
+		ubifs_err(c, "%s called on non INO node %d", __func__, type);
+		return 0;
+	}
+
+	if (zbr->len < UBIFS_CH_SZ) {
+		ubifs_err(c, "bad leaf length %d (LEB %d:%d)",
+				zbr->len, zbr->lnum, zbr->offs);
+		return -EINVAL;
+	}
+
+	ino = kmalloc(zbr->len, GFP_NOFS);
+	if (!ino)
+		return -ENOMEM;
+
+	err = ubifs_tnc_read_node(c, zbr, ino);
+	if (err) {
+		ubifs_err(c, "cannot read leaf node at LEB %d:%d, error %d",
+				zbr->lnum, zbr->offs, err);
+		goto out_free;
+	}
+
+	kuid = make_kuid(&init_user_ns, le32_to_cpu(ino->uid));
+	qid[USRQUOTA] = make_kqid_uid(kuid);
+
+	kgid = make_kgid(&init_user_ns, le32_to_cpu(ino->gid));
+	qid[GRPQUOTA] = make_kqid_gid(kgid);
+
+	kprojid = make_kprojid(&init_user_ns, le32_to_cpu(ino->projid));
+	qid[PRJQUOTA] = make_kqid_projid(kprojid);
+
+	for (i = 0; i < UBIFS_MAXQUOTAS; i++) {
+		struct ubifs_dqblk *ud;
+
+		if (!(c->quota_enable & (1 << type)))
+			continue;
+
+		ud = ubifs_dqblk_get(c, qid[i]);
+		if (!ud) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		if (S_ISREG(le32_to_cpu(ino->mode)))
+			ud->dqblk.dqb_curspace += le64_to_cpu(ino->size);
+		ud->dqblk.dqb_curinodes++;
+	}
+
+	err = 0;
+
+out_free:
+	kfree(ino);
+
+	return err;
+}
+
+/**
+ * get_next_parent_inum - get the next inum
+ * @c: UBIFS file-system description object
+ * @znode: The znode to start searching from
+ * @inum: The next inum returned here
+ *
+ * Helper function for ubifs_quota_walk_index(). If we know the next inum we
+ * find up the tree is still the same as we just handled we do not have to walk
+ * down the tree but can skip these branches. Returns 0 for success or -ENOENT
+ * when we can't go further to the upper-right but hit the root node instead.
+ */
+static int get_next_parent_inum(struct ubifs_info *c, struct ubifs_znode *znode,
+				ino_t *inum)
+{
+	struct ubifs_znode *zp;
+
+	while (1) {
+		int nn;
+
+		zp = znode->parent;
+		if (!zp)
+			return -ENOENT;
+
+		nn = znode->iip + 1;
+		znode = zp;
+
+		if (nn < znode->child_cnt) {
+			*inum = key_inum(c, &znode->zbranch[nn].key);
+			return 0;
+		}
+	}
+}
+
+/**
+ * ubifs_quota_walk_index - Collect quota info
+ * @c: UBIFS file-system description object
+ *
+ * This function walks the whole index and collects the quota usage information
+ * for all inodes. Returns 0 for success or a negative error code otherwise.
+ */
+static int ubifs_quota_walk_index(struct ubifs_info *c)
+{
+	int err;
+	struct ubifs_znode *znode;
+	int i, nn = 0;
+	ino_t inum = 0, pinum;
+
+	if (!c->zroot.znode) {
+		c->zroot.znode = ubifs_load_znode(c, &c->zroot, NULL, 0);
+		if (IS_ERR(c->zroot.znode)) {
+			err = PTR_ERR(c->zroot.znode);
+			c->zroot.znode = NULL;
+			return err;
+		}
+	}
+
+	znode = c->zroot.znode;
+
+	while (1) {
+		while (znode->level != 0) {
+			znode = ubifs_get_znode(c, znode, nn);
+			if (IS_ERR(znode))
+				return PTR_ERR(znode);
+			nn = 0;
+		}
+
+		for (i = 0; i < znode->child_cnt; i++) {
+			if (inum == key_inum(c, &znode->zbranch[i].key))
+				continue;
+
+			add_inode_quota(c, &znode->zbranch[i]);
+			inum = key_inum(c, &znode->zbranch[i].key);
+		}
+
+		while (1) {
+			struct ubifs_znode *zp;
+
+			zp = znode->parent;
+			if (!zp)
+				return 0;
+
+			nn = znode->iip + 1;
+			znode = zp;
+
+			err = get_next_parent_inum(c, znode, &pinum);
+
+			/*
+			 * Optimization: When the next parent node is still for
+			 * the inode we just handled we can skip parsing our
+			 * children.
+			 */
+			if (!err && pinum == inum)
+				continue;
+
+			/*
+			 * Optimization: We can skip scanning all child nodes
+			 * which are for the same inode as we already looked at.
+			 */
+			while (nn < znode->child_cnt - 1 &&
+			       inum == key_inum(c, &znode->zbranch[nn + 1].key))
+				nn++;
+
+			if (nn < znode->child_cnt)
+				break;
+		}
+	}
+}
+
+/**
+ * ubifs_enable_quotas - enable quota
+ * @c: UBIFS file-system description object
+ *
+ * Enable usage tracking for all quota types.
+ */
+int ubifs_enable_quotas(struct ubifs_info *c)
+{
+	struct super_block *sb = c->vfs_sb;
+	struct quota_info *dqopt = sb_dqopt(sb);
+	int type, ret;
+
+	if (!c->quota_enable)
+		return 0;
+
+	dqopt->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
+
+	for (type = 0; type < UBIFS_MAXQUOTAS; type++) {
+		if (!(c->quota_enable & (1 << type)))
+			continue;
+
+		ret = dquot_load_quota_sb(sb, type, QFMT_UBIFS,
+				   DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
+		if (ret)
+			goto out_quota_off;
+
+		c->dqblk_tree[type] = RB_ROOT;
+	}
+
+	return ubifs_quota_walk_index(c);
+
+out_quota_off:
+	ubifs_disable_quotas(c);
+
+	return ret;
+}
+
+/**
+ * ubifs_disable_quotas - disable quota
+ * @c: UBIFS file-system description object
+ *
+ * Disable quota for UBFIS.
+ */
+void ubifs_disable_quotas(struct ubifs_info *c)
+{
+	struct rb_node *n;
+	struct ubifs_dqblk *ud;
+	int type;
+
+	if (!c->quota_enable)
+		return;
+
+	dquot_disable(c->vfs_sb, -1, DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
+
+	for (type = 0; type < UBIFS_MAXQUOTAS; type++) {
+		while ((n = rb_first(&c->dqblk_tree[type]))) {
+			ud = rb_entry(n, struct ubifs_dqblk, rb);
+			rb_erase(n, &c->dqblk_tree[type]);
+			kfree(ud);
+		}
+	}
+}
+
+static int ubifs_get_projid(struct inode *inode, kprojid_t *projid)
+{
+	struct ubifs_inode *ui = ubifs_inode(inode);
+
+	*projid = ui->projid;
+
+	return 0;
+}
+
+static const struct dquot_operations ubifs_dquot_operations = {
+	.write_dquot	= dquot_commit,
+	.acquire_dquot	= dquot_acquire,
+	.release_dquot	= dquot_release,
+	.mark_dirty	= dquot_mark_dquot_dirty,
+	.write_info	= dquot_commit_info,
+	.alloc_dquot	= dquot_alloc,
+	.destroy_dquot	= dquot_destroy,
+	.get_next_id	= dquot_get_next_id,
+	.get_projid	= ubifs_get_projid,
+};
+
+static const struct quotactl_ops ubifs_quotactl_ops = {
+	.get_state	= dquot_get_state,
+	.set_info	= dquot_set_dqinfo,
+	.get_dqblk	= dquot_get_dqblk,
+	.set_dqblk	= dquot_set_dqblk,
+	.get_nextdqblk	= dquot_get_next_dqblk,
+};
+
+static struct quota_format_type ubifs_quota_format = {
+	.qf_fmt_id	= QFMT_UBIFS,
+	.qf_ops		= &ubifs_format_ops,
+	.qf_owner	= THIS_MODULE
+};
+
+int ubifs_register_quota_format(void)
+{
+	return register_quota_format(&ubifs_quota_format);
+}
+
+void ubifs_unregister_quota_format(void)
+{
+	return unregister_quota_format(&ubifs_quota_format);
+}
+
+/**
+ * ubifs_init_quota - init quota ops for UBIFS
+ * @c: UBIFS file-system description object
+ *
+ * This inits the quota operations for UBIFS
+ */
+void ubifs_init_quota(struct ubifs_info *c)
+{
+	struct super_block *sb = c->vfs_sb;
+
+	if (!c->quota_enable)
+		return;
+
+	sb->dq_op = &ubifs_dquot_operations;
+	sb->s_qcop = &ubifs_quotactl_ops;
+	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
+}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index e702fb4e92cf..e2af9ccea301 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -151,6 +151,7 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
+		inode_set_bytes(inode, ino->size);
 		inode->i_mapping->a_ops = &ubifs_file_address_operations;
 		inode->i_op = &ubifs_file_inode_operations;
 		inode->i_fop = &ubifs_file_operations;
@@ -354,6 +355,7 @@ static void ubifs_evict_inode(struct inode *inode)
 	if (is_bad_inode(inode))
 		goto out;
 
+	dquot_initialize(inode);
 	ui->ui_size = inode->i_size = 0;
 	err = ubifs_jnl_delete_inode(c, inode);
 	if (err)
@@ -363,7 +365,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		 */
 		ubifs_err(c, "can't delete inode %lu, error %d",
 			  inode->i_ino, err);
-
+	dquot_free_inode(inode);
 out:
 	if (ui->dirty)
 		ubifs_release_dirty_inode_budget(c, ui);
@@ -373,6 +375,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		smp_wmb();
 	}
 done:
+	dquot_drop(inode);
 	clear_inode(inode);
 	fscrypt_put_encryption_info(inode);
 }
@@ -435,6 +438,13 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
 	else if (c->mount_opts.chk_data_crc == 1)
 		seq_puts(s, ",no_chk_data_crc");
 
+	if (c->quota_enable & (1 << USRQUOTA))
+		seq_puts(s, ",usrquota");
+	if (c->quota_enable & (1 << GRPQUOTA))
+		seq_puts(s, ",grpquota");
+	if (c->quota_enable & (1 << PRJQUOTA))
+		seq_puts(s, ",prjquota");
+
 	if (c->mount_opts.override_compr) {
 		seq_printf(s, ",compr=%s",
 			   ubifs_compr_name(c, c->mount_opts.compr_type));
@@ -927,6 +937,29 @@ static int check_volume_empty(struct ubifs_info *c)
 	return 0;
 }
 
+#ifdef CONFIG_QUOTA
+static struct dquot **ubifs_get_dquots(struct inode *inode)
+{
+	return ubifs_inode(inode)->i_dquot;
+}
+
+static ssize_t ubifs_quota_read(struct super_block *sb, int type, char *data,
+				size_t len, loff_t off)
+{
+	BUG();
+
+	return 0;
+}
+
+static ssize_t ubifs_quota_write(struct super_block *sb, int type, const char *data,
+				 size_t len, loff_t off)
+{
+	BUG();
+
+	return 0;
+}
+#endif
+
 /*
  * UBIFS mount options.
  *
@@ -954,6 +987,9 @@ enum {
 	Opt_auth_key,
 	Opt_auth_hash_name,
 	Opt_ignore,
+	Opt_usrquota,
+	Opt_grpquota,
+	Opt_prjquota,
 	Opt_err,
 };
 
@@ -970,6 +1006,9 @@ static const match_table_t tokens = {
 	{Opt_ignore, "ubi=%s"},
 	{Opt_ignore, "vol=%s"},
 	{Opt_assert, "assert=%s"},
+	{Opt_usrquota, "usrquota"},
+	{Opt_grpquota, "grpquota"},
+	{Opt_prjquota, "prjquota"},
 	{Opt_err, NULL},
 };
 
@@ -1104,6 +1143,23 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
 			break;
 		case Opt_ignore:
 			break;
+#ifdef CONFIG_QUOTA
+		case Opt_usrquota:
+			c->quota_enable |= 1 << USRQUOTA;
+			break;
+		case Opt_grpquota:
+			c->quota_enable |= 1 << GRPQUOTA;
+			break;
+		case Opt_prjquota:
+			c->quota_enable |= 1 << PRJQUOTA;
+			break;
+#else
+		case Opt_usrquota:
+		case Opt_grpquota:
+		case Opt_prjquota:
+			ubifs_err(c, "quota operations not supported");
+			break;
+#endif
 		default:
 		{
 			unsigned long flag;
@@ -1800,6 +1856,7 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		 */
 		err = dbg_check_space_info(c);
 	}
+	c->vfs_sb->s_flags &= ~SB_RDONLY;
 
 	mutex_unlock(&c->umount_mutex);
 	return err;
@@ -1869,6 +1926,7 @@ static void ubifs_remount_ro(struct ubifs_info *c)
 	err = dbg_check_space_info(c);
 	if (err)
 		ubifs_ro_mode(c, err);
+	c->vfs_sb->s_flags |= SB_RDONLY;
 	mutex_unlock(&c->umount_mutex);
 }
 
@@ -1879,6 +1937,8 @@ static void ubifs_put_super(struct super_block *sb)
 
 	ubifs_msg(c, "un-mount UBI device %d", c->vi.ubi_num);
 
+	ubifs_disable_quotas(c);
+
 	/*
 	 * The following asserts are only valid if there has not been a failure
 	 * of the media. For example, there will be dirty inodes if we failed
@@ -1976,11 +2036,17 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 		err = ubifs_remount_rw(c);
 		if (err)
 			return err;
+		err = dquot_resume(sb, -1);
+		if (err)
+			return err;
 	} else if (!c->ro_mount && (*flags & SB_RDONLY)) {
 		if (c->ro_error) {
 			ubifs_msg(c, "cannot re-mount R/O due to prior errors");
 			return -EROFS;
 		}
+		err = dquot_suspend(sb, -1);
+		if (err)
+			return err;
 		ubifs_remount_ro(c);
 	}
 
@@ -2012,6 +2078,11 @@ const struct super_operations ubifs_super_operations = {
 	.remount_fs    = ubifs_remount_fs,
 	.show_options  = ubifs_show_options,
 	.sync_fs       = ubifs_sync_fs,
+#ifdef CONFIG_QUOTA
+	.get_dquots    = ubifs_get_dquots,
+	.quota_read    = ubifs_quota_read,
+	.quota_write   = ubifs_quota_write,
+#endif
 };
 
 /**
@@ -2172,6 +2243,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 	fscrypt_set_ops(sb, &ubifs_crypt_operations);
 
+	ubifs_init_quota(c);
+
 	mutex_lock(&c->umount_mutex);
 	err = mount_ubifs(c);
 	if (err) {
@@ -2186,6 +2259,10 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 
+	err = ubifs_enable_quotas(c);
+	if (err)
+		goto out_umount;
+
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		err = -ENOMEM;
@@ -2392,6 +2469,10 @@ static int __init ubifs_init(void)
 
 	dbg_debugfs_init();
 
+	err = ubifs_register_quota_format();
+	if (err)
+		goto out_compressors;
+
 	err = register_filesystem(&ubifs_fs_type);
 	if (err) {
 		pr_err("UBIFS error (pid %d): cannot register file system, error %d",
@@ -2402,6 +2483,8 @@ static int __init ubifs_init(void)
 
 out_dbg:
 	dbg_debugfs_exit();
+	ubifs_unregister_quota_format();
+out_compressors:
 	ubifs_compressors_exit();
 out_shrinker:
 	unregister_shrinker(&ubifs_shrinker_info);
@@ -2427,6 +2510,7 @@ static void __exit ubifs_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(ubifs_inode_slab);
+	ubifs_unregister_quota_format();
 	unregister_filesystem(&ubifs_fs_type);
 }
 module_exit(ubifs_exit);
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 188fa036e655..624568365ad3 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -600,7 +600,7 @@ struct ubifs_znode *ubifs_get_znode(struct ubifs_info *c,
  * This function returns %0 if the next TNC entry is found, %-ENOENT if there is
  * no next entry, or a negative error code otherwise.
  */
-static int tnc_next(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
+int tnc_next(struct ubifs_info *c, struct ubifs_znode **zn, int *n)
 {
 	struct ubifs_znode *znode = *zn;
 	int nn = *n;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 66c7ed0dc610..285472100b96 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -27,6 +27,7 @@
 #include <linux/security.h>
 #include <linux/xattr.h>
 #include <linux/random.h>
+#include <linux/quotaops.h>
 #include <crypto/hash_info.h>
 #include <crypto/hash.h>
 #include <crypto/algapi.h>
@@ -157,6 +158,8 @@
 
 #define UBIFS_DEF_PROJID 0
 
+#define UBIFS_MAXQUOTAS 3
+
 /*
  * Lockdep classes for UBIFS inode @ui_mutex.
  */
@@ -416,6 +419,9 @@ struct ubifs_inode {
 	loff_t synced_i_size;
 	loff_t ui_size;
 	int flags;
+#ifdef CONFIG_QUOTA
+	struct dquot *i_dquot[UBIFS_MAXQUOTAS];
+#endif
 	kprojid_t projid;
 	pgoff_t last_page_read;
 	pgoff_t read_in_a_row;
@@ -1045,6 +1051,7 @@ struct ubifs_debug_info;
  * @rw_incompat: the media is not R/W compatible
  * @assert_action: action to take when a ubifs_assert() fails
  * @authenticated: flag indigating the FS is mounted in authenticated mode
+ * @quota_enable: If true, quota is enabled on this filesystem
  *
  * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, and
  *             @calc_idx_sz
@@ -1386,6 +1393,9 @@ struct ubifs_info {
 	struct ubi_device_info di;
 	struct ubi_volume_info vi;
 
+	unsigned int quota_enable;
+	struct rb_root dqblk_tree[UBIFS_MAXQUOTAS];
+
 	struct rb_root orph_tree;
 	struct list_head orph_list;
 	struct list_head orph_new;
@@ -2109,6 +2119,32 @@ static inline bool ubifs_crypt_is_encrypted(const struct inode *inode)
 	return ui->flags & UBIFS_CRYPT_FL;
 }
 
+/* quota.c */
+#ifdef CONFIG_QUOTA
+int ubifs_register_quota_format(void);
+void ubifs_unregister_quota_format(void);
+void ubifs_init_quota(struct ubifs_info *c);
+int ubifs_enable_quotas(struct ubifs_info *c);
+void ubifs_disable_quotas(struct ubifs_info *c);
+#else
+static inline int ubifs_register_quota_format(void)
+{
+	return 0;
+}
+static inline void ubifs_unregister_quota_format(void)
+{
+}
+static inline void ubifs_init_quota(struct ubifs_info *c)
+{
+}
+static inline int ubifs_enable_quotas(struct ubifs_info *c)
+{
+	return 0;
+}
+static inline void ubifs_disable_quotas(struct ubifs_info *c)
+{
+}
+#endif
 /* Normal UBIFS messages */
 __printf(2, 3)
 void ubifs_msg(const struct ubifs_info *c, const char *fmt, ...);
diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
index e1787c0df601..7082868ca225 100644
--- a/include/uapi/linux/quota.h
+++ b/include/uapi/linux/quota.h
@@ -78,6 +78,7 @@
 #define	QFMT_VFS_V0 2
 #define QFMT_OCFS2 3
 #define	QFMT_VFS_V1 4
+#define QFMT_UBIFS 5
 
 /* Size of block in which space limits are passed through the quota
  * interface */
-- 
2.25.0

