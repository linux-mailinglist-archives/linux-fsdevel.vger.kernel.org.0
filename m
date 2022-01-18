Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03D49200A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiARHUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbiARHUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33426C06161C;
        Mon, 17 Jan 2022 23:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Hmdul2b824Aw+W7hsxfLRPm+W2xGls7ShW1BUgArE2A=; b=FlSg7Ip4B3XJbqRLUazSGBl6sY
        aCwhXTmbowZx9b2j7qi2Hd8DnfbGH4eiPxuAaA2nRPne046/wmkaYlrnWHmDzVrmLfbwtcNrB2Y5G
        L2k1rbD83lcM9y55YgCjdm3x34WIVHPPGGKbMAMBTkOlHX1/RYAWfOSXMvKfFfvu+z6XGHMVcEUOc
        GTFWU4kS/QuprLIJtVIfCwCheJZFCG7BPLBRkxMUGQVd05jFWnJg0a/6rUFRuwjohPcbkpzQsrxtv
        nMW27Vau8u3rAodC7STr3O6ThI27hF4j362D5p61hPICn2G3bNrEpQc2H7FsOMM9QEe/wLR7EuIoO
        m2N3R2JA==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9in6-000Zaz-6Z; Tue, 18 Jan 2022 07:20:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 12/19] xen-blkback: bio_alloc can't fail if it is allow to sleep
Date:   Tue, 18 Jan 2022 08:19:45 +0100
Message-Id: <20220118071952.1243143-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove handling of NULL returns from sleeping bio_alloc calls given that
those can't fail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkback/blkback.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 14e452896d04c..6bb2ad7692065 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1327,9 +1327,6 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 				     seg[i].nsec << 9,
 				     seg[i].offset) == 0)) {
 			bio = bio_alloc(GFP_KERNEL, bio_max_segs(nseg - i));
-			if (unlikely(bio == NULL))
-				goto fail_put_bio;
-
 			biolist[nbio++] = bio;
 			bio_set_dev(bio, preq.bdev);
 			bio->bi_private = pending_req;
@@ -1346,9 +1343,6 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		BUG_ON(operation_flags != REQ_PREFLUSH);
 
 		bio = bio_alloc(GFP_KERNEL, 0);
-		if (unlikely(bio == NULL))
-			goto fail_put_bio;
-
 		biolist[nbio++] = bio;
 		bio_set_dev(bio, preq.bdev);
 		bio->bi_private = pending_req;
@@ -1381,14 +1375,6 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	free_req(ring, pending_req);
 	msleep(1); /* back off a bit */
 	return -EIO;
-
- fail_put_bio:
-	for (i = 0; i < nbio; i++)
-		bio_put(biolist[i]);
-	atomic_set(&pending_req->pendcnt, 1);
-	__end_block_io_op(pending_req, BLK_STS_RESOURCE);
-	msleep(1); /* back off a bit */
-	return -EIO;
 }
 
 
-- 
2.30.2

