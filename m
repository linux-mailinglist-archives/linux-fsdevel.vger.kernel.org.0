Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA44515A84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiD3Eo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 00:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbiD3Eoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:44:54 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C5D5D67F
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:41:32 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1651293690; bh=nETD8OqEnBlkdQAGuG/gUNJDPTwwN4YF6hFvsmxafg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QlghbgG+NTkIj/aeM3qlBBVyAfGpkv0xpVRAy4+MEgAnzQCpWp6UKzfunnwfE3z4n
         tfk4ki8AeNuMibk5gJ1mvkkM812DtbWilRm1PQBafbQL1dVCcHM5H6sMeywKk5/WnB
         e+V4HJc2Gjl7lASYgR2WD55GJ5GKmYEH1ju9ldNY=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, kernel@cccheng.net,
        shepjeng@gmail.com, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v5 2/3] fat: ignore ctime updates, and keep ctime identical to mtime in memory
Date:   Sat, 30 Apr 2022 12:41:26 +0800
Message-Id: <20220430044127.2384398-2-cccheng@synology.com>
In-Reply-To: <20220430044127.2384398-1-cccheng@synology.com>
References: <20220430044127.2384398-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To address this issue, this patch changes the behavior of ctime. It
will no longer be loaded and stored from the creation time on disk.
Instead of that, it'll be consistent with the in-memory mtime and share
the same on-disk field. All updates to mtime will also be applied to
ctime in memory, while all updates to ctime will be ignored.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/inode.c | 11 ++++-------
 fs/fat/misc.c  |  9 ++++++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bf6051bdf1d1..16d5a52116d3 100644
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
+		inode->i_atime = fat_truncate_atime(sbi, &inode->i_mtime);
 
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
index 63160e47be00..85bb9dc3af2d 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -341,10 +341,13 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 
 	if (flags & S_ATIME)
 		inode->i_atime = fat_truncate_atime(sbi, now);
-	if (flags & S_CTIME)
-		inode->i_ctime = fat_truncate_crtime(sbi, now);
+	/*
+	 * ctime and mtime share the same on-disk field, and should be
+	 * identical in memory. all mtime updates will be applied to ctime,
+	 * but ctime updates are ignored.
+	 */
 	if (flags & S_MTIME)
-		inode->i_mtime = fat_truncate_mtime(sbi, now);
+		inode->i_mtime = inode->i_ctime = fat_truncate_mtime(sbi, now);
 
 	return 0;
 }
-- 
2.34.1

