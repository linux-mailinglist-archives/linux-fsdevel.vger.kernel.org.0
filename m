Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E332D1849
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfJITMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:12:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbfJITLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MofLl-1hleRX2T5V-00p7Pi; Wed, 09 Oct 2019 21:11:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v6 43/43] scsi: sd: enable compat ioctls for sed-opal
Date:   Wed,  9 Oct 2019 21:10:44 +0200
Message-Id: <20191009191044.308087-44-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zX1dBOxTNEIjEWC6S6Aboc9GLFenI7/73H9gQTcEXZJuXQOOPKQ
 m3Fd1C/SOXXiF/vgpisdbgSmCcJpi/8S/vO/qXr1qfrJIStRYB3s3dEawxyMSUMn+0NTfXy
 Ab9xMpMNOALYbbrUsRd2FLw0Ye7wS9Iq5k27P/7uitVAlIrvvypAqXWfA5vkc0tbPYZF+1m
 NIF5nP/JU3XKb21XnisJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lFQ+r8yms6g=:sbWCiEgDC0Wd/x2FxEm0lO
 HIOHewpro6Y6RhDe6KbndIDg0JNlUin7WJAs+q2iO5twgzE03hJmvtw+q/+cNaD+grzoD4Oda
 gFzYZwLfS9Ef35ZuoxQBOuKAIMQZ7UrTAbC7A4HGnHBdrCJeuL+FAvMkx8d9Q3v8oDLoRK99G
 guyQ9i6W0+p2M2w3TlNGT+w7ZOCMJIl9i//enaD+YsHcY26KZ2FFZUau1fGlpuhXhAcqODDXX
 SIcsD74vNvgKtyEPxV9tc3Q2lfXhV6s74yPR+l6P2GlsQnPmu3EOvVNP8zyq8PBq4AP4/0PxD
 8mt6NCkQTa6kLkw69qrXpOki8HjCDcvQ2jcGjludeml2Gae0+PG+4flcA4nJzyRMb5pG2bXde
 Gss218kuyh26mcuzvCMUzxMxLCoTBtDQiVx8PY3oe69kv15zMI+htD6Ocko1S9T0fX+4tn3KN
 g/dqGY4gdlj/BH/PsPlw7NfC3JvJtW5J8KgG0SAfphyamwOela5x8WVCzovCgjr4yuqFbGZXi
 /0zOytzYJdzQerNej9emCJzBg4g//n0fKkVR99ce+YbHmaRFLD0+QnF41NuB2SNqlkNEVDWLQ
 JkJ/iUs6UBYMGqIj35uk/P8skn4f3tiRIkaDlpRk4Rb8G8J9bl8MaT4JrR+dlNzyR1EswTS2M
 NFx1iku9lwAxHQrhCwDBbP+1xC3i60il2GQ0PiXA9ETGMcBWbWH3QQYqw3bkOQebzBgN1ezzI
 ucj68bPQaHNnBwPCpejCq7sFoYI8x1G2hI0OzAx8IWJrONDM4BrJghfQQvnMXkjO57YmRW3KR
 ppoc3ztmdrjMOaKOPqMKgvjeTkKkkZM5MPa/hI7eeaQeYRXyvd6rEK8MQdP/6fH4SgeGNu6Ru
 eU2kfW0Ze1W96JFfciaA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sed_ioctl() function is written to be compatible between
32-bit and 64-bit processes, however compat mode is only
wired up for nvme, not for sd.

Add the missing call to sed_ioctl() in sd_compat_ioctl().

Fixes: d80210f25ff0 ("sd: add support for TCG OPAL self encrypting disks")
Cc: linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 50928bc266eb..5abdf03083ae 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1692,20 +1692,30 @@ static void sd_rescan(struct device *dev)
 static int sd_compat_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
-	struct scsi_device *sdev = scsi_disk(bdev->bd_disk)->device;
+	struct gendisk *disk = bdev->bd_disk;
+	struct scsi_disk *sdkp = scsi_disk(disk);
+	struct scsi_device *sdev = sdkp->device;
+	void __user *p = compat_ptr(arg);
 	int error;
 
+	error = scsi_verify_blk_ioctl(bdev, cmd);
+	if (error < 0)
+		return error;
+
 	error = scsi_ioctl_block_when_processing_errors(sdev, cmd,
 			(mode & FMODE_NDELAY) != 0);
 	if (error)
 		return error;
+
+	if (is_sed_ioctl(cmd))
+		return sed_ioctl(sdkp->opal_dev, cmd, p);
 	       
 	/* 
 	 * Let the static ioctl translation table take care of it.
 	 */
 	if (!sdev->host->hostt->compat_ioctl)
 		return -ENOIOCTLCMD; 
-	return sdev->host->hostt->compat_ioctl(sdev, cmd, (void __user *)arg);
+	return sdev->host->hostt->compat_ioctl(sdev, cmd, p);
 }
 #endif
 
-- 
2.20.0

