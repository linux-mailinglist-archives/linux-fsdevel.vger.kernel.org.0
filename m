Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B8778D4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjHKLUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjHKLUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:06 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD4E71
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:00 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230811111956epoutp04bad1f518921775eeefc9978fe7ae99cd~6UDSX4ZgC1413614136epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:19:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230811111956epoutp04bad1f518921775eeefc9978fe7ae99cd~6UDSX4ZgC1413614136epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752796;
        bh=blaoC074Ya9ltXHcd0v3GbswvL2JJkNv5V3x6ev1dEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8q+U6EApJ7pTXdnzj1cK6+Kc2+Crr/oG9OsdmYD0J+SZNg3dTMk3t2pduHPuxvT2
         MM5PjrPB4I8wY72yYJ6kA46j+s+/8809rObzCSjDCCmWQNzNqCqDRkUVXA9XPJuh+Z
         z+OVoT8L21DFFhx1IUI/ToZZ4l/C5oaB8TUk40g0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230811111956epcas5p40da669816432f41c3ed102802f4354f3~6UDRxQ6sd1085110851epcas5p4c;
        Fri, 11 Aug 2023 11:19:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RMhCZ2H2Fz4x9Px; Fri, 11 Aug
        2023 11:19:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.4D.55522.A5916D46; Fri, 11 Aug 2023 20:19:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1~6Tu8Bn2f70692406924epcas5p4F;
        Fri, 11 Aug 2023 10:56:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105638epsmtrp1ef8c2c8c5cf02cd46cd1268f490bd855~6Tu8AjKzq0289502895epsmtrp1g;
        Fri, 11 Aug 2023 10:56:38 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-a2-64d6195a258f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.51.14748.6E316D46; Fri, 11 Aug 2023 19:56:38 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105633epsmtip269f03b32902ad1e771641fe58a40cb75~6Tu3pdOob1095610956epsmtip2g;
        Fri, 11 Aug 2023 10:56:33 +0000 (GMT)
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
        Hannes Reinecke <hare@suse.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 01/11] block: Introduce queue limits and sysfs for
 copy-offload support
