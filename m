Return-Path: <linux-fsdevel+bounces-6774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09F81C5A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8178A1C250F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3011D696;
	Fri, 22 Dec 2023 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MBG6W+jJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4F1CF92
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231222073210epoutp0141a6f49f402a378d8e772e9f35b98269~jFvYwj0GQ3120431204epoutp015
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231222073210epoutp0141a6f49f402a378d8e772e9f35b98269~jFvYwj0GQ3120431204epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230330;
	bh=9frU+oN9cW84tUmQ8PszwC/fCsF2sdAWZkWnbtQtafI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBG6W+jJ6LXb2iwYngYt7WcqC/DsvTBvk2L1UI78B7u8NPXmC+f+gTDa/bK0P/BIC
	 pC6W8eqA12L3T7vCfjCl+LynObzh9uf/iyXCjjYX9PtXoiToD10Mj1T/av/jys8hNz
	 wIB/Vntuws6no3thzjAHjGnyvRYU5Sdlj7CS8QGQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073210epcas5p2d828fcd26c2acef7da1ed7d5eaed9d97~jFvYP30bG2130021300epcas5p2M;
	Fri, 22 Dec 2023 07:32:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SxJsM5XBzz4x9Q9; Fri, 22 Dec
	2023 07:32:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.D2.09634.77B35856; Fri, 22 Dec 2023 16:32:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231222062126epcas5p382f390cbedd5351c49adf07121d18448~jExoFy5wl0194201942epcas5p3T;
	Fri, 22 Dec 2023 06:21:26 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062126epsmtrp131e61b114be345c1c8edb06d53480a52~jExoEtGIY1607116071epsmtrp1s;
	Fri, 22 Dec 2023 06:21:26 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-6d-65853b773aa6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.DE.18939.6EA25856; Fri, 22 Dec 2023 15:21:26 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062122epsmtip234bd0da50619d5d996eaf8c8abad787c~jExkq0fXB0344503445epsmtip2p;
	Fri, 22 Dec 2023 06:21:22 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Vincent Fu
	<vincent.fu@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 04/12] block: add emulation for copy
