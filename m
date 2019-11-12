Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F10F9BB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKLVNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:46 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37624 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727482AbfKLVNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:45 -0500
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDiUc029692
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:44 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDda6026637
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:44 -0500
Received: by mail-qk1-f197.google.com with SMTP id p68so45444qkf.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kG7Ptaq+86UuiddtLF3z6ZZhHPb5HLJn9YbpAAIlC6g=;
        b=NAq+9NWUnQsvmh7tXKpysHO1MfMB/IaMrYfyRNlwW3l1fFodFjLy+LYqToTiIwfoRi
         Zan20zB5MZ42Tn3Xdjv8pBSDO8N/qIbhHFJA0S/Y5VmGuDezUG43hvIM0Wjuv6+Pfy2b
         fKOJkiwWRxIlqMFjFtuclg6DCux/PcEd0aCc0M+qkjo0xyI9bv2eRXPLa5zUZQYuA0z2
         PVN3ecdrX/VylwvSvJiTxCshWUGG4ll0xp+1P3+reIihrJSWpDzVeO2Y5d18ydsezOHP
         N7SPMsgUE0bWDfK6exIKjxR9cufTjQdc2yi8ghrnvOB/8Lfm3DY/cDAMbgmaNdII/BtJ
         RJRA==
X-Gm-Message-State: APjAAAX8dyyeTK42Hqft5BPWMcH/8BBkLTabssA36j40hfvSxoBURdcI
        lKs++/E611/EMf2vfe1YNzQ8xyAdIdZnzSxXpUuG03XZqDJtwAhXgm5XrKjk8gDWdI5EiPkfF1N
        nCUpJwXP2BOIH1oQA35f/RlH+6Tk7KPdRczOk
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr33362159qtk.31.1573593218506;
        Tue, 12 Nov 2019 13:13:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVIlNCsK9Ac0q93isCUr3PgF+MgibBGZqIuHluMITzT2edSbTc9sATSaQOnX7hr6yi/9BQvQ==
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr33362137qtk.31.1573593218178;
        Tue, 12 Nov 2019 13:13:38 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:37 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: exfat: Clean up the namespace pollution part 2
Date:   Tue, 12 Nov 2019 16:12:32 -0500
Message-Id: <20191112211238.156490-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename all the bdev_* to exfat_bdev_*

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h        | 10 +++++-----
 drivers/staging/exfat/exfat_blkdev.c | 10 +++++-----
 drivers/staging/exfat/exfat_core.c   |  8 ++++----
 drivers/staging/exfat/exfat_super.c  | 16 ++++++++--------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 5efba3d4259b..5044523ccb97 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -842,13 +842,13 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 int multi_sector_write(struct super_block *sb, sector_t sec,
 		       struct buffer_head *bh, s32 num_secs, bool sync);
 
-void bdev_open(struct super_block *sb);
-void bdev_close(struct super_block *sb);
-int bdev_read(struct super_block *sb, sector_t secno,
+void exfat_bdev_open(struct super_block *sb);
+void exfat_bdev_close(struct super_block *sb);
+int exfat_bdev_read(struct super_block *sb, sector_t secno,
 	      struct buffer_head **bh, u32 num_secs, bool read);
-int bdev_write(struct super_block *sb, sector_t secno,
+int exfat_bdev_write(struct super_block *sb, sector_t secno,
 	       struct buffer_head *bh, u32 num_secs, bool sync);
-int bdev_sync(struct super_block *sb);
+int exfat_bdev_sync(struct super_block *sb);
 
 extern const u8 uni_upcase[];
 #endif /* _EXFAT_H */
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 0abae041f632..7bcd98b13109 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -8,7 +8,7 @@
 #include <linux/fs.h>
 #include "exfat.h"
 
-void bdev_open(struct super_block *sb)
+void exfat_bdev_open(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
@@ -23,14 +23,14 @@ void bdev_open(struct super_block *sb)
 	p_bd->opened = true;
 }
 
-void bdev_close(struct super_block *sb)
+void exfat_bdev_close(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	p_bd->opened = false;
 }
 
-int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
+int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	      u32 num_secs, bool read)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -65,7 +65,7 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	return -EIO;
 }
 
-int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
+int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	       u32 num_secs, bool sync)
 {
 	s32 count;
@@ -118,7 +118,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	return -EIO;
 }
 
-int bdev_sync(struct super_block *sb)
+int exfat_bdev_sync(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 #ifdef CONFIG_EXFAT_KERNEL_DEBUG
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 2dc07e81bad0..5a01fc25f31d 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2569,7 +2569,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_read(sb, sec, bh, 1, read);
+		ret = exfat_bdev_read(sb, sec, bh, 1, read);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2598,7 +2598,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_write(sb, sec, bh, 1, sync);
+		ret = exfat_bdev_write(sb, sec, bh, 1, sync);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2621,7 +2621,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_read(sb, sec, bh, num_secs, read);
+		ret = exfat_bdev_read(sb, sec, bh, num_secs, read);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2649,7 +2649,7 @@ int multi_sector_write(struct super_block *sb, sector_t sec,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_write(sb, sec, bh, num_secs, sync);
+		ret = exfat_bdev_write(sb, sec, bh, num_secs, sync);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index cf094458b5d2..7309053105d8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -289,7 +289,7 @@ static DEFINE_MUTEX(z_mutex);
 static inline void fs_sync(struct super_block *sb, bool do_sync)
 {
 	if (do_sync)
-		bdev_sync(sb);
+		exfat_bdev_sync(sb);
 }
 
 /*
@@ -361,7 +361,7 @@ static int ffsMountVol(struct super_block *sb)
 	p_fs->dev_ejected = 0;
 
 	/* open the block device */
-	bdev_open(sb);
+	exfat_bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
 		printk(KERN_INFO "EXFAT: maont failed - sector size %d less than blocksize %ld\n",
@@ -385,7 +385,7 @@ static int ffsMountVol(struct super_block *sb)
 	/* check the validity of PBR */
 	if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
 		brelse(tmp_bh);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
@@ -407,26 +407,26 @@ static int ffsMountVol(struct super_block *sb)
 	brelse(tmp_bh);
 
 	if (ret) {
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 
 	ret = load_alloc_bitmap(sb);
 	if (ret) {
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 	ret = load_upcase_table(sb);
 	if (ret) {
 		free_alloc_bitmap(sb);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 
 	if (p_fs->dev_ejected) {
 		free_upcase_table(sb);
 		free_alloc_bitmap(sb);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		ret = -EIO;
 		goto out;
 	}
@@ -461,7 +461,7 @@ static int ffsUmountVol(struct super_block *sb)
 	buf_release_all(sb);
 
 	/* close the block device */
-	bdev_close(sb);
+	exfat_bdev_close(sb);
 
 	if (p_fs->dev_ejected) {
 		pr_info("[EXFAT] unmounted with media errors. Device is already ejected.\n");
-- 
2.24.0

