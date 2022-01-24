Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B020497B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiAXJL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiAXJLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:11:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648BC061744;
        Mon, 24 Jan 2022 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Hmdul2b824Aw+W7hsxfLRPm+W2xGls7ShW1BUgArE2A=; b=pWc0N5kYb4bArsjIbr1mc2MULT
        3C8ao+NuMPVQ2pEhWYD0pS4OEiDwzWJcF3OQWJ/7qPuRxogxWFPuvaH/AdXs6d9RZUXZ3YF8Gb0Z3
        adpO4UBuk/hqPQGUGdkP7euk2NRZzk0iS7A1P8UCLCAKB11FO7xYa9uy+6z1r53Ll03uwC/sZF7Bz
        2AYkMWod1x441+zLUUKusAzBIuZ96nUG4RvGk5j2uXutO+aMMny3ji5ZOHON/lia9Bdro8LDESVGt
        +7vVuZZXadeZX2arJ2UfxF0DCT0MLTUT8dyRYXfgOb5VGvKJj2KC8zrta0vgK9UgXnaGvmHM5Jw+1
        YxPUbcZQ==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvO3-002kGt-6c; Mon, 24 Jan 2022 09:11:43 +0000
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
Date:   Mon, 24 Jan 2022 10:11:00 +0100
Message-Id: <20220124091107.642561-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124091107.642561-1-hch@lst.de>
References: <20220124091107.642561-1-hch@lst.de>
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