Date: Fri, 22 Dec 2023 11:42:58 +0530
Message-Id: <20231222061313.12260-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxjtfe/xCMxEn2jbm1QwE0sdF5bYJF5EilbF50QrTqd1pq2lGXiF
	DNnMAlbaKQgBDbJWbAkiVKgLIluQYSkWgRBFlHYUUGYAWxNKQUuBQasgNiFo/Xe+851zv+XO
	x8K9fnDnsmRKHaNRSuV80pOoa1u9yi8+2MAEHrOsQpWdHTiamJ4h0OHsZzi6MJBForG2SYBs
	LWkAFZ8uJNDdlgYMnb9gwVBuay9A9h4Thpr716IfU0sJ9HPzNQLdajxJoqIzdneU3ldPorPW
	OQzdybYDlHOkB0P1tiSA6maKcFQxNk6gq/1vofvpRwDqfmZ128ylG0wD7nT3YDVB37qhp2vK
	jpK0ufRbesScD+imu4kkXZL5nRudkfw3SU/Y+wl6/HIPSWfWlgF6qsaHrrE9xMIXfRK7KYaR
	RjEaHqOMVEXJlNEhfMmHEVsjROJAgZ8gCG3g85RSBRPC37Yr3C9MJnesg8+Lk8r1DipcqtXy
	A97bpFHpdQwvRqXVhfAZdZRcLVT7a6UKrV4Z7a9kdBsFgYHrRQ7hF7ExjyyzmLr7/YNDN21E
	IpgUGYEHC1JC+IehEzMCT5YX1QRgZ0eFmyuYBHD4shF7GdiNRuKFJbXBjLsSDQAOPT65oDJg
	cOTBFYeKxSKptfD6c5bTsIwqx2FDtcCpwakSHDYPFpHOxFIKQcOU1c2JCcoXzqUWzFdgUxvh
	qeuFpPMdSAXArKElTtqDCoZ/Pi1xc0mWwGv5tnk5Tq2AyZcK5huCVKUHbMzJW+h0G0xp68Jd
	eCkctda6uzAX/pWVuoDj4fnj50iXOQVAU58JuBKh0NCZhTubwKnVsLIxwEV7w7zOCsxVeBHM
	mLFhLp4N60+9wCtheWUx6cIc2Ps4aQHTcCata/55LyoTwF/GQrMBz/TKPKZX5jH9X7kY4GWA
	w6i1imhGK1ILlEz8y1+OVClqwPyJrNlZDwbu/ePfCjAWaAWQhfOXsVXrUhgvdpT0q0OMRhWh
	0csZbSsQOfadg3Nfj1Q5bkypixAIgwKFYrFYGPSuWMB/kz1mKIzyoqKlOiaWYdSM5oUPY3lw
	EzGUwKP3lwdwfjftv3LIzuoLitij1Ncm7W2ffZ7zdKQ7NKtG0rHFmrvjdHVlz0qBZ8DXeX77
	GieeeMuMceOffZNpbVHPpfl2ejOKf8vjD8CmoyfMbaVbMtqzD8duP56/nTibIH/N19Iikkmq
	uc0bpkc+3/2oK1YynLzrgE/xvYLcg2HDPyVYf+Ml7O77VHNx8YmHijR7xx5s5sb9d7LXCz/Q
	HxuWFNzeKd4hu2queoNTxInbN3QmtLDKfKdqLuwiOyma8wCte5tjCZ7194msvd1xqX3zYs+h
	jMn0c7/WVY9a9rbmFg6WjXpTyhrOiqmPp/DpJ5MJN7/0KOU3VWiWTy3/vvcjCZ/QxkgFa3CN
	Vvof1rR34KsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra1BMYRzG5z3ndDqtyrG5vIpWa8hkRa7vuA0xnD6YwciMxbBjj2q07dpt
	U2qo3XTZSJHJblKUaEm1S8qlmi2lm8aliww7o13dkGrcosWKGd9+8zy///PlT+HcRsKdCgkL
	Z+VholA+ySHKavi8BW99TrCLUjshKm6sw9HQp+8EUqWN4ej6q9MkGqgZBshSnQhQ7uVsAr2o
	rsBQ4fWHGDpjagfI2qbD0IOu+ehSQj6B7j9oINCzuxdIlFNgdUQpHeUkulpvw1BnmhWg9KQ2
	DJVb4gAq+56Do5sDgwR61OWBulOSAGodq3dY585U6F45Mq2vSwnmWYuSMeiTScaYf5zpNWoB
	c+9FLMnkpZ51YE6pP5DMkLWLYAYr20gm9ZYeMCMGT8ZgeY9tdRVyVovZ0JAIVr5w7X5O8OeH
	PzBZq3+k+bGFiAXDyzTAiYL0UphQYcQ1gENx6TsANr1NwMeL6bBgrPYvu8FCW4/juKTG4L2y
	KgcNoCiSng+bflL2fDJdjsNvRWrMfoDTpTh8Wrfczm40gidG6h3sTNBzoC0hi7CzC70SXmzK
	Ju07kF4IT5sn2WMnehXsGc37o3N/Kw09RnJcnwQbtBZifJ4H1bez8DRA6/6rdP9VuQDTgyms
	TCEJkhyQ+fkqRBKFMizI94BUYgB/3u2zvRwUFI/5mgBGAROAFM6f7CIVxLNcF7Eo6igrl+6T
	K0NZhQl4UAR/msvs0GQxlw4ShbOHWFbGyv+1GOXkHot5O28dWMFJbaiMSowbUR0Mr7NkZDTv
	yKxR6TU/v+yoHVL1zzTtqk8O3lgYZKHbpQGLBXOrVvMH1kdsbpEFjG75Ia7kKTNV0V5Ci8fH
	vGMdObn7PL96CSIXJQbGi5LO6hOvvQzs1B4+Y5VE+vcWZe9ekhHQJ98rNL+Z0JfsHH9rf0SK
	MVxYiq5EK24s8V83sUd97vimzc07gWZ4dFDc66lcHG/wfg6iLsTM0jWLn2zof1nm1UnPeyc4
	OVVyJDJGqC6pDTPfD+l+02J0pbvPayvjPkmc+UvbtzfClXuac3i2kXyetmTG57YF5nTXbVJF
	i+1OwaWhR8Vr4jKgoGZj4OguPqEIFvn54HKF6Beo0twiXQMAAA==
