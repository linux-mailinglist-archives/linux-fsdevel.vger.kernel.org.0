Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A447562480
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiF3UnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiF3Um6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C862710
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UF76Bb021139
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/zU7PuiJ1KZ8+CVYUOg4nHq63Q9/stHoIw4yuqAbJgE=;
 b=GzX0fwCPvDst6W+MHhoP5cIyjQQ42Dt5FWXyLp14pumO7yb0Nma1gx6jEa/eaHQ2Aeon
 3OuFSazJgTp3++dJT0uTfzpFU3iY8c8nDeGC7eFGE+Di05ZXI6Aa+R+DD92RGfCMDWcd
 fsQStzlV/7l0E5m6TmbITyy3qRo1QuyBrUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqwy2u-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:57 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D79595932DBF; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/12] block: allow copying pre-registered bvecs
Date:   Thu, 30 Jun 2022 13:42:07 -0700
Message-ID: <20220630204212.1265638-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -C-g7jKYmtenXrVF9u9bkBBGBAKR4bqn
X-Proofpoint-GUID: -C-g7jKYmtenXrVF9u9bkBBGBAKR4bqn
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

If a bio was initialized with bi_max_vecs, then append the requested
bvec instead of overriding it. This will allow mixing bvecs from
multiple sources.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b0c85778257a..391cad726ff2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1130,12 +1130,25 @@ void __bio_release_pages(struct bio *bio, bool ma=
rk_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
=20
+static void bio_copy_bvec(struct bio *bio, struct iov_iter *iter)
+{
+	memcpy(&bio->bi_io_vec[bio->bi_vcnt], iter->bvec,
+	       iter->nr_segs * sizeof(struct bio_vec));
+	bio->bi_vcnt +=3D iter->nr_segs;
+	bio->bi_iter.bi_size +=3D iov_iter_count(iter);
+}
+
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	size_t size =3D iov_iter_count(iter);
=20
 	WARN_ON_ONCE(bio->bi_max_vecs);
=20
+	if (bio->bi_max_vecs) {
+		bio_copy_bvec(bio, iter);
+		return;
+	}
+
 	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
 		struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 		size_t max_sectors =3D queue_max_zone_append_sectors(q);
--=20
2.30.2

