Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D0261F9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgIHUFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgIHPWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:22:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68DC0A3BF4;
        Tue,  8 Sep 2020 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XebGuej3xK5XjUIiTqbUvyFcyDyWl1r5Hy6xhDXcn70=; b=Jo4ghawcy8JBg+Rvq73LY38/vm
        H0E/3JTxgUCzhUOeO6oPYKDq7jMdH0z8pdJiLjtntbizJIeFY7HTlaT+xFliSk4fvXVQUDomQKfPA
        xJbsw3eb0QZfnCk+QgyEv3caVYnmiw7OGLSn+hJs0xwGElk8VP+tw0kxmVPowxAtzAU1Bgy1JQHmc
        Hd8BwUSmYB9t/lgMcdPlNhwsynwcum09GA/F41DqA2uku86jqdlDH5sIRTro5NJnEBpBaTJwjbm4R
        508Zzt5cVLp/Xz02AavSx98OqojF975Rx0eHcnral1/R//khH3OwdlGiu2pymRQTNhe3RCXnbpUVZ
        IvG6zcGg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf1C-0002zh-Fx; Tue, 08 Sep 2020 14:54:46 +0000
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
Subject: [PATCH 16/19] sd: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:44 +0200
Message-Id: <20200908145347.2992670-17-hch@lst.de>
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
call sd_revalidate_disk manually.  As sd also calls sd_revalidate_disk
manually during probe and open, , the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/sd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2bec8cd526164d..d020639c28c6ca 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1381,8 +1381,10 @@ static int sd_open(struct block_device *bdev, fmode_t mode)
 	if (!scsi_block_when_processing_errors(sdev))
 		goto error_out;
 
-	if (sdev->removable || sdkp->write_prot)
-		check_disk_change(bdev);
+	if (sdev->removable || sdkp->write_prot) {
+		if (bdev_check_media_change(bdev))
+			sd_revalidate_disk(bdev->bd_disk);
+	}
 
 	/*
 	 * If the drive is empty, just let the open fail.
@@ -1843,7 +1845,6 @@ static const struct block_device_operations sd_fops = {
 	.compat_ioctl		= sd_compat_ioctl,
 #endif
 	.check_events		= sd_check_events,
-	.revalidate_disk	= sd_revalidate_disk,
 	.unlock_native_capacity	= sd_unlock_native_capacity,
 	.report_zones		= sd_zbc_report_zones,
 	.pr_ops			= &sd_pr_ops,
-- 
2.28.0

