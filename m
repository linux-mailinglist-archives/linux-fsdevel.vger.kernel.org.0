Return-Path: <linux-fsdevel+bounces-6782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76881C5D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527282833F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED723773;
	Fri, 22 Dec 2023 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cHTeEEHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC923749
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231222073254epoutp02727645ca21596cbb79fb55539b3b755a~jFwBvnwEu1674516745epoutp02g
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231222073254epoutp02727645ca21596cbb79fb55539b3b755a~jFwBvnwEu1674516745epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230374;
	bh=gdF/wOMKugvH3378GVUkXSQTheU2+tEf4koM7BLSTqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHTeEEHD4GNkzWNv6eTZqmKPtPXdJKUZPn/655lcCQOFn2Z6uQmJfSn1Th03+STr/
	 Ho6KlLBKpF15Aso4B3fAmwrWCpQBvaa7ZfyV7pDeZTYLeKn9JTVcy1UFqlnJibpGBi
	 m9vq38tx4NtPjfT+hZ2qsOct3qDZcOUmZh2V6hRk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231222073253epcas5p412bcd55be87879719d1db2fdf5a4af8e~jFwBAl_tL2514625146epcas5p4K;
	Fri, 22 Dec 2023 07:32:53 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SxJtD5PGNz4x9Q1; Fri, 22 Dec
	2023 07:32:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.74.08567.4AB35856; Fri, 22 Dec 2023 16:32:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231222062248epcas5p4623168200a168ae2f895df4221368d66~jEy0En_fu0903809038epcas5p4h;
	Fri, 22 Dec 2023 06:22:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062248epsmtrp1088c62ec57e799bad9ace7097f36eaf2~jEy0DmXzk1655116551epsmtrp1W;
	Fri, 22 Dec 2023 06:22:48 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-e8-65853ba4252f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.FE.18939.73B25856; Fri, 22 Dec 2023 15:22:48 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062244epsmtip26cf587d2c278da63c0ced776226aa9da~jEywWeSb_0303503035epsmtip2O;
	Fri, 22 Dec 2023 06:22:44 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Anuj
	Gupta <anuj20.g@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 12/12] null_blk: add support for copy offload
