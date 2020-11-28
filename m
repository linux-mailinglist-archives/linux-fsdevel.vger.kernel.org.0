Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49C2C75AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgK1VtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbgK1Sm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:42:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33DC025487;
        Sat, 28 Nov 2020 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=58eRvABQ9wcBaVUecn4OAyBZ+Jv++aJOLsdqKdGeutg=; b=NketMA/qS9o3GPr2SbKJRQmdNq
        pAtkMDydyPF3ecFOIsS4NbLEEDFNmefQuMBkQit3GpjJKLRxXm8pnvFD3NCyW3+kflIhNBh8C8DQe
        xjLrMJaAC6hNsYGzFNl9IuapwYcRhReMChdfv7HMgFZ83JP5Vvy0UlYixykYMDKlwKmewLdOSSqz5
        mWwZTizFMMlajZWalQr1vYwESDdaWv1WfnpDRlFB9bw8SHbYfmfCPt9+0qfRcmknoOqPtopPUzHDS
        q+yt+4ZSx0spCtDL7PPF2dD49DtamtSjr+HzjaHpeftqqv6Le/xaG5EzHCP3xl2FTNzfXoAZ1vx6x
        o5IaGSkA==;
Received: from [2001:4bb8:18c:1dd6:48f3:741a:602e:7fdd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj2t2-0000Iy-4Q; Sat, 28 Nov 2020 16:15:49 +0000
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
Subject: [PATCH 22/45] block: move bdput() to the callers of __blkdev_get
Date:   Sat, 28 Nov 2020 17:14:47 +0100
Message-Id: <20201128161510.347752-23-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow for a more symmetric calling convention going forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0c533ac92e2492..a2d5050c97ee08 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1462,6 +1462,7 @@ static int __blkdev_get(struct block_device *bdev, struct gendisk *disk,
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
 				__blkdev_put(whole, mode, 1);
+				bdput(whole);
 				ret = -ENXIO;
 				goto out_clear;
 			}
@@ -1744,9 +1745,10 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
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
@@ -1796,6 +1798,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	mutex_unlock(&bdev->bd_mutex);
 
 	__blkdev_put(bdev, mode, 0);
+	bdput(bdev);
 	put_disk_and_module(disk);
 }
 EXPORT_SYMBOL(blkdev_put);
-- 
2.29.2

