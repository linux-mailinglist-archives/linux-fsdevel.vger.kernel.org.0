Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D31A1CCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 09:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDHHqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 03:46:50 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:38222 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDHHqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:46:50 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 82F093A41E6;
        Wed,  8 Apr 2020 16:46:46 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48xxDk2KZSzRkCm;
        Wed,  8 Apr 2020 16:46:46 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48xxDk21Y5zRkCj;
        Wed,  8 Apr 2020 16:46:46 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48xxDk1w6WzRkD1;
        Wed,  8 Apr 2020 16:46:46 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48xxDk0gYfzRkBx;
        Wed,  8 Apr 2020 16:46:46 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 0387kj5l032297;
        Wed, 8 Apr 2020 16:46:45 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id C6F8317E07A;
        Wed,  8 Apr 2020 16:46:45 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id BA9DD17E079;
        Wed,  8 Apr 2020 16:46:45 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 0387kjUx005469;
        Wed, 8 Apr 2020 16:46:45 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Date:   Wed,  8 Apr 2020 16:46:10 +0900
Message-Id: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace "time_ms"  with "time_10ms" in the file directory entry structure
and related functions.

The unit of create_time_ms/modify_time_ms in File Directory Entry are
not 'milli-second', but 'centi-second'.

The reason for using 10ms instead of cs for the names is that the exfat
specification defines it as Create10msIncrement/LastModified10msIncrement.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
Changes in v2:
- fix spelling mistakes in commit-log.

 fs/exfat/dir.c       |  8 ++++----
 fs/exfat/exfat_fs.h  |  4 ++--
 fs/exfat/exfat_raw.h |  4 ++--
 fs/exfat/file.c      |  2 +-
 fs/exfat/inode.c     |  4 ++--
 fs/exfat/misc.c      | 18 +++++++++---------
 fs/exfat/namei.c     |  4 ++--
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 4b91afb0f0..cacc53ff11 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -137,12 +137,12 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 					ep->dentry.file.create_tz,
 					ep->dentry.file.create_time,
 					ep->dentry.file.create_date,
-					ep->dentry.file.create_time_ms);
+					ep->dentry.file.create_time_10ms);
 			exfat_get_entry_time(sbi, &dir_entry->mtime,
 					ep->dentry.file.modify_tz,
 					ep->dentry.file.modify_time,
 					ep->dentry.file.modify_date,
-					ep->dentry.file.modify_time_ms);
+					ep->dentry.file.modify_time_10ms);
 			exfat_get_entry_time(sbi, &dir_entry->atime,
 					ep->dentry.file.access_tz,
 					ep->dentry.file.access_time,
@@ -461,12 +461,12 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 			&ep->dentry.file.create_tz,
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_ms);
+			&ep->dentry.file.create_time_10ms);
 	exfat_set_entry_time(sbi, &ts,
 			&ep->dentry.file.modify_tz,
 			&ep->dentry.file.modify_time,
 			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_ms);
+			&ep->dentry.file.modify_time_10ms);
 	exfat_set_entry_time(sbi, &ts,
 			&ep->dentry.file.access_tz,
 			&ep->dentry.file.access_time,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 67d4e46fb8..6d357e9f5b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -506,9 +506,9 @@ void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
 		__printf(3, 4) __cold;
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 tz, __le16 time, __le16 date, u8 time_ms);
+		u8 tz, __le16 time, __le16 date, u8 time_10ms);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_10ms);
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
 		unsigned short chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 2a841010e6..be0e362422 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -136,8 +136,8 @@ struct exfat_dentry {
 			__le16 modify_date;
 			__le16 access_time;
 			__le16 access_date;
-			__u8 create_time_ms;
-			__u8 modify_time_ms;
+			__u8 create_time_10ms;
+			__u8 modify_time_10ms;
 			__u8 create_tz;
 			__u8 modify_tz;
 			__u8 access_tz;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 483f683757..a986f1eeef 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -165,7 +165,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 				&ep->dentry.file.modify_tz,
 				&ep->dentry.file.modify_time,
 				&ep->dentry.file.modify_date,
-				&ep->dentry.file.modify_time_ms);
+				&ep->dentry.file.modify_time_10ms);
 		ep->dentry.file.attr = cpu_to_le16(ei->attr);
 
 		/* File size should be zero if there is no cluster allocated */
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 06887492f5..59b50dfbdd 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -56,12 +56,12 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 			&ep->dentry.file.create_tz,
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_ms);
+			&ep->dentry.file.create_time_10ms);
 	exfat_set_entry_time(sbi, &inode->i_mtime,
 			&ep->dentry.file.modify_tz,
 			&ep->dentry.file.modify_time,
 			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_ms);
+			&ep->dentry.file.modify_time_10ms);
 	exfat_set_entry_time(sbi, &inode->i_atime,
 			&ep->dentry.file.access_tz,
 			&ep->dentry.file.access_time,
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 14a3300848..8b39c8176a 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -75,7 +75,7 @@ static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
 
 /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 tz, __le16 time, __le16 date, u8 time_ms)
+		u8 tz, __le16 time, __le16 date, u8 time_10ms)
 {
 	u16 t = le16_to_cpu(time);
 	u16 d = le16_to_cpu(date);
@@ -84,10 +84,10 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 			      t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
 
 
-	/* time_ms field represent 0 ~ 199(1990 ms) */
-	if (time_ms) {
-		ts->tv_sec += time_ms / 100;
-		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
+	/* time_10ms field represent 0 ~ 199cs(1990 ms) */
+	if (time_10ms) {
+		ts->tv_sec += (time_10ms * 10) / 1000;
+		ts->tv_nsec = (time_10ms * 10) % 1000 * NSEC_PER_MSEC;
 	}
 
 	if (tz & EXFAT_TZ_VALID)
@@ -100,7 +100,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 
 /* Convert linear UNIX date to a EXFAT time/date pair. */
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms)
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_10ms)
 {
 	struct tm tm;
 	u16 t, d;
@@ -112,9 +112,9 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 	*time = cpu_to_le16(t);
 	*date = cpu_to_le16(d);
 
-	/* time_ms field represent 0 ~ 199(1990 ms) */
-	if (time_ms)
-		*time_ms = (tm.tm_sec & 1) * 100 +
+	/* time_10ms field represent 0 ~ 199cs(1990 ms) */
+	if (time_10ms)
+		*time_10ms = (tm.tm_sec & 1) * 100 +
 			ts->tv_nsec / (10 * NSEC_PER_MSEC);
 
 	/*
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index a8681d91f5..90d8273cd8 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -698,12 +698,12 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 				ep->dentry.file.create_tz,
 				ep->dentry.file.create_time,
 				ep->dentry.file.create_date,
-				ep->dentry.file.create_time_ms);
+				ep->dentry.file.create_time_10ms);
 		exfat_get_entry_time(sbi, &info->mtime,
 				ep->dentry.file.modify_tz,
 				ep->dentry.file.modify_time,
 				ep->dentry.file.modify_date,
-				ep->dentry.file.modify_time_ms);
+				ep->dentry.file.modify_time_10ms);
 		exfat_get_entry_time(sbi, &info->atime,
 				ep->dentry.file.access_tz,
 				ep->dentry.file.access_time,
-- 
2.25.0

