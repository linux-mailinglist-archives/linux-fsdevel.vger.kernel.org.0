Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7646E790E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjDSLyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjDSLyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:54:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41B1444E
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 04:54:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419115431epoutp04e9d782b58613b6a0f75fc3f9a35abcb0~XU_71ORi81730617306epoutp04n
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419115431epoutp04e9d782b58613b6a0f75fc3f9a35abcb0~XU_71ORi81730617306epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681905271;
        bh=zU+GbPVLniyzLXqnw+/kZiZDz+gADtrdaFwLreejzFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgtVJ3SXi7W5wDHHdqYyoVbZR1GnohaIXEc1FtQmqpJSJ0KP228mGK6hSMt9Pk63X
         WktqlhaxOoweYaIiWeFCOwjb8jIW6kMNQJ3bcgYUpX23f2hbL+imVYjeGzX1nxvt29
         MRB4C2WlNjJG7L1HGOuTRG+HExTtoYxRYZVpQMT0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230419115430epcas5p4c4fc875af9bfa3e1d1b7a0053d658018~XU_68lK_40259502595epcas5p4H;
        Wed, 19 Apr 2023 11:54:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q1fN46btRz4x9Pw; Wed, 19 Apr
        2023 11:54:28 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.6D.09540.476DF346; Wed, 19 Apr 2023 20:54:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230419114714epcas5p33084dcdc06787292b46c376aa51e5ec5~XU4k0bKDE0243802438epcas5p3C;
        Wed, 19 Apr 2023 11:47:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419114714epsmtrp287261cf1c9a9408d6e300cd342b3c5e1~XU4kyFJpe2737927379epsmtrp2E;
        Wed, 19 Apr 2023 11:47:14 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-4a-643fd674d87e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.97.08279.2C4DF346; Wed, 19 Apr 2023 20:47:14 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114711epsmtip11aa690ad8b0169d54a3eb3301fe130c7~XU4hjF8il2496324963epsmtip1C;
        Wed, 19 Apr 2023 11:47:10 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
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
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 3/9] block: add emulation for copy
Date:   Wed, 19 Apr 2023 17:13:08 +0530
Message-Id: <20230419114320.13674-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230419114320.13674-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVCUZRzHed53eVlo0BeEeKDBttdBBwzY5dgeUI4ptHekgxFqmnKEBd4W
        Yq92l0smATnkGE6zYsEQBiVuBWU4XDU2RCAiBsHEFIhFEoZDcGSSZNttofzv8/v+7t8zDxu3
        LjZzYMdKlIxcIhBRhAWrXeO8z1U5HhDNLXjqjloGbuHoVPELHDU8KCLQgmYVoG9W/sLR1I0A
        pF4qN0X3bnZi6Fp1KYbqGnox1F31BEO9ukUClfaMAzQ7psKQemI/uqbuZ6HRrgoCVV6cNUM9
        ZzIw1KFNB6h9oxJHzQvLLHR74jU0k58D0PCLPtNAe3r0TjCtmhwi6E7VAzN6+OFlFj06FE+3
        1ucSdFtNKt19L42gCzKWCHr5+hhBF16pB3TbYAq91rqbbtUuYiE7Po07GMMIohk5h5FESaNj
        JUI/Kjg0/J1wbz6X58rzQW9RHIlAzPhRQe+FuB6OFenPQHESBKJ4vRQiUCgod/+Dcmm8kuHE
        SBVKP4qRRYtkXjI3hUCsiJcI3SSM0pfH5Xp46wMj4mIacwYxWXtAkjZPB9JAtlceMGdD0gvq
        KuYxA1uT3QCevSnPAxZ6XgVwcW3D1Gg8A3C9psRsO+OP078SRocawB+rn29FZWFwc0ajN9hs
        gtwPB3Vsg25DZuPwyWwuy2Dg5DoGJ+faTA2ldpF8qF34ljAwi3SCS+P3gYEtSV/YrZ0GhkKQ
        dIdFk1YG2Zw8AGuvn8GNIVawv0zLMjBOvg4zrpbjhvqQbDCHi79XbY0aBKvmNSwj74LzfVe2
        dAe4tqQmjJwI677+gTAmZwKouqsCRkcAzBoowg1D4KQzbOlyN8qO8OxAM2ZsvAMWbGgxo24J
        O77f5j2wseX8Vn17OL6eThh3oWFmY5jxWIUATmobQDHgqF7aR/XSPqr/O58HeD2wZ2QKsZBR
        eMs8JEzif68cJRW3gn+/hsuRDjA9teLWAzA26AGQjVM2lj8f8o22towWJJ9g5NJwebyIUfQA
        b/29S3AH2yip/m9JlOE8Lx+uF5/P9/Lx5PMoO8t9fv1R1qRQoGTiGEbGyLfzMLa5QxrWZvXG
        7ktjuJ/Y5Wjqiil2J2vip6BXjpwYyC4/+WbkYENjs3P/scJQp70JwSnpr2Yu/y3xD2vZ+eyz
        p+dihY/ft/Mt/a69k+ffOet2/JfLd5t0yflNObKM1Ecmp2pVHWrb1KvYh0Sl7fFRk5EvWz54
        1F09H9p1oK/kYmSKsiTpof3OUZcazxubTaspFkdF+YdNyo7dDqNCAjwD55q+ilvLvmShE59L
        nvrt0IXI2uS6PYseXxAjM1Mwc/1djdD9Y12gZ4Qon9dRPGfHd0q0iZiXpVP344ducbifdMQ5
        YpuPOzVtw+jt4I+GVIKRPxMWpCVJMc8HcjNPXvh8ek5eVrG311Z+2tGeYiliBDwXXK4Q/AOU
        gbQaowQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUzMcRzH9/39fve7XxG/rsw3rHLWKFMa2dfDHJ3xxTz+EZnhuN8KXeWu
        8xDN5TZ3rueiuDIxO3rAFFEpXCXnonRKD0vhWra6HmiMnriLzX/vvV/vvT5/fBhSUEvNYg5H
        xnDySEmEkHamSqqEnouM70TSxaUjEN179YJE51LHSFTQkUKj3qqvAGUO/iRR11MRqujP5qHW
        Z6UEenIjnUB5BTUEKr8+RKCaCRuN0o3NAHU36QlU0bYQPakwUchSlkOja4ZuPjJmqAn02BoP
        UMnINRLd7R2g0Mu22ehzghag+rFa3hoPbHm3Ges7X9O4VN/Bx/Uf7lPY8lqJi/Iv0Lj45llc
        3qqicZK6n8YDlU00Tn6QD3Cx+TT+VuSJi6w2Yvu0Pc6rpFzE4eOcPGD1AefwQq2ZiC4RnbTq
        JoAKnF+qA04MZJfCT5oGWgecGQFbDuDX5wZqEnhAw1g1OZndYN54D39ypCZge3USTwcYhmYX
        QvMEY+/d2VQSNnaqHCaS1ZCwzzDoMLmxy6C1N4u2Z4r1gf3N7cCeXdgVsNz6EdhFkA2AKZ2u
        9tqJXQlvVWY4Dgv+TBKN43/nrtB0xepQkqwXVD/MJlMBq/8P6f9DuYDIBx5ctEIWJlMERgdG
        cif8FRKZQhkZ5n8oSlYEHL/2830MHuUP+hsBwQAjgAwpdHfZsGq1VOAilZyK5eRR++XKCE5h
        BLMZSjjTpUFn2i9gwyQx3FGOi+bk/yjBOM1SEWFDbs97g8UXNv7wSe32Dr2za6frCOQ3tgSL
        FNUrC/xz2ytmBvXEVe3t8Z6XbfJObBRPXZDXtTl2qNjDVIN+dnpNXR/jtnv7l4vv90J6+TAV
        FBF36HtygPb2/MwdRrM0wZYpChkJLUsJH94kZrpim+fGqT31eN+o7/T4y5pKS9p5v7ol6aE7
        sXax9tKyoeIc5bEs3yPbZOeU9ba1heJnocFb5pwZl6taPoeEnPZK61ibNZxWqCkz8FqV1+vm
        HJuic1clxR9Ii7cm9/QF816Obq2p6z6Y/NRye09uKb6amDAx71fQnYGxN+t+aHi1AWYsbh/N
        4efuTmw7EtWwxuY34+2wkFKESwL9SLlC8huiqIjTWgMAAA==
