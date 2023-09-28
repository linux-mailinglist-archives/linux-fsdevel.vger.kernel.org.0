Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732F7B1AD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjI1LXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjI1LWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B42713;
        Thu, 28 Sep 2023 04:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C7C433D9;
        Thu, 28 Sep 2023 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899139;
        bh=cv9SfrcWZVkYk2VwTVipTu4sbLCE/zDatfr5PCjqSsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBWgry+MO4CAf8ojhH5BUiO+kaKaN0QSsdwxd/10AFlKcGJqs3K5H7OpSGFJt0ff7
         zQLqXY+djgEUh96ZgrvVgMWBdKiDWAdLLiZoe6ak1cuQSluttx1lOPfhaeU8N1cRyB
         uf4d1OTYSe2adQMAaOWXYZzqCFm4goKmKAf35sukCRoXD/UU4wTrUd/3svGHJD6drS
         8F5UD3aaykDkCsNTSM51LQWIT1h+oFkeu5HUPp+tpXxk4gspkrjJfcz2pYkBv6+mbD
         s+l2O+THemnyOGnQAOSddW6M94NpYX4Ovg8glIfK8hv+K6QFiayIA4QbXuIHB/mBQX
         l0k4PrQvJ3cNA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org
Subject: [PATCH 72/87] fs/ubifs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:21 -0400
Message-ID: <20230928110413.33032-71-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ubifs/debug.c   |  8 ++++----
 fs/ubifs/dir.c     | 23 +++++++++++++++--------
 fs/ubifs/file.c    | 16 ++++++++--------
 fs/ubifs/journal.c |  8 ++++----
 fs/ubifs/super.c   |  8 ++++----
 5 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index eef9e527d9ff..ef9c39e3f39a 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -237,11 +237,11 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 	pr_err("\tuid            %u\n", (unsigned int)i_uid_read(inode));
 	pr_err("\tgid            %u\n", (unsigned int)i_gid_read(inode));
 	pr_err("\tatime          %u.%u\n",
-	       (unsigned int)inode->i_atime.tv_sec,
-	       (unsigned int)inode->i_atime.tv_nsec);
+	       (unsigned int) inode_get_atime(inode).tv_sec,
+	       (unsigned int) inode_get_atime(inode).tv_nsec);
 	pr_err("\tmtime          %u.%u\n",
-	       (unsigned int)inode->i_mtime.tv_sec,
-	       (unsigned int)inode->i_mtime.tv_nsec);
+	       (unsigned int) inode_get_mtime(inode).tv_sec,
+	       (unsigned int) inode_get_mtime(inode).tv_nsec);
 	pr_err("\tctime          %u.%u\n",
 	       (unsigned int) inode_get_ctime(inode).tv_sec,
 	       (unsigned int) inode_get_ctime(inode).tv_nsec);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2f48c58d47cd..7af442de44c3 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -96,7 +96,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	inode->i_flags |= S_NOCMTIME;
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_mapping->nrpages = 0;
 
 	if (!is_xattr) {
@@ -324,7 +324,8 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -767,7 +768,8 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	inode_set_ctime_current(inode);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -841,7 +843,8 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 	drop_nlink(inode);
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
 	if (err)
 		goto out_cancel;
@@ -944,7 +947,8 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
 	if (err)
 		goto out_cancel;
@@ -1018,7 +1022,8 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	inc_nlink(dir);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err) {
 		ubifs_err(c, "cannot create directory, error %d", err);
@@ -1109,7 +1114,8 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
@@ -1209,7 +1215,8 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_lock(&dir_ui->ui_mutex);
 	dir->i_size += sz_change;
 	dir_ui->ui_size = dir->i_size;
-	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
 	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
 	if (err)
 		goto out_cancel;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index e5382f0b2587..2e65fd2dbdc3 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1088,9 +1088,9 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
 	if (attr->ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (attr->ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (attr->ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
 	if (attr->ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (attr->ia_valid & ATTR_MODE) {
@@ -1192,7 +1192,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 	mutex_lock(&ui->ui_mutex);
 	ui->ui_size = inode->i_size;
 	/* Truncation changes inode [mc]time */
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	/* Other attributes may be changed at the same time as well */
 	do_attr_changes(inode, attr);
 	err = ubifs_jnl_truncate(c, inode, old_size, new_size);
@@ -1239,7 +1239,7 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 	mutex_lock(&ui->ui_mutex);
 	if (attr->ia_valid & ATTR_SIZE) {
 		/* Truncation changes inode [mc]time */
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		/* 'truncate_setsize()' changed @i_size, update @ui_size */
 		ui->ui_size = inode->i_size;
 	}
@@ -1365,9 +1365,9 @@ static inline int mctime_update_needed(const struct inode *inode,
 				       const struct timespec64 *now)
 {
 	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
 
-	if (!timespec64_equal(&inode->i_mtime, now) ||
-	    !timespec64_equal(&ctime, now))
+	if (!timespec64_equal(&mtime, now) || !timespec64_equal(&ctime, now))
 		return 1;
 	return 0;
 }
@@ -1429,7 +1429,7 @@ static int update_mctime(struct inode *inode)
 			return err;
 
 		mutex_lock(&ui->ui_mutex);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		release = ui->dirty;
 		mark_inode_dirty_sync(inode);
 		mutex_unlock(&ui->ui_mutex);
@@ -1567,7 +1567,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 		struct ubifs_inode *ui = ubifs_inode(inode);
 
 		mutex_lock(&ui->ui_mutex);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		release = ui->dirty;
 		mark_inode_dirty_sync(inode);
 		mutex_unlock(&ui->ui_mutex);
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index ffc9beee7be6..79d148357f81 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -452,12 +452,12 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
 	ino->ch.node_type = UBIFS_INO_NODE;
 	ino_key_init_flash(c, &ino->key, inode->i_ino);
 	ino->creat_sqnum = cpu_to_le64(ui->creat_sqnum);
-	ino->atime_sec  = cpu_to_le64(inode->i_atime.tv_sec);
-	ino->atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
+	ino->atime_sec  = cpu_to_le64(inode_get_atime(inode).tv_sec);
+	ino->atime_nsec = cpu_to_le32(inode_get_atime(inode).tv_nsec);
 	ino->ctime_sec  = cpu_to_le64(inode_get_ctime(inode).tv_sec);
 	ino->ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	ino->mtime_sec  = cpu_to_le64(inode->i_mtime.tv_sec);
-	ino->mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	ino->mtime_sec  = cpu_to_le64(inode_get_mtime(inode).tv_sec);
+	ino->mtime_nsec = cpu_to_le32(inode_get_mtime(inode).tv_nsec);
 	ino->uid   = cpu_to_le32(i_uid_read(inode));
 	ino->gid   = cpu_to_le32(i_gid_read(inode));
 	ino->mode  = cpu_to_le32(inode->i_mode);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..366941d4a18a 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -142,10 +142,10 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
 	set_nlink(inode, le32_to_cpu(ino->nlink));
 	i_uid_write(inode, le32_to_cpu(ino->uid));
 	i_gid_write(inode, le32_to_cpu(ino->gid));
-	inode->i_atime.tv_sec  = (int64_t)le64_to_cpu(ino->atime_sec);
-	inode->i_atime.tv_nsec = le32_to_cpu(ino->atime_nsec);
-	inode->i_mtime.tv_sec  = (int64_t)le64_to_cpu(ino->mtime_sec);
-	inode->i_mtime.tv_nsec = le32_to_cpu(ino->mtime_nsec);
+	inode_set_atime(inode, (int64_t)le64_to_cpu(ino->atime_sec),
+			le32_to_cpu(ino->atime_nsec));
+	inode_set_mtime(inode, (int64_t)le64_to_cpu(ino->mtime_sec),
+			le32_to_cpu(ino->mtime_nsec));
 	inode_set_ctime(inode, (int64_t)le64_to_cpu(ino->ctime_sec),
 			le32_to_cpu(ino->ctime_nsec));
 	inode->i_mode = le32_to_cpu(ino->mode);
-- 
2.41.0

