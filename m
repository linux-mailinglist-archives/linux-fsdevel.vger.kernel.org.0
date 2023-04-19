Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3E6E7907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjDSLyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDSLyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:54:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B9146CD
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 04:54:29 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230419115428epoutp0176556591fcd1df9f692cdba4f38d6038~XU_4eLewK1494514945epoutp01f
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:54:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230419115428epoutp0176556591fcd1df9f692cdba4f38d6038~XU_4eLewK1494514945epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681905268;
        bh=QlVDKHXxeSIn7ttIPNdI5Kwjrx+MA7ilbM9ui+Z3ous=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEwNm7q62VYI0YSA2KlykHgv9dY4J55g/GhAGROM0okwwXyAa5PCbvDvGylkuUhaX
         m/f8dcwTObPxOUE7IleWoDgkir+uQ2TkehqcIlF+S+67KuYwbEH366VgBK0Tv5cXnq
         Vy1ny/iKVMtgqepdzTPdr73X829cUAOj54TsNUNc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230419115427epcas5p4cb4a56e7e55f15087e9498b3a825bef5~XU_3oi3bu0896108961epcas5p4M;
        Wed, 19 Apr 2023 11:54:27 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q1fN12tJMz4x9Pp; Wed, 19 Apr
        2023 11:54:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.04.09987.176DF346; Wed, 19 Apr 2023 20:54:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230419114705epcas5p376d05f7c5f892d82590c2137650dd291~XU4cZ_fLw0477504775epcas5p33;
        Wed, 19 Apr 2023 11:47:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419114705epsmtrp29b292ae34f628324de1701f82e39a126~XU4cYkyw22700627006epsmtrp2k;
        Wed, 19 Apr 2023 11:47:05 +0000 (GMT)
X-AuditID: b6c32a4b-7fbff70000002703-11-643fd6718857
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.87.08279.9B4DF346; Wed, 19 Apr 2023 20:47:05 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114701epsmtip1854900c6066e7cb09f6e4078a2838c2d~XU4Y5mivx2050920509epsmtip1K;
        Wed, 19 Apr 2023 11:47:01 +0000 (GMT)
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
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 2/9] block: Add copy offload support infrastructure
Date:   Wed, 19 Apr 2023 17:13:07 +0530
Message-Id: <20230419114320.13674-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230419114320.13674-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeubfctmZlV2DjAJtrasYEVmhnYQcUOx/oTWAJw2wYJqlNuQFG
        aUsfMNFlIANB5TEqRgsTgeGQMojAHIIwKamMgjHjNZCBblAzdbwXGXHgKBc3//vO9/u+3+vk
        x8FdTrI9OYkqPa1VyZUCYhPrWpePrzBlWBonmq9zRg22Wzg6UbSCI/N4IYEedy0AdG5uGUf3
        f5Si9plSJzR68zqGblQWY+iK2Yqhtop5DFmfTROo2DIMkH3IhKH2u37oRnsPCw20lhGo/LKd
        jSzGLAy1TGUCdO1pOY7qH8+y0E93vdCdlW6n9yE1MBhOme7dJqjrpnE2dWfiKosauG2gGmvz
        CKrpmy+ottEMgsrPmiGo2Y4hgiporgVUU+8xarFxC9U4NY1FOsck7Uyg5XG0lk+rFOq4RFV8
        qCD8oGyvLDBIJBaKg9F7Ar5KnkyHCvZFRAr3JyrXNiDgp8qVhjUqUq7TCQJ27dSqDXqan6DW
        6UMFtCZOqZFo/HXyZJ1BFe+vovUhYpHo3cA14ZGkhKrcVUxTfOizhr6UDLB84BTgciApgaeX
        RlgO7EK2ATiWHX4KbFrDCwCW2cws5vEEwNWpZvYpwFl3VK6oGEM7gDl/ezOabAzaW35wcmgI
        0g/2PuM4eDcyB4fz9rz1RDjZj8F/mmdxh9uVPABzLvxBODCLfAs+Kq5eN/PIEJhZE83UCoCF
        9zY7FFxyB/y2w7ju5JGbYc+FqfWmcfJNmPV9Ke5ID8kqLizMLWEzk+2DqxcHcQa7wkfdzRu8
        J1ycaScYnAavnK0hGPOXAJp+MQEmIIXZtkLc0QRO+sCG1gCGfgOW2OoxprAzzH86hTE8D7Zc
        fI63wrqGSxv5PeDwUuYGpmDlZDdgFlcAYP+irAjwTS/MY3phHtP/lS8BvBZ40BpdcjytC9Rs
        V9Fp//2wQp3cCNYvwje8Bfx+f87fAjAOsADIwQVuvL6wkDgXXpz8aDqtVcu0BiWts4DAtXV/
        hXu+qlCvnZRKLxNLgkWSoKAgSfD2ILHAnfd2aI/ChYyX6+kkmtbQ2uc+jMP1zMD4HVGW5fqA
        WKPd62Hi54t15sgHvhL/aez4YEeAV2MM+aTi2M8xZdsGS0Q3Rw59F+lenfWxMbo0Raz5JKpp
        6bj0aFJA1/y5BeVoIS6ILhN+PWGzlcfuvryVmPTMjKjJOG3uId129G+LMpxNz08f4XB2H77K
        Ixf2jL+uqKvIa/2woJMj7RTlhp2srmmTjt068xfbNbVIY431CKuYT+389U/viYixg6/sCjQ2
        263c0hw9ErvX9MXmtghrjcLQInvf/rIY9/O51tc+cPfhDrgm9E7+NuR9/qXYtpYj75jDpfmH
        93j7b3FSnEgzZM8MiObSRh5+ekYym/lAVmUOWf7IavB7eU7A0iXIxb64Vif/FziYlyeaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnO7OK/YpBrdPiFusP3WM2aJpwl9m
        i9V3+9ksXh/+xGgx7cNPZosH++0t9r6bzWpx88BOJos9iyYxWaxcfZTJYvfCj0wWR/+/ZbOY
        dOgao8XTq7OYLPbe0rbYs/cki8XlXXPYLOYve8pucWhyM5PFjieNjBbbfs9ntlj3+j2LxYlb
        0hbn/x5ndZDwuHzF22PW/bNsHjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObR2/zOzaP
        9/uusnn0bVnF6LH5dLXH501yHpuevGUK4IvisklJzcksSy3St0vgyljc8Y+pYFJExfozhQ2M
        P927GDk4JARMJBb9zeti5OIQEtjNKHHx+jLGLkZOoLikxLK/R5ghbGGJlf+es0MUNTNJdN/a
        xwTSzCagLXH6PwdIXERgArPEpfsNbCAOs8ADJonzz7+wgnQLC7hLtM18wQZiswioSryatJQV
        pJlXwEqicUU4xBH6Ev33BUEqOAWsJZbvmwy2VwiooufQP7B7eAUEJU7OfMICYjMLyEs0b53N
        PIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjWEtzB+P2VR/0
        DjEycTAeYpTgYFYS4XW3sUsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklqdmpq
        QWoRTJaJg1OqgWmCSzjXLB7RohYOdd26w9kiy0qD5QsfRTyb0Frk3MN3P5lRsn7OTU2+N0sD
        0j72fbl2+F16ftmNS5mvO8VOdk7JZH3Bl6woumymWnN5Pfe/pXv5r0ebcPv9j2SuqgrhcXtg
        wjHxYOTue9qCv9vKzc2qfk0I29eWzll2plfM0OtW2v/n+4Nrp/Bz/331ryLFjsnXxOhc7euZ
        7/+rqp/x+57+XGHdsR3Pgnul46TyDKsmpT+9dO2ol4vv9nU7FBf8OcC7a/J8X/N/nmuy0+rX
        G1a8vjZr8UnxPzUiDyvF/BdIGuZFL7i26ZzvubUneWzUnpxde1M7zHzpPU299r1G+f92puf8
        2POrPHn5iWmtR5RYijMSDbWYi4oTAXRMuvZSAwAA
