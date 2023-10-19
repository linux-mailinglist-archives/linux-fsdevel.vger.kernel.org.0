Return-Path: <linux-fsdevel+bounces-740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688DD7CF811
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18F1B21686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF3208DF;
	Thu, 19 Oct 2023 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="StV9toHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA201EB5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:26 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB51FDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:03:59 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019120357epoutp02a2f4ce390f2aad2baaad2a2953b98f1c~PgKaGyEss2730527305epoutp02f
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:03:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019120357epoutp02a2f4ce390f2aad2baaad2a2953b98f1c~PgKaGyEss2730527305epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717037;
	bh=A08fzSS5yF5x8HdE6Ju9IHdNmMRpxoEL3T7ujwB/X78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StV9toHCyuqYLjAEH8PlVsTG4PkKInbfvTITRB7b1PqdSNxk6eCs8NOPcXww/QdtF
	 pabMoEp2kYlHvIuMs1BsVawi+NbjlsQ/xCGjYDw+pZdfrLk103MdqH8/vroJbXu4Tb
	 LstKFIZk1XhM/6rxg0AEwrV1ct4lQP6kge0iz98g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231019120356epcas5p1995aa540862c36a48598bcc177b777df~PgKZgM6eJ3087230872epcas5p1t;
	Thu, 19 Oct 2023 12:03:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SB5wV661tz4x9Pv; Thu, 19 Oct
	2023 12:03:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.32.09672.A2B11356; Thu, 19 Oct 2023 21:03:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231019110833epcas5p39702b3bd2c06fdce04e261c2e79f8bdd~PfaDDcegz1682516825epcas5p3t;
	Thu, 19 Oct 2023 11:08:33 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231019110833epsmtrp10bd306eac66f3302c6058a0d2577cd12~PfaDCTmm12693626936epsmtrp1g;
	Thu, 19 Oct 2023 11:08:33 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-98-65311b2a0ea9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.57.07368.13E01356; Thu, 19 Oct 2023 20:08:33 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110830epsmtip16ffe486e013330eff7e42444a5ab9598~PfZ-8_6HU1829018290epsmtip1b;
	Thu, 19 Oct 2023 11:08:30 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 02/12] Add infrastructure for copy offload in block and
 request layer.
