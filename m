Return-Path: <linux-fsdevel+bounces-58329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C0B2CA74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43FC5A5A09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9863043BF;
	Tue, 19 Aug 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dcA/iNQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B22FFDD5
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624116; cv=none; b=G8pFO2EiqlG3JDSIHIkeRIZ8ALGV0s4/fOVSDphKnRXu9b9OfIGWjqZ2lyQAx+5H/88ZAN/U53kv9cW/hQ5IKCPID9rUGn4QN6W42viW+teSmBKnGCw28/FnZPQe6VXxouqNpQkYNp+jgBrCApg2ST3KWqnWgMB8R7l2uu79qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624116; c=relaxed/simple;
	bh=vB0ZG267R0NyTRc2QS1tHZFpVPoHaE7Vlm+mOfkQxVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEkx1FhJWXoAeHGml/y3kGHsyQJuPZoekdDalaK1Wev4ih/d9w7UP1z2OLWxgrK+aH5zvBLctxnRqKI0JI7eJ4p9EXH/lG3FBfYgWolcIUoJLaGRr5IIBk98h5tfByFn5KxQTmpBmZ4mK6LRpsEbkCg3mr/M9JEZML8hjz5d+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dcA/iNQD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 57JBIiUD1315105
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:21:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=sGp/p9jk90pYDb17/CjeF47J1rgWxBOpo8km4Xf67Vo=; b=dcA/iNQDA+xk
	Me9ti1zLmxXppSQoZvlx7Gxda37p0I5ZrKEHMW4a9E2jA16+cvqPeU4Pu22hjb2X
	pzDEs//5xhYlwW9sn855cAFPx6t+HjJP/IyhWY8asInWkJDIJ0JcrgLTrOPP3VP/
	xz+MTH3BAL3I0KUNMG1Hl0BzUSu/uTDGCh2oM6unaD3QvBt0XI15Mucj+F/t3sri
	jTmLgnqY5h2puwQswNWRJdUCjsE7bdXhzzsFkErdUvXFKNtN1D0oy46FVTiIl+8g
	Zazawwrj/X2OW9spyJPmS/TgJ9vlG5Wt9DCnyQbPG9SYLmHSluRDWAHwfrNu+9Wo
	/ohOAq/KSQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48mr1su22w-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:21:54 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:21:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 68C36C89F1C; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/8] block: check for valid bio while splitting
Date: Tue, 19 Aug 2025 09:49:15 -0700
Message-ID: <20250819164922.640964-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: P-50lskbaRSxQgX61LmioIUgCaMqujX8
X-Proofpoint-ORIG-GUID: P-50lskbaRSxQgX61LmioIUgCaMqujX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MSBTYWx0ZWRfX3ZJISgBVQvfL
 iUT4JRt/oSd+GV2w+xBWwueYTSiU040F15XNTSn1OK4Y+JV5X3MzlO4AkzHL0Mqo2QrqZOVxQuq
 mFV4kjbWQI16CD3xIrGAlir1Oer/ZP6R5zpoGVyJ/ILxr2Ux6/XONfLCmOwAaj8LfwDrnnVjr+c
 oP0C5JncqnVrid17d2/2BAYSCuy8ISZR99R5sjcxEDP0uuz2PPlP8OoUhZE/8exZy2ohfJQM4qO
 kdIxxVgQI6YKCIqRPexUqvZs6Tbi4AVIHjTYCHlHVpFR/mpHuwfWM3EagjioA0EHgY81hqb7EhW
 64jM1bMCeHEXc4v7Rpqz2h/FNarqMYAAKtu9C6pBRvEU9S8onWDzROHbCIh4YCJeWP8UP9bX3AA
 qqh6Mf9iHZ/XyhAsADeAczdAsAhYtYzOXHPSR11PYHEhHaNfSKGnKnD8M8SvYXuexbukBQPo
X-Authority-Analysis: v=2.4 cv=eOYTjGp1 c=1 sm=1 tr=0 ts=68a4b2b2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=WM5RNcxwLmg6Fgc_GqUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're already iterating every segment, so check these for a valid IO at
the same time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 20 ++++++++++++++++----
 include/linux/bio.h    |  4 ++--
 include/linux/blkdev.h | 13 +++++++++++++
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 23e5d5ebe59ec..c5da9d37deee9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -443,7 +443,7 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	int ret;
=20
 	/* check that the data layout matches the hardware restrictions */
-	ret =3D bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
+	ret =3D bio_split_drv_at(bio, lim, &nr_segs, max_bytes);
 	if (ret) {
 		/* if we would have to split the bio, copy instead */
 		if (ret > 0)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..a0d8364983000 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,25 +279,29 @@ static unsigned int bio_split_alignment(struct bio =
*bio,
 }
=20
 /**
- * bio_split_rw_at - check if and where to split a read/write bio
+ * bio_split_io_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
  * @lim:  [in] queue limits to split based on
  * @segs: [out] number of segments in the bio with the first half of the=
 sectors
  * @max_bytes: [in] maximum number of bytes per bio
+ * @len_align: [in] length alignment for each vector
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
+		unsigned *segs, unsigned max_bytes, unsigned len_align)
 {
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
 	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
+		if (bv.bv_offset & lim->dma_alignment || bv.bv_len & len_align)
+			return -EINVAL;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -339,8 +343,16 @@ int bio_split_rw_at(struct bio *bio, const struct qu=
eue_limits *lim,
 	 * Individual bvecs might not be logical block aligned. Round down the
 	 * split size so that each bio is properly block size aligned, even if
 	 * we do not use the full hardware limits.
+	 *
+	 * Misuse may submit a bio that can't be split into a valid io. There
+	 * may either be too many discontiguous vectors for the max segments
+	 * limit, or contain virtual boundary gaps without having a valid block
+	 * sized split. Catch that condition by checking for a zero byte
+	 * result.
 	 */
 	bytes =3D ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
+	if (!bytes)
+		return -EINVAL;
=20
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
@@ -350,7 +362,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
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
index 95886b404b16b..7f83ad2df5425 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1869,6 +1869,19 @@ bdev_atomic_write_unit_max_bytes(struct block_devi=
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
+static inline int bio_split_drv_at(struct bio *bio,
+		const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes)
+{
+	return bio_split_io_at(bio, lim, segs, max_bytes, 0);
+}
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name =3D { }
=20
 #endif /* _LINUX_BLKDEV_H */
--=20
2.47.3


