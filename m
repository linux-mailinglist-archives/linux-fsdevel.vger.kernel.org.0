Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679A6123960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLQWRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLQWRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:52 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPGNn-1iJtNn3lVt-00PeZf; Tue, 17 Dec 2019 23:17:31 +0100
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
Subject: [PATCH v2 17/27] compat_ioctl: ide: floppy: add handler
Date:   Tue, 17 Dec 2019 23:16:58 +0100
Message-Id: <20191217221708.3730997-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YnQrSz5O/D2DBGfbF3Cxsk8pwEEUjT589STUMJGh3yzpShzGnbO
 UtKl0ZGJsAHThUjdm9r51gvC9l545WINo2a5prkFBHzM+9RQY3Arloots1Xrir/7jn058ZY
 lY3dvFXWkGkgFTV1afb9NJTxv07jjMP3/LZ84ITxMj0bnoBEEePtmNtjq9iMjF1weBFG1TC
 CVXMzbb5iVF+fqWiS0O2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/6PR2RnMp8=:5roBt3plMVSEraB1jz2O5h
 p/M30legg9XR/Y/Kt/C/cwvJgImxkhqYbhnmDZ2jTM2ic2roOHdDCBbJwfOURYUFv0qGwYzWa
 B2qWZx8aF/jNGciRRonzsvtzrevrh8kgSm8SKRw4Z6HWilgQGzNa0JD2cygphpSkBHxjjTPe0
 H6R4AoSx5K3lxdgReJ5SvYGUxJbJUFdmlDojMI8lu4Tix3nugJN5mv6/AeZWrgBiEL+NG06x2
 SgnQ2R/DcJgY4NErD0D7vRfFy8nqvisRhkpns9431tOEz0o3rDBPRYcIgj+gshSq2sOxzJo2z
 h7k/r2KY1WXGuAc75gUQhqPjJKOm2k6nybp1HZs/+ZBZt7R26M699R/3vHkZACKON1XGl+aKr
 LvnRY6PJsnz4ob7wlAJmOaNdU2cazFj72pim9W9C/KJIazWpDqXAo4BNI11sjQQdRf2fRBuZI
 NJ/EqqAIZ9wL9g9N0iwnpBrRZy3dHYY4DFnVeu2s3VceoZerOn19nvm43OnFQhc1AkcPHlSmn
 5Ba+6ALgh7JeJNL8swznKcGRFu9oSkIixiuTNlJBhb1sr7lI0YaFAkyb2Ut6mRPAOx2Sj2EjE
 pFuCkh94PX3JIrwC96rcvZOvq400csat6sR/PyNWbUIDzTIjhvN8JQKpi4J8/RmkC1IUh8Htt
 XXtazTi9tD12OGpO4CotDAU1RxMk7FJ88cSUhUsvMRFvCL4La2Qgh1BiXbZm/PKI53oQA+VqW
 2QOEW2x5t7BuvU3oX6EOs0f++xF8S0/BtDzSGXrMNi5xQKnOR6mQVrtiTtrKsGPBvlVOxqZew
 XHitJ7G+1QtWOXxgkURun9rL+6BVtR84ilhBgmhg/13As5Oka/Y11NCk5RSLTqrNCesFbIn5D
 Ju2TSq0UrO3DiZI9eDkA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than relying on fs/compat_ioctl.c, this adds support
for a compat_ioctl() callback in the ide-floppy driver directly,
which lets it translate the scsi commands.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ide/ide-floppy.c       |  4 ++++
 drivers/ide/ide-floppy.h       |  2 ++
 drivers/ide/ide-floppy_ioctl.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/ide/ide-gd.c           | 14 +++++++++++++
 include/linux/ide.h            |  2 ++
 5 files changed, 58 insertions(+)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 1ea2f9e82bf8..1fe1f9d37a51 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
