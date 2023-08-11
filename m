Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C24778D60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjHKLUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjHKLUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02542E77
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:12 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811112009epoutp01794cb14ba11f1a59d74c50915f5ee86d~6UDeUZfSP2881128811epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811112009epoutp01794cb14ba11f1a59d74c50915f5ee86d~6UDeUZfSP2881128811epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752809;
        bh=NrGERqVrpvjV00P/TGF6yHhSHm9V6YhqOP1XfV0rV+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWrul2naQxKchk//QUJOp9f1Alac9XSBZvbVm58zw0c4BLvqJDGcwPCmsvVISOOuf
         o2rAfljVz6rryKQ1mL7CvXnjZxIXO/rdHCmsRrxF5q+PlwHRwCCHFCUfdRj/V0zjQu
         hoHndOx9HmkLS/WL3mknmt0Dq9HAvk73OVls00UQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230811112008epcas5p4099a3317c3e81438337b6fde1c0604c3~6UDdrteYz1489114891epcas5p4e;
        Fri, 11 Aug 2023 11:20:08 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RMhCq0XV8z4x9Pr; Fri, 11 Aug
        2023 11:20:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.CE.55173.66916D46; Fri, 11 Aug 2023 20:20:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6~6TvcwAzaV0358903589epcas5p35;
        Fri, 11 Aug 2023 10:57:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811105713epsmtrp241c4c4bb5c8a8cc70a9ceaea04032c90~6TvcvCwop2537325373epsmtrp2v;
        Fri, 11 Aug 2023 10:57:13 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-ab-64d619663bd9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.13.64355.90416D46; Fri, 11 Aug 2023 19:57:13 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105706epsmtip2de366216a7f07d27cb8b25caff653317~6TvV2Ckx_1206312063epsmtip2e;
        Fri, 11 Aug 2023 10:57:05 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 04/11] block: add emulation for copy
