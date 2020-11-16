Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE62B474A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKPO6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgKPO6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2BCC0613D2;
        Mon, 16 Nov 2020 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iXRxgxZjdW0OSiynW0b97Ye/Ew891ZT5a6+RemicV+c=; b=QYwalgIHuTfbRFaTkWHkM/7tzW
        ACNgYybAP7vqcx/im3VyKOgAqTgW5Atn+0ww2N8yuikc1w292fLMl1UaSuvRPNP3foPRzIFlfYrUO
        TF5EYc+etKoCl/jtkiK/l8LsHF/56Z+hcqD9nruEsa0QAFV8VyAb2w5WHLyaXloSD46SPL4BHTJgf
        Bvq6vpDR5mgNyI2RyrRZoODX71i6Aaac3KpH4ld2puCpmn3rAVa2TkBfOKYPio3kLY7m4sAF2wK3s
        dHoLtSXORuum4wYRF1CwCfPc8DdNWE91x1++nDT4y6RTBsjGds+V9F6YFSSS6E9XoHMur0U1Y3c7J
        sLlJ6zUA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxU-0003l1-V7; Mon, 16 Nov 2020 14:58:21 +0000
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
Subject: [PATCH 08/78] nbd: refactor size updates
Date:   Mon, 16 Nov 2020 15:56:59 +0100
Message-Id: <20201116145809.410558-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge nbd_size_set and nbd_size_update into a single function that also
updates the nbd_config fields.  This new function takes the device size
in bytes as the first argument, and the blocksize as the second argument,
simplifying the calculations required in most callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 48054051e281e6..6e8f2ff715c661 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -296,28 +296,30 @@ static void nbd_size_clear(struct nbd_device *nbd)
 	}
 }
 
-static void nbd_size_update(struct nbd_device *nbd)
+static void nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+		loff_t blksize)
 {
-	struct nbd_config *config = nbd->config;
-	sector_t nr_sectors = config->bytesize >> 9;
 	struct block_device *bdev;
 
+	nbd->config->bytesize = bytesize;
+	nbd->config->blksize = blksize;
+
 	if (!nbd->task_recv)
 		return;
 
-	if (config->flags & NBD_FLAG_SEND_TRIM) {
-		nbd->disk->queue->limits.discard_granularity = config->blksize;
-		nbd->disk->queue->limits.discard_alignment = config->blksize;
+	if (nbd->config->flags & NBD_FLAG_SEND_TRIM) {
+		nbd->disk->queue->limits.discard_granularity = blksize;
+		nbd->disk->queue->limits.discard_alignment = blksize;
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 	}
-	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
-	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
+	blk_queue_logical_block_size(nbd->disk->queue, blksize);
+	blk_queue_physical_block_size(nbd->disk->queue, blksize);
 
-	set_capacity(nbd->disk, nr_sectors);
+	set_capacity(nbd->disk, bytesize >> 9);
 	bdev = bdget_disk(nbd->disk, 0);
 	if (bdev) {
 		if (bdev->bd_disk)
-			bd_set_nr_sectors(bdev, nr_sectors);
+			bd_set_nr_sectors(bdev, bytesize >> 9);
 		else
 			set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 		bdput(bdev);
@@ -325,15 +327,6 @@ static void nbd_size_update(struct nbd_device *nbd)
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
-static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
-			 loff_t nr_blocks)
-{
-	struct nbd_config *config = nbd->config;
-	config->blksize = blocksize;
-	config->bytesize = blocksize * nr_blocks;
-	nbd_size_update(nbd);
-}
-
 static void nbd_complete_rq(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
@@ -1311,7 +1304,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-	nbd_size_update(nbd);
+	nbd_set_size(nbd, config->bytesize, config->blksize);
 	return error;
 }
 
@@ -1390,15 +1383,14 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			arg = NBD_DEF_BLKSIZE;
 		if (!nbd_is_valid_blksize(arg))
 			return -EINVAL;
-		nbd_size_set(nbd, arg,
-			     div_s64(config->bytesize, arg));
+		nbd_set_size(nbd, config->bytesize, arg);
 		return 0;
 	case NBD_SET_SIZE:
-		nbd_size_set(nbd, config->blksize,
-			     div_s64(arg, config->blksize));
+		nbd_set_size(nbd, arg, config->blksize);
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_size_set(nbd, config->blksize, arg);
+		nbd_set_size(nbd, arg * config->blksize,
+			     config->blksize);
 		return 0;
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
@@ -1828,7 +1820,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 	}
 
 	if (bytes != config->bytesize || bsize != config->blksize)
-		nbd_size_set(nbd, bsize, div64_u64(bytes, bsize));
+		nbd_set_size(nbd, bytes, bsize);
 	return 0;
 }
 
-- 
2.29.2

