Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14669CB50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBTMsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjBTMsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:48:23 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E8186
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:15 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220124813epoutp038762fa3cfa69bec6c2ad40557e1f6a86~FiTQ-rgho2305723057epoutp03H
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220124813epoutp038762fa3cfa69bec6c2ad40557e1f6a86~FiTQ-rgho2305723057epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897293;
        bh=1hrkgfW4fuWprZ+hdImzV02kYbdcSvOZkXpC5k82hno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbaXnPOAMcZi/juQa/vp1WKh/1qQY9ooa7Coy1kNAaCxf7bEORqKrae38BPU/XR7n
         QpOuMAWeLhjEqpgZXkGEbMgKIqc0mK4+jzZ4txWzQRkRcr1nFBV9EpZkze/mDJ0sC7
         +4ZIlUOBDX/rKBhsHEnhk+0jcyLaOg++7kzfBhK0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230220124813epcas5p3e3a2a70e83cc481d02efcddd16dd3d33~FiTQY3-PX1435814358epcas5p3K;
        Mon, 20 Feb 2023 12:48:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PL2Jp14Bvz4x9Pv; Mon, 20 Feb
        2023 12:48:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.49.06765.90C63F36; Mon, 20 Feb 2023 21:48:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105432epcas5p2dc91dbe3588d8f45bf312bde2683791a~FgwAF5_N00586305863epcas5p25;
        Mon, 20 Feb 2023 10:54:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220105432epsmtrp23630d9e2a122f5d05c92d4bcbcc7dd65~FgwADYODD1664116641epsmtrp20;
        Mon, 20 Feb 2023 10:54:32 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-8e-63f36c09bff5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.8C.05839.86153F36; Mon, 20 Feb 2023 19:54:32 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105428epsmtip227dfcc5ac704f641e0f590c825bd91cd~Fgv8kVbEk0747407474epsmtip2u;
        Mon, 20 Feb 2023 10:54:28 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 1/8] block: Introduce queue limits for copy-offload
 support
