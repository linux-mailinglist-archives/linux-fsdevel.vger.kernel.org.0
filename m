Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43E25ADA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgIBOqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgIBONL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7343C061251;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/5SAWZk6icJ/MBm6T7B/yGzjpfvARn7uvD55NqOY+BE=; b=EWDvdMIvlQWYwV73Cx9dI0xu7i
        sWu2vGTiz7z10ZM+OfMHq7tF7ljG9yCO3BgQgp251yW7D6Jo7iM/6uv4WyMQGc6dKe985svnO6mlj
        yqykq1p+7ju22/KtWrLP/3AGX8cA9Fv2n0pVym7W7+uIuWxjz9eICjqdkJ+YCGTJBl/bZfTs9wpVC
        yuAWuJnKNHtwuErm9tMSuSi4jcO98Y92Ql0Ck+/nHfS3VrwrGN0Z3+Lmz6G4LrCbDl2jdEv/bfmmt
        vJ4QrEuk3yfDtfx3be/GtJ6gNOM2oesokgEE1uOYM7Y+Rcl7L6oVZ6k6SBnLqJlOPDHOMUgr6eQZB
        W/q/PVxA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUu-0005cr-4h; Wed, 02 Sep 2020 14:12:24 +0000
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
Subject: [PATCH 03/19] ataflop: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:02 +0200
Message-Id: <20200902141218.212614-4-hch@lst.de>
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
 drivers/block/ataflop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a50e13af030526..3e881fdb06e0ad 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1732,7 +1732,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* invalidate the buffer track to force a reread */
 		BufferDrive = -1;
 		set_bit(drive, &fake_change);
-		check_disk_change(bdev);
+		if (bdev_check_media_change(bdev))
+			floppy_revalidate(bdev->bd_disk);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1909,7 +1910,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return 0;
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		check_disk_change(bdev);
+		if (bdev_check_media_change(bdev))
+			floppy_revalidate(bdev->bd_disk);
 		if (mode & FMODE_WRITE) {
 			if (p->wpstat) {
 				if (p->ref < 0)
@@ -1953,7 +1955,6 @@ static const struct block_device_operations floppy_fops = {
 	.release	= floppy_release,
 	.ioctl		= fd_ioctl,
 	.check_events	= floppy_check_events,
-	.revalidate_disk= floppy_revalidate,
 };
 
 static const struct blk_mq_ops ataflop_mq_ops = {
-- 
2.28.0

