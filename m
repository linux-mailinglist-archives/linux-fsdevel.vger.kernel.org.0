Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099324AC205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386764AbiBGOxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392447AbiBGOak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:40 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63570C0401C6
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:38 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220207142254epoutp0410d9fbe135c15733822cf1bee77230f7~RhwBwi1Ng2640426404epoutp04B
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:22:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220207142254epoutp0410d9fbe135c15733822cf1bee77230f7~RhwBwi1Ng2640426404epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243774;
        bh=0Eh/8/ldLagkXv1y5ypkdvrX0F580pviPQR4N11PRXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vf2uhqoRTPQDDBzFuTlqm+0rRhsi1bDuZYzYvZQH6EUZIecinqdoVio1JRmlG96Or
         qUFP9uYPXDIJl0okrmnX2RHyWSKIB2AfeaX22HG4CvyS+CaxzdhpuSlLAsXxRy7XwD
         ahYIHEFlpauOLpETL8h0GquzYlSlfHW+5Y2O/89g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220207142253epcas5p15705b868f810051a510393c6a92200a4~RhwArr39J1199311993epcas5p1c;
        Mon,  7 Feb 2022 14:22:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JspJT28xvz4x9Ps; Mon,  7 Feb
        2022 14:22:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.1E.46822.C8A21026; Mon,  7 Feb 2022 23:19:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81~Rhs4cCphk0820008200epcas5p4L;
        Mon,  7 Feb 2022 14:19:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207141918epsmtrp21ab59392b5c604ccd0089f736c482430~Rhs4atHwi0696106961epsmtrp2S;
        Mon,  7 Feb 2022 14:19:18 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-40-62012a8c1171
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.43.08738.66A21026; Mon,  7 Feb 2022 23:19:18 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141914epsmtip15985d8168762f42340c281d99755262e~Rhs0i3C5B0282502825epsmtip1m;
        Mon,  7 Feb 2022 14:19:14 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH v2 03/10] block: Add copy offload support infrastructure
