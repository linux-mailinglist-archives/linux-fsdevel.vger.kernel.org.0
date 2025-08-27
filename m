Return-Path: <linux-fsdevel+bounces-59377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FEB384A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3085462CB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6035E4FE;
	Wed, 27 Aug 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AQ3DhheS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA835CEBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304006; cv=none; b=E76QbTUxlMbDlDBxmp1LqKbHxob2FvO/DJv/JlSiv4UOpoB1ykwCeyq4DZHTHPU9OrjA6fDl+kkUbRlIrMWih4yXE5DLopXaZUkjRaidgo2gWHPL7Z8e/DAGNm9byDe4/CZmwejtTuQJR+eoUlHdAq7jYVIuUY3M/u0EzMMmG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304006; c=relaxed/simple;
	bh=ztFUrDGS4oIWhHKj2g7BksATZ/r2z94jOjeae7uEe5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK+Zno8qHdrZNj2TDo7b8LpSmUx2SJc8j7HsBXrJAZVnWWTQYCa9W+CAV/BvGG3xli0ssVtwCtcDvKBoiJBJB91q+j9wtUMKL3RoeVGRKzl/yghSYYZPXWEMo1M9SOgdSI7QpVavg+Xdj+2YyuGA3hM56lMtjUTVI+inkWe70Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AQ3DhheS; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R8gjBO1314737
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VgiFQn0JDZrB7JSqqWEjsOqNKxIYcImUUTQocry8/qY=; b=AQ3DhheSEccb
	n4HoxRVx7UimogLFIB83eSBWTPVMnpWezjze52bFbcAtuWFusGfrZGPMKsRtyZL6
	NoyEn8AcsNooyHcsdIy6dm0ZPhmJ4jUErRSQzVSeAPmb47/Yrs5MKsy3WzJH9Xys
	mWfailQrxiuoabVdCIAnHT22AgkVqh/DlmzdzaMQwuot1rQa8XQBbA9W2FE+QNYQ
	b2r6ZWEZXE0TOmCLgDaepqoLntZ9eSPpEnkKUpvC8LGzwZNZ7DMV2OJtkLkeX3bZ
	DFycxnIm00EjcFVBf17nZr4fu9vUym1AkwfBAknls4MeN0G4gPH7KPtSfmDdyHaF
	QSj8Zz7H5Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sxrdhpky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:22 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8427110CF615; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/8] block: check for valid bio while splitting
Date: Wed, 27 Aug 2025 07:12:51 -0700
Message-ID: <20250827141258.63501-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PQz7pH_I2qOD7uSBcuj_Lx9cfMLrX2jM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX5gWu+mZn6i2P
 t6oWeXYH1indR3cQQm9YQrcMNBg4gp5KJ98wvRScKmkgF2GJfY3Eah1tpX4UlVAkxtuG7nbPXQ+
 ttgUt5hqtan59y0DZmju7B9J2ujnCTy15Dz8YuJhz25iduSvYzPFqAmv7KjOlq2TvQ1jkMPlU01
 +8EskwreNVbohxRZ+FxQwrFtL151dmc/eiqbQQYJ5I/oHG1QGc/kZz+gtB8h3VOmOpppR9n/zeN
 qZAe++0UupVQr/ZDW1RZfSf5BWauKcIWgbAefkgOx8b8NT7JHGMxcinr7Z+9u7EQQ24tu73hQVH
 i8g2+J+SDDmQ/nOS+nZbgjjZMB3SltH/e2QIe7HUcQXOMQe3E/AEufLnM3AhO8=
X-Authority-Analysis: v=2.4 cv=XuX6OUF9 c=1 sm=1 tr=0 ts=68af1282 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=WM5RNcxwLmg6Fgc_GqUA:9
X-Proofpoint-ORIG-GUID: PQz7pH_I2qOD7uSBcuj_Lx9cfMLrX2jM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're already iterating every segment, so check these for a valid IO
lengths at the same time. Individual segment lengths will not be checked
on passthrough commands. The read/write command segments must be sized
to the dma alignment.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 21 +++++++++++++++++----
 include/linux/bio.h    |  4 ++--
 include/linux/blkdev.h |  7 +++++++
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 23e5d5ebe59ec..6d1268aa82715 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -443,7 +443,7 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	int ret;
=20
 	/* check that the data layout matches the hardware restrictions */
-	ret =3D bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
+	ret =3D bio_split_io_at(bio, lim, &nr_segs, max_bytes, 0);
 	if (ret) {
 		/* if we would have to split the bio, copy instead */
 		if (ret > 0)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..cffc0fe48d8a3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,25 +279,30 @@ static unsigned int bio_split_alignment(struct bio =
*bio,
 }
=20
 /**
- * bio_split_rw_at - check if and where to split a read/write bio
+ * bio_split_io_at - check if and where to split a bio
  * @bio:  [in] bio to be split
  * @lim:  [in] queue limits to split based on
  * @segs: [out] number of segments in the bio with the first half of the=
 sectors
  * @max_bytes: [in] maximum number of bytes per bio
+ * @len_align_mask: [in] length alignment mask for each vector
  *
  * Find out if @bio needs to be split to fit the queue limits in @lim an=
d a
  * maximum size of @max_bytes.  Returns a negative error number if @bio =
can't be
  * split, 0 if the bio doesn't have to be split, or a positive sector of=
fset if
  * @bio needs to be split.
  */
-int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, unsigned max_bytes)
+int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
 {
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
 	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
+		if (bv.bv_offset & lim->dma_alignment ||
+		    bv.bv_len & len_align_mask)
+			return -EINVAL;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -339,8 +344,16 @@ int bio_split_rw_at(struct bio *bio, const struct qu=
eue_limits *lim,
 	 * Individual bvecs might not be logical block aligned. Round down the
 	 * split size so that each bio is properly block size aligned, even if
 	 * we do not use the full hardware limits.
+	 *
+	 * It is possible to submit a bio that can't be split into a valid io:
+	 * there may either be too many discontiguous vectors for the max
+	 * segments limit, or contain virtual boundary gaps without having a
+	 * valid block sized split. A zero byte result means one of those
+	 * conditions occured.
 	 */
 	bytes =3D ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
+	if (!bytes)
+		return -EINVAL;
=20
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
@@ -350,7 +363,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	bio_clear_polled(bio);
 	return bytes >> SECTOR_SHIFT;
 }
-EXPORT_SYMBOL_GPL(bio_split_rw_at);
+EXPORT_SYMBOL_GPL(bio_split_io_at);
=20
 struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim=
,
 		unsigned *nr_segs)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 46ffac5caab78..519a1d59805f8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -322,8 +322,8 @@ static inline void bio_next_folio(struct folio_iter *=
fi, struct bio *bio)
 void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
-int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, unsigned max_bytes);
+int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes, unsigned len_align);
=20
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe1797bbec420..d75c77eb8cb97 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1870,6 +1870,13 @@ bdev_atomic_write_unit_max_bytes(struct block_devi=
ce *bdev)
 	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
 }
=20
+static inline int bio_split_rw_at(struct bio *bio,
+		const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes)
+{
+	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
+}
+
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name =3D { }
=20
 #endif /* _LINUX_BLKDEV_H */
--=20
2.47.3


