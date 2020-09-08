Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC926154F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgIHQsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731991AbgIHQrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:47:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88250C0A3BE4;
        Tue,  8 Sep 2020 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=r+1XrJtfpZtchsPxllDIrQwea0QdW0twLhMRVg4bhr8=; b=TT1nBZNCsWHZwn8UVBX7BK04cl
        V40yiVsMvETvsDAW5Wv9FQEx+6Zx3521Msa0ODGqX7JbyDbDwi7zup7RnusXJ3FizgOGll1ZitZbv
        9FGQsobPamD8oInPwE68PLMVwDRZyGaf+z5cEbBFv6xTgtn1S7qa8OXvWSHKlwDVPBVp9xaNKqDgj
        buRSn6aV1BPk5x71DUtH2D8JjWabTkIrbg4T77sAAwKPj4NmijWG2FfgHeBdH03ndnmQPwgRo0CSP
        MgVlsN7xnx586Nk6lX1sNpc4JawJPCNroTbCJTWL5kYAs2WXGcyBNvl+eXuP/ULNu9P/9zH/JmDCK
        D5T5USFQ==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0q-0002xX-5v; Tue, 08 Sep 2020 14:54:27 +0000
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
Subject: [PATCH 07/19] swim3: use bdev_check_media_changed
Date:   Tue,  8 Sep 2020 16:53:35 +0200
Message-Id: <20200908145347.2992670-8-hch@lst.de>
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
call floppy_revalidate manually.  Given that floppy_revalidate only
deals with media change events, the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/swim3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index aa77eb5fb7de88..c2d922d125e281 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -945,7 +945,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	if (err == 0 && (mode & FMODE_NDELAY) == 0
 	    && (mode & (FMODE_READ|FMODE_WRITE))) {
-		check_disk_change(bdev);
+		if (bdev_check_media_change(bdev))
+			floppy_revalidate(bdev->bd_disk);
 		if (fs->ejected)
 			err = -ENXIO;
 	}
@@ -1055,7 +1056,6 @@ static const struct block_device_operations floppy_fops = {
 	.release	= floppy_release,
 	.ioctl		= floppy_ioctl,
 	.check_events	= floppy_check_events,
-	.revalidate_disk= floppy_revalidate,
 };
 
 static const struct blk_mq_ops swim3_mq_ops = {
-- 
2.28.0

