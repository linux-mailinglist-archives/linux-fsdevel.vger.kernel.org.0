Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C35347CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiEZBGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiEZBGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:06:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4648FD68
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:06:40 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24PGtZMV009413
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NDVPtsohLwJbs3chctEtWIn1Z10WtLG6eN0XAr5wzj8=;
 b=XHN+y8mvAlzSc8wJsZvMts2ARx95UAC/VrBMemjI6ca3QPggRWpK1DbOM4Jcem3/XZOJ
 nfKX0BZLQGm/5EVYh9cPpVvL2JvqsAxQYEXhrSpPiYI4CJgXt1hAFWapZpHXhtm9ZBV+
 ZgfMrsoCnxVyPIAREIfO2M0lNBl4Si5/1l8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g93tx23k4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:06:39 -0700
Received: from twshared35748.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:06:37 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id EDFBD45C0BDB; Wed, 25 May 2022 18:06:20 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 5/9] block: add a helper function for dio alignment
Date:   Wed, 25 May 2022 18:06:09 -0700
Message-ID: <20220526010613.4016118-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SDu7rw2OyuLLi-cBfAk06ZLRfFWvEWhm
X-Proofpoint-GUID: SDu7rw2OyuLLi-cBfAk06ZLRfFWvEWhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
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

This will make it easier to add more complex acceptable alignment
criteria in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..bd6c2e13a4e3 100644
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
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
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
@@ -171,11 +181,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
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
@@ -296,11 +306,11 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
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
--=20
2.30.2

