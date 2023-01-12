Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303D66734E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjALNhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjALNhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:37:12 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653048CCB
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:10 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230112133707epoutp0212532dcfd77bdd5ccc512a23a5164a34~5kz0vKWCT2230822308epoutp02s
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230112133707epoutp0212532dcfd77bdd5ccc512a23a5164a34~5kz0vKWCT2230822308epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530627;
        bh=1hrkgfW4fuWprZ+hdImzV02kYbdcSvOZkXpC5k82hno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKJRhyTWx4KAf3Z6F88IU32oTOiEPJ2YjiOJqoqLH3Q756pf5UpEWsE7G/O759+UG
         f007E0kBczdt4BDUmO8PEJ9wK4Fv58LkFtFiXbjQ4I08vkFgDK53q76puYYiNwlFx8
         3rhFXU5NuoInyZSd+yq9hOtxPNxWzjn29xwrpONI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230112133706epcas5p204c5ff92395c7759f7ecf00574594e55~5kz0Gbabv2066520665epcas5p2C;
        Thu, 12 Jan 2023 13:37:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nt5FF1ZQrz4x9Pq; Thu, 12 Jan
        2023 13:37:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.56.03362.10D00C36; Thu, 12 Jan 2023 22:37:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230112120011epcas5p33c10ec9a0cb2ee4c0c68737bb879a154~5jfL-tEuf2906129061epcas5p3u;
        Thu, 12 Jan 2023 12:00:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112120011epsmtrp2497415fb52a1294aebb952c9a531b200~5jfL_kmgL2747827478epsmtrp2I;
        Thu, 12 Jan 2023 12:00:11 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-c0-63c00d01682e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.23.10542.B46FFB36; Thu, 12 Jan 2023 21:00:11 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120008epsmtip279c81d9fc7492fa1fe2ac4e2ce550029~5jfJMwj_g0962409624epsmtip2_;
        Thu, 12 Jan 2023 12:00:08 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 1/9] block: Introduce queue limits for copy-offload
 support
