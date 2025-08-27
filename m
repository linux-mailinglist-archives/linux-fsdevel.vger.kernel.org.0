Return-Path: <linux-fsdevel+bounces-59373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FADB384A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919A31BA6422
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E635E4C8;
	Wed, 27 Aug 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iD/D/agM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150D35A29E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304003; cv=none; b=skXJgU3+2WgvQYLzB9BpUSV6QVrckzLw2ixSpNkK4gQgbtmmmLeqLKCqXjRQb5bHaFaJXpdMfwzKX9T82vL+7LifC46uBTlpCtjGBxHQvVpGhSyyGtmKlQnEcmXRT3XkuQaYT+sBgH+FUZcJsqzn+0dVs0hiiAq9ml40ovZ53+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304003; c=relaxed/simple;
	bh=pzGhiR95tsJWN5otio1Fihv9OUy15dkbv4+woJ9TwLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyNbgwwjt1Vs0w6tZwoNnoHUKakRJhA70KtjVb6TjKHWDLIfbXiytjZugC2I9gtLHGEmP+uE5OoEpBKenggnIfXVTE6owxqGqVXYer3ySxl0tLF35dZ2uI8XlXCaAImGSfpdCWDfHSLDRpdvHgWFxDcbnnoIZmVPCi+n2L5b8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iD/D/agM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R5wf9Q057974
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Ch4DKDnL5ZWGTYcVnoIIpv87/PIvs4GoOvRtM1tLNks=; b=iD/D/agMRDFd
	4t1nhS6mH8zH2JCEfBSDotGSzBRl/m6jFo2zDeORL0iZa/7/lFJ7YRxwA8n1K3ML
	m2j83pIj/ykikeYi5FdJ6YxdggAC55vEqXq1RcP+tntRF+Qn94SDFFDPvDguIrNV
	kO2KoPR7z+L/a4kqSbp2WYzj0ZGQVPZB0yXwL2XaF7ht3NMcY2m5uX/W8FHydpED
	njTnokVFUkZt4N411iRLlkyO0jA1BnUR0NNXWY7myX1p7z6wG3WwY0av65wVJvZI
	rbXR3RP0/Nel+UK1EIhoCZf6ZJJyRanaudh5+NQFl8+9QWNpXXhuL2JoPtPLHXlJ
	UmhPcn9IBA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48svbdabfv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:19 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:08 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9914A10CF61B; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 2/8] block: add size alignment to bio_iov_iter_get_pages
Date: Wed, 27 Aug 2025 07:12:52 -0700
Message-ID: <20250827141258.63501-3-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 39IgIn0GT4PdEdhWypyq88qFo6dqjCTL
X-Authority-Analysis: v=2.4 cv=a+Uw9VSF c=1 sm=1 tr=0 ts=68af1280 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yzNSm02vyakeHXeUMvAA:9
X-Proofpoint-GUID: 39IgIn0GT4PdEdhWypyq88qFo6dqjCTL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfXwH5RZ5T01Zkq
 IFpar1+pivOUWnj9zM9nyTi29Rsq7CxVcY7O0gopN6AayvGjXgZ4zqYnzNSXz+ifXnpuMewG4hT
 cE+Ij45C7X4W4GIq23Is8Ib3zHMTGzZMG5WSJL5Ycmb1ZzEkAf7Pd4us+GHqlgfGipx8VUhuhBj
 HYWPs8y0CVPKAhLBQCu/rrpzSS7GyAfPehVDGG9LnuFENJZqUC4j8cg3DubnSuj84vvwglCccZh
 f+e9JTl+a/VAgjOH/YgVOrrlcefxVtTpZsP3jkiQEaQNDj3GVx9WGuBrF9f5bgdFIfXJHKy3nFr
 U74L+Sla2HmwhkjT/y7beyj05jqoHsEs/PclSoCTf7FkjCDXUuyZiTwbM7gQZM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer tries to align bio vectors to the block device's logical