Date:   Mon,  7 Feb 2022 19:43:41 +0530
Message-Id: <20220207141348.4235-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97u33BYyzAXZ+IGoXR1RkFehwA8Dkw223AhTliUb7A/gCjct
        A9qm5aFmRqAhisC0MBBReW6QFRgTpDLkMUsI7wEiVh4yERhRMh5iEITJWi5u/vc55/c955tz
        fjk83LKBa8uLkSYwCikdJyDMONp2h4POWY7gpJu+yxE1j66YoKpHlwiUv7SOo8W70yYo51IB
        Fw3P7EItC9dM0OBaKoam67Yw1FyWg6GfqzowNFdZDlBG7yCGNqeEqGPrbwLl6B4A1DJ2GDW3
        dHNQccUsF2XqGwnUOt+Co8rO1xhSXxjB0B+FmwTSbhTjqH1yhIOqNhGaX+smUHrWOhc9awv3
        30cN3w+i1KoFLqUqmeBQw/2JVJ0mg6DqfzxH5T6sBNSd0RSCSuvrwKmC5y8ISt93G6OyVQsE
        tTw7xqG0U9lcarF1hKC+v6UBIVbfxPpKGDqaUfAZaZQsOkYq9hMEfRkREOHp5SZ0FvogbwFf
        SsczfoLA4BDnz2LiDJsS8JPouERDKoRWKgWuH/kqZIkJDF8iUyb4CRh5dJxcJHdR0vHKRKnY
        RcokHBG6ubl7GoSRsRL1QBMuvxJ2KlP1FycF1FAXgSkPkiLYpskljGxJ3gFwaZZzEZgZ+DmA
        c+e7ARusADiUNwXeVCyOVOyomgAsGskn2CAdg0tjPQYVj0eQh2HvFs9YYEVaw81B7XYnnLxu
        AlPXn3KMD7tJCjY8bcOMzCHtoTpvBDeyOekDVYP3CNbtACydumtiZFPyCFzdzOewGgvYfXVm
        m3FyP1Q1XMONBpCcNIUTN1kDSAbCexNFOMu74bPOW1yWbeHKQgvBFmQCuNb3J8YGBQCqLqt2
        rI/CoeZ/MOM4OOkAa5tc2fRemNfzC8Y674LZGzMYmzeHjUVv+ACsri3ZaWMDH7xM3WEKri6X
        4ey67gPYNTBHXAb8wrcmKnxrosL/rUsArgE2jFwZL2aUnnJ3KZP83z9HyeLrwPb9OB5rBFOP
        l1x0AOMBHYA8XGBlbpe5RVuaR9OnzzAKWYQiMY5R6oCnYeVq3Pa9KJnhAKUJEUKRj5vIy8tL
        5OPhJRRYm/eKf6UtSTGdwMQyjJxRvKnDeKa2KViI9qe9aof+460Bg3pbfMmiT53ET6MCr9ye
        xPLxqmHMvn20rSzonH7ArNqjV5/vbt1x1ql4vLMmaa6oRDjxbaB2j3lWuGcyNaDp+7D/5Kvl
        s8MW7iVFlnaRJ1avf72REfOk+jcz+0cVbZ6nNoIzwjtVue4TSYd63HxlX0z36BatQk8EdxVN
        vx92/lPR5y8tf3jyCW2qeJxar9u33Omfpvbwz2SOirxdvfVDFzTcGx9Y5AYw+yXR5TXupeO/
        v9gzVn1jlq+d/wrahB1/dSbZdFjNtPu8c7VvXJpsdrPqoVhSbpV5WlrfJXauefc7xevSZZ+P
        nSRJ/gddcmoP2ZWEph9zCo0UcJQSWuiIK5T0v1gSQt3IBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSnG6aFmOSwbNvKhZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9c/TrJZtPb8ZLd4tT/OQc7j8hVvj4nN79g9mhfcYfG4
        fLbUY9OqTjaPzUvqPSbfWM7osftmA5tH05mjzB4zPn1h87h+ZjuTR2/zOzaPj09vsXhse9jL
        7vF+31U2j74tqxgDRKK4bFJSczLLUov07RK4Miae38VcMD2yorv5GUsD41qPLkZODgkBE4n3
        V5exdDFycQgJ7GCU2LB1KytEQlJi2d8jzBC2sMTKf8/ZIYqamSSurb8I1MHBwSagLXH6PwdI
        jYiAuMSfC9sYQWqYBQ6xSvw79wasWVjAQ2Lry/1MIDaLgKrExKlXweK8ApYSzRcusUEsUJZY
        +PAg2GJOASuJb3+mQV3UwCjRcG4FK0SDoMTJmU9YQGxmAXmJ5q2zmScwCsxCkpqFJLWAkWkV
        o2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwetDS2sG4Z9UHvUOMTByMhxglOJiVRHhl
        uv8nCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDk0XW+
        /fEEST9hBZWL23+LljcdO1CXOzFwW55flLmeZW71wZ8pq/c2dl6br59nozpjr4KM1DvVmQl1
        7znePJgu7pNewJYU+DX50M3goJNLJBZmtez9vOsIy+pY42Xbet9c6xMIX3zlwi53ccckvfiK
        F0Hps04xlbM/0QjlfZd01sCisOXhLOUfdvYTNtucmd/PtmKJlOSrH3uX1ko/ne175MS5F+vC
        VXW0lvcoq3M4SGg3ds6cyrTMzrVk9a7Pe4QecMV1PF1/1k3z39slmUsiLFkEb/V+SI/xW+r4
        7qmf1PfWBfYrddIrOub9V/zZUxjqUKdd4xJZceXyZmthwbQVa2Yp/VnX3bRvp/E6U00lluKM
        REMt5qLiRAC3uBf0fgMAAA==
X-CMS-MailID: 20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141918epcas5p4f9badc0c3f3f0913f091c850d2d3bd81@epcas5p4.samsung.com>
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

