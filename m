Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101967A76BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjITJAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 05:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjITI7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:44 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F4E42
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:52 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230920085851epoutp027afd8c937f8713e3834edfe75d794044~Gj7hEnOaE2629326293epoutp020
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230920085851epoutp027afd8c937f8713e3834edfe75d794044~Gj7hEnOaE2629326293epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200331;
        bh=OJzVFQCb3WofjpZljeXnGBqYi+B32Cvdl/hefyKURJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMyqAuA4UwDr+NaeiDWo7LxoZBIJK5AQIax509D3ocyxnzlfQkLGTFBteBUwP3BHJ
         JLpU68lG08awmjL87B9e4iKEQycySEZHVrUoKSTuacPDp1m0Fk5g8c2q9uvTcx6xqs
         rhJ6l1A0LHCf8m/Qqm/wwD1v3Dri2WOQrbrZod6E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230920085850epcas5p35a345b63acc2fae58848a393cf4bd6df~Gj7gJ5igH1154211542epcas5p30;
        Wed, 20 Sep 2023 08:58:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RrCBK0m6Fz4x9Q0; Wed, 20 Sep
        2023 08:58:49 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.A4.09949.844BA056; Wed, 20 Sep 2023 17:58:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230920081617epcas5p4a0e3d23ed747115202c1d8765f6c5a6f~GjWWziplY2583825838epcas5p4J;
        Wed, 20 Sep 2023 08:16:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081617epsmtrp120a0727694d9fc9bee7bd26f727ede2f~GjWWycog52250122501epsmtrp1Y;
        Wed, 20 Sep 2023 08:16:17 +0000 (GMT)