X-CMS-MailID: 20231222062126epcas5p382f390cbedd5351c49adf07121d18448
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062126epcas5p382f390cbedd5351c49adf07121d18448
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062126epcas5p382f390cbedd5351c49adf07121d18448@epcas5p3.samsung.com>

For the devices which does not support copy, copy emulation is added.
It is required for in-kernel users like fabrics, where file descriptor is
not available and hence they can't use copy_file_range.
Copy-emulation is implemented by reading from source into memory and
writing to the corresponding destination.
At present in kernel user of emulation is fabrics.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 227 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index f03cb4bc3134..9d5fe177308c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -26,6 +26,20 @@ struct blkdev_copy_offload_io {
 	loff_t offset;
 };
 
+/* Keeps track of single outstanding copy emulation IO */
+struct blkdev_copy_emulation_io {
+	struct blkdev_copy_io *cio;
+	struct work_struct emulation_work;
+	void *buf;
+	ssize_t buf_len;
+	loff_t pos_in;
+	loff_t pos_out;
+	ssize_t len;
+	struct block_device *bdev_in;
+	struct block_device *bdev_out;
+	gfp_t gfp;
+};
+
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
@@ -319,6 +333,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 }
 EXPORT_SYMBOL_GPL(blkdev_copy_offload);
 
