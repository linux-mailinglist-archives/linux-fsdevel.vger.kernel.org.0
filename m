Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1787B8CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbjJDTIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbjJDTHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526E1BE8;
        Wed,  4 Oct 2023 11:55:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6B8C433C8;
        Wed,  4 Oct 2023 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445714;
        bh=Lyh66FBiI7e8TiDJrXRpQ2b/EtHjNFGdpdc1U69mMM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRmjkNuoYWRuOtM4jCGCgTJktUwJYQEz06EM/nSpaqKIDHpr9xt2MhhmP7gMw9XC2
         lqrUeOTEV8ieE0n0+mBF1WYcWOQaYku/qWXCoQY0ND8k5dHRP223m1dya/uMpelCHA
         /a4mNsUpxnbbg+YJm8eRv7wjps5GQlEsc2zbq4/UVvI0PnDlNgNqOYu1mVzYsMVOsr
         JdzDdJGAABNxCR64yaohtDeuN/oI9L+FXtfA0EPIW8m2RQJ8KnLMuymDWLmyv6Eb0b
         6ICGxosl2NxIke5qxk3eflGyVyHufULGnXQGjR9F3ilPRjKpQzspAUWMQwdS+k4MZj
         R2pgUnfxNMHpA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org
Subject: [PATCH v2 73/89] ubifs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:58 -0400
Message-ID: <20231004185347.80880-71-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ubifs/debug.c   | 12 ++++++------
 fs/ubifs/dir.c     | 23 +++++++++++++++--------
 fs/ubifs/file.c    | 16 ++++++++--------
 fs/ubifs/journal.c | 12 ++++++------
 fs/ubifs/super.c   |  8 ++++----
 5 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index eef9e527d9ff..d013c5b3f1ed 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -237,14 +237,14 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 	pr_err("\tuid            %u\n", (unsigned int)i_uid_read(inode));
 	pr_err("\tgid            %u\n", (unsigned int)i_gid_read(inode));
 	pr_err("\tatime          %u.%u\n",
-	       (unsigned int)inode->i_atime.tv_sec,
-	       (unsigned int)inode->i_atime.tv_nsec);
+	       (unsigned int) inode_get_atime_sec(inode),
+	       (unsigned int) inode_get_atime_nsec(inode));
 	pr_err("\tmtime          %u.%u\n",
-	       (unsigned int)inode->i_mtime.tv_sec,
-	       (unsigned int)inode->i_mtime.tv_nsec);
+	       (unsigned int) inode_get_mtime_sec(inode),
+	       (unsigned int) inode_get_mtime_nsec(inode));
 	pr_err("\tctime          %u.%u\n",
-	       (unsigned int) inode_get_ctime(inode).tv_sec,
-	       (unsigned int) inode_get_ctime(inode).tv_nsec);
+	       (unsigned int) inode_get_ctime_sec(inode),
+	       (unsigned int) inode_get_ctime_nsec(inode));
 	pr_err("\tcreat_sqnum    %llu\n", ui->creat_sqnum);
 	pr_err("\txattr_size     %u\n", ui->xattr_size);
 	pr_err("\txattr_cnt      %u\n", ui->xattr_cnt);
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
index ffc9beee7be6..d69d2154645b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -452,12 +452,12 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
 	ino->ch.node_type = UBIFS_INO_NODE;
 	ino_key_init_flash(c, &ino->key, inode->i_ino);
 	ino->creat_sqnum = cpu_to_le64(ui->creat_sqnum);
-	ino->atime_sec  = cpu_to_le64(inode->i_atime.tv_sec);
-	ino->atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	ino->ctime_sec  = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	ino->ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	ino->mtime_sec  = cpu_to_le64(inode->i_mtime.tv_sec);
-	ino->mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	ino->atime_sec  = cpu_to_le64(inode_get_atime_sec(inode));
+	ino->atime_nsec = cpu_to_le32(inode_get_atime_nsec(inode));
+	ino->ctime_sec  = cpu_to_le64(inode_get_ctime_sec(inode));
+	ino->ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
+	ino->mtime_sec  = cpu_to_le64(inode_get_mtime_sec(inode));
+	ino->mtime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 	ino->uid   = cpu_to_le32(i_uid_read(inode));
 	ino->gid   = cpu_to_le32(i_gid_read(inode));
 	ino->mode  = cpu_to_le32(inode->i_mode);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 96f6a9118207..0d0478815d4d 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -138,10 +138,10 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
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

