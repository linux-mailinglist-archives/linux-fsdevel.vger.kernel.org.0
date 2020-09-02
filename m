Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18625ADC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgIBOrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgIBOMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76268C061249;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IOBdZmqfub+9TrAGeUEaXu5Vz5gp+vrz6f+ooFKXHwY=; b=ZuN/Dmn2J8IDS9piakhRmsdkpI
        7vWOwaizTLkjNJZxYBailM2+9Gl+YeAVFkiiwel78wa+j0YAag1iY7m8xJoMJzrMEi9g5hRbd/mX4
        96CJBtGZJ690xEt7ffFH5Bq3HC9aTfTPlVKUzp5n4Pyuu51JrEvzAxLAhvbwg1D6SASNJKuwilp4f
        5cPWKtsThdhLGWnV4ifqgx6HPdP8bp1+SIo/LtGnRAVWFIZgBr44DEPpeweTkKFy+8o8V3slYgBtu
        J9XmHaFEinAi5UwsSHm7hKaBR1cAkO67N5oCJLbNexpnDyC9UkVHw9cXaHLhCzF5YWsQHRqLyAAov
        9uuRmeHQ==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUy-0005dM-96; Wed, 02 Sep 2020 14:12:28 +0000
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
Subject: [PATCH 06/19] swim: simplify media change handling
Date:   Wed,  2 Sep 2020 16:12:05 +0200
Message-Id: <20200902141218.212614-7-hch@lst.de>
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

floppy_revalidate mostly duplicates work already done in floppy_open
despite only beeing called from floppy_open.  Remove the function and
just clear the ->ejected flag directly under the right condition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index d4565c555b289f..52dd1efa00f9c5 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -217,8 +217,6 @@ extern int swim_read_sector_header(struct swim __iomem *base,
 extern int swim_read_sector_data(struct swim __iomem *base,
 				 unsigned char *data);
 
-static int floppy_revalidate(struct gendisk *disk);
-
 static DEFINE_MUTEX(swim_mutex);
 static inline void set_swim_mode(struct swim __iomem *base, int enable)
 {
@@ -640,8 +638,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return 0;
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		if (bdev_check_media_change(bdev))
-			floppy_revalidate(bdev->bd_disk);
+		if (bdev_check_media_change(bdev) && fs->disk_in)
+			fs->ejected = 0;
 		if ((mode & FMODE_WRITE) && fs->write_protected) {
 			err = -EROFS;
 			goto out;
@@ -738,24 +736,6 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 	return fs->ejected ? DISK_EVENT_MEDIA_CHANGE : 0;
 }
 
-static int floppy_revalidate(struct gendisk *disk)
-{
-	struct floppy_state *fs = disk->private_data;
-	struct swim __iomem *base = fs->swd->base;
-
-	swim_drive(base, fs->location);
-
-	if (fs->ejected)
-		setup_medium(fs);
-
-	if (!fs->disk_in)
-		swim_motor(base, OFF);
-	else
-		fs->ejected = 0;
-
-	return !fs->disk_in;
-}
-
 static const struct block_device_operations floppy_fops = {
 	.owner		 = THIS_MODULE,
 	.open		 = floppy_unlocked_open,
-- 
2.28.0

