Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F22C27A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbgKXN3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbgKXN3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA62C0613D6;
        Tue, 24 Nov 2020 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rkhCK9axDIdfwwNjyKoG+774dMOXuWJwR7IEMeelgXY=; b=PQ5bqenaVy/ulzz4fkq2HpLbJw
        jMFBpPUwLoaNoRweakNlk9vK6w2GGBD9V7NouqIFNFDrt+OFuoHGpwmoV+C2Dz9IgRy+zT4RekOgp
        yRVbSP1HZxkx0csM7/WeXyX3uhTcfBM6ujVZ95BYXFBNO2sl3g6g85SRDSlBaFSWrg58tnEvoOh+K
        DWiflISSMeOX5/4zOkK9GQGE9hU0GpueKGcJ+Rk0zYlSdyDNpm7azVHs27XfP5PWmBH75zq117BUo
        r3V1xIFl+5sBZkqGIXM+BInjWDE/7AFwJUoPfBw5Qf3TuPAlitujVvHtEPQHxUMHyJkpLz3BzWrap
        cex3173Q==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNU-0006i4-0Y; Tue, 24 Nov 2020 13:29:04 +0000
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
Subject: [PATCH 41/45] block: pass a block_device to invalidate_partition
Date:   Tue, 24 Nov 2020 14:27:47 +0100
Message-Id: <20201124132751.3747337-42-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device actually needed instead of looking it up using
bdget_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 498c816e90df64..2985740eab084b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -790,14 +790,8 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-static void invalidate_partition(struct gendisk *disk, int partno)
+static void invalidate_partition(struct block_device *bdev)
 {
-	struct block_device *bdev;
-
-	bdev = bdget_disk(disk, partno);
-	if (!bdev)
-		return;
-
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
 
@@ -806,7 +800,6 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 	 * as last inode reference is dropped.
 	 */
 	remove_inode_hash(bdev->bd_inode);
-	bdput(bdev);
 }
 
 /**
@@ -847,12 +840,12 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(disk, part->bdev->bd_partno);
+		invalidate_partition(part->bdev);
 		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
 
-	invalidate_partition(disk, 0);
+	invalidate_partition(disk->part0);
 	set_capacity(disk, 0);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-- 
2.29.2

