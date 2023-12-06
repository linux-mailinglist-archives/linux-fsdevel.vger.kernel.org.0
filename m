Return-Path: <linux-fsdevel+bounces-4969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891E806C24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB501C20A15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D12E650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uQN52hz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51882D49
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:11:09 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206101107epoutp026ea02447a202c675d2b9136ee344620d~eNlmmMJUZ2243922439epoutp02I
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:11:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206101107epoutp026ea02447a202c675d2b9136ee344620d~eNlmmMJUZ2243922439epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857467;
	bh=Ff48lndit/eTqrBB/CdVOfgqav/hSRfanUmmPiHdWuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQN52hz2+IoyRnPDdGThIBI3+focXLNJGnfYB9GqOH13LIFB+9u+A4txvmwKJDn0J
	 CBiApWDf6BYKI2pz2uBsWCo47nvoCWJLoVRVPb/XE98SYxJaTsFXK4GKuWYKbwQXQX
	 aG6Xuu8oztrr5aduBuSRVQQeMZ+dQ/Rs1dkP5nKs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231206101107epcas5p1946f7fef7afffbbc255f218e0bc1fddb~eNll1doh80441904419epcas5p1s;
	Wed,  6 Dec 2023 10:11:07 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SlY892ZB5z4x9Q6; Wed,  6 Dec
	2023 10:11:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.68.19369.9B840756; Wed,  6 Dec 2023 19:11:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231206101104epcas5p41c9a32e6cbc2ef6dd8870cf60cd1c7ce~eNljw2uEJ0156001560epcas5p4j;
	Wed,  6 Dec 2023 10:11:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101104epsmtrp1bb6ea52a119faef623ae70279b30626e~eNljvswjk1053310533epsmtrp17;
	Wed,  6 Dec 2023 10:11:04 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-3e-657048b9f86e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.42.08817.8B840756; Wed,  6 Dec 2023 19:11:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101059epsmtip24a1dc46fe3d60ea974f9479bbb7215f4~eNlesowsz1180411804epsmtip2G;
	Wed,  6 Dec 2023 10:10:59 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 03/12] block: add copy offload support
