Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476EE79E56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfG3Bub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbfG3Bua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so5806993pfa.13;
        Mon, 29 Jul 2019 18:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rtfYQ+Fr6rn8tMWD9jomVyK2aw/48rQfrLzbB373D0w=;
        b=VzijVnAMb26+mnUZVJWAQvsMW5OwVnBsB2HGhcI+BaJFihiv7fy/RAZEjj88lmWd2i
         2cwtl7p8aJB/hgOaT3EBy0IHyWOMiAPVLBa1jmAp4z+hsyRy0gXr59wz4YbB0fFQ5hfE
         Itj/SXB7EjUSvoB0mxK1aiStQEenb/tK1RwHh/V7sBB8X1H2Xthiaqzfpzd6CxqSJ2c+
         4G+aiSEKSOMWwj4t6dr6HMxajpvcIf7Pb/DIO0t9MbJNfmAQ9t5/boG4vGDkogUTPanp
         ddOycjrYvsR+vnGXjq9Q1q/OIQ4iNAa0xUqmBUjyoAsyg7Grj4Ao9TnymNj5mcSSTaJD
         6a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rtfYQ+Fr6rn8tMWD9jomVyK2aw/48rQfrLzbB373D0w=;
        b=pf+UJwJ8sqCzSMituVewd1Jbebrn72vkKXlZs8YhpfrkIPsrgU20ybsbiH5KX6eChc
         hhgqlnXlSEoifAKTgPIqnWqdWW/qtKQ85HO9avHoeRy9MBs/y/mi30pLIycVmOHUQnUy
         GM94zPMWMAU0z6cxW02iWBPxy6ApUGdpB3Nj2Q/X/G0zVyE/mg9jdQ/mmpJGHM4brwlI
         DAOp6OHPRxiaIdWpkwjHDduKqxdtlR9E1NUI9NO00oYZ2zRAgXVeoRQOBj47bQgRPeOq
         ez2qGOZ2hLySN80S+wCeQ4PqIuq2UFDlodD94R4HJIw3EE/MvXMfhpjWhx9Tmh0Iy+EX
         iy9g==
X-Gm-Message-State: APjAAAUyBaKNnwoVkfXQePD7H+8vFyHXWz8arEUosjaX+uuiaOtqTDFY
        0AIlQiYjD69mY93fmCqNOB0=
X-Google-Smtp-Source: APXvYqwfwoV+k3jPwNM9uVpzpHuXPBoPSprQG+/gn8yAYSq3waSIrl+s19WGxiWLBVTtshsVUBmtxA==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr49714185pgq.269.1564451429776;
        Mon, 29 Jul 2019 18:50:29 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:29 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: [PATCH 09/20] ext4: Initialize timestamps limits
Date:   Mon, 29 Jul 2019 18:49:13 -0700
Message-Id: <20190730014924.2193-10-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
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

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: tytso@mit.edu
Cc: adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h  |  4 ++++
 fs/ext4/super.c | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb67859e051..3f13cf12ae7f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1631,6 +1631,10 @@ static inline void ext4_clear_state_flags(struct ext4_inode_info *ei)
 
 #define EXT4_GOOD_OLD_INODE_SIZE 128
 
+#define EXT4_EXTRA_TIMESTAMP_MAX	(((s64)1 << 34) - 1  + S32_MIN)
+#define EXT4_NON_EXTRA_TIMESTAMP_MAX	S32_MAX
+#define EXT4_TIMESTAMP_MIN		S32_MIN
+
 /*
  * Feature set definitions
  */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..3ea2d60f33aa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4035,8 +4035,21 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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

