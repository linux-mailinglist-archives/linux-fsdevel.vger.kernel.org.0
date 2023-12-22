Return-Path: <linux-fsdevel+bounces-6773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7681C59C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72BA1F258AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6918E05;
	Fri, 22 Dec 2023 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hHNBJwOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21918AEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231222073203epoutp032525151e97da2b56935c4bb46e71071d~jFvRw1OhY3178931789epoutp03y
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231222073203epoutp032525151e97da2b56935c4bb46e71071d~jFvRw1OhY3178931789epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230323;
	bh=in2AYpVTNT76lhCvnjMvG4KI3Pxm2pxWCaKDykGs2IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHNBJwOCVuRDfHAagqT9Z+x9WW0s/NAstiErN3maDCSWCPPRSz7umM5rC0x9Q9XLr
	 +taDxjQO2p5WLWjHkm9UymzFsclp/wajTfoITBCLpZZWMENq6l2u956fSqz3hDpfsK
	 dr8k/QBVQnI74VF53gAhrKnlsS5ziyPulGaTVbhQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073202epcas5p208adfa9360db1984ca7359d690abbe15~jFvQzndsb1857018570epcas5p2M;
	Fri, 22 Dec 2023 07:32:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SxJsD1KdBz4x9Pr; Fri, 22 Dec
	2023 07:32:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	17.90.09672.F6B35856; Fri, 22 Dec 2023 16:31:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062116epcas5p2ff54b405039a65f107b2a570b113c501~jExeRsijg0448404484epcas5p2K;
	Fri, 22 Dec 2023 06:21:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062116epsmtrp12c1cdf9606a1bb1630bcab4b6c5d24e0~jExeQkTWF1607116071epsmtrp1n;
	Fri, 22 Dec 2023 06:21:16 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-69-65853b6f38e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.C8.08817.BDA25856; Fri, 22 Dec 2023 15:21:15 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062112epsmtip24391c108c8dd8663d9345d5960bcf949~jExawUa6O0303903039epsmtip2a;
	Fri, 22 Dec 2023 06:21:12 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
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
Subject: [PATCH v19 03/12] block: add copy offload support
Date: Fri, 22 Dec 2023 11:42:57 +0530
Message-Id: <20231222061313.12260-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tLwUtXgqGQ1HsurgNEGilwOEp85WbsSxsi/9gGDb0hkKh
	bdoyx8YmiIBjQUBgw4I8hCgvYVDGeD9KGApzMhGZTISxoisvhziMMuZaC5v/fX/f8/md3+Pk
	sHBOkRWXFSvX0Cq5OJ5P2DBaB1xdPZSB6bTglhNqHP4BRyt/rTPQ6dwNHNVN5RBoYeAxQIa+
	TIDKL11koLt97RjqunQeQzV1gxg6r78D0Ny4FkPdk+6oIqOKgbq6rzPQWEcJgcouz1mhryba
	CHRl6B8M/ZI7B1De2XEMtRlSAWpdL8NRw8IjBro26YxubgwxQ7lUu3bKirp5v4lBjd1IpJpr
	vyQoXdUp6g/dBUB13k0hqMpz+UwqO22ZoFbmJhnUo55xgjrXUgso3chn1GqzC9VsWMLCd0TI
	gqS0WEKreLQ8WiGJlccE88M+jDoU5eMrEHoI/ZEfnycXJ9DB/MPvhnscjY03bYTP+1gcn2iy
	wsVqNd8rJEilSNTQPKlCrQnm00pJvFKk9FSLE9SJ8hhPOa0JEAoE+31M4AmZ9EFVM6HMCP3E
	eKXJKgVseGcBaxYkRXD83hgzC9iwOGQngP1TpZvBYwAL799imCkOuQZgSpn/VsbtomuYBeoG
	cHglFViCdAwO5FVYZQEWiyDd4cgLljnBgazHYXuT0MzgZCkOdbNDmJmxJwPgzOW9ZoZB7oW/
	9k8SZs022XOFz5lmBJJeMGfazmxbk4Hw4fNKpgWxg9cvGF72hpN7YNp3xbilt++t4eJ8uCX1
	MBxoCLHY9nB+qMXKornQmJOxqU/CmoJqwtwZJM8AqJ3QAsvBAZg+nIOb78FJV9jY4WWxd8PC
	4QbMUtYWZq8bMIvPhm2lW/p1WN9YTli0E7zzNHVTU7C4Sb+5tnMAzrYugVzA074yjvaVcbT/
	ly4HeC1wopXqhBha7aP0ltMn/3viaEVCM3j5RdzC2sDszJ+eeoCxgB5AFs53YCv2naE5bIk4
	6VNapYhSJcbTaj3wMa07D+fujFaY/phcEyUU+QtEvr6+In9vXyHfkb2QflHCIWPEGlpG00pa
	tZWHsay5KVhuWfRu472vj/yUdHy+y37XysLTb2qV/FNOV2/YVu8s+SIi8re4d944Nkpu1+Vy
	Pir2jPBaVgh+9DUccJ8erKzId372tt1Us+OTkjxF2aHC6vZy7nvbl2NfO92/pHFpUf9c8OZQ
	Y+Vil8RLRkhu9zJkSbscaiYH3bxZYw2ZvZ8v2I72uI64OKpEabz1icb1hr4jTkmZ5D72W/lS
	nl9ccvq3CmOqX53zmmxH62rkuPF9xdVtKmGoTrq/SD/LmtmzbTUikFuSvBgy2hHw7EHadFye
	CgVl9wh/z/87Wf2k84QN1PUaH4YxDx41nvU5bmDyp15oP3A85lwQ2VafwkleDRQlp6zxGWqp
	WOiGq9TifwGNNZNSqwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvO5trdZUgz+njSzWnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZDHp0DVGi6dXZzFZ
	7L2lbbGwbQmLxZ69J1ksLu+aw2Yxf9lTdovu6zvYLJYf/8dkcWPCU0aLiR1XmSx2PGlktNj2
	ez6zxbrX71ksTtyStjj/9zirg5THzll32T3O39vI4nH5bKnHplWdbB6bl9R7vNg8k9Fj980G
	No/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov0
	7RK4Mp4t2cRW0OZQ8XL5RvYGxr/GXYycHBICJhJXZpxgArGFBHYzSszcqQgRl5RY9vcIM4Qt
	LLHy33P2LkYuoJpmJol/vc8Yuxg5ONgEtCVO/+cAiYsI7GCW+Lm2GWwQs8AaZoktc3lBaoQF
	rCQeLFMFCbMIqErcPniLDcTmBQo/nfqLFaREQkBfov++IEiYU8Ba4vmvxawQ51hJnHy+Gapc
	UOLkzCcsENPlJZq3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
	uZsYwZGupbWDcc+qD3qHGJk4GA8xSnAwK4nw5uu0pArxpiRWVqUW5ccXleakFh9ilOZgURLn
	/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXAJMeQc+Q/y5wpekluO7lKGbb13Lybz62sqBNjaX7o
	uHCxpIyF+A5O3ff5HKvT38/OOCV34OLK6K/5Gy6WOjv7Ht3lxf7EqPFImzTj1/Rvi6aduW3z
	cuXVXi1nvnNnZB0su4OvyVxdfPKJ38GvkgeW//jHt5F9kdNTj3Uxpl5+5jUrgmZ+WmCXPtP4
	la/E/4tXtqi2ray+Xbvr2dZ04XsLdln7PNetMTAQ4fzcJvu4jf2aQcZX5yMxjubNvx6U7+a2
	2eX4b5Pop1+FlzYFnfdunZDLc1vgQfusO5e/5z2ZeYN9ZdenRYYGpmXH58Rv3KJSwMt0VDY8
	6FO/iOeOuflXPv90nj1JzD8kUDHhyCXfjUosxRmJhlrMRcWJAO1ue45jAwAA
