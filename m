Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA57A7696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjITI7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjITI6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:58:41 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B9181
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:25 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230920085823epoutp014674c2ce3aafed67aa2190fab2edfb6d~Gj7HYypH32981529815epoutp01F
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230920085823epoutp014674c2ce3aafed67aa2190fab2edfb6d~Gj7HYypH32981529815epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200303;
        bh=USZuQeTvMitlfy93ih628plbLc65lwCeOm5YsC+EdU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVfdM21jDAZhhsqHZ8zq7az9h/SpwJTRDfbOeDALfVKHR4PZTC9Be4EH9wEEoodDJ
         J1bWHY2zWUzmtGfBmTX7S12HEhlITDEJVLn0EU3+ozUlI7eZB5BGwebEkklYYdl/8N
         uVwmHmStuL596YiAzTtKUHmiy1XkNfgfu06iJxnE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230920085822epcas5p1f94e94baa1b8732aa448cf982905526d~Gj7GprOEC0802708027epcas5p1O;
        Wed, 20 Sep 2023 08:58:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RrC9n144Cz4x9Q3; Wed, 20 Sep
        2023 08:58:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.EA.09638.C24BA056; Wed, 20 Sep 2023 17:58:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1~GjVNKAH8J1823718237epcas5p3e;
        Wed, 20 Sep 2023 08:14:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920081458epsmtrp257233cb19de201dcd100c4f587068814~GjVNI2jX30164101641epsmtrp2y;
        Wed, 20 Sep 2023 08:14:58 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-78-650ab42c5f42
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.9E.08788.20AAA056; Wed, 20 Sep 2023 17:14:58 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081455epsmtip154f3f3e10d1122f2fe8c5d9c247e6cfb~GjVJ4fh3S0186201862epsmtip1O;
        Wed, 20 Sep 2023 08:14:54 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 04/12] block: add emulation for copy
