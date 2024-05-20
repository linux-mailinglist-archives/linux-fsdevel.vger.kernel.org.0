Return-Path: <linux-fsdevel+bounces-19784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C58C9C54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FBD1C21E56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0356452;
	Mon, 20 May 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NhU9TtrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AE54BE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205484; cv=none; b=rZcVQi8+FnhYpdMTPL1Wq4+i/XsvenHL7s2T79P9SFDqFcWfhC+mpI/T0OO/jjniF4T9y8EiDPBv3Y1WcsojAc+Tl1W+9B7vlYsfLhywjqUEqUONVHeJ3rXSZ+TslW7m99OwxlREKZ6MNds8OE8GOHvG00plUDA5hXf7ft/BUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205484; c=relaxed/simple;
	bh=14rJEDi2P1l+j3WYjAg8K5T48LOyGvVLKGZtIYKaQsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=QjBWSc+r4TBdhdrDM+o/Tb6DiUS8aHvJt4HP7QX81BJXpndBvFq39Lo/pmxjEOev+uFYaKed6GrtgmUeIpm7QyArge1mShtcWTPcjy6fZKXV3fbk4j1QVFoJ4MeSpUuaE0dNAYrbBYguRq2vjVaa+8zeJvjd4ehi21PblhHCCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NhU9TtrB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114439epoutp0206ba54b2bebb541104dbb72b2d91258e~RL8qHApXX1030810308epoutp02I
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114439epoutp0206ba54b2bebb541104dbb72b2d91258e~RL8qHApXX1030810308epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205479;
	bh=Tu6eLlHByn6DIRbEEkQ1IQdusiM8jiE1rtht0uezMEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhU9TtrBKlG7BggPdkqwn7vfYxZDWC1XmVfRDrB6Q+X6HRVvMu7gBhgHClGvpR/C5
	 8qdAR5VqlKqG+bK51Pu0oKGcS36a1fI44XCfw1dlTVS4+7uaE7acFhxS+BQfCGGBEc
	 oReEHFa5FdYMeBuaELbxK6xJlMcDktbDczYoBan4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114439epcas5p25cd426d99f6b312791da4e80922a59b4~RL8pewmvc3086130861epcas5p2G;
	Mon, 20 May 2024 11:44:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VjbMS3vXlz4x9Pv; Mon, 20 May
	2024 11:44:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.B9.09665.4A73B466; Mon, 20 May 2024 20:44:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102830epcas5p27274901f3d0c2738c515709890b1dec4~RK6KR1F9d2367023670epcas5p20;
	Mon, 20 May 2024 10:28:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520102830epsmtrp100741a1f1493d9edbca78a155f4b7777~RK6KQapIb2026620266epsmtrp1c;
	Mon, 20 May 2024 10:28:30 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-c2-664b37a43808
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.F6.19234.DC52B466; Mon, 20 May 2024 19:28:30 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102826epsmtip29f05b1f606c395534f9b241baf559c09~RK6Gcre1a2247522475epsmtip2f;
	Mon, 20 May 2024 10:28:25 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Date: Mon, 20 May 2024 15:50:14 +0530
