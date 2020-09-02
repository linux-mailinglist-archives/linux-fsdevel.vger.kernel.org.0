Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177A825AD74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIBOky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49867C061262;
        Wed,  2 Sep 2020 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d3yMvyuS7xd9ec7kMZpN6X+jq3UwGf8290/tkdHo/88=; b=jUrDObjHg3Xh4hJgPC6tH9JvZb
        mjqvT6E9yv1ird6NFiu9L/nZrCW0DXKazGnX9iwebPLKud/jN26UiuEU0/KXuCuAtZSAJmLW1uB7G
        Lsq/+VkYxqTHfyqm0heYYcnFIiLCW63cB6xuHUdrLKee8kIz5GoVV9yn5vOWIIOTgvtVJcLJvLiBT
        UBZrLyRZx01Vv7bIGEq/NaRKO0jdFH+l4R6Tg0Bep/GzAxPba5mU6ofDKUFJUN5agi9JFipF6HNU3
        uMZ2IDKwuWzDEDJmn/xr9hEmVhjv+FSEMeZJ0fdNtpdI3BXJaTuBfnPG7cfX7zByPjhDgm0gv/cPP
        NawrN/YA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUw-0005dF-VH; Wed, 02 Sep 2020 14:12:27 +0000
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
Subject: [PATCH 05/19] swim: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:04 +0200
Message-Id: <20200902141218.212614-6-hch@lst.de>
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

Switch to use bdev_check_media_change instead of check_disk_change and
call floppy_revalidate manually.  Given that floppy_revalidate only
deals with media change events, the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index dd34504382e533..d4565c555b289f 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -217,6 +217,8 @@ extern int swim_read_sector_header(struct swim __iomem *base,
 extern int swim_read_sector_data(struct swim __iomem *base,
 				 unsigned char *data);
 
+static int floppy_revalidate(struct gendisk *disk);
+
 static DEFINE_MUTEX(swim_mutex);
 static inline void set_swim_mode(struct swim __iomem *base, int enable)
 {
@@ -638,7 +640,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return 0;
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		check_disk_change(bdev);
+		if (bdev_check_media_change(bdev))
+			floppy_revalidate(bdev->bd_disk);
 		if ((mode & FMODE_WRITE) && fs->write_protected) {
 			err = -EROFS;
 			goto out;
@@ -760,7 +763,6 @@ static const struct block_device_operations floppy_fops = {
 	.ioctl		 = floppy_ioctl,
 	.getgeo		 = floppy_getgeo,
 	.check_events	 = floppy_check_events,
-	.revalidate_disk = floppy_revalidate,
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-- 
2.28.0

