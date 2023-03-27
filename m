Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFC6CD43C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjC2IQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjC2IQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:16:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4144AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:16:03 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230329081602epoutp014c193abdb79d30edabe2aa14987f230f~Q1dLBklor1190311903epoutp01c
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230329081602epoutp014c193abdb79d30edabe2aa14987f230f~Q1dLBklor1190311903epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680077762;
        bh=8LMsuFU+adOGECMdeeltyN6nn0NGSJ2FHXwHcZ2lfa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esYXPDxSUXLO6DiWbogdjDMgpv3j8uhnPYQ6H3RmmlVcSDBVXRYEM59za3V2P4RGo
         mqjmMCRtzzLmMudX2gDe563aWzh/GLNKhQaipgOZsiuhQuu9ccXkQZE06IKC7mB491
         weFnvP2SQr858Hs/icmGHQjbqlcaOc7Eu6LrTdsY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230329081601epcas5p32acd68a630e2d9664166d41744fec1d9~Q1dKTAu2J2887628876epcas5p3d;
        Wed, 29 Mar 2023 08:16:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PmfWg4sGYz4x9Pt; Wed, 29 Mar
        2023 08:15:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.B5.55678.FB3F3246; Wed, 29 Mar 2023 17:15:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230327084216epcas5p3945507ecd94688c40c29195127ddc54d~QOhgrkaAa0488004880epcas5p37;
        Mon, 27 Mar 2023 08:42:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230327084216epsmtrp10833f46bb72e7e16fb46bdb08d3d4324~QOhgqQCmH3087630876epsmtrp1m;
        Mon, 27 Mar 2023 08:42:16 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-04-6423f3bf0833
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.B5.31821.8E651246; Mon, 27 Mar 2023 17:42:16 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084212epsmtip141d949ff8ed23c9813a82bf4362350a0~QOhdMdMe-3056830568epsmtip1I;
        Mon, 27 Mar 2023 08:42:12 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Date:   Mon, 27 Mar 2023 14:10:49 +0530
Message-Id: <20230327084103.21601-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230327084103.21601-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRzved+xH9r0BQkeKGm+mgs7YLOxHjjQvDh7L7kLz0sLKnxj7wEy
        tt1+SGlXiwGKCSO8KAeCBMcOLMSByE/tINFBRApSCIQgSwwHDKLTW1gbg/K/z/f7fD7fH5/n
        vlzcJ48TyE1VaBm1gpaT7DWsxs7g4JArC5tloubcTeh8dxeOMguWcHRu1MhG053zABXNPcKR
        s7cPR+0zxV5o6PtmDLV9U4ih6nNXMdRa7sDQ1X/sbFTYMQiQ7ZYJQ+23X0Jt7VYW6m8pYaOy
        KhsHdZwyYKhp8jOAGp1lOKqdnmWh67efRX1L17xehVT/wB7KNNbLpppNoxyq77cLLKq/V0dZ
        anLZVH3lp1TrkJ5N5RlmXITsMS9q9vItNpXfUAOo+p6j1IIliLJM2rG49fFpUSkMLWPUAkaR
        pJSlKpKjyT37El9LDJeKxCHiCPQKKVDQ6Uw0GRMbF7I7Ve7ygRQcpuU6VyqO1mjIsB1RaqVO
        ywhSlBptNMmoZHKVRBWqodM1OkVyqILRRopFou3hLuLBtBSz3V91fe+H1vJOoAd9MScAjwsJ
        CZwaeABOgDVcH6IVwC+79bgnmAdwYKST7Wb5EAsAXir1WlX01PYAT74FwOyZNI/AgEGjYZLl
        fmATQvjDvezlsr5EDg4dtlyWO8CJOxgsy6xclm8g4mCd+cGygkW8AOvbzrryXC6fiICnP5e6
        ISTCoHHM283gEZGwpKl7eQg+4Q2tpz29cOJ5aLhYvDw1JMw8uDhYx/ZoY2D58IueoTfAP641
        cDw4EN435qzgZPiw34Z5sAoaui4DD94Js7uNuLsMTgTD8y1hnvRGl0G1mKftOpjnnFyR8mFT
        6Som4bHqkhUMYftP+hVMwYKlSo7HtzwAHd+GFACB6YltTE9sY/q/81mA14AARqVJT2Y04art
        Cibjvx9OUqZbwPJdbHujCYzfmQvtABgXdADIxUlfvnOQlPnwZfRHRxi1MlGtkzOaDhDuMvsL
        PPCZJKXrsBTaRLEkQiSRSqWSiJelYtKfL4y2JvkQybSWSWMYFaNe1WFcXqAeU3rfqxJvNmce
        4vn9cjzmTETAonnxxpEfxWf8Dn9SDG1Pmx4vkhMl7/n6nUzY6Xj3/u+7hVyrzqsajObOqmOi
        hmMvpI7kvl48va72oZ/5pIHcoqqIf/8vi8Do/GociTOc7UVdf2vn9MVbDowIt/IzChu4nLW7
        coKfyq9IyrZb/QNij+8f493of7O0YpS4GfZzVroph6aH/hy/tDZoeNxmD8262/hIOFVDs/e+
        VR0s/njuVJWoon5fHadIILQnbMz/db8p4THv7akg3tfh73wXmiIxzX7QeSAr4Kj80I7exK1K
        08jk/BWLQ5l67OCuidLDkfGbJjLXXxQO18w8Z3VUSu/ezCRZmhRavA1Xa+h/AePZOzWgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTURyHOfder9fV6DpNj5qKq1wYrTKVU/RikXErkt6oMESnXlTadG2+
        VWRLi8oyzdBqCZaY5SItlzptis20nMgiW29kYzWzsM1lVCxTc5PAb78/z/OcL4fCeU8Jfyo9
        I4uVZYjEfJJDNHfxg5Z92ReSsmLU5oMa9D04KiidwNHdwRISjXSNAVRhd+BovN+Ao3bbdTf0
        trMVQ9rqMgzV3e3G0KOb3zHUPWUlUZnuFUBDRiWG2t8tRdr2XgINtFWSqKp2yB3pLhdiSGM5
        CVDzeBWO6kdGCfTsXQAyTDx1i4bMwMvtjNLUTzKtykF3xvDhAcEM9GczjapzJKOuOcE8eqsg
        meJC27Rw2uTGjHYYSebiQxVg1H3HmB+NQUyjxYrtnBfHWZvCitNzWNny9YmctNtWX+mzXXm9
        N7uAAhg2FwEPCtIRsK++DxQBDsWjNQB+H/9IzAAI9V9rwcz2gnWTw+4z0kkM3ipocUkkLYBP
        hk+7am+6FIcvTArSeeC0DYMqc62b0/KiY2HJlVOugqAXQ7X2xnRBUVx6Nbx2Pso5Ib0clpg8
        nYYHvQZWavSukjdtlJxpw5ybS3vC3msW1ys4HQwLm67jpYBWzkLKWegGwFTAj5XKJakS+Upp
        eAabK5SLJPLsjFRhcqakEbj+OixMA7Qqu1AHMAroAKRwvjdXvT0khcdNER05ysoyE2TZYlau
        AwEUwfflPi/qTeDRqaIs9hDLSlnZf4pRHv4KLCL+njE4PvaOIHLH79jPmnp33/3mqZ4xH5X3
        mZ/icONknU0efiBalrkbBputvy1is7EiZ2e710YJHbHquVdEq9LaY3jyynLstf9cfENzUujZ
        T3ul+YyiM3Cyu2mJXpVT/r52X0vMnLRtw0nRwDP/l8RRuagpsXoULy5fVFm6JHSdRdhRY9+4
        4HN1R9HhvK0NuOEqJzQ9iBeTe5CKedxQFaxytJn4iWPqeJMjZ8f9zmRBZD6hX+hToD/1o3lZ
        8ZY9zFB4QpQ5juyeyowUmg+A6G/c446kCcFgYJzW9MG+t7zMcim5xv5JcPBCpN+mq2M8g+XN
        KvHxP/PzW/4GFATyCXmaaGUYLpOL/gEgU2CjWgMAAA==
