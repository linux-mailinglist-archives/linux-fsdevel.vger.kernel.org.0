Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6E56247F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiF3UnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiF3Um4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B3E87
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UFDOec009461
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HUKpLb6JXEKmTJ5lKkPoJzYMJoy996fk0USUyFanhJ4=;
 b=No9ShFEhPbtaMuDPoG7tj+iRu2Tlj7cZpA+ZuBaA2IurJtG6ueraW1U4GqaAveht1dqe
 SXl0KJE36C4QR9ypmk3tZ9f6ZJM4F6dlR6WJEblESHBCE2XYCB+r8uO+SVrGNojMzP9u
 FfSuCeg49qLwpYIez6V5aMqac0abdPWONUA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h10tfq1ge-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 987AC5932DBA; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 04/12] iomap: use common blkdev alignment check
Date:   Thu, 30 Jun 2022 13:42:04 -0700
Message-ID: <20220630204212.1265638-5-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oI5UQlDfQ-p03iCvgJaqZqHEog8bdGNU
X-Proofpoint-ORIG-GUID: oI5UQlDfQ-p03iCvgJaqZqHEog8bdGNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The block layer provides a generic io alignment check, so use that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 40cbf2025386..10a113358365 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -241,7 +241,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
 	struct block_device *bdev =3D iomap->bdev;
-	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,8 +252,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & (blksz - 1) ||
-	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
+	if (blkdev_dio_unaligned(bdev, pos | length, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
--=20
2.30.2

