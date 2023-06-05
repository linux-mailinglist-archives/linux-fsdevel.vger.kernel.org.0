Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA67225BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjFEM3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjFEM3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCCDB
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:35 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605122933epoutp04ce12f457cecaefc1c6a938343236de2a~lwx75fdDr1858418584epoutp04e
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605122933epoutp04ce12f457cecaefc1c6a938343236de2a~lwx75fdDr1858418584epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968173;
        bh=1y7JV8IkqYpeDgQv38tdyIZC5pub23kWz9W5MNLaQSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX8OA5v4kpqn+/1h/aR0HK6FBmLMFZ5Zj13zmL+QbM6jUr9ZD33SSzoYtdC/Giizn
         wwcmND4oZKrUoJAM2OPOmnoOFAgZxJP4prDmqwB5OY7NqH0gf7Ol/zmnIX6WPWHhNK
         BJsRtruojB0eNyG9WlCN58AaiPgxfdUBuB5KoDaw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122932epcas5p411eee49c2bdc0c26f007b4f8c85c1465~lwx69wDEM1407614076epcas5p46;
        Mon,  5 Jun 2023 12:29:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QZXwp47n0z4x9Pq; Mon,  5 Jun
        2023 12:29:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.49.04567.A25DD746; Mon,  5 Jun 2023 21:29:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122141epcas5p256df105da840c937758de63e67516f32~lwrEi2xrA0039600396epcas5p2v;
        Mon,  5 Jun 2023 12:21:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605122141epsmtrp1e8fd82e63b03d16158bfa3e069db6896~lwrEhrG9W1437514375epsmtrp1B;
        Mon,  5 Jun 2023 12:21:41 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-57-647dd52ad418
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.9C.27706.553DD746; Mon,  5 Jun 2023 21:21:41 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122135epsmtip29ea7bccfcc6947623ad8181d7fe93c03~lwq_4aJnE2248722487epsmtip2O;
        Mon,  5 Jun 2023 12:21:35 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 2/9] block: Add copy offload support infrastructure
