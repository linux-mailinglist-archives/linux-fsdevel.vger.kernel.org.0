Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6716E25AD6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgIBO3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497B8C061261;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wRTpxrCFSwDx+sGCrcIKP/8yjcbTpSeoq/gsW225qj8=; b=Pea5ho/Xg2iRWW6kBTgvU4wogw
        q5SqCIGj1P+XdD5U7/JADn/FOVLtLZFrQEmE2UPK9VSW9kZ6c8hkfJAOegdWuDKEJY9rJ66HiTv4v
        mijiZpFtfw9JfYcXx7fUAS4cKHqhvKTjZECC0gREe6JtCEDBcSAPkAoi/odpfLqjJ8QIDv+YwW50D
        i7FJbkoOHBOp68LabfpZ5yXLYUNu1fk/0BFbiVWuEeUoiSutkHHQ8RxGgkWPGb/2e1Tl5DqUFC3xf
        Z+RIYGYyjVlZf9fnAuG35VCHyZLevVrvo3riOUvam7No+AAgm/POEzfEp3ygvcfu3Zb9GHA7WaBGd
        Ni9JQXpg==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUz-0005dZ-Fr; Wed, 02 Sep 2020 14:12:29 +0000
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
Subject: [PATCH 07/19] swim3: use bdev_check_media_changed
Date:   Wed,  2 Sep 2020 16:12:06 +0200
Message-Id: <20200902141218.212614-8-hch@lst.de>
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

Switch to use bdev_check_media_changed instead of check_disk_change and
call floppy_revalidate manually.  Given that floppy_revalidate only
deals with media change events, the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

