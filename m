Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91E618322
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 16:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiKCPoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiKCPny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:43:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C41C91D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 08:43:47 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3F1JMw008172
        for <linux-fsdevel@vger.kernel.org>; Thu, 3 Nov 2022 08:43:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ghCshfUGaEw/Q+3k/HGBASfyf6E51G+0Npso3iy3cZc=;
 b=CPM3rt4h/kjNRH4+T9Jq/yi9Zw04cOyPDQO/qIT6ewQtU5rCNMpXM06wCBv/r4L1O8EI
 eQxud4qVLC4129GkuvwXTYroYK0P7z1KzMbEeYzXiqHJE2DNX9kxScl5RSF04H6X7fg4
 cz2TPmC68stWuXfRJIozhIZsGGWhYCbqRT7bFS/4fyONG11ESqjx9bdP4VcMVzb4FXfc
 XVOY7ZDZXem7j43+oGdglJ1n7YZ/hfz3zHsbm84Yjae4rh75J0drr1SEvy0Ajt0wdEAU
 bSpWcN4bTvtDreTBxhods2ryAUVfIc06j0s34WMqzeIYYsTYcsGPOt3qSJCZMkxWVca0 CQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkrv54ctb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 08:43:46 -0700
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 08:43:45 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 50B53AA9DAFA; Thu,  3 Nov 2022 08:43:40 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCHv2] iomap: directly use logical block size
Date:   Thu, 3 Nov 2022 08:43:39 -0700
Message-ID: <20221103154339.2150274-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QtaoSa3siic5dDMpE2stL9gumpfVQ_R_
X-Proofpoint-GUID: QtaoSa3siic5dDMpE2stL9gumpfVQ_R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Don't transform the logical block size to a bit shift only to shift it
back to the original block size. Just use the size.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Get rid of the temporary variable since it's only used once (hch)

 fs/iomap/direct-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9e..9804714b1751 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,7 +240,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 {
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -252,7 +251,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & ((1 << blkbits) - 1) ||
+	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
=20
--=20
2.30.2