X-CMS-MailID: 20230419114714epcas5p33084dcdc06787292b46c376aa51e5ec5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419114714epcas5p33084dcdc06787292b46c376aa51e5ec5
References: <20230419114320.13674-1-nj.shetty@samsung.com>
        <CGME20230419114714epcas5p33084dcdc06787292b46c376aa51e5ec5@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 block/blk-lib.c        | 175 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-map.c        |   4 +-
 include/linux/blkdev.h |   3 +
 3 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ed089e703cb1..ba32545eb8d5 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -295,6 +295,172 @@ static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
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
+	kvfree(page_address(bio->bi_io_vec[0].bv_page));
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
+		__free_page(read_bio->bi_io_vec[0].bv_page);
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
+static int __blkdev_copy_emulate(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t endio, void *private, gfp_t gfp_mask)
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
+	if (!atomic_read(&cio->refcount))
+		return -ENOMEM;
+	/* Wait for submitted IOs to complete */
+	return blkdev_copy_wait_completion(cio);
+}
+
 static inline int blkdev_copy_sanity_check(struct block_device *bdev_in,
 	loff_t pos_in, struct block_device *bdev_out, loff_t pos_out,
 	size_t len)
@@ -342,9 +508,16 @@ int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
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
index 3551c3ff17cf..e75bae459cfa 100644
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
index 1bb43697d43d..a54153610800 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1057,6 +1057,9 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
 		      struct block_device *bdev_out, loff_t pos_out, size_t len,
 		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
+void bio_map_kern_endio(struct bio *bio);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

