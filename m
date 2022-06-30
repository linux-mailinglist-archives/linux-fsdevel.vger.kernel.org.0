Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F6562483
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiF3UnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbiF3Um5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA9646F
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:56 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UJCLq3004575
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Un4NLPzCwa9kRECQYiM/bb2nQGDf07xC9htX3/5DtNA=;
 b=ek3A4jZu7HYu0B2lUbVx87zg1N2CK9KDJ7Vg5nwa6+xnHz8tqpDYALGsIleQ/ZLzQ72Z
 zMZh8d98Tk2VWQ9QzrkleZSsCwgArhgxnGQtJ9KZQgGy6MEZcYPF3GrYJtkVhtij7g9o
 4VhPhrVJIiMsiJmws3pssN82ePFS+sbnp8k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h195a4pwy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:55 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id F00125932DC1; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 09/12] block: add partial sector parameter helper
Date:   Thu, 30 Jun 2022 13:42:09 -0700
Message-ID: <20220630204212.1265638-10-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7QBJuh0uzl96SK4Ovhwpy9TTYL_lK8Dp
X-Proofpoint-ORIG-GUID: 7QBJuh0uzl96SK4Ovhwpy9TTYL_lK8Dp
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

Check if an iov is a read, and aligned to a partial sector access. If so
set the skipped and truncated bytes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4396fcf04bb8..e631cdd01df4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1362,6 +1362,27 @@ static inline bool blkdev_dio_unaligned(struct blo=
ck_device *bdev, loff_t p,
 		!bdev_iter_is_aligned(bdev, iter);
 }
=20
+static inline bool blkdev_bit_bucket(struct block_device *bdev, loff_t p=
os,
+				loff_t len, struct iov_iter *iter, u16 *skip,
+				u16 *trunc)
+{
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
+
+	if (iov_iter_rw(iter) !=3D READ ||
+	    !blk_queue_bb(bdev_get_queue(bdev)) ||
+	    iter->nr_segs > 1)
+		return false;
+
+	if (!iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
+				 bdev_dma_alignment(bdev)))
+	        return false;
+
+	*skip =3D pos & (blksz - 1);
+	*trunc =3D blksz - ((pos + len) & (blksz - 1));
+
+	return true;
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2

