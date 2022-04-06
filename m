Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF874F5E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 15:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiDFMxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiDFMxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:53:06 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED610660C
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 01:55:04 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1649235302; bh=n41AnKVpmXRGqTKFvbN45dUP3voF1ZcCyZmjVvQa2SY=;
        h=From:To:Cc:Subject:Date;
        b=NOdcP0m1xrayT9FocdbwpiU6VW9Ypx1Qwg+UQmAZYVvwZbzPjBZd8IZ3GMHPl+Piq
         G6OAQmq2Gz68bMGB9yFIV1QVeHzsoeytlvBk8NmKtOmiiIPcX3j1gjn0o/NV8vYOQA
         yXcmiCwKebhMsbAsXY5qaBZKxK5jrsm5kJ3A6B1c=
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2 1/3] fat: split fat_truncate_time() into separate functions
Date:   Wed,  6 Apr 2022 16:54:57 +0800
Message-Id: <20220406085459.102691-1-cccheng@synology.com>
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

Separate fat_truncate_time() to each timestamps for later creation time
work.

This patch does not introduce any functional changes, it's merely
refactoring change.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/fat/fat.h  |  6 +++++
 fs/fat/misc.c | 72 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 02d4d4234956..508b4f2a1ffb 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -446,6 +446,12 @@ extern void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timespec64 *ts,
 			      __le16 __time, __le16 __date, u8 time_cs);
 extern void fat_time_unix2fat(struct msdos_sb_info *sbi, struct timespec64 *ts,
 			      __le16 *time, __le16 *date, u8 *time_cs);
+extern void fat_truncate_atime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+			       struct timespec64 *atime);
+extern void fat_truncate_crtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+				struct timespec64 *crtime);
+extern void fat_truncate_mtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+			       struct timespec64 *mtime);
 extern int fat_truncate_time(struct inode *inode, struct timespec64 *now,
 			     int flags);
 extern int fat_update_time(struct inode *inode, struct timespec64 *now,
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 91ca3c304211..c87df64f8b2b 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -282,16 +282,49 @@ static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
 	return ts;
 }
 
+/*
+ * truncate atime to 24 hour granularity (00:00:00 in local timezone)
+ */
+void fat_truncate_atime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+			struct timespec64 *atime)
+{
+	/* to localtime */
+	time64_t seconds = ts->tv_sec - fat_tz_offset(sbi);
+	s32 remainder;
+
+	div_s64_rem(seconds, SECS_PER_DAY, &remainder);
+	/* to day boundary, and back to unix time */
+	seconds = seconds + fat_tz_offset(sbi) - remainder;
+
+	*atime = (struct timespec64){ seconds, 0 };
+}
+
+/*
+ * truncate creation time with appropriate granularity:
+ *   msdos - 2 seconds
+ *   vfat  - 10 milliseconds
+ */
+void fat_truncate_crtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+			 struct timespec64 *crtime)
+{
+	if (sbi->options.isvfat)
+		*crtime = fat_timespec64_trunc_10ms(*ts);
+	else
+		*crtime = fat_timespec64_trunc_2secs(*ts);
+}
+
+/*
+ * truncate mtime to 2 second granularity
+ */
+void fat_truncate_mtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
+			struct timespec64 *mtime)
+{
+	*mtime = fat_timespec64_trunc_2secs(*ts);
+}
+
 /*
  * truncate the various times with appropriate granularity:
- *   root inode:
- *     all times always 0
- *   all other inodes:
- *     mtime - 2 seconds
- *     ctime
- *       msdos - 2 seconds
- *       vfat  - 10 milliseconds
- *     atime - 24 hours (00:00:00 in local timezone)
+ *   all times in root node are always 0
  */
 int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 {
@@ -306,25 +339,12 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 		ts = current_time(inode);
 	}
 
-	if (flags & S_ATIME) {
-		/* to localtime */
-		time64_t seconds = now->tv_sec - fat_tz_offset(sbi);
-		s32 remainder;
-
-		div_s64_rem(seconds, SECS_PER_DAY, &remainder);
-		/* to day boundary, and back to unix time */
-		seconds = seconds + fat_tz_offset(sbi) - remainder;
-
-		inode->i_atime = (struct timespec64){ seconds, 0 };
-	}
-	if (flags & S_CTIME) {
-		if (sbi->options.isvfat)
-			inode->i_ctime = fat_timespec64_trunc_10ms(*now);
-		else
-			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
-	}
+	if (flags & S_ATIME)
+		fat_truncate_atime(sbi, now, &inode->i_atime);
+	if (flags & S_CTIME)
+		fat_truncate_crtime(sbi, now, &inode->i_ctime);
 	if (flags & S_MTIME)
-		inode->i_mtime = fat_timespec64_trunc_2secs(*now);
+		fat_truncate_mtime(sbi, now, &inode->i_mtime);
 
 	return 0;
 }
-- 
2.34.1

