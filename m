Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063312AEBAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKKI26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKKI11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929EC0613D4;
        Wed, 11 Nov 2020 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v2gXXjqIndtMF2Cf5P694LBcUky2akZ2+CMnUKb8IcU=; b=h/ZYOi0vPQIdcMW1X52epW5iIP
        h9Zyh9xPBuvnBtDR9rJcVsymjFWgk2TUgP4FFoLLdSCTXe7ntGcJ5XG69rsQgx37axiExy9vtBsT1
        WBPGFF1X/JoJyNnoKqxYrl7ac50v8NuDAsyON6Auh+N53il+fFZBpHHFKORtkmvUwR/cJitnZpnUl
        qpV6JtDzWquk9bGQKBeU5PsoxpY5zIRfl9bEs8/f166ebvAy9I0T0F3CoN03bOJTOZl0KUK74BFDy
        p+OLpVJpLwXYsam4cN6EaXZ7O9sv6RwyX3Fruby3X96wcAyNGRRY8EPu1u1sug1AC5oK4U/Qi4bOK
        QmB+Zi2A==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclTE-0007bJ-Mw; Wed, 11 Nov 2020 08:27:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/24] nbd: use set_capacity_and_notify
Date:   Wed, 11 Nov 2020 09:26:45 +0100
Message-Id: <20201111082658.3401686-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use set_capacity_and_notify to update the disk and block device sizes and
send a RESIZE uevent to userspace.  Note that blktests relies on uevents
being sent also for updates that did not change the device size, so the
explicit kobject_uevent remains for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 327060e01ad58e..a6f51934391edb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -299,8 +299,6 @@ static void nbd_size_clear(struct nbd_device *nbd)
 static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		loff_t blksize)
 {
-	struct block_device *bdev;
-
 	if (!blksize)
 		blksize = NBD_DEF_BLKSIZE;
 	if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
@@ -320,16 +318,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 	blk_queue_logical_block_size(nbd->disk->queue, blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, blksize);
 
-	set_capacity(nbd->disk, bytesize >> 9);
-	bdev = bdget_disk(nbd->disk, 0);
-	if (bdev) {
-		if (bdev->bd_disk)
-			bd_set_nr_sectors(bdev, bytesize >> 9);
-		else
-			set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
-		bdput(bdev);
-	}
-	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
+	set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
+	if (!set_capacity_and_notify(nbd->disk, bytesize >> 9))
+		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
2.28.0

