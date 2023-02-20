Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8869CB53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBTMs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTMsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:48:25 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88AE211E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:21 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220124820epoutp03a5db7d54408863a2b97cc6ddb8140a5c~FiTXJ-yH02305723057epoutp03M
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220124820epoutp03a5db7d54408863a2b97cc6ddb8140a5c~FiTXJ-yH02305723057epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897300;
        bh=/o+aP9QRf4FZoRaT/LySJ+iHj8DEObsLDRxvnsfVIzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FE/XNINBTNGBTI1mnZ9e5zgv8MVVqxNS94h0+ttsn4o8k0uY8HYdHWnOBaKF/qDQy
         +WjNP2vD23aqovlcFrONg3J076uMkb9RQWQO6Mc3Z8Ww+yKKwZd/SIV6P3KWhwxM8n
         SuYh0k/C/Fd+x9IPZolzfI1mCwBwhDkzMfcj+bs8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230220124819epcas5p11f5208a9a418e9c136580224f2c472a8~FiTWPTEAL2968429684epcas5p1j;
        Mon, 20 Feb 2023 12:48:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PL2Jx5sj9z4x9Pt; Mon, 20 Feb
        2023 12:48:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.49.06765.11C63F36; Mon, 20 Feb 2023 21:48:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230220105441epcas5p49ffde763aae06db301804175e85f9472~FgwIgKeem2130321303epcas5p4Z;
        Mon, 20 Feb 2023 10:54:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220105441epsmtrp1b08882d9caa63d273a8b7cc07ca397e5~FgwIdq2h_2429224292epsmtrp1S;
        Mon, 20 Feb 2023 10:54:41 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-9d-63f36c11e513
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.0A.17995.17153F36; Mon, 20 Feb 2023 19:54:41 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105437epsmtip2b289a6411a9f285e7bb255dd7d5f15fc~FgwFFbyHG0727007270epsmtip2g;
        Mon, 20 Feb 2023 10:54:37 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 2/8] block: Add copy offload support infrastructure
