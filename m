Return-Path: <linux-fsdevel+bounces-6771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9C81C58E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F3B283887
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4014A82;
	Fri, 22 Dec 2023 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q83dtxB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA1101E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231222073151epoutp03ae215519ea368d9aae8ffaeff4096149~jFvGvTc2m2967629676epoutp03C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231222073151epoutp03ae215519ea368d9aae8ffaeff4096149~jFvGvTc2m2967629676epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230311;
	bh=4LYQ4Z8s8Ktq3w5D+hMl2cEBoY0WGnDBr6jEXEQrqz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q83dtxB9YIyXJRgt801wVaoW+Ss00prinXLjkI7Z1xRirEB/dzzhuVTHiHRw+/qyr
	 UuyrOoeiUG5Yu0bx+T6K4tKrxtK12Tm26ED8zhaEVJ3hOy5S4pXYDdy2kYz/d1L2C2
	 Mqi6z8Nv1c1fh0brAzcT2PBb5gc6x2wIZ53xHOqU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231222073150epcas5p3ad1077464d13a44c29f119619c5633ab~jFvGKb1H-2805628056epcas5p3Z;
	Fri, 22 Dec 2023 07:31:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SxJs03BD7z4x9Q2; Fri, 22 Dec
	2023 07:31:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C5.34.08567.46B35856; Fri, 22 Dec 2023 16:31:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062055epcas5p2f8d3738628d50a52c1b7da80ca6d68fe~jExLWFClN0448404484epcas5p2V;
	Fri, 22 Dec 2023 06:20:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222062055epsmtrp29f9c2de2937929e82acecb1a65de64b8~jExLVECoj1637116371epsmtrp2W;
	Fri, 22 Dec 2023 06:20:55 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-43-65853b64a85c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.B8.08817.7CA25856; Fri, 22 Dec 2023 15:20:55 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062051epsmtip26ae1566d805a06d00a45a4a05eea4f16~jExHx61j_0362603626epsmtip2F;
	Fri, 22 Dec 2023 06:20:51 +0000 (GMT)
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
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date: Fri, 22 Dec 2023 11:42:55 +0530
Message-Id: <20231222061313.12260-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRjuO+dwWFDkgFifq9l2NAy57eqyfIuQTDHOGdNkqH7IDMHGngFa
	2N12F9HUxLgoFBcxDRaQ6xQXE4GFWJRkQe6hY4TAjtDEQCo3AxRUBoh1ofz3vM/7vPd5Obh9
	viWXEyHXsCq5JJImrYnaZicnV+neBJY/YbRDFZ2tOJp+ukCgb9IXcVQ+mEai8eYZgEYazwKU
	X5hLoIFGPYZuFGZgqLS8BUMty5Mkymi6B9BorxZDDUZnVJBYTKAbDR0E6qnPIVHej6OW6Nu+
	OhL91LaEof70UYDOn+vFUN3IGYBqF/JwdHX8MYHajVvQncU2C98tjF47aMncGaokmJ7uaKaq
	LIlkqotPMw+rswBzfSCWZIpSL1gwKXFTJDM9aiSYx7/2kkyqrgww1V0nmNmqbUzVyCTmbxso
	8w5nJVJWxWPloQpphDzMh/7w4+APgj1EfIGrQIw8aZ5cEsX60H4H/V33R0Su7IXmHZVERq9Q
	/hK1mnZ/z1uliNawvHCFWuNDs0pppFKodFNLotTR8jA3OavxEvD5uz1WhCGy8MyuHEJ51ufY
	fOJfeCzQ7UkGVhxICeGkIZtIBtYce+o6gCUTD1aNGQAHhzIszMYcgBmFP4C1kO96y4HZ0QBg
	48w/hMlhTyVgMG9JnAw4HJJyhl3LHBPtQF3Bob5SYNLjVDMOWwqGSZNmIxUEK2f8TRqCegem
	/16Cm7AN5QVvjk1ZmCSQcodpf9qZaCtqL3zwosjCLLGDHVkjL6vi1FswriYbN6WH1E0r+Dzt
	LmHu0w9O6ppJM94Ix9p0lmbMhbNTDat8DCz9voQ0B8cDqO3Trg65DyZ0puGmJnDKCVbUu5vp
	N+HFzquYufAGmLIwgpl5G1h3eQ1vh1cq8lfzb4b35s+sYgaW6+pJ895SAUzoKQPpgKd9ZSDt
	KwNp/y+dD/AysJlVqqPC2FAPpUDOxvx35FBFVBV4+Sq7/OpAf96SWxPAOKAJQA5OO9goXOJZ
	exup5PhXrEoRrIqOZNVNwGNl4edx7qZQxcqvyTXBAqGYLxSJRELxHpGAfsNmPCFXak+FSTSs
	jGWVrGotDuNYcWMxGTNhta+7tl3fXVp7+Y9uT7cDdPsmZ33YfccuOss6Zf7AjhOW5PJnPxt2
	x/Nk9wvy113sONymcOkJfvvgl7cvSJ/ZHknV97k8Mw7bbtj63KFwIOAXrlXh8tDdS7cCIpLL
	jU/qbvVcC/m8Yj6I61H1qafB1unk0WMNSXGGr0+3Fom3OS3+lqk7F5+dWDKdceRkZvdHMGj4
	E77vwim/dVT9zpy6/ACXL2oCjcUtrwc9Gl6KS5K1qLwf0YEv0mU+c02n3j2U03pbv963y9Fm
	rH/cvuDwom5rliG5MkIutnut+dCOfnSJa5gTzr5f/Pd+u8kn29c7ikLGH4YcH6/xiuG47HR7
	mnttlCbU4RLBLlyllvwL8ni+HrMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+75zPDuOVsdl9KmQMLCL1cpV8HVRArNOWBQhYVdberyUm2tT
	u0GtVpp2W0oXN8XUstrIaCtZTrtMbZpZoVlqWWpbVtPsHrXUmhL03/M+v+d9eOGlCWEr6U8n
	yVM5pVyaLKL4ZHm1KHCGPfgQN+tSXyC+ev8egT99c5P4gHaAwMaOExR2VX8G2HEnE+BzxQUk
	brtzE+LK4hyILxtrIa4d6qNwju0pwM4WHcRV7dNwUcZ5EldW1ZO4uSKfwoWlTh4+8sxC4Yv2
	QYhbtU6ATx5ugdji2A9wubuQwGWufhLXtQfgRwN2r0UB7E1dB4999PIayTY3prEmQxbFms/v
	Y9+a8wBrbVNTbMnxXC/2mOYDxX5ytpNs/60Wij1+3QBYc8Me9otpImty9MFVY9fxF8ZxyUnp
	nHJm2GZ+4tmGfFKRGbrzR0YXoQbXZ2cDbxoxc9DRFiPIBnxayFgBeljXSY4AP1Q6UEOM6HHo
	8mAPbySkgehI89u/gKYpZhpqGKI9vi9jIdDPKxroGQimmUCni2qAZ3scsx6VH6wc1iQThLRN
	l4ZbBcx8dPv9By9PEWJmohOvfDy2N7MA9fwq8fJo4d9IfY+ZGon7oPo8x/BxBBOINDf0hBYw
	uv+Q7j90DkAD8OMUKlmCTBWikMi5HWKVVKZKkyeIY1NkJjD8/OBgC6g0fBTbAKSBDSCaEPkK
	UqYf5ISCOOmu3ZwyJUaZlsypbCCAJkUTBN9dx+KETII0ldvGcQpO+Y9C2ttfDbO2MY6wxAfX
	wiVb8iPlZFr479SKx2ujWyPfIPe65Zb0tmXjRz+OyD1lNT1VN3g33W+cWxoLfXl4w+vdblfm
	F+arVmqQXdhQ2+8XNbjVMrTPT98ZxCwvnvJOJwqr4fFxfM1UxSb1Gom50/58lC1aG1r4a/Xo
	vc/HbwwtnzyvQr+/JBIc3jNYJJkQWFDo6qpyqeAL+K4uoLfRmeVvja7v3qLJb7XHX61NgtkV
	SNAdtSN+U5DbkGOtWjzbMIbPH2v4vaLjyZOVYssktqysff7Sh73upqb0iO3GhXfzlsxJTp8R
	ExWZZOyOjeiS6Kdn2KJEMeI6xawzvRvD9bklbp9GEalKlIYEE0qV9A8ulR+iawMAAA==
X-CMS-MailID: 20231222062055epcas5p2f8d3738628d50a52c1b7da80ca6d68fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062055epcas5p2f8d3738628d50a52c1b7da80ca6d68fe
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062055epcas5p2f8d3738628d50a52c1b7da80ca6d68fe@epcas5p2.samsung.com>

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
index 51fa7ffdee83..d5019967a908 100644
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


