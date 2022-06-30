Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7256248F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiF3Um6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiF3Umw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CF2710
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UGtHe1008865
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/AoFdluhF2czs8dvlXSuREPByuhGsHBb6q128LYMYJc=;
 b=ibi9lGKOhhtzZuPtZnGVhjlC3gBRXS/vuGDNFHnQJAEFNLNO0ZRFldY12pIPxbk7qzpc
 /FCKuZeW6yBWzPg29oGTYovrN/0fpOCZ79vMWF4zLGDwrtBWQuI1E5TXn76gvzGoRMTX
 0U7sjL1gJERRd13Kx+m48IDgJKd6OyizVko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h17gewyms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:50 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id E1C3E5932DC0; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 08/12] block: add bio number of vecs helper for partials
Date:   Thu, 30 Jun 2022 13:42:08 -0700
Message-ID: <20220630204212.1265638-9-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ef314TpclO3i7wtmXNK_66nuLIUxGfl1
X-Proofpoint-GUID: ef314TpclO3i7wtmXNK_66nuLIUxGfl1
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

Bit buckets get their own vector, so need to allocate enough to hold
both the preregistered bvecs and the bit buckets.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/bio.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 992ee987f273..ded38accf009 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -452,6 +452,17 @@ static inline int bio_iov_vecs_to_alloc(struct iov_i=
ter *iter, int max_segs)
 	return iov_iter_npages(iter, max_segs);
 }
=20
+static inline int bio_iov_vecs_to_alloc_partial(struct iov_iter *iter,
+						int max_segs, bool trunc,
+						bool skip)
+{
+	if (skip || trunc)
+		return min(iov_iter_npages(iter, max_segs) + skip + trunc,
+			   max_segs);
+	else
+		return bio_iov_vecs_to_alloc(iter, max_segs);
+}
+
 struct request_queue;
=20
 extern int submit_bio_wait(struct bio *bio);
--=20
2.30.2

