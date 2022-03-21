Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6512D4E23F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbiCUKH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346162AbiCUKH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:07:56 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B7414867D
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 03:06:30 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1647856697; bh=7ysLmeLADbVAREm93wqx8BX8llMQvaUce49FSfAlosY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RFFuMFSTeTmCQXV+ktJuMnbyWdkYGxCDrorm/URohR1xrdf+CFHa716jb0sGmiAW5
         1+dZ6IoXO5utc7RTuSvzqkC20psSDkQ+xHMTwnEncmMosAsIoLEliTepnzmcWoBF5u
         oeUUgaPE1lWIOt3kYytSVkBhlpeWFReMXW2mLC/c=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH 2/2] fat: introduce creation time
Date:   Mon, 21 Mar 2022 17:58:14 +0800
Message-Id: <20220321095814.175891-2-cccheng@synology.com>
In-Reply-To: <20220321095814.175891-1-cccheng@synology.com>
References: <20220321095814.175891-1-cccheng@synology.com>
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

In the old days, FAT supports creation time, but there's no corresponding
timestamp in VFS. The implementation mixed the meaning of change time and
creation time into a single ctime field.

This patch introduces a new field for creation time, and reports it in
statx. The original ctime doesn't stand for create time any more. All
the behaviors of ctime (change time) follow mtime, as exfat does.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  |  6 ++++++
 fs/fat/inode.c | 15 ++++++++++-----
 fs/fat/misc.c  |  6 +++---
 4 files changed, 20 insertions(+), 8 deletions(-)

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
index 13855ba49cd9..184fa0375152 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -405,6 +405,12 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		/* Use i_pos for ino. This is used as fileid of nfs. */
 		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
 	}
+
+	if (request_mask & STATX_BTIME) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime = MSDOS_I(inode)->i_crtime;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fat_getattr);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a6f1c6d426d1..41b85b95ee9d 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -566,12 +566,15 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
 	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
+	inode->i_ctime = inode->i_mtime;
 	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
-				  de->cdate, de->ctime_cs);
 		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
-	} else
-		fat_truncate_time(inode, &inode->i_mtime, S_ATIME|S_CTIME);
+		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
+				  de->cdate, de->ctime_cs);
+	} else {
+		fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
+		fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
+	}
 
 	return 0;
 }
@@ -756,6 +759,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	ei->i_logstart = 0;
 	ei->i_attrs = 0;
 	ei->i_pos = 0;
+	ei->i_crtime.tv_sec = 0;
+	ei->i_crtime.tv_nsec = 0;
 
 	return &ei->vfs_inode;
 }
@@ -887,7 +892,7 @@ static int __fat_write_inode(struct inode *inode, int wait)
 			  &raw_entry->date, NULL);
 	if (sbi->options.isvfat) {
 		__le16 atime;
-		fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime,
+		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
 				  &raw_entry->cdate, &raw_entry->ctime_cs);
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index c87df64f8b2b..36b6da6461cc 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -341,10 +341,10 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 
 	if (flags & S_ATIME)
 		fat_truncate_atime(sbi, now, &inode->i_atime);
-	if (flags & S_CTIME)
-		fat_truncate_crtime(sbi, now, &inode->i_ctime);
-	if (flags & S_MTIME)
+	if (flags & (S_CTIME | S_MTIME)) {
 		fat_truncate_mtime(sbi, now, &inode->i_mtime);
+		inode->i_ctime = inode->i_mtime;
+	}
 
 	return 0;
 }
-- 
2.34.1

