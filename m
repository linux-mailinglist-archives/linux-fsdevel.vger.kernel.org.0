Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3821562488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiF3UnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiF3UnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:43:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733E13F0A
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:43:00 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEbCcE022527
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YJUMx25JnkLSpluSNWzz0LIB6yABqPp0PFY0YwPQEzk=;
 b=IX8uBGPgUivsyHFY6eDNymaBh9cDdYPcMcC8VQwPUs8cNfTSKMZGMuihbDhhSVsF8zpi
 QapJ7mOX6ABhhJGyp02pUfBMO/7OuRd4FjsPEhMM357xHCYFO48g0r1MoFNKvz6hZzjv
 DqRZ9Ma2xeuFvOljgbIxQ2XYYcuCW54JNZg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqwy3s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:59 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:58 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 185D35932DC3; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 11/12] iomap: add direct-io partial sector read support
Date:   Thu, 30 Jun 2022 13:42:11 -0700
Message-ID: <20220630204212.1265638-12-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: C_6BrPHfT-oQpSSnz4-goST0p-sYHC-a
X-Proofpoint-GUID: C_6BrPHfT-oQpSSnz4-goST0p-sYHC-a
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
 fs/iomap/direct-io.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 10a113358365..212e63b78950 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -251,9 +251,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_=
iter *iter,
 	int nr_pages, ret =3D 0;
 	size_t copied =3D 0;
 	size_t orig_count;
+	u16 skip =3D 0, trunc =3D 0;
=20
 	if (blkdev_dio_unaligned(bdev, pos | length, dio->submit.iter))
-		return -EINVAL;
+		if (!blkdev_bit_bucket(bdev, pos, length, dio->submit.iter,
+				       &skip, &trunc))
+			return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
 		dio->flags |=3D IOMAP_DIO_UNWRITTEN;
@@ -310,9 +313,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_=
iter *iter,
 	 */
 	bio_opf =3D iomap_dio_bio_opflags(dio, iomap, use_fua);
=20
-	nr_pages =3D bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
+	nr_pages =3D bio_iov_vecs_to_alloc_partial(dio->submit.iter, BIO_MAX_VE=
CS,
+						 skip, trunc);
 	do {
-		size_t n;
+		size_t n, bucket_bytes =3D 0;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
 			copied =3D ret =3D 0;
@@ -327,6 +331,15 @@ static loff_t iomap_dio_bio_iter(const struct iomap_=
iter *iter,
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D iomap_dio_bio_end_io;
=20
+		if (skip || trunc) {
+			bio_set_flag(bio, BIO_BIT_BUCKET);
+			if (skip) {
+				bucket_bytes +=3D skip;
+				blk_add_bb_page(bio, skip);
+				skip =3D 0;
+			}
+		}
+
 		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
 			/*
@@ -339,6 +352,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_=
iter *iter,
 			goto zero_tail;
 		}
=20
+		if (trunc && !iov_iter_count(dio->submit.iter)) {
+			blk_add_bb_page(bio, trunc);
+			bucket_bytes +=3D trunc;
+			trunc =3D 0;
+		}
+
 		n =3D bio->bi_iter.bi_size;
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
@@ -347,18 +366,19 @@ static loff_t iomap_dio_bio_iter(const struct iomap=
_iter *iter,
 				bio_set_pages_dirty(bio);
 		}
=20
-		dio->size +=3D n;
-		copied +=3D n;
+		dio->size +=3D n - bucket_bytes;
+		copied +=3D n - bucket_bytes;
=20
-		nr_pages =3D bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_VECS);
+		nr_pages =3D bio_iov_vecs_to_alloc_partial(dio->submit.iter,
+							 BIO_MAX_VECS, skip,
+							 trunc);
 		/*
 		 * We can only poll for single bio I/Os.
 		 */
 		if (nr_pages)
 			dio->iocb->ki_flags &=3D ~IOCB_HIPRI;
 		iomap_dio_submit_bio(iter, dio, bio, pos);
-		pos +=3D n;
+		pos +=3D n - bucket_bytes;
 	} while (nr_pages);
=20
 	/*
--=20
2.30.2

