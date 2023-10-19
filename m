Return-Path: <linux-fsdevel+bounces-749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5C7CF832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8211C20FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC351EB4F;
	Thu, 19 Oct 2023 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bi8CLoPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822691EB26
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:05:29 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACA19B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:05:00 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019120432epoutp0133fb4071e00f09a5d3e8616be61e8769~PgK7WeU992665326653epoutp017
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019120432epoutp0133fb4071e00f09a5d3e8616be61e8769~PgK7WeU992665326653epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717072;
	bh=OJzVFQCb3WofjpZljeXnGBqYi+B32Cvdl/hefyKURJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi8CLoPCBUmwkFvI/JVM4HyjYompNST0RPr4v+pEa4iOAJpzqflbnS3PLdfmS00jH
	 pRxadRjgOzlKgeRCJ//8cDRHLV0oPmW5Fh4d27nBbbDljV6Mec9a/8QQMCfC/DaJLJ
	 3evzsc1yY3IVK/bJE1geQygBVy7z3E0cnA7IEKPE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231019120432epcas5p358fff75117ff942f9f13e08d787f00c3~PgK6pE52f1178011780epcas5p3f;
	Thu, 19 Oct 2023 12:04:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5xC01K8z4x9Pr; Thu, 19 Oct
	2023 12:04:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.42.09672.E4B11356; Thu, 19 Oct 2023 21:04:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231019111014epcas5p461d1c994f489b9c71a6baf18922146b5~PfbhDQAmH2188221882epcas5p45;
	Thu, 19 Oct 2023 11:10:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019111014epsmtrp206f0641b0b89b0ccb652fcd40d91ffb5~PfbhA7aMl1629616296epsmtrp2T;
	Thu, 19 Oct 2023 11:10:14 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-e8-65311b4e2145
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.77.07368.69E01356; Thu, 19 Oct 2023 20:10:14 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019111011epsmtip107621e0d42a07c717dbe65573354f61f~Pfbdemp6B2869028690epsmtip1R;
	Thu, 19 Oct 2023 11:10:10 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Anuj
	Gupta <anuj20.g@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 12/12] null_blk: add support for copy offload
