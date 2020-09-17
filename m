Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84226E20B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIQRSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgIQRSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:18:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46AC061756;
        Thu, 17 Sep 2020 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j5g5OgRmz0IwlHnZdVk12MTLugeRmwRtfydhYqXW3VA=; b=h46BUJEBNfEy360lDk+R/ak9Py
        dK++bBMUBX6+Ji16EILbRg6rFJZDzJBKfEjYpp1+29cOwo4Nj0g1llqFP5h+d+zfz1NZNeEgI+WDa
        kVVoajEn577WNKybCXKmBBuj0UJGA/k3G4YyeOP3tmIvYI2eM7+5fLN44sNK49wyDZoZ/wd7e5EcH
        c1xpIODHcW4jCmq6aWQdYW7cZ8IZfHdyLE1Fx9keTpS9OU9G+E0ULmcbmvJaa2dqOaZwREVh9l/AX
        z7fQsLe8kWVGNXXfdvaPMz8BDDwkHDz9hh2k3ciSlJq9AuP3Klq1IE3q+zgPD3YyJyE9zPgP2P7yO
        qq8iikFQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxWn-0001ev-Dz; Thu, 17 Sep 2020 17:17:01 +0000
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
Subject: [PATCH 08/14] dasd: cleanup dasd_scan_partitions
Date:   Thu, 17 Sep 2020 18:57:14 +0200
Message-Id: <20200917165720.3285256-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdget_disk + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_genhd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index af5b0ecb8f8923..70c09a46d22806 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -101,18 +101,11 @@ int dasd_scan_partitions(struct dasd_block *block)
 	struct block_device *bdev;
 	int rc;
 
-	bdev = bdget_disk(block->gdp, 0);
-	if (!bdev) {
-		DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
-			      "scan partitions error, bdget returned NULL");
-		return -ENODEV;
-	}
-
-	rc = blkdev_get(bdev, FMODE_READ, NULL);
-	if (rc < 0) {
+	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL);
+	if (IS_ERR(bdev)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %d",
-			      rc);
+			      IS_ERR(bdev));
 		return -ENODEV;
 	}
 
-- 
2.28.0

