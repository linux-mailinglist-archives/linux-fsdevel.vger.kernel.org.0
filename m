Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF57531D4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiEWVBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiEWVBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:01:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44C4163E
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGo3W019900
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dIriWM7eeYA9Ml6wgxp7wP/hAy2C7xDt8yRSAd5OODM=;
 b=TbHJSycH0yfvN49f1YjBh6ZNm4q0D8QgGFjFY6A0KdddyCihaVyBHPz2BRgciX33UnnS
 W9K9uMK6LParNSQ7SWvYOaledLmCrwYVmwaszcQu5A9H70kBJRZZ9zwnnKZrWRkMnQyE
 L6bFFwfAWR3RBL7vSIEi5/soPk+kLjxohdY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6wwsbumu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:46 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:44 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 7625B4464150; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Date:   Mon, 23 May 2022 14:01:14 -0700
Message-ID: <20220523210119.2500150-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210119.2500150-1-kbusch@fb.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MfjrtJT-rcy51CyR3uGgJ5TtOGYsRT0i
X-Proofpoint-GUID: MfjrtJT-rcy51CyR3uGgJ5TtOGYsRT0i
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

The getting pages setup for zone append and normal IO are identical. Use
common code for each.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Folded in improvement suggestions from Christoph

 block/bio.c | 105 +++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3893d80dccc..55d2a9c4e312 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1158,6 +1158,37 @@ static void bio_put_pages(struct page **pages, siz=
e_t size, size_t off)
 		put_page(pages[i]);
 }
=20
+static int bio_iov_add_page(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	bool same_page =3D false;
+
+	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (WARN_ON_ONCE(bio_full(bio, len)))
+			return -EINVAL;
+		__bio_add_page(bio, page, len, offset);
+		return 0;
+	}
+
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
+static int bio_iov_add_zone_append_page(struct bio *bio, struct page *pa=
ge,
+		unsigned int len, unsigned int offset)
+{
+	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
+	bool same_page =3D false;
+
+	if (bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_zone_append_sectors(q), &same_page) !=3D len)
+		return -EINVAL;
+	if (same_page)
+		put_page(page);
+	return 0;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))
=20
 /**
@@ -1176,7 +1207,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	bool same_page =3D false;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1185,7 +1215,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
 	 * possible so that we can start filling biovecs from the beginning
 	 * without overwriting the temporary page array.
-	*/
+	 */
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
@@ -1195,18 +1225,18 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
+		int ret;
=20
 		len =3D min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
+			ret =3D bio_iov_add_zone_append_page(bio, page, len,
+					offset);
+		else
+			ret =3D bio_iov_add_page(bio, page, len, offset);
=20
-		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-			if (same_page)
-				put_page(page);
-		} else {
-			if (WARN_ON_ONCE(bio_full(bio, len))) {
-				bio_put_pages(pages + i, left, offset);
-				return -EINVAL;
-			}
-			__bio_add_page(bio, page, len, offset);
+		if (ret) {
+			bio_put_pages(pages + i, left, offset);
+			return ret;
 		}
 		offset =3D 0;
 	}
@@ -1215,54 +1245,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	return 0;
 }
=20
-static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *=
iter)
-{
-	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
-	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
-	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);
-	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
-	struct page **pages =3D (struct page **)bv;
-	ssize_t size, left;
-	unsigned len, i;
-	size_t offset;
-	int ret =3D 0;
-
-	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
-
-	/*
-	 * Move page array up in the allocated memory for the bio vecs as far a=
s
-	 * possible so that we can start filling biovecs from the beginning
-	 * without overwriting the temporary page array.
-	 */
-	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
-	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
-
-	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (unlikely(size <=3D 0))
-		return size ? size : -EFAULT;
-
-	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
-		struct page *page =3D pages[i];
-		bool same_page =3D false;
-
-		len =3D min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_add_hw_page(q, bio, page, len, offset,
-				max_append_sectors, &same_page) !=3D len) {
-			bio_put_pages(pages + i, left, offset);
-			ret =3D -EINVAL;
-			break;
-		}
-		if (same_page)
-			put_page(page);
-		offset =3D 0;
-	}
-
-	iov_iter_advance(iter, size - left);
-	return ret;
-}
-
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1297,10 +1279,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
 iov_iter *iter)
 	}
=20
 	do {
-		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)
-			ret =3D __bio_iov_append_get_pages(bio, iter);
-		else
-			ret =3D __bio_iov_iter_get_pages(bio, iter);
+		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
 	/* don't account direct I/O as memory stall */
--=20
2.30.2

