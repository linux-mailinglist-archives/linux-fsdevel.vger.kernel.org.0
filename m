Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA582B7924
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKRIsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgKRIsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31653C061A4D;
        Wed, 18 Nov 2020 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hm2+pi+4EcUeDYOHdyHUHSpCkqg13LYEV8plE6Pffx8=; b=F+OqFDrimZDfU9oJC3NE+WAnBj
        7NLGpAAHAxBrMkgV1jR3eCykIQBIYIkgtzV298VqK/hLnjFuqPQGLtD2serG/rjdABz8On3RjiItS
        jkjRT9VHC9QKxUb1fSffe1v27SEXnA5UA7cfOhezqYd+B8+1RmQrgFitIopZN9HgcU4BlpENM55mc
        SmJfzHiBAgDUmmdfkk8wpbWRoWTnUjgqAObiihN+jvvcuIIiGzIpd+Z4cEyFPI9BuVali3hgqEbEh
        14dcstmz4K2XoTMFEhD0nljib+tsh8e84xtfzcg1rp0zf4RvjCV27VRRqa3U1Ob0Zbm1BuetfFb0V
        DB31SJ8A==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8V-0007m0-4B; Wed, 18 Nov 2020 08:48:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/20] block: refactor __blkdev_put
Date:   Wed, 18 Nov 2020 09:47:50 +0100
Message-Id: <20201118084800.2339180-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reorder the code to have one big section for the last close, and to use
bdev_is_partition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 29db12c3bb501c..4c4d6c30382c06 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1745,22 +1745,22 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		WARN_ON_ONCE(bdev->bd_holders);
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
-
 		bdev_write_inode(bdev);
-	}
-	if (bdev->bd_contains == bdev) {
-		if (disk->fops->release)
+
+		if (!bdev_is_partition(bdev) && disk->fops->release)
 			disk->fops->release(disk, mode);
-	}
-	if (!bdev->bd_openers) {
+
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
 		bdev->bd_disk = NULL;
-		if (bdev != bdev->bd_contains)
+		if (bdev_is_partition(bdev))
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
 
 		put_disk_and_module(disk);
+	} else {
+		if (!bdev_is_partition(bdev) && disk->fops->release)
+			disk->fops->release(disk, mode);
 	}
 	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
-- 
2.29.2

