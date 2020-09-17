Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E826E1D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgIQRJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIQRIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:08:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051CC06174A;
        Thu, 17 Sep 2020 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4c25EWJSxFzOYhIibdL7mqfc9EKW4o438wOYFv3WSIE=; b=KljDvuYu1mLZdz61cYDyxPiR4G
        7h17/Qn15cKyl4InaV1/ZH/QQ/zvWWhXcY/vy+TBfxD4bvVhSJo+S6ANB6zpdUNy4J3nL5fDyyTLX
        JrrbXBZpAvJxsxJ+CK8ZZ6UqpJme6kifEjNha87yvS3Jw4fR7m1ZbTaTdDx5EiJIje9Y0dHOCwQkN
        SQOcZqMgX4fv/Byp0eCHgdDXsUYHkBQWQnpzeCbIpNgj3DvLft1JffOpNi6k8plqZv0IGGGbF6Pu0
        BKtLwcxZeEEiVshWMAF7cCYO8u0jFWmalZwnhShpNB1vO3mip9Ydlj6xlS4g1CQN45LAX2aOxFjRu
        zKykS7wA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxOL-0000ub-20; Thu, 17 Sep 2020 17:08:17 +0000
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
Subject: [PATCH 04/14] pktcdvd: remove the if 0'ed pkt_start_recovery function
Date:   Thu, 17 Sep 2020 18:57:10 +0200
Message-Id: <20200917165720.3285256-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove code which has been dead since the initial commit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 67 ++---------------------------------------
 1 file changed, 2 insertions(+), 65 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 17f2e6ff122314..bc870a5f15f77b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1082,65 +1082,6 @@ static void pkt_put_packet_data(struct pktcdvd_device *pd, struct packet_data *p
 	}
 }
 
-/*
- * recover a failed write, query for relocation if possible
- *
- * returns 1 if recovery is possible, or 0 if not
- *
- */
-static int pkt_start_recovery(struct packet_data *pkt)
-{
-	/*
-	 * FIXME. We need help from the file system to implement
-	 * recovery handling.
-	 */
-	return 0;
-#if 0
-	struct request *rq = pkt->rq;
-	struct pktcdvd_device *pd = rq->rq_disk->private_data;
-	struct block_device *pkt_bdev;
-	struct super_block *sb = NULL;
-	unsigned long old_block, new_block;
-	sector_t new_sector;
-
-	pkt_bdev = bdget(kdev_t_to_nr(pd->pkt_dev));
-	if (pkt_bdev) {
-		sb = get_super(pkt_bdev);
-		bdput(pkt_bdev);
-	}
-
-	if (!sb)
-		return 0;
-
-	if (!sb->s_op->relocate_blocks)
-		goto out;
-
-	old_block = pkt->sector / (CD_FRAMESIZE >> 9);
-	if (sb->s_op->relocate_blocks(sb, old_block, &new_block))
-		goto out;
-
-	new_sector = new_block * (CD_FRAMESIZE >> 9);
-	pkt->sector = new_sector;
-
-	bio_reset(pkt->bio);
-	bio_set_dev(pkt->bio, pd->bdev);
-	bio_set_op_attrs(pkt->bio, REQ_OP_WRITE, 0);
-	pkt->bio->bi_iter.bi_sector = new_sector;
-	pkt->bio->bi_iter.bi_size = pkt->frames * CD_FRAMESIZE;
-	pkt->bio->bi_vcnt = pkt->frames;
-
-	pkt->bio->bi_end_io = pkt_end_io_packet_write;
-	pkt->bio->bi_private = pkt;
-
-	drop_super(sb);
-	return 1;
-
-out:
-	drop_super(sb);
-	return 0;
-#endif
-}
-
 static inline void pkt_set_state(struct packet_data *pkt, enum packet_data_state state)
 {
 #if PACKET_DEBUG > 1
@@ -1357,12 +1298,8 @@ static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data
 			break;
 
 		case PACKET_RECOVERY_STATE:
-			if (pkt_start_recovery(pkt)) {
-				pkt_start_write(pd, pkt);
-			} else {
-				pkt_dbg(2, pd, "No recovery possible\n");
-				pkt_set_state(pkt, PACKET_FINISHED_STATE);
-			}
+			pkt_dbg(2, pd, "No recovery possible\n");
+			pkt_set_state(pkt, PACKET_FINISHED_STATE);
 			break;
 
 		case PACKET_FINISHED_STATE:
-- 
2.28.0