Date:   Mon, 20 Feb 2023 16:23:24 +0530
Message-Id: <20230220105336.3810-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjOd045tCSdh8uyb9UxLDqgk0tHWw4bbCYycjJGgu6HxsxAaY+F
        UNrS0w5QxnXEMMNgDBfpcAVsUKjAVi5y64LVCZQxXBgoRS5iiVHkDqJhBFsKun/P+zzPe/3y
        MVGvj905zFSFhlIrxHIu5sHo+DaIF+whX5eE6X4FRIv1e5QoLN9BCeNUGUbcXvkHJbaHR1DC
        vHTHjZjo60KI3roKhGgwPkSIntpVhHi4u4gRFZZxQMyP6RDCbDtJ9JoHGcRodzVG6Ovn3QnL
        rSKE6LQXAKJjW48SzQvLDGLA9iIxstPv9voRcvRpHKmbGcbILt2UOzkyfZ9Bjg5rSVNjCUa2
        GvLInol8jCwtWnIYimfcyOUHYxh5o60RkK1DH5LrJl/SZF9EEl54Ny0qhRJLKbUfpZAopakK
        WTQ37lLiG4lCURg/mB9JRHD9FOJ0KpobczEhODZV7jgB1++KWK51UAlimuaGno1SK7Uayi9F
        SWuiuZRKKlcJVCG0OJ3WKmQhCkpzmh8WdkroMCalpdgMfe6qqjezCgoeY/ngi5jrgMWEuAAO
        VhvBdeDB9MJ7ALy3uIO5gjUAhwwWN1fwF4B1AwXuBynPVs37ghnApjkDwxUUIXB+e8WhMJkY
        fhIO7TKdCT74zwjsGvJ3elB8FoH6QgNwCt54Atz86Ke9qgz8VfiDIX+PZ+ORsFm3iTrrQDwU
        ls14OiELPw23rmW7HJ5wsMrOcGIUPw6L2u+grtk+Z8GWmjMuHAMXWmb3eW/4R3/b/vwcuL5k
        xlw4EzZUfrm3McSvAaj7UQdcwjlYbC3bGwHFg2BLd6iLPgY/sTYjrr6HYOm2HXHxbNh59wD7
        w69aavbrH4XjWwX7mISTjypR16lKATQZK93KgZ/uuX10z+2j+791DUAbwVFKRafLKFqoCldQ
        mf89skSZbgJ7v4IX1wnmZldCLABhAguATJTrw95lr0u82FJx9geUWpmo1sop2gKEjnPfRDmH
        JUrHt1JoEvmCyDCBSCQSRIaL+Nwj7IDoQYkXLhNrqDSKUlHqgzyEyeLkI6l3a2MTA33r86Ro
        luSJ9beN6eVvjLZb3hqPWD6oLT/kOd0xIktItUs5q0njn9qactdyOMb2Z9G51Un3Vx738bOz
        rD5psq+rugZfiahPNobOpXXnRfz9Xo5mY8lnIiNj5vzO1fl4ldaWOBk8gphCTvTKeSWxyXEV
        Nz67OqBsqGlb1rPwm7y5hXNPTSY0IPO7wNap+MDcoGNrWy/V0vfevtQeNNDUwfY8O3ah98LG
        Ey97f/zUiZSFUzmgV1sY8FqI4eUm+S8qvWiiZO3Pyw8sdfpg/1rho+F0ofww6/1W3lvdk8nD
        1Kbv5SvKcElm3sXi43brO2eG2PT07963BVsZUclcBp0i5vNQNS3+F7mmEUueBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfVCLcRzA7/c8z56e5nY9LXf9Kq9DVKSdnF/OOZzjSYpdDueczHqu0jbZ
        FOVtM687Lwm5FoqSDItFRY0MZWqqS14inbVyx9UkebnKeMSd/z7f+3y+9/3jS+HCasKfSlJu
        YVVKqVxE8omyB6Kx0xIlfbKw6y4+KnlSg6M9mUM4utJ2jETZn37gaMDegCNLTy4Pvaq+jaGq
        C1kYunzlEYYqz/di6JG7m0RZ1ucAdbYYMGRpDUFVFhuBmu+cIVFeUacHsp7QYajCqQWobCAP
        R6aPLgI9bg1ADUO1vHm+TPOzKMbQbieZ24Y2D6bh7Q2CabanMmbjIZIpLdzNVL7SkMwRXc/v
        YF87j3HdbSGZozeNgCmt2870mccwZmc3ttxrDX9OPCtPSmNV0+eu5ye2FlZ7pORItmm1T0kN
        uLRQDzwpSIfDwV4LTw/4lJCuBLA2r5wcFn6waOghPsw+8PLP9x4cC2ktBgf3iPWAokg6BNa5
        KW53JN2FQftbB84NON2DQeO7Ih4X+dAxUHdTxO0S9CTYWKgBHAvoCGgy9ONcAunp8Fi7N4ee
        9Gz4bW/68KUI+Dir9G/tDW05ToJjnB4Ldbdy8UxAG/5Thv9UPsCMwI9NUSsSFGpxiljJbg1V
        SxXqVGVCqGyTwgz+PDk4qAKUGz+FWgFGASuAFC4aKXAL+mRCQbw0PYNVbYpTpcpZtRUEUITI
        V9Cot8UJ6QTpFjaZZVNY1T+LUZ7+Guya1AR4+bvtE1mX8Vq96r6i/+W9KaclgcV2Kx2btmzp
        5ojXnc9fjP6s2+YV+LTg6kmf4h1Bi+clh22cMDNpZcjB2sEScZfJusJZZbj1uuCSQjK/Yvy6
        qM1RXhOaDid8lVcu4QHNm6acMGdr2vFZbu/PU8869PE7s4sZ00Ltm1yZ+ei+jGpjAGoPci0O
        HxQucu58KPMdtbEm8pk70i+6e7lX0Y6amuACH2JDWfaInILjLYHNpV2jlDM2ODK+9EU6VjnO
        1ctj328/0BaHpBbjqRc/9mfa30VPwTrKGtf1dzR9Hwg9Y4tZNnlBVke++eLL8l0hH0hJ+lpZ
        xvnYcbYY5lyJ72oRoU6UioNxlVr6C5Z+Bt5TAwAA
X-CMS-MailID: 20230220105432epcas5p2dc91dbe3588d8f45bf312bde2683791a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105432epcas5p2dc91dbe3588d8f45bf312bde2683791a
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105432epcas5p2dc91dbe3588d8f45bf312bde2683791a@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 Documentation/ABI/stable/sysfs-block | 36 ++++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++
 block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 12 ++++++
 include/uapi/linux/fs.h              |  3 ++
 5 files changed, 139 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index cd14ecb3c9a5..e0c9be009706 100644
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
index 0477c4d527fe..ca6f15a70fdc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -58,6 +58,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->max_copy_sectors_hw = 0;
+	lim->max_copy_sectors = 0;
 }
 
 /**
@@ -81,6 +83,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_copy_sectors_hw = ULONG_MAX;
+	lim->max_copy_sectors = ULONG_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -177,6 +181,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
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
@@ -572,6 +592,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
+	t->max_copy_sectors_hw = min(t->max_copy_sectors_hw,
+						b->max_copy_sectors_hw);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea..82a28a6c2e8a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -212,6 +212,63 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
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
@@ -604,6 +661,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -651,6 +712,9 @@ static struct attribute *queue_attrs[] = {
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
index 43d4e073b111..807ffb5f715d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -303,6 +303,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned long		max_copy_sectors_hw;
+	unsigned long		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -571,6 +574,7 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+#define QUEUE_FLAG_COPY		32	/* supports copy offload */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -591,6 +595,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
@@ -911,6 +916,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
+		unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1229,6 +1236,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
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

