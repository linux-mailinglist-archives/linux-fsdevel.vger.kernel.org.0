Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D793379E38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfG3Bue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39276 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfG3Bue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so28260793pls.6;
        Mon, 29 Jul 2019 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q65KxpxSvZWWFfdRJC2De6rWD4axz3O/fUFw710DcxY=;
        b=o6RjBpHbSKI6NJ/u5O4m0uEaVg9AQ64I8+mF+jnHsHBxSHRwcniiguLAnigIBOxPKt
         ZbX5wAEFE2LXx3Gx9JBT7C+MaKtmtwRG80CTUTT/QloCY4i/Az2UA9zjFp2O5wW5/m4k
         QujryVdAfNVofLgvDZHUQnwSvGD5btbK7RdUyKPh9fi+b4gT8tDdUIsWQHZdcJrEmOxH
         BhgEE9a/hDUTak2wkcG8vAvVfV2aSlyTWgecQEaqqV1e5ctIdLJb/d88nuuorGukwz9f
         WxvBi9FNi/iTpqpGSQg83iExL4Wxzb3rAyuD2/Kyy/kYNRtVnYCAAQtPVHu/Ye1q2X2f
         quWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q65KxpxSvZWWFfdRJC2De6rWD4axz3O/fUFw710DcxY=;
        b=ODA0RwOrGxlq2ujgZ5HO2QdBzJyujgjylflOxXyXxEuOBkG8dqHEePpv1c4uDk1kp1
         C1YeEts1IDfG5GkYN22v3+gvl1mjt5nwLqQGjVycFNJYhOyYtuTS62gsJo9Qwvxqldzu
         p6qJrhOSowtfRMe/M2x5RqFsDikFP2dWIDrzG5dJ6eNpyci8+tDoa+S58LRbEtfFYVk2
         CeRJreNokNdrgYmLQjaYS7bWtZb5VeuFFjwN3jk9WELZK1rsorFXA9SE9u2WvtJ4g0lt
         4AXkbLKuZDTHjjNzUcwJqqwFWIJARgT7vWdRfkNfy1T7DTPSZ+i+WpuQOemEobyGbHaU
         5m1Q==
X-Gm-Message-State: APjAAAWV++10b30UPiCAWxQ3PACT3bC/lk54FvKeLu/eakRybt22DSHD
        r08b05qRfLv5GhSIVOsznHnbeOBSf94=
X-Google-Smtp-Source: APXvYqyEpkzMvJTCDY9XVuVH5i9haT6A0BQ+SZpJBIVq1q/uWQbyyODfynIElCuCYC8tz3iQJ6G77Q==
X-Received: by 2002:a17:902:e20c:: with SMTP id ce12mr116675854plb.130.1564451433161;
        Mon, 29 Jul 2019 18:50:33 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:32 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, hirofumi@mail.parknet.co.jp
Subject: [PATCH 12/20] fs: fat: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:16 -0700
Message-Id: <20190730014924.2193-13-deepa.kernel@gmail.com>
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

Some FAT variants indicate that the years after 2099 are not supported.
Since commit 7decd1cb0305 ("fat: Fix and cleanup timestamp conversion"),
we support the full range of years that can be represented, up to 2107.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hirofumi@mail.parknet.co.jp
---
 fs/fat/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 05689198f5af..5f04c5c810fb 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -31,6 +31,11 @@
 
 #define KB_IN_SECTORS 2
 
+/* DOS dates from 1980/1/1 through 2107/12/31 */
+#define FAT_DATE_MIN (0<<9 | 1<<5 | 1)
+#define FAT_DATE_MAX (127<<9 | 12<<5 | 31)
+#define FAT_TIME_MAX (23<<11 | 59<<5 | 29)
+
 /*
  * A deserialized copy of the on-disk structure laid out in struct
  * fat_boot_sector.
@@ -1605,6 +1610,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	int debug;
 	long error;
 	char buf[50];
+	struct timespec64 ts;
 
 	/*
 	 * GFP_KERNEL is ok here, because while we do hold the
@@ -1698,6 +1704,12 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	sbi->free_clus_valid = 0;
 	sbi->prev_free = FAT_START_ENT;
 	sb->s_maxbytes = 0xffffffff;
+	fat_time_fat2unix(sbi, &ts, 0, cpu_to_le16(FAT_DATE_MIN), 0);
+	sb->s_time_min = ts.tv_sec;
+
+	fat_time_fat2unix(sbi, &ts, cpu_to_le16(FAT_TIME_MAX),
+			  cpu_to_le16(FAT_DATE_MAX), 0);
+	sb->s_time_max = ts.tv_sec;
 
 	if (!sbi->fat_length && bpb.fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
-- 
2.17.1

