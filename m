Return-Path: <linux-fsdevel+bounces-741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21C7CF814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB282820E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75B225A8;
	Thu, 19 Oct 2023 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uiqtkGxH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE821369
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:32 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB5D6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:03 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019120401epoutp02a9cb5e207e38320d12fde35ba55d5f48~PgKeWyHRY2730527305epoutp02k
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019120401epoutp02a9cb5e207e38320d12fde35ba55d5f48~PgKeWyHRY2730527305epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717041;
	bh=8RJPLhVhgPuqIj+OvdyJBFvN6LyTk+71evbw3zEgBx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uiqtkGxHUIp468+GHlMMjJrlhSgoLOorvR2Ize4OhYXGZysMpskFWWjD01LIl/eoD
	 kcU4/s3fgKNMwsamxT/ZpeU4uyRBxJkaZtW2zNyA8+wT1uTmW3JjrgSepzqEBfnXxa
	 QhjxB+AOfpJDttEpDRkBeIr5HK83a9Hb9JAJ8DUQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120401epcas5p2b2f1ab51b5b85d60cb2d6e22f253eaf6~PgKdncFD00920309203epcas5p2A;
	Thu, 19 Oct 2023 12:04:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SB5wZ1vkFz4x9Pq; Thu, 19 Oct
	2023 12:03:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.78.10009.E2B11356; Thu, 19 Oct 2023 21:03:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110843epcas5p18cc398bc87c141630677ef41d266004f~PfaMXe37q1154811548epcas5p1Q;
	Thu, 19 Oct 2023 11:08:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110843epsmtrp204a2a549b824a4abc8c32b937c4d5518~PfaMWR9O01629616296epsmtrp2B;
	Thu, 19 Oct 2023 11:08:43 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-0a-65311b2ec2be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.C9.08755.B3E01356; Thu, 19 Oct 2023 20:08:43 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110840epsmtip1f494d1d0f2e7edb701ac308bef6b8144~PfaI2f1zk2963429634epsmtip14;
	Thu, 19 Oct 2023 11:08:40 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 03/12] block: add copy offload support
