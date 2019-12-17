Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7112396B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLQWRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:53 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLQWRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N63JO-1hbEp725Si-016S2I; Tue, 17 Dec 2019 23:17:29 +0100
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
Subject: [PATCH v2 14/27] compat_ioctl: block: handle cdrom compat ioctl in non-cdrom drivers
Date:   Tue, 17 Dec 2019 23:16:55 +0100
Message-Id: <20191217221708.3730997-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fgECgP85UcsuJjsyAuZL7QHYXHYBEzujC6oqv+TYTA3UFXDQ0+O
 zy7BYkmbtD/vp8Tk1y4FGXR086ig4FhOi/Rl5dEFBP99TTQ2jhWlrdT8lSSnQknngX1KAB6
 I+ogzZX67PGokZ5zfes54eIzqMGogav4wpegt34I+hdR5RPVE6BuP6DYZmUdBpq20dc60rb
 ROIQeamCDbWQqLST38hUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GRelAd88hdg=:yDxJVmxWHvbBFPkEJEmEgE
 UEJvUfrBcsIZdJ7qfTVCrg1uiVg3njJLZUgTJpKad1/0+ryRGw9lVt3Avgsqio22idIXMjSYk
 6zrTwH4axXV4Cl4ve64rU2hWTWiT/olx8jg/SSUSaetzy5RDNf/kR3vv022nW2OozkTrsv2Yv
 /G/tPFFJ/YBFl9BrRb2jp6K9D5f4ATmf4sld1YkHKSUtY7tHEgC8mVhtoCF92EsLDURoV9VJt
 rOPjvPYp8I/ZUFiMUOMMlGNUHa6F8+6UvVkrSO1TmPLafk/QSAS4uGvK2jtG4/xE3SPeFk35b
 FnNQX3FjImzSW8jI1uRA1naRTwsNWeQZWOqgRYbqlziCqvUX/O2q4xWgWF/hso+qX6SFlpKTE
 gKrZcHUKfFqK//ND+xPaACsxvQ+CNeJ3eLsDDN9dtEZiwd2nVTJ7q695ln4CGsdnBo5b+2fWO
 qDoIgtssB7L/qaqDin3lV+OxwZKxJCo2TwB8Y8JllsSvRYDjFFCJ1PJbY6hN4DeFWZdoGXHXC
 dpbdNgG70Q12STFtj0ptYcToUP5JrcHW4zGjaNIEUb9flTkhKGrWUEyYVRgDMFRiJ78qeeGG7
 U6OJUSgaYGm37yvkzz1stO8fLt5rQwHkF6HtPm9npdUb53zFh6omU7pXKYtof7ZZi8bTLU06Z
 EhsMwxi3rstYhU6Jfqyz+YGUlUQIC7EA4tUEB0JowiIEFBwKZH9DDJwFAVchSJ3iJ6bfjciKR
 8xWRaCtwhXmQAAbQZiw/69ztEa+l7vwzQQxnVaXo73+DcvjaO2Vr+EYUvfvkw1aQRAZ6QF5bW
 Tah+sUwg3WYC/0ow8O3EuxAAp19fzZTzbD3gcbp3e2aKDjGK+jphXGvhxn0A7CwGsUys4OFtb
 zAVZkqDVqwzXkJ9H41qQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Various block drivers implement the CDROMMULTISESSION,
CDROM_GET_CAPABILITY, and CDROMEJECT ioctl commands, relying on the
block layer to handle compat_ioctl mode for them.

Move this into the drivers directly as a preparation for simplifying
the block layer later.

When only integer arguments or no arguments are passed, the
same handler can be used for .ioctl and .compat_ioctl, and
when only pointer arguments are passed, the newly added
blkdev_compat_ptr_ioctl can be used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/floppy.c       | 3 +++
 drivers/block/paride/pd.c    | 1 +
 drivers/block/paride/pf.c    | 1 +
 drivers/block/sunvdc.c       | 1 +
 drivers/block/xen-blkfront.c | 1 +
 5 files changed, 7 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 485865fd0412..cd3612e4e2e1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3879,6 +3879,9 @@ static int fd_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 {
 	int drive = (long)bdev->bd_disk->private_data;
 	switch (cmd) {
+	case CDROMEJECT: /* CD-ROM eject */
+	case 0x6470:	 /* SunOS floppy eject */
+
 	case FDMSGON:
 	case FDMSGOFF:
 	case FDSETEMSGTRESH:
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 6f9ad3fc716f..c0967507d085 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -874,6 +874,7 @@ static const struct block_device_operations pd_fops = {
 	.open		= pd_open,
 	.release	= pd_release,
 	.ioctl		= pd_ioctl,
+	.compat_ioctl	= pd_ioctl,
 	.getgeo		= pd_getgeo,
 	.check_events	= pd_check_events,
 	.revalidate_disk= pd_revalidate
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 6b7d4cab3687..bb09f21ce21a 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -276,6 +276,7 @@ static const struct block_device_operations pf_fops = {
 	.open		= pf_open,
 	.release	= pf_release,
 	.ioctl		= pf_ioctl,
+	.compat_ioctl	= pf_ioctl,
 	.getgeo		= pf_getgeo,
 	.check_events	= pf_check_events,
 };
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 571612e233fe..39aeebc6837d 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -171,6 +171,7 @@ static const struct block_device_operations vdc_fops = {
 	.owner		= THIS_MODULE,
 	.getgeo		= vdc_getgeo,
 	.ioctl		= vdc_ioctl,
+	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 };
 
 static void vdc_blk_queue_start(struct vdc_port *port)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a74d03913822..23c86350a5ab 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2632,6 +2632,7 @@ static const struct block_device_operations xlvbd_block_fops =
 	.release = blkif_release,
 	.getgeo = blkif_getgeo,
 	.ioctl = blkif_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 };
 
 
-- 
2.20.0

