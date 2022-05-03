Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0451887B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiECP3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiECP3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 11:29:14 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76715220FB
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 08:25:41 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1651591538; bh=YgT8ZFXsscicXnA/wJRZ3DLVhcPAK8N6/Tg3ehyABII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WzP8E+gfzRGhPV7yBJjc+UmEzavQnXY6+2x9DoZQuNwdctPGwUoKLJJxQr9muStF/
         q1zmIUBvMzoYPd3SxpbnHqqQevO4tp1B13WMsvacR10F78tq4gPp3jMw0lRzfOyG8L
         UiKPJJAjatffVr9lQcXn0DHylbpF+y6DdP5bXqPU=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v6 3/4] fat: report creation time in statx
Date:   Tue,  3 May 2022 23:25:35 +0800
Message-Id: <20220503152536.2503003-3-cccheng@synology.com>
In-Reply-To: <20220503152536.2503003-1-cccheng@synology.com>
References: <20220503152536.2503003-1-cccheng@synology.com>
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

creation time is no longer mixed with change time. Add an in-memory
field for it, and report it in statx if supported.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h   |  1 +
 fs/fat/file.c  | 14 +++++++++++---
 fs/fat/inode.c | 10 ++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 6b04aa623b3b..f3bbf17ee352 100644
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
index 16d5a52116d3..2472a357198a 100644
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
 		inode->i_atime = fat_truncate_atime(sbi, &inode->i_mtime);
 
 	return 0;
@@ -756,6 +758,8 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	ei->i_logstart = 0;
 	ei->i_attrs = 0;
 	ei->i_pos = 0;
+	ei->i_crtime.tv_sec = 0;
+	ei->i_crtime.tv_nsec = 0;
 
 	return &ei->vfs_inode;
 }
@@ -889,6 +893,8 @@ static int __fat_write_inode(struct inode *inode, int wait)
 		__le16 atime;
 		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
 				  &raw_entry->adate, NULL);
+		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
+				  &raw_entry->cdate, &raw_entry->ctime_cs);
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
-- 
2.34.1

