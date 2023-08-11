Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26FF778D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjHKLUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjHKLUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B96E68
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811112004epoutp0173055d5d91fdb45c27f021bad618f2c8~6UDZtXYK83025530255epoutp01g
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811112004epoutp0173055d5d91fdb45c27f021bad618f2c8~6UDZtXYK83025530255epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752804;
        bh=nQxoxb+bRGkcDyLyJMCXQ68+OTUT4wvOVZURDBJ8TL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfM+a5O7Y1HABQ6OEkHFXq36rwcuvluMPz12zak6JF20X4BNlTbmPVbzQ4qMYPCXf
         rbKU6s45bI/i7E71Bi/hFARWLsVnypQ+2kV2mnMoo6AIiddv9XiH1UXSefbFfm0k+Y
         A+SZ48ulKAvWnVy53x672LnuoU8Ky8IIMbRD/ozY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811112004epcas5p13358789b11fbb22ddd097ef02eea5fc9~6UDZHfxRK1411414114epcas5p1J;
        Fri, 11 Aug 2023 11:20:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RMhCk2j3rz4x9Q3; Fri, 11 Aug
        2023 11:20:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.24.57354.26916D46; Fri, 11 Aug 2023 20:20:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08~6TvP3uxbU0562205622epcas5p1I;
        Fri, 11 Aug 2023 10:56:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105659epsmtrp1518d7b060429590656d4392751a5db2f~6TvP280k20358803588epsmtrp1h;
        Fri, 11 Aug 2023 10:56:59 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-d9-64d619625084
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.13.64355.BF316D46; Fri, 11 Aug 2023 19:56:59 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105654epsmtip2f5ca9c0c86786979107bcf3f14805923~6TvKvI32t1192511925epsmtip2k;
        Fri, 11 Aug 2023 10:56:54 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 03/11] block: add copy offload support
