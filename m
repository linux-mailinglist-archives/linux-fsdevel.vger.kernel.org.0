Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D633B03E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhFVMOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFVMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mz9EL-1l0W4B0isF-00wAP7; Tue, 22 Jun 2021 14:11:44 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 5/6] fs: fat: move fstrim to file_operation
Date:   Tue, 22 Jun 2021 14:11:35 +0200
Message-Id: <20210622121136.4394-6-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HP+X6q1Mk7DWbMk8g+sq21GR1yl081MwQLDvnRhGAxt9Js+B0An
 C/fXYdsBDIiZezEGg2mQjdrqVOOMzWKWJoCrqoac9YpdV2uslnQIr+Sez3lUMl0stzG2z1o
 JK5/DBcnR6S22R//ycLAgw6j0xGfNVeXs8WkOA/PWjBNxjT2EFAKSMXcFvG1WT8Ruw85mfP
 aBs/PCfVPDZl2IcUMW7Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7re4Z4QABM=:gVjErhWj6FvjpNSx9psr3+
 TFDIWk8TaCtOmFCJZqUtoSppDNMyN5WVENoH4/dq9G/Nz1A/CEc46xKdwLp8t2bucxmXGD3G7
 80ApmVdg8UlijDOjhNrY2sJi0rEzgwh/Ij50QZs0Lm6cUEzd+h0r2kDkIfVlKvSyCPMZEOzBq
 +Np0MkUa0mvKCHGhip8ksK3ntJqr1dJGamK5yZ+73EgPH8cfQm+WEO75nBieJ1ZFuqLx/ZyY9
 QEwUWf1FRaxsoRkz5NawwYcXZ9jT0srCtWsqdIchoqht786P3rPILomYkFgOvkXCwdpEZxaVu
 B9mpycmenwu7U3oJacBYQ3xdlJaYsNzKlG9gp26vKWkMNEBtD3Y6qiEx8s86e4IdAq04ARTiB
 oeaphPenWYSs1z9vBPsLAbnU0XeYzZUTJ+yVrjw+K8hm9Bp2PmHOvj/hW2MGFQV5UlL4Vb9qx
 mgOJ6rTSrTKGzkl8QHp4sMZ6MA7Bm3Re68HBCFhQumnEuXFjheIvlObvcuZFTgzxNbWJo42ET
 RvJFN42PLm0Bhz1whueuN8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced file_operation callback for FITRIM ioctl.
This removes some common code, eg. permission check, buffer copying,
which is now done by generic vfs code.
---
 fs/fat/file.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13855ba49cd9..5f57f06341d0 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -122,35 +122,20 @@ static int fat_ioctl_get_volume_id(struct inode *inode, u32 __user *user_attr)
 	return put_user(sbi->vol_id, user_attr);
 }
 
-static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
+static int fat_ioctl_fitrim(struct file *file, struct fstrim_range *range)
 {
+	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
-	struct fstrim_range __user *user_range;
-	struct fstrim_range range;
 	struct request_queue *q = bdev_get_queue(sb->s_bdev);
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (!blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
-	user_range = (struct fstrim_range __user *)arg;
-	if (copy_from_user(&range, user_range, sizeof(range)))
-		return -EFAULT;
-
-	range.minlen = max_t(unsigned int, range.minlen,
+	range->minlen = max_t(unsigned int, range->minlen,
 			     q->limits.discard_granularity);
 
-	err = fat_trim_fs(inode, &range);
-	if (err < 0)
-		return err;
-
-	if (copy_to_user(user_range, &range, sizeof(range)))
-		return -EFAULT;
-
-	return 0;
+	return fat_trim_fs(inode, range);
 }
 
 long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
@@ -165,8 +150,6 @@ long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return fat_ioctl_set_attributes(filp, user_attr);
 	case FAT_IOCTL_GET_VOLUME_ID:
 		return fat_ioctl_get_volume_id(inode, user_attr);
-	case FITRIM:
-		return fat_ioctl_fitrim(inode, arg);
 	default:
 		return -ENOTTY;	/* Inappropriate ioctl for device */
 	}
-- 
2.20.1