Date: Thu, 19 Oct 2023 16:31:30 +0530
Message-Id: <20231019110147.31672-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbVBUZRSe9967yyIDXVCml1URNxkSA3blwxeEcgZzbhEMTWEfNuEOewOG
	ZXfbuxsYQ+4CC4HBLhqYq8hnKKBQQM4iEgxICIViKAhJfLSIhIFCkMRqwe5S/nvO855znuec
	dw4Hd9LZcDnxEgUtlwjFPPYG4lLHTg8vz80Cmt+5/BKq6/kBR48WVwiUpnuCo5oRLRvNdMwD
	ZGzLAqikrIhAQ21NGKqq6cTQ8fYBgCZv6zHUMrwLlWZWEOhKSzeB+i+fYaPiykkbdGzQwEbn
	up5i6I5uEiCDUQ3QpZViHNXOzBHo2vBmdONJF2sfpJr0IzbUjV+/Jaj+XiVVX53NphoqjlL3
	G04BqnlIxabK806wqNz0WTb1aHKYoOa+v82m8hqrAbVQ70rVG//AIh3eTwiOo4UiWu5GS2Kk
	onhJbAgv7K3o0Gj/AL7ASxCI9vDcJMJEOoS3/41IrwPx4tUl8Nw+EYqVq1SkkGF4Pi8Hy6VK
	Be0WJ2UUITxaJhLL/GTejDCRUUpivSW0IkjA5+/2X008nBDXka1jyVTByRUnsggVuMnPAbYc
	SPrBxoEmkAM2cJzIZgC/KDSwLME8gJqJEsISLAF4b6KHWC9RZ/Vbs1oALBwYwS2BBoOm8mos
	B3A4bHIX/PEfzhq/idTgsPXuA7MITpoweHyqnbXWaiP5ARyrPImvYYJ0h7qRAjO2J4NgX0st
	vtYIkj5QO+q4RtuSe+E3x8qsKY6w+5TR7Agnt8H0706bTUCy3BY+fvwLZrG6H7ad1lptb4S/
	dzXaWDAXTmszrTgJVn15nm0pzgBQP6gHlodXoKZHazaBkzth3WUfC70VFvTUYhZhB5i7YrRq
	2UPD2XX8ArxQV8K2YBc48JfaiimYf/IWZtlWHoB9C2ksHXDTPzOQ/pmB9P9LlwC8GrjQMiYx
	lmb8Zb4SOum/f46RJtYD82l4hhnAxNhD73aAcUA7gByct8neneLTTvYi4ZFPabk0Wq4U00w7
	8F9deD7OdY6Rrt6WRBEt8Avk+wUEBPgF+gYIeM/bz2iKRE5krFBBJ9C0jJav12EcW64K07mo
	lPZyuwhe40L8529Of5zn6JBa4DOvSr1i+pmb8p7cVKU+70JdbOwPPbgvKTCsqKhmS8/rxS9m
	p+SOjn51sPJ64Z9+KRLunahio9303+MfujsHlTo5996K2GY3dyjd5Hwk/+J2rVI05hVdX+3h
	Su3uK+8ueLCstr3wzrnlZrV6PGK5tGZxyHQI5p2JEHZm7G3oC7lZYuP6Np3c8Joh3DA7k6rp
	3KLNTO81+GKxUeFfn33YOi6uH/jNd+vV9HfL9gjdPRZ9Q6saOluzrt9N3t+XsuPAq58xnkwa
	q+y5ivsixpioXdred++px5JkcCrf7dpPGRL/jzzCZ3c0HL7qqzUenYriEUycUOCJyxnhv6dR
	HqyjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra1BMYRzG5z3ndPaUKcfW8KpRLMVEtQfDG8nlA4cPbqMo43LUmTJtu2t3
	cx8224iKdjSh+9JOaIlaNV2E2UhJUyyVZiLsVjRqKsZ1d9kaM749/+f3PM+XP4ULHxPe1H6p
	ildIOYmIdCOqGkS+QYwHw4sL1Ay6/bQRRyNffxHolNaGI0NPJokGG0YBsjxMBUh3tYBArx/W
	YOiG4TGGLpg6ALK+ysVQffd8dOW0nkD36psJZK7NJ1FRiVWA0jurSXTtiR1DXVorQNWWZICq
	fhXhqGxwmEBN3T6ozfbEZRVka3J7BGzbm3KCNbcmsRWlZ0nWqD/JDhhzAFv3Wk2yxeezXNhz
	miGSHbF2E+zw/Vcke/5uKWDHKnzZCstnbLNHtFtYLC/Zf5BXhITvdYtvOKt1kavDDuuzUgk1
	eC5OA64UpBfD5FSzSxpwo4R0HYB1rS/ABJgOS2yP8AntCW/Y+wUTIQ0GUxr7/zYoiqTnwxYH
	5fS96EwcDtkuYc4Dp9NweMFhEzjbnnQ0PJV/ZnyVoP2htid7fNWdXgbb68tw5xCkQ2Dm2ylO
	25VeDu+kXx2PCP9GenUfBBPxKbA5x0I4NU77QU1lHq4FdO5/KPc/pANYKZjOy5WJcYkxjJyR
	8oeClVyiMkkaFxwjS6wA458OnFcN3hTZg00Ao4AJQAoXebn7s2Je6B7LHTnKK2R7FEkSXmkC
	PhQhmubOXM6LFdJxnIpP4Hk5r/hHMcrVW40dS89oj2yGppaXkRkLjaPH8kH1etHPjC1+nMpY
	ZCAf3PaXG9pKji9YSqfIPjw1R2IxaGv784Qo9cW5rYx+sqC1b/aK3o1XfETZtV9GoiQWh6Ot
	b3v417GMroDr7yaPfe8V/CSCrKF+Ui5+0mX9oCX4RId3++z6zuHOhPIXvzvKfuy0h92dU76g
	4Og+j9VfbvlaZ8l1moKmaStbys2Cd8kD1jmZxQbP0ggiXiYOXEOXeX88YFy7PPVbWN+MrcPw
	04Goym0zszUR3z+twx2N62uWBPjKwvuGdvmr9NzBmpzdU7s+bipcgmpDsnYsSult4jacDmLe
	q07AwpsBz/ShKRJMRCjjOSYQVyi5P0Gc9qVYAwAA
X-CMS-MailID: 20231019110833epcas5p39702b3bd2c06fdce04e261c2e79f8bdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110833epcas5p39702b3bd2c06fdce04e261c2e79f8bdd
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110833epcas5p39702b3bd2c06fdce04e261c2e79f8bdd@epcas5p3.samsung.com>

We add two new opcode REQ_OP_COPY_SRC, REQ_OP_COPY_DST.
Since copy is a composite operation involving src and dst sectors/lba,
each needs to be represented by a separate bio to make it compatible
with device mapper.
We expect caller to take a plug and send bio with source information,
followed by bio with destination information.
Once the src bio arrives we form a request and wait for destination
bio. Upon arrival of destination we merge these two bio's and send
corresponding request down to device driver.
Merging non copy offload bio is avoided by checking for copy specific
opcodes in merge function.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-core.c          |  7 +++++++
 block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
 block/blk.h               | 16 +++++++++++++++
 block/elevator.h          |  1 +
 include/linux/bio.h       |  6 +-----
 include/linux/blk_types.h | 10 ++++++++++
 6 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..33aadafdb7f9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -121,6 +121,8 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(COPY_SRC),
