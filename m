Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770B7A7686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjITI6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjITI6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:58:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9FDE
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:15 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230920085812epoutp0414aac24d6188e68a1f5e0ec9d6fecb59~Gj68t2gul1275412754epoutp045
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230920085812epoutp0414aac24d6188e68a1f5e0ec9d6fecb59~Gj68t2gul1275412754epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200292;
        bh=Pnjs48GpM2fNI5vQ32r+zx38m0Ym/uFN2UPMQUh9Xn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiSVNHIDKf7BCpaQa9RNAVJVW1wKDG9eF94qpVZ2K8G8iqZMtGvZkSIAk1Y5MmKvx
         fT1tkBTAMJbc7n7P2EELbJylqckg5iBzINbBOin4ztWXhs8sn52/P/J0w5uXNU46L1
         j4VFTtcUBhlqHiABCiozoin1TBavv9uxmlJHR74M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230920085811epcas5p282b9d9c0b16a7c30dff7c6d563b1b7dd~Gj68DxkQu2273322733epcas5p2G;
        Wed, 20 Sep 2023 08:58:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RrC9Y6VxCz4x9Q1; Wed, 20 Sep
        2023 08:58:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.74.09949.124BA056; Wed, 20 Sep 2023 17:58:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230920081425epcas5p407a3b1ee776082798adb92e8025699f1~GjUuhAu0T2321223212epcas5p40;
        Wed, 20 Sep 2023 08:14:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920081425epsmtrp226bf5e4a93a025c4257d97c0743b3497~GjUuf60FK0164101641epsmtrp2a;
        Wed, 20 Sep 2023 08:14:25 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-5e-650ab4212680
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.FE.08742.1E9AA056; Wed, 20 Sep 2023 17:14:25 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081422epsmtip135b046fe83b44edbfd4fed015cd575c5~GjUrI0Vcg2886728867epsmtip1k;
        Wed, 20 Sep 2023 08:14:21 +0000 (GMT)
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
        Hannes Reinecke <hare@suse.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date:   Wed, 20 Sep 2023 13:37:38 +0530
