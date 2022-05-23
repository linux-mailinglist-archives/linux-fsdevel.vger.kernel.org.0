Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566CA531D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiEWVCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiEWVB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:01:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8085950459
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:58 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGnhr019875
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3InifA8iBF2XdI/hDz3sCcXF6tYj0vr17287zoar5NU=;
 b=I4hRXl+ziRDpinZDMBn8dn7QAgwJY2H5yNKGp7ZZP/l+o8S3jBEg0r19Ix/8W+HPpvps
 /MCt73FTx/cOCMJYUMea3uPcih6o3NJUltBBSakQGvHF33Fv17bGDB6p5IcTUpHKKC/P
 izvN8xM5couV9mSUH8dliO7yUO/SSF/WI4o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6wwsbupf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:57 -0700
Received: from twshared6696.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id CB9C54464158; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 6/6] block: relax direct io memory alignment
Date:   Mon, 23 May 2022 14:01:19 -0700
Message-ID: <20220523210119.2500150-7-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210119.2500150-1-kbusch@fb.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YF8dF_OCS7pOl_5TNAW5qEZC_o8tEja3
X-Proofpoint-GUID: YF8dF_OCS7pOl_5TNAW5qEZC_o8tEja3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_09,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Use the address alignment requirements from the hardware for direct io
instead of requiring addresses be aligned to the block size. User space
can discover the alignment requirements from the dma_alignment queue
attribute.

User space can specify any hardware compatible DMA offset for each
segment, but every segment length is still required to be a multiple of
the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Removed iomap support for now

  Added alignment help function instead of duplicating it (Christoph)

  Added comment explaining ALIGN_DOWN

  Added check for iov alignment in _async case

 block/bio.c  | 13 +++++++++++++
 block/fops.c | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55d2a9c4e312..c8ea14ad87f6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1205,6 +1205,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 {
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size, left;
@@ -1219,7 +1220,19 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
+	/*
+	 * Each segment in the iov is required to be a block size multiple.
+	 * However, we may not be able to get the entire segment if it spans
+	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
+	 * result to ensure the bio's total size is correct. The remainder of
+	 * the iov data will be picked up in the next bio iteration.
+	 *
+	 * If the result is ever 0, that indicates the iov fails the segment
+	 * size requirement and is an error.
+	 */
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size =3D ALIGN_DOWN(size, queue_logical_block_size(q));
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..218e4a8b92aa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -42,6 +42,16 @@ static unsigned int dio_bio_write_op(struct kiocb *ioc=
b)
 	return op;
 }
=20
+static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
+		return -EINVAL;
+	return 0;
+}
+
 #define DIO_INLINE_BIO_VECS 4
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -54,9 +64,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
 		vecs =3D inline_vecs;
@@ -80,6 +90,11 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb =
*iocb,
 	ret =3D bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
+	/* check if iov is not aligned */
+	if (unlikely(iov_iter_count(iter))) {
+		ret =3D -EINVAL;
+		goto out;
+	}
 	ret =3D bio.bi_iter.bi_size;
=20
 	if (iov_iter_rw(iter) =3D=3D WRITE)
@@ -171,11 +186,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
b, struct iov_iter *iter,
 	bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos =3D iocb->ki_pos;
-	int ret =3D 0;
+	int ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
@@ -296,11 +311,11 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos =3D iocb->ki_pos;
-	int ret =3D 0;
+	int ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	ret =3D blkdev_dio_aligned(bdev, pos, iter);
+	if (ret)
+		return ret;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
@@ -323,6 +338,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb=
 *iocb,
 		bio_iov_bvec_set(bio, iter);
 	} else {
 		ret =3D bio_iov_iter_get_pages(bio, iter);
+
+		/* check if iov is not aligned */
+		if (unlikely(iov_iter_count(iter)))
+			ret =3D -EINVAL;
 		if (unlikely(ret)) {
 			bio_put(bio);
 			return ret;
--=20
2.30.2

