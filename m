Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBFA66734F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjALNhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjALNhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:37:14 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CD639FA6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:12 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230112133711epoutp0463e4cde3ec9a3d6ee4afe3413584cd34~5kz4LCmmd3145031450epoutp04D
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230112133711epoutp0463e4cde3ec9a3d6ee4afe3413584cd34~5kz4LCmmd3145031450epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530631;
        bh=V58rfq97JuSvwF86hkYEZ4/1VpPRrr5x2/bdR0eeSHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gy5vlXhM+hz2KD0bZpLk/3yzOnKQ1250/OGgjjneiVU+okk4iRGoRffNlvEWq3tg7
         KXom6IgoPHdk87lYzGlYof/yW+0aot6UxPUeZG/tFyEv/GdZOOqDwzRZkZVtfVhAtK
         ts/aBxVArasb32e8YYgt1SVeIf2RdxFezbQUmQVM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230112133710epcas5p257f267d68794389c2d1b01423de7ba15~5kz3U20ol2066520665epcas5p2K;
        Thu, 12 Jan 2023 13:37:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nt5FJ4fmpz4x9Pw; Thu, 12 Jan
        2023 13:37:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.6D.62806.40D00C36; Thu, 12 Jan 2023 22:37:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230112120039epcas5p49ccf70d806c530c8228130cc25737b51~5jflyKk9_2230422304epcas5p4n;
        Thu, 12 Jan 2023 12:00:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112120039epsmtrp2be8ddd51c8a1847c41530819b85679b1~5jflxLbWW3008130081epsmtrp2I;
        Thu, 12 Jan 2023 12:00:39 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-b1-63c00d042cbb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.A5.02211.666FFB36; Thu, 12 Jan 2023 21:00:38 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120036epsmtip221869583c809c8cf44bce7fffa4a1ac7~5jfjHqcvT0888908889epsmtip2a;
        Thu, 12 Jan 2023 12:00:36 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 2/9] block: Add copy offload support infrastructure
