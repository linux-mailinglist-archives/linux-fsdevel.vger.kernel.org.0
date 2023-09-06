Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD444794251
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbjIFRyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbjIFRyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:54:11 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2421A8
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:07 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230906175405epoutp04217f320b4834969f7271d9c26606ec97~CYM2N0Dr03253832538epoutp04U
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230906175405epoutp04217f320b4834969f7271d9c26606ec97~CYM2N0Dr03253832538epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022845;
        bh=zz5VvO0LliNfVmWInGmvdscXo09ZxUMGUEhzPpRKTzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FERoPQKozKHxOZu7c8XJdMKbVX6VICqjXtegTy3ZUhRPlNh9880Cz+yoVSbSOzIjC
         u3oDGUbVxC1iicEnG7Iahy1kqNHMLt5Y0PPjMSwHISrkt7mnEXfDo4x8OfPd3ehC+x
         3wqblTroVoZKhJkje7YKcmer51WnOwfAXp8i/328=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230906175404epcas5p17321abf761d5601a63f98876638a25f2~CYM1YCwmr3144031440epcas5p1-;
        Wed,  6 Sep 2023 17:54:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RgqkM1TwYz4x9Pq; Wed,  6 Sep
        2023 17:54:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.E9.09638.BBCB8F46; Thu,  7 Sep 2023 02:54:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164253epcas5p32862e8384bdd566881d2c155757cb056~CXOrTg7hy2340723407epcas5p3a;
        Wed,  6 Sep 2023 16:42:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906164253epsmtrp17d1a464b7be2b3b6c956ceb2417d9414~CXOrSgaIN0347103471epsmtrp1l;
        Wed,  6 Sep 2023 16:42:53 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-3f-64f8bcbbc8d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.D9.18916.D0CA8F46; Thu,  7 Sep 2023 01:42:53 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164250epsmtip2679d08d4fd4005d5e89be7677af09db6~CXOoYb_4R0104301043epsmtip2O;
        Wed,  6 Sep 2023 16:42:50 +0000 (GMT)
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
        Hannes Reinecke <hare@suse.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date:   Wed,  6 Sep 2023 22:08:26 +0530
