Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74414F590A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiDFJQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353400AbiDFJCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:02:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F8A43F1CB;
        Tue,  5 Apr 2022 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8b7He7jKWHmQh3KokdF/PRePZ9Zk3nvKntDAn0vRB+A=; b=0omtD+HQtA616dFivyqA97DclF
        5MCkQ36VFGZAUVgFUJvq7ULB9RxmAnnJK9Ru4GgkOHXwFqXqRHMXQ9LCogkUlyoM9wN6+7J7DekaY
        q43/dVC7g/6yyYP+I8eJgSyycd7IVsGmMYkR1Clskvv1tDsGCaTWuQ8Rrf8sU79R1v0lw2bQt/AWB
        OsOPsydboiChznz0eGpngaPA8w2OVY6Jf3YdqyKDFL16zctVHp5+n0d+GDis8Omgb+WFkLhPwAzdn
        EsF+yQBNP9+37ibHq8jy0MV7lNP50mXC+UwgCTvOjOUrw+1nocIz3QcImLpc9EsYaF5HR/HZej/jt
        LdNiWxFQ==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbynX-003uuj-EB; Wed, 06 Apr 2022 06:05:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: [PATCH 06/27] drbd: cleanup decide_on_discard_support
Date:   Wed,  6 Apr 2022 08:04:55 +0200
Message-Id: <20220406060516.409838-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sanitize the calling conventions and use a goto label to cleanup the
code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 68 +++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 02030c9c4d3b1..40bb0b356a6d6 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1204,38 +1204,42 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
 }
 
 static void decide_on_discard_support(struct drbd_device *device,
-			struct request_queue *q,
-			struct request_queue *b,
-			bool discard_zeroes_if_aligned)
+		struct drbd_backing_dev *bdev)
 {
-	/* q = drbd device queue (device->rq_queue)
-	 * b = backing device queue (device->ldev->backing_bdev->bd_disk->queue),
-	 *     or NULL if diskless
-	 */
-	struct drbd_connection *connection = first_peer_device(device)->connection;
-	bool can_do = b ? blk_queue_discard(b) : true;
-
-	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_TRIM)) {
-		can_do = false;
-		drbd_info(connection, "peer DRBD too old, does not support TRIM: disabling discards\n");
-	}
-	if (can_do) {
-		/* We don't care for the granularity, really.
-		 * Stacking limits below should fix it for the local
-		 * device.  Whether or not it is a suitable granularity
-		 * on the remote device is not our problem, really. If
-		 * you care, you need to use devices with similar
-		 * topology on all peers. */
-		blk_queue_discard_granularity(q, 512);
-		q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
-		q->limits.max_write_zeroes_sectors = drbd_max_discard_sectors(connection);
-	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		blk_queue_discard_granularity(q, 0);
-		q->limits.max_discard_sectors = 0;
-		q->limits.max_write_zeroes_sectors = 0;
+	struct drbd_connection *connection =
+		first_peer_device(device)->connection;
+	struct request_queue *q = device->rq_queue;
+
+	if (bdev && !blk_queue_discard(bdev->backing_bdev->bd_disk->queue))
+		goto not_supported;
+
+	if (connection->cstate >= C_CONNECTED &&
+	    !(connection->agreed_features & DRBD_FF_TRIM)) {
+		drbd_info(connection,
+			"peer DRBD too old, does not support TRIM: disabling discards\n");
+		goto not_supported;
 	}
+
+	/*
+	 * We don't care for the granularity, really.
+	 *
+	 * Stacking limits below should fix it for the local device.  Whether or
+	 * not it is a suitable granularity on the remote device is not our
+	 * problem, really. If you care, you need to use devices with similar
+	 * topology on all peers.
+	 */
+	blk_queue_discard_granularity(q, 512);
+	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
+	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	q->limits.max_write_zeroes_sectors =
+		drbd_max_discard_sectors(connection);
+	return;
+
+not_supported:
+	blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
+	blk_queue_discard_granularity(q, 0);
+	q->limits.max_discard_sectors = 0;
+	q->limits.max_write_zeroes_sectors = 0;
 }
 
 static void fixup_discard_if_not_supported(struct request_queue *q)
@@ -1273,7 +1277,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	unsigned int max_segments = 0;
 	struct request_queue *b = NULL;
 	struct disk_conf *dc;
-	bool discard_zeroes_if_aligned = true;
 
 	if (bdev) {
 		b = bdev->backing_bdev->bd_disk->queue;
@@ -1282,7 +1285,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		rcu_read_lock();
 		dc = rcu_dereference(device->ldev->disk_conf);
 		max_segments = dc->max_bio_bvecs;
-		discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
 		rcu_read_unlock();
 
 		blk_set_stacking_limits(&q->limits);
@@ -1292,7 +1294,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	/* This is the workaround for "bio would need to, but cannot, be split" */
 	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
 	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
+	decide_on_discard_support(device, bdev);
 
 	if (b) {
 		blk_stack_limits(&q->limits, &b->limits, 0);
-- 
2.30.2