X-CMS-MailID: 20230419114705epcas5p376d05f7c5f892d82590c2137650dd291
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419114705epcas5p376d05f7c5f892d82590c2137650dd291
References: <20230419114320.13674-1-nj.shetty@samsung.com>
        <CGME20230419114705epcas5p376d05f7c5f892d82590c2137650dd291@epcas5p3.samsung.com>
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
index e59c3069e835..ed089e703cb1 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,241 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to make it through
+ * blkdev_copy_write_endio.
+ */
+static int blkdev_copy_wait_completion(struct cio *cio)
+{
+	int ret;
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
+	__free_page(bio->bi_io_vec[0].bv_page);
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
+static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out, size_t len,
+		cio_iodone_t endio, void *private, gfp_t gfp_mask)
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
+		INIT_WORK(&ctx->dispatch_work, blkdev_copy_dispatch_work);
+
+		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+		read_bio->bi_iter.bi_size = copy_len;
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_end_io = blkdev_copy_offload_read_endio;
+		read_bio->bi_private = ctx;
+
+		__bio_add_page(write_bio, token, PAGE_SIZE, 0);
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
+	__free_page(token);
+err_token:
+	cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
+	if (!atomic_read(&cio->refcount))
+		return -ENOMEM;
+	/* Wait for submitted IOs to complete */
+	return blkdev_copy_wait_completion(cio);
+}
+
+static inline int blkdev_copy_sanity_check(struct block_device *bdev_in,
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
+ *	device. Max total length of copy is limited to MAX_COPY_TOTAL_LENGTH
+ */
+int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *q_in = bdev_get_queue(bdev_in);
+	struct request_queue *q_out = bdev_get_queue(bdev_out);
+	int ret;
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
+EXPORT_SYMBOL_GPL(blkdev_issue_copy);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk.h b/block/blk.h
index 62fca868bc61..d245817d2242 100644
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
index 8ef209e3aa96..f8aa539dc4c8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -421,6 +421,7 @@ enum req_flag_bits {
 	 */
 	/* for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	__REQ_COPY,		/* copy request */
 
 	__REQ_NR_BITS,		/* stops here */
 };
@@ -445,6 +446,7 @@ enum req_flag_bits {
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
+#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 
@@ -475,6 +477,11 @@ static inline bool op_is_write(blk_opf_t op)
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
@@ -534,4 +541,22 @@ struct blk_rq_stat {
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

