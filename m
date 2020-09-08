Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C52261E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgIHTpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbgIHPuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25992C0A3BE9;
        Tue,  8 Sep 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZZPptDJA7zo1pAmFtcEHIHPbV2EOsr7b1cFpG8AIcSg=; b=LPHktdA1gD7zeQQmz1PPQ3v5qm
        h/lMeXNocn437rcYbMj7jTZxiaHU9pV8FjH0aOTRVZNq+ApSVFhaLpL3XwoG1LVgIRy53Kvwob7XJ
        UVvpLK5x7kC/XQZMOuvLuOUKMfdPXLRK1kO1mk+fwOCgBM1B+y2gqXiP+J4WtUb2bdDFsD0F0WFZ+
        5JBzNyJnUQgdTBLrXVWuAMM02tA/zbsqD+3rgsJ752DILPi4zZoVJpMQAptJqjEMh8gLv2H2VUyO+
        tzZ7u+gpJaZWNg9UW1SYEV4hSRQwzDPaAOWnmV5ynT1ATDJ7C61oaqwpLcto/+1Keo1msuFgsrlbp
        K+aZB7fA==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0X-0002w7-Sk; Tue, 08 Sep 2020 14:54:08 +0000
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
Subject: [PATCH 03/19] ataflop: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:31 +0200
Message-Id: <20200908145347.2992670-4-hch@lst.de>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

