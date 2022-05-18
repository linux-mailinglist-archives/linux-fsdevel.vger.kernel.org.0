Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4B52C124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiERRLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbiERRLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 13:11:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE75419A
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:41 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IFiBwi014227
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oWw+bc+rJhlNN3apliQ9xsJQL9S1G4MZnFOj+WYiR5w=;
 b=Fsd+vV/keQUYdqoCHJ7XVQHZ+rYT8uK8PvUFgHI22X9cm29EwB6XQPQLbL6iu5HGcfB7
 NBmh8ehxar+tf6W7GwT+OmNeba/lK5wxduFFmd2Ci59GbCgkiUmUm4rvzeaAbXQl5NNq
 jlOk3adlepEs5337FZBCzbv2KZYOFsJOz2c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ap6tey3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:40 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 10:11:37 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5DE4C414B92B; Wed, 18 May 2022 10:11:32 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] block: relax direct io memory alignment
Date:   Wed, 18 May 2022 10:11:31 -0700
Message-ID: <20220518171131.3525293-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518171131.3525293-1-kbusch@fb.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RmD4cmzepoqBbQaQRW9_KKBsQkyCHfFI
X-Proofpoint-ORIG-GUID: RmD4cmzepoqBbQaQRW9_KKBsQkyCHfFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v1->v2:

  Squashed the alignment patch into this one

  Use ALIGN_DOWN macro instead of reimplementing it

  Check for unalignment in _simple case

 block/bio.c            |  3 +++
 block/fops.c           | 20 ++++++++++++++------
 fs/direct-io.c         | 11 +++++++----
 fs/iomap/direct-io.c   |  3 ++-
 include/linux/blkdev.h |  5 +++++
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 320514a47527..bde9b475a4d8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1207,6 +1207,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 {
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
 	bool same_page =3D false;
@@ -1223,6 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size =3D ALIGN_DOWN(size, queue_logical_block_size(q));
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..d8537c29602f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -54,8 +54,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
@@ -80,6 +81,11 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb =
*iocb,
 	ret =3D bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
+	if (unlikely(iov_iter_count(iter))) {
+		/* iov is not aligned for a single bio */
+		ret =3D -EINVAL;
+		goto out;
+	}
 	ret =3D bio.bi_iter.bi_size;
=20
 	if (iov_iter_rw(iter) =3D=3D WRITE)
@@ -173,8 +179,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
@@ -298,8 +305,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 840752006f60..64cc176be60c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1131,7 +1131,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, st=
ruct inode *inode,
 	struct dio_submit sdio =3D { 0, };
 	struct buffer_head map_bh =3D { 0, };
 	struct blk_plug plug;
-	unsigned long align =3D offset | iov_iter_alignment(iter);
+	unsigned long align =3D iov_iter_alignment(iter);
=20
 	/*
 	 * Avoid references to bdev if not absolutely needed to give
@@ -1165,11 +1165,14 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, =
struct inode *inode,
 		goto fail_dio;
 	}
=20
-	if (align & blocksize_mask) {
-		if (bdev)
+	if ((offset | align) & blocksize_mask) {
+		if (bdev) {
 			blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
+			if (align & bdev_dma_alignment(bdev))
+				goto fail_dio;
+		}
 		blocksize_mask =3D (1 << blkbits) - 1;
-		if (align & blocksize_mask)
+		if ((offset | count) & blocksize_mask)
 			goto fail_dio;
 	}
=20
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 80f9b047aa1b..0256d28baa8e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -244,7 +244,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    align & bdev_dma_alignment(iomap->bdev))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bdf2ac9142c..834b981ef01b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1365,6 +1365,11 @@ static inline int queue_dma_alignment(const struct=
 request_queue *q)
 	return q ? q->dma_alignment : 511;
 }
=20
+static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
+{
+	return queue_dma_alignment(bdev_get_queue(bdev));
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