Introduce blkdev_issue_copy which supports source and destination bdevs,
and a array of (source, destination and copy length) tuples.
Introduce REQ_COP copy offload operation flag. Create a read-write
bio pair with a token as payload and submitted to the device in order.
the read request populates token with source specific information which
is then passed with write request.
Ths design is courtsey Mikulas Patocka<mpatocka@>'s token based copy

Larger copy operation may be divided if necessary by looking at device
limits.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/blk-lib.c           | 216 ++++++++++++++++++++++++++++++++++++++
 block/blk-settings.c      |   2 +
 block/blk.h               |   2 +
 include/linux/blk_types.h |  20 ++++
 include/linux/blkdev.h    |   3 +
 include/uapi/linux/fs.h   |  14 +++
 6 files changed, 257 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 1b8ced45e4e5..3ae2c27b566e 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -135,6 +135,222 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * Wait on and process all in-flight BIOs.  This must only be called once
+ * all bios have been issued so that the refcount can only decrease.
+ * This just waits for all bios to make it through bio_copy_end_io. IO
+ * errors are propagated through cio->io_error.
+ */
+static int cio_await_completion(struct cio *cio)
+{
+	int ret = 0;
+
+	while (atomic_read(&cio->refcount)) {
+		cio->waiter = current;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		blk_io_schedule();
+		/* wake up sets us TASK_RUNNING */
+		cio->waiter = NULL;
+		ret = cio->io_err;
+	}
+	kvfree(cio);
+
+	return ret;
+}
+
+static void bio_copy_end_io(struct bio *bio)
+{
+	struct copy_ctx *ctx = bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+
+	if (bio->bi_status) {
+		cio->io_err = bio->bi_status;
+		clen = (bio->bi_iter.bi_sector - ctx->start_sec) << SECTOR_SHIFT;
+		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
+	}
+	__free_page(bio->bi_io_vec[0].bv_page);
+	kfree(ctx);
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&cio->refcount) && cio->waiter)
+		wake_up_process(cio->waiter);
+}
+
+/*
+ * blk_copy_offload	- Use device's native copy offload feature
+ * Go through user provide payload, prepare new payload based on device's copy offload limits.
+ */
+int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
+{
+	struct request_queue *sq = bdev_get_queue(src_bdev);
+	struct request_queue *dq = bdev_get_queue(dst_bdev);
+	struct bio *read_bio, *write_bio;
+	struct copy_ctx *ctx;
+	struct cio *cio;
+	struct page *token;
+	sector_t src_blk, copy_len, dst_blk;
+	sector_t remaining, max_copy_len = LONG_MAX;
+	int ri = 0, ret = 0;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+	cio->rlist = rlist;
+
+	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_sectors,
+			(sector_t)dq->limits.max_copy_sectors);
+	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
+			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
+
+	for (ri = 0; ri < nr_srcs; ri++) {
+		cio->rlist[ri].comp_len = rlist[ri].len;
+		for (remaining = rlist[ri].len, src_blk = rlist[ri].src, dst_blk = rlist[ri].dst;
+			remaining > 0;
+			remaining -= copy_len, src_blk += copy_len, dst_blk += copy_len) {
+			copy_len = min(remaining, max_copy_len);
+
+			token = alloc_page(gfp_mask);
+			if (unlikely(!token)) {
+				ret = -ENOMEM;
+				goto err_token;
+			}
+
+			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
+					gfp_mask);
+			if (!read_bio) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
+			read_bio->bi_iter.bi_size = copy_len;
+			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+			ret = submit_bio_wait(read_bio);
+			if (ret) {
+				bio_put(read_bio);
+				goto err_read_bio;
+			}
+			bio_put(read_bio);
+			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+			ctx->cio = cio;
+			ctx->range_idx = ri;
+			ctx->start_sec = rlist[ri].src;
+
+			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
+					gfp_mask);
+			if (!write_bio) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+
+			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
+			write_bio->bi_iter.bi_size = copy_len;
+			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
+			write_bio->bi_end_io = bio_copy_end_io;
+			write_bio->bi_private = ctx;
+			atomic_inc(&cio->refcount);
+			submit_bio(write_bio);
+		}
+	}
+
+	/* Wait for completion of all IO's*/
+	return cio_await_completion(cio);
+
+err_read_bio:
+	__free_page(token);
+err_token:
+	rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
+
+	cio->io_err = ret;
+	return cio_await_completion(cio);
+}
+
+static inline int blk_copy_sanity_check(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
+{
+	unsigned int align_mask = max(
+			bdev_logical_block_size(dst_bdev), bdev_logical_block_size(src_bdev)) - 1;
+	sector_t len = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (rlist[i].len)
+			len += rlist[i].len;
+		else
+			return -EINVAL;
+		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
+				(rlist[i].len & align_mask))
+			return -EINVAL;
+		rlist[i].comp_len = 0;
+	}
+
+	if (!len && len >= MAX_COPY_TOTAL_LENGTH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline bool blk_check_copy_offload(struct request_queue *src_q,
+		struct request_queue *dest_q)
+{
+	if (dest_q->limits.copy_offload == BLK_COPY_OFFLOAD &&
+			src_q->limits.copy_offload == BLK_COPY_OFFLOAD)
+		return true;
+
+	return false;
+}
+
+/*
+ * blkdev_issue_copy - queue a copy
+ * @src_bdev:	source block device
+ * @nr_srcs:	number of source ranges to copy
+ * @src_rlist:	array of source ranges
+ * @dest_bdev:	destination block device
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ * @flags:	BLKDEV_COPY_* flags to control behaviour
+ *
+ * Description:
+ *	Copy source ranges from source block device to destination block device.
+ *	length of a source range cannot be zero.
+ */
+int blkdev_issue_copy(struct block_device *src_bdev, int nr,
+		struct range_entry *rlist, struct block_device *dest_bdev,
+		gfp_t gfp_mask, int flags)
+{
+	struct request_queue *src_q = bdev_get_queue(src_bdev);
+	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
+	int ret = -EINVAL;
+
+	if (!src_q || !dest_q)
+		return -ENXIO;
+
+	if (!nr)
+		return -EINVAL;
+
+	if (nr >= MAX_COPY_NR_RANGE)
+		return -EINVAL;
+
+	if (bdev_read_only(dest_bdev))
+		return -EPERM;
+
+	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
+	if (ret)
+		return ret;
+
+	if (blk_check_copy_offload(src_q, dest_q))
+		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_copy);
+
 /**
  * __blkdev_issue_write_same - generate number of bios with same page
  * @bdev:	target blockdev
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 818454552cf8..4c8d48b8af25 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -545,6 +545,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min_not_zero(t->max_copy_sectors, b->max_copy_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk.h b/block/blk.h
index abb663a2a147..94d2b055750b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -292,6 +292,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5561e58d158a..0a3fee8ad61c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -418,6 +418,7 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_COPY,		/* copy request*/
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -442,6 +443,7 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_COPY		(1ULL << __REQ_COPY)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -498,6 +500,11 @@ static inline bool op_is_discard(unsigned int op)
 	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
 }
 
+static inline bool op_is_copy(unsigned int op)
+{
+	return (op & REQ_COPY);
+}
+
 /*
  * Check if a bio or request operation is a zone management operation, with
  * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
@@ -532,4 +539,17 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+struct cio {
+	atomic_t refcount;
+	blk_status_t io_err;
+	struct range_entry *rlist;
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+};
+
+struct copy_ctx {
+	int range_idx;
+	sector_t start_sec;
+	struct cio *cio;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f63ae50f1de3..15597488040c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1120,6 +1120,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		struct bio **biop);
 struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		gfp_t gfp_mask);
+int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev,
+		gfp_t gfp_mask, int flags);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..55bca8f6e8ed 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,20 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* Maximum no of entries supported */
+#define MAX_COPY_NR_RANGE	(1 << 12)
+
+/* maximum total copy length */
+#define MAX_COPY_TOTAL_LENGTH	(1 << 21)
+
+/* Source range entry for copy */
+struct range_entry {
+	__u64 src;
+	__u64 dst;
+	__u64 len;
+	__u64 comp_len;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.30.0-rc0

