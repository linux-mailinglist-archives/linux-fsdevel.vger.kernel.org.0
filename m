Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD33B03E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFVMOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhFVMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UIe-1lwDDZ2rTu-000e4a; Tue, 22 Jun 2021 14:11:43 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 3/6] fs: hpfs: move fstrim to file_operation
Date:   Tue, 22 Jun 2021 14:11:33 +0200
Message-Id: <20210622121136.4394-4-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i9Va3/wzWYKOOMpUq4UWF1AbMNkd+4d0zB4pLWM9Sw7zxUMVYVM
 T3Wu/xOVKxoOtH9osBQLS5sIuKS05e0cVAul1aQmq+bXvsjMwnMLiQC+LKN9PyP4Bf5N2Ms
 Oq7t435SSeRsDtYYHq8kfMzmbi7diPhyn3LUb9KcE3rRkD15HbC448fk+PNUFBRunYUINCu
 nOI0W+0PTP0Zy8Gd5keQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C5z7gN4M5/s=:fQeweGJCa1sjTb/306Jk9T
 +LJY9vpgHQdvbGTX9dDp7IpYfLgH08UDQPk9xepqsAUjqa3OAZyCYxUZegtWF4179ru5gVvRO
 BG8gXVOjKyrlCEU+52gAQzvGKxMHaMl5U3D4eCuHHiEElrQpPrAYbwzW6gDW6lOHlqiKTt1p6
 iCrCEubrJP3hLdXPiGaz0gQS7Q8tGrTeYGlFLc3i07J4PsAwgkWG9xIcimYP9vJtd5cl1NKYD
 V84dNTKIF/P1zSxnBPfVXH4FWccAc4VdVSF+hq20nRxJem287VPx/Ar7FFQedDEq0YgcU2v/M
 0pRvcqrdKUUYyzrXchR7XPf1HcElX1VL21/faN9pkZMrJ6ictTO7UQKxBn4JhAActBiKLfRuk
 VY+k2cL6VrFIBOM23UEkcV+g+L/+JGMPFXkZj4jhYqgwi5lvO1PGock0fsJFBrr9ra8QaWc5m
 kp5wOjyEwZY0YyMAVp+QBqRN+BRK9ZWTPMBCE14i0Pq5RSWqrC6+CvHCrmfPDlS7BvEUtKiqB
 wbJ+wtwQ6i5Ey6El7QFKYA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced file_operation callback for FITRIM ioctl.
This removes some common code, eg. permission check, buffer copying,
which is now done by generic vfs code.
---
 fs/hpfs/dir.c     |  1 +
 fs/hpfs/file.c    |  1 +
 fs/hpfs/hpfs_fn.h |  1 +
 fs/hpfs/super.c   | 36 +++++++++++++++---------------------
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index f32f15669996..92084f4ce6a7 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -326,4 +326,5 @@ const struct file_operations hpfs_dir_ops =
 	.fsync		= hpfs_file_fsync,
 	.unlocked_ioctl	= hpfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.fitrim		= hpfs_fitrim,
 };
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 077c25128eb7..66112702cd4c 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -216,6 +216,7 @@ const struct file_operations hpfs_file_ops =
 	.splice_read	= generic_file_splice_read,
 	.unlocked_ioctl	= hpfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.fitrim		= hpfs_fitrim,
 };
 
 const struct inode_operations hpfs_file_iops =
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 167ec6884642..05c558084033 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -329,6 +329,7 @@ void hpfs_error(struct super_block *, const char *, ...);
 int hpfs_stop_cycles(struct super_block *, int, int *, int *, char *);
 unsigned hpfs_get_free_dnodes(struct super_block *);
 long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg);
+long hpfs_fitrim(struct file *file, struct fstrim_range *range);
 
 /*
  * local time (HPFS) to GMT (Unix)
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index a7dbfc892022..8c45cb749ba4 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -200,30 +200,24 @@ static int hpfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+long hpfs_fitrim(struct file *file, struct fstrim_range *range)
+{
+	secno n_trimmed;
+
+	int r = hpfs_trim_fs(file_inode(file)->i_sb, range->start >> 9,
+			     (range->start + range->len) >> 9,
+			     (range->minlen + 511) >> 9, &n_trimmed);
+
+	if (r)
+		return r;
+
+	range->len = (u64)n_trimmed << 9;
+	return 0;
+}
 
 long hpfs_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
-	switch (cmd) {
-		case FITRIM: {
-			struct fstrim_range range;
-			secno n_trimmed;
-			int r;
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-			if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
-				return -EFAULT;
-			r = hpfs_trim_fs(file_inode(file)->i_sb, range.start >> 9, (range.start + range.len) >> 9, (range.minlen + 511) >> 9, &n_trimmed);
-			if (r)
-				return r;
-			range.len = (u64)n_trimmed << 9;
-			if (copy_to_user((struct fstrim_range __user *)arg, &range, sizeof(range)))
-				return -EFAULT;
-			return 0;
-		}
-		default: {
-			return -ENOIOCTLCMD;
-		}
-	}
+	return -ENOIOCTLCMD;
 }
 
 
-- 
2.20.1

