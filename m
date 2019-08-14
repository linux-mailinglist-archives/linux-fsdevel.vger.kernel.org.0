Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA98DF8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHNU6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:58:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfHNU6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:58:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mfpf7-1iVP9a30qP-00gHok; Wed, 14 Aug 2019 22:57:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 18/18] scsi: sd: enable compat ioctls for sed-opal
Date:   Wed, 14 Aug 2019 22:54:53 +0200
Message-Id: <20190814205521.122180-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GHU2BOUolFMuYU4JHf6S7Epw6n2I5F+s2JL2xcZ0QVFOtlz3LTM
 Cg1Y0P2DCMYs/77HHCx1SBY6ljRsMtpIZLwfU9oRltiVTFqbskRhozs7BR1P4kelS1oZQdf
 NO3WcQWcvIZWwBG0eNOOKMNkbslk2VdBMFzYBppBkPwj0oVa+cGYH4/9qltFy28mV3yE9NN
 os1WcG3Ajoz39bCTJnZgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zpxeGQV2Lis=:DxZ29hcJwmhH8cHBeJLpFh
 cbl964bB0IHU8mgW586im24i2LN4vSL9QCCunqRoHxS7JbPtdo5H45SQ6PWsw9mw/Ulb/ScC1
 0wRZL4DfLEEd0+uxjvjXcsGHZWHGCFNQLqo4Q25G0MVi5VwZyzkAsDZ51/SJZ5+QyVes+Qt9I
 jpKCw8zab86I+Rl7XhCLexRa9CBJThsIiej6aL+7uuwzbweouesQv0N8hCkZYPSHT+ujCSWh0
 kLdAOCE6Biopn5K/CGKUYmuSjZ9apaCSOVDn5i0Q6JdR0putP+DLV+uMO99uB7qL1273rW5AM
 aiOAT7BbnDBhLmofbzGwXZvCbgrWP9CBdLFxRXsB0Gh9sC8duzp3M3okSQ8EhDEBLKt7Xr82Y
 69IHO+8bAGW0Avqxepran8c+dzq2jov2jsQrrxJqinBc6KXjj1lwSbbsVisl1WnukDYcN6k2l
 bXhBO2kcCQjrrjs8o/B2IdMo5vHHxsu883UHlrOuPk0+Pmdf4TrAwNirMNkik7rmJCC1VWD0M
 YZ4JfrKoykoTAIz6RHX4zUk0RvgX/5+6B3ms7hZ5+mWytecx9vFhvM6dbSTVopHsuOfKorbtd
 C/xUO8wK1iajpYzXGo+S0nhiHKBNVa/kboscA0C7kx3Ybwba60OSBHWJ1wHuQrvP5fihDvrMU
 3yg76Yq3EpfucvHZpAOym5tAjj1kALpm3aXVMSJBtBSlqHml5cwYgTvD1OW8YuOeCwuxBz2fH
 2hKYaB8bwrOK32MdonrxWgBxhRv5SfKCbUepsQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sed_ioctl() function is written to be compatible between
32-bit and 64-bit processes, however compat mode is only
wired up for nvme, not for sd.

Add the missing call to sed_ioctl() in sd_compat_ioctl().

Fixes: d80210f25ff0 ("sd: add support for TCG OPAL self encrypting disks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 149d406aacc9..8b71664c54bd 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1693,20 +1693,30 @@ static void sd_rescan(struct device *dev)
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