Date: Fri, 22 Dec 2023 11:43:06 +0530
Message-Id: <20231222061313.12260-13-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRie75yzZxca6gCin4SJa0moXBaX7eOWMlw8TQ5DpcboD9zgCAzs
	xb1Ixjgutw0hASUcWeMiMAlIy8jN5SKjkFyzrQRcYYDSxQxCAlM0Atr1oPnveZ/ved7bNy8P
	d6jhOvMSpCpGIRUn8UlbornL3c2jMiCT8a44twXV9XfjaO7xIoHS8pdwdGksj0TTXfMAma99
	CdDiTSOOysqLCXTnWguG2svPYKj60g0MnekcBmhySIehqyPb0AVtJYHar/YR6FbrNyQq/XaS
	i3JuG0h0sWcZQ6b8SYBOZw1hyGBOBah5sRRH+ulZAvWOvInu5WQBZFzq4exyoVt0Y1zaOH6Z
	oG/dVNP1NSdJuqHyBP2goQjQbXc0JF2RW8ChT6U/JOmWzAkOPTc5QtCzHUMkndtYA+iGgRT6
	Uf1bdL15BoukDiQGxjPiWEbhykhjZLEJ0rgg/oefRIdE+4q8BR4CP/Qe31UqljBB/NA9kR7h
	CUmWDfFdj4qT1BYqUqxU8r3eD1TI1CrGNV6mVAXxGXlsklwo91SKJUq1NM5Tyqj8Bd7ePr4W
	4aHE+Kn+blL+c/jnVU9+5WqA3j8b8HiQEsJnJ12ygS3PgWoDcPziAMkG8wAWrpi4LwPzn/OW
	wOa547e0Uox9aAGw1tQH2CATg8bUGa41L0ltgwMrPKthDVWLw5bLAqsGp57isKKnh7RqHKlg
	WFISadUQ1Duw+ayWY8V2VADM67tOsO15wbwJeyttY6F//6diVWIP+4rMhBXj1EaY3nQet6aH
	VJcNHP3uJGAbDYWPHxUSLHaEUz2NqwM4wz/ytKs4GVZ/XUWy5gwAdbd1q+adMLM/D7c2gVPu
	sK7Vi6U3wMJ+PcYWfh2eWjRjLG8HDSUv8GZYW1dGsng9HF5IXcU0LB/Q4uyucgHMvqvD8oGr
	7pWBdK8MpPu/dBnAa8B6Rq6UxDExvnKBlEl++ckxMkk9eH40W0MNwFS67NkJMB7oBJCH89fY
	ybZnMA52seJjXzAKWbRCncQoO4GvZeGncWenGJnl6qSqaIHQz1soEomEfjtEAv46u+nM4lgH
	Kk6sYhIZRs4oXvgwno2zBst4Y/vkbColGmwwp3S4rWPCtRlr3/YJRvuznl73SIg4qpsoQIl7
	c47L/o1KvrDb3se88CBNrt3b/33auX1RQXM1IXP6wzs2930cUDcsdc8YmVhbWTBTHTHqWP5D
	zfF9URXL8Zuc/XI0kuLXXP7K8t3yUdsV46eDNiFmv186ME5YeliT05A9RrgUF5btMUzd0F35
	27/RKDIcWXm46aAhy/bEhiOOo6KlFP2xQ88iHN9tHOT8KDJNud2f2T0bKFTualcYzx8ujDA5
	bZTYj98b14yfHVkprQ796aA+fudn2m5+a9F+nyr13Wxpn1tv7oLW7kCjS1rTE/X9gKrerzTp
	OWEfBLeP8QllvFiwFVcoxf8B7C2wGr0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcQDG+77ve++9bt32dlTfcstc9Q86as2+xVJrtTfK0toqrXF450d3
	2F1KtBLHSeUulnLidKcTDeUk59c4ScRUNxWSLDeVFaU03fTjWFv/PXs+nz1/PRQuGCFWU7Hx
	J1h5vEQqInlEfYfIbQPyzGR9lJMA1fQ8wtGX73YCpWvmcXRnRE2iyY6vAI23qQCy9/XjqFRf
	TKDBNjOGmvV5GKq404mhPMsLgGwDWgy1DHmim1llBGpu6SaQtfEGiXRGGxddfNlAovKuXxh6
	pbEBdCV7AEMN4+cBqrfrcFQ9OUWgx0Ou6N3FbID657s424WMWTvCZfrf3CMYa18SU1t5gWRM
	ZeeY96ZCwDQNppGMITefw1zO+Ewy5sxRDvPFNkQwU60DJJNbVwkY05NUZqZ2DVM7/gnbT4fy
	/KNYaexJVu69LZwX87HnEZn4bHfy7dm33DRQvTUHOFGQ3gzH0nVYDuBRAvoBgKqnH8hFsAoa
	5x/ii9kZVvya4C5KGRi8PjxB5ACKImlP+OQ35ehd6AYczlVlLCzhdDYBn9a3cB2SM70DlpTs
	dwwR9HpYX5DFcWQ+7QfV3e0LO5D2hurRZY7a6W898dOwoAjorbB7wkQu6stgd+E44cg47QYz
	7hfhGkBr/0Pa/1ApwCrBcjZRIYuWRSZuFCskMkVSfLQ4MkFWCxYe4HGgARhr5sUWgFHAAiCF
	i1z4CV5KVsCPkpxOYeUJYfIkKauwAFeKEK3kr5VeiBLQ0ZIT7HGWTWTl/yhGOa1Ow652Vqzr
	1XQFTrl37ak5ONint/i6r+vYZOfdTqraUjK7dAspMcwEufgp248RRYfyW5Pj3hXmlllvxVnV
	BpVK7rtiZcC0NWX9SS/zDbUHiggQ9ynJMY/Xn9+6iavSi8MvaQvdmyaLOjX+4e1+wm9jISap
	Mz/C+qKRa7Pq65qb1mRrp30iBWLtcG+ysmff0V0681mj4fKOgvIjJfbpoL0puw/f5bwJUY66
	n7nedO2H9HX/R1e9sb1GuIuaWxVYGpB1yll2TBEdlBomDhXFpcZ2KpRh56qfW5bkN89tzznC
	TRHuEc7WxfirhjPFmw7ofhcJy2fY2JCbZ4uDd+58mOUfLCIUMZKNHrhcIfkDEazyDnADAAA=
X-CMS-MailID: 20231222062248epcas5p4623168200a168ae2f895df4221368d66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062248epcas5p4623168200a168ae2f895df4221368d66
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062248epcas5p4623168200a168ae2f895df4221368d66@epcas5p4.samsung.com>

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
index 1b40c674f62b..e6f476ad45a6 100644
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
+	 * First bio contains information about destination and last bio
+	 * contains information about source.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			sector_in = bio->bi_iter.bi_sector;
+			if (rem != bio->bi_iter.bi_size)
+				return status;
+		} else {
+			sector_out = bio->bi_iter.bi_sector;
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
@@ -2074,6 +2160,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->queue_mode == NULL_Q_BIO)
+		dev->copy_max_bytes = 0;
+
 	return 0;
 }
 
@@ -2193,6 +2282,8 @@ static int null_add_dev(struct nullb_device *dev)
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


