Return-Path: <linux-fsdevel+bounces-59376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34827B384AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DA1BA79CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39535E4F8;
	Wed, 27 Aug 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sI/abBz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946E35A2AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304004; cv=none; b=OPD3svx99r9Yn9S6gPatY9dv39LhdR+E8ZJlblQNudw/TyADLTpA3xZpM3bpKGdQ5ywF2bNXyORNG7V1BO3TA5FyYgFpfqcuc7OWiG5bhD5AeLfoVX/9b4UVAe8r61X/phUMB/ibgHK+ct7nZs7lhw3fU5SE9c916pVkHoTXIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304004; c=relaxed/simple;
	bh=tkwtZpHJ7yEDJENTuLH2IzGsPCiERUNgWXMyN+Mq3bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PY3SC75BwoaXcAlxW8UjEvOTpQ6gL3uywkuxCtemcrOSq8DQlgH+fAnIxRF5WBrabInCVV7FDoecEzF9/Q6Xp0VRNxFb362MjMF5bcdOpOFak5yC8HdgGUCrAP4hSfn6wy+znFEGlzAorY4e8KrKYDF5ESwv6faq8OoXJPyzoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sI/abBz/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R7Rmvf1297717
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fO99FmkBQeL0rszyIdRwBSoKXWkuo21MiNsJwXg2csM=; b=sI/abBz/zDab
	3wlASAgv1VG5i/wCbCwbTZ6H+yRvkHZz3LmW5pEex3gh3BdMWX97urFnyoWF2YQS
	dPrTbtcLJkqCumGnanEdhxz1hZdMt0XFdsAbnhL2Mo7ay68PKCvBWMGc5Yup3VLh
	EX2iVPkDGb06m+CVEr1/ERgJcx6Bj7+QQNEhSIZQmQqcTP3UpUCIdd8ZgtuAI07v
	8rzZaASgvnSx0TQxC3btqO10suCvGa0SB9Tee8d1fV8Hq9wXmPuXNaCA5XWcP3Od
	Vhz4ywgAymzrbvxCMhKkoJiPPYRNAtoFPj8vNqT1cLIHQfKk6VMfvIo6hTgS/G8c
	GIC/HhVglA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48swmva0c4-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:21 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A553210CF61D; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 3/8] block: align the bio after building it
Date: Wed, 27 Aug 2025 07:12:53 -0700
Message-ID: <20250827141258.63501-4-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX0Q7L+d3bsYtj
 ZNHTcoO79ZlOjHACDxdacvqJyRYHd95TL/+4Kt6AWNxi1dxtL80T1xOcPkHIhOWofaFFBhyXst2
 wUVK+WZ+5+H+0jNEH7wkMQ6KQV+77AoaA2ktNNmPHas2y7YwOGVIoYRny4TaGghoxWfDUvPWP/r
 7DYb6XLHMUEsCyJXd1UAVZgxJ1AelkkAg+i2cyFZf8I4OEySsZIOGzzS9YJLucTiBU645CcnrAb
 r/63CqCArORi6P9y0wVAoaGSlYuluzOwgakfHzBtDsIU147oN2bvOrdvX/eu3p911Xq+APkDQdK
 uo1qKr21fb+SRZPg9KGKc/oaN/9inWiBivnNybee2VoVRlI0gTqthnAKjjBvgs=
X-Proofpoint-ORIG-GUID: OEltBve5S9PMAyibyrG4ZUusZj9568nk
X-Authority-Analysis: v=2.4 cv=NKnV+16g c=1 sm=1 tr=0 ts=68af1281 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=YLIuIqOInwJuuOtFGpUA:9
X-Proofpoint-GUID: OEltBve5S9PMAyibyrG4ZUusZj9568nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Instead of ensuring each vector is block size aligned while constructing
the bio, just ensure the entire size is aligned after it's built. This
makes getting bio pages more flexible to accepting device valid io
vectors that would otherwise get rejected by alignment checks.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 65 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44286db14355f..8703be4748db8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,8 +1204,7 @@ static unsigned int get_contig_folio_len(unsigned i=
nt *num_pages,
  * For a multi-segment *iter, this function only adds pages from the nex=
t
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er,
-				    unsigned len_align_mask)
+static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er)
 {
 	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
@@ -1214,7 +1213,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter,
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size;
 	unsigned int num_pages, i =3D 0;
-	size_t offset, folio_offset, left, len, trim;
+	size_t offset, folio_offset, left, len;
 	int ret =3D 0;
=20
 	/*
@@ -1228,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter,
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |=3D ITER_ALLOW_P2PDMA;
=20
-	/*
-	 * Each segment in the iov is required to be a block size multiple.
-	 * However, we may not be able to get the entire segment if it spans
-	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
-	 * result to ensure the bio's total size is correct. The remainder of
-	 * the iov data will be picked up in the next bio iteration.
-	 */
 	size =3D iov_iter_extract_pages(iter, &pages,
 				      UINT_MAX - bio->bi_iter.bi_size,
 				      nr_pages, extraction_flags, &offset);
@@ -1242,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter,
 		return size ? size : -EFAULT;
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
-
-	trim =3D size & len_align_mask;
-	if (trim) {
-		iov_iter_revert(iter, trim);
-		size -=3D trim;
-	}
-
-	if (unlikely(!size)) {
-		ret =3D -EFAULT;
-		goto out;
-	}
-
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i +=3D num_pages)=
 {
 		struct page *page =3D pages[i];
 		struct folio *folio =3D page_folio(page);
@@ -1298,11 +1278,44 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter,
 	return ret;
 }
=20
+/*
+ * Aligns the bio size to the len_align_mask, releasing excessive bio ve=
cs that
+ * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed l=
ength
+ * for the next iteration.
+ */
+static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *ite=
r,
+			    unsigned len_align_mask)
+{
+	size_t nbytes =3D bio->bi_iter.bi_size & len_align_mask;
+
+	if (!nbytes)
+		return 0;
+
+	iov_iter_revert(iter, nbytes);
+	bio->bi_iter.bi_size -=3D nbytes;
+	do {
+		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (nbytes < bv->bv_len) {
+			bv->bv_len -=3D nbytes;
+			break;
+		}
+
+		bio_release_page(bio, bv->bv_page);
+		bio->bi_vcnt--;
+		nbytes -=3D bv->bv_len;
+	} while (nbytes);
+
+	if (!bio->bi_vcnt)
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages_aligned - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
- * @len_align_mask: the mask to align each vector size to, 0 for any len=
gth
+ * @len_align_mask: the mask to align the total size to, 0 for any lengt=
h
  *
  * This takes either an iterator pointing to user memory, or one pointin=
g to
  * kernel pages (BVEC iterator). If we're adding user pages, we pin them=
 and
@@ -1336,10 +1349,12 @@ int bio_iov_iter_get_pages_aligned(struct bio *bi=
o, struct iov_iter *iter,
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
-		ret =3D __bio_iov_iter_get_pages(bio, iter, len_align_mask);
+		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
-	return bio->bi_vcnt ? 0 : ret;
+	if (bio->bi_vcnt)
+		return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_aligned);
=20
--=20
2.47.3