Date:   Thu, 12 Jan 2023 17:28:56 +0530
Message-Id: <20230112115908.23662-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxjl7obNQhtZEcYLtkoXmQ44QKIhXagIHVF3aqdDR35oK4ZtWIGS
        bDJ5iHVKQR4jYhVpwRmDvBzwAUhaJEx4pEJaykMpg4g2KEVamE61iVQY1FJKExJa/53v3PM9
        znfvxVFfOxaIZ3BaVs0xchLz5rV9FxoWzhN0y4SmX96gDIM/oFTe2SWUapwowSizvcKTsna3
        I9TVxl6E6qz9E6F6l20Y9aXlLqBmxvQIZR7fQnWZB3jUaMcFjKq+NMOnTNPHAdW2WI1Sc/UF
        fKr58RMe1T++gRpe6vOM96P1k0MY3a6f4NPDP3/Do0eHdHRLw0mMvl6XQ3daczH6dL4do598
        O4bRZ1obAD3XspFumbYhia9+mLk9nWVSWXUQy8mUqRlcWiy5d590pzRKIhSFi6Kpt8ggjlGw
        sWTCe4nhuzPkDptk0BFGrnNQiYxGQ0bu2K5W6rRsULpSo40lWVWqXCVWRWgYhUbHpUVwrDZG
        JBRujXIIUzLTi3ouIqr6nKP3TswiucCQVgy8cEiIYdFiPVIMvHFfohPAAvOiO3jqCJ4/cgcL
        APYVl4DVlJHvyzEn9iXMAN434S5RPgJv1S3xiwGOY8QWeHMZd2r8iAcIbL8Z7NSgRAUC+21T
        ns6DdcRuaL1YuYJ5RAhc+rqd58QCIgaWD9hW6kAiEpZMrnXSXsTbsOmnebdkLRw4P72CUWIT
        zDdWoM76kFjG4bmRBZ5r0ARYf+oF5sLr4KO+Vr4LB8I5u9nNZ8GrZVcwV3IBgPp7erfLOFg4
        WII6h0CJUGjoiHTRr8PywWbE1XgNPL04jbh4ATRVreJg2GSocdcPgHefHcdcXmjYWMlz7e0M
        gPbbkWdBkP4lO/qX7Oj/b1wD0AYQwKo0ijRWE6XayrFZ/92xTKloASsPP+xdE5h6OBthAQgO
        LADiKOkn6Oq9IfMVpDKfHmPVSqlaJ2c1FhDlWHcpGugvUzp+DqeVisTRQrFEIhFHb5OIyPUC
        1lgt8yXSGC2bybIqVr2ah+BegblI8sdC2V+Gg2teKMZtO1lL9vyujXHoH4Pcjtpr8WNteerS
        GOK1yMoDaEi4T9+GPac+vzxfWLWnUD6x+dD6kQdZfzfXvfIjqZduHs1p7Q7t7/JqFHeGDGT5
        T4WlxNtPlvVwhw4myj3Un5w4Pz9269dJy+Fj244mBCyilvHk0ejDvXE+s8klVv1n089tdzJN
        fU+l7VU3ZiT9nudymSveHrXNeffTjyR1CD00vwXX5HLDPtk1zwKl4xnDb6qsQ7ebeu4o/vG6
        3ORfl2J+32o8kMS/vilbV1bqIXlH1GYILbs2FGFMapqAvxttXyUzwoWH+79ofWwENR/tz8xr
        DPigt6IobF/5JZKnSWdEYahaw/wLQJ7G44EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvG7at/3JBg9umFusP3WM2aJpwl9m
        i9V3+9ks9r6bzWpx88BOJouVq48yWexe+JHJ4uj/t2wWkw5dY7R4enUWk8XeW9oWe/aeZLG4
        vGsOm8X8ZU/ZLXY8aWS02PZ7PrPF56Ut7BbrXr9nsThxS9ri/N/jrA4iHrPun2Xz2DnrLrvH
        +XsbWTwuny312LSqk81j85J6j903G9g8epvfsXm833eVzaNvyypGj8+b5Dw2PXnLFMATxWWT
        kpqTWZZapG+XwJXRcXARU8HS+orr7R+YGhjXp3cxcnJICJhIXDwyla2LkYtDSGA3o0Rrx35W
        iISkxLK/R5ghbGGJlf+es0MUNTJJzH2wg6WLkYODTUBb4vR/DpC4iMAzJomz9x4xgzjMAkuZ
        JBbsawSbJCzgJnFz0Vwwm0VAVeLvhp0sIDavgJXE1JNv2UEGSQjoS/TfFwQJcwpYS6y58QWs
        RAioZNaeq0wQ5YISJ2c+AYszC8hLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGC41JLcwfj9lUf9A4xMnEwHmKU4GBWEuHdc3R/shBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1Met+mtAmsFVNYvbSCaYKWtMyd
        uXM5lRqrf9s1Bznxz/QpEf8e5q6u8pPvnaWvCK8tk44hP08lS6nF2pprQes1N5SnF1Xncv97
        KCAfVyzt6ywiccKmQqnQ89fpKzyqu6Nfmq+6+DL66teYc1abXnq4d/yftHX566Ztq+LWJb+5
        IrOSY0/p874srqV7cgXvnYkTP6v40Dt8xr5gS94zue2M9YmH/t7bq7ZlM+/Kt9+cGt48/vey
        aX5V9JQz3boLmv+dXSWWx/AlzsV5ovX6c9me9murpFR+CZtd/yt5kGnvOv+YqWtiVt41eLri
        u3it6yTPuEvvbfpN+lWFxdi/L5701lPE8eEU0Q7vw62TIruUWIozEg21mIuKEwECdCPAOgMA
        AA==
X-CMS-MailID: 20230112120039epcas5p49ccf70d806c530c8228130cc25737b51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120039epcas5p49ccf70d806c530c8228130cc25737b51
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120039epcas5p49ccf70d806c530c8228130cc25737b51@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 4c3b3325219a..6d9924a7d559 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -304,6 +304,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..de1638c87ecf 100644
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
@@ -477,6 +479,11 @@ static inline bool op_is_write(blk_opf_t op)
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
@@ -536,4 +543,41 @@ struct blk_rq_stat {
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
index 807ffb5f715d..48e9160b7195 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1063,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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