Message-Id: <20240520102033.9361-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHue89Hi0b2xuweGH+YDUuKIIUab0YUDJwPgcGNpNtWWLKCzwo
	obRNW34MF0cFRCSA6IBZVKAwBlRBKGOAoIUKDBxhyC8l0S0bBREQNFS2McZaitt/n/O953vO
	ybk5HNz5L9KdEy9VsQopI+GRjkSLcbend9WBsFjfa39A1DDQi6MzF9ZwpHtUQKI54wuAipf+
	xNGUIRug1cEhHDX3PgaoXHuVQA8NbRjq0F7EUK2uB0OlJRkY6llfINHF7nGATGMaDHVOeqGK
	s1UE6ujsJ9BI+xUSlVWbHNB3ff9gqPDcGIZap9QAtayW4ah+bpFAP06+g4bW+uyDt9Ijo2H0
	gBbSbZpHDvTQ40aCHhlMopvqckhaX/UV/UR/GdC3HqaTdGX+JXs6L+MZSbdl/WJPPzdNEvTi
	7TGSzm+uA/RP5XcdIl0+TwgUs0wMq/BgpdGymHhpXBAv7IQoRCQQ+vK9+QHoAM9DyiSyQbzQ
	8EjvD+Illg3xPJIZSZJFimSUSt6+Q4EKWZKK9RDLlKogHiuPkcj95T5KJlGZJI3zkbKqg3xf
	Xz+BJTEqQbxewsjVIanZ964Q6UCLzgMuB1L+sPNyLXEeOHKcqVsAzuTn2NuCFwC+vFkDrFkb
	we/XY1451id6CJveBmBnnYPNkIVBs7nYEnA4JOUF761zrLorpcNhrr5wowVO6XGoNhowq9uF
	Ognrf57YqERQu+By67K9lZ2oALi23Ivbuu2AupuGDeZSB6Hh+yVgLQSpSi5M7xq0tyWFQsP6
	4qbBBT7ta3awsTucLTi7ySmw9usa0mbOBFAzoQG2h8Mwa6AAt46NU7thQ/s+m7wNFg3UbwyK
	U2/AvNUpzKY7wdZrr3gnvN5QTtrYDY6vqDeZhqUmI2ZbUR6A/cXbL4Dtmv87lANQB9xYuTIx
	jlUK5PulbMp/nxYtS2wCG0ewJ6wV/Pbrkk83wDigG0AOznN1amo+FuvsFMN8kcYqZCJFkoRV
	dgOBZYGFuPvb0TLLFUlVIr5/gK+/UCj0D9gv5PO2OM1lXY1xpuIYFZvAsnJW8cqHcbju6Vin
	dDh8Vj99u4Mb/MMIXeHV+HfUlx9O5Q0fStsxf/dGZsHJfP3zj3Wp03EzOaff7Cm1C+rLfYv0
	YY6/5yMok98vuPRZPROak/1NiEJwR2PnShfa5UYmB7Ox76cc7XBTze/95LTfsMnca9ylVd9X
	76WetuZ2pE1FSNUzp2pCTqUUbQlKjqu/Icr27KpJdZQoXPsd7yi05UXhxRK/9Blde4PXuWHX
	NPNH5urVErHIsDBIM9O5zMtKDXNE3JKYGRxV0hVx9JnnbNmDhXdXjSeIdTpiNL7x+Jn55gqT
	2e71nOrDoy4P+NjWceS8jfvpsW+xVCJWOPIk0DNjZXzcVPvaSv5OHqEUM/w9uELJ/AtQakzp
	jQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfVDLcRzHfX+/3377NTd+tzg/1V2Zy5FTugtfyVPd6ctwzsMh1zH6SdrW
	bpOHPK0mFZclD93Sk0lUWLaalnK7tIpklHR1K47y2CP5g6zR4r/XfV7vz+f9x4fCBXcJDypG
	dohVyMQSIckjTI+F3gue+4r2L/xVgUP903ocJmU4cFjapSHh18ffALw69BOHPZYUAEebbTgs
	r+8GsECXS8AOixmD1bpMDBaXWjF4LUuNQauzn4SZta8B7G3LxmBN53x4/WwhAatrnhCwtSqH
	hPlFvVx4q2EMgxdT2zBY2ZMIoGk0H4f3vg4SsLHTE9ocDZxVXqj1lQg91THInN3FRbbu+wRq
	bY5HhpI0EhkLT6NPRi1ADztUJLpx4RIHpasHSGROfsNBw72dBBp81EaiC+UlAD0rqONuco/g
	hUSxkpjDrCJgxR7eAWeWWJ4YdjSlKYdQAR08B9wohg5inO1W4hzgUQL6AWDMV8ycCTGTKXLU
	4RPszhSPfeROhNQYo8/p/CsoiqTnM01Oanw+jX6AM8Pq89j4Ak5bcebFHVeDO72LeV5U4zpK
	0L7MSOWIi/n0UsYxUv+vwJspLbO42I0OZiwVQ2CcBX8zXe1DZAaYUgAmlYDprFwpjZbukwf6
	K8VSZbws2n9fnNQAXB/121wJivQO/1qAUaAWMBQunMY3lK/dL+BHiY8lsIq43Yp4CausBZ4U
	IZzBny1JixLQ0eJDbCzLylnFf4tRbh4qTLZk74BM6x0W2uLH9Tkx43tUZF73sgiPF9ptUntw
	mSil+KXb5BaNZ8Vs9Op9VWugemzRWvuZ5LI5O/Q6ufF6bGgXubgl1Wu7hre5+f3nX3eFc4/I
	bFsNi6xSTeDRuMh2Tjq17lpEnz1yk92wIKga9I6usa9G2t/rwg17Cmd94aY1iUyS7ACfUwdv
	PlPJ1zR2qLac9A8RqRUDCbu2Lu5vb8TD21L5AZQynK8ZqqoeDPqx06aN3PCBl7E8olxPHvHq
	+ZGQOs8Z+w7c2Hg/PW9l7tnLPcEmQnI8Lh/3rZuTveX2Bzk2tS/kjGnwLRFwObaffx4mWYxZ
	hesdap8lxkStkFAeEAf64Qql+A/3YTbWQAMAAA==
