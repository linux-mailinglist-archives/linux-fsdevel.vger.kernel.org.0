Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FFC70BB82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjEVLRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjEVLPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:15:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567410E6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:11:00 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230522111058epoutp0279f2785d401ff3cc6a65d32cc1a1456c~hcrVI9q3s1081810818epoutp027
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:10:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230522111058epoutp0279f2785d401ff3cc6a65d32cc1a1456c~hcrVI9q3s1081810818epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684753858;
        bh=83AxBeKcHPZBcp1RaGv5HmeWYA8Mwjvvo3x8XiJloJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xmfl7l4VsLbl8cXQcRRaFCzkBsCRsmx5rO5jLXWg0o0+Ap/oXJw+QUX8lzaYHZpu5
         egOHAHyviE2oTg7tqqc3gUON0XNxwVKo/b5aQJQ0db3sDg+wgaD5HZBN6b15mKARb4
         PwBprG3GBVIyAiekwunNklZKNc5YFp6W09wQztFQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230522111057epcas5p2bd0372a943b87bc5dfe45e25fcae9cf7~hcrUkUFmj2988629886epcas5p22;
        Mon, 22 May 2023 11:10:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QPvrc4Nzjz4x9Pr; Mon, 22 May
        2023 11:10:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.03.54880.0CD4B646; Mon, 22 May 2023 20:10:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104708epcas5p20f182069898f9c6852826600ce6116c1~hcWheoaM90821608216epcas5p2E;
        Mon, 22 May 2023 10:47:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230522104708epsmtrp17ff4a7d88fedc98b3fa557152b70893a~hcWhdhI5V1451014510epsmtrp1X;
        Mon, 22 May 2023 10:47:08 +0000 (GMT)
