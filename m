Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B05347E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbiEZBJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEZBIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:08:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941C91599
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:47 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q0RQig017156
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=p1SrztScHuNblAyNzaIrLrE3P0hdGIoUW1/0kG6YeG0=;
 b=bI4l3PPlztGf+5lncfJTmG775gE70vfmcBpB/sEWiibua7XR+31Mhg/W+4lDpnmlJA3k
 XP14kJxvoBYPhP9RVMdaLL2S4Nn86NOmN0pY7lAU3cQfIPd488F0uKzP6vHj3qEUAXUm
 tVNHNOAmxJr7td0Lb7PTzGkOADbJyNDlfwI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93vsa51c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:47 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:08:46 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 269D045C0BDF; Wed, 25 May 2022 18:06:20 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 8/9] block: relax direct io memory alignment
Date:   Wed, 25 May 2022 18:06:12 -0700
Message-ID: <20220526010613.4016118-9-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ATfS5kuHMzeD_o4DCJ9YvxCQxa7eW8mW
X-Proofpoint-GUID: ATfS5kuHMzeD_o4DCJ9YvxCQxa7eW8mW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_07,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 block/bio.c  | 12 ++++++++++++
 block/fops.c | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 55d2a9c4e312..c492881959d1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1219,7 +1219,19 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
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
+		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/fops.c b/block/fops.c
index bd6c2e13a4e3..6ecbccc552b9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -45,10 +45,10 @@ static unsigned int dio_bio_write_op(struct kiocb *io=
cb)
 static int blkdev_dio_aligned(struct block_device *bdev, loff_t pos,
 			      struct iov_iter *iter)
 {
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
-
 	return 0;
 }
=20
@@ -88,6 +88,10 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb =
*iocb,
 	bio.bi_ioprio =3D iocb->ki_ioprio;
=20
 	ret =3D bio_iov_iter_get_pages(&bio, iter);
+
+	/* check if iov is not aligned */
+	if (unlikely(!ret && iov_iter_count(iter)))
+		ret =3D -EINVAL;
 	if (unlikely(ret))
 		goto out;
 	ret =3D bio.bi_iter.bi_size;
@@ -333,6 +337,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb=
 *iocb,
 		bio_iov_bvec_set(bio, iter);
 	} else {
 		ret =3D bio_iov_iter_get_pages(bio, iter);
+
+		/* check if iov is not aligned */
+		if (unlikely(!ret && iov_iter_count(iter)))
+			ret =3D -EINVAL;
 		if (unlikely(ret)) {
 			bio_put(bio);
 			return ret;
--=20
2.30.2

