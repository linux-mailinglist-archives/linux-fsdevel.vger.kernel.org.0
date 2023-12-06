Return-Path: <linux-fsdevel+bounces-4978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11668806C3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3492D1C20996
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3D3033C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RONvNQbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0F198A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:13:15 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206101313epoutp041e7592f64e560d625a499e50ddf7e221~eNnbr93IE1696616966epoutp04f
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:13:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206101313epoutp041e7592f64e560d625a499e50ddf7e221~eNnbr93IE1696616966epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857593;
	bh=xTrfyi/yJidoNrl3TPzzopI+GnPn+ZUhLrlBrAJpZmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RONvNQbfKPP7JVvjs7/Cza28A52wzlIx90cwYe3YvAdVCJEITxSXUxRQRkVuU4Hrs
	 EXjltQKrrtIHLDJNzBZc0Si7sXIvm09t8hUWceIR4z3qQVGCJjLsRAkPxiyMnS4Ifn
	 sKZNZuXoukFqHOHKNCzHaWtMMOTo3WvokxoY+HMs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231206101312epcas5p27ba89066024e85afe3dcbfa68f2ad196~eNna9UUf43251632516epcas5p20;
	Wed,  6 Dec 2023 10:13:12 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SlYBb3qKRz4x9Pw; Wed,  6 Dec
	2023 10:13:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.A8.19369.73940756; Wed,  6 Dec 2023 19:13:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231206101310epcas5p43f06695868958526fed828762e728e7b~eNnZC_V9U2295022950epcas5p46;
	Wed,  6 Dec 2023 10:13:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101310epsmtrp24b03b0bf079829d4f931fce53db76085~eNnZBqF9B1007210072epsmtrp21;
	Wed,  6 Dec 2023 10:13:10 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-4a-657049372387
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.85.18939.63940756; Wed,  6 Dec 2023 19:13:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101305epsmtip2045c6dd8db41916fbde2ae92d7cd27d5~eNnUSGSf50087600876epsmtip2e;
	Wed,  6 Dec 2023 10:13:05 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
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
Subject: [PATCH v18 12/12] null_blk: add support for copy offload
Date: Wed,  6 Dec 2023 15:32:44 +0530
Message-Id: <20231206100253.13100-13-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH97v3trTL2K5lZL+wZbBGEoEUWuXxAwq6bBlXRqSJURPRQC03
	hVDa2seGmmUdWB7teIxOM2CjvNwDEOQpRVgmxCE4Vjbs1pKAOlo0MkFgAycPbS2b++9zTr4n
	33zPyWHhnFqfAFa2XEOr5GIZl7mT6B0OCeHFvK6k+Vd1ELWP3cTR0uN1AuVXbOKoZbqcieaH
	lwFy3igCaH3ciqO6hksEctywYGigoRJD11q+w1Dl0D2AXLZqDA1OhaH6wiYCDQyOEmiy/yIT
	mS+7fJDxfh8TXRnZwpC9wgXQuWIbhvqcZwDqXTfjqG1+kUDfT+1Hs8ZigKybI4zXDlCW6mkf
	yjrTQVCT41qqs7mESXU1naZ+66oC1DcOHZNqLDMxqNKCBSZl0f/EoJZcUwS1eN3GpMq6mwHV
	9cMn1ErnQarT+QcmIt/NEWbR4kxaFUTLJYrMbLk0gXv8zfQj6VHRfAFPEItiuEFycS6dwD2a
	IuIdy5a5N8QNOiGWad0tkVit5kYkClUKrYYOylKoNQlcWpkpU0Yqw9XiXLVWLg2X05o4AZ//
	cpRbmJGTVblhYCh1SXl9owoduBdnAGwWJCPhF2sjTAPYyeKQAwAWuK5j3mIZQN2VVeaz4tP2
	HuzpyNn8y7iHOaQFwGIz6RWtAPijfY5hACwWkwyBEyatR7OXbMWhpUPg0eDkXzhsHPH4sVl+
	5GHomGoCHibIYPjAXsrwsC8ZCwcetTK9ZoGw6u6aj4fZ7r7p1wbcq3kBjlY5CQ/jbk1BTw3u
	MYDkMBtOzzkY3uGjcO7rEuBlP/j7SLePlwPgysLgtoEE3q26vZ1MA2cHvt3mV6F+rBz3hMHd
	Ydr7I7xeu2HpuhPztCHpC4sLOV71IThT6dp23Qd/udC0zRRsKRwnvPs5C+DMmJlRAQKrn4tQ
	/VyE6v/d6gDeDAJopTpXSkuilAKenD757LASRW4n+O9RQkV9oOWrzfAhgLHAEIAsnLvXV2ZV
	0BzfTPFHH9MqRbpKK6PVQyDKveRzeIC/ROH+NLkmXRAZy4+Mjo6OjH0lWsDd5zuvv5TJIaVi
	DZ1D00pa9XQOY7EDdJhRa5d9UGtvTbJFSZMNh4vUX9ruhE4K+/qPv3jnVINT/49vPB4u+RCr
	HytvPBXSSpaJ8Pbyh0OzQRt80UL8g5vx72vyKvP0Vtd+aczJ3vsm09buNHNYkZ82P0N45G+j
	xS+wUGgvnre9ETbNS1UR4wfNu2rXUopqatK3DMNntOLzvHrhbWE9uWcpyXWiZtV84MKxxccR
	s8Fs04Sxvz0Ye+JI1qMWxi3jjl1pC4aS+rbEsoDOlw619cSTDVlPEvf8PGidTDE4Coyp7yRn
	2FZXrxUkmicu/il9+FZ4U+6y/60i7XshaY/eFkn9ZdTnNhiXlLrx2TRMqxtpO301t7tjB5dQ
	Z4kFobhKLf4Xr0p7nLEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSvK6ZZ0Gqwbb1KhbrTx1jtvj49TeL
	RdOEv8wWq+/2s1m8PvyJ0eLJgXZGi99nzzNbLFg0l8Xi5oGdTBZ7Fk1isli5+iiTxaRD1xgt
	nl6dxWSx95a2xcK2JSwWe/aeZLG4vGsOm8X8ZU/ZLbqv72CzWH78H5PFjQlPGS0mdlxlstjx
	pJHRYtvv+cwW616/Z7E4cUva4nF3B6PF+b/HWR1kPHbOusvucf7eRhaPy2dLPTat6mTz2Lyk
	3uPF5pmMHrtvNrB5LO6bzOrR2/yOzWNn631Wj49Pb7F4vN93lc2jb8sqRo/Np6s9Pm+S89j0
	5C1TgEAUl01Kak5mWWqRvl0CV8akP12sBQ3uFTtO5jcwXrPqYuTkkBAwkehpWsYMYgsJbGeU
	mPFXHiIuLtF87Qc7hC0ssfLfcyCbC6jmI6PE3487WLoYOTjYBDQlLkwuBYmLCOxglvi5tpkJ
	xGEW6GCRuLBtL1i3sICjxM1bSxhBbBYBVYlHN3pZQWxeAUuJPV/WsEFskJeYeek7WD0nUHzy
	80VQF1lI7GuczgJRLyhxcuYTMJsZqL5562zmCYwCs5CkZiFJLWBkWsUomlpQnJuem1xgqFec
	mFtcmpeul5yfu4kRnAK0gnYwLlv/V+8QIxMH4yFGCQ5mJRHenPP5qUK8KYmVValF+fFFpTmp
	xYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1M3iXFdZdzDiSpbVI1MvnQbW25/k4/
	k5I99w2unWuuPjvNkWF2933znmezbBM69h9tXLix7gDH+W9zZeJMdp17fbdOdFZL3pUPBv9C
	XknlvPgaIzN9DZvj1YS3y5J9cqI3PlthfKTY7+PRGWuvBrzJOtQQaH9cmkdYZH7+Jpddk9rN
	5jwTfuloJR8cwB9zacMayQ1ClqXhP0xu8Cp7LZh3syr5cdPm3BdG7XN+pb+z38nDcJfhu1CE
	Y/TboJut/gvylXSWi89Me8KzvuZsSsjKKaG3O1r6FMTzZ6YVb6sJXfiryfviGfOzLqqPMz59
	Mp1829o4OOP08y61fvYjoT+3PVjQeC6Z8ROXrPPUOdd3KrEUZyQaajEXFScCAPx2ZblwAwAA
X-CMS-MailID: 20231206101310epcas5p43f06695868958526fed828762e728e7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101310epcas5p43f06695868958526fed828762e728e7b
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101310epcas5p43f06695868958526fed828762e728e7b@epcas5p4.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 1b40c674f62b..5b1b401a68fb 100644
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


