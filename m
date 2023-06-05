Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBDD7225B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjFEM3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjFEM3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D9ED
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:30 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605122928epoutp0428fbe76ece7355c4c63a0e44e9069295~lwx33wv-c1857918579epoutp04e
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605122928epoutp0428fbe76ece7355c4c63a0e44e9069295~lwx33wv-c1857918579epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968169;
        bh=XtAXhvnJKkZLthC90pQwMUapDiLrIj5s2XGYljXFy3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQ/7mf1JbbFspT7Ngh2SeB7IRihc9hG+tJrspQllaq+gFBDuBv/iI+Y9GUal7JbNN
         FnwTungbrscVzhu1ft9u6jB++8PVwQtuwZFe42YQymrHXfcJwagRKnq/giVx11ojzh
         Gq2bBwOjw/fAD5qAakWy9TNx0dn/DFsDiobT7IUs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122928epcas5p4b692346fb9b641b4c9b3e8a20b72a4be~lwx2_KwUy0962809628epcas5p4T;
        Mon,  5 Jun 2023 12:29:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QZXwk1xfBz4x9Pt; Mon,  5 Jun
        2023 12:29:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.49.04567.625DD746; Mon,  5 Jun 2023 21:29:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122122epcas5p27d70bd972c1063ecb543ea4489870fd7~lwqy3owFb3040930409epcas5p2o;
        Mon,  5 Jun 2023 12:21:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605122122epsmtrp1e2d7fa0ca0d16df66ef92d953df766b4~lwqy2XyPz1437514375epsmtrp1u;
        Mon,  5 Jun 2023 12:21:22 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-4a-647dd5260903
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.A5.28392.243DD746; Mon,  5 Jun 2023 21:21:22 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122114epsmtip224958e7fecb35e637355c81ec48af8a0~lwqrYRYqT2526625266epsmtip2U;
        Mon,  5 Jun 2023 12:21:14 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 1/9] block: Introduce queue limits for copy-offload
 support