Date:   Fri, 11 Aug 2023 16:22:46 +0530
Message-Id: <20230811105300.15889-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO/fevVwYaK6L1QFHY7aoEQV2cdkOJIhIeEmbYVLH0mrd2CsQ
        sLvuQ6wZC+ORwsAi4GDLEgImCiZKQLzDRUFAghZ5OiAm9IABgkyQRWyXBfO/z+/7e//OHArn
        mkhnKlKmZpUySTSPtCMqmza+6f6pU6+UP9jliErbmnH0dfoTHJUMaUk00TQL0GjjNwCN/LwN
        1U/lcNBAYzWGLpXcxFCGoRegsR4dhuoHN6H8pPMEqqtvJVB3jZ5EeRfGbFBRyxKG+tPHAKo0
        5eHoysQ0gW4NrkOdT1o4AS8zncPXCKa7Q8OUFZ8imR/Pf8XUDsSRTGFaJodJjZ8imZmxQYKZ
        bughmbTyYsD8U7aBKRudxELtD0RtjWAlUlbpwsrC5NJIWbgfb9ce8Q6xt4gvcBf4oLd4LjJJ
        DOvHC9od6h4cGW3el+dyVBKtMUuhEpWK5+m/VSnXqFmXCLlK7cdjFdJohVDhoZLEqDSycA8Z
        q/YV8Ple3ubAQ1ERN7JnSUWR/7HsU5UgDjR4JQNbCtJCOFJehCUDO4pL1wI43jsNrMYsgCNz
        icQzo+REB76acsNwB7c6qgH811TLsRqJGMxPnTLnUxRJb4LtTymLvpaOw+HV2sLlujhtwKAu
        fxKzlHKkfeHd70dICxO0K8z+qQdY2MGsDxTct7EUgrQn1N5bY5Ft6bfhdJmRtIasga3fjhIW
        xulXYXxFzvJEkH5KQdPpdNI6ahBM+k27wo5wvKXcxsrO8C9t0grHwktZF0lrcgKAuj4dsDq2
        wcQ2LW4ZAqc3wtIaT6u8Hp5pu4JZG78IU02jmFV3gFXfrfJr8HLpuZW+TrB37sQKM1Cvn1q5
        dhqAxsYhTjpw0T23kO65hXT/tz4H8GLgxCpUMeFsmLdCIGNjn71zmDymDCz/AregKtCft+Rh
        ABgFDABSOG+tg98eo5TrIJV8/gWrlIuVmmhWZQDe5oOfxp1fCpObv5FMLRYIffhCkUgk9Nki
        EvBecZhIzJVy6XCJmo1iWQWrXM3DKFvnOCw411GYdWzzx4/mxu0bTOvnA9vZ4fmqnAdGY/Vt
        ne/MQmSfaHG7/4EAW3WztFR6L6Wwoq//4uGdE/ZU4WTtydCH2n0HZS0a+etdR47zDeKakMtu
        CU6ZKe2leUU99MODY/QPCX8+Fj3onHkX+70+kMe4I7qu72rGnYziXZ99eVa/P+VmV2BdR6tf
        VlDT0cXDBSHG3UTBO7/+vb390Hu3NbHxQ8nq+ke5mR+9saE9k5k6kvVB8MnuWZ2YGA54vMWr
        1znjjIb7vv7+XlfXC9f2X79roxgJ0X6ydCtw3olbYjq+GGT3wsK+YSfiw85fUsTSdWc3++9o
        9trLL44s79tZwVnI1Ff/cZ1HqCIkAjdcqZL8B+zNr+yOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO5v4WspBju+qFusP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8WD/fYWe9/NZrW4eWAnk8XK1UeZLCYdusZo8fTqLCaLvbe0LRa2
        LWGx2LP3JIvF5V1z2CzmL3vKbrH8+D8mixsTnjJabPs9n9li3ev3LBYnbklbnP97nNVBzOP8
        vY0sHpfPlnpsWtXJ5rF5Sb3H7psNbB6L+yazevQ2v2Pz+Pj0FovH+31X2Tz6tqxi9Pi8Sc5j
        05O3TAE8UVw2Kak5mWWpRfp2CVwZR6Z/YitYblcxvXMbYwPjPqMuRk4OCQETiSOHrjB3MXJx
        CAlsZ5TYfuokI0RCUmLZ3yPMELawxMp/z9khipqZJLZd2wDkcHCwCWhLnP7PARIXEehilujc
        +Y4FpIFZ4ByTxMnb/CC2sICVxO2lD9hAbBYBVYnp26+CLeAFit9c9BBsjoSAvkT/fUGQMKeA
        tcT7TZfAyoWASj4sOwhVLihxcuYTqPHyEs1bZzNPYBSYhSQ1C0lqASPTKkbR1ILi3PTc5AJD
        veLE3OLSvHS95PzcTYzg+NQK2sG4bP1fvUOMTByMhxglOJiVRHhtgy+lCPGmJFZWpRblxxeV
        5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTAFXtlT9fcIi+GZW3PW9960vHor
        /sSWqFxV/afrNN8rTIo62b3ZMKzg/dk59c9mJN7waPQo8he2qTdyq/cxElNT/tEpsGbvvNdx
        FyPXt4jOTd7j6Hcl4wHPmbWHt4WGBl7snrz2QvrBYpZ4dscvawWnbRbcs+2fu4/zw6UhdoLR
        W50OMwpF3mXz9g6dbLs/6OyBsEkmYYl+cfYar24u8WcKFXw4kft33OXbu06oFXkn3srk1xIR
        Mlk9of/273mXwrYZnFh06PuCg1cM9I1ygldP/7buh2/kvtu20+O7HI7lVNXmex1+7sh4rrN3
        UUvxfCEBX5OQDXsLN5086PPaa+vp89L7PxV1OZxze3jFdJqfEktxRqKhFnNRcSIAPOycrD4D
        AAA=
X-CMS-MailID: 20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blkdev_copy_offload to perform copy offload.
Issue REQ_OP_COPY_SRC with source info along with taking a plug.
This flows till request layer and waits for dst bio to arrive.
Issue REQ_OP_COPY_DST with destination info and this bio reaches request
layer and merges with src request.
For any reason, if a request comes to the driver with only one of src/dst
bio, we fail the copy offload.

Larger copy will be divided, based on max_copy_sectors limit.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c        | 196 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 200 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..ad512293730b 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,6 +10,22 @@
 
 #include "blk.h"
 
