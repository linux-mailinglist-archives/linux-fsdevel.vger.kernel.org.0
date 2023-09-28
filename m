Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD97B19CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjI1LF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjI1LEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD41CDF;
        Thu, 28 Sep 2023 04:04:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA214C433C8;
        Thu, 28 Sep 2023 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899089;
        bh=/jx6v54okv5rWUdL7DXV1/JPVZXBFihxPBXGVAifEAI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=krfVbC+A5UJYZiJou/wpRVYzcYwLL3aVIIdzaykXDg9QVNW0Qh3AgNBpvtAjTqErO
         MnLftgQldgru27kculVvKhoHtKG6HB+Hza3ERjacv7SXYIjEiXeglgtDIbGAHmQuol
         Ohanmy4hA8m0DKoJZy1v4OD+2QAynC1meUsAN1SmGOQxxN2iG59zxyqwjQqbPMAPI8
         1jmA8FHj2c928me27hkE09wRuFWr8f1wwR61K1ShWnB0+2j3f3bGkF7qxhhGdSS6+A
         apaXdbIVbNhaVWtFw0wZi9cRqjZqDvdJgfqqVjyE5i94PzgdEGMyxwBeTovFk2ZsyJ
         ukvc6x3B2qtEA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/87] fs/exfat: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:41 -0400
Message-ID: <20230928110413.33032-31-jlayton@kernel.org>
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
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/file.c     |  7 +++----
 fs/exfat/inode.c    | 31 +++++++++++++++++--------------
 fs/exfat/misc.c     |  8 ++++++++
 fs/exfat/namei.c    | 31 ++++++++++++++++---------------
 fs/exfat/super.c    |  4 ++--
 6 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f55498e5c23d..f78b614f44dc 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -549,6 +549,7 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_cs);
 void exfat_truncate_atime(struct timespec64 *ts);
+void exfat_truncate_inode_atime(struct inode *inode);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 32395ef686a2..30ee2c8d36a5 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -22,7 +22,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	if (err)
 		return err;
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
 	if (!IS_SYNC(inode))
@@ -290,10 +290,9 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
index 1b9f587f6cca..b92e46916dea 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -569,7 +569,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -582,8 +582,9 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	EXFAT_I(inode)->i_crtime = simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
+
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -816,16 +817,16 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -851,7 +852,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -865,8 +866,8 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto unlock;
 
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode->i_atime = EXFAT_I(inode)->i_crtime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	EXFAT_I(inode)->i_crtime = simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
@@ -977,8 +978,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	ei->dir.dir = DIR_DELETED;
 
 	inode_inc_iversion(dir);
-	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
-	exfat_truncate_atime(&dir->i_atime);
+	simple_inode_init_ts(dir);
+	exfat_truncate_inode_atime(dir);
 	if (IS_DIRSYNC(dir))
 		exfat_sync_inode(dir);
 	else
@@ -986,8 +987,8 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	exfat_truncate_atime(&inode->i_atime);
+	simple_inode_init_ts(inode);
+	exfat_truncate_inode_atime(inode);
 	exfat_unhash_inode(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
@@ -1312,7 +1313,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	inode_inc_iversion(new_dir);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
-	exfat_truncate_atime(&new_dir->i_atime);
+	exfat_truncate_inode_atime(new_dir);
 	if (IS_DIRSYNC(new_dir))
 		exfat_sync_inode(new_dir);
 	else
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 2778bd9b631e..e919a68bf4a1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -370,8 +370,8 @@ static int exfat_read_root(struct inode *inode)
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

