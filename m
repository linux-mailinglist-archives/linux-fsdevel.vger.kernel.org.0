Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883FD6CD43E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjC2IQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjC2IQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:16:16 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202EF4697
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:16:08 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230329081606epoutp01f311bc3b0c3f3d418ce4fec26e3a7bbd~Q1dPBlruL1316713167epoutp01h
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:16:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230329081606epoutp01f311bc3b0c3f3d418ce4fec26e3a7bbd~Q1dPBlruL1316713167epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680077766;
        bh=S/AESpOblqaglCp0pwrLwPKzeuihkrjZZs90eduqZX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfZPa1G1poSkhrXhJeYAoz8yX+DERZO6k6+F+IwBAmeMiHqNFum74zg3ptojasqeR
         JyC+5LKG5FHIbqkuwZrPMkLsSTC2Rj8UGh/czY0SRnJnMGpQjG/yPGEfQZ6ps1t/Lq
         w4UiVs3x6hMXDVRF3u7CXG2nz3EKKpEAOdEyFOJM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230329081605epcas5p42a743f8306957971e642e6df25dfe8b3~Q1dOYEUoY0856608566epcas5p4Q;
        Wed, 29 Mar 2023 08:16:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PmfWm0jcSz4x9Px; Wed, 29 Mar
        2023 08:16:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.FF.06765.3C3F3246; Wed, 29 Mar 2023 17:16:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230327084226epcas5p28e667b25cbb5e4b0e884aa2ca89cbfff~QOhpuUFL-2983129831epcas5p2K;
        Mon, 27 Mar 2023 08:42:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230327084226epsmtrp158fd5a02f82d941bca7d3593b5824a0b~QOhptJug73087530875epsmtrp1s;
        Mon, 27 Mar 2023 08:42:26 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-ac-6423f3c342ae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.C5.31821.1F651246; Mon, 27 Mar 2023 17:42:26 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084222epsmtip1ce77c8d1469b570810959246667d4d05~QOhmVZrxS3003330033epsmtip1i;
        Mon, 27 Mar 2023 08:42:22 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 2/9] block: Add copy offload support infrastructure