+	REQ_OP_NAME(COPY_DST),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
 };
@@ -792,6 +794,11 @@ void submit_bio_noacct(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		if (!q->limits.max_copy_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..bcb55ba48107 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,6 +158,20 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
 	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *bio_split_copy(struct bio *bio,
+				  const struct queue_limits *lim,
+				  unsigned int *nsegs)
+{
+	*nsegs = 1;
+	if (bio_sectors(bio) <= lim->max_copy_sectors)
+		return NULL;
+	/*
+	 * We don't support splitting for a copy bio. End it with EIO if
+	 * splitting is required and return an error pointer.
+	 */
+	return ERR_PTR(-EIO);
+}
+
 /*
  * Return the maximum number of sectors from the start of a bio that may be
  * submitted as a single request to a block device. If enough sectors remain,
@@ -366,6 +380,12 @@ struct bio *__bio_split_to_limits(struct bio *bio,
 	case REQ_OP_WRITE_ZEROES:
 		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
 		break;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		split = bio_split_copy(bio, lim, nr_segs);
+		if (IS_ERR(split))
+			return NULL;
+		break;
 	default:
 		split = bio_split_rw(bio, lim, nr_segs, bs,
 				get_max_io_size(bio, lim) << SECTOR_SHIFT);
@@ -922,6 +942,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
+	if (blk_copy_offload_mergable(rq, bio))
+		return true;
+
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
@@ -951,6 +974,8 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
 	if (blk_discard_mergable(rq))
 		return ELEVATOR_DISCARD_MERGE;
+	else if (blk_copy_offload_mergable(rq, bio))
+		return ELEVATOR_COPY_OFFLOAD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
@@ -1053,6 +1078,20 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
 	return BIO_MERGE_FAILED;
 }
 
+static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
+							    struct bio *bio)
+{
+	if (req->__data_len != bio->bi_iter.bi_size)
+		return BIO_MERGE_FAILED;
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->nr_phys_segments++;
+	req->__data_len += bio->bi_iter.bi_size;
+
+	return BIO_MERGE_OK;
+}
+
 static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 						   struct request *rq,
 						   struct bio *bio,
@@ -1073,6 +1112,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 		break;
 	case ELEVATOR_DISCARD_MERGE:
 		return bio_attempt_discard_merge(q, rq, bio);
+	case ELEVATOR_COPY_OFFLOAD_MERGE:
+		return bio_attempt_copy_offload_merge(rq, bio);
 	default:
 		return BIO_MERGE_NONE;
 	}
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..b0c17ad635a5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -159,6 +159,20 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
+/*
+ * Copy offload sends a pair of bio with REQ_OP_COPY_SRC and REQ_OP_COPY_DST
+ * operation by taking a plug.
+ * Initially SRC bio is sent which forms a request and
+ * waits for DST bio to arrive. Once DST bio arrives
+ * we merge it and send request down to driver.
+ */
+static inline bool blk_copy_offload_mergable(struct request *req,
+					     struct bio *bio)
+{
+	return (req_op(req) == REQ_OP_COPY_SRC &&
+		bio_op(bio) == REQ_OP_COPY_DST);
+}
+
 static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 {
 	if (req_op(rq) == REQ_OP_DISCARD)
@@ -300,6 +314,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
 		return true; /* non-trivial splitting decisions */
 	default:
 		break;
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed82..eec442bbf384 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -18,6 +18,7 @@ enum elv_merge {
 	ELEVATOR_FRONT_MERGE	= 1,
 	ELEVATOR_BACK_MERGE	= 2,
 	ELEVATOR_DISCARD_MERGE	= 3,
+	ELEVATOR_COPY_OFFLOAD_MERGE	= 4,
 };
 
 struct blk_mq_alloc_data;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 41d417ee1349..ed746738755a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -53,11 +53,7 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
  */
 static inline bool bio_has_data(struct bio *bio)
 {
-	if (bio &&
-	    bio->bi_iter.bi_size &&
-	    bio_op(bio) != REQ_OP_DISCARD &&
-	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
 		return true;
 
 	return false;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..78624e8f4ab4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -393,6 +393,10 @@ enum req_op {
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
+	/* copy offload dst and src operation */
+	REQ_OP_COPY_SRC		= (__force blk_opf_t)19,
+	REQ_OP_COPY_DST		= (__force blk_opf_t)21,
+
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
@@ -481,6 +485,12 @@ static inline bool op_is_write(blk_opf_t op)
 	return !!(op & (__force blk_opf_t)1);
 }
 
+static inline bool op_is_copy(blk_opf_t op)
+{
+	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
+		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
+}
+
 /*
  * Check if the bio or request is one that needs special treatment in the
  * flush state machine.
-- 
2.35.1.500.gb896f729e2