Date: Wed,  6 Dec 2023 15:32:35 +0530
Message-Id: <20231206100253.13100-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRTOe+/lUkhgdxTDmy4TaEIW6oDWFXiLY4w59SJjaVyixh/gBa5A
	gLb2Y0OXIIOtzuLGV1BgbjAGDKg4vqVAZ4FBVwRRJo7vIB9hSObG0EHATluKun/POec553mf
	8+ZwcI88Zx4nRaZmlTImjU+6Eu19/gcCDLSCFXZM70G3BgdwtPbnNoGy86040s/kkWi17wlA
	i6ZPAaqovEqgCZMBQ92VhRiq0/djqLD3F4CWxsowZJx8CV3XVhGo22gh0L3Or0hUXrPkjHLv
	d5DopvkZhsbzlwAquDiGoY7FcwC1b5fj6JvVRwS6O7kPjVjNTkd5tKFsxpkemW0i6HvDGrq5
	/jOSbqn6hH7QUgrorokskr5xuciJvpTzO0mvLU0S9KPbYyR9ubUe0C3fn6XXm1+kmxcfYtI9
	76UeTmaZRFbpw8oS5IkpsqRwfvSpuFfjgkOEogCRBIXyfWRMOhvOP35CGvB6SpptJXyf00ya
	xpaSMioVP+jIYaVco2Z9kuUqdTifVSSmKcSKQBWTrtLIkgJlrDpMJBS+HGwjvp+a3LBQRyra
	jmZcKzY4Z4FqsQ5wOJASw5K1MzrgyvGgugFc1w0RjuAJgMYrs7gjeAqgrnbdWQdcdjq0M1W7
	BSOAX7bfcHIE6wDeza/E7XNJyh/+WKSxN3hSX+PQ0CSyc3DqGg5b5s2YvcClwuCyRYvZ+QTl
	B/M6oT3tRiF43bRJOsS8Yenoxo6wCyWBRcv28XbOXmgpXSTsGLdxctqu7DwIUl0ucHv0PO5o
	Pg7XahZ2MRf+Zm7ddcCDK3naXZwAR0t/wBxYDRe6e3ZxBLwwmLfjBbd5udUZ5NByh5e2FzHH
	6tzgRa2Hg+0LZwuXnBzYC/5aUrWLaWjp6cMc6/kcwJLNh875wLvsOQtlz1ko+1+tAuD1gMcq
	VOlJbEKwQhQgY8/897EJ8vRmsHMZAmkH0DdaA3sBxgG9AHJwvqdb2oic9XBLZD76mFXK45Sa
	NFbVC4JtOy7AeS8kyG2nJVPHicQSoTgkJEQsORQi4nu5rV64muhBJTFqNpVlFazy3z6M48LL
	wrQrr/20f3N4a3V9OKp4fLzxQ64v6W7gklbvgx23w7l61V9m2UTGSpt4pm5kLtMUGiuw9lhC
	5ytTfH1qiOiijM5cY7k6d+UtbvbsyYXaqT9MpdWPt6cbpPJ+r8APUsxvCPc5nc489mDzHUF/
	5P2o5dqpQ8eapM+cmKGzGZ5fjB78VqcT6GclkhyT/8nRra2t5DCW+6ZHhzvIrY+JDXssaPiu
	OH2KzaptGDjV9feMJftOzNtSv+rzP5fepJhYF78T1qigDd9lr8i6rohKYIxfjykwKfqHzjUK
	989lzO+d6lUdwCMK3j2SKXhlblAv4HU9jdy4MxBvDnBtna6Ini+IL+YTqmRGJMCVKuYfPk8q
	bqIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvO4Oj4JUg5VbVC3WnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZDHp0DVGi6dXZzFZ
	7L2lbbGwbQmLxZ69J1ksLu+aw2Yxf9lTdovu6zvYLJYf/8dkcWPCU0aLiR1XmSx2PGlktNj2
	ez6zxbrX71ksTtyStjj/9zirg5THzll32T3O39vI4nH5bKnHplWdbB6bl9R7vNg8k9Fj980G
	No/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov0
	7RK4MtY+XslWsNWhYt7UnewNjEtNuhg5OSQETCTa7i5h7mLk4hAS2M0o8WfxDlaIhLhE87Uf
	7BC2sMTKf8/ZIYo+Mkr0NCxg7GLk4GAT0JS4MLkUJC4isINZ4ufaZiaQBmaBNcwSW+bygtjC
	AlYSz0+2MYHUswioSvTvkgAJ8wpYSCw88IMNYr68xMxL38F2cQpYSkx+vogZxBYCqtnXOJ0F
	ol5Q4uTMJywQ4+UlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgVGeanlesWJucWleel6
	yfm5mxjB0a6ltYNxz6oPeocYmTgYDzFKcDArifDmnM9PFeJNSaysSi3Kjy8qzUktPsQozcGi
	JM777XVvipBAemJJanZqakFqEUyWiYNTqoFJR0rxd80P4+smgbX3wpdeX/9/YtjsxTZ8q9y+
	OMx4OKUg/My/PV9yhT/FuflVWR/zuMZW1JXDx/y6cKXqHt0Tjf8s7j36WddxrZ9h26kpvCrm
	J+XfdvlpzHP9p7vg4vzvR1rrpZdEpUUpC0v8bPfr9BPP+OI9K9rykJRZjNKp1sxNUka6Sy+r
	c04qPdLiLJpd0LZwUuaM1dfnHbqU3DTLaet6L7Z18lGvr252U+VoOJex/0vPQkGBy6y3/jx6
	wr/g6wrD+ROD7wi7K55lemxjNM/yweJllt/acyW/fZX4e2vB9RO6AkLeUpdNrvWfC87hmT8z
	IPTL7fB3Bxz9ZnNrJq6++GbexIQ1gb8kRF7fU2Ipzkg01GIuKk4EADr1Q49lAwAA
X-CMS-MailID: 20231206101104epcas5p41c9a32e6cbc2ef6dd8870cf60cd1c7ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101104epcas5p41c9a32e6cbc2ef6dd8870cf60cd1c7ce
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101104epcas5p41c9a32e6cbc2ef6dd8870cf60cd1c7ce@epcas5p4.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

Introduce blkdev_copy_offload to perform copy offload.
Issue REQ_OP_COPY_SRC with source info along with taking a plug.
This flows till request layer and waits for dst bio to arrive.
Issue REQ_OP_COPY_DST with destination info and this bio reaches request
layer and merges with src request.
For any reason, if a request comes to the driver with only one of src/dst
bio, we fail the copy offload.

Larger copy will be divided, based on max_copy_sectors limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c        | 204 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 208 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..05dbe7fa5354 100644
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
@@ -115,6 +131,194 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
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
+static ssize_t blkdev_copy_wait_for_completion_io(struct blkdev_copy_io *cio)
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
+	kfree(offload_io);
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
+	size_t rem, chunk;
+	size_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
+	ssize_t ret;
+	struct blk_plug plug;
+
+	if (!max_copy_bytes)
+		return -EOPNOTSUPP;
+
+	ret = blkdev_copy_sanity_check(bdev, pos_in, bdev, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), gfp);
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
+		offload_io = kzalloc(sizeof(*offload_io), gfp);
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
+	if (endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+
+err_free_src_bio:
+	bio_put(src_bio);
+err_free_offload_io:
+	kfree(offload_io);
+err_free_cio:
+	cio->copied = min_t(ssize_t, cio->copied, (len - rem));
+	cio->status = -ENOMEM;
+	if (rem == len) {
+		ret = cio->status;
+		kfree(cio);
+		return ret;
+	}
+	if (cio->endio)
+		return cio->status;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4e17945041c8..e8582a38adb7 100644
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


