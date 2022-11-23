Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4E635028
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiKWGN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiKWGNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:25 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B6E8714
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:22 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221123061318epoutp020faa7b4b1e8f2e0080a37dbada05dbe7~qIgDSr4hg1661416614epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221123061318epoutp020faa7b4b1e8f2e0080a37dbada05dbe7~qIgDSr4hg1661416614epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669183998;
        bh=1tZws8Hb1eFN18ZJBmssPvEBmaBiDwVui9GYaRE9iO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mm/77p9x2UdmqmyZqjmQaZRWYXwjvL8L2mbt4LFwP1eXlvvWjLKfR/ggiu3oXLgb7
         2utx3a7Eox/30VhgRJtbuBxskvcRTE3k8rzLvsCv/R1X89O7hdes+LJUMZnBoE2czf
         UaqZhLUAXucMIhS2RjzTSuZMWVNA2Fw42SW5L+i8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221123061318epcas5p30a403cecbd22a8ef3969d1c68319a0ed~qIgCjTag_1162411624epcas5p3f;
        Wed, 23 Nov 2022 06:13:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NH9mD35f2z4x9Pt; Wed, 23 Nov
        2022 06:13:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.30.39477.CF9BD736; Wed, 23 Nov 2022 15:13:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123061017epcas5p246a589e20eac655ac340cfda6028ff35~qIdaetnlR1320613206epcas5p2s;
        Wed, 23 Nov 2022 06:10:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123061017epsmtrp20611c43eb55ee051bbf76ef63dee122f~qIdabu9J-0451404514epsmtrp2-;
        Wed, 23 Nov 2022 06:10:17 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-2b-637db9fc3898
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.0B.14392.949BD736; Wed, 23 Nov 2022 15:10:17 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061014epsmtip1e54b0e13ca838fc29c950958d0e1fe6e~qIdXddRF62063320633epsmtip19;
        Wed, 23 Nov 2022 06:10:14 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v5 02/10] block: Add copy offload support infrastructure