@@ -546,4 +547,7 @@ const struct ide_disk_ops ide_atapi_disk_ops = {
 	.set_doorlock	= ide_set_media_lock,
 	.do_request	= ide_floppy_do_request,
 	.ioctl		= ide_floppy_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ide_floppy_compat_ioctl,
+#endif
 };
diff --git a/drivers/ide/ide-floppy.h b/drivers/ide/ide-floppy.h
index 13c9b4b6d75e..8505a5f58f4e 100644
--- a/drivers/ide/ide-floppy.h
+++ b/drivers/ide/ide-floppy.h
@@ -26,6 +26,8 @@ void ide_floppy_create_read_capacity_cmd(struct ide_atapi_pc *);
 /* ide-floppy_ioctl.c */
 int ide_floppy_ioctl(ide_drive_t *, struct block_device *, fmode_t,
 		     unsigned int, unsigned long);
+int ide_floppy_compat_ioctl(ide_drive_t *, struct block_device *, fmode_t,
+			    unsigned int, unsigned long);
 
 #ifdef CONFIG_IDE_PROC_FS
 /* ide-floppy_proc.c */
diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 40a2ebe34e1d..4fd70f804d6f 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/ide.h>
+#include <linux/compat.h>
 #include <linux/cdrom.h>
 #include <linux/mutex.h>
 
@@ -302,3 +303,38 @@ int ide_floppy_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	mutex_unlock(&ide_floppy_ioctl_mutex);
 	return err;
 }
+
+#ifdef CONFIG_COMPAT
+int ide_floppy_compat_ioctl(ide_drive_t *drive, struct block_device *bdev,
+			    fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	struct ide_atapi_pc pc;
+	void __user *argp = compat_ptr(arg);
+	int err;
+
+	mutex_lock(&ide_floppy_ioctl_mutex);
+	if (cmd == CDROMEJECT || cmd == CDROM_LOCKDOOR) {
+		err = ide_floppy_lockdoor(drive, &pc, arg, cmd);
+		goto out;
+	}
+
+	err = ide_floppy_format_ioctl(drive, &pc, mode, cmd, argp);
+	if (err != -ENOTTY)
+		goto out;
+
+	/*
+	 * skip SCSI_IOCTL_SEND_COMMAND (deprecated)
+	 * and CDROM_SEND_PACKET (legacy) ioctls
+	 */
+	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
+		err = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
+
+	/*
+	 * there is no generic_ide_compat_ioctl(), that is handled
+	 * through compat_blkdev_ioctl().
+	 */
+out:
+	mutex_unlock(&ide_floppy_ioctl_mutex);
+	return err;
+}
+#endif
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index dba9ad5c97b3..1b0270efcce2 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -341,11 +341,25 @@ static int ide_gd_ioctl(struct block_device *bdev, fmode_t mode,
 	return drive->disk_ops->ioctl(drive, bdev, mode, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int ide_gd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg)
+{
+	struct ide_disk_obj *idkp = ide_drv_g(bdev->bd_disk, ide_disk_obj);
+	ide_drive_t *drive = idkp->drive;
+
+	return drive->disk_ops->compat_ioctl(drive, bdev, mode, cmd, arg);
+}
+#endif
+
 static const struct block_device_operations ide_gd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= ide_gd_unlocked_open,
 	.release		= ide_gd_release,
 	.ioctl			= ide_gd_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl			= ide_gd_compat_ioctl,
+#endif
 	.getgeo			= ide_gd_getgeo,
 	.check_events		= ide_gd_check_events,
 	.unlock_native_capacity	= ide_gd_unlock_native_capacity,
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 46b771d6999e..06dae6438557 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -413,6 +413,8 @@ struct ide_disk_ops {
 				      sector_t);
 	int		(*ioctl)(struct ide_drive_s *, struct block_device *,
 				 fmode_t, unsigned int, unsigned long);
+	int		(*compat_ioctl)(struct ide_drive_s *, struct block_device *,
+					fmode_t, unsigned int, unsigned long);
 };
 
 /* ATAPI device flags */
-- 
2.20.0

