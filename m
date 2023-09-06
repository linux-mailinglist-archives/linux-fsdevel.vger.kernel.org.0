Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4930479425F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjIFRyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjIFRye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:54:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7719AB
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:20 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230906175419epoutp0446437fa7e396fcb8d8e595b5acdbf173~CYNCxh7Xw3254332543epoutp04j
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230906175419epoutp0446437fa7e396fcb8d8e595b5acdbf173~CYNCxh7Xw3254332543epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022859;
        bh=dSIu1Pc3TbUY1x4xw2AiToASIfGpKCjKLydT9Yx11zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFS/txiH/Mmo414E9QiGgzXEbtHEB+dDanRe7sNx8rdZAIRLAp3j0LpXNlYStO3ol
         UMcTu5c+bD7NEhkCt9EWdNC2hupCdfaFkj4TszW8SgkMMCAVHFApDEhv7RfZDyNseO
         JJ90E7UjwfLZh10JnTf5fz9AV6V0sUltyCLlGtZ4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230906175418epcas5p35e2257c8a9f7e1d013aeb4aca3d52906~CYNCIqfdP2681826818epcas5p3t;
        Wed,  6 Sep 2023 17:54:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rgqkc29Tfz4x9Pv; Wed,  6 Sep
        2023 17:54:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.D4.09635.8CCB8F46; Thu,  7 Sep 2023 02:54:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3~CXO8pz8V02340723407epcas5p3u;
        Wed,  6 Sep 2023 16:43:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164312epsmtrp209da0fc220eb8c775e923d6871810929~CXO8oufb_1133211332epsmtrp2M;
        Wed,  6 Sep 2023 16:43:12 +0000 (GMT)
X-AuditID: b6c32a4b-563fd700000025a3-ad-64f8bcc8e9a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.0B.08742.F1CA8F46; Thu,  7 Sep 2023 01:43:11 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164309epsmtip25245d3e436d4490fd8cb3b6fd875a2be~CXO56pnY41829618296epsmtip2X;
        Wed,  6 Sep 2023 16:43:09 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 03/12] block: add copy offload support