X-AuditID: b6c32a49-bd9f8700000026dd-d3-650ab4487973
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.1F.08742.15AAA056; Wed, 20 Sep 2023 17:16:17 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081613epsmtip13d39ccd65439ff7d195fb43480506a81~GjWTRj7Vl3236232362epsmtip1T;
        Wed, 20 Sep 2023 08:16:13 +0000 (GMT)
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 12/12] null_blk: add support for copy offload
Date:   Wed, 20 Sep 2023 13:37:49 +0530
Message-Id: <20230920080756.11919-13-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRie75yzZxcm8gg0fUAiLFMpxGUF1o9bajl6FEqK0hlthnbYEzDA
        7s4uSJIjtzCCWAhippabweoKKCi3uK3tsBICOUQIBHJZEVACQUETQbRdD5T/nud5L8/7vt98
        PNyylGvLi5TEMnKJKJpPmhMN+u3bXOk6c8ZjZdEHVXf9hqMHj1YJlJKzhqPK0WwSzeoXAZrU
        fQPQ6vUeHGnnCzhoSNeEodbSXAyVV7ZjKLdtAKCpfhWGtMMu6OfTagK1ajsJ1NdcSKKSc1Nc
        lDnYSCJNxzMM/ZUzBVDjZDJADaslOKqaXSDQtWE7dDszHaCetQ7Obju6STXKpXvGLhN03/U4
        uqbiW5KuVSfSLUNJJF2mzOPQWanzJN2UNs6hH0wNE/TClX6SVtZVALq2+yt6qcaerpm8hwVv
        OhrlH8GIxIzcgZGEScWRkvAAfmBI6Puh3kIPgavAB+3kO0hEMUwAf29QsOu+yGjjXfgOx0XR
        cUYpWKRQ8N3f9ZdL42IZhwipIjaAz8jE0TIvmZtCFKOIk4S7SZhYX4GHxw5vY+LnURH5310j
        ZL37vpy+1MtJAlW+GcCMBykveLlkCDdhS6oFwPMTARnA3IgXASxNK+Gw5B8AlUuTxEZFo2oM
        YwNaAFVZjwmWpGFQr281Eh6PpFxg93OeSbemknB4qaUMmAhOLeOwrKODNLWyovbAi7pbmAkT
        1JtwZuzGC92C8oPLd1KBqRGk3GH2+GaTbGaUl9SDXDZlM+z8iZ0Ip7bC1PoC3NQfUnozmH9V
        g7Gj7oV/rt0nWWwF/+6o47LYFs5kn17H8bD8h/MkW/y1cZ1BFWADu2BaVzZuGgKntsPqZndW
        3gLzu6ow1vhVmLU6ue5lARuLN7ATvFB9Zt3XBg48Tl7HNNQUFwP2WkoAH+lq8RzgoHppIdVL
        C6n+tz4D8Apgw8gUMeGMwlsmkDDx/z1zmDSmBrz4LM4HGsGo4b5bG8B4oA1AHs63toh5y5yx
        tBCLTiQwcmmoPC6aUbQBb+PBv8dtXwuTGn+bJDZU4OXj4SUUCr18PIUC/usWs2lFYksqXBTL
        RDGMjJFv1GE8M9skzDPVYPe0O7t+VPqhzaGmvKKdJ32XHRVfbEtr073ykQS2GPymL3x2ldsy
        kccj54PrMroCyoPmlC6HDZ8eHTrneEypO1JkaNZGCgJ/cazDJs6OOWm1P17hjbwT5KLc9FBY
        OF/olq1Qa/LePpl+J/62YSWk7yy23Jo8EB6fVP8kjn+3wTox0KporX3wVMMM/+BWTjoR36k5
        xbHkpjuvHHs4N6057OZ/8dbHfj79ubqbz9XmETx1xW6OaD/Xfi3lD3vVG7OR7Q1Pj//uQjcd
        WAgZ3HJXWXAj4cSvoZ/s8tw/MpIQOZSS+Sxw3LbtXsPcIfHURFF9b2J7n34Hs+cIevLezQ8O
        VjrxCUWESOCMyxWifwG0lAtetQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCSnG7gKq5Ug8e75CzWnzrGbPHx628W
        i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmi0mHrjFa
        PL06i8li7y1ti4VtS1gs9uw9yWJxedccNov5y56yW3Rf38Fmsfz4PyaLGxOeMlrseNLIaLHt
        93xmi3Wv37NYnLglbfG4u4PR4vzf46wO0h47Z91l9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YD
        m8fivsmsHr3N79g8drbeZ/X4+PQWi8f7fVfZPPq2rGL02Hy62uPzJjmPTU/eMgXwR3HZpKTm
        ZJalFunbJXBlTO05wVJw0a3i2YaLrA2M66y6GDk5JARMJHbMuscEYgsJ7GaUWLOFCyIuKbHs
        7xFmCFtYYuW/5+xdjFxANc1MEl/nH2fsYuTgYBPQljj9nwMkLiLQxSzRufMdC4jDLNDBInFh
        2152kG5hAUeJtQcegm1gEVCVeHnvChuIzStgLfHjeTPYIAkBfYn++4IgYU6g8Ocl19khDrKS
        OH1hPjtEuaDEyZlPWEBsZgF5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5x
        Ym5xaV66XnJ+7iZGcNxrae5g3L7qg94hRiYOxkOMEhzMSiK8uWpcqUK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYqjzu799m2fxsmT+Xd6D8X6H/nMFz
        rn8qS1f0UFLgqru96Kpd8jNO34l1/MazsubJP8v+tqBxx8zDi1X3VeZJbeIP6vPdJDf98aY9
        d+x+zZ0pohttnXDlz3QP6Sm95b9UpkXv1T6VYlEjdMSpv137r5z0Ag3hFVwlIiG9/ja7szLW
        /fpqaOPcMnnro57YZ6xS/2b6V0+7nZXd9apda0Hm9JfvHyWerTv/yPr7pJYK+yVhDWIZHXZ2
        P1LPGgYfMSv6zCq9vXvpu+uyBdvvWmTdETg2odjCZJ6HakNo0uwi/pifRpGsns4529Nlf/20
        uxgjnqZT8SVl6V5W6eNRzqwsbFsckr+2x24QtPeO5FRiKc5INNRiLipOBABtKl5UagMAAA==
X-CMS-MailID: 20230920081617epcas5p4a0e3d23ed747115202c1d8765f6c5a6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081617epcas5p4a0e3d23ed747115202c1d8765f6c5a6f
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081617epcas5p4a0e3d23ed747115202c1d8765f6c5a6f@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implementation is based on existing read and write infrastructure.
copy_max_bytes: A new configfs and module parameter is introduced, which
can be used to set hardware/driver supported maximum copy limit.
Only request based queue mode will support for copy offload.
Added tracefs support to copy IO tracing.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst  |  5 ++
 drivers/block/null_blk/main.c     | 97 ++++++++++++++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/trace.h    | 23 ++++++++
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_blk.rst
index 4dd78f24d10a..6153e02fcf13 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -149,3 +149,8 @@ zone_size=[MB]: Default: 256
 zone_nr_conv=[nr_conv]: Default: 0
   The number of conventional zones to create when block device is zoned.  If
   zone_nr_conv >= nr_zones, it will be reduced to nr_zones - 1.
