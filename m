Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EF70BB62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjEVLQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEVLPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:15:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0C210D
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:10:31 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230522111030epoutp04c906a9b30bf61d420064912d8ca528e0~hcq6smIVz1580715807epoutp049
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:10:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230522111030epoutp04c906a9b30bf61d420064912d8ca528e0~hcq6smIVz1580715807epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684753830;
        bh=YMZdsOD0UUYdd7xweh0AWYwQGUaFZAK6DIfIElX1bCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fabtxh5pf53TAZOH/KBAQ07mk6suHjZQg2cteLW4ZQMsSVDuDNal6Fa7pR/OR071l
         PBEAaFyxjfhBHbNQUJiWRdCs2IL1fy2fDnDjytAIFKMaU2bNl2Ml5EldzK7r8wCBsa
         0YwnUv84E4Eu274DPq3arPGdP3AqbtnfPoFFuYdU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230522111029epcas5p33d877412226c985b251270a67d74dbf4~hcq5-Q3D81390713907epcas5p3R;
        Mon, 22 May 2023 11:10:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QPvr33SXNz4x9Px; Mon, 22 May
        2023 11:10:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.8E.44881.3AD4B646; Mon, 22 May 2023 20:10:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e~hcVChV0gH0993609936epcas5p3d;
        Mon, 22 May 2023 10:45:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230522104526epsmtrp128279e1827de9e8fccaab5742f360c3e~hcVCgIBF91351813518epsmtrp1Z;
        Mon, 22 May 2023 10:45:26 +0000 (GMT)
X-AuditID: b6c32a4a-ea9fa7000001af51-7c-646b4da372f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.13.27706.6C74B646; Mon, 22 May 2023 19:45:26 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104522epsmtip23379b85128ad1a00eb9a2dd413e225e6~hcU_tZeg_1590015900epsmtip2l;
        Mon, 22 May 2023 10:45:22 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v11 1/9] block: Introduce queue limits for copy-offload
 support
Date:   Mon, 22 May 2023 16:11:32 +0530
Message-Id: <20230522104146.2856-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230522104146.2856-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxid+17y8sDGeSyOF0RLQzdgIIStF0bEEXXeVFoRf3Rqp8YMvAIF
        kkwSyvIHFGgBgdDQMhB2Qco2UBAxAlEnFFkqwwCySAWsLKVsIp0RBYESHrb+O+fcbznfd+cj
        cfMGnjUZJlUxCqkkQkCYcprb7R2cyj4LD3YZWLJE9T33cVRQX0ugK1mbOKoZVxNooX0VoJyV
        Vzh6ctcX6ZfzuejRvdsYarumwVBVTQeGGtQkai19jqGO7SUCaQzDAM0MaTGkH3NEbfpuDhps
        KSDQRO02FxVXzPDQ1REdgX7p3MKQITsRQ7rpywA1bxTjqG7hGQd1jR1CfZudXLTxsoA4foQe
        fHiG1k72EvRt7TiP7pto4NA5mh6CvlHpQA/2RtGN1akE3biq4dFduRsc+kZ5PN36KIGgMxKX
        Cfr5zBiHfnZniKAzm6pBgMWF8KOhjCSYUdgy0iBZcJg0xEdw5rzYT+zh6SJyEnmhTwS2Ukkk
        4yM46R/gdDosYmdTAtvvJBFRO1KARKkUCI8dVciiVIxtqEyp8hEw8uAIubvcWSmJVEZJQ5yl
        jMpb5OLi6rETeCk8dOHeCE++dTbm4WOHBFDhlwZIElLuMCf32zRgSppTrQA2pXRjLFkFcGp0
        lMuSFwCq9amcNGCym3ErvW4vSg9gSn86hyXJGNSrX/GMdQnKEf6+TRp1S2oah0sti7iR4FQn
        DrMqunFjKQvqHNTrruwmcKgPYP5UjFHmU16w9Nc7BOtPCNWTZkbZhPKGc/1anA0xg91507uG
        cOpdmHgzH2fNDZvAxEQ7Fp+Eg5m9GIst4HxnE4/F1vBv9fd7OBpW/VRJGK1BKglA7YgWsA++
        MLlHjRs94JQ9rG8RsvJh+HNPHcb23Q8zNqb36vOhrugNtoO19SUEi63g8NrlPUzDobwJgt1V
        BoDJunJuFrDVvjWP9q15tP+3LgF4NbBi5MrIEEbpIXeVMtH//XGQLLIR7N6Ow6c68OeTFWcD
        wEhgAJDEBZb8c5lBweb8YElsHKOQiRVREYzSADx21v0jbn0gSLZzfFKVWOTu5eLu6enp7uXm
        KRIc5H/k0x1kToVIVEw4w8gZxZs8jDSxTsDSBVMugb5Lx4WFk1fDZVHN45kG2cCRVPIpeX+9
        zvoW1tL6ZeG+pDhLi8NJbZPSs8d0jvwtsd1i69V/tDZr/g1mc6X9GnvPKkXXVIdrVVZRC3h8
        YBSA6z4zbvtWPrb58KLYT1TkRMabvk/kp3fFC2p+qO0pnVt7HXDti+xZN/07UO10sVqEZ6wM
        dGoefFNn1S/UnM8pC8xc9uPb/YG993neb4F29tjYflVFvZvTS1fHv8LKqr/O7fOa92+fVXLd
        bQ8trT/drJ79KiU2Wrm2fuFF2okESauV76WD4d4Gmxif1yY3TxUW5y+WC+NduYPZVEklefrE
        A8389QGNR2yuMOtunICjDJWIHHCFUvIvR3k1zMQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRiAfeecPXtamjm7uXzFaKxbNm3C5NO4zbTDMQwRMyyGnTpaujpb
        CFEqUWxNzaS2m9us2pA2rZKSZauVe5e1UaHCWFTMuEwqVsz4987zPO/766Vw0RvChdoVFsly
        YYoQMSkgDHfErh51K4ID5xQnilHJvToc5ZZcItHRtEEcFbenksh25zNAmX0/cPTy1lJU/SmH
        h6y1lRi6eS4dQ0XFJgyVplKo6mw/hkzDH0mUbmwFqKdFg6HqNnd0s9pMoKYbuSTquDTMQwXa
        Hj5KsVSQ6GL9EIaMGfEYquiOA8gwUICjK7ZeAjW0TUSPBut5aOB7LrlsMtPUvIrRdD4gmUpN
        O5951FFKMJnp90imrFDCND2IYvS6EySj/5zOZxqyBgim7MIRpsoaSzKn4j+RTH9PG8H01rSQ
        jPqaDvg5yQWLAtmQXXtZznPJDoHSVmvhRwyt3d/8QhILtL7JwIGC9Hx4/eQVLBkIKBFdBWBJ
        tw4fEc5QO3j37+wEi4be8keieAw+/WYlkgFFkbQ7bBym7Hws3YfDkmvngH0Bp5/j0GDZZJ+d
        6LXQUGDB7D1BT4c5Xfvt2JFeCM9erSHtGNKeMLVTaMcOtA9890SD27Hod5KmnTtSC6E5u5sY
        Oe4K48tz8DRAa/5Tmv/UGYDpgDMboQoNClV5RXiFsfukKkWoKiosSBoQHqoHf15BMqsCXNf1
        SY0Ao4ARQAoXj3Vcpw4IFDkGKqIPsFz4di4qhFUZwUSKEE9wfJxs3i6igxSRbDDLRrDcP4tR
        Di6xWJTlw2pMXqpfv2CCm9VzgeRx7YnE6OU53ovceFlTE7/pFcEx78vjuLjChPHTH371y5Pd
        NnFuGTPEo4MOudm672u+F3Ycyl6tyux9siH/4eFns1LUZt+thP99njcqN71NqhQo766xULIN
        wstXuZ/Kk0+9XGX7ZG2eVkN2zEoPtbyyKWDSce+Y/GNTWGvN7Iv4Gb8dSxNkcb7Kca2j/I0H
        X45u9mmZNjfyfOvRPUJpO93QWAp2m8efnrlNKZWrZ7xeF17hvPmFv6lx6yt5f0pC2Rb3kFsu
        hlM/si580H45nVTk8Rzs/DlmY9eQbHGXQZjgX5frXb452ufGvPdddbb6PJekTjGhUiq8JDin
        UvwCzGQc1nkDAAA=
