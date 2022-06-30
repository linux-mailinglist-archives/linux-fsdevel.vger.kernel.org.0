Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6389856247C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiF3Umz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbiF3Umw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF8E6426
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:51 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UGYCt1002690
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IzuejAZDXVoGY3HRUSZnk1+5V9y94rIoG6LLgWhRwEE=;
 b=SlUBWCdviGqGE1WMXHze8ouHun4HiWUxERQZZdyyO2ELdOV9nvt3yQex7RJzcLig7Ddb
 BZb8x+q6GlVJT4IXTvwEtU7NEUR6+Z/kp0JBWHFjXdKilZTX3z9aKTORfHWgmD497k4P
 5AnmJXq0vTXXhTITAG2TeADrC4P3ziStfhQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h150eebcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:51 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 575A65932DB9; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 03/12] iomap: get logical block size directly
Date:   Thu, 30 Jun 2022 13:42:03 -0700
Message-ID: <20220630204212.1265638-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DMpPWn6yhhMl0EO8kWVJfQiREeiW1ZSD
X-Proofpoint-ORIG-GUID: DMpPWn6yhhMl0EO8kWVJfQiREeiW1ZSD
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

Don't transform the logical block size to a bit shift only to shift it
back out to the size. Just use the size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d478a95efdf..40cbf2025386 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -241,7 +241,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
 	struct block_device *bdev =3D iomap->bdev;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,7 +253,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & ((1 << blkbits) - 1) ||
+	if ((pos | length) & (blksz - 1) ||
 	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
 		return -EINVAL;
=20
--=20
2.30.2

