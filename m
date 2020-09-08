Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54E6261DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgIHToV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbgIHPvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968FC0A3BE6;
        Tue,  8 Sep 2020 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CokwUhLtLY+HJBUS4+kWwYLSBZUJwKz5SbJHqq17dNs=; b=e8WxUJ04cgOn5PPMEkZOv1VJAx
        xPxEtTVTtYeROSAdSqWsWh2V/9iTgmtfw0EV9V4V+gHWIbd4Y36s4uqASOey8kQ1lDmrihyyHrA/o
        N2i/G/DSmmZb/GOC6nyU1q90mg/zIRgocv2+SIZWG85W8CCc2HtKxebIpn9AkFIF8/BB6yiv0sJMb
        ThBFmrg7Z7gjKogjX4Mw426+cNBvX8T0DaUVGod+G7YPLHm8rWFTaV6hjvwnKWp70gJUbf5a42J93
        b6al7WYDCfltB0lHajfE3Pv3W74poknrXE23A30KOkElM4jEDJXLp0YhBOhVIBjsRB7VPrHvzHVw7
        7kn1Gz2g==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0b-0002wi-Qz; Tue, 08 Sep 2020 14:54:15 +0000
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
Subject: [PATCH 04/19] floppy: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:32 +0200
Message-Id: <20200908145347.2992670-5-hch@lst.de>
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
call floppy_revalidate manually.  Given that floppy_revalidate only
deals with media change events, the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/floppy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a563b023458a8b..7df79ae6b0a1e1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -561,6 +561,7 @@ static void floppy_release_irq_and_dma(void);
  * output_byte is automatically disabled when reset is set.
  */
 static void reset_fdc(void);
+static int floppy_revalidate(struct gendisk *disk);
 
 /*
  * These are global variables, as that's the easiest way to give
@@ -3275,7 +3276,8 @@ static int invalidate_drive(struct block_device *bdev)
 	/* invalidate the buffer track to force a reread */
 	set_bit((long)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
-	check_disk_change(bdev);
+	if (bdev_check_media_change(bdev))
+		floppy_revalidate(bdev->bd_disk);
 	return 0;
 }
 
@@ -4123,7 +4125,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 			drive_state[drive].last_checked = 0;
 			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
 				  &drive_state[drive].flags);
-			check_disk_change(bdev);
+			if (bdev_check_media_change(bdev))
+				floppy_revalidate(bdev->bd_disk);
 			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
 				goto out;
 			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
@@ -4291,7 +4294,6 @@ static const struct block_device_operations floppy_fops = {
 	.ioctl			= fd_ioctl,
 	.getgeo			= fd_getgeo,
 	.check_events		= floppy_check_events,
-	.revalidate_disk	= floppy_revalidate,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= fd_compat_ioctl,
 #endif
-- 
2.28.0

