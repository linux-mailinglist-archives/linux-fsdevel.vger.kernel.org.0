Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3836026E3EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIQSiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgIQREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:04:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F606C06174A;
        Thu, 17 Sep 2020 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1fBT9s1q2BeyeX5HlyXsJ+Y6Y5+WpSqbNQWYXqzlTr0=; b=P6srGR6vEznh8lHtplE7kMZUWt
        NC07bfyxiYydvJofD1807i3dSytM+YwHGjTqXPxPxVItTdUyA3Y5tN/K5vADXgpxE6OZRhUADgvFU
        xSQVyeLBnlSaVXGkYFI2TnoQgbrSA1qj7L6NeTFBTQiGAqnNO6EomBrAE8LBfpN/g97kN+89KshXt
        3vH8sjjPHQN56MPFQdlJ43XVOo/g4nQmyS7PXGmypC56CULLI41HYb+f8SYkTZjCVSzth1iP0lbiI
        Y7JIy2SR9IGcI1kT0VMb0xyLEAlWiOUgK2lQgr9pbh0UJmhEyE6SX3aG5bpiuzVgHzxmZS+i74gxH
        VS4vkhvA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxK6-0000Y8-TJ; Thu, 17 Sep 2020 17:03:55 +0000
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
Subject: [PATCH 02/14] block: switch register_disk to use blkdev_get_by_dev
Date:   Thu, 17 Sep 2020 18:57:08 +0200
Message-Id: <20200917165720.3285256-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of open coding it using bdget_disk +
blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7b56203c90a303..f778716fac6cde 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -732,10 +732,9 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		goto exit;
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	err = blkdev_get(bdev, FMODE_READ, NULL);
-	if (err < 0)
-		goto exit;
-	blkdev_put(bdev, FMODE_READ);
+	bdev = blkdev_get_by_dev(disk_devt(disk), FMODE_READ, NULL);
+	if (!IS_ERR(bdev))
+		blkdev_put(bdev, FMODE_READ);
 
 exit:
 	/* announce disk after possible partitions are created */
-- 
2.28.0