Date:   Fri, 11 Aug 2023 16:22:44 +0530
Message-Id: <20230811105300.15889-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+4tt62zywVkHIoP0oVsKPSBBQ4vdZlx17gsGHTLNAyv9A4I
        pa0tVRkzw/FSoy2gxq1MXr4GTMAK6MpjrowBZaKDwRBX5xjNAlhe4sQRx1qvbP73Od/z+35/
        53dODg/3yucKeamqDEaropUiYhmnqT0oKGSX36BCOtwgQHW2H3D0WeFTHNXYjQSaaJ8FaPRG
        AUD3v92IWidLPNCdG99gqKWyGENVNR0Y6lh0EqjYOgiQY8CEodbhdagi/zwHtbR2c1C/5UsC
        lV10cNGlzn8wNFToAKhpoQxHtRNTHNQ17I9uPe302ASpW/eucKj+m3rKXH2UoK6e/5RqvpNN
        UOcMJz2oEzmTBDXjGOZQU20DBGVoqAbU1Z4s6qF5NWUedWJxgl1pMSkMrWC0AYwqSa1IVSXH
        irbFJ76VGBYulYXIIlGEKEBFpzOxos3vxIVsSVW6phcF7KeVepcUR+t0IsmGGK1an8EEpKh1
        GbEiRqNQauQasY5O1+lVyWIVkxElk0pDw1yFe9JSKq7UcjRdMQcfVPwBssHfoccAnwdJObTN
        HAFu9iKbAbT07DwGlrl4FsC6Bws4u/EXgGOPM5cMxsEcDlvUCmBHqZnLLvIwWG2uckXxeAS5
        DvYs8tz6CjIbh/XN54B7gZNHcWg3dHDdUd5kAuxrn+e4mUMGwoJSK+ZmARkFiw4Xc91BkJRA
        42+ebplPRsMpcx/BlnjC7i9Gn1lxcg3MaSzB3fmQLOPDJqeFYL2b4XT9PvbU3nC8s4HLshCO
        GfOf8wFYdeorgvXmAmj6xQTYjY0wz2bE3Tk4GQTrLBJWXgVP22oxtu8r8MTCKMbqAni9dIlf
        g1/XlRMs+8HBx4efMwVPH5kh2MsyAHhv6BpeCAJML8xjemEe0/+tywFeDfwYjS49mdGFaWQq
        5sB/j5ykTjeDZx9i7dbrwH5/WmwFGA9YAeThohWC2Pg+hZdAQWd+zGjViVq9ktFZQZjrvotw
        oU+S2vWjVBmJMnmkVB4eHi6PXB8uE/kKJvLOKrzIZDqDSWMYDaNd8mE8vjAb21deEfzn7e0l
        GnTppjOrPtpUkFUlvrzqVfsF82Te2eDfZ63+ReNJtv4kp0M58qh35M2VwdTd+hwLR7gbpDby
        7x7a67BnddEfquP3fC+ukj7cBI4POV9aVNScAXSbfD4XSFWhFs/gXyOj5z9fzxt4eWTIGBjU
        fkFyzfDzTl+75ckngpOEz5jn/oOzap+y0FJzbvT7IYE7jn5U5/tTb2qxsCE4SvLkXe7tWHFj
        y47t30X4rzm+dco6NukTPVfJ70gw1GxTzEk0p8YrX0+YMuz9wCOsd0tIXNeGy2+P/ZgZUTYp
        PNTZO2ejvVeeaRVVxwS1WULfeNS1vHu1Q/neiP7idNby3SKOLoWWrcW1OvpfX7k/epkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH932e5557url5utr6Kqu5kZRSHL4pYY09+COb34Xcumf50VXu
        SqIRh9YtlcsWpXJlUSnrcCKRSz+vRFRXG5q7xOruyo+GdHFi67/X3q/35/3Ph8IFjwlX6mBs
        AiuLFccISR6hbRB6+H5w6pH4dzXNRrfbmnB0JnsSRxVvskg03PAZIFN9GkADT9agOks+B/XV
        P8DQo2IVhsoqGjHUOGUmkUrXA9Bgdx6G6vp9kPr8dQI9qmsl0KuHV0lUVDrIRTeabRgyZA8C
        pJ0owlHVsJVALf1uqHOymbMWMp1vqwnmVUcioylPJ5k7108xtX2pJFOSmcNhLigsJDM22E8w
        1sfdJJN5txwwd/QnmC8ad0ZjMmNb+OG8YAkbc/AoK1sSsp93QF1dRcS3BB8bURtBKvi5VAkc
        KEiLYFaPglACHiWgawEcN/Ti02IOLJ189o+dYJltiDtdUmDQ9OEGRwkoiqR9oH6KsufOtBKH
        6Q8sf5dwOheH4/druPZrJzoCvjd0AzsT9AKYVqjD7MynV8GLp1Vc+xCkl8Csd4722IEOglZN
        F2lnwZ/KaOlTMF13hK1XTISdcdoDKu7l49mAzpuh8maoawArB3PYeLk0WhoVEB8Qyyb5ycVS
        eWJstF9UnFQD/r7Y26sGvC2y+ekARgEdgBQudOav3tolEfAl4uTjrCwuUpYYw8p1wI0ihC78
        gMv5EgEdLU5gD7NsPCv7bzHKwTUVoz62vACGJ70i910u278Frl/vK/80NH/j3Ui9yzY431z5
        kntidMfusZBZu09akwVR5wuMFcG1IYFbmrpurVyRVODRlvF5mVfb3nHj64kcz97InAzHSRet
        c8g4yI1a7H/v5jZ1uHaFtGS5rDizw+0HT64Uzctsxr025VpNRs/IuNDi/anDnZjRZ5Gktarm
        sFPQrJfuCzeL9qWwnT2WIZFrYsbWke8bbQNJliOsamfhOo+5CRzf5zsku1KSyoNHOcNqc7vA
        P+yi4qHu3blD1eRZwyFVc6PN0HqpsPrqzoF1G0IjBszCr2t4fQrjj19De/T6sIh2rWeBeGSq
        MqVM4jYh3CAk5AfEAd64TC7+DaW9uupRAwAA
X-CMS-MailID: 20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1@epcas5p4.samsung.com>
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
index c57e5b7cb532..1728b5ceabcb 100644
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
index 0046b447268f..7c6aaa4df565 100644
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
+	if (max_copy_sectors > (COPY_MAX_BYTES >> SECTOR_SHIFT))
+		max_copy_sectors = COPY_MAX_BYTES >> SECTOR_SHIFT;
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
index e2418c7c16c5..6ab3b0d60315 100644
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
@@ -892,6 +895,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
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
+#define COPY_MAX_BYTES		(1 << 27)
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

