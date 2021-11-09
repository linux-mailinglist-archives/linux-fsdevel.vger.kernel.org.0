Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80B44A879
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbhKIIgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbhKIIgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720BC061764;
        Tue,  9 Nov 2021 00:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PrmU1McI9Lz9rWePxXHiZdW7Le1GN8Zv7TzW7GRRfmk=; b=CuJDt0FnnSJ1eRr3YU30gflIA6
        5CCyiEF5PJ92FLWSC5MIrL2oH/HvW4JocKHiNlKk53JCqDzd/ckeXXc2zjfc+Q5VpKYbrY6owJYE1
        bd4bldr9fdxNNWB/TJ3uOl0qQSqz847WVXvuknaL4G1y9MO7XW5obvlN+sFSF2aPN7NtTYpBfBBCk
        lCOIJmFMmk2HWX/bA8RoUdDE2LpUM3knxONSKfFdJTzGHFn3Eh/RmVJo4ZhGtXdzyxdB041usXmfr
        YPoaGNkMnx0dmYe61d55DOrfJlq0O0+WS5XMVD8VYwZ8QNZlI2PRnvOg/51w4Q6RBTR0HukCpwuWF
        b0zyKNrw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZI-000rzk-Aa; Tue, 09 Nov 2021 08:33:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 06/29] dax: move the partition alignment check into fs_dax_get_by_bdev
Date:   Tue,  9 Nov 2021 09:32:46 +0100
Message-Id: <20211109083309.584081-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs_dax_get_by_bdev is the primary interface to find a dax device for a
block device, so move the partition alignment check there instead of
wiring it up through ->dax_supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 04fc680542e8d..482fe775324a4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -93,6 +93,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	if (!blk_queue_dax(bdev->bd_disk->queue))
 		return NULL;
 
+	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
+	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
+		pr_info("%pg: error: unaligned partition for dax\n", bdev);
+		return NULL;
+	}
+
 	id = dax_read_lock();
 	dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
 	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
@@ -107,10 +113,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors)
 {
-	pgoff_t pgoff, pgoff_end;
-	sector_t last_page;
-	int err;
-
 	if (blocksize != PAGE_SIZE) {
 		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
 		return false;
@@ -121,19 +123,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
-	if (err) {
-		pr_info("%pg: error: unaligned partition for dax\n", bdev);
-		return false;
-	}
-
-	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
-	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
-	if (err) {
-		pr_info("%pg: error: unaligned partition for dax\n", bdev);
-		return false;
-	}
-
 	return true;
 }
 EXPORT_SYMBOL_GPL(generic_fsdax_supported);
-- 
2.30.2

