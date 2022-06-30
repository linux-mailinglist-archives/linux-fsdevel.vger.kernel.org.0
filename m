Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7D562476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiF3Ums (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiF3Ump (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A96E11C24
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UG18kJ032059
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0vQ+SPG7rbLReFzJBCjN1ACRC52yjPlRyenY1f8Evls=;
 b=BwXqJ0IRMhHWVI2XdzdHeXoVR2qu4nIthtzTWuPUslKc79l+2euoanAdUtXj/Ufrrnz0
 E+PXzA2yPKqxIJiWHuOmL9271VX8lgn3H2SJCgPYf58h93h6CSmZV8r+ObwDwDyAd4CE
 1SdoWZWVmTZwR7kamid3ibWolWpcqMPUVxg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h12ug6fyd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:42 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 34C505932DB8; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 02/12] iomap: save copy of bdev for direct io
Date:   Thu, 30 Jun 2022 13:42:02 -0700
Message-ID: <20220630204212.1265638-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6K-7voUxb8_2zl89izdRoTdlfAfmHFod
X-Proofpoint-ORIG-GUID: 6K-7voUxb8_2zl89izdRoTdlfAfmHFod
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

The block_device is used three times already, so save a copy instead of
following the iomap pointer each time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d098adba443..5d478a95efdf 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,7 +240,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 {
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
+	struct block_device *bdev =3D iomap->bdev;
+	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,7 +254,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t orig_count;
=20
 	if ((pos | length) & ((1 << blkbits) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
@@ -275,7 +276,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 		 * cache flushes on IO completion.
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_FUA) && bdev_fua(iomap->bdev))
+		    (dio->flags & IOMAP_DIO_WRITE_FUA) && bdev_fua(bdev))
 			use_fua =3D true;
 	}
=20
--=20
2.30.2

