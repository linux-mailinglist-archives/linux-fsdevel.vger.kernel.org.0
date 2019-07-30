Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5B79E33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfG3Bu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44260 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbfG3Bu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so28915662pfe.11;
        Mon, 29 Jul 2019 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IiHYsAumGmwMilrFK0b/NUIB9co6Y5UEsmqHb9nGQyU=;
        b=ISJ9TA4FZmcd7womrY0uIyLdNdlSuPdhvjTVi55bbvOo+4KcTQunZschTJxOgpfE0i
         xJQa3/ZoUAGWP+kk/km2Ros4yCR2rqZVzoR9laFigM+l08Ywd1UHScAvQwhT5fh8Q1BL
         1WcDAjqMV+yBT1Sxb4i52Eq22z2+ROZ13HPf+0GKKFwuFZas8FtECFuI1uoXl5aM/c27
         VfV4pjxDaPvusEDoNfuaKvSlqG5omKPtpxWhEOiM/zDwxaflk9RhCT2EU52hNXO78iWB
         g4e1rgQ6HhYY21QsJGUoDj6uXt+drYVcY1dqSgwf5/ytHAl5GtZu4AWz3tgJ53Cw3zMx
         7gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IiHYsAumGmwMilrFK0b/NUIB9co6Y5UEsmqHb9nGQyU=;
        b=soNTj2bvI6nRTKMQgrAkbaPGYNudNEv8gYB0vmeGdBYBofND4E+ySY+2UN2D0nokz7
         IsxlJLhlDLNnDboiSgLzYmPSaOley6S/oyw7gQHDtkhRUQhwtNH8ogseneuuB0nrKs/9
         1lfdDSiPJG3hN73cv2aWVOoMMrEB+0c6LWZiOxjcmsspdbazaQeUmQMh651/4A8li0iw
         n1jHxyxsqI5C0QgQnPTYy46KURuGtDNZ1GRPxG/cisQckZ9+BKfr3Qrx2k6os51+BR91
         fiSerRKCJZyfUk7vmyk0AAuF13YU6P9EPGzYGJfclHjh6xBQXCqrSVtsCMzxWJr8cOME
         iSSA==
X-Gm-Message-State: APjAAAWdVtu0jFIPRgefutV943oY5X7+5nHmb4N5/w+P6ahBXxhMf+89
        pnQRqFe86TOWlPztyCKmXkg=
X-Google-Smtp-Source: APXvYqy7CBHQMm439yEyjRbQweRYrXZDCuISH7LHBxFLktyDgLRupH2Pa3t6gj+0pivswKb1FS+xXg==
X-Received: by 2002:a65:5a44:: with SMTP id z4mr107194289pgs.41.1564451428828;
        Mon, 29 Jul 2019 18:50:28 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:28 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 08/20] adfs: Fill in max and min timestamps in sb
Date:   Mon, 29 Jul 2019 18:49:12 -0700
Message-Id: <20190730014924.2193-9-deepa.kernel@gmail.com>
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

Note that the min timestamp is assumed to be
01 Jan 1970 00:00:00 (Unix epoch). This is consistent
with the way we convert timestamps in adfs_adfs2unix_time().

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/adfs/adfs.h  | 13 +++++++++++++
 fs/adfs/inode.c |  8 ++------
 fs/adfs/super.c |  2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 804c6a77c5db..781b1c3817e0 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -2,6 +2,19 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 
+/*
+ * 01 Jan 1970 00:00:00 (Unix epoch) as seconds since
+ * 01 Jan 1900 00:00:00 (RISC OS epoch)
+ */
+#define RISC_OS_EPOCH_DELTA 2208988800LL
+
+/*
+ * Convert 40 bit centi seconds to seconds
+ * since 01 Jan 1900 00:00:00 (RISC OS epoch)
+ * The result is 2248-06-03 06:57:57 GMT
+ */
+#define ADFS_MAX_TIMESTAMP ((0xFFFFFFFFFFLL / 100) - RISC_OS_EPOCH_DELTA)
+
 /* Internal data structures for ADFS */
 
 #define ADFS_FREE_FRAG		 0
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 66621e96f9af..3f75cefc0380 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -170,11 +170,7 @@ static void
 adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 {
 	unsigned int high, low;
-	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
-	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
-	 */
-	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
-							2208988800000000000LL;
+	static const s64 nsec_unix_epoch_diff_risc_os_epoch = RISC_OS_EPOCH_DELTA * NSEC_PER_SEC;
 	s64 nsec;
 
 	if (ADFS_I(inode)->stamped == 0)
@@ -219,7 +215,7 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
 	if (ADFS_I(inode)->stamped) {
 		/* convert 32-bit seconds to 40-bit centi-seconds */
 		low  = (secs & 255) * 100;
-		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
+		high = (secs / 256) * 100 + (low >> 8) + (RISC_OS_EPOCH_DELTA*100/256);
 
 		ADFS_I(inode)->loadaddr = (high >> 24) |
 				(ADFS_I(inode)->loadaddr & ~0xff);
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 2a83655c408f..0a0854ef9e3c 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -449,6 +449,8 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb->s_size    		= adfs_discsize(dr, sb->s_blocksize_bits);
 	asb->s_version 		= dr->format_version;
 	asb->s_log2sharesize	= dr->log2sharesize;
+	sb->s_time_min		= 0;
+	sb->s_time_max		= ADFS_MAX_TIMESTAMP;
 
 	asb->s_map = adfs_read_map(sb, dr);
 	if (IS_ERR(asb->s_map)) {
-- 
2.17.1

