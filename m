Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE85261FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgIHUFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbgIHPV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17286C0A3BF6;
        Tue,  8 Sep 2020 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ijISDI3+FEAsJRrVv6gnkByyFtP6B2mrzNMrQzqv2GQ=; b=J+m1dnyxZ/PYz+dryLUb8kif20
        f3x71W6Ej8XzEJbIhNcB1LU+pAraLcrDpiJOM3NnpmYpYXwpbb4jZrKnjGUqtCDjw0l/Gckp5OpHr
        Uk5Rp2b6SktC1LZfPQicf8DGNlPllrYbKDLXTyGrG29Q2mDpWHLSd3omK0MmWaZR+lBsOaWw+0SVz
        NPcujQr7rhEe+AaInu3x3iq2l3FxacJkiRd7o0r79Fqsdj4RnuRMukoTInM8ugORJ6teWIt+mwTXr
        4xwoLOR3XK5qR6atnqMJJlNmizV9bCrJJSgSjhYsxYWzQLDBwuijgB1bNklCB3ytmV7LkYy0UbDNh
        BTy8u2Rg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf1E-0002zv-1m; Tue, 08 Sep 2020 14:54:50 +0000
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
Subject: [PATCH 17/19] sr: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:45 +0200
Message-Id: <20200908145347.2992670-18-hch@lst.de>
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

Switch to use bdev_check_media_change instead of check_disk_change and
call sr_block_revalidate_disk manually.  Also add an explicit call to
sr_block_revalidate_disk just before disk_add() to ensure we always
read check for a ready unit and read the TOC and then stop wiring up
->revalidate_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/sr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 3b3a53c6a0de53..34be94b62523fa 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -86,6 +86,7 @@ static int sr_remove(struct device *);
 static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt);
 static int sr_done(struct scsi_cmnd *);
 static int sr_runtime_suspend(struct device *dev);
+static int sr_block_revalidate_disk(struct gendisk *disk);
 
 static const struct dev_pm_ops sr_pm_ops = {
 	.runtime_suspend	= sr_runtime_suspend,
@@ -529,7 +530,8 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 
 	sdev = cd->device;
 	scsi_autopm_get_device(sdev);
-	check_disk_change(bdev);
+	if (bdev_check_media_change(bdev))
+		sr_block_revalidate_disk(bdev->bd_disk);
 
 	mutex_lock(&cd->lock);
 	ret = cdrom_open(&cd->cdi, bdev, mode);
@@ -688,7 +690,6 @@ static const struct block_device_operations sr_bdops =
 	.compat_ioctl	= sr_block_compat_ioctl,
 #endif
 	.check_events	= sr_block_check_events,
-	.revalidate_disk = sr_block_revalidate_disk,
 };
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
@@ -802,6 +803,7 @@ static int sr_probe(struct device *dev)
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
+	sr_block_revalidate_disk(disk);
 	device_add_disk(&sdev->sdev_gendev, disk, NULL);
 
 	sdev_printk(KERN_DEBUG, sdev,
-- 
2.28.0

