Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A732271B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIUHUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIUHUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40910C061755;
        Mon, 21 Sep 2020 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MHbHWVb7i2hEAMu0TaoSE+DzMo7bJmFTrAxcV7DsN+w=; b=QdjrGTmBYZeIymqLkS2Q7P7Gx2
        x/+QeM1ZWq6UNWGIuIw98ZbzMSin3O6GR2Dqe63K5UNQUUOzE7vPBVnGIMa3DBn5niO9lb1sFgrBn
        5RMKASTBRXaAkVlkO8Kyi8JgzddOkZ6GTTCQGIe+6Hvy4U81+APlro4CQBGVJwDMQAkBKRa0Yf994
        nJJb/0wnximkQPjjmI6IVA5Rugw2kdbbOAmmQ4vsEcOK0UrqBIqzRN3luW42L40fKfq3dultAauYu
        C+DieuoB2H2QWyB6/7t+Pdj1SOXavXNHPo+NUDVBThHXu5Nje6MMkpS9H2TVXgKhGZ8CP96BQZXs6
        ylSGEqqA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG75-0003EK-N7; Mon, 21 Sep 2020 07:19:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH 02/14] block: cleanup partition scanning in register_disk
Date:   Mon, 21 Sep 2020 09:19:46 +0200
Message-Id: <20200921071958.307589-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of open coding it using bdget_disk +
blkdev_get, and split the code to read the partition table into a
separate helper to make it a little more obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7b56203c90a303..05fb27cbb66784 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -673,11 +673,23 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
+static void disk_scan_partitions(struct gendisk *disk)
+{
+	struct block_device *bdev;
+
+	if (!get_capacity(disk) || !disk_part_scan_enabled(disk))
+		return;
+
+	set_bit(GD_NEED_PART_SCAN, &disk->state);
+	bdev = blkdev_get_by_dev(disk_devt(disk), FMODE_READ, NULL);
+	if (!IS_ERR(bdev))
+		blkdev_put(bdev, FMODE_READ);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
-	struct block_device *bdev;
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 	int err;
@@ -719,25 +731,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		return;
 	}
 
-	/* No minors to use for partitions */
-	if (!disk_part_scan_enabled(disk))
-		goto exit;
-
-	/* No such device (e.g., media were just removed) */
-	if (!get_capacity(disk))
-		goto exit;
-
-	bdev = bdget_disk(disk, 0);
-	if (!bdev)
-		goto exit;
-
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	err = blkdev_get(bdev, FMODE_READ, NULL);
-	if (err < 0)
-		goto exit;
-	blkdev_put(bdev, FMODE_READ);
+	disk_scan_partitions(disk);
 
-exit:
 	/* announce disk after possible partitions are created */
 	dev_set_uevent_suppress(ddev, 0);
 	kobject_uevent(&ddev->kobj, KOBJ_ADD);
-- 
2.28.0

