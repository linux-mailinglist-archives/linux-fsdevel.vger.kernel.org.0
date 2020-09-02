Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAB25ADA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIBOqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgIBONL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F134C06124F;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G29JkSXO5mbjv1FoDpuAl//FXROAUm+3biOsauwhg0s=; b=YbggAEx9ze8hczGoKQ8PaAFw67
        PsEkFNv31FZcKERky+O++zQ9kvVdW7HBx4lvmngVLfdXX8SbwEPkzZvdCK5vFc4az+Sk27+TGhgN9
        7QFg/4pEu0RYytEvQPP+uO21Tca9pR4QqutZ+Z7gOGBhGqNbhk/Hvowhiix75ZDYUMZnQ7niEHxEY
        VYjoCyUJ0L/cTR4nH2S2b+skjfHtbx4qpYKK8G4srMxCKSunIMBAaDDQyaYI1RSy4GdQ5SGPgn6TM
        N7/ixE54Q5ehR/xHZ6a4HfuN6Iu92GWKCuyjF3PguqjYRY61I3HAnYSU4VLCRnkRoEuqhabztoVxg
        5i4HKTaw==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTV1-0005ds-SV; Wed, 02 Sep 2020 14:12:32 +0000
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
Subject: [PATCH 09/19] xsysace: simplify media change handling
Date:   Wed,  2 Sep 2020 16:12:08 +0200
Message-Id: <20200902141218.212614-10-hch@lst.de>
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

Pass a struct ace_device to ace_revalidate_disk, move the media changed
check into the one caller that needs it, and give the routine a better
name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xsysace.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index eefe542f2d9fff..8d581c7536fb51 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -888,26 +888,20 @@ static unsigned int ace_check_events(struct gendisk *gd, unsigned int clearing)
 	return ace->media_change ? DISK_EVENT_MEDIA_CHANGE : 0;
 }
 
-static int ace_revalidate_disk(struct gendisk *gd)
+static void ace_media_changed(struct ace_device *ace)
 {
-	struct ace_device *ace = gd->private_data;
 	unsigned long flags;
 
-	dev_dbg(ace->dev, "ace_revalidate_disk()\n");
-
-	if (ace->media_change) {
-		dev_dbg(ace->dev, "requesting cf id and scheduling tasklet\n");
+	dev_dbg(ace->dev, "requesting cf id and scheduling tasklet\n");
 
-		spin_lock_irqsave(&ace->lock, flags);
-		ace->id_req_count++;
-		spin_unlock_irqrestore(&ace->lock, flags);
+	spin_lock_irqsave(&ace->lock, flags);
+	ace->id_req_count++;
+	spin_unlock_irqrestore(&ace->lock, flags);
 
-		tasklet_schedule(&ace->fsm_tasklet);
-		wait_for_completion(&ace->id_completion);
-	}
+	tasklet_schedule(&ace->fsm_tasklet);
+	wait_for_completion(&ace->id_completion);
 
 	dev_dbg(ace->dev, "revalidate complete\n");
-	return ace->id_result;
 }
 
 static int ace_open(struct block_device *bdev, fmode_t mode)
@@ -922,8 +916,8 @@ static int ace_open(struct block_device *bdev, fmode_t mode)
 	ace->users++;
 	spin_unlock_irqrestore(&ace->lock, flags);
 
-	if (bdev_check_media_change(bdev))
-		ace_revalidate_disk(bdev->bd_disk);
+	if (bdev_check_media_change(bdev) && ace->media_change)
+		ace_media_changed(ace);
 	mutex_unlock(&xsysace_mutex);
 
 	return 0;
@@ -1080,7 +1074,7 @@ static int ace_setup(struct ace_device *ace)
 		(unsigned long long) ace->physaddr, ace->baseaddr, ace->irq);
 
 	ace->media_change = 1;
-	ace_revalidate_disk(ace->gd);
+	ace_media_changed(ace);
 
 	/* Make the sysace device 'live' */
 	add_disk(ace->gd);
-- 
2.28.0

