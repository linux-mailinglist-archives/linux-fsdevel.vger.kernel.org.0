Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5D59DC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1OcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 10:32:10 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:52998 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1OcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:32:10 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 7A5431B457B;
        Fri, 28 Jun 2019 23:32:08 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SEW7xw030708
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 23:32:08 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x5SEW7vV013687
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 23:32:07 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x5SEW6j4013686;
        Fri, 28 Jun 2019 23:32:06 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fat: Add nobarrier to workaround the strange behavior of device
Date:   Fri, 28 Jun 2019 23:32:06 +0900
Message-ID: <87woh5pyqh.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


v2:
Just cleanup, changed the place of options under comment of fat.

---

There was the report of strange behavior of device with recent
blkdev_issue_flush() position change.

The following is simplified usbmon trace.

 4203   9.160230         host -> 1.25.1       USBMS 95 SCSI: Synchronize Cache(10) LUN: 0x00 (LBA: 0x00000000, Len: 0)
 4206   9.164911       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Synchronize Cache(10)) (Good)
 4207   9.323927         host -> 1.25.1       USBMS 95 SCSI: Read(10) LUN: 0x00 (LBA: 0x00279950, Len: 240)
 4212   9.327138       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Read(10)) (Good)

[...]

 7323  10.202167         host -> 1.25.1       USBMS 95 SCSI: Synchronize Cache(10) LUN: 0x00 (LBA: 0x00000000, Len: 0)
 7326  10.432266       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Synchronize Cache(10)) (Good)
 7327  10.769092         host -> 1.25.1       USBMS 95 SCSI: Test Unit Ready LUN: 0x00 
 7330  10.769192       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Test Unit Ready) (Good)
 7335  12.849093         host -> 1.25.1       USBMS 95 SCSI: Test Unit Ready LUN: 0x00 
 7338  12.849206       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Test Unit Ready) (Check Condition)
 7339  12.849209         host -> 1.25.1       USBMS 95 SCSI: Request Sense LUN: 0x00
 
If "Synchronize Cache" command issued then there is idle time, the
device stop to process further commands, and behave as like no media.
(it returns NOT_READY [MEDIUM NOT PRESENT] for SENSE command, and this
happened on Kindle) [just a guess, the device is trying to detect the
"safe-unplug" operation of Windows or such?]

To workaround those devices and provide flexibility, this adds
"barrier"/"nobarrier" mount options to fat driver.

Cc: <stable@vger.kernel.org>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fat.h   |    1 +
 fs/fat/file.c  |    8 ++++++--
 fs/fat/inode.c |   22 +++++++++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff -puN fs/fat/fat.h~fat-nobarrier fs/fat/fat.h
--- linux/fs/fat/fat.h~fat-nobarrier	2019-06-28 21:22:18.146191739 +0900
+++ linux-hirofumi/fs/fat/fat.h	2019-06-28 23:26:04.881215721 +0900
@@ -51,6 +51,7 @@ struct fat_mount_options {
 		 tz_set:1,	   /* Filesystem timestamps' offset set */
 		 rodir:1,	   /* allow ATTR_RO for directory */
 		 discard:1,	   /* Issue discard requests on deletions */
+		 barrier:1,	   /* Issue FLUSH command */
 		 dos1xfloppy:1;	   /* Assume default BPB for DOS 1.x floppies */
 };
 
diff -puN fs/fat/file.c~fat-nobarrier fs/fat/file.c
--- linux/fs/fat/file.c~fat-nobarrier	2019-06-28 21:22:18.147191734 +0900
+++ linux-hirofumi/fs/fat/file.c	2019-06-28 23:26:04.881215721 +0900
@@ -193,17 +193,21 @@ static int fat_file_release(struct inode
 int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	int err;
 
 	err = __generic_file_fsync(filp, start, end, datasync);
 	if (err)
 		return err;
 
-	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);
+	err = sync_mapping_buffers(sbi->fat_inode->i_mapping);
 	if (err)
 		return err;
 
-	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+	if (sbi->options.barrier)
+		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+
+	return err;
 }
 
 
diff -puN fs/fat/inode.c~fat-nobarrier fs/fat/inode.c
--- linux/fs/fat/inode.c~fat-nobarrier	2019-06-28 21:22:18.148191730 +0900
+++ linux-hirofumi/fs/fat/inode.c	2019-06-28 23:26:28.029103863 +0900
@@ -1016,6 +1016,8 @@ static int fat_show_options(struct seq_f
 		seq_puts(m, ",nfs=stale_rw");
 	if (opts->discard)
 		seq_puts(m, ",discard");
+	if (!opts->barrier)
+		seq_puts(m, ",nobarrier");
 	if (opts->dos1xfloppy)
 		seq_puts(m, ",dos1xfloppy");
 
@@ -1031,8 +1033,9 @@ enum {
 	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
 	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
 	Opt_obsolete, Opt_flush, Opt_tz_utc, Opt_rodir, Opt_err_cont,
-	Opt_err_panic, Opt_err_ro, Opt_discard, Opt_nfs, Opt_time_offset,
-	Opt_nfs_stale_rw, Opt_nfs_nostale_ro, Opt_err, Opt_dos1xfloppy,
+	Opt_err_panic, Opt_err_ro, Opt_discard, Opt_barrier, Opt_nobarrier,
+	Opt_nfs, Opt_time_offset, Opt_nfs_stale_rw, Opt_nfs_nostale_ro,
+	Opt_err, Opt_dos1xfloppy,
 };
 
 static const match_table_t fat_tokens = {
@@ -1062,6 +1065,8 @@ static const match_table_t fat_tokens =
 	{Opt_err_panic, "errors=panic"},
 	{Opt_err_ro, "errors=remount-ro"},
 	{Opt_discard, "discard"},
+	{Opt_barrier, "barrier"},
+	{Opt_nobarrier, "nobarrier"},
 	{Opt_nfs_stale_rw, "nfs"},
 	{Opt_nfs_stale_rw, "nfs=stale_rw"},
 	{Opt_nfs_nostale_ro, "nfs=nostale_ro"},
@@ -1146,6 +1151,7 @@ static int parse_options(struct super_bl
 	opts->numtail = 1;
 	opts->usefree = opts->nocase = 0;
 	opts->tz_set = 0;
+	opts->barrier = 1;
 	opts->nfs = 0;
 	opts->errors = FAT_ERRORS_RO;
 	*debug = 0;
@@ -1269,6 +1275,15 @@ static int parse_options(struct super_bl
 		case Opt_err_ro:
 			opts->errors = FAT_ERRORS_RO;
 			break;
+		case Opt_discard:
+			opts->discard = 1;
+			break;
+		case Opt_barrier:
+			opts->barrier = 1;
+			break;
+		case Opt_nobarrier:
+			opts->barrier = 0;
+			break;
 		case Opt_nfs_stale_rw:
 			opts->nfs = FAT_NFS_STALE_RW;
 			break;
@@ -1332,9 +1347,6 @@ static int parse_options(struct super_bl
 		case Opt_rodir:
 			opts->rodir = 1;
 			break;
-		case Opt_discard:
-			opts->discard = 1;
-			break;
 
 		/* obsolete mount options */
 		case Opt_obsolete:
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
