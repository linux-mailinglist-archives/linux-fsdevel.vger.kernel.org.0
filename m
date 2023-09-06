Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A83794266
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbjIFRys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbjIFRyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:54:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A41BD5
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:24 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230906175423epoutp027f16b6ea34a8c6908cbcf03d0bb631e3~CYNGmHYtC2036620366epoutp02k
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230906175423epoutp027f16b6ea34a8c6908cbcf03d0bb631e3~CYNGmHYtC2036620366epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022863;
        bh=FuvIo3RaeQMekt9GumvuSS1hGym5D2eIyqosTTpuIig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMT6BWWyEZSSsh7a7ALRi9nmrAIdMNHWBhHtyOzR3fnXlmdgg73chtN8Vrgm0is69
         ZKdeqkIwRiewuxWjiR3j1n+5H+AO0y1X8pC4HwFluGc32NJVPi8+wBgIT9j8Dba9H3
         zhGQo2SVizlJfwBKibEbwRbIILwPosr4gtGrxt/Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230906175422epcas5p41430db49a7589222a405a65bb0a265d6~CYNF0_DsU0784107841epcas5p41;
        Wed,  6 Sep 2023 17:54:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rgqkh0n1Dz4x9Pt; Wed,  6 Sep
        2023 17:54:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.D4.09635.BCCB8F46; Thu,  7 Sep 2023 02:54:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7~CXPFqJv4X3044230442epcas5p44;
        Wed,  6 Sep 2023 16:43:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906164321epsmtrp1078e3c9dc4e28283e9fcd5b112a8b2d6~CXPFpJI-Z0347103471epsmtrp1z;
        Wed,  6 Sep 2023 16:43:21 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-b4-64f8bccbe6e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.DA.08788.92CA8F46; Thu,  7 Sep 2023 01:43:21 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164318epsmtip27c4218f90213cf14ba28129d73b5d131~CXPCnvW7z0395803958epsmtip2E;
        Wed,  6 Sep 2023 16:43:18 +0000 (GMT)
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
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 04/12] block: add emulation for copy
Date:   Wed,  6 Sep 2023 22:08:29 +0530
Message-Id: <20230906163844.18754-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTee297adW6S2HshckglywDsZRqqS9OmBls3MRtIeo0409p6A0w
        Stu1RdmHoXzOwfhwsiUrDmgkYvko0gFDoAOKGxMFoo0gHzJ1sAgMRNigjritpbD57znPOc85
        73PeHA7OXyf8OKlKHaNRyhQUsY3V1hcSLLje5ZCH31uIRE0DP+Eop+wpjurvlhJovm8ZoOme
        zwCyLlaw0VjPFQyZ6n/E0Je2EYBmbhswZB0PRcaCGhbqsl5jIXvHeQJVXZzxQLX9f2PoTtkM
        QG3rVTgyzz9ioZ/HX0K/Fp0BaPhpP/uQDz081cyi7YMZtKXuc4L+riaL7hzTE/SFknNsujh3
        kaAfz4yz6Ec/3CbokpY6QK9YXqYt0wtY/I6EtIMpjEzOaAIZZZJKnqpMjqIOH5XGSCMk4SKB
        KBLtpwKVsnQmiop9O17wVqrCaZgKPClTZDipeJlWSwmjD2pUGTomMEWl1UVRjFquUIvVYVpZ
        ujZDmRymZHQHROHheyOchYlpKTcmK1hqc0zm/fUJXA96JYWAy4GkGFaaBrFCsI3DJzsBvFr+
        2MMdLAN45WrOZmYVwNycLnxLMli7xnInrAC2VWRvBvkYdBSedVZxOAQZCq//w3Hx3qQeh5c7
        LwBXgJN2DA61/sFytfIiEWxbqt5oyyJfgVVTZg+XmEcegPlLmS4ISSEs/cXTVcElX4M52TeB
        C/NIT3jtm+mNLjgZAHNbK3BXe0gWcWHLsmPzpbGw/vwU24294Fx/i4cb+8HZ0oJNfAqayi8R
        bnEegIZRA3AnXof5A6UbZnAyBDZ1CN20P/xqwIy5B++ExevTmJvnwfbKLRwEG5qqCTf2hSNr
        2ZuYhp3Td9juZZUAONj0O7sMBBqeMWR4xpDh/9HVAK8Dvoxam57MaCPU+5TMqf++OUmVbgEb
        V7D7cDt4cG8pzAYwDrAByMEpb95iwKqcz5PLPvqY0aikmgwFo7WBCOe+z+J+LySpnGek1ElF
        4shwsUQiEUfuk4ioF3nz+d/K+WSyTMekMYya0WzpMA7XT4/ldKco0MCcV0GX4wy6sXO7mXvi
        rtfJh/OrtwTNC7yyoklrqVUyMXyk4fu++ONddn+lzjrzruPNlbQ9tqbxoehQRUn6RdPpisq/
        Ro9nGX0ix0cbua1rcwk6oWAkYHv/4uyDLOPNYlvvoiCJ8r3vyFvff+T9iM64PY3i4h6Udy7K
        45MPVltNPt5iS4ei9/mJaKnxz17m02DT19KWsYcjfNFc915V+4KfQjdpFJW9l3h69kmtXpUQ
        IyzOOiZ8Q3/onYAdZvmJhKNDjXFBRQ2Zuu4auCtk5Gns5MpYvbGvLY5f8MWH3bde/a3BGmzx
        vhxa/sTTXzGxK9vePJt47Dn7paB6gmJpU2Si3bhGK/sXVJShlo4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK7mmh8pBm/3qVmsP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksXL1USaLSYeuMVo8vTqLyWLvLW2LhW1LWCz2
        7D3JYnF51xw2i/nLnrJbLD/+j8nixoSnjBbbfs9ntlj3+j2LxYlb0haPuzsYLc7/Pc7qIOZx
        /t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPxX2TWT16m9+xeXx8eovF4/2+q2wefVtWMXp83iTn
        senJW6YAnigum5TUnMyy1CJ9uwSujDN3ZrMUrHOuePj7NnMD40GzLkZODgkBE4mzy7+zdDFy
        cQgJ7GaU+PzmCzNEQlJi2d8jULawxMp/z9khipqZJBbu28nYxcjBwSagLXH6PwdIXESgi1mi
        c+c7FpAGZoH7TBKH5weC2MICFhLbPiwAG8QioCox/946dpBeXgEridYPFSCmhIC+RP99QZAK
        TgFriabGi4wgthBQxZ1Vr8FsXgFBiZMzn0BNl5do3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem
        5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHqZbWDsY9qz7oHWJk4mA8xCjBwawkwvtO/luKEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUxHRMublrV5XMmc
        1jTbY2FpSTFzhcaiJZETtiW/EzqxeqPrgVlO/syOs7beZNx76odol4XfAnc5xcsW32dNUnJ5
        3ra0YEeJ0GT9G+2JuU8SZx72P+ob7Wp4+4HCyhXGj2dx3l+80eLou4yg98dK6sS2KC5m7PCd
        fPOz0Ty+TeUrfJIenXdK3vK90bPscuU0kVXXmlzmcq3+fm2LcG0Uw1dtc5PZlX3d/0/MnM7F
        XfuR64W/ye3JC5WFmr1aOKfN86g49fOn6vU/PSdKYo+J71ux/ayMXHSAvau98Oz1yvaqX2vF
        /so6eF26mau8+sbO6b8UPu5T2CH+2HVH9TfvlJ1Nwq5elt+fJ8lEH3p9pPexEktxRqKhFnNR
        cSIApn2z4EIDAAA=
X-CMS-MailID: 20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7@epcas5p4.samsung.com>
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

For the devices which does not support copy, copy emulation is added.
It is required for in-kernel users like fabrics, where file descriptor is
not available and hence they can't use copy_file_range.
Copy-emulation is implemented by reading from source into memory and
writing to the corresponding destination.
Also emulation can be used, if copy offload fails or partially completes.
At present in kernel user of emulation is NVMe fabrics.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 227 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index d22e1e7417ca..b18871ea7281 100644
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
@@ -317,6 +331,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
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
+ *	as fallback to perform copy.
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
+	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
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
+	return blkdev_copy_wait_io_completion(cio);
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
index 5405499bcf22..e0a832a1c3a7 100644
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

