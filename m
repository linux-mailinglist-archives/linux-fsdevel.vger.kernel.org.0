Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179A09181E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfHRQ76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38588 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfHRQ7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so4628304plt.5;
        Sun, 18 Aug 2019 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bixo0d9JjVSmJP3zunYh4uJR5sDX3PUyVSVA35Jm0FY=;
        b=WTuXL53CLURj5aLi3QpopNfU2HCbOZcvXfAXvNbLHaeiXRjkDE+OyGMppcB/hn4j5c
         WtdxFfM9N7Y5Srktdgxtrld2dilkdzOYzha5NVVFpiuW2FWR8k8X+GLKR6WZjwA3fyWj
         mpiwz4OQB0ho+A7z5D10nh7qcp9JIZLRwpo8EhA9vxZ0+DbCBMjCmnzIOYEjL/ZZyPsJ
         r2suupkpUgcLm20f30+NXLF6zgRInErF4rzxOMX/iPJjYjfrr57u8l4dn0lFWJIFiYg9
         QNU/xGdVV60c4OxpV4hAhVSWjRlv6AhnwYih73krgEGGmFrpFhlYJpsx+eA4Vjivm3l0
         id3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bixo0d9JjVSmJP3zunYh4uJR5sDX3PUyVSVA35Jm0FY=;
        b=DQU/SDgInBal71QcIsuGbN2Fz14x/V1A8gM/XGwOoJGXi1VeQmg+fkUIi6c9bWmVRI
         goN8Cyt4R5Z2AWP2OShjcCyz4EfH/E1UhrNtMHkE2H9uNw/ezwmkyJWBNxUpitqjD+0X
         dutdZVmo43L/3zWOmPpvZ7zZskmONLQWIyZmVCUeSJ99hbYbp3jfg1CWnCACvGtm85E2
         bNOVtU/A7TqK7HqfGLriyTrsjnpWpCD6jDIMZv4nEFyMoNy2aOheUGNkMUYuFr+IVy4o
         0TFm9CxiiPkrE+GkuizJIXPNNODWq+fAfTwgU2KmnKfYGlNEJhuJhnfqoAherlcLUhLR
         fN1w==
X-Gm-Message-State: APjAAAUIFcKZ+60pRC0vYNxlIZwKxXY9T9RTwl+MO+zmV/xkfgb526GA
        N0/x4SzSQ1SLO1wDVE6NkEY=
X-Google-Smtp-Source: APXvYqyKSFklkROLyfCHvHH06V4+O4L2K9sP6JRoVvpdbxityMSw53WzHF3Th+mpCDHKI3WCN44LBw==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr18746076pll.308.1566147592742;
        Sun, 18 Aug 2019 09:59:52 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:52 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: [PATCH v8 09/20] ext4: Initialize timestamps limits
Date:   Sun, 18 Aug 2019 09:58:06 -0700
Message-Id: <20190818165817.32634-10-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4 has different overflow limits for max filesystem
timestamps based on the extra bytes available.

The timestamp limits are calculated according to the
encoding table in
a4dad1ae24f85i(ext4: Fix handling of extended tv_sec):

* extra  msb of                         adjust for signed
* epoch  32-bit                         32-bit tv_sec to
* bits   time    decoded 64-bit tv_sec  64-bit tv_sec      valid time range
* 0 0    1    -0x80000000..-0x00000001  0x000000000   1901-12-13..1969-12-31
* 0 0    0    0x000000000..0x07fffffff  0x000000000   1970-01-01..2038-01-19
* 0 1    1    0x080000000..0x0ffffffff  0x100000000   2038-01-19..2106-02-07
* 0 1    0    0x100000000..0x17fffffff  0x100000000   2106-02-07..2174-02-25
* 1 0    1    0x180000000..0x1ffffffff  0x200000000   2174-02-25..2242-03-16
* 1 0    0    0x200000000..0x27fffffff  0x200000000   2242-03-16..2310-04-04
* 1 1    1    0x280000000..0x2ffffffff  0x300000000   2310-04-04..2378-04-22
* 1 1    0    0x300000000..0x37fffffff  0x300000000   2378-04-22..2446-05-10

Note that the time limits are not correct for deletion times.

Added a warn when an inode cannot be extended to incorporate an
extended timestamp.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: tytso@mit.edu
Cc: adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h  | 10 +++++++++-
 fs/ext4/super.c | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9c7f4036021b..ae5d0c86aba2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -832,11 +832,15 @@ static inline void ext4_decode_extra_time(struct timespec64 *time,
 
 #define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
 do {										\
-	(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);		\
 	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
+		(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);	\
 		(raw_inode)->xtime ## _extra =					\
 				ext4_encode_extra_time(&(inode)->xtime);	\
 		}								\
+	else	{\
+		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (inode)->xtime.tv_sec, S32_MIN, S32_MAX));	\
+		ext4_warning_inode(inode, "inode does not support timestamps beyond 2038"); \
+	} \
 } while (0)
 
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
@@ -1643,6 +1647,10 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 
 #define EXT4_GOOD_OLD_INODE_SIZE 128
 
+#define EXT4_EXTRA_TIMESTAMP_MAX	(((s64)1 << 34) - 1  + S32_MIN)
+#define EXT4_NON_EXTRA_TIMESTAMP_MAX	S32_MAX
+#define EXT4_TIMESTAMP_MIN		S32_MIN
+
 /*
  * Feature set definitions
  */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 27cd622676e7..3db5f17228b7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4039,8 +4039,21 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			       sbi->s_inode_size);
 			goto failed_mount;
 		}
-		if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE)
-			sb->s_time_gran = 1 << (EXT4_EPOCH_BITS - 2);
+		/*
+		 * i_atime_extra is the last extra field available for [acm]times in
+		 * struct ext4_inode. Checking for that field should suffice to ensure
+		 * we have extra space for all three.
+		 */
+		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
+			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
+			sb->s_time_gran = 1;
+			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+		} else {
+			sb->s_time_gran = NSEC_PER_SEC;
+			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+		}
+
+		sb->s_time_min = EXT4_TIMESTAMP_MIN;
 	}
 
 	sbi->s_desc_size = le16_to_cpu(es->s_desc_size);
-- 
2.17.1

