Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD497B8C11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbjJDSzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbjJDSyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77494192;
        Wed,  4 Oct 2023 11:54:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7637DC433C8;
        Wed,  4 Oct 2023 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445663;
        bh=PdvRjpk7Uq2h9jWOsaIRpYPti7242OhJxoh6M5gZNDo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AeoFQ1nOYMJMiJwItTy8f1vsdT50nfGsKewjXG2dMxuRNEL2X+JnZX+0RTeuJS73C
         8ZGVh8s4aXdKTRO6CiM8WUIwugiVBH/MEkPrzQ4x7bZPeX55ijUlG6PFMXMNH3GzpN
         p0VxNsewQXNkUhe1cb8Glh4C6did42Usd8ovfP6NLa3v4F2mRKEs6qMF/qlSS1D4Qx
         B9xsVTMR6v3P2/biD576G49USFvRj3JHBiCAbCDrAHSiCT+2xEgBU5/nUmLWCHeSUN
         n/Wyf7ja8Th97TrLvUJEQimtJtiNTRTOXm1+lZtyrtFKvVh78jcaBQxCH3BV61sS5M
         1DOOVv73uMZWQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/89] exfat: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:18 -0400
Message-ID: <20231004185347.80880-31-jlayton@kernel.org>
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
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     |  7 +++----
 fs/exfat/inode.c    | 31 +++++++++++++++++--------------
 fs/exfat/misc.c     |  8 ++++++++
 fs/exfat/namei.c    | 31 ++++++++++++++++---------------
 fs/exfat/super.c    |  4 ++--
 6 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 219b1cf9d041..b4d3f791a2e0 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -557,6 +557,7 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_cs);
 void exfat_truncate_atime(struct timespec64 *ts);
+void exfat_truncate_inode_atime(struct inode *inode);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f47620eef71b..2a4ec907e42f 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -24,7 +24,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	if (err)
 		return err;
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
 	if (!IS_SYNC(inode))
@@ -292,10 +292,9 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (attr->ia_valid & ATTR_SIZE)
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
-	exfat_truncate_atime(&inode->i_atime);
+	exfat_truncate_inode_atime(inode);
 
 	if (attr->ia_valid & ATTR_SIZE) {
 		error = exfat_block_truncate_page(inode, attr->ia_size);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 13329baeafbc..a2185e6f0548 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -26,6 +26,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	bool is_dir = (ei->type == TYPE_DIR) ? true : false;
+	struct timespec64 ts;
 
 	if (inode->i_ino == EXFAT_ROOT_INO)
 		return 0;
@@ -55,16 +56,18 @@ int __exfat_write_inode(struct inode *inode, int sync)
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
 			&ep->dentry.file.create_time_cs);
-	exfat_set_entry_time(sbi, &inode->i_mtime,
-			&ep->dentry.file.modify_tz,
-			&ep->dentry.file.modify_time,
-			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_cs);
-	exfat_set_entry_time(sbi, &inode->i_atime,
-			&ep->dentry.file.access_tz,
-			&ep->dentry.file.access_time,
-			&ep->dentry.file.access_date,
-			NULL);
+	exfat_set_entry_time(sbi, &ts,
+			     &ep->dentry.file.modify_tz,
+			     &ep->dentry.file.modify_time,
+			     &ep->dentry.file.modify_date,
+			     &ep->dentry.file.modify_time_cs);
+	inode_set_mtime_to_ts(inode, ts);
+	exfat_set_entry_time(sbi, &ts,
+			     &ep->dentry.file.access_tz,
+			     &ep->dentry.file.access_time,
+			     &ep->dentry.file.access_date,
+			     NULL);
+	inode_set_atime_to_ts(inode, ts);
 
 	/* File size should be zero if there is no cluster allocated */
 	on_disk_size = i_size_read(inode);
@@ -355,7 +358,7 @@ static void exfat_write_failed(struct address_space *mapping, loff_t to)
 
 	if (to > i_size_read(inode)) {
 		truncate_pagecache(inode, i_size_read(inode));
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		exfat_truncate(inode);
 	}
 }
@@ -398,7 +401,7 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 		exfat_write_failed(mapping, pos+len);
 
 	if (!(err < 0) && !(ei->attr & ATTR_ARCHIVE)) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		ei->attr |= ATTR_ARCHIVE;
 		mark_inode_dirty(inode);
 	}
@@ -576,10 +579,10 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 	exfat_save_attr(inode, info->attr);
 
 	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >> 9;
-	inode->i_mtime = info->mtime;
+	inode_set_mtime_to_ts(inode, info->mtime);
 	inode_set_ctime_to_ts(inode, info->mtime);
 	ei->i_crtime = info->crtime;
-	inode->i_atime = info->atime;
+	inode_set_atime_to_ts(inode, info->atime);
 
 	return 0;
 }
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 2e1a1a6b1021..fa8459828046 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -126,6 +126,14 @@ void exfat_truncate_atime(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
+void exfat_truncate_inode_atime(struct inode *inode)
+{
+	struct timespec64 atime = inode_get_atime(inode);
+
+	exfat_truncate_atime(&atime);
+	inode_set_atime_to_ts(inode, atime);
+}
+
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type)
 {
 	int i;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1e1ffda279cf..59600cc251ba 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -583,7 +583,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -596,8 +596,9 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	EXFAT_I(inode)->i_crtime = simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
+
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -830,16 +831,16 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
-	exfat_truncate_atime(&dir->i_atime);
+	simple_inode_init_ts(dir);
+	exfat_truncate_inode_atime(dir);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
@@ -865,7 +866,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -879,8 +880,8 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	EXFAT_I(inode)->i_crtime = simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -994,8 +995,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
-	exfat_truncate_atime(&dir->i_atime);
+	simple_inode_init_ts(dir);
+	exfat_truncate_inode_atime(dir);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -1003,8 +1004,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
@@ -1330,7 +1331,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	inode_inc_iversion(new_dir);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
-	exfat_truncate_atime(&new_dir->i_atime);
+	exfat_truncate_inode_atime(new_dir);
 	if (IS_DIRSYNC(new_dir))
 		exfat_sync_inode(new_dir);
 	else
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 17100b13dcdc..17d35107b850 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -377,8 +377,8 @@ static int exfat_read_root(struct inode *inode)
 	ei->i_size_ondisk = i_size_read(inode);
 
 	exfat_save_attr(inode, ATTR_SUBDIR);
-	inode->i_mtime = inode->i_atime = ei->i_crtime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	ei->i_crtime = simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	return 0;
 }
 
-- 
2.41.0

