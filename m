Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B13261E05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgIHTpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgIHPvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB37C0A3BF7;
        Tue,  8 Sep 2020 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fs8KDvUlBtih+JNIUNQobEQslvMWHTx5fiB3hsIGlEU=; b=fToRuRTLBzkwhKm/TBMIAObCfx
        47SjRyodcVFkso9Pdp1Z4yO8OZ3afLCOAU2HivmVTsp3tP1Bs88OMnOZB7haSutu6gHet6t4VM3wp
        yw1Wa+3VlMgjCzG1XqrEZAep3+D15GDpvLTW/mHCdv6Urlj/XZbc1Mi4vvIbLWP2FZPmjUyJsZ1Vv
        yi0qc4NmeefS23wziWDUVQUXwMIwfzTbyLWpaBN3N8hJtzG+iTWHHG4AwwJjrYLudG25EJeXDoso9
        RVK0YroYrfuP2PbYDLdLaevlsiDgFf5Jm5RM70YkGXbQXegJusJEa/ZMQ6NYGQUa1p9Yi1HBUDqt/
        tlSbZePw==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf1I-00030J-0O; Tue, 08 Sep 2020 14:54:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 18/19] sr: simplify sr_block_revalidate_disk
Date:   Tue,  8 Sep 2020 16:53:46 +0200
Message-Id: <20200908145347.2992670-19-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
References: <20200908145347.2992670-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both callers have a valid CD struture available, so rely on that instead
of getting another reference.  Also move the function to avoid a forward
declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/sr.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 34be94b62523fa..2b43c0f97442d4 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -86,7 +86,6 @@ static int sr_remove(struct device *);
 static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt);
 static int sr_done(struct scsi_cmnd *);
 static int sr_runtime_suspend(struct device *dev);
-static int sr_block_revalidate_disk(struct gendisk *disk);
 
 static const struct dev_pm_ops sr_pm_ops = {
 	.runtime_suspend	= sr_runtime_suspend,
@@ -518,6 +517,17 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	return ret;
 }
 
+static void sr_revalidate_disk(struct scsi_cd *cd)
+{
+	struct scsi_sense_hdr sshdr;
+
+	/* if the unit is not ready, nothing more to do */
+	if (scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES, &sshdr))
+		return;
+	sr_cd_check(&cd->cdi);
+	get_sectorsize(cd);
+}
+
 static int sr_block_open(struct block_device *bdev, fmode_t mode)
 {
 	struct scsi_cd *cd;
@@ -531,7 +541,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 	sdev = cd->device;
 	scsi_autopm_get_device(sdev);
 	if (bdev_check_media_change(bdev))
-		sr_block_revalidate_disk(bdev->bd_disk);
+		sr_revalidate_disk(cd);
 
 	mutex_lock(&cd->lock);
 	ret = cdrom_open(&cd->cdi, bdev, mode);
@@ -660,26 +670,6 @@ static unsigned int sr_block_check_events(struct gendisk *disk,
 	return ret;
 }
 
-static int sr_block_revalidate_disk(struct gendisk *disk)
-{
-	struct scsi_sense_hdr sshdr;
-	struct scsi_cd *cd;
-
-	cd = scsi_cd_get(disk);
-	if (!cd)
-		return -ENXIO;
-
-	/* if the unit is not ready, nothing more to do */
-	if (scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES, &sshdr))
-		goto out;
-
-	sr_cd_check(&cd->cdi);
-	get_sectorsize(cd);
-out:
-	scsi_cd_put(cd);
-	return 0;
-}
-
 static const struct block_device_operations sr_bdops =
 {
 	.owner		= THIS_MODULE,
@@ -803,7 +793,7 @@ static int sr_probe(struct device *dev)
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
-	sr_block_revalidate_disk(disk);
+	sr_revalidate_disk(cd);
 	device_add_disk(&sdev->sdev_gendev, disk, NULL);
 
 	sdev_printk(KERN_DEBUG, sdev,
-- 
2.28.0