Date:   Wed, 23 Nov 2022 11:28:19 +0530
Message-Id: <20221123055827.26996-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0ybZRTO+33la4tj+VZwvHSbdtUlAgLtBvUFwZE5yOfmheCyBP5Abb+U
        jtLWtji3qLABKixcxV2KctkGQnHgGGCBFRl3ECTAQMEgw7TEjJWrESdl2NKi+3fOc57nnPOc
        Ny8L5+QwuSy5UkdrlGIFn3BnNHf5+gbYWj6WCCbHvFD9YC+OLhZs4qh2Jp9AG8MjODItlrih
        qY4WDNXU9mCorWIFQz1bVgLN/TnNQEWdkwBZJvQYMk37o7umAQYab/2KQGVVFiYq7Lvjhozm
        CwA1b5ThaK0yk4nqFpYYqH96HxrZ7HOL9Kb0s8ME1aKfYVIjv91mUOPDqVSDIZug7txMo9qm
        0gkqN2PRTsiadaOW2icIKq/RAKi1hueozzouYVSD2YrF7I5PDk+ixVJaw6OVEpVUrpRF8E++
        m/B6QohIIAwQhqJX+DylOIWO4B9/MyYgWq6w++fzPhArUu1QjFir5Qe9Fq5RpepoXpJKq4vg
        02qpQh2sDtSKU7SpSlmgktaFCQWCwyF2YmJyknH9FlNdmfZhb9MQMx3Uy3IAmwXJYFg4/j2W
        A9xZHLINwHVDNdOZrAI4c7EIOJO/AOz63UrsSB6PWghnwQTglNmKO5MsDA79NG+vsFgE6Q9/
        3GI5cC8yD4Oft3Vsk3CyBIPWKhvT0cqTpOD8Vh3DIWCQh2DmhNoBe5BhsDfnH+CAIRkE82f3
        OGA2+SocGm3FnJQ9cOCameGIcfJ5mNFUst0ekiVsuFBsZTo3PQ7Xl7IwZ+wJH/Y1unAuXFs0
        udychTXF1YRTnAmg/mc9cBaOwqzBfNyxBE76wvrWICd8AH45WIc5B++GuRtmV38PaCzdiV+A
        39aXu/r7wMn1C66YgveXK10nzQPQ0luIFQCe/ilD+qcM6f8fXQ5wA/Ch1doUGa0NUR9W0mf/
        e2aJKqUBbH8KvxNGMPdgObATYCzQCSAL53t5pL3xkYTjIRWfO09rVAmaVAWt7QQh9nsX4txn
        JSr7r1LqEoTBoYJgkUgUHHpEJOR7e9y46ifhkDKxjk6maTWt2dFhLDY3HYvublyNdPt0Bgsr
        rRyrWK6e6YpI9A+SL9heku1/67vyugfsT2xjAxkKWjHP7mw2xJ/pvXntlE/RgWPCdpP07aVT
        NQMTt+SqvU0ZEos5pztqjssZqj32JL+KKf6BUxi7cu+b3PhfIv5ozz66K44e5XpLA67kccMv
        eRljj8SN3q+QKdm7sjl/u8fEZmfnZjyMr/ac8psvSCiNO3g6MrJurz7/fOOjaM/Vu2f63unR
        VHQUnw7zrVLA2hv9Gy++P2XiVVuSer42Tj6ir15+8syVXxeub77MPuR74nbXF/2Cftvm/igb
        3NfdmMc8eC7rMTYsP7kcha10XzZssRWiMuGl967fS2zmM7RJYqEfrtGK/wWgefYHnQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRzGec85nh0F47RMX7Uboww1rYnBm+ue1fFLSRFSGTbnaUrbGpur
        nKZTk2qiVlDYlqmRirMSZ9psmrrMS2mmy8iBSqBFipdyIeVlOS3o2/P//Z7n05/CuS8JHypB
        lsgqZEIJj3Qjal/x1gVF1F0RbevXeaPKN604yrg5j6OKgTwSzXZ146hhQu+C+pvqMFRe8RpD
        5uLvGHrtGCfRZ7uNQLctHwEa6dNhqMEWiOobOghkfXGfRIWlIxx0q63aBZmG0wGqnS3E0XTJ
        VQ56OjZJoHabL+qeb3PZ68XohrpIpk43wGG6B6sIxtqlYoyGGyRT/SiNMfdrSCYnc2KxkDXk
        wky+7COZ3GcGwEwb1zHXmrIxxjg8jkWuOOW2M46VJFxkFVt3n3WLN8084chL0i631nRyNKBS
        rAWuFKRD4a+eEVIL3CgubQbQ+HMaXxbesHS+5W9eBcsXvnKWS5kYzHpQQGgBRZF0IHzroJzc
        gy7CoHVwFHceOF2CQf2HAdK5XkUz8Ivj6dKAoDfBq31yJ3anw2Cr9jdwYkhvhXlDK53YlRbA
        zp4XmBNzFyv1pVuW2ythx71hwplxej3MrNHjNwGt+0/p/lNFADMAb1aulIqlSr6cL2MvBSuF
        UqVKJg4WXZAawdKLA/xN4LlhKtgCMApYAKRwnod7WkSKiOseJ0xSs4oLMQqVhFVagC9F8Lzc
        32s7Yri0WJjInmdZOav4ZzHK1UeD5Z2KkNoFqkslc+c8Y6K7fWUb9C0xXv5+F0V2PpGwO1Fa
        8CDlu7fmeEOItTRzl+zn/JHiGX71Mf/kMLM+1NpbjcVJ03kE3y+1XTQ+Hnsg6kh7W2py1GN9
        RP1cJC1J0oZq5+Jta8zlD332RI9I7qzuavbcuD934rQda3EUnDl87ropK/96PmPrnbJFqU48
        KbvbIvkhyjeACnXjClWkx7fw5NmJe/30es9ec+xUtkfxK5txYUeeifLdvq9zn67AbA8XOAQZ
        j9W570Zztl8JGd6cfmjHwWZHvNykboylPpWpoCZMkCpoRgHZiLDcGawqPFl249DRR4FjGxPW
        BuGbeIQyXsgPwBVK4R9lADCfUQMAAA==
