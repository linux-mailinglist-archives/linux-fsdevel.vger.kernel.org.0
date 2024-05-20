Return-Path: <linux-fsdevel+bounces-19785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1C8C9C5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A6AB21351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2995FBB3;
	Mon, 20 May 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dGTUL8SA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538056766
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205487; cv=none; b=blXTJ61GcDSDnSsaOogQgAU25qvokzV5iN5+npWJBn3CEg3AFuVV00c2PxdIsQk3jzAH0NfVNoLHEjPN10JaUTeAsrr0IDXme1iCV1BqWXZcv/UJHNnybdd9oUsRagc7c5svGm2fspqCa0AM6J3FCghfLeyNe+xZ1uZUCz2aGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205487; c=relaxed/simple;
	bh=tDW90go0cwdQKfVxfCFMOlHa/JVIItF8C/bqx5wNnLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=OAzIkPDAkpi7JWPS8d0T3YVm5iHT1QQxTTPCJ3WXvI8DQkjhsSKNJWpjlsMU8akrwSQG/cFeYmP9+FtrKxRwSYt5I8yy4VqHljVTJjzvXG+Ge0zVr8DEq7v9NVPzhK2hFYTce8vE4vfiITFK7xqx6hjGHqNfg4twODw/ejZhm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dGTUL8SA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240520114443epoutp03ce3a75ef599c1260d8cd028f8f8e3270~RL8tm4Paq1613216132epoutp03v
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240520114443epoutp03ce3a75ef599c1260d8cd028f8f8e3270~RL8tm4Paq1613216132epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205483;
	bh=WdNRoHumSn7w5xCV6vWF2e9p3PFPIhHw8dbDxe51WtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGTUL8SAv4pKuChohpMYoF8K6ueKbJBgmpfB5gaO+qz6ioQ9ErXBWpPozzuv+JJFE
	 BExOpSu6s2FQE7pcqqt/pMs3vBfsv2RRyn+iIo2VAM2XU4zJM5BmnXAF8d/E4kbRfJ
	 SmmvErZc+7qggGSnwlmpQDB5UFAMexQVlBBvDFWE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114443epcas5p21e69d571d5ffd31eeb5915946f52636d~RL8s-8eDJ2455024550epcas5p2a;
	Mon, 20 May 2024 11:44:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjbMX64nSz4x9Px; Mon, 20 May
	2024 11:44:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.B9.09665.8A73B466; Mon, 20 May 2024 20:44:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240520102842epcas5p4949334c2587a15b8adab2c913daa622f~RK6VX63oy1370113701epcas5p4D;
	Mon, 20 May 2024 10:28:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520102842epsmtrp123a9d33826cf03d228d42e765b92b7cd~RK6VWvDE92026720267epsmtrp1k;
	Mon, 20 May 2024 10:28:42 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-c8-664b37a8b833
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.F6.19234.9D52B466; Mon, 20 May 2024 19:28:41 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102838epsmtip23bacddee0f9b0fe75b4460140bd89c31~RK6RkNFC32248422484epsmtip2h;
	Mon, 20 May 2024 10:28:37 +0000 (GMT)
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
Subject: [PATCH v20 02/12] Add infrastructure for copy offload in block and
 request layer.
