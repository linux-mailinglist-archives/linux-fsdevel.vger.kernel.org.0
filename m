Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9668760E5D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiJZQwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiJZQwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:52:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B68D7D7B8
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 09:52:07 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QFxuGl014138
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 09:52:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=yweTIcEEup4K70R2eq07Kp6EbZy543M8HDS4MaHQouE=;
 b=KeqUX9C6evJ19CNbkIyX//kFQ00xpDB38KH+ya2Mr46EC9xid+R9Iyq/WJq/bRXP7Wmv
 nDNsjRYgZoBPj+EuhQjTWXQsKGUTf5DZ41wlCK9YNhyemfbzFNFRexRHod11QnxjHrIB
 KP6itgP7A9mfGsff/hc8vbbNkuiRVMDeJjQp88b2iSRKSoadkEgrh3JfbKz/HV68M3Kg
 UQMQe9Qy3FPqXgxRVxYGBliC8Sn85ZBfjaVvGln3mr1oHM/JfjPBnUXyK1wQ/H9SsD7a
 cI1f30DSA2q95nwQN+rHl2R/QHhbvtM+HPXTBHhYiUKogJA2fFJ1UmGFLbDYChuMDgxN Ww== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kf4y2tm6e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 09:52:06 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 09:52:03 -0700
Received: from twshared13927.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 09:52:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5F861A4B1E3F; Wed, 26 Oct 2022 09:51:53 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hch@lst.de>, <djwong@kernel.org>,
        <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] iomap: directly use logical block size
Date:   Wed, 26 Oct 2022 09:51:33 -0700
Message-ID: <20221026165133.2563946-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vG6frEBybfhVsdjheLPSfRDxEVHbvRJQ
X-Proofpoint-GUID: vG6frEBybfhVsdjheLPSfRDxEVHbvRJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Don't transform the logical block size to a bit shift only to shift it
back to the original block size. Just use the size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9e..503b97e5a115 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,7 +240,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 {
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
+	unsigned int blksz =3D bdev_logical_block_size(iomap->bdev);
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -252,7 +252,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & ((1 << blkbits) - 1) ||
+	if ((pos | length) & (blksz - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
=20
--=20
2.30.2

