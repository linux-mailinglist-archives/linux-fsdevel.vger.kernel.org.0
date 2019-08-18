Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC09F91837
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHRRAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35158 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfHRQ75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so5742118pfd.2;
        Sun, 18 Aug 2019 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OANlzDBkabtl5UN7ibJ4MLwySknYtbivCf67bcL51AQ=;
        b=LY1WM6E8Kys2q7bNl2j7oB8/ISkGzEPiE0m9INgM32Ocw3Rsj+EYWZEUlZyH/X+yDW
         uJmiZ2eQrFLYP1ngeyVFhdvwrjcpeJwA60pSqsAnTjGCnCWbgZxMQCNR6QSfIrhijmWV
         DqF3vgYoawl+9EUYEgHazkgWm+ygOuKzuxtDpiN+VX5dFw0xDydRa1sZHnp0+znIpmoX
         hJV+v6Wu5nIFkcgDm0oPB+WItqilJxlctvpkK2lxSMCBbNz9ww5Sxxqu/tIpwZprJIet
         ttAu5Jw9SdUpCXQrU4Cco6c9sQq2kB/+xgyMMqXzHAnehdvOKgPS+TmiMjcnhGieYuGl
         kshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OANlzDBkabtl5UN7ibJ4MLwySknYtbivCf67bcL51AQ=;
        b=c7UDJ48Xxzmzvox2ecSXEqoX32wGPsn8/Swzpjx8MzUAvfB2vVNS0mDgqlyRxiT/jV
         sXnOv75arNIInJngrh6b+XuTnkd8n6BGEtPbhqcQ4YiHYVR3aE9xLHiW22VBkR6d2tNr
         s+S5/4S7PSl5/dEGEp4jMml/zj6EZr4eWCiFPVkLikMco0h6VuQZ97aaF+7IK2qvC7QU
         nryA+XvEugJi5rZ+4Q8rh2rQ1uLALkhg+j5Yj2iTcAxONx+/JMZhrHEm4YZmBhJFNhWx
         TL5lEqrDnEBTFtWGnzMN2TKnG3HV84VIz/T5YLq+K3JTUbLwsn88l8yROkLPkEj34p8A
         VQzg==
X-Gm-Message-State: APjAAAUvauVy0zccC3e26sLK9Gb2sxez14C1QZ6AxWYsldbDUPO+RMJT
        hawSs9Wdnqe5yByZO5RGjyA=
X-Google-Smtp-Source: APXvYqwz00Tt6K8qor9ax5HaEuLrqJg2JMRGS32/pgAAjnqroMTDadhto/XOMVcETYlxqjtrhrsgqw==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr20446137pfc.127.1566147596711;
        Sun, 18 Aug 2019 09:59:56 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:56 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, sfrench@samba.org, linux-cifs@vger.kernel.org
Subject: [PATCH v8 11/20] fs: cifs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:08 -0700
Message-Id: <20190818165817.32634-12-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Also fixed cnvrtDosUnixTm calculations to avoid int overflow
while computing maximum date.

References:

http://cifs.com/

https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-cifs/d416ff7c-c536-406e-a951-4f04b2fd1d2b

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: sfrench@samba.org
Cc: linux-cifs@vger.kernel.org
---
 fs/cifs/cifsfs.c  | 22 ++++++++++++++++++++++
 fs/cifs/netmisc.c | 14 +++++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 3289b566463f..7a75726442ad 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -56,6 +56,15 @@
 #include "dfs_cache.h"
 #endif
 
+/*
+ * DOS dates from 1980/1/1 through 2107/12/31
+ * Protocol specifications indicate the range should be to 119, which
+ * limits maximum year to 2099. But this range has not been checked.
+ */
+#define SMB_DATE_MAX (127<<9 | 12<<5 | 31)
+#define SMB_DATE_MIN (0<<9 | 1<<5 | 1)
+#define SMB_TIME_MAX (23<<11 | 59<<5 | 29)
+
 int cifsFYI = 0;
 bool traceSMB;
 bool enable_oplocks = true;
@@ -142,6 +151,7 @@ cifs_read_super(struct super_block *sb)
 	struct inode *inode;
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_tcon *tcon;
+	struct timespec64 ts;
 	int rc = 0;
 
 	cifs_sb = CIFS_SB(sb);
@@ -161,6 +171,18 @@ cifs_read_super(struct super_block *sb)
 	/* BB FIXME fix time_gran to be larger for LANMAN sessions */
 	sb->s_time_gran = 100;
 
+	if (tcon->unix_ext) {
+		ts = cifs_NTtimeToUnix(0);
+		sb->s_time_min = ts.tv_sec;
+		ts = cifs_NTtimeToUnix(cpu_to_le64(S64_MAX));
+		sb->s_time_max = ts.tv_sec;
+	} else {
+		ts = cnvrtDosUnixTm(cpu_to_le16(SMB_DATE_MIN), 0, 0);
+		sb->s_time_min = ts.tv_sec;
+		ts = cnvrtDosUnixTm(cpu_to_le16(SMB_DATE_MAX), cpu_to_le16(SMB_TIME_MAX), 0);
+		sb->s_time_max = ts.tv_sec;
+	}
+
 	sb->s_magic = CIFS_MAGIC_NUMBER;
 	sb->s_op = &cifs_super_ops;
 	sb->s_xattr = cifs_xattr_handlers;
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index ed92958e842d..49c17ee18254 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -949,8 +949,8 @@ static const int total_days_of_prev_months[] = {
 struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset)
 {
 	struct timespec64 ts;
-	time64_t sec;
-	int min, days, month, year;
+	time64_t sec, days;
+	int min, day, month, year;
 	u16 date = le16_to_cpu(le_date);
 	u16 time = le16_to_cpu(le_time);
 	SMB_TIME *st = (SMB_TIME *)&time;
@@ -966,15 +966,15 @@ struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset)
 	sec += 60 * 60 * st->Hours;
 	if (st->Hours > 24)
 		cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
-	days = sd->Day;
+	day = sd->Day;
 	month = sd->Month;
-	if (days < 1 || days > 31 || month < 1 || month > 12) {
-		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, days);
-		days = clamp(days, 1, 31);
+	if (day < 1 || day > 31 || month < 1 || month > 12) {
+		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, day);
+		day = clamp(day, 1, 31);
 		month = clamp(month, 1, 12);
 	}
 	month -= 1;
-	days += total_days_of_prev_months[month];
+	days = day + total_days_of_prev_months[month];
 	days += 3652; /* account for difference in days between 1980 and 1970 */
 	year = sd->Year;
 	days += year * 365;
-- 
2.17.1

