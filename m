Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C756248B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbiF3UnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbiF3UnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:43:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C614D3D
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:43:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UH5ia9006498
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3kDhkv8lM7uoBEi94XUYDlI+HwJ5aHLXq4ypfNnnqqQ=;
 b=qoOXKOgTY6dzB2fyhIbEUU+7vLAzqnaYpXb6MEGUkt0bafSaQqevZOTbhE5KBv8DEDpO
 qd5ojcdAYOm8jh8roLlEGcBbsXV6bv4YiETq0Nv5uned1bzlWhLl+3qzVVQPiSQp2vm3
 vC4rj4DkgkM/VTJyX5wUhYv/A5t5GDnxqQQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h17gewyna-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:59 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 0E32A5932DC2; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 10/12] block: add direct-io partial sector read support
Date:   Thu, 30 Jun 2022 13:42:10 -0700
Message-ID: <20220630204212.1265638-11-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x9B1f68pno2o3CYgXDvYbZPgdIXpMVf0
X-Proofpoint-GUID: x9B1f68pno2o3CYgXDvYbZPgdIXpMVf0
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

Enable direct io to read partial sectors if the block device supports bit
buckets.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 69 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index f37af5924cef..5eee8cef7ce0 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -46,9 +46,10 @@ static unsigned int dio_bio_write_op(struct kiocb *ioc=
b)
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		struct iov_iter *iter, unsigned int nr_pages,
-		struct block_device *bdev, loff_t pos)
+		struct block_device *bdev, loff_t pos, u16 skip, u16 trunc)
 {
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	u16 bucket_bytes =3D skip + trunc;
 	bool should_dirty =3D false;
 	struct bio bio;
 	ssize_t ret;
@@ -72,10 +73,19 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb=
 *iocb,
 	bio.bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 	bio.bi_ioprio =3D iocb->ki_ioprio;
=20
+	if (bucket_bytes) {
+		bio_set_flag(&bio, BIO_BIT_BUCKET);
+		if (skip)
+			blk_add_bb_page(&bio, skip);
+	}
+
 	ret =3D bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
-	ret =3D bio.bi_iter.bi_size;
+
+	if (trunc)
+		blk_add_bb_page(&bio, trunc);
+	ret =3D bio.bi_iter.bi_size - bucket_bytes;
=20
 	if (iov_iter_rw(iter) =3D=3D WRITE)
 		task_io_account_write(ret);
@@ -157,13 +167,15 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
=20
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *i=
ter,
-		unsigned int nr_pages, struct block_device *bdev, loff_t pos)
+		unsigned int nr_pages, struct block_device *bdev, loff_t pos,
+		u16 skip, u16 trunc)
 {
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	u16 bucket_bytes =3D skip + trunc;
 	int ret =3D 0;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
@@ -199,6 +211,14 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter,
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
=20
+		if (bucket_bytes) {
+			bio_set_flag(bio, BIO_BIT_BUCKET);
+			if (skip) {
+				blk_add_bb_page(bio, skip);
+				skip =3D 0;
+			}
+		}
+
 		ret =3D bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
 			bio->bi_status =3D BLK_STS_IOERR;
@@ -206,6 +226,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter,
 			break;
 		}
=20
+		if (trunc && !iov_iter_count(iter)) {
+			blk_add_bb_page(bio, trunc);
+			trunc =3D 0;
+		}
+
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
@@ -218,7 +243,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 		dio->size +=3D bio->bi_iter.bi_size;
 		pos +=3D bio->bi_iter.bi_size;
=20
-		nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
+		nr_pages =3D bio_iov_vecs_to_alloc_partial(iter, BIO_MAX_VECS, 0,
+							 trunc);
 		if (!nr_pages) {
 			submit_bio(bio);
 			break;
@@ -244,7 +270,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	if (!ret)
 		ret =3D blk_status_to_errno(dio->bio.bi_status);
 	if (likely(!ret))
-		ret =3D dio->size;
+		ret =3D dio->size - bucket_bytes;
=20
 	bio_put(&dio->bio);
 	return ret;
@@ -277,10 +303,11 @@ static void blkdev_bio_end_io_async(struct bio *bio=
)
=20
 static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		struct iov_iter *iter, unsigned int nr_pages,
-		struct block_device *bdev, loff_t pos)
+		struct block_device *bdev, loff_t pos, u16 skip, u16 trunc)
 {
 	bool is_read =3D iov_iter_rw(iter) =3D=3D READ;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	u16 bucket_bytes =3D skip + trunc;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	int ret =3D 0;
@@ -296,6 +323,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb=
 *iocb,
 	bio->bi_end_io =3D blkdev_bio_end_io_async;
 	bio->bi_ioprio =3D iocb->ki_ioprio;
=20
+	if (bucket_bytes) {
+		bio_set_flag(bio, BIO_BIT_BUCKET);
+		if (skip)
+			blk_add_bb_page(bio, skip);
+	}
+
 	if (iov_iter_is_bvec(iter)) {
 		/*
 		 * Users don't rely on the iterator being in any particular
@@ -311,7 +344,11 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb=
 *iocb,
 			return ret;
 		}
 	}
-	dio->size =3D bio->bi_iter.bi_size;
+
+	if (trunc)
+		blk_add_bb_page(bio, trunc);
+
+	dio->size =3D bio->bi_iter.bi_size - bucket_bytes;
=20
 	if (is_read) {
 		if (iter_is_iovec(iter)) {
@@ -338,23 +375,29 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter)
 {
 	struct block_device *bdev =3D iocb->ki_filp->private_data;
 	loff_t pos =3D iocb->ki_pos;
+	u16 skip =3D 0, trunc =3D 0;
 	unsigned int nr_pages;
=20
 	if (!iov_iter_count(iter))
 		return 0;
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
+	if (blkdev_dio_unaligned(bdev, pos, iter)) {
+		if (!blkdev_bit_bucket(bdev, pos, iov_iter_count(iter), iter,
+				       &skip, &trunc))
+			return -EINVAL;
+		nr_pages =3D bio_iov_vecs_to_alloc_partial(iter, BIO_MAX_VECS + 1,
+							 skip, trunc);
+	} else
+		nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
=20
-	nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <=3D BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
 			return __blkdev_direct_IO_simple(iocb, iter, nr_pages,
-							 bdev, pos);
+							 bdev, pos, skip, trunc);
 		return __blkdev_direct_IO_async(iocb, iter, nr_pages, bdev,
-						pos);
+						pos, skip, trunc);
 	}
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages), bdev,
-				  pos);
+				  pos, skip, trunc);
 }
=20
 static int blkdev_writepage(struct page *page, struct writeback_control =
*wbc)
--=20
2.30.2

