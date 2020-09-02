Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECC25ADBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgIBOrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgIBOMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F1C061247;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bJa71sDGZRTcC2iIw3V/lx4zrrvbhIXSbhIKo+Q3k5g=; b=YGK8fJVS2GhiC/1NvOWxDvyR76
        lncnW8u9y5IvWyMGnSvbzmCBmG7CeKllGy/JYfR3xfhKqx/+Xb/Lc+pSCTGW8TlF8oRUvRzxRsOhc
        awsTrnlvbnjczzPUBzFa3QXwj35mhof/K6MHnFNHofvGWJP2684IwP0x0QbFTndL87AdMRy8384mS
        qJDm0Oxy2lyCIjZvbaT0OYEDgITukkRgmOYBQ7+bLoKBDbipGRKtjIeCFL9/e4nsRMA4hA+zKzqaS
        ZgDNJbC+Ii0/vQJkZ8bpIftCw5rI23+PmfgYQoJ115/ANznPrxEXbVZDp61Kq7NaQYsf+QZspJD1+
        LXMNpjSg==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTV5-0005ew-Qp; Wed, 02 Sep 2020 14:12:36 +0000
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
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/19] ide-cd: use bdev_check_media_changed
Date:   Wed,  2 Sep 2020 16:12:11 +0200
Message-Id: <20200902141218.212614-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902141218.212614-1-hch@lst.de>
References: <20200902141218.212614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch to use bdev_check_media_changed instead of check_disk_change and
call idecd_revalidate_disk manually.  Given that idecd_revalidate_disk
only re-reads the TOC, and we already do the same at probe time, the
extra call into ->revalidate_disk from bdev_disk_changed is not required
either, so stop wiring up the method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-cd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 212bb2d8bf346a..6a38cbc80aea0d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -56,6 +56,7 @@ static DEFINE_MUTEX(ide_cd_mutex);
 static DEFINE_MUTEX(idecd_ref_mutex);
 
 static void ide_cd_release(struct device *);
+static int idecd_revalidate_disk(struct gendisk *disk);
 
 static struct cdrom_info *ide_cd_get(struct gendisk *disk)
 {
@@ -1611,7 +1612,8 @@ static int idecd_open(struct block_device *bdev, fmode_t mode)
 	struct cdrom_info *info;
 	int rc = -ENXIO;
 
-	check_disk_change(bdev);
+	if (bdev_check_media_change(bdev))
+		idecd_revalidate_disk(bdev->bd_disk);
 
 	mutex_lock(&ide_cd_mutex);
 	info = ide_cd_get(bdev->bd_disk);
@@ -1770,7 +1772,6 @@ static const struct block_device_operations idecd_ops = {
 	.compat_ioctl		= IS_ENABLED(CONFIG_COMPAT) ?
 				  idecd_compat_ioctl : NULL,
 	.check_events		= idecd_check_events,
-	.revalidate_disk	= idecd_revalidate_disk
 };
 
 /* module options */
-- 
2.28.0

