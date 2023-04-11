Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750B6DD506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDKITN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDKITC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:19:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FFE58
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:18:59 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230411081858epoutp036e50d9265a91472ac09a88e9046a8cc2~U04chZ2Mg1057410574epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 08:18:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230411081858epoutp036e50d9265a91472ac09a88e9046a8cc2~U04chZ2Mg1057410574epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681201138;
        bh=azNz458ro0wDubj3yA6JaBDeCE9nCzpzPvVQaV4RgaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qecUkqtlNj5NHCQ4B/eCYhY6DQ/bDrHCQE8e0jvBtB8UTeDb5MyEyfAEpIIFcotf8
         K8IpB5aTe0vMr1h0MZwpI6osWlaA1wSI7bllc3Ln9iYo4UkiC9y34KNJxl1KljNpEi
         qu5olvbK89WEggX74YqMZQRdU2UUCw04W66HgeAI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230411081856epcas5p1d40b52ec6c71413049c66a8f4569a722~U04axPziP1310613106epcas5p1Q;
        Tue, 11 Apr 2023 08:18:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pwdz24X9Hz4x9Q2; Tue, 11 Apr
        2023 08:18:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.AC.09987.EE715346; Tue, 11 Apr 2023 17:18:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230411081241epcas5p15b9c54d8f86db6dda2901d15f4c834db~U0y_GV3zo1543815438epcas5p1_;
        Tue, 11 Apr 2023 08:12:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230411081241epsmtrp2985da42dbd36d667b60fc0c204c599e6~U0y_FXbsb2545725457epsmtrp2X;
        Tue, 11 Apr 2023 08:12:41 +0000 (GMT)
X-AuditID: b6c32a4b-7fbff70000002703-b6-643517eee8ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.0F.08279.97615346; Tue, 11 Apr 2023 17:12:41 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230411081237epsmtip242be83d7d3286979f87d447cbe28d778~U0y6Rm8JJ2386223862epsmtip2J;
        Tue, 11 Apr 2023 08:12:37 +0000 (GMT)
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
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 1/9] block: Introduce queue limits for copy-offload
 support
