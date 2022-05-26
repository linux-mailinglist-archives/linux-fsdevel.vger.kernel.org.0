Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8155347DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiEZBIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbiEZBIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:08:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB593455
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGtaTJ031464
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rloVwIFmva/Mw8+w//LHl9STezmnJzPW30nB4MxWxeg=;
 b=LMX7bFMBChiFKnvLc7zxxRioAWJzpqw1184RAgHobRms8gu6TiqAFnL9jgNIx+jUQ1ja
 4yqnxP7GkIDRIkWDmsQ/CyASx91wMmSabPLUdP2wNw90w9d4cCzaa5xGbTQ5ahtI1QLq
 vEC/FltPS68w6mnSSVGEi5IObPvyCxZRZ8g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9bky7667-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:40 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:08:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 30C3145C0BE0; Wed, 25 May 2022 18:06:20 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 9/9] fs: add support for dma aligned direct-io
Date:   Wed, 25 May 2022 18:06:13 -0700
Message-ID: <20220526010613.4016118-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HyVoCg5_iLmfKpf9h1ZPNJtZHPjzFTFR
X-Proofpoint-ORIG-GUID: HyVoCg5_iLmfKpf9h1ZPNJtZHPjzFTFR
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

Use the address alignment requirements from the hardware for direct io
instead of requiring addresses be aligned to the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/direct-io.c       | 11 +++++++----
 fs/iomap/direct-io.c |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

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
--=20
2.30.2

