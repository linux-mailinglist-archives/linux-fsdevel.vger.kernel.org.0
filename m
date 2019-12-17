Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52E8123998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLQWTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:19:18 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:46933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLQWTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:19:14 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKKhF-1iOrCN359b-00Looj; Tue, 17 Dec 2019 23:17:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 21/27] compat_ioctl: move cdrom commands into cdrom.c
Date:   Tue, 17 Dec 2019 23:17:02 +0100
Message-Id: <20191217221708.3730997-22-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xQtqzDF0k6u89EQieIQzUB9hiVcXtS5mjt2hY+zFGQb8APrgaxJ
 mBUBNv6HQTyWI67r5klVxNs8hbG34FMJ6V4H1OIknx+iXFwtjM25VsaYwp88i2z0nwoWi1I
 TnTgZeCsnC1aCMB9hk8IaX2/KgLUhBCJxsDWxtft0DzXyc+PzBt+rt/ZuyVMomqnjviYnh3
 YoVR+mpglYKYjo8U/jGGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNPJQbvKd+U=:MpWDPVhy5y+i9LqCtJmTmu
 6rkUBZ4gXyXzKxtB/tFOl7A5y+hEU4TED8JWQgJ2isNp9eMh71mKG0ZTXIyBVqnnXnMz6ZzIk
 cwvQVxdoM+OkoUPEH1AYuTpfGTDFlhX2aT8My3SbrLvONUjOt1Hi+uGLtQLiEWiNwwzBA6y5Y
 OLncZQuRAq4yIMRZwN4zswmQICGt5DTcjgOVX2OJ0/K7oBUaMb2Y+5HmGwa9AfZ3dum3zZiKW
 3MaW8IaqB5h2v6ACeBBi/0QlBlk6qGM0Z2Vg6BrD70OhREPIuMlRysYUqSNl95+7DG1t5u07q
 VW0nT2wuOQOG7RKpg2DPN21t+mxmPuLYr7s2N5UKormAGysU37nm2O0cy3fFk+MtxdRRmy5hv
 haQ8FdrRKHA9ki+wiEo9W+axXfVz+bXL9Jy/casciu5wxQ7BpJ+SSwXul3TO3V1GiKV5lmq+6
 xtGhudSAjpl3JVNugwDKiMJ49ijrh7OPKH8VWZg+qGoDsgAbzlGz7IjBRi/CO5mjKcFnK1LM6
 /XS+6SYCp8MXbznn5MWAXS/5jtS4I9Tx5P/s9iv3UvGtwtS1iHQWBeVaIANpFvAT88NhXM+Yy
 EzBJWS3cGVKhUfx12Lcn4EmBc+xHaAPxbnHEM/RatnKc5dl86+m/bNfr9hkerJCTuNhoiHqeh
 laVSWhnadCyCeXocU6Lice+7EZ7oTmJaCG71UKBydjRa3XbXT2sQUXnNE5OH79/SQlPyJFZYd
 1F7Y8cf2R3Jhx0GLvVBIsTPJhewRJxdITcP7GijENBG6TY3lfjWdVNgrCqIomX9LjVyS9ki2v
 M2jchqHAy81dGqM3yECcIr+jfNeu98PEf1uSEeZGzI+CcHemHpYaJ/sGQyc4m1HMNwSTQ8cfR
 lXW2ZFqZ+z3qFEY+ixDg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need for the special cases for the cdrom ioctls any more now,
so make sure that each cdrom driver has a .compat_ioctl() callback and
calls cdrom_compat_ioctl() directly there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c       | 45 --------------------------------------
 drivers/block/paride/pcd.c |  3 +++
 drivers/cdrom/gdrom.c      |  3 +++
 drivers/ide/ide-cd.c       | 36 ++++++++++++++++++++++++++++++
 drivers/scsi/sr.c          | 10 +++------
 5 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index cf136bc2c9fc..7cb534d6e767 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -159,42 +159,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case HDIO_DRIVE_CMD:
 	/* 0x330 is reserved -- it used to be HDIO_GETGEO_BIG */
 	case 0x330:
-	/* CDROM stuff */
-	case CDROMPAUSE:
-	case CDROMRESUME:
-	case CDROMPLAYMSF:
-	case CDROMPLAYTRKIND:
-	case CDROMREADTOCHDR:
-	case CDROMREADTOCENTRY:
-	case CDROMSTOP:
-	case CDROMSTART:
-	case CDROMEJECT:
-	case CDROMVOLCTRL:
-	case CDROMSUBCHNL:
-	case CDROMMULTISESSION:
-	case CDROM_GET_MCN:
-	case CDROMRESET:
-	case CDROMVOLREAD:
-	case CDROMSEEK:
-	case CDROMPLAYBLK:
-	case CDROMCLOSETRAY:
-	case CDROM_DISC_STATUS:
-	case CDROM_CHANGER_NSLOTS:
-	case CDROM_GET_CAPABILITY:
-	case CDROM_SEND_PACKET:
-	/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
-	 * not take a struct cdrom_read, instead they take a struct cdrom_msf
-	 * which is compatible.
-	 */
-	case CDROMREADMODE2:
-	case CDROMREADMODE1:
-	case CDROMREADRAW:
-	case CDROMREADCOOKED:
-	case CDROMREADALL:
-	/* DVD ioctls */
-	case DVD_READ_STRUCT:
-	case DVD_WRITE_STRUCT:
-	case DVD_AUTH:
 		arg = (unsigned long)compat_ptr(arg);
 	/* These intepret arg as an unsigned long, not as a pointer,
 	 * so we must not do compat_ptr() conversion. */
@@ -210,15 +174,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case HDIO_SET_ACOUSTIC:
 	case HDIO_SET_BUSSTATE:
 	case HDIO_SET_ADDRESS:
-	case CDROMEJECT_SW:
-	case CDROM_SET_OPTIONS:
-	case CDROM_CLEAR_OPTIONS:
-	case CDROM_SELECT_SPEED:
-	case CDROM_SELECT_DISC:
-	case CDROM_MEDIA_CHANGED:
-	case CDROM_DRIVE_STATUS:
-	case CDROM_LOCKDOOR:
-	case CDROM_DEBUG:
 		break;
 	default:
 		/* unknown ioctl number */
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 636bfea2de6f..117cfc8cd05a 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -275,6 +275,9 @@ static const struct block_device_operations pcd_bdops = {
 	.open		= pcd_block_open,
 	.release	= pcd_block_release,
 	.ioctl		= pcd_block_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl		= blkdev_compat_ptr_ioctl,
+#endif
 	.check_events	= pcd_block_check_events,
 };
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 5b21dc421c94..886b2638c730 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -518,6 +518,9 @@ static const struct block_device_operations gdrom_bdops = {
 	.release		= gdrom_bdops_release,
 	.check_events		= gdrom_bdops_check_events,
 	.ioctl			= gdrom_bdops_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl			= blkdev_compat_ptr_ioctl,
+#endif
 };
 
 static irqreturn_t gdrom_command_interrupt(int irq, void *dev_id)
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 9d117936bee1..2de6e8ace957 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -25,6 +25,7 @@
 
 #define IDECD_VERSION "5.00"
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -1710,6 +1711,38 @@ static int idecd_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned int cmd, unsigned long arg)
+{
+	struct cdrom_info *info = ide_drv_g(bdev->bd_disk, cdrom_info);
+	int err;
+
+	switch (cmd) {
+	case CDROMSETSPINDOWN:
+		return idecd_set_spindown(&info->devinfo, arg);
+	case CDROMGETSPINDOWN:
+		return idecd_get_spindown(&info->devinfo, arg);
+	default:
+		break;
+	}
+
+	return cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
+			   (unsigned long)compat_ptr(arg));
+}
+
+static int idecd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			     unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	mutex_lock(&ide_cd_mutex);
+	ret = idecd_locked_compat_ioctl(bdev, mode, cmd, arg);
+	mutex_unlock(&ide_cd_mutex);
+
+	return ret;
+}
+#endif
 
 static unsigned int idecd_check_events(struct gendisk *disk,
 				       unsigned int clearing)
@@ -1732,6 +1765,9 @@ static const struct block_device_operations idecd_ops = {
 	.open			= idecd_open,
 	.release		= idecd_release,
 	.ioctl			= idecd_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= idecd_compat_ioctl,
+#endif
 	.check_events		= idecd_check_events,
 	.revalidate_disk	= idecd_revalidate_disk
 };
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 6033a886c42c..0fbb8fe6e521 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -628,13 +628,9 @@ static int sr_block_compat_ioctl(struct block_device *bdev, fmode_t mode, unsign
 		goto put;
 	}
 
-	/*
-	 * CDROM ioctls are handled in the block layer, but
-	 * do the scsi blk ioctls here.
-	 */
-	ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
-	if (ret != -ENOTTY)
-		return ret;
+	ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, (unsigned long)argp);
+	if (ret != -ENOSYS)
+		goto put;
 
 	ret = scsi_compat_ioctl(sdev, cmd, argp);
 
-- 
2.20.0

