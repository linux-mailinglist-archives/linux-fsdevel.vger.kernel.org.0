Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73636B45F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhDZN4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhDZN4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F52C061574;
        Mon, 26 Apr 2021 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xx4Cz8+VRZIai22xncAKSSeddbBkdRcxhPCDno94DQQ=; b=QC4OFA1L5zvQq5ABpmdLIrioay
        SxjJI0TbMUvewaNZL4NI10dFw0MDlygEUzVMclaO1snbOko5bmGPzleawPTT7wP0z/uujGQbFYNSK
        MjA8RJY4jmRfRYPPIeSBQvNNMdxS00xzbGfQ2ml/XiIKH2odjEI7W9ubszVdB5/x/ExGxQs8pfdv3
        lr/rCXZ7fGcozOLXNmcvYAR0w20Uw9yPmo+eJXjSSQ6Z3pxv0Z41GUUJsDMxBD8E7Ub/NoOGnFDaN
        VRjQLXXdjEU2A/feVzVqDHQNQybi7mLMuOP8SmeEabilGGr6iaJi/mnY/Oz3DGELJRgg8uIu6WaHC
        06tjI1sg==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hp-00Fzp8-2t; Mon, 26 Apr 2021 13:55:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] block: RCU free polled bios
Date:   Mon, 26 Apr 2021 15:48:19 +0200
Message-Id: <20210426134821.2191160-11-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Free the actual memory used for the bio using RCU for polled bios.
This will allow to store all the polling information in the bio and
thus simplify passing the cookie and allow for polling stacked devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 28 +++++++++++++++++++---------
 include/linux/blk_types.h |  6 +++++-
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 303298996afe..7296abe293de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -215,25 +215,35 @@ void bio_uninit(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_uninit);
 
+static inline void bio_mempool_free(struct bio *bio)
+{
+	struct bio_set *bs = bio->bi_pool;
+	void *p = bio;
+
+	p -= bs->front_pad;
+	mempool_free(p, &bs->bio_pool);
+}
+
+static void bio_free_rcu(struct rcu_head *head)
+{
+	bio_mempool_free(container_of(head, struct bio, bi_rcu_free));
+}
+
 static void bio_free(struct bio *bio)
 {
 	struct bio_set *bs = bio->bi_pool;
-	void *p;
 
 	bio_uninit(bio);
 
 	if (bs) {
 		bvec_free(&bs->bvec_pool, bio->bi_io_vec, bio->bi_max_vecs);
-
-		/*
-		 * If we have front padding, adjust the bio pointer before freeing
-		 */
-		p = bio;
-		p -= bs->front_pad;
-
-		mempool_free(p, &bs->bio_pool);
+		if (bio->bi_opf & REQ_POLLED)
+			call_rcu(&bio->bi_rcu_free, bio_free_rcu);
+		else
+			bio_mempool_free(bio);
 	} else {
 		/* Bio was allocated by bio_kmalloc() */
+		WARN_ON_ONCE(bio->bi_opf & REQ_POLLED);
 		kfree(bio);
 	}
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ac60432752e3..183a76bf24b7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,6 +10,7 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
+#include <linux/rcupdate.h>
 
 struct bio_set;
 struct bio;
@@ -233,7 +234,10 @@ struct bio {
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
-	struct bvec_iter	bi_iter;
+	union {
+		struct bvec_iter	bi_iter;
+		struct rcu_head		bi_rcu_free;
+	};
 
 	bio_end_io_t		*bi_end_io;
 
-- 
2.30.1