Date: Thu, 19 Oct 2023 16:31:40 +0530
Message-Id: <20231019110147.31672-13-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbVBUZRSe9967l4WJvHxNL8uEzKqZEOyusPhiUKDkXNMJZsqZ6M+6sNcF
	gWXbjwDLAmFDIAElKheVDwkUkoXlI1D5GBAWsYVZyQWZELNdP9qCwDJHINp1sfz3nOec5zzv
	Oe8cNu7Z4MJhp8hUjEImTuOSbkTn4JbNwe/4CRh+YV8o0o0O42jhryUCHSlbwVHTTCmJbIOL
	AFn6CwBaMo7jqLr2NIFu9ndj6HLtCQydbxrC0IkBM0DWG1oM9UwHoZrP6wh0uecqgSYuniJR
	Vb3VBRVPdpGowfAPhqbKrAB1WXIB6lyqwlGzbZ5AI9N+6JfiowCNrxhY0X50t3bGhR6/1UrQ
	E0Y1rW8sJOm2us/o+20nAX3pZg5Jny0pZ9HH8uZIulszy6IXrNMEPd97g6RL2hsB3XbtY/qh
	3p/WW37H4qkPUiOTGbGEUQQwsqQMSYpMGsXd865op0gYzhcECyLQNm6ATJzORHFj98YH70pJ
	sy+HG/CROE1tp+LFSiWX90akIkOtYgKSM5SqKC4jl6TJw+QhSnG6Ui2ThsgY1XYBn79VaC/c
	n5pc8cUIITftyrrbYmLlgObtRcCVDakwuDTVRRYBN7YndQnAtvvzLGewCGCNuQFzBo8ALG4v
	xZ9JVsqHCGeiB8ALvUOYI+FJaTDY9OPGIsBmk1QQvLbKdtR4Uxoc9v30G3AEOPUYh2cNBtIh
	8KJi4JQ5z8WBCWoTbDp+9yl2p16HhZYrpKMRpHiwdNbDQbva6ZbiWtxZ4gGvnrQQDoxT62Fe
	RyXu6A+pMVdoXjiHOV8aC2tyO1hO7AV/NbS7ODEHPpzrIZ04E57/8hzpFOcDqJ3UAmfiTagZ
	dYzMtjtsgbqLPCf9MqwYbcacxi/CY0uWNS932HXmGd4Av9NVr/X3hea/c9cwDU2mxbWVlgCo
	X60ny0CA9rmBtM8NpP3fuhrgjcCXkSvTpYxSKA+VMZn/fXNSRroePL2YwD1d4M7tP0IGAMYG
	AwCyca63+yaaz3i6S8TZhxhFhkihTmOUA0BoX/hxnOOTlGE/OZlKJAiL4IeFh4eHRYSGC7gv
	uds0pyWelFSsYlIZRs4onukwtisnB+t4oe2eRzOsM7klzM3mShNmDSmdB4J5DzQ+VdetXnHq
	3qwn/tm5K8O7XaMLloPlWW+59WGc+kPKVV39EXmm0WNkK9xdWSeKPfjDQtKrIaOFbx8c09Ua
	W0FLyUxUXfnt/IqIQlHTt7q9R7N38OAGo+7Kvo3VWduGFyYkhxNjIj+13fqq/5uvo5fNOxPG
	7vF6Dj9ZFyka7eeRRX/qP4xkkZs5gdP++z9pQ9b56xfivs9dlyxcHzC23Fpw5v2QoJZHjw8A
	AeP7ikGaH4UWw8fjbYuDeOVrO4zcTJ+8GJ/35r2iY7xL7tgE2sLOlLjE3vGpfRXZiYOTp4qF
	D7KY7p8jTEEKLqFMFgsCcYVS/C/00qlQugQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnO40PsNUg637tSzWnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFr/Pnme2WLBoLovFzQM7mSz2LJrEZLFy9VEmi0mHrjFa
	PL06i8li7y1ti4VtS1gs9uw9yWJxedccNov5y56yW3Rf38Fmsfz4PyaLGxOeMlrseNLIaLHt
	93xmi3Wv37NYnLglbfG4u4PR4vzf46wO0h47Z91l9zh/byOLx+WzpR6bVnWyeWxeUu/xYvNM
	Ro/dNxvYPBb3TWb16G1+x+axs/U+q8fHp7dYPN7vu8rm0bdlFaPH5tPVHp83yXlsevKWKUAg
	issmJTUnsyy1SN8ugStjas8JloKLbhXPNlxkbWBcZ9XFyMkhIWAi8XfyUZYuRi4OIYHdjBIf
	7l1hgkhISiz7e4QZwhaWWPnvOTtEUTOTxKmGdqAiDg42AW2J0/85QOIiAv3MEu/+TmcCcZgF
	OlgkLmzbyw7SLSzgKHHjWjOYzSKgKrF64jMwm1fAWqLzyRE2kEESAvoS/fcFQcKcQOEN3YvA
	FgsJWEk8WPAYqlxQ4uTMJywgNrOAvETz1tnMExgFZiFJzUKSWsDItIpRMrWgODc9N9mwwDAv
	tVyvODG3uDQvXS85P3cTIzgFaGnsYLw3/5/eIUYmDsZDjBIczEoivKoeBqlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MHEfmLBVP128dcb8Nd5Z4sw7
	b/w4cLp9mn79k+1yRrNXle/1+Jqt/7Hw013ddxU8Sb80TN/WTV36eaK+//ant6UFcybc2GGk
	GfvrbzPvIpkle+eEvjhxqky+PbfOrPC3XJ3x/V+y10/+nz4zyPqp7VSTnb+1197YvKmshf20
	1dqtCUeKw79daFNeu2db7qLKd6fmSh7JrRI7PjsoxeO3/JeuFa9LmkJ5DLXU8wWuLnFZUXPN
	xuTT1FaekqPBZ0V0rI2Vn77KX7lG48tdjxaelDNMc1nuiTQfXnm47YXd9s2bZj1/H3Bgy5N5
	1fd2q749t6P6uN3y01dydksIrfuofeL9G84Pi9Xe5zTp+Hfv4IgIVmIpzkg01GIuKk4EAPOw
	tuxwAwAA
X-CMS-MailID: 20231019111014epcas5p461d1c994f489b9c71a6baf18922146b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019111014epcas5p461d1c994f489b9c71a6baf18922146b5
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019111014epcas5p461d1c994f489b9c71a6baf18922146b5@epcas5p4.samsung.com>

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


