Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4BB79E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfG3Bvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbfG3Bud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so28938959pfp.7;
        Mon, 29 Jul 2019 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WtwY5yricjUUFTVKUgDZ3nK7nqec7Ph6cbHYobxR4wQ=;
        b=O+z9w0naZ1YWNbDGDlg1VRQ6JPexZ8LTW3EeZvsX12cMfb9dSMi5/ZvikfdTNDFUrk
         Lhv/9aDYSLhRX/QsQRuLHVKEtQtWCNRrgHuwoiJeFzr0tmym9NqZn+nrq+9liKBSgxD/
         viIcUMbTAYZfGPSatlDzSSleH+zpWsrMyD9npMEcZM+JnGS8q+/LspDOgULZdn1d2TPf
         97hlQz/IxufgVX/r+T6BgIepRwL2N4M8UYGpSIv60FUlRYJYGT3w1x3cmGYrekDUQpfx
         Fa7sUZy3nb23nysxxG3BbWMHTvPd/orMAkW3WxJnWqaZBodP7H7+e89dl4lSUsZu+CQW
         Sq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtwY5yricjUUFTVKUgDZ3nK7nqec7Ph6cbHYobxR4wQ=;
        b=D+1thWMUk3Tg686+qmnlomqkPD9wlHd3Ihx8V7h2Zm5FASzC4ScZ71GxwOEP4xBqB/
         g1n6I8KHKU55dsuesZs3YbXPgoNOeqv/GrEIiwaTcCgnjRvltnWQ2NWAubcu4wZsYFxR
         FbPhABp+l+DefUNgY88Q89sL+y3PPL9U8DdHi+qslG2AADIrrxtzgO3MvE23XAsttIn5
         0EY0HFlKaLeMROcDtKa3j4XXvKZe9FVvpeXCFyDrWzKjwQzKuyU2kJpla0iVDqF3bJ7k
         4/ikS9ANwVstKqr+9+ECQ5j03wMCmbqp1bXoIaXphs+RwxgoPr4iK42vp4sQizValVvG
         rZWw==
X-Gm-Message-State: APjAAAUH1Olf2g1jsLPD0KIHarUcGgJUUGigglH79SLl+7nUJjSGM8xT
        yHq47wyJWjmpcqNJaLcsOGY=
X-Google-Smtp-Source: APXvYqzxr2P3AtG+QgBq4Lx2+D3QSoPEWcus9Yjxal69gp9m+wMIuOUPCR9aRnyvXjKQZLijNdQ3ww==
X-Received: by 2002:a65:6547:: with SMTP id a7mr85739982pgw.65.1564451432094;
        Mon, 29 Jul 2019 18:50:32 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:31 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH 11/20] fs: cifs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:15 -0700
Message-Id: <20190730014924.2193-12-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
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
index 81a16b4e1b48..94a52a63b9ea 100644
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