X-CMS-MailID: 20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/ABI/stable/sysfs-block | 33 ++++++++++++++
 block/blk-settings.c                 | 24 +++++++++++
 block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 12 ++++++
 include/uapi/linux/fs.h              |  3 ++
 5 files changed, 136 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c57e5b7cb532..e4d31132f77c 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,39 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_offload
+Date:		April 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file shows whether offloading copy to a
+		device is enabled (1) or disabled (0). Writing '0' to this
+		file will disable offloading copies for this device.
+		Writing any '1' value will enable this feature. If the device
+		does not support offloading, then writing 1, will result in
+		error.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		April 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the maximum number of bytes, that the block layer
+		will allow for copy request. This will be smaller or equal to
+		the maximum size allowed by the hardware, indicated by
+		'copy_max_bytes_hw'. Attempt to set value higher than
+		'copy_max_bytes_hw' will truncate this to 'copy_max_bytes_hw'.
+
+
+What:		/sys/block/<disk>/queue/copy_max_bytes_hw
+Date:		April 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the maximum number of bytes, that the hardware
+		will allow in a single data copy request.
+		A value of 0 means that the device does not support
+		copy offload.
+
+
 What:		/sys/block/<disk>/queue/crypto/
 Date:		February 2022
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..23aff2d4dcba 100644
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
index a64208583853..826ab29beba3 100644
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
@@ -590,6 +647,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -637,6 +698,9 @@ static struct attribute *queue_attrs[] = {
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
index b441e633f4dd..c9bf11adccb3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -295,6 +295,9 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned long		max_copy_sectors_hw;
+	unsigned long		max_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -561,6 +564,7 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+#define QUEUE_FLAG_COPY		32	/* supports copy offload */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
 				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
@@ -581,6 +585,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
@@ -899,6 +904,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
+		unsigned int max_copy_sectors);
 void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1218,6 +1225,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
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
index b7b56871029c..8879567791fa 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,9 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* maximum total copy length */
+#define COPY_MAX_BYTES	(1 << 27)
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

