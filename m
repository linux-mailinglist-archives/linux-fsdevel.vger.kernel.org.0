Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D974F5ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiDFMxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiDFMxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:53:08 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A27A987
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 01:55:05 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1649235303; bh=u1yYG5zGRiu7B3V8XTpA9iNMqfc/c6W9vdXWRB0/16U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iCLXmgTALLvi2wnVGpyLVbtiqyUK3YDZBEc5OSTclXblfNTuXLHepHeUDsMaeXld2
         4HX56xRCNYc4VfAiZZoMdmncH5nYSgB4QTFWZbSA8f45d7EDn9i6O8dGcRWI/3nVdK
         waIPx1I1O7pjxcjKhqI8I6sBa4byz6eKOz/CHjrc=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 2/3] fat: make ctime and mtime identical explicitly
Date:   Wed,  6 Apr 2022 16:54:58 +0800
Message-Id: <20220406085459.102691-2-cccheng@synology.com>
In-Reply-To: <20220406085459.102691-1-cccheng@synology.com>
References: <20220406085459.102691-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAT supports creation time but not change time, and there was no
corresponding timestamp for creation time in previous VFS. The
original implementation took the compromise of saving the in-memory
change time into the on-disk creation time field, but this would lead
to compatibility issues with non-linux systems.

In address this issue, this patch changes the behavior of ctime. ctime
will no longer be loaded and stored from the creation time on disk.
Instead of that, it'll be consistent with the in-memory mtime and
share the same on-disk field.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/dir.c         |  2 +-
 fs/fat/file.c        |  4 ++++
 fs/fat/inode.c       | 11 ++++-------
 fs/fat/misc.c        | 11 ++++++++---
 fs/fat/namei_msdos.c |  6 +++---
 fs/fat/namei_vfat.c  |  6 +++---
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 249825017da7..0ae0dfe278fb 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1068,7 +1068,7 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 		}
 	}
 
-	fat_truncate_time(dir, NULL, S_ATIME|S_MTIME);
+	fat_truncate_time(dir, NULL, S_ATIME|S_CTIME|S_MTIME);
 	if (IS_DIRSYNC(dir))
 		(void)fat_sync_inode(dir);
 	else
diff --git a/fs/fat/file.c b/fs/fat/file.c
index a5a309fcc7fa..178c1dde3488 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -544,6 +544,10 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	/*
 	 * setattr_copy can't truncate these appropriately, so we'll
 	 * copy them ourselves
+	 *
+	 * fat_truncate_time() keeps ctime and mtime the same. if both
+	 * ctime and mtime are need to update here, mtime will overwrite
+	 * ctime
 	 */
 	if (attr->ia_valid & ATTR_ATIME)
 		fat_truncate_time(inode, &attr->ia_atime, S_ATIME);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bf6051bdf1d1..f2ac55cd4ea4 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -567,12 +567,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
-	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
-				  de->cdate, de->ctime_cs);
+	inode->i_ctime = inode->i_mtime;
+	if (sbi->options.isvfat)
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
-	} else
-		fat_truncate_time(inode, &inode->i_mtime, S_ATIME|S_CTIME);
+	else
+		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
 
 	return 0;
 }
@@ -888,8 +887,6 @@ static int __fat_write_inode(struct inode *inode, int wait)
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
-		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
-				  &raw_entry->cdate, &raw_entry->ctime_cs);
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
 	}
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index c87df64f8b2b..71e6dadf12a2 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -341,10 +341,15 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 
 	if (flags & S_ATIME)
 		fat_truncate_atime(sbi, now, &inode->i_atime);
-	if (flags & S_CTIME)
-		fat_truncate_crtime(sbi, now, &inode->i_ctime);
-	if (flags & S_MTIME)
+
+	/*
+	 * ctime and mtime share the same on-disk field, and should be
+	 * identical in memory.
+	 */
+	if (flags & (S_CTIME|S_MTIME)) {
 		fat_truncate_mtime(sbi, now, &inode->i_mtime);
+		inode->i_ctime = inode->i_mtime;
+	}
 
 	return 0;
 }
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index efba301d68ae..b2760a716707 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -328,7 +328,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	fat_truncate_time(inode, NULL, S_CTIME);
+	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);
 	fat_detach(inode);
 out:
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
@@ -415,7 +415,7 @@ static int msdos_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 	clear_nlink(inode);
-	fat_truncate_time(inode, NULL, S_CTIME);
+	fat_truncate_time(inode, NULL, S_CTIME|S_MTIME);
 	fat_detach(inode);
 out:
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
@@ -550,7 +550,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
-		fat_truncate_time(new_inode, &ts, S_CTIME);
+		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);
 	}
 out:
 	brelse(sinfo.bh);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..b8deb859b2b5 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -811,7 +811,7 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
+	fat_truncate_time(inode, NULL, S_ATIME|S_CTIME|S_MTIME);
 	fat_detach(inode);
 	vfat_d_version_set(dentry, inode_query_iversion(dir));
 out:
@@ -837,7 +837,7 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 	clear_nlink(inode);
-	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
+	fat_truncate_time(inode, NULL, S_ATIME|S_CTIME|S_MTIME);
 	fat_detach(inode);
 	vfat_d_version_set(dentry, inode_query_iversion(dir));
 out:
@@ -981,7 +981,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
-		fat_truncate_time(new_inode, &ts, S_CTIME);
+		fat_truncate_time(new_inode, &ts, S_CTIME|S_MTIME);
 	}
 out:
 	brelse(sinfo.bh);
-- 
2.34.1