Message-Id: <20230906163844.18754-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaVATZxjH++5uloU2ZQGVV5hqmtIPxHKEq8tlodJ2R+3AFGrVjqUp2QGG
        kGSyiaidKshVzgAqSiinXImMKIojAToMiKmkLdOhYMURkSY9AIPFKi1CaUKg9dvv/T/3885D
        oK45Dh5EqlTJKKQiCR93wq4Negt8enr/EvsX1WBUx/BNlDpZtoJSF+6pcWp2cAFQpv58QPVZ
        qjnUnf5uhOptrEAo7YUhhBpafYhTFQPjgDKPaRCqb2IH1ZDXhFG9fbcwalT/FU7VtZgdqFbD
        Pwj1U5kZUNee1aHUxdl5jPpmwpMaWTFwotzpkcnLGD36nYru1BXg9JWmE3TPnUycPl96ikOX
        ZFtw+g/zBEbPfz2G06VXdYC+Yvycfty5je40PUTiuAfTIlIYkZhR8BhpkkycKk2O5O+JT9yV
        GBziL/QRhlJv8nlSUToTyY/ZG+fzbqrEOjmfd1gkUVmlOBHL8v12RihkKiXDS5Gxykg+IxdL
        5EFyX1aUzqqkyb5SRhkm9PcPCLY6fpqWcu9BFkf+Y8QRXfHfnEyQF1gIHAlIBsGphm85hcCJ
        cCV7ACw7k43YDK7kAoBz+YF2g5VXV/KRjYinHWeB3dANYMXNacz+yEVgdeVdtBAQBE7ugMZV
        wqZvIjNReKnn/FoESj5BoPHXYgdbKjfyELxr0OM2xsjX4cKfBaiNuWQYHCxeXEsEST+ovu9i
        kx3JcHgy6wdgd3GBt6pMmI1RcjvM7qpGbfkhecoRdp1rd7C3GgOHurSond3gjOHquu4Bf1fn
        rXMG1J5uw+3BOQBqbmuA3fAWzB1WrzWBkt6wQ+9nl1+BZ4YvIvbCL8OSZ6b1tXDh9doNfg22
        d9Tjdt4Kxxez1pmGZnPd+rZKAdSOtYEywNM8N5DmuYE0/5euB6gObGXkbHoywwbLA6RMxn/f
        nCRL7wRr5yDYfR08mHrkOwAQAgwASKD8TVzL9qdiV65YdPQYo5AlKlQShh0AwdaFl6Mem5Nk
        1nuSKhOFQaH+QSEhIUGhgSFCvjt3NrdG7Eomi5RMGsPIGcVGHEI4emQiqowkj8Zm9w9Mlqhp
        zNh22+lVX8/fsM17nnxhRLS15fubGnYWdM97tZzLbvJCBo48rg0r8qlbbu2Pnk1w4zv2fe9d
        ou6V6D/Lia2cBPsMqrejPtZlsCOxh1Leyy+ci64P33c63ivsUZGFqNEORfpFexYKbsTrdD7m
        yy9qLWUfVYYvb9kfP7F6IKaxzriq31JzKZfj3lIe1+w8JR9fSlDPjv8y08RtC3/h7EuCn0e7
        NHsPLgd4vm/q7OYh458449k5b3CGheWGvC+HMwPfEXx4PErhcuD+jUXP2pXd04eJolbnyXa/
        BCJgic2KdembO+F09PhMqH4bgZvSqqqajxmYpX4+xqaIhAJUwYr+BTHN11CXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCSvC7vmh8pBideilmsP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksWfRJCaLlauPMlkc/f+WzWLSoWuMFk+vzmKy
        2HtL22Jh2xIWiz17T7JYXN41h81i/rKn7BbLj/9jsrgx4Smjxbbf85kt1r1+z2Jx4pa0xfm/
        x1kdxD3O39vI4nH5bKnHplWdbB6bl9R77L7ZwOaxuG8yq0dv8zs2j49Pb7F4vN93lc2jb8sq
        Ro/Np6s9Pm+S89j05C1TAG8Ul01Kak5mWWqRvl0CV8bdh42sBVdsKlb1/GRtYGwz7mLk5JAQ
        MJH4tn46YxcjF4eQwHZGicauPSwQCUmJZX+PMEPYwhIr/z1nhyhqZpJ49nQqUIKDg01AW+L0
        fw6QuIhAF7NE5853LCAOs0Ajs8SxfR1g3cIC0RIdDTeZQGwWAVWJT186weK8AlYSh3u+gw2S
        ENCX6L8vCBLmFLCWaGq8yAhiCwGV3Fn1mhGiXFDi5MwnYMcxC8hLNG+dzTyBUWAWktQsJKkF
        jEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYKjVitoB+Oy9X/1DjEycTAeYpTgYFYS4X0n
        /y1FiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWkmq5xk
        0fcMTw331/X7p5pt8v96qr4nvmJH3Sr/3h9ZBfv7p1dsPHn+QWmXvBHj/018H1i++7e+eVjT
        LnBtW6S1m67XwzscCsvdexzO/eTsvM2je0fmy82vGpzZP6IsEr8fTkxYNOvNr8rre54x9zaV
        rdh2z7E5+KNQewNjBNe3eQvM7rzNzSzMfHnK3+6BU3DdZ/Z1xTPklLeIswbq75A+ddPnxf1F
        fy5IGHh4Pt/z2kjK58iTe3mC642qLpe9mPMjov1nBmfks/eNp2xrvTfOMCg8YSo3SfSzgteu
        iuI7usz8fbJP6y6WpcwoW+u+tdq07elEE6/z1b9XRK3YunmvhYfs1AXHbevsnR65MSixFGck
        GmoxFxUnAgDyunsgSQMAAA==