Date: Mon, 20 May 2024 15:50:15 +0530
Message-Id: <20240520102033.9361-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1DUVRTH5/5+uz8Wm83fAI13KWRddUYgcFcXuLzKmQh+BhWjThmlyw78
	ZFn21T6SbCYgxHjIU4kgDAJUXkLyfgizLgG5uAEiONDwSGEiyCDKMUKgXRbsv88593zP99xz
	57Jwu2eEIytGoaXVCrGMR+xgNHe7uLhXeIec4Q/fd0N1xl4cfZG9hqPqiSwCLXQvA/TV0gqO
	ZvRfArRqGsBRY+8kQCWlVxhoTN+GoVuluRiqrO7B0Df5SRjq2XhMoFzDKECzI4UY6hx3Q99d
	KGegW513GGi4vYhAxddmbdD1vnUM5aSMYKh1JhGg5tViHNUuLDLQj+Mvo4G1PuaRV6jh+yGU
	sRRSbYUTNtTA5E0GNWzSUfVVqQTVUB5PzTUUAKpjLIGgyjIvMamMpD8Iqi15ikn9OTvOoBa7
	Rggqs7EKUHdLfrAJsw+P9ZfQ4ihazaUVkcqoGEV0AC/kuOgNkacXX+Au8EHePK5CLKcDeIGh
	Ye5BMTLzhnjcT8QynTkVJtZoeAdf81crdVqaK1FqtAE8WhUlUwlVHhqxXKNTRHsoaK2vgM8/
	5GkujIiV/PQkgaka9ItbmyuzSQDF/DRgy4KkEF7KvYilgR0sO7IDwJWGdWANlgFczB5hPA/S
	jUawLTHeXN46aAPQ1Fe7JUnG4OJUs7kZi0WQbrB/g2XJO5DVOExvyNlU4GQDDhO79ZillT35
	Efz7RibDwgxyP0wZmmZamE36wPKrVzGrnTOs/l6PW9iW9IX6pqVNN0iW2cKkiaFNN0gGwpqx
	d6z19nC+r9HGyo7wt6wLW3wWVl6uIKza8wAWPijcus/rMNmYhVv64KQLrGs/aE07wTxj7eYM
	OPkizFid2ZqHDVu/3ea9sKauhLAyB44+TSSs41Dw5xpn61IyABy8Nw+ywe7C/x1KAKgCHFql
	kUfTGk/VYQV99vmzRSrl9WDzG7iGtIKH00seBoCxgAFAFs5zYNc3Hj1jx44Sf3qOVitFap2M
	1hiAp3l/ObjjS5FK8z9SaEUCoQ9f6OXlJfQ57CXg7WIvJF+JsiOjxVo6lqZVtHpbh7FsHROw
	t6ci4kNTNe8KQ+MFn3Nk+5t8bx/1+/XEnqn4oQ+m5V2nbthXd382750rvnagPNUfq5rboz/2
	JC0vOCMymr8aLgraZ+qv4EqwjYK4ghFN0nH93fzguNFgP2m3K+cfKbf+Q5+eRx6Xu9rX73w9
	8IJ00DTIX/IokBo2yiZ1TeyEex+fKPslzllSQRU/hoy63oX5994cv35kbxOV2Yc/zZ/eGejw
	r3TnSuAjzsz5ftmBIhmvyHeX0/hbu1umZ6oS09mmxdvBp+dMD+LFz+Q1ne/3h7W0QKdXpaOO
	zJRjQThz3ynRuYeVER0nf28qyVZQpw0cj6SI/lGXQ9zwkxU5vInAv/KceAyNRCxwxdUa8X9o
	dnqfjwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfyyUcRzHfZ/nueceNvZwrG/YbCfWKLH1xzf6yXa+ptJstWKViydZjtsd
	rbRKzon0+4eKynXOCUl+5EepLpJLDk1qhNrq6kqF22xd3Mmx/nvt/f589n5vb4Z0q6E8mZS0
	DE6WJk4V0k5UU4fQZ+WQX/T+4M/PwlBt90sS5Vywkqh69DyNxjvMABVNWkj0RXcKoBlDH4ka
	X44BpFLfotCQrpVAbepLBKqs7iRQyTUFgTrnftHoUvs7gIyDxQR6MhyI7uRpKNT25BWFBh7d
	pFGp1shHFV02Al3MHyRQy5eTADXNlJLo/vgEhfTDXqjP2sXb6I0H3kbjbjXErcWjfNw3Vkfh
	AUMmrq8qoHGD5gQ2NdwA+PFQNo3Lzl3m4bOK3zRuVX7k4SnjMIUnng7S+FxjFcA9qhf8bYI4
	p7VJXGrKIU62an2C04He6WyetD/ssNVUxs8GpcGngSMD2dWwu85M2dmNbQbwflXYor4Uaq0v
	yEUWwErbN/5p4DR/oyBgrkE1bzAMzQbC13OMXXdnm0k4pSgk7A8k20nC/nvIzgI2DjbP6fl2
	plg/mP/mE8/OzuwaqCkvJxYDfGD1A91CmCMbCnUPJ8FioTVw9P0kfQG4qIBDFfDgpHJJsiRR
	GhIkF0vkmWnJQYnpknqwsGhAbAvQ1lqD2gHBgHYAGVLo7lzfGLXfzTlJfCSLk6XvlWWmcvJ2
	4MVQwiXOvqkFSW5ssjiDO8hxUk723yUYR89sglHCmgGlb+Q60Qrz526y0rvNQWor8z9m+Ohh
	idp8d/mJlO+F2/e1EK3m5yP7toQTu76eD1jVI5r1NNmOb9OV4MikfLQlOGjPslimIv3oj6yi
	qGc7O3LVk+DaCPNz01vDXHD0xYTrj21bE24nxl4pbLvC27DMJ5wa913i3UTWlJpmNYHFu0WW
	lcbcaXWTBahcjONdfyp2/Y266Z+RmDGVWS5KFqD4iB/SCcUOulHiLvKTaJV5dVzgVYUlnvrQ
	McuFxxxT8+g9rp3KOHzdOqJxfXhQn/NIYHaJKD5shTHCX/HMA1OC65kYD22OefrkEWmIS62+
	qMHwabO+N/SqkJIfEIcEkDK5+B8289o3QAMAAA==