Date:   Mon,  5 Jun 2023 17:47:17 +0530
Message-Id: <20230605121732.28468-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxT2vbdcignsAjJeYUItwQUcH92gviggEbNcBBJ0Rjb9wTp6BQa0
        TVtQwWEZgzkVisA2VlBk6mjBgICw8infX8oQOzCQISSjbgiCwCJfAdbSsvnvOc97nnPOc94c
        Jm5VaWrHjBFIabGAF8cmdjJq211c3fYNfcX3zM81QxV9XTj6OnsdR2VjcgJNty8A9MPrFRxN
        tnwLkGbSAk08PIyaZgtM0EhLHYYaf87BkKqsE0MNxfMY6tx8RaCctmGAtEMKDDWN7kfFGXcY
        qLGpl4E09YUEKvpFa4quPlMTqKR7A0NtuWkYUk+mAlS7VoSj8uk5BuoZtUcD690maG25kAhw
        oDS/B1OK8X6CqlOMmVIDzysZVLXSldL0J1BVpd8RVPWdS1TDiIygbmflmlCZabMENa8dZVBz
        zUMElfWgFFDVj5KpxSqHMMvTsb7RNI9Pi1m0IFLIjxFE+bGDP4kIjPDmenLcOD7oAJsl4MXT
        fuyjIWFuH8fE6fbEZiXy4hJ0VBhPImF7+PuKhQlSmhUtlEj92LSIHyfyErlLePGSBEGUu4CW
        HuR4en7orUv8PDZ65O96XFQedv7G5R5MBnoCrwAzJiS9oGxpnnEF7GRakQ0AZs7LjcECgEPq
        MtwQLAJ4r3vBZFuS19FIGB7qAZxrWTIG6Rj8MVujkzCZBLkfPtpk6vldpBKHqUuPGXo1Ts7i
        UH0zRJ9jTR6H+b179TSDdIYvVDJcj83Jg7CxtRfTp0DSA8rHLfW0GXkITvW3GVMsYe9Pk8aK
        jjCtpmBrUEiOmsFrHb8Bw6BHoWqmGTNga/iy+4GpAdvBKXmGEZ+DqjwlYRB/A6DimcIoPgzT
        ++RbXnDSBVbUexjoPfD7vnLM0NgCZq5NGuub61xtYyd4r+IWYcC74fBSqhFTMGfzqalhV1kA
        TjW/ZGQDluItQ4q3DCn+b30L4KVgNy2SxEfREm8RR0Cf+++XI4XxVWDrdlyD1GBs4rV7G8CY
        oA1AJs7eZV5/LJlvZc7nXUiixcIIcUIcLWkD3rqFX8ftbCKFuuMTSCM4Xj6eXlwu18vnIy6H
        bWv+vl9vpBUZxZPSsTQtosXbOoxpZifDxBb+J5bFNU7au+3jr4r3TAw9KawfXE0czN1BZpwx
        V9VQQRaXsnyO3GxwGQgOLe1KkdIpTloW+2lBJdfhpFnwyJ9n9raUDL5oSj518W6oLd21IZOv
        9l1YPawU+hdF2XbYRMPTnylbC35l2a6818hkbZ78B3ofmHb+g62QXc+PD2JtBGoijwVpwx0D
        l9xXBAF/Jd7/wvH40HlrwqG0wi1ccy24dnNf0qk3MW9uLLtQn9Y+TvlyfXxHXS7zyDvv5i30
        pwyGL+OtZ0PXoi9qYrLzO7FhZ3HdoQ8Kff0KR4QDt1G6+nmIUpsxP2qjGseuVj25f/byiaSZ
        CfuAhzNy5xJH+0UTNkMSzeO44mIJ719D7dsKxAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTWRzFvfe9Ph516jwK0QtmJFZcAooLfLjjMA6D280QFUkMxkShyAsu
        pdYWxm0MaIcRMUhDcasLgojSuiCIUtqiVhCqAppSTEkEIwU1CFjgg1tBC5nEb+d/fud/Ph2W
        Er+hg9jt8nReKZfKJIyQvvNQErwgxn4wZVHeV4RvPn5E4cMaD4UNL/MZ3PdwCOCTHz5R2HX/
        CMB21xT86t4f2DJwVoCd940Qm0sKIC43NEBsKnZD3DDWz+ACazvAPQ4dxJaOMFz8XymNzRYb
        je215xhcVNbjg4+9qGHwlcZRiK1aNcQ1rkMA3/lSROEbfYM0buqYjls9jQL85eM5JnoGsbfF
        El1XM0OMupc+pLXzFk2qroYSe3MGqdQfZUhVaSYxObMYcum4VkDy1AMMcfd00GSwzsGQ47f1
        gFQ9OUCGK2fE+W0SRqXwsu1/88qFy5KE25xvaynFjbi953OaYBZoWp4LfFnERaLCejOTC4Ss
        mKsBqL5II5gAgajMU09NaH9UPvrGZyKkhmho5PF3wLIMF4aejLFeP4C7TaHmz1qB96C4wzR6
        WtYNvd/+3Dp0pLvJx6tpbjbqLc8abxVxS5H5gQ16ixC3EOV3+XltX+439K7ZOt4v/h5xDEZN
        pP2Q7YyL9mqKC0bq6rOUBnC6H5DuB3QRQD0I5BWqtNQ01WLFEjm/J1wlTVNlyFPDt+5KqwTj
        WwgNrQFm/YdwK4AssALEUpIAUe1fB1LEohTpvv28cleiMkPGq6xgOktLpome5doSxVyqNJ3f
        yfMKXvk/haxvUBbcN+knXm9hZ/mFDx0dLv4louR9I+mOaI/d3CdgZZw5cvUS2rH7xOCOnOFq
        9Dn7a3TCeY9wjWa0n+rXf4STCnLuloXkbxjpzE7KL9h4fU6F4cSVqPhVvcceuOTJoC3+lPJP
        68wuexIwh+i0dZ6YsXt7tXNh4emqsOr11otzLytKmUfu+ucxr7KT5+3xb7l6yuCMlQXYemdy
        /nHunYFBCZr213UXXkytaOk1Zvy6X2VKMNaaSGtfYUl8ZEnDuslcwibLz44WnjfOEqTn6UK2
        rA1+/j5uxT85hSJn9Eb3/JWSNktEpuna79ejEgciKsStl3VqalnP7MwYQ6fYuTl55F8Jrdom
        XRxKKVXSbz8IBUF6AwAA
