Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4F571F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiGLPda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiGLPdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:33:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93DC1665
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 08:33:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C7oVGx011187
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 08:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jxCiKEH/1t+x3zcdL+X8KQZmdGEfq3hNQwQWm3upkXM=;
 b=J2vjKWGwOeHI/1or0uRAqwLUgKp9SfJ3ShrxQE0JTDyzLkYxvE3TtLuvv9XqWqdp44tg
 sUpvw3WA4oP3Gfuan4+nqUd+VLtNYY+JN+c1Yqc5WanUYpC3jYyQqdowK6X3nymVP4CN
 pLtOsjRO4kDT4ZXKMeDlMrXjoNOBRptppik= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h94wradd6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 08:33:08 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 08:33:06 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 9EBB160739E9; Tue, 12 Jul 2022 08:32:58 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] block: fix leaking page ref on truncated direct io
Date:   Tue, 12 Jul 2022 08:32:56 -0700
Message-ID: <20220712153256.2202024-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712153256.2202024-1-kbusch@fb.com>
References: <20220712153256.2202024-1-kbusch@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0FWOeWoNYDrD4CrP1fwX6HB8dkA-LHV4
X-Proofpoint-GUID: 0FWOeWoNYDrD4CrP1fwX6HB8dkA-LHV4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The size being added to a bio from an iov is aligned to a block size
after the pages were gotten. If the new aligned size truncates the last
page, its reference was being leaked. Ensure all pages that were not
added to the bio have their reference released.

Since this essentially requires doing the same that bio_put_pages(), and
there was only one caller for that function, this patch makes the
put_page() loop common for everyone.

Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: fixed possible uninitialized variable

This update is also pushed to my repo,

https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=3Da=
lignment-fixes-rebased

 block/bio.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 01223f8086ed..de345a9b52db 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1151,14 +1151,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_it=
er *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
=20
-static void bio_put_pages(struct page **pages, size_t size, size_t off)
-{
-	size_t i, nr =3D DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
-
-	for (i =3D 0; i < nr; i++)
-		put_page(pages[i]);
-}
-
 static int bio_iov_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int offset)
 {
@@ -1207,7 +1199,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, =
struct iov_iter *iter)
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size, left;
-	unsigned len, i;
+	unsigned len, i =3D 0;
 	size_t offset;
 	int ret =3D 0;
=20
@@ -1228,10 +1220,16 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	 */
 	size =3D iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
 				  nr_pages, &offset);
-	if (size > 0)
+	if (size > 0) {
+		nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
 		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
-	if (unlikely(size <=3D 0))
-		return size ? size : -EFAULT;
+	} else
+		nr_pages =3D 0;
+
+	if (unlikely(size <=3D 0)) {
+		ret =3D size ? size : -EFAULT;
+		goto out;
+	}
=20
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
 		struct page *page =3D pages[i];
@@ -1240,10 +1238,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 			ret =3D bio_iov_add_zone_append_page(bio, page, len,
 					offset);
-			if (ret) {
-				bio_put_pages(pages + i, left, offset);
+			if (ret)
 				break;
-			}
 		} else
 			bio_iov_add_page(bio, page, len, offset);
=20
@@ -1251,6 +1247,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 	}
=20
 	iov_iter_advance(iter, size - left);
+out:
+	while (i < nr_pages)
+		put_page(pages[i++]);
+
 	return ret;
 }
=20
--=20
2.30.2