+/* Keeps track of all outstanding copy IO */
+struct blkdev_copy_io {
+	atomic_t refcount;
+	ssize_t copied;
+	int status;
+	struct task_struct *waiter;
+	void (*endio)(void *private, int status, ssize_t copied);
+	void *private;
+};
+
+/* Keeps track of single outstanding copy offload IO */
+struct blkdev_copy_offload_io {
+	struct blkdev_copy_io *cio;
+	loff_t offset;
+};
+
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
@@ -115,6 +131,186 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+static inline ssize_t blkdev_copy_sanity_check(struct block_device *bdev_in,
+					       loff_t pos_in,
+					       struct block_device *bdev_out,
+					       loff_t pos_out, size_t len)
+{
+	unsigned int align = max(bdev_logical_block_size(bdev_out),
+				 bdev_logical_block_size(bdev_in)) - 1;
+
+	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
+	    len >= COPY_MAX_BYTES)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void blkdev_copy_endio(struct blkdev_copy_io *cio)
+{
+	if (cio->endio) {
+		cio->endio(cio->private, cio->status, cio->copied);
+		kfree(cio);
+	} else {
+		struct task_struct *waiter = cio->waiter;
+
+		WRITE_ONCE(cio->waiter, NULL);
+		blk_wake_io_task(waiter);
+	}
+}
+
+/*
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to complete.
+ * Returns the length of bytes copied or error
+ */
+static ssize_t blkdev_copy_wait_io_completion(struct blkdev_copy_io *cio)
+{
+	ssize_t ret;
+
+	for (;;) {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(cio->waiter))
+			break;
+		blk_io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	ret = cio->copied;
+	kfree(cio);
+
+	return ret;
+}
+
+static void blkdev_copy_offload_dst_endio(struct bio *bio)
+{
+	struct blkdev_copy_offload_io *offload_io = bio->bi_private;
+	struct blkdev_copy_io *cio = offload_io->cio;
+
+	if (bio->bi_status) {
+		cio->copied = min_t(ssize_t, offload_io->offset, cio->copied);
+		if (!cio->status)
+			cio->status = blk_status_to_errno(bio->bi_status);
+	}
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&cio->refcount))
+		blkdev_copy_endio(cio);
+}
+
+/*
+ * @bdev:	block device
+ * @pos_in:	source offset
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @endio:	endio function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	endio function will be called with this private data,
+ *		for synchronous operation this should be NULL
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * For synchronous operation returns the length of bytes copied or error
+ * For asynchronous operation returns -EIOCBQUEUED or error
+ *
+ * Description:
+ *	Copy source offset to destination offset within block device, using
+ *	device's native copy offload feature.
+ *	We perform copy operation by sending 2 bio's.
+ *	1. We take a plug and send a REQ_OP_COPY_SRC bio along with source
+ *	sector and length. Once this bio reaches request layer, we form a
+ *	request and wait for dst bio to arrive.
+ *	2. We issue REQ_OP_COPY_DST bio along with destination sector, length.
+ *	Once this bio reaches request layer and find a request with previously
+ *	sent source info we merge the destination bio and return.
+ *	3. Release the plug and request is sent to driver
+ *	This design works only for drivers with request queue.
+ */
+ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
+			    loff_t pos_out, size_t len,
+			    void (*endio)(void *, int, ssize_t),
+			    void *private, gfp_t gfp)
+{
+	struct blkdev_copy_io *cio;
+	struct blkdev_copy_offload_io *offload_io;
+	struct bio *src_bio, *dst_bio;
+	ssize_t rem, chunk, ret;
+	ssize_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
+	struct blk_plug plug;
+
+	if (!max_copy_bytes)
+		return -EINVAL;
+
+	ret = blkdev_copy_sanity_check(bdev, pos_in, bdev, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 1);
+	cio->waiter = current;
+	cio->endio = endio;
+	cio->private = private;
+
+	/*
+	 * If there is a error, copied will be set to least successfully
+	 * completed copied length
+	 */
+	cio->copied = len;
+	for (rem = len; rem > 0; rem -= chunk) {
+		chunk = min(rem, max_copy_bytes);
+
+		offload_io = kzalloc(sizeof(*offload_io), GFP_KERNEL);
+		if (!offload_io)
+			goto err_free_cio;
+		offload_io->cio = cio;
+		/*
+		 * For partial completion, we use offload_io->offset to truncate
+		 * successful copy length
+		 */
+		offload_io->offset = len - rem;
+
+		src_bio = bio_alloc(bdev, 0, REQ_OP_COPY_SRC, gfp);
+		if (!src_bio)
+			goto err_free_offload_io;
+		src_bio->bi_iter.bi_size = chunk;
+		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+
+		blk_start_plug(&plug);
+		dst_bio = blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DST, gfp);
+		dst_bio->bi_iter.bi_size = chunk;
+		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
+		dst_bio->bi_private = offload_io;
+
+		if (rem != chunk)
+			atomic_inc(&cio->refcount);
+		submit_bio(dst_bio);
+		blk_finish_plug(&plug);
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+
+	if (cio->endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_io_completion(cio);
+
+err_free_offload_io:
+	kfree(offload_io);
+err_free_cio:
+	cio->copied = min_t(ssize_t, cio->copied, (len - rem));
+	cio->status = -ENOMEM;
+	if (rem == len) {
+		kfree(cio);
+		return cio->status;
+	}
+	if (cio->endio)
+		return cio->status;
+
+	return blkdev_copy_wait_io_completion(cio);
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6ab3b0d60315..81558cb7c019 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1042,6 +1042,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
+			    loff_t pos_out, size_t len,
+			    void (*endio)(void *, int, ssize_t),
+			    void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