Date:   Wed, 20 Sep 2023 13:37:41 +0530
Message-Id: <20230920080756.11919-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1BUVRTHue8tj4Vx7QkoFxppXVNDB1gQtouCOab0AscYoamxjF7sCxjY
        Zdvlh0QTGGACww9FIhcUVn4JGCghP10kCPnZLOGwGxAQuNsU1CKgZZHSsg/L/8753HPu937P
        ncPFbbOtnLiR0lhGLqWjBYQNp6nbZZera6MNI+yYxVD9wB0cLT5c4aDP8h7jqHYyl0Dz3UsA
        6Ts/B0htLLJEY52tGKqu7cHQ+S4tQIZRJYbU43uQ6kw5B91S93PQ3bZiApVUGqxQlq6FQFW9
        TzD0Q54BoBb9aYCaVkpwVDe/wEF948+je1lnAdI87rU86Ei1KietKM3UDQ5197s4qqEmg6C+
        Lk+m2sdSCKosJ9+Syk41EtSiYZxDLXSMElROYw2glhucqQb971gQ70SUbwRDixk5n5GGxYgj
        peF+gsDg0FdDvUVCD1cPH/SygC+lJYyf4PDRIFf/yGjTEAT8eDo6zoSCaIVC4H7AVx4TF8vw
        I2IUsX4CRiaOlnnJ3BS0RBEnDXeTMrH7PIRCT29T4ftRESMXWzDZyKFT/6zex1LAQ+9MYM2F
        pBfsa23CMoEN15ZsBzDtGxXOJksAKqu+AmzyB4CPtEOmhGtu0eg+YrkawF/HlJZsko7Bur/u
        4WtFBLkHDq5y17g9mYLD6+1l5ptwsgyH6qkSYk3cjkSwp62HsxZzyB1w9sEjM+eR+2Da6ATB
        qrnD3OlNa9ia3A+Xy3VWbMkm2H9Rb27FyRdg6s0i87MhWWYNF1Q5HNbcYTjUXESwsR2c6220
        YmMnuGxUr/MEWH3hKsE2p5k865SAPXgFpg/kmt3gpAusb3Nn8VZYMFCHscIbYfaKHmM5D7Zc
        fhpvh9fqS9fvd4TaP0+ve6Fg6vWTa9iWzAGwoDYwD/CVz9hRPmNH+b9wKcBrgCMjU0jCGYW3
        zFPKJPz3yWExkgZg3ovdAS1g5qf7bl0A44IuALm4wJ4n2WnD2PLEdOLHjDwmVB4XzSi6gLdp
        3Odwp81hMabFksaGenj5CL1EIpGXz16Rh8CBN59+SWxLhtOxTBTDyBj50z6Ma+2Ugm3J+vBQ
        t9pYe8ni3V82Z2w7Wz+dOq7CnYtbNxgr0ex4/HCwJgHuKJxLLrxt99q1oJIQo3iqQqh+rnls
        +/GhU3E+NXPHfH6rnrmcdPwlQ+mRJeX3YR9EJTpGuwzLLEI6Fasi/7CAI1r7ManEQTPxorXW
        3qtixVWgS6JvjPT3hTzRLZ+7KrR4HXv7QOGbJwe3OfpqxBkV/MlPeKrqzDlV4Vnf3s7Z80fn
        OrbSwY1XNhi+sN1ZP71L+/cilbT3258T7zTOE/Fch5n9+hL61oUz8ZUPnAdvX/myOd+vYMtE
        /o9OK5qAg+/4l97kit/TO6R6Vn26sUp17A3S8q3kFcNwYLGL+5TuhICjiKA9duNyBf0vqg9d
        LKAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzHfb/P03PPHdeeruJbJjnKVlOdxHeJEeNZIczMDDl6VHNXuZMf
        +UOcXbpIQnYdYuXi2o4rUkd2LklIVqs4S4vOr5vqpGIpXLH577XX+/357LN9aEJUS/rSySl7
        OUWKVCamBGRlrdhvDjQIuLDGbF9848kjAjsHhkl8NG+EwGUdpyjsqP0KcLclC+CaHp0bfmWp
        hvh6WR3E+dY2gO2thRDX2ILxFXUJie/VNJC4xXyBwkV6Ow/ntFdRuLR+FOKXeXaAq7qPAFw5
        XERgo6OXxI9tU/G7nOMAN43Uuy3xYasLO3hs0xsTybY0prPlhmyKrSg5zN59lUmxxbln3NiT
        qh6KddptJNt7v5Vic28ZANtf7seWd3+Ba4WbBVEJnCx5H6cIXbxdkNSsrYJpzdEHfv7qg5lg
        IEIDaBox81BT+x4NENAi5i5A+eespAbw/3gfpB95SIyzJ7o++oE3XlJBVHIxk+capphg9PQX
        7fJejIZA2dU9Y8MEYyJQ86P5LvZkMKoz1415kglAb799p1wsZCLRsdbX1PgRoehUp4dL85mF
        qL+knedi0Z/K0xdFvPG6B2rQdv9dPx2pbuuIPMAU/hcV/hddBtAAfLg0pTxRrpSkzU3h9oco
        pXJlekpiyM5UeTkY+3NQUBW4Z+gLsQJIAytANCH2EsoDBZxImCA9mMEpUuMV6TJOaQVTaVI8
        RTjoOJkgYhKle7ndHJfGKf6lkOb7ZkJjwefwoQcrc4TuHtNO99Wv1Dom2mXq8+4a/vvU5NWS
        oe9tZt21GY6tk0ofms4Ndgzm2woO/XzuvWvLoC0mQGqOdJh2JMf0vMl16jpVxiO6G8XyyN7Z
        wKBesKDtcItz0ZUT0OTxoeuqUp+wjnPK7AMxk8LDNvmPBMfGxzYGWEIuwC/+SUMnuiRqL77b
        xMSGH6ROH1jqfjPes8XbdMlkz0rSRHQu9j499Gw9/PgpLLbggDovzrLOsmbFHX14JZ61MTrq
        WeV8MwyYE+2tndy8bcK+5cOrskLjjH5nrxa/1C6LuKmSdc14MnP7aEfUNEmj0Z6xdIlzw/61
        4v6KhfKCOP8aMalMkkqCCIVS+hta4tVRVgMAAA==
X-CMS-MailID: 20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081458epcas5p3a3e12d8b5661b5d6f4420316630b02e1@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
At present in kernel user of emulation is fabrics.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 223 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   4 +
 2 files changed, 227 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 50d10fa3c4c5..da3594d25a3f 100644
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
@@ -316,6 +330,215 @@ ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
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

