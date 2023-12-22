Return-Path: <linux-fsdevel+bounces-6772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7481C599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E151F25C88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE61803C;
	Fri, 22 Dec 2023 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="phC5LFnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0511171D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231222073158epoutp0227c84869e3ae50a4f9d4edab2ac7fb2a~jFvNB9U6G1674116741epoutp02E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231222073158epoutp0227c84869e3ae50a4f9d4edab2ac7fb2a~jFvNB9U6G1674116741epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230318;
	bh=zNOpXkz6e9K4rFrmmQNgX1f5/CjWsYrydMLP3nTXSzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phC5LFnUhaYBtBLfoaA92T9OVJdUd8/M5ylcTrjUzn620b5adR5b+qTX9qAd72zom
	 /tdo8Ah7uVci5ca9oHben0r41djzySP0+daH/gj8VI5Vv6Tzh++1bdswcFikr1Opcw
	 acaTfpXVDhVq/helfZEWh9dtZR+h2PICUilyFSRI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231222073157epcas5p34cf86fc659d43f490607f3bc1d3b26ce~jFvMhFlNH0585105851epcas5p3V;
	Fri, 22 Dec 2023 07:31:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SxJs76bj4z4x9Q0; Fri, 22 Dec
	2023 07:31:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.37.10009.B6B35856; Fri, 22 Dec 2023 16:31:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231222062105epcas5p1c21613f0c44451d579ae4cd24003cca2~jExUqR4Ov1748217482epcas5p19;
	Fri, 22 Dec 2023 06:21:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231222062105epsmtrp23d848ed4420c0c59a8032b1b8568ec1d~jExUpUc2E1647616476epsmtrp2S;
	Fri, 22 Dec 2023 06:21:05 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-e4-65853b6b8346
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.93.08755.1DA25856; Fri, 22 Dec 2023 15:21:05 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062102epsmtip2e916b9b662132bc0cb3cccba89ce6c13~jExRPlMhy0303903039epsmtip2W;
	Fri, 22 Dec 2023 06:21:01 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
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
Subject: [PATCH v19 02/12] Add infrastructure for copy offload in block and
 request layer.