X-CMS-MailID: 20231222062116epcas5p2ff54b405039a65f107b2a570b113c501
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062116epcas5p2ff54b405039a65f107b2a570b113c501
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062116epcas5p2ff54b405039a65f107b2a570b113c501@epcas5p2.samsung.com>

Introduce blkdev_copy_offload to perform copy offload.
Issue REQ_OP_COPY_DST with destination info along with taking a plug.
This flows till request layer and waits for src bio to arrive.
Issue REQ_OP_COPY_SRC with source info and this bio reaches request
layer and merges with dst request.
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
index e59c3069e835..f03cb4bc3134 100644
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
+static void blkdev_copy_offload_src_endio(struct bio *bio)
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
+ *	1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
+ *	sector and length. Once this bio reaches request layer, we form a
+ *	request and wait for dst bio to arrive.
+ *	2. We issue REQ_OP_COPY_SRC bio along with source sector, length.
+ *	Once this bio reaches request layer and find a request with previously
+ *	sent destination info we merge the source bio and return.
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
+		dst_bio = bio_alloc(bdev, 0, REQ_OP_COPY_DST, gfp);
+		if (!dst_bio)
+			goto err_free_offload_io;
+		dst_bio->bi_iter.bi_size = chunk;
+		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+
+		blk_start_plug(&plug);
+		src_bio = blk_next_bio(dst_bio, bdev, 0, REQ_OP_COPY_SRC, gfp);
+		if (!src_bio)
+			goto err_free_dst_bio;
+		src_bio->bi_iter.bi_size = chunk;
+		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		src_bio->bi_end_io = blkdev_copy_offload_src_endio;
+		src_bio->bi_private = offload_io;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(src_bio);
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
+err_free_dst_bio:
+	bio_put(dst_bio);
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
index d5019967a908..cd940de16750 100644
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