X-CMS-MailID: 20230906164253epcas5p32862e8384bdd566881d2c155757cb056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164253epcas5p32862e8384bdd566881d2c155757cb056
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164253epcas5p32862e8384bdd566881d2c155757cb056@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add device limits as sysfs entries,
	- copy_max_bytes (RW)
	- copy_max_hw_bytes (RO)

Above limits help to split the copy payload in block layer.
copy_max_bytes: maximum total length of copy in single payload.
copy_max_hw_bytes: Reflects the device supported maximum limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 23 ++++++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++++++++++
 block/blk-sysfs.c                    | 36 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 13 ++++++++++
 4 files changed, 96 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..96ba701e57da 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,29 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		August 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the maximum number of bytes that the block layer
+		will allow for a copy request. This is always smaller or
+		equal to the maximum size allowed by the hardware, indicated by
+		'copy_max_hw_bytes'. An attempt to set a value higher than
+		'copy_max_hw_bytes' will truncate this to 'copy_max_hw_bytes'.
+		Writing '0' to this file will disable offloading copies for this
+		device, instead copy is done via emulation.
+
+
+What:		/sys/block/<disk>/queue/copy_max_hw_bytes
+Date:		August 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the maximum number of bytes that the hardware
+		will allow for single data copy request.
+		A value of 0 means that the device does not support
+		copy offload.
+
+
 What:		/sys/block/<disk>/queue/crypto/
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..4441711ac364 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_copy_hw_sectors = 0;
+	lim->max_copy_sectors = 0;
 }
 
 /**
@@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_copy_hw_sectors = UINT_MAX;
+	lim->max_copy_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/*
+ * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
+ * @q:	the request queue for the device
+ * @max_copy_sectors: maximum number of sectors to copy
+ */
+void blk_queue_max_copy_hw_sectors(struct request_queue *q,
+				   unsigned int max_copy_sectors)
+{
+	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
+		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
+
+	q->limits.max_copy_hw_sectors = max_copy_sectors;
+	q->limits.max_copy_sectors = max_copy_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
@@ -578,6 +598,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
+	t->max_copy_hw_sectors = min(t->max_copy_hw_sectors,
+				     b->max_copy_hw_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..4840e21adefa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -199,6 +199,37 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
 	return queue_var_show(0, page);
 }
 
+static ssize_t queue_copy_hw_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+		       q->limits.max_copy_hw_sectors << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+		       q->limits.max_copy_sectors << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
+				    size_t count)
+{
+	unsigned long max_copy;
+	ssize_t ret = queue_var_store(&max_copy, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	if (max_copy & (queue_logical_block_size(q) - 1))
+		return -EINVAL;
+
+	max_copy >>= SECTOR_SHIFT;
+	q->limits.max_copy_sectors = min_t(unsigned int, max_copy,
+					   q->limits.max_copy_hw_sectors);
+
+	return count;
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -517,6 +548,9 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RO_ENTRY(queue_copy_hw_max, "copy_max_hw_bytes");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -633,6 +667,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_hw_max_entry.attr,
+	&queue_copy_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..7548f1685ee9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		max_copy_hw_sectors;
+	unsigned int		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -893,6 +896,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_hw_sectors(struct request_queue *q,
+					  unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1211,6 +1216,14 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 	return bdev_get_queue(bdev)->limits.discard_granularity;
 }
 
+/* maximum copy offload length, this is set to 128MB based on current testing */
+#define BLK_COPY_MAX_BYTES		(1 << 27)
+
+static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_copy_sectors;
+}
+
 static inline unsigned int
 bdev_max_secure_erase_sectors(struct block_device *bdev)
 {
-- 
2.35.1.500.gb896f729e2