Date: Fri, 22 Dec 2023 11:42:56 +0530
Message-Id: <20231222061313.12260-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRz39zzPHjYTewSKHxA2V5mIwEawfryJV0aPRScd3VUKBwsegQO2
	tReU6gpS4kXkZQLGcIwXzUBkCUSADmlUxHt3wNAlKXebehCKcGJCVFuD8r/P9/v9fL6v92Xj
	Ticd3NkpYgUjE4vSeORGor3Xa4dPakgOw7dc90e6gZ9wdP/BCoE+L1nF0fmpYhLN9i4AZO7J
	BaimTkOgaz2dGGo4/yOGVAYjQJYJNYb0Jm9U+8UZAl3W9xNorOs0ibRfWRzQ8ckOEp3r+wtD
	V0ssAJXmTWCow5wNUPuKFkfNs/cI9LPJA42u9rH2uNGd6ikHevS3iwQ9NqykWxrzSbr1zGf0
	ndZKQF+6lkXS9UUnWfSJo3dJ+r7FRND3uidIuqitEdCLLVvpFvMcFrX5QGpoMiNKZGRcRpwg
	SUwRJ4Xx3oyOezUuUMgX+AiC0Ms8rliUzoTx9kZG+USkpFk3weNmiNKUVleUSC7n+e0OlUmU
	CoabLJErwniMNDFNGiD1lYvS5Upxkq+YUQQL+Hz/QCsxPjW5v+oXUroccqSifZWVBQb4BYDD
	hlQArB05BQrARrYTdQnA4dkKB7uxAODvXVmkjeVELQF49frr64oqVR1pJ+kBHLqhZ9mNHAwu
	nbtjlbPZJOUNB/9m2wQuVBMOOy8KbByc+hODqtsGli3gTMXA/i+XMBsmqBfg0GA1sGFHKhiO
	Nv9B2PJAyg8W39hic3OoEHh7uZ5lp2yB/ZVmwoZx6ll49Nsq3JYfUjoOLFusJe2d7oULx+pY
	duwMZ/raHOzYHS7e1a9xDsOGsq9Ju/gYgOpJNbAHwmHOQDFuawKnvKCuy8/u9oTlA82YvfBm
	eGLFjNn9jrCjeh0/B5t0NWv53aDxYfYapmGu7sLa5ooAbCnvxUoAV/3YQOrHBlL/X7oG4I3A
	jZHK05MYeaDUX8wc/u/KCZL0FvDvd+x8owNM35z3NQCMDQwAsnGei6Nk1zHGyTFRlPkRI5PE
	yZRpjNwAAq0LL8Xdn0qQWN9LrIgTBATxA4RCYUDQS0IBz9VxNkeT6EQliRRMKsNIGdm6DmNz
	3LOw7O1NjaeMU6uzm0yuw1UztzThmg9Nvbvf22+4+e73WtXxdz6dlL74liWggcmIC35bzC8Q
	YvsiDCtdi/GFVaf7tvXFKmPPikYGqz+xnny/j/n5psKg8SMfdA1qvV+BzPx2Syh4xF5RzYzv
	UJSPR8rL8gX95Zndhz6u/W7fwbYHA8qtxDaj0f1sYfT0wQ1t3Ysd3dFFS5wDjyos6c9EVqpc
	hEz8kx4/cNp/1Y/tCiqltHM6hScWn/9Ebs8cMx8TY3yt1SfaJXdTpPTCXNPTGhn0TOKGHlIS
	GqHJ8I02JNkrInYkz7leNxQzfTmvsmDZIyU4/kr48oTHrUzD+xkPN7heGeQR8mSRYCcuk4v+
	AaEHZsSmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+845Oztaq+MU/DRIGESpZS2FvjTMKOqUlEEoEUUe2ski59bm
	uhjVykuppbZuOKt5XTpLaTOv2cXKtSy0zNJ1M9qaJFmrFt2mdZKg/37v8zzvywMvhYttRDC1
	LS2dU6WxqRLSl2i8JQmZ/TAsm5t78uw0VH+vE0duz08CHSry4qj2RSGJhm99Ashx4zBApeXn
	CDRwowVDNbV3MKTreAKQs0+PoXZ7OCrLqSTQ1XYbgXpbz5LIYHQKUf7TZhJdsI5iqL/ICdDx
	I30YanYcBKjxpwFHdcMfCHTXPhV1e62CuCCmRf9CyHS/vEwwvQ80jNmUSzKWygPMkKUYMG0D
	WpKpKDghYI5ljpCM22knmA/X+kimoMEEmM/maYzZ8R5bM3m970IZl7ptJ6eaE5vsu9VW0kMq
	f8TsPt3oFWjBvbl5wIeCdBQs0ZWTPIvpNgCzPbJxPQgavbfxcfaHNaMuYR7w/ZPJxODQwVKQ
	ByiKpMNh1xjF6wF0Mw6/X8rE+AGn83CoG/MK+W1/ej18ZegU8EzQ0+H9rvOAZxEdDbvrvhH8
	IUjPgYWv/HjZh46Brh8VgvFC0dDmspDjcT9oK3YQPON0CMy8UoIXAVr/n6X/zyoFmAkEcUq1
	PEWuliqladyuCDUrV2vSUiI2K+Rm8PfbYaHNoMn0MaIDYBToAJDCJQEixawsTiySsXsyOJVi
	k0qTyqk7wFSKkASKAoeOycR0CpvObec4Jaf652KUT7AWa7GHaU+J31ZXmaUtCZPMS+YbWjeL
	do60DV0LeGRJr83a4ro46fZykz7fc/Nx7FKB99ODRe++HrevTXEHi+Kt4g1PK458iTrjvr67
	rHHVSO6v9ndvx06WdykOtcqTwBbTMm1rZM7hR/pQH1cyNb0HhLtDWVVu3+vooKPxLzX1E/cP
	S6zsknU5GYGF0voZkbEr+z8LCyjo78jtn4LvwxITZsYpU2can+0Q+nUnJtWtWfDcEGesJiUN
	8+veLMe2s9mKvfmnDU2KhsH4mgk9iijT0ox12QkbKj0fB1c7NU03z3t6jKOjxaJvMpdqhW7e
	ypDF+5ObNjreD0ysGq5+4tJZLRJCvZWVhuEqNfsbD7KTz1wDAAA=
X-CMS-MailID: 20231222062105epcas5p1c21613f0c44451d579ae4cd24003cca2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062105epcas5p1c21613f0c44451d579ae4cd24003cca2
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062105epcas5p1c21613f0c44451d579ae4cd24003cca2@epcas5p1.samsung.com>

We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
Since copy is a composite operation involving src and dst sectors/lba,
each needs to be represented by a separate bio to make it compatible
with device mapper.
We expect caller to take a plug and send bio with destination information,
followed by bio with source information.
Once the dst bio arrives we form a request and wait for source
bio. Upon arrival of source bio we merge these two bio's and send
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
index 08a358bc0919..3d51d7827abb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -159,6 +159,20 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
+/*
+ * Copy offload sends a pair of bio with REQ_OP_COPY_DST and REQ_OP_COPY_SRC
+ * operation by taking a plug.
+ * Initially DST bio is sent which forms a request and
+ * waits for SRC bio to arrive. Once SRC bio arrives
+ * we merge it and send request down to driver.
+ */
+static inline bool blk_copy_offload_mergable(struct request *req,
+					     struct bio *bio)
+{
+	return (req_op(req) == REQ_OP_COPY_DST &&
+		bio_op(bio) == REQ_OP_COPY_SRC);
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
index b29ebd53417d..344dd3740a87 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -395,6 +395,10 @@ enum req_op {
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
+	/* copy offload src and dst operation */
+	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
+	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
+
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
@@ -483,6 +487,12 @@ static inline bool op_is_write(blk_opf_t op)
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