X-CMS-MailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

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
index ea44b13af9af..f18ee5f709c0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -122,6 +122,8 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(COPY_SRC),
+	REQ_OP_NAME(COPY_DST),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
 };
@@ -838,6 +840,11 @@ void submit_bio_noacct(struct bio *bio)
 		 * requests.
 		 */
 		fallthrough;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		if (!q->limits.max_copy_sectors)
+			goto not_supported;
+		break;
 	default:
 		goto not_supported;
 	}
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8534c35e0497..f8dc48a03379 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -154,6 +154,20 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
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
@@ -362,6 +376,12 @@ struct bio *__bio_split_to_limits(struct bio *bio,
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
@@ -925,6 +945,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
+	if (blk_copy_offload_mergable(rq, bio))
+		return true;
+
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
@@ -958,6 +981,8 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
 	if (blk_discard_mergable(rq))
 		return ELEVATOR_DISCARD_MERGE;
+	else if (blk_copy_offload_mergable(rq, bio))
+		return ELEVATOR_COPY_OFFLOAD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
@@ -1065,6 +1090,20 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
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
@@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 		break;
 	case ELEVATOR_DISCARD_MERGE:
 		return bio_attempt_discard_merge(q, rq, bio);
+	case ELEVATOR_COPY_OFFLOAD_MERGE:
+		return bio_attempt_copy_offload_merge(rq, bio);
 	default:
 		return BIO_MERGE_NONE;
 	}
diff --git a/block/blk.h b/block/blk.h
index 189bc25beb50..6528a2779b84 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -174,6 +174,20 @@ static inline bool blk_discard_mergable(struct request *req)
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
@@ -323,6 +337,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
 		return true; /* non-trivial splitting decisions */
 	default:
 		break;
diff --git a/block/elevator.h b/block/elevator.h
index e9a050a96e53..c7a45c1f4156 100644
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
index d5379548d684..528ef22dd65b 100644
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
index 781c4500491b..7f692bade271 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -342,6 +342,10 @@ enum req_op {
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
 
+	/* copy offload src and dst operation */
+	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
+	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
+
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
@@ -430,6 +434,12 @@ static inline bool op_is_write(blk_opf_t op)
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
2.17.1


