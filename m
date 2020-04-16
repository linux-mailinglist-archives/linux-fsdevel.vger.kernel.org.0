Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F901ABBCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503028AbgDPIzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 04:55:42 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:53079 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502971AbgDPIwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:52:17 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 659653A3F41;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 492tHx2VgNzRkJW;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 492tHx2BWLzRkJg;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 492tHx2DkzzRkCV;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 492tHx1mJgzRkBs;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 03G8pfNA025279;
        Thu, 16 Apr 2020 17:51:41 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 09CBF17E07A;
        Thu, 16 Apr 2020 17:51:41 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id F135217E079;
        Thu, 16 Apr 2020 17:51:40 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 03G8pePX013596;
        Thu, 16 Apr 2020 17:51:40 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
Date:   Thu, 16 Apr 2020 17:51:21 +0900
Message-Id: <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace "time_ms"  with "time_cs" in the file directory entry structure
and related functions.

The unit of create_time_ms/modify_time_ms in File Directory Entry are not
'milli-second', but 'centi-second'.
The exfat specification uses the term '10ms', but instead use 'cs' as in
"msdos_fs.h".

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
Changes in v3:
 - change time_10ms to time_cs
 - revert calculation formula to original
 - change subject & commit-log
 - rebase to 'linkinjeon/exfat.git' dev branch 
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
index 53ae965da..b5a237c33 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -137,12 +137,12 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 					ep->dentry.file.create_tz,
 					ep->dentry.file.create_time,
 					ep->dentry.file.create_date,
-					ep->dentry.file.create_time_ms);
+					ep->dentry.file.create_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->mtime,
 					ep->dentry.file.modify_tz,
 					ep->dentry.file.modify_time,
 					ep->dentry.file.modify_date,
-					ep->dentry.file.modify_time_ms);
+					ep->dentry.file.modify_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->atime,
 					ep->dentry.file.access_tz,
 					ep->dentry.file.access_time,
@@ -461,12 +461,12 @@ int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
 			&ep->dentry.file.create_tz,
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_ms);
+			&ep->dentry.file.create_time_cs);
 	exfat_set_entry_time(sbi, &ts,
 			&ep->dentry.file.modify_tz,
 			&ep->dentry.file.modify_time,
 			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_ms);
+			&ep->dentry.file.modify_time_cs);
 	exfat_set_entry_time(sbi, &ts,
 			&ep->dentry.file.access_tz,
 			&ep->dentry.file.access_time,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 4ced4c0d9..f619b9250 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -511,9 +511,9 @@ void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
 	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
 
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 tz, __le16 time, __le16 date, u8 time_ms);
+		u8 tz, __le16 time, __le16 date, u8 time_cs);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
 		unsigned short chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 2a841010e..8d6c64a75 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -136,8 +136,8 @@ struct exfat_dentry {
 			__le16 modify_date;
 			__le16 access_time;
 			__le16 access_date;
-			__u8 create_time_ms;
-			__u8 modify_time_ms;
+			__u8 create_time_cs;
+			__u8 modify_time_cs;
 			__u8 create_tz;
 			__u8 modify_tz;
 			__u8 access_tz;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 483f68375..5eff50afd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -165,7 +165,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 				&ep->dentry.file.modify_tz,
 				&ep->dentry.file.modify_time,
 				&ep->dentry.file.modify_date,
-				&ep->dentry.file.modify_time_ms);
+				&ep->dentry.file.modify_time_cs);
 		ep->dentry.file.attr = cpu_to_le16(ei->attr);
 
 		/* File size should be zero if there is no cluster allocated */
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 06887492f..3f367d081 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -56,12 +56,12 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 			&ep->dentry.file.create_tz,
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_ms);
+			&ep->dentry.file.create_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_mtime,
 			&ep->dentry.file.modify_tz,
 			&ep->dentry.file.modify_time,
 			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_ms);
+			&ep->dentry.file.modify_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_atime,
 			&ep->dentry.file.access_tz,
 			&ep->dentry.file.access_time,
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index d32beb172..0d521ca24 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -75,7 +75,7 @@ static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
 
 /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 tz, __le16 time, __le16 date, u8 time_ms)
+		u8 tz, __le16 time, __le16 date, u8 time_cs)
 {
 	u16 t = le16_to_cpu(time);
 	u16 d = le16_to_cpu(date);
@@ -84,10 +84,10 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 			      t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
 
 
-	/* time_ms field represent 0 ~ 199(1990 ms) */
-	if (time_ms) {
-		ts->tv_sec += time_ms / 100;
-		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
+	/* time_cs field represent 0 ~ 199cs(1990 ms) */
+	if (time_cs) {
+		ts->tv_sec += time_cs / 100;
+		ts->tv_nsec = (time_cs % 100) * 10 * NSEC_PER_MSEC;
 	}
 
 	if (tz & EXFAT_TZ_VALID)
@@ -100,7 +100,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 
 /* Convert linear UNIX date to a EXFAT time/date pair. */
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms)
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs)
 {
 	struct tm tm;
 	u16 t, d;
@@ -112,9 +112,9 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 	*time = cpu_to_le16(t);
 	*date = cpu_to_le16(d);
 
-	/* time_ms field represent 0 ~ 199(1990 ms) */
-	if (time_ms)
-		*time_ms = (tm.tm_sec & 1) * 100 +
+	/* time_cs field represent 0 ~ 199cs(1990 ms) */
+	if (time_cs)
+		*time_cs = (tm.tm_sec & 1) * 100 +
 			ts->tv_nsec / (10 * NSEC_PER_MSEC);
 
 	/*
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 549274fef..27c0fe5c1 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -687,12 +687,12 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 				ep->dentry.file.create_tz,
 				ep->dentry.file.create_time,
 				ep->dentry.file.create_date,
-				ep->dentry.file.create_time_ms);
+				ep->dentry.file.create_time_cs);
 		exfat_get_entry_time(sbi, &info->mtime,
 				ep->dentry.file.modify_tz,
 				ep->dentry.file.modify_time,
 				ep->dentry.file.modify_date,
-				ep->dentry.file.modify_time_ms);
+				ep->dentry.file.modify_time_cs);
 		exfat_get_entry_time(sbi, &info->atime,
 				ep->dentry.file.access_tz,
 				ep->dentry.file.access_time,
-- 
2.25.0

