Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D5B531D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiEWVB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiEWVBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:01:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8614FC46
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:51 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGd7v025899
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MuvN3ozMauA3nHBRAqMRRKMOhmhpA4TYHL+gbOVraQs=;
 b=rLy8RcDLqUnnjOQC4x96EhctvYFw8UVvu69bkubM2RolaydvQ7Q5CXQQ4Pm26PApI1q6
 OYv4zeJoEDq2OZC77/QZDpgGU2Q4cN5PYGm12xLMHdw7kThl2Fuc7AWQNA3MI9AVjfR5
 C4D1DR23YaFNt7Ifj+3WJ+KJxIpSk9z3CsU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6yd3bh09-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:50 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:49 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C170B4464157; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 5/6] block/bounce: count bytes instead of sectors
Date:   Mon, 23 May 2022 14:01:18 -0700
Message-ID: <20220523210119.2500150-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210119.2500150-1-kbusch@fb.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0qz5CBzzmFD70vjsrWnFODqX9-9UOxic
X-Proofpoint-ORIG-GUID: 0qz5CBzzmFD70vjsrWnFODqX9-9UOxic
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

Individual bv_len's may not be a sector size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bounce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 8f7b6fe3b4db..20a43c4dbdda 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -207,17 +207,18 @@ void __blk_queue_bounce(struct request_queue *q, st=
ruct bio **bio_orig)
 	struct bvec_iter iter;
 	unsigned i =3D 0;
 	bool bounce =3D false;
-	int sectors =3D 0;
+	int sectors =3D 0, bytes =3D 0;
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
+	sectors =3D ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> 9;
 	if (sectors < bio_sectors(*bio_orig)) {
 		bio =3D bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
--=20
2.30.2