X-CMS-MailID: 20230327084216epcas5p3945507ecd94688c40c29195127ddc54d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084216epcas5p3945507ecd94688c40c29195127ddc54d
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

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
 Documentation/ABI/stable/sysfs-block | 36 ++++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++
 block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 12 ++++++
 include/uapi/linux/fs.h              |  3 ++
 5 files changed, 139 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c57e5b7cb532..f5c56ad91ad6 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,42 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_offload
+Date:		November 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file shows whether offloading copy to
+		device is enabled (1) or disabled (0). Writing '0' to this
+		file will disable offloading copies for this device.
+		Writing any '1' value will enable this feature. If device
+		does not support offloading, then writing 1, will result in
+		error.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		November 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
+		device, 'copy_max_bytes' setting is the software limit.
+		Setting this value lower will make Linux issue smaller size
+		copies from block layer.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes_hw
+Date:		November 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Devices that support offloading copy functionality may have
+		internal limits on the number of bytes that can be offloaded
+		in a single operation. The `copy_max_bytes_hw`
+		parameter is set by the device driver to the maximum number of
+		bytes that can be copied in a single operation. Copy
+		requests issued to the device must not exceed this limit.
+		A value of 0 means that the device does not
+		support copy offload.
+
+
 What:		/sys/block/<disk>/queue/crypto/
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..350f3584f691 100644
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
+	lim->max_copy_sectors_hw = ULONG_MAX;
+	lim->max_copy_sectors = ULONG_MAX;
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
+	if (max_copy_sectors >= MAX_COPY_TOTAL_LENGTH)
+		max_copy_sectors = MAX_COPY_TOTAL_LENGTH;
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
index 1a743b4f2958..dccb162cf318 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -213,6 +213,63 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
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
+	s64 max_copy;
+	ssize_t ret = queue_var_store64(&max_copy, page);
+
+	if (ret < 0)
+		return ret;
+
+	if (max_copy & (queue_logical_block_size(q) - 1))
+		return -EINVAL;
+
+	max_copy >>= SECTOR_SHIFT;
+	if (max_copy > q->limits.max_copy_sectors_hw)
+		max_copy = q->limits.max_copy_sectors_hw;
+
+	q->limits.max_copy_sectors = max_copy;
+	return count;
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -591,6 +648,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -638,6 +699,9 @@ static struct attribute *queue_attrs[] = {
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
index e3242e67a8e3..200338f2ec2e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -298,6 +298,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned long		max_copy_sectors_hw;
+	unsigned long		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -564,6 +567,7 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+#define QUEUE_FLAG_COPY		32	/* supports copy offload */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -584,6 +588,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
@@ -902,6 +907,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
+		unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1221,6 +1228,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
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
index b7b56871029c..b3ad173f619c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,9 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* maximum total copy length */
+#define MAX_COPY_TOTAL_LENGTH	(1 << 27)
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