Message-Id: <20230920080756.11919-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1CUZRTu/b7l2wsufoLiyzrJtk3EJS6bsLyIVBZDH+QPZoia0RxY2W+A
        2Bt7AaOyVSFAWyDRkoVAFEvAuIOLuMUl3AQNaQcIZgARqBkYQWQ1GkRiWSj/Pec55zzPOeed
        l4U7f8vksZLlGlolF0sFBIfR0uXl6ftSE4cOyFvwRbU9N3G08HiZgU4UrOCoejSfQLNdjwCa
        as8GyDRX7ICG21sxdOPiGQxVVndjqHv1AYHOdA4CND1gwJBpxAeVf1nBQDdMtxjIcr2EQGXf
        TzPR6SEjgX4wP8PQHwXTABmnjgPUslyGo5rZeQb6dWQX6lsxO7zFo1oNo0yqb6yeQVnuaKmG
        qlyCaqz4gmob1hHUpbxCB0p/co6gFqZHGNT8TwMElddUBajG3k+pxYbdVMPUAyza6WDKviRa
        LKFVfFqeoJAkyxPDBO/FxL0TFyQKEPoKQ1CwgC8Xy+gwQfiBaN+IZOnaNQT8NLFUu0ZFi9Vq
        gf8b+1QKrYbmJynUmjABrZRIlYFKP7VYptbKE/3ktGavMCDg9aC1wviUJGve58rssKOWQiOm
        A017TgE2C5KB8PeZx+AU4LCcyTYA6zqGGfbgEYCTq5aNzBMAB8/nOWy2PCmadrAnTAA2l7QT
        9iALg/UXf8ROARaLIH1g7yrLxm8ndTisa7u0LoWTXTjsLr9P2KRcyMPwztJfmA0zyFfgUr1l
        3YJL7oUT/RWETQiS/jB/fJuNZpOhcLFiiGkv2QZvFU0xbBgn3eHJ5mLcpg/Ja2y4YJ3A7KOG
        w4HhmY2xXeCMuYlpxzy4OGci7DgdVp69QtibMwE0DBmAPfEmzOrJx21D4KQXrL3ub6dfhOd6
        ajC7sRPUL09teHGhsXQTvwyv1l7Y0HeDg38f39iFgh16jv1YeQBWG78CBYBveG4fw3P7GP53
        vgDwKuBGK9WyRFodpBTK6fT/XjlBIWsA6z/EO9IIRu899OsEGAt0AsjCBdu5Mg8O7cyViD/J
        oFWKOJVWSqs7QdDavb/GeTsSFGtfTK6JEwaGBASKRKLAkD0ioWAndzbrO4kzmSjW0Ck0raRV
        m30Yi83TYVsdTGWLd397NbJS4Xa+QzPG3WKNcaozn20+nDK5oyZV8PTIsdxD2pgrL7QXZbL/
        CWkfKU7sL2G4p2abjWUSLj7RveID1O69HzoOeI7Tjt+wbqfqdOzY9ys5XaLxgoctCUuvwWuW
        n11je/bn9rR4B98uP+Qu+1O/ag5a9jiSeG5rbYYfs2S3PiLn7RJT5GW+9ZfPovCrnBxltrfX
        0fvvcvodo7ZIL0d9wAtodR/fv7Nw/t4uVZvVwzoa+FGaa5rE7+7BsczgeEV0qOSpy+rNTI5e
        Vq/1dj1RxystHZmv/rhPj0yNIRmmiKK6Z7GTnTlQVHjAEH4sNLsiKx00d3hmxzsKGOoksdAb
        V6nF/wJYbdxeqgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnO7DlVypBovaFSzWnzrGbPHx628W
        i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZHH0/1s2i0mHrjFa
        PL06i8li7y1ti4VtS1gs9uw9yWJxedccNov5y56yW3Rf38Fmsfz4PyaLGxOeMlrseNLIaLHt
        93xmi3Wv37NYnLglbXH+73FWBymPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2zgc1jcd9k
        Vo/e5ndsHh+f3mLxeL/vKptH35ZVjB6bT1d7fN4k57HpyVumAL4oLpuU1JzMstQifbsErowv
        fbUF7bYVlyfvYGpg3GLcxcjJISFgIvFt5lPWLkYuDiGB3YwSK16sZIVISEos+3uEGcIWllj5
        7zk7RFEzk8T9BZOAEhwcbALaEqf/c4DERQS6mCU6d75jAXGYBS4zS0xbeIQRpFtYIFpiRlsH
        mM0ioCrxY+NlsA28AlYSDy8uYQMZJCGgL9F/XxAkzClgLfF5yXV2EFsIqOT0hfnsEOWCEidn
        PmEBsZkF5CWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmb
        GMExrqW5g3H7qg96hxiZOBgPMUpwMCuJ8OaqcaUK8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/
        0ZsiJJCeWJKanZpakFoEk2Xi4JRqYOLjU7zw7/eeOwa75SvSzibN35V+SeFcZd6rvW4hHYEJ
        01uM669PmSqzMky8qUklSk8w2qq0vif3VP+LrzWRsR57Xr3dsS124kKXhUozJ8TGh9+YuenR
        ycwv/F61decVJ9pMnrki801f9f9Ax6lHZ/cfk/584ggHS/upaSFmSnvjN/yrnfnw2J0wcZ4c
        7TeXJ/0/2pAV27FD9qbcXf/s7l2/vO30r/DP5A8PfJAdVu1Q+ary5++nzMduTFt83ayB18Nn
        yU5BWY/+Mw/X2JqYlbHsOZc79YlFTonwpvDFFSvzbpzTtY4/W2G8f164/UsRrdTQxftv/fQV
        6ZY8e8d5QvqcmKxfJ/pLFtWdu5N9+4kSS3FGoqEWc1FxIgBsDchvYAMAAA==
X-CMS-MailID: 20230920081425epcas5p407a3b1ee776082798adb92e8025699f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081425epcas5p407a3b1ee776082798adb92e8025699f1
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081425epcas5p407a3b1ee776082798adb92e8025699f1@epcas5p4.samsung.com>
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
	- copy_max_bytes (RW)
	- copy_max_hw_bytes (RO)

Above limits help to split the copy payload in block layer.
copy_max_bytes: maximum total length of copy in single payload.
copy_max_hw_bytes: Reflects the device supported maximum limit.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
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

