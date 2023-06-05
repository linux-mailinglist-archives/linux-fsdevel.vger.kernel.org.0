Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9497225B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjFEM3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjFEM3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:41 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B28F9
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230605122936epoutp02d5560f4aef4c46b2f7376456a0eca35e~lwx__X4Et0553505535epoutp02Z
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230605122936epoutp02d5560f4aef4c46b2f7376456a0eca35e~lwx__X4Et0553505535epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968176;
        bh=FZjAen5BLaL48oB6pQ6fLBXdXNFuo0Xeex4cPJyfepw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9l2XqAgDQZGZN8/SjYBVxb0q1uHwOXmN1LsCXKb51nPHTRDGILK0zIBshgiV5TXW
         KWygpMswL4oTGnS2dI56v6T5g3k8fBWtE5p5q1Or5LJz7k0OIdrRXqipha6BadzfWw
         XHW+SMaNfuJbMRgiPvL1uEQe1GB3ZPViWAT/FlCU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122935epcas5p4fa7c841a0718ed12c7422ced406345f0~lwx_XJsvk0962809628epcas5p4i;
        Mon,  5 Jun 2023 12:29:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QZXws5zh0z4x9Pv; Mon,  5 Jun
        2023 12:29:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.F6.44881.D25DD746; Mon,  5 Jun 2023 21:29:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122208epcas5p297068ea23b0aff43e40751219574ff9f~lwreFrU9P2830028300epcas5p2Q;
        Mon,  5 Jun 2023 12:22:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605122208epsmtrp228fa4e823273dbca931ac9e52f1381c3~lwreEen5A0879508795epsmtrp2F;
        Mon,  5 Jun 2023 12:22:08 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-66-647dd52d779d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.B5.28392.073DD746; Mon,  5 Jun 2023 21:22:08 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122203epsmtip2ef3933d0ab30729821518ffb0b7096f2~lwrZHH17B2137821378epsmtip2Q;
        Mon,  5 Jun 2023 12:22:03 +0000 (GMT)
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
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 3/9] block: add emulation for copy
Date:   Mon,  5 Jun 2023 17:47:19 +0530
Message-Id: <20230605121732.28468-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjOd057ekpkOcAM37hsXdEs3MutfEwu011yhMURmYHIFBt6BATa
        2hZQ0QkDhEG4DaauXMYAuTPCVaAwseg6bmEZUDLmBmpxYQu3YQJaGQIF3b/ne973eS/Pl5fE
        zVs5VmSMRMnIJaI4PmHC6hq0P+bsPPWFWDBf7IRahm/j6FLBJo4aH+YT6OngM4C+XvkLR/qB
        TIAm9AfQ3A8BqH+phI3uD/RgqK/yCobqG3/GkPrGKoauaHQAzU+pMNQ/44hufFXNQn39Qyw0
        0VtKoOs18xyUM91NoFrtcwxpitIw1K1PBajLcB1HN58us9CdGWv0e04WQOObWjYybJQSJw7T
        E5NBtGp2jKB7VA859PijVhbdXudAT4wl0G0Nlwm6vfpLWn0/haCr8orYdG7aEkGvzs+w6OVb
        UwSd19EA6PaRZHqt7XCw2buxvtGMSMzIeYwkUiqOkUT58YNCIk5GeAkFbs5uPsibz5OI4hk/
        /qmzwc5nYuK2feLzEkVxCdtUsEih4Lv6+8qlCUqGFy1VKP34jEwcJ/OUuShE8YoESZSLhFEe
        dxMI3L22Ez+IjV4eGwCyEv9P7v24zkkBaR7ZgEtCyhNmqueIbGBCmlNqAKsWpzHj4xmAORsp
        e5E1AK9u1WD7knJV3y42p3oBfKIXGJMyMDg98w2eDUiSoBzhyBa5wx+k6nCYuj7K2hHg1BIO
        qwq5O9iCEsL6u6u7PIt6FQ486AE72JQ6DisN2t06kHKF+bNmOzSXeg0ujGlwY4oZHLqm3yt5
        BKZ1luA7vSB1jws7NrLYxkFPwWltPsuILeATbQfHiK3g2lI/YcRJsL64jjCK0wFUTauAMRAA
        M4bzd4fAKXvY0utqpG3h1eGbmLHxAZhr0O+ZYgq7y/exHWxqqdirfwjq1lP3MA3Lm+4Ao1l5
        ALYX/8MuADzVCwupXlhI9X/rCoA3gEOMTBEfxSi8ZO4SJum/X46UxreB3dtxCOwGv86tuGgA
        RgINgCTOP2jaG5gsNjcViz79jJFLI+QJcYxCA7y2DS/ErV6OlG4fn0QZ4ebpI/AUCoWePh5C
        N76l6TG/oUhzKkqkZGIZRsbI93UYybVKwY7wTr8Xd05XZJNYOvi8tvxWmMEjai3okZ+/oP5y
        2QX6XBmusP7Yu9TEVnTGweW7up/CinxjfNV+0lonFO5gwXmTelwxHnZ+Mvad239nmnDqtrIm
        We9Xv2XzeF347WJqiICLWnS/nS9bSJq1T76olNjFvtR8tHkxhNdZ83o+qrEOtMzo2vQy6Gz5
        k0e9RzK3Pncys/HhBKSLNOJKJ3Wae7mJ5fjsR7ywE5FJiQtnR//oe6P2z9YHb4eTXDJ3o/Fa
        WsYvFwq7ThZo3bPxuQ9D7TphycRAWWpoUj1pFe5/Oj145BU2TvlsjWpmW3TWK9pLHsWEY+hQ
        k5WJ2RwWKrh78ftmPksRLXJzwOUK0b9/gZioxAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXVBMYRzG5z3n7NlTM8tpq/GyY2Nn+hAiJa80Psd46aa4KYzasWdS2m1n
        V5LGSOuzSLYmdoskgzLjYwvFKWv7kiw7tqSSol2EKXEhJbE1Ztw9z/N7/s/VnyHFH6hZTKJq
        D6dRyZNltDt1t17ms1BtP6BYrH8Xim4+aSJRVt44ia73nKbR5/pvABV+/Ukih/kYQHbHNNT3
        cBWqHSwSoE5zDYH4S3oClV9vJNCD0mEC6S0vAXK2GwlU2zUflR69TCG+toVC9vvFNCq54hSi
        nI5qGl1t/k0gS76OQNWOQwDdHSsh0Y3PQxR63CVB/TnHAXo+3ixAYyPF9GoptrdFYmOvlcY1
        xh4hfv7mNoUrrwViuzUVmypO0Ljy8kH8oDOTxmW5+QJ8SjdI42FnF4WH6tppnFtVAXBlawb+
        bpJGeWx1j1BwyYl7Oc2ilfHuu4asZqAuWrnvxaMfwkygC8kGbgxkQ+EFI09kA3dGzFYDWFlw
        lZ4CM+GV8QZySnvC8t8fhFMlHQGfvOr5axiGZufD1gnGlXuxVSS0juYLXIZksyjY+frT5LUn
        GwbLbcOUS1OsLzR31wCXFrHh8NJYM+kaguwieLrXwxW7sSvggNUyGYv/VtqHIqbaHrDF4Jhc
        IVkfqLtTROYB1vgfMv6HLgKiAszk1FplglIbrF6i4tKCtHKlNlWVELQzRWkCk78QGFgN+Iqv
        QRZAMMACIEPKvET3N2UoxCKFPH0/p0mJ06Qmc1oLkDCUbIbIlt0SJ2YT5Hu43Ryn5jT/KMG4
        zcokkrJh//SRmNmDTsMhi8SfM1zbrLmory+L/7im0XTjrGhC0rp2XnJkWMa58KYX8XrzoPRM
        31P7cb+QZ30lAum6ez4308Pj+v3luTir1MSHxnp6lNZNU+VEbesQp/EXvKPJQlrULamPYbcE
        RJ6wp0W3NVUVzlnxOL2B2WIb9W/8FmLzovi1ecJmNLd2jt+qxJPOuF/eyxTOl3t9y7rL1v16
        uuGIdPtDi3dQDRkcayuIuXUr/mzH9tjgiOmPGgLW955P8uV3pvRqzEsNE7e/OEZn7CDMeYff
        N4alJ/XvOCLcuMAtOor3ff82NmVJ3ciZAFoZ3jAwMFBw4MdybQDXVu5nkFHaXfLgQFKjlf8B
        pK5sbHoDAAA=
