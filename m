Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3285667353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjALNiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjALNhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:37:22 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CD6340
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:20 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230112133714epoutp025d19136666d3059c90b76df8e889cdf0~5kz7ojjLu2559025590epoutp02R
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230112133714epoutp025d19136666d3059c90b76df8e889cdf0~5kz7ojjLu2559025590epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530634;
        bh=fU5HjIdSnEaxtmpO3Wugku3TLnqNWog9cVAcaBP9h5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJuAX6fOqOH8z+AuX32Z+7ZWe/tlvI6L+HQKNHeqXM/9DplVDfnYV0g+ARaVAF3TU
         bpHCicQaCY5yxeUw0erjR5XHrHdueaLAC23Ar/0Gyx/7gd91mL4vmHntb542PlYsMn
         PQLGt6l3Ua6/S52hLRUopkFfjz08LoziYF4LsT8I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230112133714epcas5p4f3a746e46b20ab75d8ad8ae51564fe33~5kz7D3ub_0230502305epcas5p4v;
        Thu, 12 Jan 2023 13:37:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nt5FN4hfXz4x9Pv; Thu, 12 Jan
        2023 13:37:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.D4.02301.80D00C36; Thu, 12 Jan 2023 22:37:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65~5jf0VhKwh1949219492epcas5p3H;
        Thu, 12 Jan 2023 12:00:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112120054epsmtrp2579dd9ec74f61611bed4cb72ee905aea~5jf0TKh3E3008330083epsmtrp2S;
        Thu, 12 Jan 2023 12:00:54 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-1c-63c00d082ee9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.33.10542.676FFB36; Thu, 12 Jan 2023 21:00:54 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120051epsmtip20c3c0f8832f14bcc5d9336453a0310e3~5jfxjNjru0767707677epsmtip2X;
        Thu, 12 Jan 2023 12:00:51 +0000 (GMT)
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
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 3/9] block: add emulation for copy
Date:   Thu, 12 Jan 2023 17:28:57 +0530
Message-Id: <20230112115908.23662-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRzOube9vWBrLh3MM5YpKdEEJtA66C5sIAOCd8KQuKDJpsNSbgqh
        tKUPUBIjj6mMyUNlUzpDIcqE0g3pAHl1IlqeIjMMGC/Z1sLmtsKEwcw2gi0XdP995/t93+91
        zsFR/irmjacrtLRaIZELMHdW6y9+fgE4r1sqHCjdQzYO9qJkQfk6SjbMlmGkZfEcm5zsbkfI
        +gYrQnbW/I2Q1g0HRn7RMw7I+TE9Qlqm9pJdlgEWOdrxDUYazs9zyDZ7PiBbHxtQcqX2JIe8
        eHeJRfZP7SZtp4sAObLex470ovRzwxjVrp/lUCN/NrGo0WEdZTaewqhL331EdU7mYVRJ4SJG
        LV0ew6jSZiOgVszPU2a7A0nkHss4mEZLUmm1D62QKlPTFbJwQdzR5OjkELFQFCAKJfcLfBSS
        TDpcEBOfGBCbLnfOKvDJlsh1TipRotEIgiIOqpU6Le2TptRowwW0KlWuClYFaiSZGp1CFqig
        tWEiofCVEKfwvYy0W7UFbFXNG+8vt3Sx8sBIZDFwwyERDJttC5xi4I7ziU4AfzQ9YjOHZQA7
        q+oAc1gB8Nr3Daxti6mrAnNhPtEBYNFEHCMqRGCd0eYM4DhG7IVDG7hL40nMILB9yNelQYlu
        BK5PmzbNO4gQ+HCwm+PCLOJFuFi5AVyYR4TBvrx5xJUHEkGwbM7DRbsRB6Dp2gMWI/GAA5X2
        TYwSL8DClnOoKz8kPnWD+pvTbKbRGPjl3XaMwTvgnb5mDoO94cqiZYvPgfUVdRhjPgmgfkIP
        mMCr8OPBMtTVBEr4wcaOIIbeA88MXkSYws/Cksd2hOF5sK1qG/tCU2P1Vv5dcPxh/ham4JBt
        eWujpQAu2U+BcuCjf2og/VMD6f8vXQ1QI9hFqzSZMloTohIp6Jz/blmqzDSDzffvf7gNzF6/
        H9gDEBz0AIijAk9el/UnKZ+XKvkgl1Yrk9U6Oa3pASHOhX+OentJlc4PpNAmi4JDhcFisTg4
        dJ9YJHiOR7cYpHxCJtHSGTStotXbPgR3885DUg7dtE7vZz+IPoGlxN/Jzg38J/r3rz+Zef0P
        2xl27HGAP/N2wA/THvEJ/UHrlt6W1SX3q4PcibjG2/1EFLbyzs8LE7Lfjmedrwyr5N77y2Ms
        a82g7JwqHjky9NK7SX66oNtQvNwadd3x5s7VbnV+tD10lHvZZJg0H7GW02e/Ap4OFstRgfYO
        O6LX73k09byFmMxJNl9TyY0EK/dCXNv9ZFnVE2HETlOSlUjIOcCvlc7MR55QFMzGlC16Vb38
        rdQ6lJI792us5kZG0VJZlKVDfsm/dPzYa7vrq6+ehjGHsq9cORq61lTzmXGfJaKeEPSt5VnD
        z9568mHWwqMw4+ELBu6MgKVJk4j8UbVG8i+GQyo9iAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvG7Zt/3JBt8ny1usP3WM2aJpwl9m
        i9V3+9ks9r6bzWpx88BOJouVq48yWexe+JHJ4uj/t2wWkw5dY7R4enUWk8XeW9oWe/aeZLG4
        vGsOm8X8ZU/ZLXY8aWS02PZ7PrPF56Ut7BbrXr9nsThxS9ricXcHo8X5v8dZHUQ9Zt0/y+ax
        c9Zddo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHn0Nr9j83i/7yqbR9+WVYwenzfJeWx68pYp
        gCeKyyYlNSezLLVI3y6BK+P50ibWgoX+FZ+27mFpYDzv0MXIySEhYCKxZs8Uti5GLg4hgR2M
        Ek8uzWWESEhKLPt7hBnCFpZY+e85O0RRI5PE5bMvWbsYOTjYBLQlTv/nAImLCDxjkjh77xEz
        iMMscIZJYsWkXnaQbmEBU4nvpw6A2SwCqhLvZv4H28ArYCVxvOEpE8ggCQF9if77giBhTgFr
        iTU3vrCA2EJAJbP2XGWCKBeUODnzCVicWUBeonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55b
        bFhglJdarlecmFtcmpeul5yfu4kRHKFaWjsY96z6oHeIkYmD8RCjBAezkgjvnqP7k4V4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgqvpY85qBiY+h73vX
        /Xtmoqmyyekb3+5zfnNNNJU7qiF5TttGba3ZS2q9C/imVpfGilrLGSw4zaJ6yEwh6nyq+ZPV
        E3ptGv9WqX7dprvrjsKhPSlqfS8El/lsVDWvcuY/GL1GYffnv/0rPjhXVp7a4btT4dW0f1Nb
        /JsW8l8PqE1z3F+1JMht3eW37l7nu5YkyO99HrvXYJXMjmfz2JbmC0hw++xe0sx/76RvI8uk
        bm3V2ty8yRZlZfzHGjZavXvzbnPqT/5czo49632rF+U8mZNQ8+Gqlsh+OYFNX+bETgoNO5u5
        onzxHZ7I560dz+5bFOwLuK4dfM6Fd9UDnSevK4KnX+o3Pbj1YwrPjp1hSizFGYmGWsxFxYkA
        qGTMbT8DAAA=