Date: Thu, 19 Oct 2023 16:31:31 +0530
Message-Id: <20231019110147.31672-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbVBUVRju3Hu5u+BsXBfNA0xFi6iAwC4u2+HL0Ji6lT8Y/aFlhAvcgAF2
	190FyyIgROP7e4gFFgSGAhpAIOQbZTG+ptkmQISARBdiJEDUtGlHbJeL5b/nfc7zvM953zOH
	i/OLOXbcKJmaUcqkMQLSimjXOTu7uduLGOFqmSVqGv0JRxt/GQn0de5THDXM5ZBoRfcAIMO1
	SwBVVpUTaPpaJ4Z6qvIxVNdwA0P5AzcBWpzUYKh3xhVdvlhDoJ7eEQKNd5WRqKJ2kYMypjpI
	9N3QJoZu5S4C1GFIBqjdWIGjxpV1Ag3P2CP90yGLAFu6UzPHofXzVwh6/Oc4uqU+jaRbaxLp
	5dYSQHdPJ5F0dXaBBZ2VskbSG4szBL3eN0nS2W31gG4d+4J+2PIa3WJYxYKsP4r2i2Sk4YzS
	gZGFycOjZBH+gg9OhLwd4iURitxE3uhNgYNMGsv4CwKPBbm9ExVj2obAIV4aE2eigqQqlcDj
	sJ9SHqdmHCLlKrW/gFGExyjECneVNFYVJ4twlzFqH5FQ6OllEp6Jjrzcn0MoCgM+W/2mDSSB
	DHE6sORCSgzzipY56cCKy6e6Acwe7gJs8QDAemMzyRaPARz+dckk425ZUvIJlu8F8O5y2rY9
	FYO163lbIpJyhWPPuGZ+F5WKw/7ZP7fa4pQWh613hjBzuA3lAzN/qSXNBoJygkX642aaZ6LL
	5y8RbJgHzPl9p5m2pHxhc0YVzkp2wpESA2HGOPU6TPmxFDe3h1SDJVwqXSPZ2QKh7lGFBYtt
	4L2hNg6L7eDDtd5tzTlYV/g9yZovAKiZ0gD24C2YOpqDmy+BU86wqcuDpV+FRaONGBv8Mswy
	GjCW58EO7XPsCH9oqtzubwtvPknexjTsy8zc3lw2gHXaAotc4KB5YSDNCwNp/o+uBHg9sGUU
	qtgIRuWl8JQx5/575TB5bAvY+iEu73eAhdv33QcAxgUDAHJxwS6eEy1k+Lxw6efnGaU8RBkX
	w6gGgJdp33m43e4wuemLydQhIrG3UCyRSMTehyQiwR7eSmp5OJ+KkKqZaIZRMMrnPoxraZeE
	Oa+ceiMqb2CPonvDSuvUdPfvLKHdUqJsf/zVpYyT0c9qTu9zGUvodM0OG8wL2s/XyjK/1F4t
	+sNgY2N/Pe0rx/cmZs9KvY99a3P7+on2iYL1x4O/Xdh3K/iQYbrXeMpzcPKT6R20LtRR4hts
	1bORsCMgkZeQvHk6pfRAY+3Bl4rH/9Hfm/0wqvvonTrrwsUZlW62P3+SP/ZpH6esZ/Rk6fHg
	CZ/4g7q2sftH1zffPax4ggdVnrWdzJw/M9O8dyOwhLLXa1P5OuusUEz0sdwYXLy7fs0xLAKs
	LvS31J7fvOgZan+jP+eVOueltQN+ngvVlXP+ex/5UtVIUMIbmVrxv3JkQ58uIFSRUpELrlRJ
	/wVpXyDtqgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbTBUYRiG5z3ndfYsszqWxtlUpk0/tONjpXr7tEMf76SRavqhSbXDGQmb
	2Y2iJmorX8sixqCNMIQmWhLCSlIxtT5GQqkpYmpYKv3IqGxqpn/3XPd9P88z89CksAsuo0MV
	pzmlQh4upixh3SPxSpct1lLO/VeyG6rq7CDRzOwcRJfS50lU+UZLoc+PvgA02poAUGGRDqLB
	1gYCNRVlEqi88jGBMtteAjTWn0eg5iEJunm1BKKm5mcQ9TVep1BB6RgPpQzUU6jsyU8CvUof
	A6h+9CJAdXMFJLrz2QTR0yEHZJx/YiET4Ya8NzxsHLkLcd/zKKyvSKJwTUkcnqjJBfjBYDyF
	i9OuWeBU9RSFZ8aGIDa19FM4rbYC4Jquc/irfiXWj04S/ksOW24N5sJDozml2/bjliduGrQw
	Mkt2djKxFsSDFM9kQNMs48mqM2EysKSFzAPA6k2vyGTAX+AitnS+/a+2Zct/jvMWQ2qCNTZ8
	J8xlipGwXb9oM7djtCQ7NZ9DmAskc5tka3UCs7ZlNrOa7lLKnIfMGjbbeMCMBQtYN5IAF29w
	Y7VvbcyYz2xhq1OK/qwVLkTeFX7gLcZt2Ge5o3BxuiOrvpdPpgMm7z8r7z+rEBAVQMRFqiJC
	IlTSSKmCO+OqkkeoohQhrkGnIvTgz7/XOteD+xXTrm2AoEEbYGlSbCdYg905oSBYHhPLKU8d
	U0aFc6o24EBDsb3AfiI1WMiEyE9zYRwXySn/uQTNXxZP5EuL+7u9B6Y3ei3X7M3wmhiX5Qdo
	3t+I4etaE2I1Vk7rO5N8jaHtSb7Nik64zXlPYmOLZCbKx3p1ztym2c5VA1Z21s7j0bs29O9/
	LvYMahkxyddJrvhQ7RbZw2GBoiBeufMPLtYpgCqJ6/X2Gyy9kGWS6L753ZKpP5WVhTVV+SlT
	jxjKkz7K7LlD+1x7HsYO5MT0jHtIV4RKiOnz0jmc//HKzGZ+kwdhqI3zD3x9NGvY9FXrHxi+
	zcvW4NIV7wE1Dgc39ZrIb8W+uJs/69KzdLKasRPt1j39ER3Skeh7ucC9Q/iuIHDf1Dp/fPzC
	TkP9ydzHmHmRcc5xR8YHsF0MVSfk0rWkUiX/DSFZMc5eAwAA
X-CMS-MailID: 20231019110843epcas5p18cc398bc87c141630677ef41d266004f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110843epcas5p18cc398bc87c141630677ef41d266004f
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110843epcas5p18cc398bc87c141630677ef41d266004f@epcas5p1.samsung.com>

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
index e59c3069e835..0c5763095f7b 100644
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


