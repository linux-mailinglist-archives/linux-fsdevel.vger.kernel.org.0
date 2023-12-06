Return-Path: <linux-fsdevel+bounces-4968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F8806C1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9B1C208DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC62DF84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OoT/jEVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F77D50
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:10:55 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206101053epoutp04e19bcbac99c8ebc8757be072da8100dc~eNlZKdMPo1299912999epoutp04c
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:10:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206101053epoutp04e19bcbac99c8ebc8757be072da8100dc~eNlZKdMPo1299912999epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857453;
	bh=Ht/Do8cTuJq3u2yJt3wmG4hHCRAbWvK0/GxdjTa0bnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoT/jEVES07IzsqBprqRYW4rnbTfG+Rec80k5makyHcuCWU/kNE+Lswx5CZ5W6S8p
	 iEg3LitIwj6qXGbDl+RHyzzy8sXDvRsQjUS9KAj/62faUujzAeziGrbP/GKHsUyJH6
	 /RIMzV1VgjMjJHEcyV1ubELKTxsdgj7+yoepFCUE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231206101052epcas5p1f74433f38c2c0a95c3448556d538f621~eNlYlyY1U0449604496epcas5p1D;
	Wed,  6 Dec 2023 10:10:52 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SlY7v0xjCz4x9Px; Wed,  6 Dec
	2023 10:10:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.58.19369.AA840756; Wed,  6 Dec 2023 19:10:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7~eNlWbwK8W3161231612epcas5p2p;
	Wed,  6 Dec 2023 10:10:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101050epsmtrp11528effcadae6126b68eea06fd58e0ac~eNlWagLGu1050310503epsmtrp1J;
	Wed,  6 Dec 2023 10:10:50 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-26-657048aacece
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.7B.08755.AA840756; Wed,  6 Dec 2023 19:10:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101046epsmtip29bbd9da58b30c5b273ec0cbf08b87c0b~eNlSljNQa1163811638epsmtip2B;
	Wed,  6 Dec 2023 10:10:46 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 02/12] Add infrastructure for copy offload in block and
 request layer.