X-CMS-MailID: 20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120054epcas5p3ec5887c4e1de59f7529dafca1cd6aa65@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the devices which does not support copy, copy emulation is
added. Copy-emulation is implemented by reading from source ranges
into memory and writing to the corresponding destination asynchronously.
For zoned device we maintain a linked list of read submission and try to
submit corresponding write in same order.
Also emulation is used, if copy offload fails or partially completes.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 241 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-map.c        |   4 +-
 include/linux/blkdev.h |   3 +
 3 files changed, 245 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 2ce3c872ca49..43b1d0ef5732 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -428,6 +428,239 @@ static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 	return 0;
 }
 
+static void *blk_alloc_buf(sector_t req_size, sector_t *alloc_size,
+		gfp_t gfp_mask)
+{
+	int min_size = PAGE_SIZE;
+	void *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp_mask);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		/* retry half the requested size */
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
+static void blk_copy_emulate_write_end_io(struct bio *bio)
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
+	kvfree(page_address(bio->bi_io_vec[0].bv_page));
+	bio_map_kern_endio(bio);
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
+static void blk_copy_emulate_read_end_io(struct bio *read_bio)
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
+	kfree(read_bio);
+
+	return;
+
+err_rw_bio:
+	clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+					cio->ranges[ri].src;
+	cio->ranges[ri].comp_len = min_t(sector_t, clen,
+					cio->ranges[ri].comp_len);
+	__free_page(read_bio->bi_io_vec[0].bv_page);
+	bio_map_kern_endio(read_bio);
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
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ */
+static int blk_copy_emulate(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *ranges,
+		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *sq = bdev_get_queue(src_bdev);
+	struct request_queue *dq = bdev_get_queue(dst_bdev);
+	struct bio *read_bio, *write_bio;
+	void *buf = NULL;
+	struct copy_ctx *ctx;
+	struct cio *cio;
+	sector_t src, dst, offset, buf_len, req_len, rem = 0;
+	int ri = 0, ret = 0;
+	unsigned long flags;
+	sector_t max_src_hw_len = min_t(unsigned int, queue_max_hw_sectors(sq),
+			queue_max_segments(sq) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_dst_hw_len = min_t(unsigned int, queue_max_hw_sectors(dq),
+			queue_max_segments(dq) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_hw_len = min_t(unsigned int,
+			max_src_hw_len, max_dst_hw_len);
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	cio->ranges = ranges;
+	atomic_set(&cio->refcount, 1);
+	cio->waiter = current;
+	cio->endio = end_io;
+	cio->private = private;
+
+	if (bdev_is_zoned(dst_bdev)) {
+		INIT_LIST_HEAD(&cio->list);
+		spin_lock_init(&cio->list_lock);
+	}
+
+	for (ri = 0; ri < nr; ri++) {
+		offset = ranges[ri].comp_len;
+		src = ranges[ri].src + offset;
+		dst = ranges[ri].dst + offset;
+		/* If IO fails, we truncate comp_len */
+		ranges[ri].comp_len = ranges[ri].len;
+
+		for (rem = ranges[ri].len - offset; rem > 0; rem -= buf_len) {
+			req_len = min_t(int, max_hw_len, rem);
+
+			buf = blk_alloc_buf(req_len, &buf_len, gfp_mask);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto err_alloc_buf;
+			}
+
+			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_ctx;
+			}
+
+			read_bio = bio_map_kern(sq, buf, buf_len, gfp_mask);
+			if (IS_ERR(read_bio)) {
+				ret = PTR_ERR(read_bio);
+				goto err_read_bio;
+			}
+
+			write_bio = bio_map_kern(dq, buf, buf_len, gfp_mask);
+			if (IS_ERR(write_bio)) {
+				ret = PTR_ERR(write_bio);
+				goto err_write_bio;
+			}
+
+			ctx->cio = cio;
+			ctx->range_idx = ri;
+			ctx->write_bio = write_bio;
+			atomic_set(&ctx->refcount, 1);
+
+			read_bio->bi_iter.bi_sector = src >> SECTOR_SHIFT;
+			read_bio->bi_iter.bi_size = buf_len;
+			read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+			bio_set_dev(read_bio, src_bdev);
+			read_bio->bi_end_io = blk_copy_emulate_read_end_io;
+			read_bio->bi_private = ctx;
+
+			write_bio->bi_iter.bi_size = buf_len;
+			write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+			bio_set_dev(write_bio, dst_bdev);
+			write_bio->bi_end_io = blk_copy_emulate_write_end_io;
+			write_bio->bi_iter.bi_sector = dst >> SECTOR_SHIFT;
+			write_bio->bi_private = ctx;
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
+			atomic_inc(&cio->refcount);
+			submit_bio(read_bio);
+
+			src += buf_len;
+			dst += buf_len;
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
+	kvfree(buf);
+err_alloc_buf:
+	ranges[ri].comp_len -= min_t(sector_t,
+			ranges[ri].comp_len, (ranges[ri].len - rem));
+
+	cio->io_err = ret;
+	return cio_await_completion(cio);
+}
+
 static inline bool blk_check_copy_offload(struct request_queue *src_q,
 		struct request_queue *dst_q)
 {
@@ -460,15 +693,21 @@ int blkdev_issue_copy(struct block_device *src_bdev,
 	struct request_queue *src_q = bdev_get_queue(src_bdev);
 	struct request_queue *dst_q = bdev_get_queue(dst_bdev);
 	int ret = -EINVAL;
+	bool offload = false;
 
 	ret = blk_copy_sanity_check(src_bdev, dst_bdev, ranges, nr);
 	if (ret)
 		return ret;
 
-	if (blk_check_copy_offload(src_q, dst_q))
+	offload = blk_check_copy_offload(src_q, dst_q);
+	if (offload)
 		ret = blk_copy_offload(src_bdev, dst_bdev, ranges, nr,
 				end_io, private, gfp_mask);
 
+	if (ret || !offload)
+		ret = blk_copy_emulate(src_bdev, dst_bdev, ranges, nr,
+				end_io, private, gfp_mask);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_issue_copy);
diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c73..bcf8db2b75f1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -363,7 +363,7 @@ static void bio_invalidate_vmalloc_pages(struct bio *bio)
 #endif
 }
 
-static void bio_map_kern_endio(struct bio *bio)
+void bio_map_kern_endio(struct bio *bio)
 {
 	bio_invalidate_vmalloc_pages(bio);
 	bio_uninit(bio);
@@ -380,7 +380,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
+struct bio *bio_map_kern(struct request_queue *q, void *data,
 		unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 48e9160b7195..c5621550e5b4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1066,6 +1066,9 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 int blkdev_issue_copy(struct block_device *src_bdev,
 		struct block_device *dst_bdev, struct range_entry *ranges,
 		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
+void bio_map_kern_endio(struct bio *bio);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

