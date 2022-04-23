Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DC50C6E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiDWD0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 23:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDWD0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:26:48 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375414586C
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 20:23:52 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650684230; bh=dH37hSwd0RJNtFKM3/hj6IPI09qfptf8pvcyRdXz52o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EF5OeADwSZW+NAxVlgMuVaJHRwF8P5mQZkjcM+KWxdwsMPqRxDgAC07JzKAhJRHbo
         QfKp+d5Ed+DQ/a3S/sdUUoue0KRd6/0Uzneo/OX/Z8pWigpSGhnNIWk2HBvic1Bkrp
         8fYh5E2mbnjV4F1eWxjnP+tKoBRtL4ogDb7LS/wQ=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v4 3/3] fat: report creation time in statx
Date:   Sat, 23 Apr 2022 11:23:48 +0800
Message-Id: <20220423032348.1475539-3-cccheng@synology.com>
In-Reply-To: <20220423032348.1475539-1-cccheng@synology.com>
References: <20220423032348.1475539-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

creation time is no longer mixed with change time. Add an in-memory
field for it, and report it in statx if supported.

The unused code in fat_truncate_crtime() is also removed because only
vfat support creation time.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h        |  1 +
 fs/fat/file.c       | 14 +++++++++++---
 fs/fat/inode.c      | 10 ++++++++--
 fs/fat/misc.c       |  3 +--
 fs/fat/namei_vfat.c |  1 +
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 508b4f2a1ffb..e4409ee82ea9 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -126,6 +126,7 @@ struct msdos_inode_info {
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct hlist_node i_dir_hash;	/* hash by i_logstart */
 	struct rw_semaphore truncate_lock; /* protect bmap against truncate */
+	struct timespec64 i_crtime;	/* File creation (birth) time */
 	struct inode vfs_inode;
 };
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index a5a309fcc7fa..8f5218450a3a 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -399,13 +399,21 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
 	generic_fillattr(mnt_userns, inode, stat);
-	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
+	stat->blksize = sbi->cluster_size;
 
-	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
+	if (sbi->options.nfs == FAT_NFS_NOSTALE_RO) {
 		/* Use i_pos for ino. This is used as fileid of nfs. */
-		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
+		stat->ino = fat_i_pos_read(sbi, inode);
 	}
+
+	if (sbi->options.isvfat && request_mask & STATX_BTIME) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime = MSDOS_I(inode)->i_crtime;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_getattr);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f2ac55cd4ea4..ebc124f44e86 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -568,9 +568,11 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
 	inode->i_ctime = inode->i_mtime;
-	if (sbi->options.isvfat)
+	if (sbi->options.isvfat) {
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
-	else
+		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
+				  de->cdate, de->ctime_cs);
+	} else
 		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
 
 	return 0;
@@ -756,6 +758,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	ei->i_logstart = 0;
 	ei->i_attrs = 0;
 	ei->i_pos = 0;
+	ei->i_crtime.tv_sec = 0;
+	ei->i_crtime.tv_nsec = 0;
 
 	return &ei->vfs_inode;
 }
@@ -887,6 +891,8 @@ static int __fat_write_inode(struct inode *inode, int wait)
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
+		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
+				  &raw_entry->cdate, &raw_entry->ctime_cs);
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
 	}
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index ef09b6361602..dfc5d6df3519 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -309,9 +309,8 @@ void fat_truncate_crtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
 {
 	if (sbi->options.isvfat)
 		*crtime = fat_timespec64_trunc_10ms(*ts);
-	else
-		*crtime = fat_timespec64_trunc_2secs(*ts);
 }
+EXPORT_SYMBOL_GPL(fat_truncate_crtime);
 
 /*
  * truncate mtime to 2 second granularity
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..9187979fed5d 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -781,6 +781,7 @@ static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 	inode_inc_iversion(inode);
 	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
+	fat_truncate_crtime(MSDOS_SB(sb), &MSDOS_I(inode)->i_crtime, &MSDOS_I(inode)->i_crtime);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
-- 
2.34.1