X-AuditID: b6c32a49-8c5ff7000001d660-fd-646b4dc011fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.FF.28392.C284B646; Mon, 22 May 2023 19:47:08 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104703epsmtip25ab915d72944e30a8e5989b7e059b922~hcWc5i_3U1827918279epsmtip2T;
        Mon, 22 May 2023 10:47:03 +0000 (GMT)
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v11 9/9] null_blk: add support for copy offload
Date:   Mon, 22 May 2023 16:11:40 +0530
Message-Id: <20230522104146.2856-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230522104146.2856-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxjtfS+8BGdoH4tyAas0QqkwQMLWC4i0gM4r1JHWsds4xQx5Awwh
        SZNQbdUWRIrEocEUgT5oQGupLAMVxUIAhahswoAFBSMYLAEFKls7dAGlCYHWf+c795xvu/Nx
        cLtmtjMnSaygZWKBiEtsYF25vt3Du2VPspA32u2CarracFRcU0Wg47lPcVQ5oiLQ9PUFgPLn
        /sbRUk8vjkavhaPmmSIrdK+lAUNN59QYKq+8iaGLKg5qPDuPoZsrTwik1t0FaPwOg6FmvRdq
        au5koX5tMYEeVK1YoZKycTY6NVhPoB/bn2FI900GhuqN6QBdWSrBUfX0LAt16F3Q2KmTAPU+
        bbdCS38VE2+4Uv0DMRRj6CGoBmaETfU+uMii8tVdBHXpgifV35NK1VZkE1TtgppNdRQusahL
        57+kGu+lEVROxozJk2mwoubH9Sxq9uodItbho+QdibRASMtcaXG8RJgkTgjjxuyLi4wLDOLx
        vfnB6HWuq1iQQodxo96O9d6dJDLtjOv6qUCUaqJiBXI513fnDpkkVUG7JkrkijAuLRWKpAFS
        H7kgRZ4qTvAR04oQPo/nF2gSHkxOzMsrY0m/Cz9cUNaDpYHxACWw5kAyABqVp4ESbODYkY0A
        pjP6tWABQM3EfbYl+B3A5oob7HXLzCRDWB60AP7U2r2mysRg/T8TJj+HQ5Be8NYKx8w7kEYc
        PtH+hpsDnPyeBSdv5OBmkT0ZDq9lbTFnZZHusD9/gmWmbcgQONuy1wwh6QtVBluzwtrEPr7N
        4GZsQ9rCzm+NLDPGya0wo65oNTskp6zhQM0Ibmk0CmbfLgAWbA+n2i+vDeAMJ1VfreFDsDzv
        AmExnwCQGWTWDOEws0u12iZOboc1Wl8L/TI801WNWQq/CHOWjJiFt4H1mnW8DVbVlBIW7ATv
        /pm+himoz6+2suwqB8DZglKQC1yZ5wZinhuI+b90KcArgBMtlack0PJAKV9MH/rvl+MlKbVg
        9Y4836oHI6NzPjqAcYAOQA7OdbB55+t4oZ2NUPDZ57RMEidLFdFyHQg07fs07rwxXmI6RLEi
        jh8QzAsICgoKCPYP4nMdbTzCOuPtyASBgk6maSktW/dhHGvnNOxkW1Zf+CP3SdVKfKZHYEzm
        YMHhvhdsNZrCll17nErDRP702IHurr6kT7z+eDe6KNTN1zBo1O49ph52/GCxdWxzsDLn1RDO
        0TljXVbo0JRYeNy6Ka1PV9g4vjx/hnsi82j6rP/Qx4vLm0MLS/X8FvQD47LFLS4tP1IT9gg8
        jtp0v+TNkejL7ruOnH3vC+feurlC/+iJ1/Yr/SJu5WPHGnjFuQz7IS8qwuXXsVdUH0YOYLsd
        7YYlvEG+YWOrxp6vvRpyxI2d0iB/yS0HHdy0uFOtnn/IGIcQqdlfoixf7ggfm3bM9tv3fqWP
        07Z0efaz6HO/bA2eNLj8PHp+Zrit9EBEpSOXJU8U8D1xmVzwL1D/wD/QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSvK6OR3aKwfK/shbrTx1jtpizfg2b
        RdOEv8wWq+/2s1m8PvyJ0WLah5/MFr/Pnme2eLDf3mLvu9msFjcP7GSy2LNoEpPFytVHmSw2
        9nNY7F74kcni6P+3bBaTDl1jtHh6dRaTxd5b2hZ79p5ksbi8aw6bxb01/1kt5i97ym7RfX0H
        m8Xy4/+YLA5Nbmay2PGkkdFi2+/5zBbrXr9nsThxS9ricXcHo8X5v8dZLX7/mMPmoOBx+Yq3
        x6z7Z9k8ds66y+5x/t5GFo9pk06xeWxeoeVx+Wypx6ZVnWwemz5NYvc4MeM3i8fmJfUeu282
        sHn0Nr8D6mm9z+rx8ektFo/3+66yBYhEcdmkpOZklqUW6dslcGVMmbKMpWCufcX0ZWeZGhif
        mnQxcnJICJhIvHs5i62LkYtDSGAHo8S8n2+ZIRKSEsv+HoGyhSVW/nvODlHUzCQxvW0KUIKD
        g01AW+L0fw6QuIjAB2aJ9VsWMYI4zALbWSSOt55lAykSFrCX2N8uBzKIRUBV4vK0ZywgYV4B
        K4n3B/xBTAkBfYn++4IgFZxA0RcXZ4FNFxKwlJiwzAgkzCsgKHFy5hMWEJtZQF6ieets5gmM
        ArOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iRGcKrS0djDuWfVB7xAj
        EwfjIUYJDmYlEd7AvuQUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpjKND/rrfvD650vucdsxa/oio7XCW7LWuezW4qXPny/fedduX9FXEpzrSx13+mf
        cOJsZxTmfHT0YGDixAVtS/gl9kTrPNr8VvN2QgYrp6CKXY3G0lqXVJkTPu6bo9z32dztFv94
        S6R99aQIS8Y1F1fkzblzO8hO+TzXEeey7sNHetaZWHge/1V+3LrFJsgk+tT+ad56JlkzPJ/Z
        16jUGIjnbXtdJub2zHRHr6vR1EIB06fLZFgsWfdca88y6t0S6c2U+cvWr7//r2ySDstOjeP2
        Zlkbr6vtPnNvxd3049cvBj18xbLcYXfcdfXJfEsc60qy71RXZr04b72D3/L2UeWXSa/P6v7X
        LfuzdG7ueiWW4oxEQy3mouJEACpqFsCEAwAA
