Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1E261E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgIHTp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgIHPux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B47C0A3BF3;
        Tue,  8 Sep 2020 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2GZkfuA3+QyfRSiQ2N97BGanWRbnzEKE1BjaKC2IVN0=; b=O86Gx79j7ucuqz3TrvYr5EhBje
        C/oXMrJ4WKO+yXmV5+sEymlVehTXk5/DJHhU56HU8sZwFYJkVImwpqAIkpHP+4EWRYPElWZiHYOM6
        JTZMo9BmExshb9Jf6gNZS9KtEWre2XgSZfWpPVMZiBKs6/L5nAKx7wUjaCgd0ReBO4AGXHH3GPk+g
        Yz+CuWAi3DCOsLerWzlAbZQl8BRFgPaDjM/RU99uFzag9/3bWPk0BA7PL1ADUFQSlb4n4zKqFMNm8
        9AkDGdP+jy2+m0yoDmziq8oEchHj71jWkTkYxD1oRD5cXAhb772Yh2Q2AyPOONiMgMtwmoVZ165dU
        ycWvFAhw==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf17-0002yr-30; Tue, 08 Sep 2020 14:54:42 +0000
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
Subject: [PATCH 13/19] ide-cd: remove idecd_revalidate_disk
Date:   Tue,  8 Sep 2020 16:53:41 +0200
Message-Id: <20200908145347.2992670-14-hch@lst.de>
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

Just merge the trivial function into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

