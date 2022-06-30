Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C742256247A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiF3Ump (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiF3Umo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335C2710
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UJCLpt004575
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8cc23F6j5+adqkGR+byTTk90kWs3qVOG0MzAZ27W60Y=;
 b=nZ/r4lBidqjvrhNVFQl1SXA5uaXeC2qaTVM/NqD6HQ5Zc5C3T8nHE8LcV9SdHPPv6qJa
 j8YQbacbvqq7ezOALyZ+8KwoQcyNstDtX3Bigu74w6PH0FPNKDULJHYyEnVXclxadYMP
 w3+UI2zuCqUcakEpyOrXDWMYeDTZ3BOyGF0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h195a4pv9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:41 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:38 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1E5DD5932DB7; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 01/12] block: move direct io alignment check to common
Date:   Thu, 30 Jun 2022 13:42:01 -0700
Message-ID: <20220630204212.1265638-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8jl_5Ofob8AP0vb34p0z1FvduUtPa979
X-Proofpoint-ORIG-GUID: 8jl_5Ofob8AP0vb34p0z1FvduUtPa979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

All direct io has the same setup and alignment check, so just do it once
in common code.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c           | 44 ++++++++++++++----------------------------
 include/linux/blkdev.h |  7 +++++++
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 86d3cab9bf93..f37af5924cef 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -42,28 +42,17 @@ static unsigned int dio_bio_write_op(struct kiocb *io=
cb)
 	return op;
 }
=20
-static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
-			      struct iov_iter *iter)
-{
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
-}
-
 #define DIO_INLINE_BIO_VECS 4
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
-		struct iov_iter *iter, unsigned int nr_pages)
+		struct iov_iter *iter, unsigned int nr_pages,
+		struct block_device *bdev, loff_t pos)
 {
-	struct block_device *bdev =3D iocb->ki_filp->private_data;
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
-	loff_t pos =3D iocb->ki_pos;
 	bool should_dirty =3D false;
 	struct bio bio;
 	ssize_t ret;
=20
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
 		vecs =3D inline_vecs;
 	else {
@@ -168,20 +157,15 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
=20
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *i=
ter,
-		unsigned int nr_pages)
+		unsigned int nr_pages, struct block_device *bdev, loff_t pos)
 {
-	struct block_device *bdev =3D iocb->ki_filp->private_data;
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
-	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
 	bio =3D bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -292,20 +276,15 @@ static void blkdev_bio_end_io_async(struct bio *bio=
)
 }
=20
 static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
-					struct iov_iter *iter,
-					unsigned int nr_pages)
+		struct iov_iter *iter, unsigned int nr_pages,
+		struct block_device *bdev, loff_t pos)
 {
-	struct block_device *bdev =3D iocb->ki_filp->private_data;
 	bool is_read =3D iov_iter_rw(iter) =3D=3D READ;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |=3D REQ_ALLOC_CACHE;
 	bio =3D bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -357,18 +336,25 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
=20
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *ite=
r)
 {
+	struct block_device *bdev =3D iocb->ki_filp->private_data;
+	loff_t pos =3D iocb->ki_pos;
 	unsigned int nr_pages;
=20
 	if (!iov_iter_count(iter))
 		return 0;
+	if (blkdev_dio_unaligned(bdev, pos, iter))
+		return -EINVAL;
=20
 	nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <=3D BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
-			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
+			return __blkdev_direct_IO_simple(iocb, iter, nr_pages,
+							 bdev, pos);
+		return __blkdev_direct_IO_async(iocb, iter, nr_pages, bdev,
+						pos);
 	}
-	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
+	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages), bdev,
+				  pos);
 }
=20
 static int blkdev_writepage(struct page *page, struct writeback_control =
*wbc)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22b12531aeb7..9d676adfaaa1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1352,6 +1352,13 @@ static inline bool bdev_iter_is_aligned(struct blo=
ck_device *bdev,
 				   bdev_logical_block_size(bdev) - 1);
 }
=20
+static inline bool blkdev_dio_unaligned(struct block_device *bdev, loff_=
t p,
+			      struct iov_iter *iter)
+{
+	return p & (bdev_logical_block_size(bdev) - 1) ||
+		!bdev_iter_is_aligned(bdev, iter);
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

