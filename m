Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367382C2732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgKXN2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbgKXN2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E52C061A4D;
        Tue, 24 Nov 2020 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0e+oH+92GlExM9i4SIPWTJvhHTDsEZRU6nAY6yeduas=; b=REng/ovLixhm4d/5DVr1VL2uxE
        639N3KIOFrakBFne91QmfkqFXFb98IXLDOJAJjpMFMj6wLqG5p9ivwi/IdkTiYg4UpBWe6eJ1dbQ0
        HBBalWEc8V1HK853AyKP05+uuRQAG2MYtBlard5dwdv3pfAPnyCU606UPfuqSfkDGROj+x/Jgp80m
        xgK0Cn++2YT5C/MR23s2fjCN+ORZdOrOQHa/0v4hpeslgE++xWymjVqNfUo2VOJ114NGbFD3umqP5
        6luT+lKBWO6SNfhge4bMavfuGRB4GvvtxnMy6Fhr3dVO8r0ujYfdajMXqb4qBL494koWxbslNF9Up
        gR2DYZAw==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMU-0006Uj-4z; Tue, 24 Nov 2020 13:28:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 05/45] mtip32xx: remove the call to fsync_bdev on removal
Date:   Tue, 24 Nov 2020 14:27:11 +0100
Message-Id: <20201124132751.3747337-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

del_gendisk already calls fsync_bdev for every partition, no need
to do this twice.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 15 ---------------
 drivers/block/mtip32xx/mtip32xx.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 153e2cdecb4d40..53ac59d19ae530 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3687,7 +3687,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	/* Enable the block device and add it to /dev */
 	device_add_disk(&dd->pdev->dev, dd->disk, NULL);
 
-	dd->bdev = bdget_disk(dd->disk, 0);
 	/*
 	 * Now that the disk is active, initialize any sysfs attributes
 	 * managed by the protocol layer.
@@ -3721,9 +3720,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	return rv;
 
 kthread_run_error:
-	bdput(dd->bdev);
-	dd->bdev = NULL;
-
 	/* Delete our gendisk. This also removes the device from /dev */
 	del_gendisk(dd->disk);
 
@@ -3804,14 +3800,6 @@ static int mtip_block_remove(struct driver_data *dd)
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 	blk_mq_unquiesce_queue(dd->queue);
 
-	/*
-	 * Delete our gendisk structure. This also removes the device
-	 * from /dev
-	 */
-	if (dd->bdev) {
-		bdput(dd->bdev);
-		dd->bdev = NULL;
-	}
 	if (dd->disk) {
 		if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 			del_gendisk(dd->disk);
@@ -4206,9 +4194,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	} while (atomic_read(&dd->irq_workers_active) != 0 &&
 		time_before(jiffies, to));
 
-	if (!dd->sr)
-		fsync_bdev(dd->bdev);
-
 	if (atomic_read(&dd->irq_workers_active) != 0) {
 		dev_warn(&dd->pdev->dev,
 			"Completion workers still active!\n");
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index e22a7f0523bf30..88f4206310e4c8 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -463,8 +463,6 @@ struct driver_data {
 
 	int isr_binding;
 
-	struct block_device *bdev;
-
 	struct list_head online_list; /* linkage for online list */
 
 	struct list_head remove_list; /* linkage for removing list */
-- 
2.29.2

