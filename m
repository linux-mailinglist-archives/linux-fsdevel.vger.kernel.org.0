Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4B271B73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIUHUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIUHUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CAC0613D3;
        Mon, 21 Sep 2020 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h4/QAG7XZ2LCco1JGzki/qWfOc0KsyEC+JNPlpp1wQs=; b=rR+xdh0vm8Noc5mUmvFDkm382Y
        2/hBIY6JnJ/t5EJ/+4CkoFQwcplR8SmigV0bGKUQHjtFPo+zFY5bAhrP9J34SO9L3mIRVu6uPWfio
        eb+xYTNQ212M5Av8vWYE8W6wSDyveZsA7OK4P7UJ0neZC4NAuadFp7uE0rxtUH7widtkZKBfJWFVx
        cgu5vP4udQ1r7N2E0rZaDsPs7/Z+O6AbXkrPytdYHpV+l88YVd7OJdaCt5IP16sYkWxOW8ujzcCcE
        Oz8ezB17rjqJ2smetvrxQy6Y342pmj76dAhlR/zDmbP1D/XTK2f5Q2McAVRNsEO4Qg81EjcgzptIR
        3+b9FgWA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7C-0003FI-Bs; Mon, 21 Sep 2020 07:19:58 +0000
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
Date:   Mon, 21 Sep 2020 09:19:52 +0200
Message-Id: <20200921071958.307589-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdget_disk + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_genhd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index af5b0ecb8f8923..a9698fba9b76ce 100644
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
-			      "scan partitions error, blkdev_get returned %d",
-			      rc);
+			      "scan partitions error, blkdev_get returned %ld",
+			      PTR_ERR(bdev));
 		return -ENODEV;
 	}
 
-- 
2.28.0