Date:   Mon, 27 Mar 2023 14:10:50 +0530
Message-Id: <20230327084103.21601-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230327084103.21601-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbZRjGc87pDRLYgQ39YDrIWRgDhLYC9SvCZBHmMTDDnGbLjIGmPbaE
        3ugp4+YiA2FsGZfhAFdw6CQYQEHuhdIpFMpgYdynYAaI1GVDYAOVmQ61tKD77/e+7/PkvXz5
        OJj7FbYXJ0mppTRKkZxgOTM6TP6Hg/o3Dkp4t8/ApmEzBnNKtjDYcK+YBZdN6wgsf/QXBq0j
        oxg0rlYy4cz3XSjsuVGKwrqGARQavniMwoF/VliwtO8uAi3TOhQaZwNhj3GIASe7q1iwutbC
        hn2f5KJQv3QegR3Wagw2Lq8x4K3Z/XB0a5AZBcjJqVhSNz/CIrt099jk6Fwzg5wcSSVb6i+y
        yNaaj0jDTDaLLMxdtQny5pnk2s1pFlnUVo+QrbezyI2WA2TL0goav+dMcoSMEkkojQ+lFKsk
        SUppJBF7MuH1hDABjx/EF8JXCB+lSEFFEtFx8UHHkuS2MxA+Z0XyVFsqXkTTBPdIhEaVqqV8
        ZCpaG0lQaolcHaoOpkUKOlUpDVZS2nA+j/dymE2YmCz76kEhW/30VPp41XksG5l74xLixAF4
        KFgrfIpdQpw57rgBAR+bLzAcwToCruv1bEewgYBrtZcZu5bWsss7qm4ElJuLEEeQi4KZ32aY
        2yoW7gf67+fZC/vwfAw8tly0WzB8AQXVOTW2CoezFz8GvvlFvG1g4L7AnH/f3sIFF4LlijV0
        WwJwLiied9tOO+HhoEo/zHRI3MDQtSW7HMO9QW57pX0JgDc4gemCMaZj1GhQalpgOXgveDjY
        xnawF3hQnL/DUvBk0oI6WA1yzTcRB78G8oaLse0ZMNwfNHVzHekXQdlwI+ro6woKrUs7Vheg
        v77LBLhQV7XDABjvZO8wCTo2J3ZOWoiA/rZydgnio3tmH90z++j+b/05gtUjnpSaVkgpOkwd
        oqTS/ntmsUrRgtj/RkCsHllceBTch6AcpA8BHIzY52K9S0jcXSSijExKo0rQpMopug8Js937
        CublIVbZPpdSm8APFfJCBQJBqDBEwCeed/GLHBK741KRlkqmKDWl2fWhHCevbNRDvegX49zf
        HHjO4HsqoHd/V9OqtYfHi62Ibk9/4dd2Drcz4kZgadwhusRboj/hlvh2eEFaTNxPvv5Wlun9
        lEVDY3rQQNQtjx8Ff9RYRq7WSsL+bg6qFzYQAa+enn2zKaU3z1CR3NsZKOr94a2N9+a4DzN/
        f+6Q+YPyxKkQ04T8u4yKgZyGw8fvEE88g1NrhByFTP/z5rtXzeNDB8pkJzOsRGbOpm7cdDrt
        z7rBT79W+Gd56qbcjWSnZdZT6r0ZeaLuaAPlajn6zpLrHiO3+HjM1tkV76j1suwjLu1jZd8m
        ekrDCTpzbCLfcM4pZf6lqBVXvfOHleLCLwtUn2UV5bQLpOkEg5aJ+AGYhhb9Cxl5cTmkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTcRTH+917d3ddqNdp9StDc/RimmWF/YqS6GE/EnuagVC69OZzOrfU
        HlTaUkkyh1PDbWBZWE4z3Ep89tjK1DAtNdBwo1SsZGpGZdjLKYH/nXM+n+/hwGFIYQu1hIlN
        PMXJEyUJIlpA1ZhFHmsmQr2i1k12A3S/rZlEl1S/SVTRn0ejEfMEQEXjP0k01d5BoqZRLQ/1
        PqkjUGNpPoHKK54TqOHmFwI9/2ujUb7pLUBDPRoCNfV5o8amVgp11etoVFI2xEcmtZJAtYMZ
        ANVMlZCoamSMQi197qjj9wvedoi7uoOwxtpO4zpNPx93WKop3NWegg36KzQ23r6IG3rTaZyr
        HJ0WMq08PPaoh8bXHugBNr48h78aPLBh0EYccA4TbI3iEmJTOfnagAhBzJ1PuXzZr6OnX+sy
        yHRg2ZMDHBjIboTGwqtUDhAwQrYWwE7bV94sgLDtUxmYrV1h+Z9h/qyUQcC/VZl8O6DZVfDZ
        cCawAzdWRcI31nTa3pDsKAH178umVzGMKxsI7w1E2gMUuwI2Zw1T9tqR3QxHro8RdgWya2Ge
        1cU+dmC3QF1t28wRwmklL7uemNVdYGvx4EyUZD2h8qGWVAFWMwdp5qAbgNCDxZxMIY2WKvxk
        6xO5NF+FRKpISYz2jUySGsDMs8XiWtCoH/c1AYIBJgAZUuTmaAzyihI6RknOnOXkSeHylARO
        YQLuDCVa5NiZ0xouZKMlp7h4jpNx8v+UYByWpBMPAy90ZjvtfyzsO276Hhbsn3xQVR4XMWo+
        vI/6jvY67SweEmTuCDhUWlCpi9hA31h6M7T6yM4V7vu9fd4FH1M7LVCvY8lfsfvC1bIsUmvs
        5/uH3F0+JB4YXvRssXcqLzQ+lczvuVq118/fdsEy79EU5l6GdfMzCup9GqTXV8tMJUWRLU/V
        CwbqPNShytw4lyJV8Daf5ObPBZULjXd/vPNzPuEZ4/zNXN1mQIWTpebx3UktV7TFSSG+aQdt
        dKsHscvy6jxOszbeUsT3fDgyv+byppOioA2Tkw3ZgpU7zu1eE/PCZ5ln4JY/Jw4nfzRfTM4K
        fPKTr1O6WlJdr8kqn+J+sYhSxEj8xKRcIfkH4ykxpFsDAAA=