Date:   Mon,  5 Jun 2023 17:47:18 +0530
Message-Id: <20230605121732.28468-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+4tt4VZvOWxHV6zqTGOMh5lwA5MJk7E62vCiC7ZNKyhN8CA
        tmlhzhHCuygKRWATSxFhTHkoFRDGU6EEO1DmIitMFgYsQEQ2XmOgAm6UK5v/fb7f83uc3+/k
        cHCrG2x7TpQ0jlZIxTECwoLV2OX8lqvQmCjxaDM6Il3vXRyl5q7hqHpYTaDprgWAvpl7hqPx
        jkyA+sct0eid3ah9psgMPepoxlBbWR6GKqu7MdRaOo+hPP0AQBNGDYbah1xQqaqchdrae1io
        v0VLoJKrE2x0brCJQNcMLzCkz0/DUNN4CkCNKyU4qpmeZaEfhhzQgzWDGVp5qiUCnKj+nw9R
        mpE+gmrWDLOpB7/Vsqj6CiHV3xdP1VWdJaj68iSq9VEyQX2bk29GZafNENT8xBCLmr1tJKic
        W1WAqr+XQP1V92Yw75PoXZG0WEIr+LQ0XCaJkkb4Cw6Fhu0N8/bxELmKfNG7Ar5UHEv7CwIP
        B7sGRcWsr0jA/0IcE79uBYuVSoH7+7sUsvg4mh8pU8b5C2i5JEbuJXdTimOV8dIINykd5yfy
        8PD0Xg/8LDqyY/K8mbwz7Mv+2b9ZySDvwyxgzoGkF0xW1+JZwIJjRbYC2KE6TzBiAUBDV6YZ
        I5YArJ5pwzdTrl99+DKqHcC6kiLAiAwMqsoXsSzA4RCkC7z3D8fk25AVOExZvs8yCZw04PDu
        fMpGKWtyP9QvrwATs8gdMK+sgzAxl/SD05mDhKkQJN2heoRnss3J9+BUnx5nQniw59I4y8Q4
        uQ2mNRRtDAHJh+aw53stzuQGwpp6b+bW1vCJ4RabYXs4pVa95FOwsqCCYHLTAdQMagBzsBtm
        9Ko36uCkM9S1uDO2E/y6twZj+lrC7JVxjPG5sOnyJm+H13VXCIbt4MByykumoLHxR4xZVg6A
        o+kZWC7ga16ZR/PKPJr/W18BeBWwo+XK2Aha6S0XSelT/z1zuCy2Dmz8G+GBJjA8OuemBxgH
        6AHk4AIbbsvBBIkVVyI+/RWtkIUp4mNopR54r+/7Am5vGy5b/3jSuDCRl6+Hl4+Pj5fvOz4i
        wRvcnf494VZkhDiOjqZpOa3YzMM45vbJWOx4wFrhd6VC7uoCv7NHZ3BOlAg+dx9o7nb7veHs
        sUKLy+Ge9wM9TxTPjHHZuo+D9zuW1aWe7hXqDKnPhav6bSGP2TMnxVN9j6NXXW8Tma87vjAe
        0006JHwadNiy+MC+sblemd2ZscSlI4qPth4sgLaLyGPt19Bze4+udYb+YXm8UvHTiIMTr//k
        UUfzhuqgPU+zrf+8KVAfCfEvX7QNv9i2hffLc2F3stWArau2bWkr+21V1LRN0oRWl+tce6l4
        bHvNiZtnQnZCmzHR/I7FPZO8D/bduFYof6bKj5m0LHjiHa1ydj+enVIU65frcsfd+NoW64AW
        jjC1L109EN3eob2YpC4TsJSRYpEQVyjF/wJVA0JrwAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCSvG7o5doUgwXnxC3WnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFrsX
        fmSymHToGqPF06uzmCz23tK2WNi2hMViz96TLBaXd81hs5i/7Cm7Rff1HWwWy4//Y7I4NLmZ
        yWLHk0ZGi22/5zNbrHv9nsXixC1pi/N/j7Na/P4xh81B1uPyFW+PWffPsnnsnHWX3eP8vY0s
        HptXaHlcPlvqsWlVJ5vH5iX1HrtvNrB5LO6bzOrR2/yOzePj01ssHu/3XWXz6NuyitFj8+lq
        j8+b5AIEo7hsUlJzMstSi/TtErgyDjzrYS04GF9x+f1XlgbGSX5djJwcEgImEmuWXWLrYuTi
        EBLYzSjx4cRVdoiEpMSyv0eYIWxhiZX/nrNDFDUzSfQ/2A7UwcHBJqAtcfo/B0hcRGALs8TZ
        X5NZQRqYBW4zS8w8KwNiCwu4Sxz6/psRxGYRUJWYtOgAG4jNK2Al8br9OtgcCQF9if77giBh
        TgFriZdnDzGDhIWASq6+t4GoFpQ4OfMJC8R0eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnAq0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeHd5VacI8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwDSj5bP4vQlzpt/h
        PqZv2N7vFKb+o3h/XI0Nd3uC182n4dWO7QLrLM1ZUgpdHgt85//pc46j/MkOm6rVZzvtZtTI
        Pg50dDLLu3HHxOHMghadv0wly4O2fUwIl0x31a5TWl/+8knSI7nimXcWzrtdb329v1Lwx947
        P//VzDYv3G+ZuFX7B3/Vp/hVkxJVrx8T+lPJaJ/wS69E3TJ91mzVxM9Vcw71ZWf457q0aIba
        9K1tbNdfrn8vNUVRXTCHUc4q8swZrUiJIicPAbVq++XZ7JPLbrzir/ZaIPW+MZglJnButcOi
        U5cqNxTnHZjcftXgHr9rxb6yy//ZzG1Wz3MzLSwumZGzS+/sh4lGUS+VWIozEg21mIuKEwFW
        c+R5dAMAAA==
X-CMS-MailID: 20230605122141epcas5p256df105da840c937758de63e67516f32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122141epcas5p256df105da840c937758de63e67516f32
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122141epcas5p256df105da840c937758de63e67516f32@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
 block/blk-lib.c           | 243 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   2 +
 include/linux/blk_types.h |  25 ++++
 include/linux/blkdev.h    |   4 +
 include/uapi/linux/fs.h   |   5 +-
 5 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..b8e11997b5bf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,249 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to make it through