+static void *blkdev_copy_alloc_buf(ssize_t req_size, ssize_t *alloc_size,
+				   gfp_t gfp)
+{
+	int min_size = PAGE_SIZE;
+	char *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
+static struct bio *bio_map_buf(void *data, unsigned int len, gfp_t gfp)
+{
+	unsigned long kaddr = (unsigned long)data;
+	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long start = kaddr >> PAGE_SHIFT;
+	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
+	int offset, i;
+	struct bio *bio;
+
+	bio = bio_kmalloc(nr_pages, gfp);
+	if (!bio)
+		return ERR_PTR(-ENOMEM);
+	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, 0);
+
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
+	offset = offset_in_page(kaddr);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned int bytes = PAGE_SIZE - offset;
+
+		if (len <= 0)
+			break;
+
+		if (bytes > len)
+			bytes = len;
+
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_page(bio, page, bytes, offset) < bytes) {
+			/* we don't support partial mappings */
+			bio_uninit(bio);
+			kfree(bio);
+			return ERR_PTR(-EINVAL);
+		}
+
+		data += bytes;
+		len -= bytes;
+		offset = 0;
+	}
+
+	return bio;
+}
+
+static void blkdev_copy_emulation_work(struct work_struct *work)
+{
+	struct blkdev_copy_emulation_io *emulation_io = container_of(work,
+			struct blkdev_copy_emulation_io, emulation_work);
+	struct blkdev_copy_io *cio = emulation_io->cio;
+	struct bio *read_bio, *write_bio;
+	loff_t pos_in = emulation_io->pos_in, pos_out = emulation_io->pos_out;
+	ssize_t rem, chunk;
+	int ret = 0;
+
+	for (rem = emulation_io->len; rem > 0; rem -= chunk) {
+		chunk = min_t(int, emulation_io->buf_len, rem);
+
+		read_bio = bio_map_buf(emulation_io->buf,
+				       emulation_io->buf_len,
+				       emulation_io->gfp);
+		if (IS_ERR(read_bio)) {
+			ret = PTR_ERR(read_bio);
+			break;
+		}
+		read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+		bio_set_dev(read_bio, emulation_io->bdev_in);
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(read_bio);
+		kfree(read_bio);
+		if (ret)
+			break;
+
+		write_bio = bio_map_buf(emulation_io->buf,
+					emulation_io->buf_len,
+					emulation_io->gfp);
+		if (IS_ERR(write_bio)) {
+			ret = PTR_ERR(write_bio);
+			break;
+		}
+		write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+		bio_set_dev(write_bio, emulation_io->bdev_out);
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+		write_bio->bi_iter.bi_size = chunk;
+		ret = submit_bio_wait(write_bio);
+		kfree(write_bio);
+		if (ret)
+			break;
+
+		pos_in += chunk;
+		pos_out += chunk;
+	}
+	cio->status = ret;
+	kvfree(emulation_io->buf);
+	kfree(emulation_io);
+	blkdev_copy_endio(cio);
+}
+
+static inline ssize_t queue_max_hw_bytes(struct request_queue *q)
+{
+	return min_t(ssize_t, queue_max_hw_sectors(q) << SECTOR_SHIFT,
+		     queue_max_segments(q) << PAGE_SHIFT);
+}
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
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
+ *	If native copy offload feature is absent, caller can use this function
+ *	to perform copy.
+ *	We store information required to perform the copy along with temporary
+ *	buffer allocation. We async punt copy emulation to a worker. And worker
+ *	performs copy in 2 steps.
+ *	1. Read data from source to temporary buffer
+ *	2. Write data to destination from temporary buffer
+ */
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp)
+{
+	struct request_queue *in = bdev_get_queue(bdev_in);
+	struct request_queue *out = bdev_get_queue(bdev_out);
+	struct blkdev_copy_emulation_io *emulation_io;
+	struct blkdev_copy_io *cio;
+	ssize_t ret;
+	size_t max_hw_bytes = min(queue_max_hw_bytes(in),
+				  queue_max_hw_bytes(out));
+
+	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	cio = kzalloc(sizeof(*cio), gfp);
+	if (!cio)
+		return -ENOMEM;
+
+	cio->waiter = current;
+	cio->copied = len;
+	cio->endio = endio;
+	cio->private = private;
+
+	emulation_io = kzalloc(sizeof(*emulation_io), gfp);
+	if (!emulation_io)
+		goto err_free_cio;
+	emulation_io->cio = cio;
+	INIT_WORK(&emulation_io->emulation_work, blkdev_copy_emulation_work);
+	emulation_io->pos_in = pos_in;
+	emulation_io->pos_out = pos_out;
+	emulation_io->len = len;
+	emulation_io->bdev_in = bdev_in;
+	emulation_io->bdev_out = bdev_out;
+	emulation_io->gfp = gfp;
+
+	emulation_io->buf = blkdev_copy_alloc_buf(min(max_hw_bytes, len),
+						  &emulation_io->buf_len, gfp);
+	if (!emulation_io->buf)
+		goto err_free_emulation_io;
+
+	schedule_work(&emulation_io->emulation_work);
+
+	if (cio->endio)
+		return -EIOCBQUEUED;
+
+	return blkdev_copy_wait_for_completion_io(cio);
+
+err_free_emulation_io:
+	kfree(emulation_io);
+err_free_cio:
+	kfree(cio);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_emulation);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cd940de16750..80867c9fd602 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1046,6 +1046,10 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
 			    loff_t pos_out, size_t len,
 			    void (*endio)(void *, int, ssize_t),
 			    void *private, gfp_t gfp_mask);
+ssize_t blkdev_copy_emulation(struct block_device *bdev_in, loff_t pos_in,
+			      struct block_device *bdev_out, loff_t pos_out,
+			      size_t len, void (*endio)(void *, int, ssize_t),
+			      void *private, gfp_t gfp);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2


