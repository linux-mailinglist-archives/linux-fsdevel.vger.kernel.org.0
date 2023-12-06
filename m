Return-Path: <linux-fsdevel+bounces-4967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42EB806C1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0371E1C208DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638742DF91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bb596vxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C99D5A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:10:43 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206101042epoutp024372331a77374a7d1f58be54aa7bbd0a~eNlOhHBid1975119751epoutp02P
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206101042epoutp024372331a77374a7d1f58be54aa7bbd0a~eNlOhHBid1975119751epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857442;
	bh=SF1N2aEMUVTCNqgb0+5ohRAM5D566oKMRQvrVXH9YeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bb596vxZSzDq6HUO6OJryULZFPb5XEJdCNrLcfyZ4hxnPwAG3Nnp6hEPwozaULZy4
	 orqqqZuKkIWr7H4IgfRLUiPhiGk+TTjkiBzUQbhHaSl9MKE9e7au8UM0dNdjEcOAtP
	 GiR5P4CiZr0YFR3Wukup8myASUFKlni0FYWtBNAc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231206101041epcas5p3237c541b3548a36a5cbe4510ba0336e7~eNlNywgn70506805068epcas5p3V;
	Wed,  6 Dec 2023 10:10:41 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SlY7g1vy7z4x9Pp; Wed,  6 Dec
	2023 10:10:39 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.03.09634.F9840756; Wed,  6 Dec 2023 19:10:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231206101038epcas5p49984074d09421f0f60e231e33db8b9e7~eNlK5-s1R0156201562epcas5p4x;
	Wed,  6 Dec 2023 10:10:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101038epsmtrp117841ac668b2752ba50e9a8c2f2d58a1~eNlK32slC1053310533epsmtrp1j;
	Wed,  6 Dec 2023 10:10:38 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-7f-6570489fb8eb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.B5.07368.D9840756; Wed,  6 Dec 2023 19:10:37 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101030epsmtip2d34b4a231c1c746d0b685aa105f7840b~eNlDvozXf0087000870epsmtip2A;
	Wed,  6 Dec 2023 10:10:29 +0000 (GMT)
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
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date: Wed,  6 Dec 2023 15:32:33 +0530
Message-Id: <20231206100253.13100-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTH+917ubvrtHZZUH+Bk7hTGTA8Nhf64bih+eg2xMAMjjFFgxvc
	Adpn+/A5DAQDrCTPbSJWkWdhmDqCAcsrZWddhHAFRJBXEbuFESEypDysdlkq//ucc77ndx6/
	OWycp2d5sVPkGkYlF0v55Aai0eTrF1BOK5lgnY6FrnTfxNH84gqBMgqf4ujieAGJZkyPALJd
	zwGooqqMQPevGzHUVlWMoW8umjFk/nuWRMWd9wCyDxow1D7ijyqzawjU1n6LQAMt50hU/rWd
	hT4baiZRreUvDA0X2gEq0g1iqNn2KUCNK+U4ujwzR6CuEW9kfWpx2+NNGw3jLNo6cZWgB3q1
	dH3daZJuqEmjpxtKAd16P52kq/P1bnRe5h8kPW8fIei5jkGSzr9WB+iGnlP0Qv1LdL1tFot+
	4X3J7mRGnMiofBh5giIxRZ4k4kfExO+LDwkNFgQIwtAbfB+5WMaI+PvfjQ44mCJ17IXvc1Qs
	1Tpc0WK1mh/05m6VQqthfJIVao2IzygTpUqhMlAtlqm18qRAOaPZJQgOfj3EITwiSR4/3cpS
	NoqOL2U8IdPB2M5cwGZDSgiH5jS5gMPmUa0AFvwuyQUbHPwIQJu5h+Uy/gSw5Ic5wqlyJvxo
	1eOuQDuAlvJV0mUsADhtH8Ccz5KUL7yj1zoTPKlvcWi8KnBqcMqEQ3Plz6Qz4EF9CLPPNa4x
	Qb0C707VsZzMpRCc763CXdW2wdL+x2t+DhUG9b+6/FzKHd4qta11hDs0md+dXesIUt9zYJ7+
	C+BK3g+N/TXrbXvA3yzXWC72gg8Kstc5AfaX3sZcrIFTbTfWORxmdRfgzmFwxzBXWoJctTbC
	vBUb5lodF+qyeS71djhRbHdz8RY4+WXNOtOwYKBzfVlnAJwbbcYKwTbDMyMYnhnB8H+1CoDX
	gRcZpVqWxKhDlAI5c+y/f01QyOrB2nX4vdMMxn96GNgJMDboBJCN8z25UquC4XETxSdOMipF
	vEorZdSdIMSx4yLca1OCwnFeck28QBgWLAwNDRWG7QwV8LdwZ7LKEnlUkljDSBhGyaj+zcPY
	HK907LW+orHeuJXmw8JXs4YelOxws1Z4d4vCc3IiYz+YrPAbW+44kHUn+0b0ZFnTiX2SJEGk
	tqWIdWjUc6vx/EfPr+q6q83LmyzMTDqx616q91HsOTxymO5ip70cNu7tMRPFR+r3aocljC5q
	1m0+6omVuFTdtNc69nEL3zf/bFxQZqp6yWSKzdzYcfKxwEOVaql7u0I2GuM1UpZ5MKJ/+82O
	rgu1MTzEOR70ltHcdNf9lwsTl5L9oS0vdR67/JXpkP/yjp62M2kP961OuZ/KWAyk+rrMm6Ol
	R6Z5ss/1hgUY28E639NnDi8ZKN17TNS7ddGwZ+qwsZ6zFMfaHF4ZcfuTtnw+oU4WC/xwlVr8
	D34F2iemBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSvO5cj4JUg1VXLC3WnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZHH0/1s2i0mHrjFa
	PL06i8li7y1ti4VtS1gs9uw9yWJxedccNov5y56yW3Rf38Fmsfz4PyaLGxOeMlpM7LjKZLHj
	SSOjxbbf85kt1r1+z2Jx4pa0xfm/x1kdpD12zrrL7nH+3kYWj8tnSz02repk89i8pN7jxeaZ
	jB67bzaweSzum8zq0dv8js3j49NbLB7v911l8+jbsorRY/Ppao/Pm+Q8Nj15yxTAH8Vlk5Ka
	k1mWWqRvl8CVcbdzN3vBNtuKn00/2BoY7xh3MXJySAiYSNw/P5m5i5GLQ0hgN6PE/pMNrBAJ
	cYnmaz/YIWxhiZX/nrNDFH1klHjet4qti5GDg01AU+LC5FKQuIjADmaJn2ubmUAcZoHLzBLT
	Fh5hBOkWFoiWOP39ONhUFgFViSuPV4FN5RWwkPh4dhEzxAZ5iZmXvoPFOQUsJSY/h4gLAdXs
	a5zOAlEvKHFy5hMwmxmovnnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtc
	mpeul5yfu4kRHPtaGjsY783/p3eIkYmD8RCjBAezkghvzvn8VCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqY3s5iMhSVEWkPWts1p5rp5VOPZcGTXHM9
	gx5vvrjbzH/FouUK+eY3s/yYuz+cvD75xG79b/qRDu8/Jvf37PMXcbp0a1PhxO8vr/jL5MZt
	8haTzHB5eLHHyorj7NE7U5kyPiWZzdLrZWU6sVKY2XJbzWn32u4+c4HLrU3LWCqPi7OGLf+b
	svA2174uq4wHEvqzl2spn/035cdNU8W6usV3pSuFQ2MVgr0b3FY5Vc86wyDVueuOeqrS9xSP
	+WuYLrYc++TzJ8U2eJ2N8/5Tz1Zyau6c+UfIunKD+WLDpYd+luzk3am+LdWxZ6uJ7VWTqVXf
	axcYVzjqqVb4bORafvzPPK5rk5jO3p+0OG9978OdSizFGYmGWsxFxYkA66GVEmwDAAA=
X-CMS-MailID: 20231206101038epcas5p49984074d09421f0f60e231e33db8b9e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101038epcas5p49984074d09421f0f60e231e33db8b9e7
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101038epcas5p49984074d09421f0f60e231e33db8b9e7@epcas5p4.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 0b2d04766324..7193a1f015f9 100644
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
@@ -634,6 +668,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_hw_max_entry.attr,
+	&queue_copy_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f8a21cd9233..4e17945041c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -311,6 +311,9 @@ struct queue_limits {
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


