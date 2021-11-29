Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36BB461342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354107AbhK2LLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354201AbhK2LJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:09:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04546C08E9AC;
        Mon, 29 Nov 2021 02:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UKPlOruGYXgvpYiUrVEWmqUFKgTCebZbbinpg8lZZWY=; b=SvmFV2K6BH98rrmkUK23eJq8Cc
        SPT1+17YYhBTJUiEA9tDobk8ioPedPiE6jDfNf42bafFOCuj89DFF2p0sihzAHHuUkXcDEQ7GtEYh
        bhHvoDwGNRLm3n0ZKz40+9tRqbZb2Hn2GB6MDQxBSrsHGvPLmYcNk7h2QMEIphbr+BSzGHi8JWZ5R
        HhD6rXsQlVJJohX5fBVJUPP2hyWiIA9UbqnEvL63jQIe6dpMazA8WnsmiSAnfOCv5EoH1ier71Ujd
        EY9138E0le+Ibmm+92S3jdMVeSzCje+1mE/7lAesO/5a3TQpCXoFvA80C9uf9cjZaua/RMNT9UwpS
        O6+CA6jQ==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnY-0073Kv-0W; Mon, 29 Nov 2021 10:22:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 06/29] dax: move the partition alignment check into fs_dax_get_by_bdev
Date:   Mon, 29 Nov 2021 11:21:40 +0100
Message-Id: <20211129102203.2243509-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c8500b7e2d8a2..f2cef47bdeafd 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -92,6 +92,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
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
@@ -106,10 +112,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
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
@@ -120,19 +122,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
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

