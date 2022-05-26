Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462EC5347D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiEZBIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 21:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiEZBIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 21:08:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD09156B
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q0SitE029091
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ng5jvbQ8e5kkQ3+8JRxl9hl6c4zipP7NfhMRhPIwcAQ=;
 b=G0/oah+kRKu/W1WggEFAxp6KmjshoKODoYEYfUvKn7tRqDwhgev6URHqwRJBe579q7ki
 y0DAKmYrS+WTbbHut6WbhRVixUIS4FrbsehOxsPjGx5oVKBlaMP9K4OyV1wMlR5SkmF0
 NZyOIYaQkpEF7CXYy/AOIj18STttQBC7NfU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g9puakqat-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 18:08:37 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 18:08:37 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1A68045C0BDE; Wed, 25 May 2022 18:06:20 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 7/9] block/bounce: count bytes instead of sectors
Date:   Wed, 25 May 2022 18:06:11 -0700
Message-ID: <20220526010613.4016118-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526010613.4016118-1-kbusch@fb.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZIkqqdo-D413R1sw_fZfo-_Ivov0aq-T
X-Proofpoint-ORIG-GUID: ZIkqqdo-D413R1sw_fZfo-_Ivov0aq-T
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

Individual bv_len's may not be a sector size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Use sector shift

  Add comment explaing the ALIGN_DOWN

  Use unsigned int type for counting bytes

 block/bounce.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 8f7b6fe3b4db..f6ae21ec2a70 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -205,19 +205,25 @@ void __blk_queue_bounce(struct request_queue *q, st=
ruct bio **bio_orig)
 	int rw =3D bio_data_dir(*bio_orig);
 	struct bio_vec *to, from;
 	struct bvec_iter iter;
-	unsigned i =3D 0;
+	unsigned i =3D 0, bytes =3D 0;
 	bool bounce =3D false;
-	int sectors =3D 0;
+	int sectors;
=20
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_VECS)
-			sectors +=3D from.bv_len >> 9;
+			bytes +=3D from.bv_len;
 		if (PageHighMem(from.bv_page))
 			bounce =3D true;
 	}
 	if (!bounce)
 		return;
=20
+	/*
+	 * If the original has more than BIO_MAX_VECS biovecs, the total bytes
+	 * may not be block size aligned. Align down to ensure both sides of
+	 * the split bio are appropriately sized.
+	 */
+	sectors =3D ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> SECTOR_SH=
IFT;
 	if (sectors < bio_sectors(*bio_orig)) {
 		bio =3D bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
--=20
2.30.2

