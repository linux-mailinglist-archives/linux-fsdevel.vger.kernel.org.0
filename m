Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600AB5347D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiEZBIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiEZBId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:08:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06E91575
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:32 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGtbNd023130
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IPGZEoZLlJcqR4y6vi40ehjfP/MqoJW85cjDrHKckc4=;
 b=FrT4tTxGTITL9IHqw2rpyYrDPfPw4oqxYhIl1hSGIx0lJshz9qRcb2MC/UAt4+86Hobi
 U7oQqzJUbuLDHrPzb7NSMZhr+AGpZR67neq5mHS3HzijCJGkx3aSdi+pCCGvtr2kqIlb
 HcarAlMDkMPahCCeDQSHtTirsxGjvLp6+s8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g93upt3ub-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:32 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:08:29 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3EF5045C0BCB; Wed, 25 May 2022 18:06:19 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv4 2/9] block/bio: remove duplicate append pages code
Date:   Wed, 25 May 2022 18:06:06 -0700
Message-ID: <20220526010613.4016118-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yDAk_fOxhkKVP-BXAJrkjh1VVCDzA7Ce
X-Proofpoint-GUID: yDAk_fOxhkKVP-BXAJrkjh1VVCDzA7Ce
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

The getting pages setup for zone append and normal IO are identical. Use
common code for each.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 102 ++++++++++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e249f6414fd5..55d2a9c4e312 100644
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
@@ -1215,51 +1245,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
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
@@ -1294,10 +1279,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
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