Date:   Fri, 11 Aug 2023 16:22:47 +0530
Message-Id: <20230811105300.15889-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tL8WteikQDhi37hrjgPAotvWgMJfB9CaajcxtOp1gQy+P
        Udqmlwq6JfIcroSHVDIoMnAw5DUe5REediBEXgZ1EhDYRKewyZD3mDjDHOWK87/P73t+75Of
        ABetEi6CSHUMo1MrVBSxidfU5erqEeY8rPROaJWjmv5uHCVmreKo8m4mgaa7FgGa6EgF6H77
        PmSZzeej0Y4WDJVXXsNQducwQJNDJgxZxtzRpa9LeOiKpY+HBlsvEqiwdNIGXe75F0MjWZMA
        NT0rxFH19BwP9Y5tRQ/TzgF0c7WH/64TfXO8jkcPDuhpc8U3BF1fcpZuG40n6OIMI59OT5ol
        6IXJMR4999MQQWc0VAB6yfwGbZ6YwYJePxblF8EolIxOzKhDNcpIdbg/dfBwSECITO4t8ZD4
        ot2UWK2IZvypwENBHvsjVWtDU+JTCpV+TQpSsCzl9Y6fTqOPYcQRGjbGn2K0SpVWqvVkFdGs
        Xh3uqWZi9ki8vX1ka44noyK+bf0N11YHxM3XzePx4KrcAGwFkJTCoZVGvgFsEojIKwAu5TwG
        nLEI4PfdBfyXRleugb8Rkr/y1MbKIrIFwOoZd84pBYPF58YJAxAICNIdXn8usOoOZDwOa9uK
        19Pi5BQGh0d/AVYnexLBvwbirIl45A5oHK9bl4XkHng9x9eKkPSCmffsrB625F44Z75NWFlI
        2sG+vAmelXHyTZjUmI9zrWXawirDdo4DoaW3ncexPfyzp8GGYxe4NGshOI6F5RfKCGtnkEwG
        0HTHBLiHfTClPxO39oCTrrCm1YuTt8Gc/mqMq7sZpj+bwDhdCJu/2+DtsKqm6EV+Zzj8JOEF
        03CkpBDnVpUBYGNqE5EFxKZX5jG9Mo/p/9JFAK8ALoyWjQ5nQmVaiYeaiX35yaGaaDNYvwO3
        oGZQWbvq2QkwAegEUIBTDkL/w7eVIqFScfoMo9OE6PQqhu0EsrV9n8ddHEM1a4ekjgmRSH29
        pXK5XOq7Sy6hnITTKQVKERmuiGGiGEbL6DbiMIGtSzxW/4HP3ZqV6TlZrO1uSdnRAMcd7NyJ
        EyGHjoQtLKQ7597flTyR6BYr+wMcXN7Zt63tTNHTA5a65pGHcV0+E+KCRrtg8HkQ8mtbvHT+
        /c3Rpddyng8ZP9F89J5U/k9eae7xnR9nR/5qmBrUJ3Q/2Pppu/3ftb0qUfLPXsGPA9mlvaUD
        ea130pKC6z/0ORl8eov92Yu6DodEqvZyVvmtC/QNPyz+kTFnMY16zTGgc3l5YNhcG9x5Sn2V
        XP2xoest9vctdQ/0uYqyrONP8sO+0u5/JLEr/GIhysnL1Hgk2Xa+6ti9Fg+l+2eVQmHbl2W3
        6KlUaYPe+ANpCmBvuPtL+7JnjEeptw9QPDZCIXHDdaziP/1oRyGQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02ReUiTcRjH+73v6+vravC6pv08SFyJlaQZHT/tsLuXooMiOqBjtbcZeaxN
        xYpqaFpbmdIqc+sSZZGGtmkrLWveeSEpmo7UWS4pzzwqy2W9SeB/n+f7/fDwwEPhghzCnToR
        EcXKI8RhIpJHmEpFXgudhM2SRaN6N5RbXYGjuBQ7jrLbkknUUzoEUJf5EkDW1yGoqF/ngFrN
        BRh6lF2OoeslzQDZmrQYKrL4ofTETAK9LKoiUGPhHRLd19sc0cPK3xhqSbEBZPp1H0c5PQME
        emPxQB+vXAao3l7psGYWU99uIJjGumjGmKUimbzMC8yLViXJZFzTODBJ8f0k89VmIZiBV00k
        cy0/CzDDxtmMsasP2znjAG+lhA07EcPKA1Yf4YWmFnbispz1sYOGQVwJipepgRMF6SVQ92PM
        kWMB/QzA3NeHJnM3qLeX4ZM8Ez763f3X4f114jH4NrGdVAOKImk/WDNBcbmQVuNQVdBPcANO
        j2KwVa39J82kERypi+UWEbQP1LQbABfz6WBYczOIQ0gHwOQOZ85wolfAAWMDOXlOMBzUFwOO
        +bQzrErrIjjGaS8Y/1SHpwBaO6XSTqkeACwLuLAyRbg0/Jgs0F8hDldER0j9j0WGG8G/ly7Y
        9Rzoc+3+JQCjQAmAFC4S8lftbpAI+BLx6TOsPPKwPDqMVZQAD4oQzeLPCVNJBLRUHMWeZFkZ
        K//fYpSTuxLb3di5IeEoO5wwNzrRu+tBzHiD9/D5WlZD2240KdWshTrMasYTn1pv3/LwmdCe
        Tk1PDhTw1DrVWYmwzzBWbr0qUSV14MzSnwlyl4jvspjqnLYvZOoT8Xu/UK/P9dvGcaYp+Enr
        9s1lccq1ysx1x88pPE7tyxiy5oJYa3maum7xhzWXI291PPYMyc//FmTxyd/RvOlewSeH7JUH
        57e80/R1O07La97Kcx2ZYxr2XD3+uKqwd2OC2WpxDlno62o3FVXjpi21LotirrZUHHF7uzzK
        nF6WNbp/aA85z2WnoVp6cW+PdOgZ9F5ivZ73vfdhaKE9bdr0Fb46YUrHXfNI9s0oEaEIFQcu
        wOUK8R8sKNEjQQMAAA==
X-CMS-MailID: 20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
index ad512293730b..5eeb5af20a9a 100644
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
@@ -311,6 +325,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
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
index 81558cb7c019..67eab354592c 100644
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

