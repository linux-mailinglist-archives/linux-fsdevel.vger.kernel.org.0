Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134D1B1B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDUByy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgDUByy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:54:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E575C061A0E;
        Mon, 20 Apr 2020 18:54:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so1502826pfd.4;
        Mon, 20 Apr 2020 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zTsL7jrQo3RBcjRVnxayYipedNR136l/Rz6U1rY4KU=;
        b=GuhSibr5Ar0yNDD7LrZz6OATLvOxzJpIDs/nLbNyF6erRoZ2vxaoDbQaGpTTbAGrv8
         3kaAjSEIGZwLdPgZuSpTYO3mSBEntQP2n0aMfs8yNVZcZxyJX1PrC9ldPp+1wqy3IgUR
         eNUxttIjePQ20tBo5MHFXnbnZAJJOsxDExIEqkY6o+SMYuuYU6mTsiNuJwWoDX/CDcan
         imns8hIHL1vaV0tqrJeeCzbomc62/XXkB2cR4UP/6+RVPoihBgdYajf9fP+5M0+UBuf1
         9ciTnUPXaHRNIwrh2TMc28i55BGsaWGhkSUY4V/MLXtJNv9fzT2u3d86eGHec9TNOb4I
         mF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zTsL7jrQo3RBcjRVnxayYipedNR136l/Rz6U1rY4KU=;
        b=jsICkv9i3iIS6of8pBA9DHdl/AHBkedRKNy19ww6cw0q9dLSfbnDo0kWGRsF7BFwLm
         7YIvHNuxFVTqWxEWm+psTKPE9E2SAuhjE7a2dJ4Prlj0Uc9DZEN/ovTo8me1he9XoTkA
         lT5G0ylTFEZfksbzf3QNBTBNhyFasFTPomhy2zY4aCNaJGpMrvUbpXwo251Rw06obYzc
         gXV8DZrfvccSc6uK0nb5CSH7B6oi8Fw8ZEewjF5/tuOp7mlanODcFwmqVf7IHpF3C2xN
         3JwfTuPPSv+ejW/hI6ClXxqnZIF17OQK2frao+cblb7AReXvs/uipr0sYGtOH8elboBq
         UK3A==
X-Gm-Message-State: AGi0PuZxDCUH5F+IBuGRPLdHVrgIfrBXFc0C2LYxFYOl43yOTNXnlaR+
        V6uqX0yo0KOjr9MbwUyZAbA=
X-Google-Smtp-Source: APiQypJ21pmP5BtyXbBx6uvsj8+3OUfgL5AtUY/n8lQzzEt56RzFNdiVnNPdxB2BcQZla67gl/JjMA==
X-Received: by 2002:a63:1d08:: with SMTP id d8mr18968508pgd.306.1587434093640;
        Mon, 20 Apr 2020 18:54:53 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:459a:cd47:8130:d7ac])
        by smtp.gmail.com with ESMTPSA id h13sm819098pfk.86.2020.04.20.18.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 18:54:53 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada88@hotmail.com
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH-v4] exfat: replace 'time_ms' with 'time_cs'
Date:   Tue, 21 Apr 2020 10:54:32 +0900
Message-Id: <20200421015432.14563-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.26.1
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

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v4:
 - change sender email
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
index 53ae965da7ec..b5a237c33d50 100644
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
index 3862df6af738..294aa7792bc3 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -511,10 +511,10 @@ void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
 	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
 
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 tz, __le16 time, __le16 date, u8 time_ms);
+		u8 tz, __le16 time, __le16 date, u8 time_cs);
 void exfat_truncate_atime(struct timespec64 *ts);
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
 		unsigned short chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 2a841010e649..8d6c64a7546d 100644
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
index 4f76764165cf..9160fc070d94 100644
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
index 06887492f54b..3f367d081cd6 100644
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
index a3ac541c7103..d2f47c926230 100644
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
 	} else
 		exfat_truncate_atime(ts);
 
@@ -101,7 +101,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 
 /* Convert linear UNIX date to a EXFAT time/date pair. */
 void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
-		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms)
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs)
 {
 	struct tm tm;
 	u16 t, d;
@@ -113,9 +113,9 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
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
index cf8ad9eb0412..c241dd177f1a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -688,12 +688,12 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
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
2.26.1