X-CMS-MailID: 20230522104708epcas5p20f182069898f9c6852826600ce6116c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104708epcas5p20f182069898f9c6852826600ce6116c1
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104708epcas5p20f182069898f9c6852826600ce6116c1@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implementaion is based on existing read and write infrastructure.
copy_max_bytes: A new configfs and module parameter is introduced, which
can be used to set hardware/driver supported maximum copy limit.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 drivers/block/null_blk/main.c     | 108 ++++++++++++++++++++++++++++--
 drivers/block/null_blk/null_blk.h |   8 +++
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b3fedafe301e..34e009b3ebd5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -157,6 +157,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned long g_copy_max_bytes = COPY_MAX_BYTES;
+module_param_named(copy_max_bytes, g_copy_max_bytes, ulong, 0444);
+MODULE_PARM_DESC(copy_max_bytes, "Maximum size of a copy command (in bytes)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -409,6 +413,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(copy_max_bytes, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_copy_max_bytes,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -656,7 +662,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
+			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
+			"copy_max_bytes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -722,6 +729,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->copy_max_bytes = g_copy_max_bytes;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1271,6 +1279,78 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
+static inline void nullb_setup_copy_read(struct nullb *nullb, struct bio *bio)
+{
+	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+
+	token->subsys = "nullb";
+	token->sector_in = bio->bi_iter.bi_sector;
+	token->nullb = nullb;
+	token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+}
+
+static inline int nullb_setup_copy_write(struct nullb *nullb,
+		struct bio *bio, bool is_fua)
+{
+	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+	sector_t sector_in, sector_out;
+	void *in, *out;
+	size_t rem, temp;
+	unsigned long offset_in, offset_out;
+	struct nullb_page *t_page_in, *t_page_out;
+	int ret = -EIO;
+
+	if (unlikely(memcmp(token->subsys, "nullb", 5)))
+		return -EINVAL;
+	if (unlikely(token->nullb != nullb))
+		return -EINVAL;
+	if (WARN_ON(token->sectors != bio->bi_iter.bi_size >> SECTOR_SHIFT))
+		return -EINVAL;
+
+	sector_in = token->sector_in;
+	sector_out = bio->bi_iter.bi_sector;
+	rem = token->sectors << SECTOR_SHIFT;
+
+	spin_lock_irq(&nullb->lock);
+	while (rem > 0) {
+		temp = min_t(size_t, nullb->dev->blocksize, rem);
+		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
+		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
+
+		if (null_cache_active(nullb) && !is_fua)
+			null_make_cache_space(nullb, PAGE_SIZE);
+
+		t_page_in = null_lookup_page(nullb, sector_in, false,
+			!null_cache_active(nullb));
+		if (!t_page_in)
+			goto err;
+		t_page_out = null_insert_page(nullb, sector_out,
+			!null_cache_active(nullb) || is_fua);
+		if (!t_page_out)
+			goto err;
+
+		in = kmap_local_page(t_page_in->page);
+		out = kmap_local_page(t_page_out->page);
+
+		memcpy(out + offset_out, in + offset_in, temp);
+		kunmap_local(out);
+		kunmap_local(in);
+		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
+
+		if (is_fua)
+			null_free_sector(nullb, sector_out, true);
+
+		rem -= temp;
+		sector_in += temp >> SECTOR_SHIFT;
+		sector_out += temp >> SECTOR_SHIFT;
+	}
+
+	ret = 0;
+err:
+	spin_unlock_irq(&nullb->lock);
+	return ret;
+}
+
 static int null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = cmd->rq;
@@ -1280,13 +1360,20 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
+	bool fua = rq->cmd_flags & REQ_FUA;
+
+	if (rq->cmd_flags & REQ_COPY) {
+		if (op_is_write(req_op(rq)))
+			return nullb_setup_copy_write(nullb, rq->bio, fua);
+		nullb_setup_copy_read(nullb, rq->bio);
+		return 0;
+	}
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
-				     rq->cmd_flags & REQ_FUA);
+				     op_is_write(req_op(rq)), sector, fua);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
@@ -1307,13 +1394,20 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 	sector_t sector = bio->bi_iter.bi_sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
+	bool fua = bio->bi_opf & REQ_FUA;
+
+	if (bio->bi_opf & REQ_COPY) {
+		if (op_is_write(bio_op(bio)))
+			return nullb_setup_copy_write(nullb, bio, fua);
+		nullb_setup_copy_read(nullb, bio);
+		return 0;
+	}
 
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(bio_op(bio)), sector,
-				     bio->bi_opf & REQ_FUA);
+				     op_is_write(bio_op(bio)), sector, fua);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
@@ -2161,6 +2255,10 @@ static int null_add_dev(struct nullb_device *dev)
 		dev->max_sectors = queue_max_hw_sectors(nullb->q);
 	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_copy_sectors_hw(nullb->q,
+			       dev->copy_max_bytes >> SECTOR_SHIFT);
+	if (dev->copy_max_bytes)
+		blk_queue_flag_set(QUEUE_FLAG_COPY, nullb->disk->queue);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..3dda593b0747 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -67,6 +67,13 @@ enum {
 	NULL_Q_MQ	= 2,
 };
 
+struct nullb_copy_token {
+	char *subsys;
+	struct nullb *nullb;
+	sector_t sector_in;
+	sector_t sectors;
+};
+
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_group group;
@@ -107,6 +114,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned long copy_max_bytes; /* Max copy offload length in bytes */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.35.1.500.gb896f729e2