Date: Wed,  6 Dec 2023 15:32:34 +0530
Message-Id: <20231206100253.13100-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59x7ubsQ0G0xPG4ksEGGBu7Gw4PxDEbvRM3g1PQgGNxZ7iwb
	y+6yDytjRmJzA+TlMhm7xCwaSkCJvB+CQ7shaSUoIoIjjbooBOSAihIi7bJb+d/n9zvf3/md
	7+/Mj41zdCwuWyJTM0qZUMoj3YgOS9CW4AZawfCXjuxETefP4mjhwQqB8stXcdR4vYxEs5ZF
	gKz9XwFUc6yaQOP93RiqbxzAkN58BaCpUSOG+ia2oaO6WgL19p0j0EjPtyQynZhioUNjXSSq
	G3yCoavlUwAdLhjFUJf1C4A6Vkw4Ojl7l0C/TLyAhlYHXeI20d3G6yx6aLKZoEd+19AtDYUk
	3Vp7gJ5uNQD69HgeSX9XWuFCl2j/IumFqQmCvntmlKRL2xoAfa9lM91inceSPVOyojIZYQaj
	9GNkInmGRCaO5iW9k56QHh7BFwQLItEOnp9MmM1E8xLfSg7eJZHaJsHz2yeUamypZKFKxdse
	E6WUa9SMX6ZcpY7mMYoMqSJMEaISZqs0MnGIjFHvFPD5r4XbhHuzMn9urWIpmqI+XVi7gOWB
	ZX4RcGVDKgyWVlZjduZQvQBqa1OKgJuNFwH82zRCOIIlADtOzNgC9nrF7MABR74PwMmvzzhF
	9wDU/9ZG2kUkFQSHKzT2WzdQP+Cwu1lg1+DUYwzq75hd7AdeVCr89VAry84EFQh/HKxfZw8K
	QeOVdtLxPF9ouPRwPe9KRcKKO8dwh+Y5eM5gJeyM2zTa9irc3gBSja5wrqsYdxQnQkttHcvB
	XvDPwTYnc+FMmc7JInjJcAFzsBre6v3JybHw4Pky3G4Gt5lp6tnu6OUJS1asmGMQHrBAx3Go
	/eGkfsrFwRvhjcpaJ9OwpvAb53yKAXxgLQblwNf4lAXjUxaM/3erAXgD4DIKVbaYEYUrBMEy
	5pP/PlYkz24B6wuxNbkLNJ5aDTEDjA3MALJx3gYP6ZCc4XhkCD/bzyjl6UqNlFGZQbhtyIdx
	7vMiuW2jZOp0QVgkPywiIiIsMjRCwNvoMXuwOoNDiYVqJothFIzy3zqM7crNw+L3sjgvJ/3R
	7aZ/RuSXcnJpaTihxV807XVR2jZjmE+t21OQX2JejX+zWrrWzV3stbzvHeBTyNwam/g8f9l9
	AeceFy27C1DU7eKj2Tr/7989ez/OLY3X81D70fzwq6H6t3dcCw36YKDoSXxOJdYem7w6/ciU
	2wbTJK8wJo0k16fZNw16zpkSxQEmoWugf+IjdYK65n7h5qX63hwdy+z+xuVpZtP+L8cvx5zy
	h7vXHse+tIttCfw4r31hUTsU0/nhs3FjRZKh/NSkG4bjaKIz8aI2P1ff7G1pfy+2R3xk99w+
	Ive2+5bXq19MuNrp7XOz6vS2hj09AdjAzfQc32v9fQFRfTxClSkUbMWVKuE/TyWjmJkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvO4qj4JUg8uXRCzWnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFytVHmSwmHbrGaPH06iwmi723tC0W
	ti1hsdiz9ySLxeVdc9gs5i97ym7RfX0Hm8Xy4/+YLG5MeMpoMbHjKpPFjieNjBbbfs9ntlj3
	+j2LxYlb0hbn/x5ndZD02DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwOaxuG8y
	q0dv8zs2j49Pb7F4vN93lc2jb8sqRo/Pm+Q8Nj15yxTAF8Vlk5Kak1mWWqRvl8CVcWTzbPaC
	9TYVH/+fY2pg/GnQxcjBISFgIvH6aH0XIxeHkMBuRokrD7azdTFyAsXFJZqv/WCHsIUlVv57
	zg5R9JFRYuWSZnaQZjYBTYkLk0tB4iICO5glfq5tZgJxmAW6mCUm/f8L1i0sECXxoXUlI4jN
	IqAqsfb4SrA4r4CFxKxrW6G2yUvMvPQdLM4pYCkx+fkiZhBbCKhmX+N0Foh6QYmTM5+A2cxA
	9c1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4OjW0tzB
	uH3VB71DjEwcjIcYJTiYlUR4c87npwrxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5Y
	kpqdmlqQWgSTZeLglGpgWnBb5h7rruOn1N+e+FfScvDaq1SrOqG8A1OlPwbtS10/l7FEgmOK
	xROnGZ8EJdPP3eOedtuLV+CpcumDOZ0ze+YmZig+kmHLT3ibJrsy4myZ5/Ndrod1Hp+Pbpz0
	5/EToyv9G/oEbsX0i1YXhZ3T//ny463jX3Lnbnq3ZVVf3vHlZ39qeYh++jaJ7WLz7Lse+osN
	zBUDVsfI8pfYPRdrTzZgcExqSonRZGp8nu/btL6ib//RsBAZ8ZDJEXP2p01aemEWTyGTopUd
	11aGKY2bLhi8YGZV2vpTjTP0Zlrm04/TZ3PNPmDRv39rRMCrlNl5YUuX7PaPm//HmJUr+dCv
	TuuTXBarzmw+G8Odv2/rRCWW4oxEQy3mouJEAHH4sytdAwAA
X-CMS-MailID: 20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 2eca76ccf4ee..51c6cc3022f4 100644
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
@@ -800,6 +802,11 @@ void submit_bio_noacct(struct bio *bio)
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
index ec4db73e5f4e..5816e41588af 100644
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
index 7c2316c91cbd..bd821eaa7a02 100644
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


