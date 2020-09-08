Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E7D261E2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgIHTpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbgIHPuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6FCC0A3BF0;
        Tue,  8 Sep 2020 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e8UHu128BOucpF3Nt3G76NBwCQdX+XymqNnsSMwHxZQ=; b=ULEEX4pqiG0rpUIcfCQiiH99la
        0zqHLiRmorEWRz3YaTpL5W/sFi0/Zv9L1qH5VnRIzVggbwz+MIu2EJywgEE4vOmpkf3VgvA9A6uTF
        BGbhuaQVQ45BvFItW8hPcDX9RBUx2lonpU781IaOo/EeON4VIX1JEIi2CA7BKPMisiR/HD7j87J5e
        X2vB8KoUkr8T43SpK5vCMoBk4fXayWzO/7Et49o9ZYAR92y0YOVyXkkhUTa3u8NXgUosSEgmfOb6y
        IS72enXK/zrLXMeQw/9wEM8iCmsLQGXMzx4fRNbc9V2lfNmtq6ApMFTs6cT1b4ocoyQ2/kfkO7EPt
        67W1vvkw==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf14-0002yj-Ly; Tue, 08 Sep 2020 14:54:38 +0000
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
Subject: [PATCH 12/19] ide-cd: use bdev_check_media_changed
Date:   Tue,  8 Sep 2020 16:53:40 +0200
Message-Id: <20200908145347.2992670-13-hch@lst.de>
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

Switch to use bdev_check_media_changed instead of check_disk_change and
call idecd_revalidate_disk manually.  Given that idecd_revalidate_disk
only re-reads the TOC, and we already do the same at probe time, the
extra call into ->revalidate_disk from bdev_disk_changed is not required
either, so stop wiring up the method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

