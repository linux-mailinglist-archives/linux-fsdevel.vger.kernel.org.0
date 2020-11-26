Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059272C54BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbgKZNHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389944AbgKZNHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5FC061A04;
        Thu, 26 Nov 2020 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5gqSfUEPjcqcvSOENSbeIw4Q7nJzcUAFuskTYoCv0hA=; b=JWcPR2Czk6lpE+7kEj6vIMT2+/
        4nicpsqgBYNWPrgpWKio4K0jeCe98Uc0g0V9XvFN5/UOpUTdPX8bCSz599ECAiNsDa9IJUPuHehU9
        MwG78A+rwJdIl84DsbRHcZAsiL6DIfCCmgvr8NKINemzjL99+qQIjGMo2ugbnW7FuELEJ/QAJ7922
        aVEnYZjGfu+QFdUK0bXGpy16LW0SS4/NZuDX+KSRtGaN32GdP7RGL6vQfCLc/lGeMv41tUfghfTD2
        YLBhFsDW/u+tArfinK1HJR9C1dufWvDt7yaV8HXH5KfxNloQgg9nLcNaHylzqSwgSzK3/n/NPrBf6
        EnNEM4Ow==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzG-000424-OK; Thu, 26 Nov 2020 13:07:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 21/44] block: move bdput() to the callers of __blkdev_get
Date:   Thu, 26 Nov 2020 14:03:59 +0100
Message-Id: <20201126130422.92945-22-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow for a more symmetric calling convention going forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 86a61a2141f642..d0783c55a0ce65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1458,6 +1458,7 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
 				__blkdev_put(whole, mode, 1);
+				bdput(whole);
 				ret = -ENXIO;
 				goto out_clear;
 			}
@@ -1740,9 +1741,10 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 			disk->fops->release(disk, mode);
 	}
 	mutex_unlock(&bdev->bd_mutex);
-	bdput(bdev);
-	if (victim)
+	if (victim) {
 		__blkdev_put(victim, mode, 1);
+		bdput(victim);
+	}
 }
 
 void blkdev_put(struct block_device *bdev, fmode_t mode)
@@ -1792,6 +1794,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	mutex_unlock(&bdev->bd_mutex);
 
 	__blkdev_put(bdev, mode, 0);
+	bdput(bdev);
 	put_disk_and_module(disk);
 }
 EXPORT_SYMBOL(blkdev_put);
-- 
2.29.2