X-CMS-MailID: 20230605122122epcas5p27d70bd972c1063ecb543ea4489870fd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122122epcas5p27d70bd972c1063ecb543ea4489870fd7
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122122epcas5p27d70bd972c1063ecb543ea4489870fd7@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add device limits as sysfs entries,
        - copy_offload (RW)
        - copy_max_bytes (RW)
        - copy_max_bytes_hw (RO)

Above limits help to split the copy payload in block layer.
copy_offload: used for setting copy offload(1) or emulation(0).
copy_max_bytes: maximum total length of copy in single payload.
copy_max_bytes_hw: Reflects the device supported maximum limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 33 +++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++
 block/blk-sysfs.c                    | 63 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 12 ++++++
 include/uapi/linux/fs.h              |  3 ++
 5 files changed, 135 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c57e5b7cb532..3c97303f658b 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,39 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_offload
+Date:		June 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file shows whether offloading copy to a
+		device is enabled (1) or disabled (0). Writing '0' to this
+		file will disable offloading copies for this device.
+		Writing any '1' value will enable this feature. If the device
+		does not support offloading, then writing 1, will result in an
+		error.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		June 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the maximum number of bytes that the block layer
+		will allow for a copy request. This will is always smaller or
+		equal to the maximum size allowed by the hardware, indicated by
+		'copy_max_bytes_hw'. An attempt to set a value higher than
+		'copy_max_bytes_hw' will truncate this to 'copy_max_bytes_hw'.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes_hw
+Date:		June 2023
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
index 4dd59059b788..738cd3f21259 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_copy_sectors_hw = 0;
+	lim->max_copy_sectors = 0;
 }
 
 /**
@@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_copy_sectors_hw = UINT_MAX;
+	lim->max_copy_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_max_copy_sectors_hw - set max sectors for a single copy payload
+ * @q:  the request queue for the device
+ * @max_copy_sectors: maximum number of sectors to copy
+ **/
+void blk_queue_max_copy_sectors_hw(struct request_queue *q,
+		unsigned int max_copy_sectors)
+{
+	if (max_copy_sectors > (COPY_MAX_BYTES >> SECTOR_SHIFT))
+		max_copy_sectors = COPY_MAX_BYTES >> SECTOR_SHIFT;
+
+	q->limits.max_copy_sectors_hw = max_copy_sectors;
+	q->limits.max_copy_sectors = max_copy_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
@@ -578,6 +598,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
+	t->max_copy_sectors_hw = min(t->max_copy_sectors_hw,
+						b->max_copy_sectors_hw);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a64208583853..94e90a877cec 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -212,6 +212,62 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
 	return queue_var_show(0, page);
 }
 
+static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(blk_queue_copy(q), page);
+}
+
+static ssize_t queue_copy_offload_store(struct request_queue *q,
+				       const char *page, size_t count)
+{
+	s64 copy_offload;
+	ssize_t ret = queue_var_store64(&copy_offload, page);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_offload && !q->limits.max_copy_sectors_hw)
+		return -EINVAL;
+
+	if (copy_offload)
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+
+	return count;
+}
+
+static ssize_t queue_copy_max_hw_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+			q->limits.max_copy_sectors_hw << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n", (unsigned long long)
+			q->limits.max_copy_sectors << SECTOR_SHIFT);
+}
+
+static ssize_t queue_copy_max_store(struct request_queue *q,
+				       const char *page, size_t count)
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
+					q->limits.max_copy_sectors_hw);
+
+	return count;
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -590,6 +646,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -637,6 +697,9 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_offload_entry.attr,
+	&queue_copy_max_hw_entry.attr,
+	&queue_copy_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 04a133d32c67..5ff161c18ae8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -295,6 +295,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		max_copy_sectors_hw;
+	unsigned int		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -563,6 +566,7 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+#define QUEUE_FLAG_COPY		32	/* enable/disable device copy offload */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -583,6 +587,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
@@ -901,6 +906,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
+		unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1220,6 +1227,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 	return bdev_get_queue(bdev)->limits.discard_granularity;
 }
 
+static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_copy_sectors;
+}
+
 static inline unsigned int
 bdev_max_secure_erase_sectors(struct block_device *bdev)
 {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..a16bafada09d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,9 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* maximum total copy length, this is set to 128 MB based on current testing */
+#define COPY_MAX_BYTES	(1 << 27)
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