Date:   Tue, 11 Apr 2023 13:40:28 +0530
Message-Id: <20230411081041.5328-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230411081041.5328-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjHd3fttRhLTnDhBbbJLjqDjh8dbXmZVMkw7jaMspHFREOway+A
        lGvttcJGHAWCCBuCTFGKUuemGwVBCxIEC1uZMDAUJrIIWYEsrTMqoDCNUn6spbD53/d53s83
        z483Dx/zK+EF8dMZLa1hZEoSX8Np6QoNDZsKECsinx97Gzb2dWMwv3wBg3X2Mhw+6ppBYOWT
        lxic6NwBLVPVXDjy8w0U3rxYgcLaulsobP/uKQpvLU3isML6BwKdwwYUWka3wpuWXg4cajuH
        Q+NlJw9avy1AYasjD4EtLiMGGx5Nc+Bvo8FwYKGHGweoobsJlGG8H6duGOw8amDsGoca6tdR
        ZlMxTjX9kEu1j+hxqrRgCqemO4Zx6kSzCaGabudQs+a3KLNjEk303Z8Rm0bLFLQmhGbkKkU6
        kyolE5JS4lPEkkhhmDAGRpMhjCyTlpI7dyeG7UpXujdAhhyRKXXuVKKMZcmI7bEalU5Lh6Sp
        WK2UpNUKpVqkDmdlmayOSQ1naO37wsjI98Ru8GBG2sjcdvWVxOy5xgZcj9jiSxAfPiBEoKK9
        hVuCrOH7Ee0IOP2wH/MGMwi4PVjG8VB+xHMETD7eu+p4XPgjzwtZ3I7h+7g3KEDBP81mzEPh
        xGbw69+FiOdhPXEMA0+dxRxPgBF3UDDfPO2m+Hx/IhG0joV7DBxiE1hwzCEeLSAgaHUucj0I
        ICJA2fg6T9qHiAHz54/jXmQd6K1yLHeHERtAwfXq5bYBYfQBlSYD6m11J1i09XC92h887Gnm
        eXUQmJ2y4F6dCl4MOVd4NSjo7kC8egco7CtbbhMjQkFjW4Q3/SY43deAeuv6glKXY8UqAK01
        q5oERbXnVjQAFpt+RVOgq+b6yq6/QcBMmxMpR0IMr8xjeGUew/+lLyCYCQmk1WxmKs2K1VEM
        nfXfJ8tVmWZk+Si2JLQif008CbciKB+xIoCPkesFz5aiFH4CheyLL2mNKkWjU9KsFRG7930S
        C3pdrnJfFaNNEYpiIkUSiUQUEyURkgGCzdJeuR+RKtPSGTStpjWrPpTvE6RHM/vXVmSzX48N
        WkHTKQ3/YkaxXF9RmrvVaecKAs/MJu/7oLDwqKl3sOi+s9EVGu/7WsCEv9x+dYMpaZN4REQG
        Vm1cVL5TKRDqDuyunwfA3HH0UEBsln9ncd694vkw4Uf5cRfs9cK4wfQXJ+qzlQ+SyjWYdDTZ
        X+RyfWI1mXz50ZcObZxY5A1cJd498+lZXytx2Mjtu/TTZ7kME7ynvur8x3u6q/FgG7O2JsHn
        Zd4vB48Yc2r3aodOTRRdadrfEOA4rr/nsidTl7cdHhmNDn5wwEh8+P1Y5ecd27KcX01159vu
        JFxbOCnd9waH7TgbUafpNP25YMsez3kmv5s/uCT5XUdy2DSZcAumYWX/AuUB5D6dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSvG6lmGmKwa0LRhbrTx1jtmia8JfZ
        YvXdfjaL14c/MVpM+/CT2eLBfnuLve9ms1rcPLCTyWLPoklMFitXH2Wy2L3wI5PF0f9v2Swm
        HbrGaPH06iwmi723tC327D3JYnF51xw2i/nLnrJbHJrczGSx40kjo8W23/OZLda9fs9iceKW
        tMX5v8dZHSQ8Ll/x9ph1/yybx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js3j
        /b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KK4bFJSczLLUov07RK4Mm7+sitYG1Dxa/06tgbG
        c85djJwcEgImEm9al7N3MXJxCAnsZpToe9LCBJGQkDj1chkjhC0ssfLfc6iiRiaJTd/vgxWx
        CahLHHneygiSEBGYwCxx6X4DG4jDLPCASeL88y+sIFXCAn4Sk9ecAxvFIqAq8ffJLzCbV8BC
        YsfTf0A1HEAr9CX67wuChDkFLCX+zO1gAwkLAZUs2cMCUS0ocXLmEzCbWUBeonnrbOYJjAKz
        kKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHMtamjsYt6/6oHeIkYmD
        8RCjBAezkgjv1//GKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwaf54E1Cx4Pa2ZwtvxQhYLJ72UixSNvjNvTJ3OYXi74rrfe8l6c3tuhoR+uRo9tYj
        PwL+HK1b3MRd4mei1SMmv2sSj2GXwfpVf4t0Nu7s9v6R8/NRreiyxvuTvkT3qi+rssna4+S4
        W4SLxYyjdJf7N2Zv9481SzcHmr95IPfsSW4l19H9jb1Lo5fXqrfGflcUnP14Z8whp7aAXU2x
        BbzXW/rrvCqeB3ZoF59PvHRS29v0+lLpnauXnJ97eNNjUenzMV47r37u9+P1rD3Ecq3a44bE
        hIDjXnJ751Ruc95b9qo2MIJf2ifbx7363jOV0M6lqx/KVOtEn5Nc0WL0S+lveEP8xqmfDy5i
        lbgTLfleiaU4I9FQi7moOBEAk5Qmm1QDAAA=
X-CMS-MailID: 20230411081241epcas5p15b9c54d8f86db6dda2901d15f4c834db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081241epcas5p15b9c54d8f86db6dda2901d15f4c834db
References: <20230411081041.5328-1-anuj20.g@samsung.com>
        <CGME20230411081241epcas5p15b9c54d8f86db6dda2901d15f4c834db@epcas5p1.samsung.com>
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