block size. Some cases don't have a block device, or we may need to
align to something larger, which we can't derive it from the queue
limits. Have the caller specify what they want, or allow any length
alignment if nothing was specified. Since the most common use case
relies on the block device's limits, a helper function is provided.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c            | 19 +++++++++++--------
 block/fops.c           |  6 +++---
 fs/iomap/direct-io.c   |  2 +-
 include/linux/bio.h    |  9 ++++++++-
 include/linux/blkdev.h |  7 +++++++
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3b371a5da159e..44286db14355f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,7 +1204,8 @@ static unsigned int get_contig_folio_len(unsigned i=
nt *num_pages,
  * For a multi-segment *iter, this function only adds pages from the nex=
t
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er)
+static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er,
+				    unsigned len_align_mask)
 {
 	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
@@ -1213,7 +1214,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size;
 	unsigned int num_pages, i =3D 0;
-	size_t offset, folio_offset, left, len;
+	size_t offset, folio_offset, left, len, trim;
 	int ret =3D 0;
=20
 	/*
@@ -1242,8 +1243,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
=20
-	if (bio->bi_bdev) {
-		size_t trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+	trim =3D size & len_align_mask;
+	if (trim) {
 		iov_iter_revert(iter, trim);
 		size -=3D trim;
 	}
@@ -1298,9 +1299,10 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 }
=20
 /**
- * bio_iov_iter_get_pages - add user or kernel pages to a bio
+ * bio_iov_iter_get_pages_aligned - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
+ * @len_align_mask: the mask to align each vector size to, 0 for any len=
gth
  *
  * This takes either an iterator pointing to user memory, or one pointin=
g to
  * kernel pages (BVEC iterator). If we're adding user pages, we pin them=
 and
@@ -1317,7 +1319,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *ite=
r,
+			   unsigned len_align_mask)
 {
 	int ret =3D 0;
=20
@@ -1333,12 +1336,12 @@ int bio_iov_iter_get_pages(struct bio *bio, struc=
t iov_iter *iter)
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
-		ret =3D __bio_iov_iter_get_pages(bio, iter);
+		ret =3D __bio_iov_iter_get_pages(bio, iter, len_align_mask);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
 	return bio->bi_vcnt ? 0 : ret;
 }
-EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_aligned);
=20
 static void submit_bio_wait_endio(struct bio *bio)
 {
diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..d136fb5f6b6ab 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -78,7 +78,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |=3D REQ_ATOMIC;
=20
-	ret =3D bio_iov_iter_get_pages(&bio, iter);
+	ret =3D bio_iov_iter_get_bdev_pages(&bio, iter, bdev);
 	if (unlikely(ret))
 		goto out;
 	ret =3D bio.bi_iter.bi_size;
@@ -212,7 +212,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
=20
-		ret =3D bio_iov_iter_get_pages(bio, iter);
+		ret =3D bio_iov_iter_get_bdev_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
 			bio->bi_status =3D BLK_STS_IOERR;
 			bio_endio(bio);
@@ -348,7 +348,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 		 */
 		bio_iov_bvec_set(bio, iter);
 	} else {
-		ret =3D bio_iov_iter_get_pages(bio, iter);
+		ret =3D bio_iov_iter_get_bdev_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
 	}
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b84f6af2eb4c8..fea23fa6a402f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -434,7 +434,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter=
, struct iomap_dio *dio)
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D iomap_dio_bio_end_io;
=20
-		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter);
+		ret =3D bio_iov_iter_get_bdev_pages(bio, dio->submit.iter, iomap->bdev=
);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 519a1d59805f8..788a50ff319e3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -441,7 +441,14 @@ int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
=20
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *ite=
r,
+		unsigned len_align_mask);
+
+static inline int bio_iov_iter_get_pages(struct bio *bio, struct iov_ite=
r *iter)
+{
+	return bio_iov_iter_get_pages_aligned(bio, iter, 0);
+}
+
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d75c77eb8cb97..36500d576d7e9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1877,6 +1877,13 @@ static inline int bio_split_rw_at(struct bio *bio,
 	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
 }
=20
+static inline int bio_iov_iter_get_bdev_pages(struct bio *bio,
+		struct iov_iter *iter, struct block_device *bdev)
+{
+	return bio_iov_iter_get_pages_aligned(bio, iter,
+					bdev_logical_block_size(bdev) - 1);
+}
+
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name =3D { }
=20
 #endif /* _LINUX_BLKDEV_H */
--=20
2.47.3