X-CMS-MailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Add device limits as sysfs entries,
	- copy_max_bytes (RW)
	- copy_max_hw_bytes (RO)

Above limits help to split the copy payload in block layer.
copy_max_bytes: maximum total length of copy in single payload.
copy_max_hw_bytes: Reflects the device supported maximum limit.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 Documentation/ABI/stable/sysfs-block | 23 +++++++++++++++
 block/blk-settings.c                 | 34 ++++++++++++++++++++--
 block/blk-sysfs.c                    | 43 ++++++++++++++++++++++++++++
 include/linux/blkdev.h               | 14 +++++++++
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 831f19a32e08..52d8a253bf8e 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -165,6 +165,29 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/copy_max_bytes
+Date:		May 2024
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
+Date:		May 2024
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
index a7fe8e90240a..67010ed82422 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -52,6 +52,9 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
+	lim->max_copy_hw_sectors = UINT_MAX;
+	lim->max_copy_sectors = UINT_MAX;
+	lim->max_user_copy_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -219,6 +222,9 @@ static int blk_validate_limits(struct queue_limits *lim)
 		lim->misaligned = 0;
 	}
 
+	lim->max_copy_sectors =
+		min(lim->max_copy_hw_sectors, lim->max_user_copy_sectors);
+
 	return blk_validate_zoned_limits(lim);
 }
 
@@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
 {
 	/*
 	 * Most defaults are set by capping the bounds in blk_validate_limits,
-	 * but max_user_discard_sectors is special and needs an explicit
-	 * initialization to the max value here.
+	 * but max_user_discard_sectors and max_user_copy_sectors are special
+	 * and needs an explicit initialization to the max value here.
 	 */
 	lim->max_user_discard_sectors = UINT_MAX;
+	lim->max_user_copy_sectors = UINT_MAX;
 	return blk_validate_limits(lim);
 }
 
@@ -316,6 +323,25 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
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
+	struct queue_limits *lim = &q->limits;
+
+	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
+		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
+
+	lim->max_copy_hw_sectors = max_copy_sectors;
+	lim->max_copy_sectors =
+		min(max_copy_sectors, lim->max_user_copy_sectors);
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
@@ -633,6 +659,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
 
+	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
+	t->max_copy_hw_sectors = min(t->max_copy_hw_sectors,
+				     b->max_copy_hw_sectors);
+
 	t->misaligned |= b->misaligned;
 
 	alignment = queue_limit_alignment_offset(b, start);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f0f9314ab65c..805c2b6b0393 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -205,6 +205,44 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
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
+	unsigned long max_copy_bytes;
+	struct queue_limits lim;
+	ssize_t ret;
+	int err;
+
+	ret = queue_var_store(&max_copy_bytes, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
+		return -EINVAL;
+
+	blk_mq_freeze_queue(q);
+	lim = queue_limits_start_update(q);
+	lim.max_user_copy_sectors = max_copy_bytes >> SECTOR_SHIFT;
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+
+	if (err)
+		return err;
+	return count;
+}
+
 static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(0, page);
@@ -505,6 +543,9 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RO_ENTRY(queue_copy_hw_max, "copy_max_hw_bytes");
+QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -618,6 +659,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_hw_max_entry.attr,
+	&queue_copy_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aefdda9f4ec7..109d9f905c3c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,10 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		max_copy_hw_sectors;
+	unsigned int		max_copy_sectors;
+	unsigned int		max_user_copy_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -933,6 +937,8 @@ void blk_queue_max_secure_erase_sectors(struct request_queue *q,
 		unsigned int max_sectors);
 extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
+extern void blk_queue_max_copy_hw_sectors(struct request_queue *q,
+					  unsigned int max_copy_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
@@ -1271,6 +1277,14 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
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
2.17.1


