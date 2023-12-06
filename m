Return-Path: <linux-fsdevel+bounces-4970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB3806C29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C86C1C209E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB130330
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zvsgxf9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E80D69
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:11:22 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231206101121epoutp0102bf82055d67a7ce630f55f22bfed43c~eNly-Siod0205302053epoutp01d
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:11:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231206101121epoutp0102bf82055d67a7ce630f55f22bfed43c~eNly-Siod0205302053epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857481;
	bh=/6OhQ9ODX//umK/uU/u7BcJDEaHDVpwjz5uay8Kefew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zvsgxf9BFlB3by/cG0LjnxSw9PuIrmn+Ve6wLU+4nkYVKhCVyUYAV49SvJFxqXE2a
	 FhUTk0u0yqd621sjpzzUXVqKKMTaaU+632OV7znew28DJLjcrqtZoIXt5ltX0G9DcT
	 1kamBpJgHgrhwn7TugpqnIZ17VLgwnjtYLYWMStw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231206101120epcas5p2f9ffcb1fb083bd23d3b4fb98147d54d9~eNlyWpE5K2940529405epcas5p27;
	Wed,  6 Dec 2023 10:11:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SlY8Q5kFBz4x9Pv; Wed,  6 Dec
	2023 10:11:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.C6.10009.6C840756; Wed,  6 Dec 2023 19:11:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231206101118epcas5p1cc77b49dbd8bc1601423d02527b03122~eNlwWIZO30449604496epcas5p1v;
	Wed,  6 Dec 2023 10:11:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101118epsmtrp2882cd222b4c8fcca5aaafc6113b65840~eNlwVBeI-0924709247epsmtrp2d;
	Wed,  6 Dec 2023 10:11:18 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-2d-657048c6a55e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B1.52.08817.6C840756; Wed,  6 Dec 2023 19:11:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101113epsmtip278f834a99ee8a24a8447ab449801a2ff~eNlrq_aCz3173831738epsmtip2Z;
	Wed,  6 Dec 2023 10:11:13 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
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
Subject: [PATCH v18 04/12] block: add emulation for copy
Date: Wed,  6 Dec 2023 15:32:36 +0530
Message-Id: <20231206100253.13100-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeufdyWyB1bdVxVhOBOtwE+ShruwMDNGLcjWMZC/90k93QO0BK
	2/UDYdkyKoJYUPmQAVU+hM4PMDAKQ0C6ACqgC2AkdYMENqSdczAU2TBaYGtp3fz3vM/7PHnf
	5z05bJxfzBKw0xVaRq2g5ULSh+i8vuOt0EFKxUQsVryJWm8P4mjxbweBjpas4qh56jSJ5q4/
	AcjWdxyg+oYaAk30dWPocvNNDJUN3APIbjViyDIZgs4XmAjUa7lFoPGecySqu2BnoaKfukh0
	cWgNQz+X2AEqLbRiqMumB6jTUYejlrlHBBqe3IJmiwoBGlsd8totoLqNUyxqbLqNoMZHdJS5
	6QRJtZu+pn5vrwbUtYlckmo8Ve5FncxbIKlF+yRBPfrBSlKnOpoAtWTeSpltf2KJGw5kxKQx
	tIxRBzCKFKUsXZEaK3w/KTk+WSKNEIWKotA7wgAFncnECvcmJIbuS5c7zyEMyKLlOieVSGs0
	wvC4GLVSp2UC0pQabayQUcnkKrEqTENnanSK1DAFo40WRURESpzCTzPS6hqrMdXanmxL/n1W
	LjBKDcCbDbliOL/8i5cB+LD53GsALhvPeIonABZYbbi7WAYw76aeeGEpMOtJd8MCYGmlwWNZ
	ArCrfcRpYbNJ7g54p1znMmziXsFhd5vIpcG5jTi0TNeRrsZGLoJPHzSsY4IbBEcfm4ELc5z8
	1IkVzD3NH1bffcpyYW9uFCx/0IC7NTx4q9q2vhHu1OR9f3Z9Vcht9oa1fVbcbd4Ln/e3km68
	Ef4x1MFyYwFcWrB4+BR4t3rUM0wLZ3v7PXgXzL99ej0M7gzT2hPunrUBnnTYMBcNuRxYWMB3
	qwPhdJndy4394EyVyYMpWLFQ6bliMYDHzzjIEuBvfCmC8aUIxv+n1QO8CbzOqDSZqYxGoopU
	MEf+e9kUZaYZrH+L4P1dYObXx2EDAGODAQDZuHATRz6mZPgcGZ3zBaNWJqt1ckYzACTOG5fi
	gs0pSue/UmiTReKoCLFUKhVHvS0VCf04c/k1Mj43ldYyGQyjYtQvfBjbW5CLHY7P9x+TJSx8
	80zTtnKBlEhHR2iJrmN5WF+/1h7MYz7x0dtO768N510y7Ml6pb9eEDqX/bmpNyZ2vr32K8eq
	32vfPjRE51Z999lC/BX7fBnZ+WGsMr21SPXxoUFfwrRdygvPqpq+kR1/x5EjzNiWdMN3URx9
	eXem0bYlsOX+q/T0wbOVB3lf6g/HV/GPgn1bI7OuXqo4BoNUVQdsjp6HV01HmH92jdeY69Y4
	YY0zm5fj5tFHgiC6z3+4x94zqh191i+dNIRd3B4Xfqhv24xS917WwM4JVsK5D3LLBn8MTmxr
	M4WcX13xKy66R/NUwbOBLbbfQnz7n79h/QvtfDfmWFKOkNCk0aJgXK2h/wVQ6RsynwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHe885nh1H2mmWvnnJGhSpNZtEvF3JCDsFUlFGFJRLD2ptc+xo
	N4000VLzHtROhdes1tVlMq/pLM2oVt4qaRW5sUwst252meUcQd9+PL//8/w/PBQuMhK+VIIy
	iVUrZXIxKSTq2sWBizoYFbvYZpmKbj7swJHt6y8CHS904OiqqYBEw+12gMytJwAqq7hAoJet
	9Ri6cvU+hooN/QBZ+ngMNQ+EoPKsKgI1NXcRqKfhPIlKqy0ClPtcT6JLneMYelFoAajoZB+G
	9OZ0gOp+leLoxvAnAj0Y8EODuScBMjo63db4MvW8ScAYX9cQTM/jZEanzSaZ21XHmPe3NYBp
	fJlGMpX5JW5MXsZHkrFZBgjmU0sfyeTXagHzWTeb0ZlHsM2eO4UrY1l5wgFWHbo6WhhfWqnB
	VONrDzVnvhOkAX5pDnCnIL0EZunSyRwgpER0I4D8rRuES/jAjP4xgYu94JVxq8AVsgE4ducD
	ngMoiqSD4NOSZOd8Bq3H4Y/rGZhzAadrcNjdMdngRSP43VpBOpmg58EnozrgZI+JuSn7N+Yq
	CISa7u+TZe70MlhircCdLJrItKSfIVz56bBLYyZc9wNhxp1zeCGg+f8U/58qA5gWzGJVnCJO
	wUlVYUr2oISTKbhkZZwkJlGhA5M/Dw7WgybtqMQAMAoYAKRw8QwPuTGRFXnEyg4fYdWJe9TJ
	cpYzAD+KEPt4fBvOixXRcbIkdj/Lqlj1P4tR7r5pmK+3/4lDl8FyxR/vftHCqI2nPmyTvA2r
	Dh9ZtY4vmGKd/7AoZWSBnbPSx66fXv5z9OC13AsJbdPW1wfE7mjcG3W47Uv7G+ub2tQAPmlm
	zM8QB2OXrM8acjQmxUVuN68TzpVL+reeDY2I8equHHmWPX50S4GxIf5Mb2ZDud27q/yden6R
	dMXrojFoEM/pexXR+nhtVdfgzUf+X03f2jR8AdguLUv1CQ5x643Y5Zmiq0HS81HVOdy2WcYN
	vSWiVLtJHxSWN9QTXdEb6B8Ejea9LcW7Pod3rrzorcxuytwXWuu+ZIi+Fxm+W5tG2Ui30Rr4
	xdOUUnx36uLaOsfg4KbIu9FigouXSYNxNSf7C2PAyuliAwAA
X-CMS-MailID: 20231206101118epcas5p1cc77b49dbd8bc1601423d02527b03122
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101118epcas5p1cc77b49dbd8bc1601423d02527b03122
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101118epcas5p1cc77b49dbd8bc1601423d02527b03122@epcas5p1.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 05dbe7fa5354..e32e00e4a1eb 100644
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
index e8582a38adb7..9fa1ad68beb5 100644
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


