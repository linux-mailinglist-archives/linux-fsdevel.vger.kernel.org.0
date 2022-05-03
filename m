Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF108518879
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiECP33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiECP3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 11:29:14 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76769220FE
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 08:25:41 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1651591539; bh=g6MfePQU8t3Y/BL8DAczp+pL5LtDlT8JGWNaQOq9alk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=q2noa+GitB//zf7uiQz57pNf9y0urtq0LFrTR06GodQu4rilftKpYxoWXdCblY64O
         11f0e4a8oRkvY7GRNafZ8cz0chrU87Eyae3fCWN7crZDBxqFgypD4fdeFhACHp8VIZ
         WSpM9qW03LTkQi8LI0IkyKLqzIgDT0MKVKgMwrdk=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v6 4/4] fat: remove time truncations in vfat_create/vfat_mkdir
Date:   Tue,  3 May 2022 23:25:36 +0800
Message-Id: <20220503152536.2503003-4-cccheng@synology.com>
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

All the timestamps in vfat_create() and vfat_mkdir() come from
fat_time_fat2unix() which ensures time granularity. We don't need to
truncate them to fit FAT's format.

Moreover, fat_truncate_crtime() and fat_timespec64_trunc_10ms() are
also removed because there is no caller anymore.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h        |  2 --
 fs/fat/misc.c       | 21 ---------------------
 fs/fat/namei_vfat.c |  4 ----
 3 files changed, 27 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index f3bbf17ee352..47b90deef284 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -449,8 +449,6 @@ extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 			      __le16 *time, __le16 *date, u8 *time_cs);
 extern struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
 					    const struct timespec64 *ts);
-extern struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
-					     const struct timespec64 *ts);
 extern struct timespec64 fat_truncate_mtime(const struct msdos_sb_info *sbi,
 					    const struct timespec64 *ts);
 extern int fat_truncate_time(struct inode *inode, struct timespec64 *now,
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 85bb9dc3af2d..010865dfc46b 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -275,13 +275,6 @@ static inline struct timespec64 fat_timespec64_trunc_2secs(struct timespec64 ts)
 	return (struct timespec64){ ts.tv_sec & ~1ULL, 0 };
 }
 
-static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
-{
-	if (ts.tv_nsec)
-		ts.tv_nsec -= ts.tv_nsec % 10000000UL;
-	return ts;
-}
-
 /*
  * truncate atime to 24 hour granularity (00:00:00 in local timezone)
  */
@@ -299,20 +292,6 @@ struct timespec64 fat_truncate_atime(const struct msdos_sb_info *sbi,
 	return (struct timespec64){ seconds, 0 };
 }
 
-/*
- * truncate creation time with appropriate granularity:
- *   msdos - 2 seconds
- *   vfat  - 10 milliseconds
- */
-struct timespec64 fat_truncate_crtime(const struct msdos_sb_info *sbi,
-				      const struct timespec64 *ts)
-{
-	if (sbi->options.isvfat)
-		return fat_timespec64_trunc_10ms(*ts);
-	else
-		return fat_timespec64_trunc_2secs(*ts);
-}
-
 /*
  * truncate mtime to 2 second granularity
  */
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..c573314806cf 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -780,8 +780,6 @@ static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 	}
 	inode_inc_iversion(inode);
-	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
-	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
 out:
@@ -878,8 +876,6 @@ static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 	inode_inc_iversion(inode);
 	set_nlink(inode, 2);
-	fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
-	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	d_instantiate(dentry, inode);
 
-- 
2.34.1