+
+copy_max_bytes=[size in bytes]: Default: COPY_MAX_BYTES
+  A module and configfs parameter which can be used to set hardware/driver
+  supported maximum copy offload limit.
+  COPY_MAX_BYTES(=128MB at present) is defined in fs.h
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c56bef0edc5e..22361f4d5f71 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -160,6 +160,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned long g_copy_max_bytes = BLK_COPY_MAX_BYTES;
+module_param_named(copy_max_bytes, g_copy_max_bytes, ulong, 0444);
+MODULE_PARM_DESC(copy_max_bytes, "Maximum size of a copy command (in bytes)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -412,6 +416,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(copy_max_bytes, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -553,6 +558,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_copy_max_bytes,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -659,7 +665,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
+			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
+			"copy_max_bytes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -725,6 +732,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->copy_max_bytes = g_copy_max_bytes;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1274,6 +1282,81 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
+static inline int nullb_setup_copy(struct nullb *nullb, struct request *req,
+				   bool is_fua)
+{
+	sector_t sector_in = 0, sector_out = 0;
+	loff_t offset_in, offset_out;
+	void *in, *out;
+	ssize_t chunk, rem = 0;
+	struct bio *bio;
+	struct nullb_page *t_page_in, *t_page_out;
+	u16 seg = 1;
+	int status = -EIO;
+
+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
+		return status;
+
+	/*
+	 * First bio contains information about source and last bio contains
+	 * information about destination.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			sector_out = bio->bi_iter.bi_sector;
+			if (rem != bio->bi_iter.bi_size)
+				return status;
+		} else {
+			sector_in = bio->bi_iter.bi_sector;
+			rem = bio->bi_iter.bi_size;
+		}
+		seg++;
+	}
+
+	trace_nullb_copy_op(req, sector_out << SECTOR_SHIFT,
+			    sector_in << SECTOR_SHIFT, rem);
+
+	spin_lock_irq(&nullb->lock);
+	while (rem > 0) {
+		chunk = min_t(size_t, nullb->dev->blocksize, rem);
+		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
+		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
+
+		if (null_cache_active(nullb) && !is_fua)
+			null_make_cache_space(nullb, PAGE_SIZE);
+
+		t_page_in = null_lookup_page(nullb, sector_in, false,
+					     !null_cache_active(nullb));
+		if (!t_page_in)
+			goto err;
+		t_page_out = null_insert_page(nullb, sector_out,
+					      !null_cache_active(nullb) ||
+					      is_fua);
+		if (!t_page_out)
+			goto err;
+
+		in = kmap_local_page(t_page_in->page);
+		out = kmap_local_page(t_page_out->page);
+
+		memcpy(out + offset_out, in + offset_in, chunk);
+		kunmap_local(out);
+		kunmap_local(in);
+		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
+
+		if (is_fua)
+			null_free_sector(nullb, sector_out, true);
+
+		rem -= chunk;
+		sector_in += chunk >> SECTOR_SHIFT;
+		sector_out += chunk >> SECTOR_SHIFT;
+	}
+
+	status = 0;
+err:
+	spin_unlock_irq(&nullb->lock);
+	return status;
+}
+
 static int null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = cmd->rq;
@@ -1283,13 +1366,16 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
+	bool fua = rq->cmd_flags & REQ_FUA;
+
+	if (op_is_copy(req_op(rq)))
+		return nullb_setup_copy(nullb, rq, fua);
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
-				     rq->cmd_flags & REQ_FUA);
+				    op_is_write(req_op(rq)), sector, fua);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
@@ -2053,6 +2139,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->queue_mode == NULL_Q_BIO)
+		dev->copy_max_bytes = 0;
+
 	return 0;
 }
 
@@ -2172,6 +2261,8 @@ static int null_add_dev(struct nullb_device *dev)
 		dev->max_sectors = queue_max_hw_sectors(nullb->q);
 	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_copy_hw_sectors(nullb->q,
+				      dev->copy_max_bytes >> SECTOR_SHIFT);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..e82e53a2e2df 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -107,6 +107,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned long copy_max_bytes; /* Max copy offload length in bytes */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 91446c34eac2..2f2c1d1c2b48 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -70,6 +70,29 @@ TRACE_EVENT(nullb_report_zones,
 );
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+TRACE_EVENT(nullb_copy_op,
+		TP_PROTO(struct request *req,
+			 sector_t dst, sector_t src, size_t len),
+		TP_ARGS(req, dst, src, len),
+		TP_STRUCT__entry(
+				 __array(char, disk, DISK_NAME_LEN)
+				 __field(enum req_op, op)
+				 __field(sector_t, dst)
+				 __field(sector_t, src)
+				 __field(size_t, len)
+		),
+		TP_fast_assign(
+			       __entry->op = req_op(req);
+			       __assign_disk_name(__entry->disk, req->q->disk);
+			       __entry->dst = dst;
+			       __entry->src = src;
+			       __entry->len = len;
+		),
+		TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
+			  __print_disk_name(__entry->disk),
+			  blk_op_str(__entry->op),
+			  __entry->dst, __entry->src, __entry->len)
+);
 #endif /* _TRACE_NULLB_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.35.1.500.gb896f729e2