Date:   Wed,  6 Sep 2023 22:08:28 +0530
Message-Id: <20230906163844.18754-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRzu3Hu53GXc5rLA7BFT8FoWb9aF9YLycHSY60hKQ5MTU+LG3mGJ
        ZXdnH2BZtoAEkrI8smR98JZXAi6mBC4ZRMAWwxDjEgyJQ2AogTwmwDGlXRbK/77v+53v9zrn
        ECjvb9ydSJJrWJVcLKNwJ+xmp9frfj23VySBObUcutH8E0pn5D9D6frf9Tg93bkA6Ik72YA2
        zV50oIfvfIfQtfVdCF3YYQH05F0DQptGfOiyzysx+rapF6MHWy/hdMnVSUe6uvs5Qv+WPwno
        m09LULph+jFG94xsofufdTtEujH9965jzGCfljHWncGZ5srPmLZhHc5U5BU5MOcyZ3FmfnIE
        Yx6338WZvBt1gFk0bmOMEzNIzKa45L1SVixhVZ6sPEEhSZInhlGHYuP3xweLAgV+ghB6N+Up
        F6ewYdSB6Bi/qCSZdVbKM1Us01qlGLFaTQWE71UptBrWU6pQa8IoVimRKYOU/mpxilorT/SX
        s5pQQWDgrmDrwePJUt0/K7gyI/LE4NkcTAeeCHMBh4BkEJzvmURygRPBI9sALE5fWicLAOor
        RlE7WQLw+WgfsmEpKrrgaA+YACx6WLNOshBYW55pJQSBkz7w51XCpruSOhQ2tVUAG0HJBgQW
        V/6K2lK5kKHwSn4XZsMY+RocHNXhNsy16unmQdSWCJIBUD/mbJM55B6YkT4A7EecYW/xxJoV
        JT1g5rcX11qFZDYH6m5VA7v3AJwa4Nu7doGPum842rE7XJw14XacBmu/rMHt3tMAGoYMwB6I
        gFlm/VoPKOkFG1sD7PJWeN7cgNjrvgzPPZ1Y3woXtlzZwDvgN42l6/k3Q8ty+jpm4MTytbUe
        eGQegOVlx/KBp+GFcQwvjGP4v3IpQOvAZlapTklk1cFKoZxN+++WExQpRrD2/r0PtYDx+3P+
        HQAhQAeABEq5cmc9liQ8rkT80cesShGv0spYdQcItq67AHV3S1BYP5BcEy8ICgkMEolEQSFC
        kYDic6ezLkt4ZKJYwyazrJJVbfgQguOuQ/4c+tQ3InzscJzHnsxOh+FNp8x9TaX7oD4i9et3
        vvcdYE92jN3K/uCHt+tFA6WxpoMPhGddi3lCVWjase3j5BdR/LbtzSeCQ+ZruEts1YO5yDdM
        zv01hUd63/Id/zAup3pVREYLvzr8o2Pu+1uimy1/vOqN+LU3JBEJw8uhwrAnxjMLu2XvIk7b
        pnZSluMc3r36azPv9XpZsCG3gqbF8vBPqq669swxgpJ9EbEtfDf94szJiiNvmrtXLrS3Ppqy
        SM+bm10cD95fMpXHSfmqXwpXnHY077ouW/jrVNUI3nd0/HRBX1ZsnmFaFGVcjWQut/K7tK9w
        I5Whqe5bjya8VFnl87CMwtRSscAbVanF/wKBF6htiAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvK78mh8pBjs7bSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrR4cqCd0WLvu9msFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
        9p5ksbi8aw6bxfxlT9ktlh//x2RxY8JTRottv+czW6x7/Z7F4sQtaYvzf4+zOoh6nL+3kcXj
        8tlSj02rOtk8Ni+p99h9s4HNY3HfZFaP3uZ3bB4fn95i8Xi/7yqbR9+WVYwenzfJeWx68pYp
        gCeKyyYlNSezLLVI3y6BK6Phzw+2giaHiss9HSwNjD+Nuxg5OSQETCQmT57B3sXIxSEksJtR
        4sqNncwQCUmJZX+PQNnCEiv/PYcqamaSWHzhEFMXIwcHm4C2xOn/HCBxEYEuZonOne9YQBxm
        gR1MEs//t7GDdAsLWEnMm3CUBcRmEVCVuHyngQ3E5gWKN566zAwySEJAX6L/viBImFPAWqKp
        8SIjiC0EVHJn1WtGiHJBiZMzn4CNYRaQl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsW
        GOallusVJ+YWl+al6yXn525iBEeoluYOxu2rPugdYmTiYDzEKMHBrCTC+07+W4oQb0piZVVq
        UX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGpnUfAqz1ZYqcNsRd7DW5
        uTdTe+vhTxOd93nYpuXc+Xp/2nK+oymhz2rZnS7Oeqtt4P89fp5Hk/3CLXpmR75t8zuk6M5h
        wPH0Au+KTqeZ4sFn5B5Yn+fMnXONa1uHdsinmT+2pfTU7VlqJPujvvzjdNOARac0I2/9ffJD
        fO/lyBWzLHe1dP6Jk4lteNHGz7y2Y339hgjeAutXvG2re58v2/Fhdlvn2kVHq0JnXhIK5w+6
        97Vhz7Q5gtv3Rc3bJuuld+N7/yrZ1fJS0RwJ/r+Y7986Yit3el260a7D8+zLjRs/14bMmfFn
        Zav12be7XXzXKV5mzt9Wfzp8h2U9W+0alWXW6hudvbyfCVVJFOhmP1FiKc5INNRiLipOBABx
        kMRwPwMAAA==
X-CMS-MailID: 20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 block/blk-lib.c        | 202 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 206 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..d22e1e7417ca 100644
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
@@ -115,6 +131,192 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
+	    len >= BLK_COPY_MAX_BYTES)
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
+ *	device's native copy offload feature. This function can fail, and
+ *	in that case the caller can fallback to emulation.
+ *	We perform copy operation using 2 bio's.
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
+		if (!dst_bio)
+			goto err_free_src_bio;
+		dst_bio->bi_iter.bi_size = chunk;
+		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
+		dst_bio->bi_private = offload_io;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(dst_bio);
+		blk_finish_plug(&plug);
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+
+	if (atomic_dec_and_test(&cio->refcount))
+		blkdev_copy_endio(cio);
+	if (cio->endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_io_completion(cio);
+
+err_free_src_bio:
+	bio_put(src_bio);
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
index 7548f1685ee9..5405499bcf22 100644
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