Date:   Mon, 20 Feb 2023 16:23:25 +0530
Message-Id: <20230220105336.3810-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc98rr61L5+PHxoWNrT7C+OH4US31YkDUYX0bRsn2h8lGZLW8
        FKS0XVsUXJaBRQbNEHAOY3EiQoaCk1iQARWjZVoLY0z5Tcb4EWDTiYB1cfxQ1vJg87/Pued8
        77nfc3N4uIeR68tLVekZrUqmpIh1nMa24MBQd6VDHjFgCEJ17XdwdKz4OY5qh4sIVDo7j6PF
        zi4ctT4uc0ODN5sxdP3CSQxdqr2NIUvFHIZuL08T6KS1D6DJXhOGWoc2ouutdg7qbjlLoPLv
        J7nI+o0BQ00TOQA1Lpbj6MpfMxx0d+gN1PXc5rbdm+7uiadNI50E3Wwa5tJdv1/l0N2dGbS5
        poCg66u+pC2D2QRdaHjsLDg+4kbP3Ogl6BMNNYCu7/icdpjfos0T01jC+o/TolMYWTKjFTIq
        uTo5VaWIoeI/SnovKVISIQoVRaEtlFAlS2diqLg9CaHSVKVzBJTwsEyZ4TxKkOl0VPi2aK06
        Q88IU9Q6fQzFaJKVGrEmTCdL12WoFGEqRr9VFBGxKdJZ+GlayuUKI66p2p851lIIssHp3UbA
        50FSDB9NNuBGsI7nQVoALM1v47LBEwD/rl1wYwMHgHNTudiapKdtEbCJFgCXGkowNjBg0Nz+
        wHkZj0eQG2HHMs8l8CJ/w2Bzh7+rBidHMVh+rAq4Ep6kFPZXODBXPYcMgPX9CS4UkFGwq8bT
        hZAMh0Uj7i7kk1vhs9wsl05AukP7mQmOi3HybWi4VrZiAJKVfPjLVwUc9plxMGeqnMuyJ3xo
        a1hlX/igKG+Vj8BLpy4SrDgXQFO/CbCJWHi8vWjFCU4Gw7qWcPbYD37bfgVjG78KCxcnVkci
        gE3n1tgfXq47T7DsA/ue5awyDevyRznspAoBvFjaThQDoeklQ6aXDJn+b30e4DXAh9Ho0hWM
        LlKzWcUc+e+P5ep0M1hZipD4JjA+OhtmBRgPWAHk4ZSXYFngkHsIkmVZRxmtOkmboWR0VhDp
        nHYJ7vuaXO3cKpU+SSSOihBLJBJx1GaJiPIWBMbY5R6kQqZn0hhGw2jXdBiP75uNdcZ+8cFh
        j6VT428GnsueLL0n7at0+N9suC9bmu+c8fmwdsGOKrF739nrqw9NJ1FujX4wrv7nLRLF1wV3
        +Rv6d1iyenMHA6wVzadtZ9rujP05/08IMT5fljh4QLfdt3lucC/Xe/sn6fsOMVyv3r29UfYb
        23gDr+x+/4A0wLLeP69H6lOYeC05Vfx6im2Yr7//5MVo5q4Xhkz4TnQkmmJG/4gxfPbTw50H
        D24Y2vR0p2SurDrbHvxj4j73mVvBSpuN6JkuOXpLmpdvCTJ2KHb5tMVyGYl5ZsCv/MJY19X+
        E0Gzfjsepf0QbUzM83y6f8/ZqXeXAn71ClqocRQbq5eEIWTWCEZxdCkyUQiu1cn+BcI0MPGd
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvG5h4Odkg9PzeC3WnzrGbNE04S+z
        xeq7/WwW0z78ZLb4ffY8s8Xed7NZLW4e2MlksWfRJCaLlauPMlnsXviRyeLo/7dsFpMOXWO0
        eHp1FpPF3lvaFnv2nmSxuLxrDpvF/GVP2S0OTW5mstjxpJHRYtvv+cwW616/Z7E4cUva4vzf
        46wO4h6Xr3h7zLp/ls1j56y77B7n721k8bh8ttRj06pONo/NS+o9dt9sYPPobX4HVNB6n9Xj
        /b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov07RK4MtYs7GIuWBJe8XBXL2MD
        43T3LkZODgkBE4krh38zdjFycQgJ7GCUeLukgxkiISmx7O8RKFtYYuW/5+wQRY1MEjNmLwXq
        4OBgE9CWOP2fAyQuIvCMSeLsvUfMIA6zwDsmiVUPl7GCdAsLuElcX/iZCaSBRUBVYvP1ABCT
        V8BS4vwqYRBTQkBfov++IIjJKWAl8b2lEqRPCKjgxKTNjCA2r4CgxMmZT1hAbGYBeYnmrbOZ
        JzAKzEKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAka2ntYNyz6oPe
        IUYmDsZDjBIczEoivP95PycL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwDT1vI64eolr9ALWsCfBApvXdv5iW7/t/MuiDxVzP+3YpDCpqv760/74TfG5
        tRG7rni7injwvzdIq2fV1a52M1nX/pGPvyz+/tUHLgyT5mXs/ifz07H2ZvikxIK80gAr0Si/
        jizjb3MaFpXY3rtXN3O26bSZUZ1uksL79xsv1jJclh2UfmDp9Ae39+xc/4Zpj6iGabj1fs2S
        FUtEL6TsXp+YfM3/4bmqiVs1ZqdMjl28yle/caoKW1P82ddiGc4fhMKe9exM1Vbk+VMcHrrj
        r/efHunbdxX497fIr72T0JGhNdEruuvM47lxu3xLRbRYdvoE98dsrE6N673xMVPozVKLrTqT
        Dj29taAu11A4UomlOCPRUIu5qDgRACDThsdTAwAA
X-CMS-MailID: 20230220105441epcas5p49ffde763aae06db301804175e85f9472
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105441epcas5p49ffde763aae06db301804175e85f9472
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105441epcas5p49ffde763aae06db301804175e85f9472@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 block/blk-lib.c           | 235 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   2 +
 include/linux/blk_types.h |  25 ++++
 include/linux/blkdev.h    |   3 +
 4 files changed, 265 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..c48cee5b6c98 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,241 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
+ * 2. Once read opration completes, we issue write with REQ_COPY flag with same
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
index 99be590f952f..bab0ed9c767e 100644
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
@@ -536,4 +543,22 @@ struct blk_rq_stat {
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
index 807ffb5f715d..18d5bd7fc3bf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1063,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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

