Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0761E25AD68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIBONl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgIBONL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396EC06125C;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EqP9HPoUpfEHaFZHJN9/qOYklR5YKLZjZD+GBezP77s=; b=WwKvie5UOByQM0J/L7OERFefDG
        ekdcHLA92IY05Goz+JUSOuazP3GEGKKjiLVA1rLvqyDC5QPu1wQlZuYlb67SbGXgpQUWb0Z085ajZ
        bzKBmGu7jmWA7jca34IRO+FzQGfZXCvxyTQLUgkJrzFOWFHRqdpbXFTey/eVRMg47kL6JCidKpDX7
        0XIROz3WU/OiGmOoFvLLNfbDFBvsO5PcclVc8CarMFrymMsiwtWuH1CD3efqsXF1SBRJ8k2Nnub7I
        FdkSZB5lwhZ9HKyDbJ2fEA1f4fwIkuFNnTxjhPcxx3OlbDrtrVbW53tyC6dCWUAoFHlrhRuiPpqve
        2sW3A4EA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTV7-0005f9-Hr; Wed, 02 Sep 2020 14:12:38 +0000
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
Subject: [PATCH 13/19] ide-cd: remove idecd_revalidate_disk
Date:   Wed,  2 Sep 2020 16:12:12 +0200
Message-Id: <20200902141218.212614-14-hch@lst.de>
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

Just merge the trivial function into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-cd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 6a38cbc80aea0d..25d2d88e82ada0 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -56,7 +56,6 @@ static DEFINE_MUTEX(ide_cd_mutex);
 static DEFINE_MUTEX(idecd_ref_mutex);
 
 static void ide_cd_release(struct device *);
-static int idecd_revalidate_disk(struct gendisk *disk);
 
 static struct cdrom_info *ide_cd_get(struct gendisk *disk)
 {
@@ -1612,8 +1611,11 @@ static int idecd_open(struct block_device *bdev, fmode_t mode)
 	struct cdrom_info *info;
 	int rc = -ENXIO;
 
-	if (bdev_check_media_change(bdev))
-		idecd_revalidate_disk(bdev->bd_disk);
+	if (bdev_check_media_change(bdev)) {
+		info = ide_drv_g(bdev->bd_disk, cdrom_info);
+
+		ide_cd_read_toc(info->drive);
+	}
 
 	mutex_lock(&ide_cd_mutex);
 	info = ide_cd_get(bdev->bd_disk);
@@ -1755,15 +1757,6 @@ static unsigned int idecd_check_events(struct gendisk *disk,
 	return cdrom_check_events(&info->devinfo, clearing);
 }
 
-static int idecd_revalidate_disk(struct gendisk *disk)
-{
-	struct cdrom_info *info = ide_drv_g(disk, cdrom_info);
-
-	ide_cd_read_toc(info->drive);
-
-	return  0;
-}
-
 static const struct block_device_operations idecd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= idecd_open,
-- 
2.28.0