X-CMS-MailID: 20221123061017epcas5p246a589e20eac655ac340cfda6028ff35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061017epcas5p246a589e20eac655ac340cfda6028ff35
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blkdev_issue_copy which supports source and destination bdevs,
and an array of (source, destination and copy length) tuples.
Introduce REQ_COPY copy offload operation flag. Create a read-write
bio pair with a token as payload and submitted to the device in order.
Read request populates token with source specific information which
is then passed with write request.
This design is courtesy Mikulas Patocka's token based copy

Larger copy will be divided, based on max_copy_sectors limit.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c           | 358 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   2 +
 include/linux/blk_types.h |  44 +++++
 include/linux/blkdev.h    |   3 +
 include/uapi/linux/fs.h   |  15 ++
 5 files changed, 422 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..2ce3c872ca49 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,364 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to make it through
+ * bio_copy_*_write_end_io. IO errors are propagated through cio->io_error.
+ */
+static int cio_await_completion(struct cio *cio)
+{
+	int ret = 0;
+
+	atomic_dec(&cio->refcount);
+
+	if (cio->endio)
+		return 0;
+
+	if (atomic_read(&cio->refcount)) {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		blk_io_schedule();
+	}
+
+	ret = cio->io_err;
+	kfree(cio);
+
+	return ret;
+}
+
+static void blk_copy_offload_write_end_io(struct bio *bio)
+{
+	struct copy_ctx *ctx = bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+
+	if (bio->bi_status) {
+		cio->io_err = blk_status_to_errno(bio->bi_status);
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+			cio->ranges[ri].dst;
+		cio->ranges[ri].comp_len = min_t(sector_t, clen,
+				cio->ranges[ri].comp_len);
+	}
+	__free_page(bio->bi_io_vec[0].bv_page);
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&ctx->refcount))
+		kfree(ctx);
+	if (atomic_dec_and_test(&cio->refcount)) {
+		if (cio->endio) {
+			cio->endio(cio->private, cio->io_err);
+			kfree(cio);
+		} else
+			blk_wake_io_task(cio->waiter);
+	}
+}
+
+static void blk_copy_offload_read_end_io(struct bio *read_bio)
+{
+	struct copy_ctx *ctx = read_bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+	unsigned long flags;
+
+	if (read_bio->bi_status) {
+		cio->io_err = blk_status_to_errno(read_bio->bi_status);
+		goto err_rw_bio;
+	}
+
+	/* For zoned device, we check if completed bio is first entry in linked
+	 * list,
+	 * if yes, we start the worker to submit write bios.
+	 * if not, then we just update status of bio in ctx,
+	 * once the worker gets scheduled, it will submit writes for all
+	 * the consecutive REQ_COPY_READ_COMPLETE bios.
+	 */
+	if (bdev_is_zoned(ctx->write_bio->bi_bdev)) {
+		spin_lock_irqsave(&cio->list_lock, flags);
+		ctx->status = REQ_COPY_READ_COMPLETE;
+		if (ctx == list_first_entry(&cio->list,
+					struct copy_ctx, list)) {
+			spin_unlock_irqrestore(&cio->list_lock, flags);
+			schedule_work(&ctx->dispatch_work);
+			goto free_read_bio;
+		}
+		spin_unlock_irqrestore(&cio->list_lock, flags);
+	} else
+		schedule_work(&ctx->dispatch_work);
+
+free_read_bio:
+	bio_put(read_bio);
+
+	return;
+
+err_rw_bio:
+	clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+					cio->ranges[ri].src;
+	cio->ranges[ri].comp_len = min_t(sector_t, clen,
+					cio->ranges[ri].comp_len);
+	__free_page(read_bio->bi_io_vec[0].bv_page);
+	bio_put(ctx->write_bio);
+	bio_put(read_bio);
+	if (atomic_dec_and_test(&ctx->refcount))
+		kfree(ctx);
+	if (atomic_dec_and_test(&cio->refcount)) {
+		if (cio->endio) {
+			cio->endio(cio->private, cio->io_err);
+			kfree(cio);
+		} else
+			blk_wake_io_task(cio->waiter);
+	}
+}
+
+static void blk_copy_dispatch_work_fn(struct work_struct *work)
+{
+	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
+			dispatch_work);
+
+	submit_bio(ctx->write_bio);
+}
+
+static void blk_zoned_copy_dispatch_work_fn(struct work_struct *work)
+{
+	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
+			dispatch_work);
+	struct cio *cio = ctx->cio;
+	unsigned long flags = 0;
+
+	atomic_inc(&cio->refcount);
+	spin_lock_irqsave(&cio->list_lock, flags);
+
+	while (!list_empty(&cio->list)) {
+		ctx = list_first_entry(&cio->list, struct copy_ctx, list);
+
+		if (ctx->status == REQ_COPY_READ_PROGRESS)
+			break;
+
+		atomic_inc(&ctx->refcount);
+		ctx->status = REQ_COPY_WRITE_PROGRESS;
+		spin_unlock_irqrestore(&cio->list_lock, flags);
+		submit_bio(ctx->write_bio);
+		spin_lock_irqsave(&cio->list_lock, flags);
+
+		list_del(&ctx->list);
+		if (atomic_dec_and_test(&ctx->refcount))
+			kfree(ctx);
+	}
+
+	spin_unlock_irqrestore(&cio->list_lock, flags);
+	if (atomic_dec_and_test(&cio->refcount))
+		blk_wake_io_task(cio->waiter);
+}
+
+/*
+ * blk_copy_offload	- Use device's native copy offload feature.
+ * we perform copy operation by sending 2 bio.
+ * 1. First we send a read bio with REQ_COPY flag along with a token and source
+ * and length. Once read bio reaches driver layer, device driver adds all the
+ * source info to token and does a fake completion.
+ * 2. Once read opration completes, we issue write with REQ_COPY flag with same
+ * token. In driver layer, token info is used to form a copy offload command.
+ *
+ * For conventional devices we submit write bio independentenly once read
+ * completes. For zoned devices , reads can complete out of order, so we
+ * maintain a linked list and submit writes in the order, reads are submitted.
+ */
+static int blk_copy_offload(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *ranges,
+		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct cio *cio;
+	struct copy_ctx *ctx;
+	struct bio *read_bio, *write_bio;
+	struct page *token;
+	sector_t src_blk, copy_len, dst_blk;
+	sector_t rem, max_copy_len;
+	int ri = 0, ret = 0;
+	unsigned long flags;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	cio->ranges = ranges;
+	atomic_set(&cio->refcount, 1);
+	cio->waiter = current;
+	cio->endio = end_io;
+	cio->private = private;
+	if (bdev_is_zoned(dst_bdev)) {
+		INIT_LIST_HEAD(&cio->list);
+		spin_lock_init(&cio->list_lock);
+	}
+
+	max_copy_len = min(bdev_max_copy_sectors(src_bdev),
+			bdev_max_copy_sectors(dst_bdev)) << SECTOR_SHIFT;
+
+	for (ri = 0; ri < nr; ri++) {
+		cio->ranges[ri].comp_len = ranges[ri].len;
+		src_blk = ranges[ri].src;
+		dst_blk = ranges[ri].dst;
+		for (rem = ranges[ri].len; rem > 0; rem -= copy_len) {
+			copy_len = min(rem, max_copy_len);
+
+			token = alloc_page(gfp_mask);
+			if (unlikely(!token)) {
+				ret = -ENOMEM;
+				goto err_token;
+			}
+
+			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_ctx;
+			}
+			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY
+					| REQ_SYNC | REQ_NOMERGE, gfp_mask);
+			if (!read_bio) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE
+					| REQ_COPY | REQ_SYNC | REQ_NOMERGE,
+					gfp_mask);
+			if (!write_bio) {
+				cio->io_err = -ENOMEM;
+				goto err_write_bio;
+			}
+
+			ctx->cio = cio;
+			ctx->range_idx = ri;
+			ctx->write_bio = write_bio;
+			atomic_set(&ctx->refcount, 1);
+
+			if (bdev_is_zoned(dst_bdev)) {
+				INIT_WORK(&ctx->dispatch_work,
+					blk_zoned_copy_dispatch_work_fn);
+				INIT_LIST_HEAD(&ctx->list);
+				spin_lock_irqsave(&cio->list_lock, flags);
+				ctx->status = REQ_COPY_READ_PROGRESS;
+				list_add_tail(&ctx->list, &cio->list);
+				spin_unlock_irqrestore(&cio->list_lock, flags);
+			} else
+				INIT_WORK(&ctx->dispatch_work,
+					blk_copy_dispatch_work_fn);
+
+			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+			read_bio->bi_iter.bi_size = copy_len;
+			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
+			read_bio->bi_end_io = blk_copy_offload_read_end_io;
+			read_bio->bi_private = ctx;
+
+			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
+			write_bio->bi_iter.bi_size = copy_len;
+			write_bio->bi_end_io = blk_copy_offload_write_end_io;
+			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
+			write_bio->bi_private = ctx;
+
+			atomic_inc(&cio->refcount);
+			submit_bio(read_bio);
+			src_blk += copy_len;
+			dst_blk += copy_len;
+		}
+	}
+
+	/* Wait for completion of all IO's*/
+	return cio_await_completion(cio);
+
+err_write_bio:
+	bio_put(read_bio);
+err_read_bio:
+	kfree(ctx);
+err_ctx:
+	__free_page(token);
+err_token:
+	ranges[ri].comp_len = min_t(sector_t,
+			ranges[ri].comp_len, (ranges[ri].len - rem));
+
+	cio->io_err = ret;
+	return cio_await_completion(cio);
+}
+
+static inline int blk_copy_sanity_check(struct block_device *src_bdev,
+	struct block_device *dst_bdev, struct range_entry *ranges, int nr)
+{
+	unsigned int align_mask = max(bdev_logical_block_size(dst_bdev),
+					bdev_logical_block_size(src_bdev)) - 1;
+	sector_t len = 0;
+	int i;
+
+	if (!nr)
+		return -EINVAL;
+
+	if (nr >= MAX_COPY_NR_RANGE)
+		return -EINVAL;
+
+	if (bdev_read_only(dst_bdev))
+		return -EPERM;
+
+	for (i = 0; i < nr; i++) {
+		if (!ranges[i].len)
+			return -EINVAL;
+
+		len += ranges[i].len;
+		if ((ranges[i].dst & align_mask) ||
+				(ranges[i].src & align_mask) ||
+				(ranges[i].len & align_mask))
+			return -EINVAL;
+		ranges[i].comp_len = 0;
+	}
+
+	if (len && len >= MAX_COPY_TOTAL_LENGTH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline bool blk_check_copy_offload(struct request_queue *src_q,
+		struct request_queue *dst_q)
+{
+	return blk_queue_copy(dst_q) && blk_queue_copy(src_q);
+}
+
+/*
+ * blkdev_issue_copy - queue a copy
+ * @src_bdev:	source block device
+ * @dst_bdev:	destination block device
+ * @ranges:	array of source/dest/len,
+ *		ranges are expected to be allocated/freed by caller
+ * @nr:		number of source ranges to copy
+ * @end_io:	end_io function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	end_io function will be called with this private data, should be
+ *		NULL, if operation is synchronous in nature
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *	Copy source ranges from source block device to destination block
+ *	device. length of a source range cannot be zero. Max total length of
+ *	copy is limited to MAX_COPY_TOTAL_LENGTH and also maximum number of
+ *	entries is limited to MAX_COPY_NR_RANGE
+ */
+int blkdev_issue_copy(struct block_device *src_bdev,
+	struct block_device *dst_bdev, struct range_entry *ranges, int nr,
+	cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *src_q = bdev_get_queue(src_bdev);
+	struct request_queue *dst_q = bdev_get_queue(dst_bdev);
+	int ret = -EINVAL;
+
+	ret = blk_copy_sanity_check(src_bdev, dst_bdev, ranges, nr);
+	if (ret)
+		return ret;
+
+	if (blk_check_copy_offload(src_q, dst_q))
+		ret = blk_copy_offload(src_bdev, dst_bdev, ranges, nr,
+				end_io, private, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_issue_copy);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk.h b/block/blk.h
index 5929559acd71..6d534047f20d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -308,6 +308,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e0b098089ef2..71278c862bba 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -422,6 +422,7 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	__REQ_COPY,		/* copy request */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -451,6 +452,7 @@ enum req_flag_bits {
 
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
+#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -484,6 +486,11 @@ static inline bool op_is_write(blk_opf_t op)
 	return !!(op & (__force blk_opf_t)1);
 }
 
+static inline bool op_is_copy(blk_opf_t op)
+{
+	return (op & REQ_COPY);
+}
+
 /*
  * Check if the bio or request is one that needs special treatment in the
  * flush state machine.
@@ -543,4 +550,41 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+typedef void (cio_iodone_t)(void *private, int status);
+
+struct cio {
+	struct range_entry *ranges;
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+	atomic_t refcount;
+	int io_err;
+	cio_iodone_t *endio;		/* applicable for async operation */
+	void *private;			/* applicable for async operation */
+
+	/* For zoned device we maintain a linked list of IO submissions.
+	 * This is to make sure we maintain the order of submissions.
+	 * Otherwise some reads completing out of order, will submit writes not
+	 * aligned with zone write pointer.
+	 */
+	struct list_head list;
+	spinlock_t list_lock;
+};
+
+enum copy_io_status {
+	REQ_COPY_READ_PROGRESS,
+	REQ_COPY_READ_COMPLETE,
+	REQ_COPY_WRITE_PROGRESS,
+};
+
+struct copy_ctx {
+	struct cio *cio;
+	struct work_struct dispatch_work;
+	struct bio *write_bio;
+	atomic_t refcount;
+	int range_idx;			/* used in error/partial completion */
+
+	/* For zoned device linked list is maintained. Along with state of IO */
+	struct list_head list;
+	enum copy_io_status status;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3ac324208f2f..a3b12ad42ed7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1065,6 +1065,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_issue_copy(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *ranges,
+		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b3ad173f619c..9248b6d259de 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -67,6 +67,21 @@ struct fstrim_range {
 /* maximum total copy length */
 #define MAX_COPY_TOTAL_LENGTH	(1 << 27)
 
+/* Maximum no of entries supported */
+#define MAX_COPY_NR_RANGE	(1 << 12)
+
+/* range entry for copy offload, all fields should be byte addressed */
+struct range_entry {
+	__u64 src;		/* source to be copied */
+	__u64 dst;		/* destination */
+	__u64 len;		/* length in bytes to be copied */
+
+	/* length of data copy actually completed. This will be filled by
+	 * kernel, once copy completes
+	 */
+	__u64 comp_len;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