+ * blkdev_copy_(offload/emulate)_write_endio.
+ */
+static ssize_t blkdev_copy_wait_completion(struct cio *cio)
+{
+	ssize_t ret;
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
+static void blkdev_copy_offload_write_endio(struct bio *bio)
+{
+	struct copy_ctx *ctx = bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+
+	if (bio->bi_status) {
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+	}
+	kfree(bvec_virt(&bio->bi_io_vec[0]));
+	bio_put(bio);
+
+	kfree(ctx);
+	if (!atomic_dec_and_test(&cio->refcount))
+		return;
+	if (cio->endio) {
+		cio->endio(cio->private, cio->comp_len);
+		kfree(cio);
+	} else
+		blk_wake_io_task(cio->waiter);
+}
+
+static void blkdev_copy_offload_read_endio(struct bio *read_bio)
+{
+	struct copy_ctx *ctx = read_bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+
+	if (read_bio->bi_status) {
+		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT)
+				- cio->pos_in;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+		kfree(bvec_virt(&read_bio->bi_io_vec[0]));
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
+static void blkdev_copy_dispatch_work(struct work_struct *work)
+{
+	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
+			dispatch_work);
+
+	submit_bio(ctx->write_bio);
+}
+
+/*
+ * __blkdev_copy_offload	- Use device's native copy offload feature.
+ * we perform copy operation by sending 2 bio.
+ * 1. First we send a read bio with REQ_COPY flag along with a token and source
+ * and length. Once read bio reaches driver layer, device driver adds all the
+ * source info to token and does a fake completion.
+ * 2. Once read operation completes, we issue write with REQ_COPY flag with same
+ * token. In driver layer, token info is used to form a copy offload command.
+ *
+ * Returns the length of bytes copied or error if encountered
+ */
+static ssize_t __blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct cio *cio;
+	struct copy_ctx *ctx;
+	struct bio *read_bio, *write_bio;
+	void *token;
+	sector_t copy_len;
+	sector_t rem, max_copy_len;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+	cio->waiter = current;
+	cio->endio = endio;
+	cio->private = private;
+
+	max_copy_len = min(bdev_max_copy_sectors(bdev_in),
+			bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
+
+	cio->pos_in = pos_in;
+	cio->pos_out = pos_out;
+	/* If there is a error, comp_len will be set to least successfully
+	 * completed copied length
+	 */
+	cio->comp_len = len;
+	for (rem = len; rem > 0; rem -= copy_len) {
+		copy_len = min(rem, max_copy_len);
+
+		token = kmalloc(COPY_TOKEN_SIZE, gfp_mask);
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
+		INIT_WORK(&ctx->dispatch_work, blkdev_copy_dispatch_work);
+
+		__bio_add_page(read_bio, virt_to_page(token), COPY_TOKEN_SIZE,
+				offset_in_page(token));
+		read_bio->bi_iter.bi_size = copy_len;
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_end_io = blkdev_copy_offload_read_endio;
+		read_bio->bi_private = ctx;
+
+		__bio_add_page(write_bio, virt_to_page(token), COPY_TOKEN_SIZE,
+				offset_in_page(token));
+		write_bio->bi_iter.bi_size = copy_len;
+		write_bio->bi_end_io = blkdev_copy_offload_write_endio;
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
+	return blkdev_copy_wait_completion(cio);
+
+err_write_bio:
+	bio_put(read_bio);
+err_read_bio:
+	kfree(ctx);
+err_ctx:
+	kfree(token);
+err_token:
+	cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
+	if (!atomic_read(&cio->refcount)) {
+		kfree(cio);
+		return -ENOMEM;
+	}
+	/* Wait for submitted IOs to complete */
+	return blkdev_copy_wait_completion(cio);
+}
+
+static inline ssize_t blkdev_copy_sanity_check(
+	struct block_device *bdev_in, loff_t pos_in,
+	struct block_device *bdev_out, loff_t pos_out,
+	size_t len)
+{
+	unsigned int align = max(bdev_logical_block_size(bdev_out),
+					bdev_logical_block_size(bdev_in)) - 1;
+
+	if (bdev_read_only(bdev_out))
+		return -EPERM;
+
+	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
+		len >= COPY_MAX_BYTES)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @endio:	endio function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	endio function will be called with this private data, should be
+ *		NULL, if operation is synchronous in nature
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ *
+ * Returns the length of bytes copied or error if encountered
+ *
+ * Description:
+ *	Copy source offset from source block device to destination block
+ *	device. If copy offload is not supported or fails, fallback to
+ *	emulation. Max total length of copy is limited to COPY_MAX_BYTES
+ */
+ssize_t blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *q_in = bdev_get_queue(bdev_in);
+	struct request_queue *q_out = bdev_get_queue(bdev_out);
+	ssize_t ret;
+
+	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	if (blk_queue_copy(q_in) && blk_queue_copy(q_out))
+		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
+			   len, endio, private, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk.h b/block/blk.h
index 7ad7cb6ffa01..f7593396c637 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -303,6 +303,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d7eeaedddd16..1d54a1648adf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -427,6 +427,7 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	__REQ_COPY,		/* copy request */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -451,6 +452,7 @@ enum req_flag_bits {
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
+#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 
@@ -481,6 +483,11 @@ static inline bool op_is_write(blk_opf_t op)
 	return !!(op & (__force blk_opf_t)1);
 }
 
+static inline bool op_is_copy(blk_opf_t op)
+{
+	return op & REQ_COPY;
+}
+
 /*
  * Check if the bio or request is one that needs special treatment in the
  * flush state machine.
@@ -540,4 +547,22 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+typedef void (cio_iodone_t)(void *private, int comp_len);
+
+struct cio {
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+	atomic_t refcount;
+	loff_t pos_in;
+	loff_t pos_out;
+	ssize_t comp_len;
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
index 5ff161c18ae8..96e986b37a29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1053,6 +1053,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+ssize_t blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a16bafada09d..3c8224a2ad85 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,9 +64,12 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
-/* maximum total copy length, this is set to 128 MB based on current testing */
+/* maximum copy offload length, this is set to 128MB based on current testing */
 #define COPY_MAX_BYTES	(1 << 27)
 
+/* copy offload token size */
+#define COPY_TOKEN_SIZE SECTOR_SIZE
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

