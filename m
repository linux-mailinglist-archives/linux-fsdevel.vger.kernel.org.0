Return-Path: <linux-fsdevel+bounces-48245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD1AAC44B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8523B025A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856DC27FB20;
	Tue,  6 May 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YDmWAzAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35D27CCD7
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534860; cv=none; b=t2oQydHfVs3Bhg0SyRkMeX+rKlHKJPFBitVxAXO0YNckThZh+PD0F31lh0N0GU1CqrfEfWeVT+En+PfwDTvOgV3+dkIcj7b2L1eiwIHmUscC2h7MHhuFXmiBT//lOH1R7379Jt8CJr0/5llzH/pX0AM/CDh2mD1h/XrQVZ2fO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534860; c=relaxed/simple;
	bh=u0E28ynjY9VM/X/SWZepqeJNutumReN9HhRNFvhdWps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=gnunFnvsw2UokxHTJigeVs0A0xfmL3twhl562/IlHhDiNrzEeMDH9fWXAnWZ+P6LxU2GA6GlxDuQa3h6vTkRxJiHRH8Rr6x6uLieBJx5RWR64djOnSoVg/sxscS72EFQjNrpzkbXWXdn2pC3z2ZIXjqoa8N7ls+AwMXNWpZkQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YDmWAzAD; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250506122640epoutp01bc2edc8ba23aebb42277e1858dad94aa~878iozqup2804028040epoutp01a
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 12:26:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250506122640epoutp01bc2edc8ba23aebb42277e1858dad94aa~878iozqup2804028040epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534400;
	bh=fly4fygGWFwfsIMnf/ScH10Rni944s+sIuQ7LVjredw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDmWAzADRoPCXnJxuuumwvsXTDs+L+21AlOKDWqa07xO2rzgLitgR5Ss1KL6YxcxH
	 cU4L97Hfl3joR5Y0a7dDLha++tfaqlsGLvF8FziW0X51tJjNLhdsLERio7qdRbp/3y
	 9HT6bxyp9ZYsysJ+yc6A5o5TZN4l6eV7wt7G+UZY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250506122639epcas5p219c65b82fe7e69c96019528c1f5f6291~878h0xslA2629626296epcas5p2R;
	Tue,  6 May 2025 12:26:39 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZsHgx6lJtz6B9m6; Tue,  6 May
	2025 12:26:37 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385~878fWuxOq1362913629epcas5p4_;
	Tue,  6 May 2025 12:26:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250506122637epsmtrp186cfaa2c3dae78c6472bb0d199297e3a~878fWA97k2524025240epsmtrp1g;
	Tue,  6 May 2025 12:26:37 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-da-6819fffca100
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.E5.07818.CFFF9186; Tue,  6 May 2025 21:26:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122635epsmtip243ccc0d442cd051d968e2a46b1cf7711~878duJM1c1663216632epsmtip2K;
	Tue,  6 May 2025 12:26:35 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 02/11] block: add a bi_write_stream field
Date: Tue,  6 May 2025 17:47:23 +0530
Message-Id: <20250506121732.8211-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO6f/5IZBs8nWVrMWbWN0WL13X42
	iz2LJjFZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYs9e0+yWMxf9pTdYtvv+cwO3B47Z91l
	97h8ttRj06pONo/NS+o9dt9sYPPo27KK0WPz6WqPz5vkAjiiuGxSUnMyy1KL9O0SuDJWHN3L
	WjBdsmLatkvsDYytol2MnBwSAiYSJxafZOti5OIQEtjNKLHz/CJmiIS4RPO1H+wQtrDEyn/P
	2SGKPjJKTH1xkLGLkYODTUBT4sLkUpAaEYEAiZeLHzOD1DALfGCU2DNxNiNIQljAVuL83sVg
	NouAqsSP29/BFvAKmEu8PHMCaoG8xMxL38FsTgELieV7ZoHVCwHVvDh6hB2iXlDi5MwnLCA2
	M1B989bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4KrQ0
	djC++9akf4iRiYPxEKMEB7OSCO/9+5IZQrwpiZVVqUX58UWlOanFhxilOViUxHlXGkakCwmk
	J5akZqemFqQWwWSZODilGpiilJf/mRVz4KHm/ucZi6ZP/jzlKWO9pHVxVI7vT+3N55+t4bRY
	pCKz/tRB48peh22Rc2M/L9bL6z2lviup/4NW8OcFj2O2MgrbPn+ve+CW8SnOzE1BD+4YtDhc
	0VfbtjzQ1O/yaiWzZK4IRsdjSn8evPmV/cj4hetLM7HiaoU+dbbt8Q/PVftEKTyXObLhxvpp
	1zYUJ71yEzbICT538uud8vI1G6cnlhxasen+jPNlr/PKG74tFxDlMrjOm+xSO8VUmlPYWzaw
	OzBU8HnPPOGDzRIVhUUPjWzynHuMt1fvmpc57ZxzPNcS+d5UhfY3Nzy17eVCjCt61rfHeEXX
	rNW9e7hm+paPZ2/y9mU911NiKc5INNRiLipOBACAq8Hq+QIAAA==
X-CMS-MailID: 20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122637epcas5p4a4e84171a1c6fa4ce0f01b6783fa2385@epcas5p4.samsung.com>

From: Christoph Hellwig <hch@lst.de>

Add the ability to pass a write stream for placement control in the bio.
The new field fits in an existing hole, so does not change the size of
the struct.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 4 ++++
 include/linux/blk_types.h   | 1 +
 4 files changed, 8 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 4e6c85a33d74..1e42aefc7377 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
 	bio->bi_write_hint = 0;
+	bio->bi_write_stream = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -827,6 +828,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
+	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index f154be0b575a..005c9157ffb3 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -173,6 +173,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
+	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fdd4efb54c6c..782308b73b53 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -832,6 +832,8 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	if (req->bio->bi_write_hint != next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream != next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio != next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -953,6 +955,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 		return false;
 	if (rq->bio->bi_write_hint != bio->bi_write_hint)
 		return false;
+	if (rq->bio->bi_write_stream != bio->bi_write_stream)
+		return false;
 	if (rq->bio->bi_ioprio != bio->bi_ioprio)
 		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5a46067e85b1..f38425338c3f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,6 +220,7 @@ struct bio {
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
 	enum rw_hint		bi_write_hint;
+	u8			bi_write_stream;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 
-- 
2.25.1