Date:   Thu, 12 Jan 2023 17:28:55 +0530
Message-Id: <20230112115908.23662-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O6ecHshKjlXDR5fNWmY2IEALpR4YoE5cDpMfNVuiIxh2Uk5o
        A73YliG7uFIQMzLAGQQpZKCWOgpCBki4FZENuUsmQ+Wm6MqCTqsTNt1AGOXA5r/nfd7nvTzv
        lw9H+X9jAlylMTJ6DZ0mwrw4zT/6vxMEeF0KcWcdRtYPXENJ86mXKFkzXYiRDleZBzne1YqQ
        HedPI2R1TQ9Ctp/7AyF7Vh5j5Onum4CcHbMgpGMikOxw9HPI0bZyjKywzXLJFmcWIJsXK1By
        viqHS9b9/oRD9k28To687PXYs42y3B3GqFbLNJcaufMDhxodTqca7F9jVKP1K6p93IRR+dku
        jHrSOYZRBU12QDUOfk7NN7xJNTgfI3JeQmqUkqGTGb2Q0Si0ySpNSrTowIdJ+5LCZWJJkCSC
        3CUSamg1Ey2KjZcHva9KW/UrEn5Kp6WvUnLaYBCFxETptelGRqjUGozRIkaXnKaT6oINtNqQ
        rkkJ1jDGSIlYHBq+KvwkVTlh7eLqSg8ey8q6jpnAxdg84IlDQgotxXPcPOCF84l2APsuXfBg
        g2cA9i6OcNhgHkCnowNslPSXLK+r2gCcK2tC3Qk+kY3Ae649eQDHMSIQDq7gbnorMYXA1kE/
        tx4l2hGYdWIZcye2EHL460rBWi2H2AltVW1rPI+IhKPN5cDdBxIhsPDuZjftSbwLa28vcFjJ
        Zthf6lzDKLEdZl8uQ939IVHoCa/cGkfZRWNh6VztOt4CH/Y2cVksgPMuB8biDFhd9D3GFucA
        aLllWXe5G54YKETdS6CEP6xvC2HpN+CZgTqEHewN8xedCMvzYMt3G9gP1tZXrvf3hTefZ61j
        CjpXphD2cAUAPjt/FTkFhJZXDFleMWT5f3QlQO3Al9EZ1CmMIVwXpmEy/ntlhVbdANb+QMCB
        FnB/5mlwN0Bw0A0gjoq28jp6rij4vGQ68zNGr03Sp6cxhm4Qvnrwb1HBNoV29RNpjEkSaYRY
        KpPJpBFhMonIh8dcrlDwiRTayKQyjI7Rb9QhuKfAhCi3D9uDuF4VvfbDNp8mjkRefBD1brW+
        iFFcqEU2dUwqjp9tdJ4c0lX6v+11/ZeH6ri8BdVQmPm3lKiiI66W/U/jcF9sttxlUzknCw+N
        1C6UyMxLHyzslsZ9uX/HseOJy5f8DVMB1Jnno+JNi8tX/2pO/MZ8URez16f6du6+TFNC1dnY
        3snEAuXkn9XvfSSQdeb07aixev681/6xjvb1f/Ba/KNQ2nk/fzpi8c5JNYZmDx3tu/eWWb4r
        3jTTFel3aMg2oyeKbhxttZa/KKG0D1R5DWOO5riZDD7v2qOfgv6pzFV+EWG7kZuwpItdsgo0
        mYgp3FzsHdruFScMjDxyuA0XcQxKWhKA6g30v9lB556MBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK73t/3JBhc3c1usP3WM2aJpwl9m
        i9V3+9ks9r6bzWpx88BOJos9iyYxWaxcfZTJYvfCj0wWR/+/ZbOYdOgao8XTq7OYLPbe0rbY
        s/cki8XlXXPYLOYve8puseNJI6PFtt/zmS0+L21ht1j3+j2LxYlb0hbn/x5ndRD1mHX/LJvH
        zll32T3O39vI4nH5bKnHplWdbB6bl9R77L7ZwObR2/yOzeP9vqtsHn1bVjF6bD5d7fF5k5zH
        pidvmQJ4o7hsUlJzMstSi/TtErgybi05wF4wM7CisfEcWwPjcpcuRk4OCQETiZPT/7F2MXJx
        CAnsYJQ4+ekJI0RCUmLZ3yPMELawxMp/z9lBbCGBRiaJd29zuhg5ONgEtCVO/+cA6RUReMYk
        cfbeI2YQh1ngOJPEyeaVLCANwgJ+ElefLGcFsVkEVCWWLd3FBmLzClhJXN42hxFkkISAvkT/
        fUGQMKeAtcSaG19YIHZZSczac5UJolxQ4uTMJ2BxZgF5ieats5knMArMQpKahSS1gJFpFaNk
        akFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcJxqae1g3LPqg94hRiYOxkOMEhzMSiK8e47u
        TxbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB6UzFwZL7
        FytXX/q4K95R/YDV9vsmuklz1c9emmrxO3XnlY4rzaG9KpnMZgn9izaKxFw7ecXGocf1j6f+
        ibsv+Q9FX7y44MXHzDfLQgLf7fzZ8vh82PuEs/M00o7cvpHzQ+eti/4czZUKUUKvmOq1nRen
        c71R8/c9xnavpPy9RvSODT9jYzqvWpcGxD2Z5ijAn+hw93rZe26+lUulo5X3h1vulTFo+F4s
        u0Uobl6v1s1Iy8gv6V8E3aPf3fp2wHReUrVfqI+7+dtPX7bKt1/q5W16wHAp+uXlHINj70PW
        15/zPX/TgH/OApUHapE7mLZ/vPrvbNSzh5Y1+dVTbE6vijcRZKpVTXibpfrF5XOGjxJLcUai
        oRZzUXEiAIs/ID1CAwAA
X-CMS-MailID: 20230112120011epcas5p33c10ec9a0cb2ee4c0c68737bb879a154
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120011epcas5p33c10ec9a0cb2ee4c0c68737bb879a154
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120011epcas5p33c10ec9a0cb2ee4c0c68737bb879a154@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
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