X-CMS-MailID: 20230605122208epcas5p297068ea23b0aff43e40751219574ff9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122208epcas5p297068ea23b0aff43e40751219574ff9f
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122208epcas5p297068ea23b0aff43e40751219574ff9f@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the devices which does not support copy, copy emulation is added.
It is required for in-kernel users like fabrics, where file descriptor is
not available and hence they can't use copy_file_range.
Copy-emulation is implemented by reading from source into memory and
writing to the corresponding destination asynchronously.
Also emulation is used, if copy offload fails or partially completes.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 178 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-map.c        |   4 +-
 include/linux/blkdev.h |   3 +
 3 files changed, 182 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index b8e11997b5bf..99b65af8bfc1 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -300,6 +300,175 @@ static ssize_t __blkdev_copy_offload(
 	return blkdev_copy_wait_completion(cio);
 }
 
+static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
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
+static void blkdev_copy_emulate_write_endio(struct bio *bio)
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
+	bio_map_kern_endio(bio);
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
+static void blkdev_copy_emulate_read_endio(struct bio *read_bio)
+{
+	struct copy_ctx *ctx = read_bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+
+	if (read_bio->bi_status) {
+		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+						cio->pos_in;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+		kfree(bvec_virt(&read_bio->bi_io_vec[0]));
+		bio_map_kern_endio(read_bio);
+		kfree(ctx);
+
+		if (atomic_dec_and_test(&cio->refcount)) {
+			if (cio->endio) {
+				cio->endio(cio->private, cio->comp_len);
+				kfree(cio);
+			} else
+				blk_wake_io_task(cio->waiter);
+		}
+	}
+	schedule_work(&ctx->dispatch_work);
+	kfree(read_bio);
+}
+
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ * Returns the length of bytes copied or error if encountered
+ */
+static ssize_t __blkdev_copy_emulate(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *in = bdev_get_queue(bdev_in);
+	struct request_queue *out = bdev_get_queue(bdev_out);
+	struct bio *read_bio, *write_bio;
+	void *buf = NULL;
+	struct copy_ctx *ctx;
+	struct cio *cio;
+	sector_t buf_len, req_len, rem = 0;
+	sector_t max_src_hw_len = min_t(unsigned int,
+			queue_max_hw_sectors(in),
+			queue_max_segments(in) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_dst_hw_len = min_t(unsigned int,
+		queue_max_hw_sectors(out),
+			queue_max_segments(out) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_hw_len = min_t(unsigned int,
+			max_src_hw_len, max_dst_hw_len);
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+	cio->pos_in = pos_in;
+	cio->pos_out = pos_out;
+	cio->waiter = current;
+	cio->endio = endio;
+	cio->private = private;
+
+	for (rem = len; rem > 0; rem -= buf_len) {
+		req_len = min_t(int, max_hw_len, rem);
+
+		buf = blkdev_copy_alloc_buf(req_len, &buf_len, gfp_mask);
+		if (!buf)
+			goto err_alloc_buf;
+
+		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+		if (!ctx)
+			goto err_ctx;
+
+		read_bio = bio_map_kern(in, buf, buf_len, gfp_mask);
+		if (IS_ERR(read_bio))
+			goto err_read_bio;
+
+		write_bio = bio_map_kern(out, buf, buf_len, gfp_mask);
+		if (IS_ERR(write_bio))
+			goto err_write_bio;
+
+		ctx->cio = cio;
+		ctx->write_bio = write_bio;
+		INIT_WORK(&ctx->dispatch_work, blkdev_copy_dispatch_work);
+
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_iter.bi_size = buf_len;
+		read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+		bio_set_dev(read_bio, bdev_in);
+		read_bio->bi_end_io = blkdev_copy_emulate_read_endio;
+		read_bio->bi_private = ctx;
+
+		write_bio->bi_iter.bi_size = buf_len;
+		write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+		bio_set_dev(write_bio, bdev_out);
+		write_bio->bi_end_io = blkdev_copy_emulate_write_endio;
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		write_bio->bi_private = ctx;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(read_bio);
+
+		pos_in += buf_len;
+		pos_out += buf_len;
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
+	kvfree(buf);
+err_alloc_buf:
+	cio->comp_len -= min_t(sector_t, cio->comp_len, len - rem);
+	if (!atomic_read(&cio->refcount)) {
+		kfree(cio);
+		return -ENOMEM;
+	}
+	/* Wait for submitted IOs to complete */
+	return blkdev_copy_wait_completion(cio);
+}
+
 static inline ssize_t blkdev_copy_sanity_check(
 	struct block_device *bdev_in, loff_t pos_in,
 	struct block_device *bdev_out, loff_t pos_out,
@@ -350,9 +519,16 @@ ssize_t blkdev_copy_offload(
 	if (ret)
 		return ret;
 
-	if (blk_queue_copy(q_in) && blk_queue_copy(q_out))
+	if (blk_queue_copy(q_in) && blk_queue_copy(q_out)) {
 		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
 			   len, endio, private, gfp_mask);
+		if (ret < 0)
+			ret = 0;
+	}
+
+	if (ret != len)
+		ret = __blkdev_copy_emulate(bdev_in, pos_in + ret, bdev_out,
+			 pos_out + ret, len - ret, endio, private, gfp_mask);
 
 	return ret;
 }
diff --git a/block/blk-map.c b/block/blk-map.c
index 44d74a30ddac..ceeb70a95fd1 100644
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
index 96e986b37a29..69fe977afdc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1057,6 +1057,9 @@ ssize_t blkdev_copy_offload(
 		struct block_device *bdev_in, loff_t pos_in,
 		struct block_device *bdev_out, loff_t pos_out,
 		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
+void bio_map_kern_endio(struct bio *bio);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