X-CMS-MailID: 20230327084226epcas5p28e667b25cbb5e4b0e884aa2ca89cbfff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084226epcas5p28e667b25cbb5e4b0e884aa2ca89cbfff
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084226epcas5p28e667b25cbb5e4b0e884aa2ca89cbfff@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

Introduce blkdev_issue_copy which takes similar arguments as
copy_file_range and performs copy offload between two bdevs.
Introduce REQ_COPY copy offload operation flag. Create a read-write
bio pair with a token as payload and submitted to the device in order.
Read request populates token with source specific information which
is then passed with write request.
This design is courtesy Mikulas Patocka's token based copy

Larger copy will be divided, based on max_copy_sectors limit.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c           | 236 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   2 +
 include/linux/blk_types.h |  25 ++++
 include/linux/blkdev.h    |   3 +
 4 files changed, 266 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..cbc6882d1e7a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,242 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
+	if (cio->endio)
+		return 0;
+
+	if (atomic_read(&cio->refcount)) {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		blk_io_schedule();
+	}
+
+	ret = cio->comp_len;
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
+
+	if (bio->bi_status) {
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+	}
+	__free_page(bio->bi_io_vec[0].bv_page);
+	bio_put(bio);
+
+	kfree(ctx);
+	if (atomic_dec_and_test(&cio->refcount)) {
+		if (cio->endio) {
+			cio->endio(cio->private, cio->comp_len);
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
+
+	if (read_bio->bi_status) {
+		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT)
+				- cio->pos_in;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+		__free_page(read_bio->bi_io_vec[0].bv_page);
+		bio_put(ctx->write_bio);
+		bio_put(read_bio);
+		kfree(ctx);
+		if (atomic_dec_and_test(&cio->refcount)) {
+			if (cio->endio) {
+				cio->endio(cio->private, cio->comp_len);
+				kfree(cio);
+			} else
+				blk_wake_io_task(cio->waiter);
+		}
+		return;
+	}
+
+	schedule_work(&ctx->dispatch_work);
+	bio_put(read_bio);
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
+/*
+ * __blk_copy_offload	- Use device's native copy offload feature.
+ * we perform copy operation by sending 2 bio.
+ * 1. First we send a read bio with REQ_COPY flag along with a token and source
+ * and length. Once read bio reaches driver layer, device driver adds all the
+ * source info to token and does a fake completion.
+ * 2. Once read operation completes, we issue write with REQ_COPY flag with same
+ * token. In driver layer, token info is used to form a copy offload command.
+ *
+ * returns the length of bytes copied or negative error value
+ */
+static int __blk_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out, size_t len,
+		cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct cio *cio;
+	struct copy_ctx *ctx;
+	struct bio *read_bio, *write_bio;
+	struct page *token;
+	sector_t copy_len;
+	sector_t rem, max_copy_len;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+	cio->waiter = current;
+	cio->endio = end_io;
+	cio->private = private;
+
+	max_copy_len = min(bdev_max_copy_sectors(bdev_in),
+			bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
+
+	cio->pos_in = pos_in;
+	cio->pos_out = pos_out;
+	cio->comp_len = len;
+	for (rem = len; rem > 0; rem -= copy_len) {
+		copy_len = min(rem, max_copy_len);
+
+		token = alloc_page(gfp_mask);
+		if (unlikely(!token))
+			goto err_token;
+
+		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+		if (!ctx)
+			goto err_ctx;
+		read_bio = bio_alloc(bdev_in, 1, REQ_OP_READ | REQ_COPY
+			| REQ_SYNC | REQ_NOMERGE, gfp_mask);
+		if (!read_bio)
+			goto err_read_bio;
+		write_bio = bio_alloc(bdev_out, 1, REQ_OP_WRITE
+			| REQ_COPY | REQ_SYNC | REQ_NOMERGE, gfp_mask);
+		if (!write_bio)
+			goto err_write_bio;
+
+		ctx->cio = cio;
+		ctx->write_bio = write_bio;
+		INIT_WORK(&ctx->dispatch_work, blk_copy_dispatch_work_fn);
+
+		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+		read_bio->bi_iter.bi_size = copy_len;
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_end_io = blk_copy_offload_read_end_io;
+		read_bio->bi_private = ctx;
+
+		__bio_add_page(write_bio, token, PAGE_SIZE, 0);
+		write_bio->bi_iter.bi_size = copy_len;
+		write_bio->bi_end_io = blk_copy_offload_write_end_io;
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		write_bio->bi_private = ctx;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(read_bio);
+		pos_in += copy_len;
+		pos_out += copy_len;
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
+	cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
+	return cio_await_completion(cio);
+}
+
+static inline int blk_copy_sanity_check(struct block_device *bdev_in,
+	loff_t pos_in, struct block_device *bdev_out, loff_t pos_out,
+	size_t len)
+{
+	unsigned int align = max(bdev_logical_block_size(bdev_out),
+					bdev_logical_block_size(bdev_in)) - 1;
+
+	if (bdev_read_only(bdev_out))
+		return -EPERM;
+
+	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
+		len >= MAX_COPY_TOTAL_LENGTH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline bool blk_check_copy_offload(struct request_queue *q_in,
+		struct request_queue *q_out)
+{
+	return blk_queue_copy(q_in) && blk_queue_copy(q_out);
+}
+
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @end_io:	end_io function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	end_io function will be called with this private data, should be
+ *		NULL, if operation is synchronous in nature
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ *
+ * Returns the length of bytes copied or a negative error value
+ *
+ * Description:
+ *	Copy source offset from source block device to destination block
+ *	device. length of a source range cannot be zero. Max total length of
+ *	copy is limited to MAX_COPY_TOTAL_LENGTH
+ */
+int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *q_in = bdev_get_queue(bdev_in);
+	struct request_queue *q_out = bdev_get_queue(bdev_out);
+	int ret = -EINVAL;
+
+	ret = blk_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	if (blk_check_copy_offload(q_in, q_out))
+		ret = __blk_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
+			   len, end_io, private, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_issue_copy);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..684b8fa121db 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -311,6 +311,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a0e339ff3d09..7f586c4b9954 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -423,6 +423,7 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	__REQ_COPY,		/* copy request */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -452,6 +453,7 @@ enum req_flag_bits {
 
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
+#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -478,6 +480,11 @@ static inline bool op_is_write(blk_opf_t op)
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
@@ -537,4 +544,22 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+typedef void (cio_iodone_t)(void *private, int comp_len);
+
+struct cio {
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+	atomic_t refcount;
+	loff_t pos_in;
+	loff_t pos_out;
+	size_t comp_len;
+	cio_iodone_t *endio;		/* applicable for async operation */
+	void *private;			/* applicable for async operation */
+};
+
+struct copy_ctx {
+	struct cio *cio;
+	struct work_struct dispatch_work;
+	struct bio *write_bio;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 200338f2ec2e..1bb43697d43d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1054,6 +1054,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

