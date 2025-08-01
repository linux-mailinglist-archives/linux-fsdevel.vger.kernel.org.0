Return-Path: <linux-fsdevel+bounces-56544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF97B189A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EABF5A2429
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A93291166;
	Fri,  1 Aug 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zxl0xZSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB962376FC
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092079; cv=none; b=LmMQITvjbBrKD/2NssRs9ueZKSQ1iDlmCrJ3wPIIc5tv24/jMol/U5easaiWSwAdyze3Co2O21j5SYIuV4SmHiIFnK7f++ViAIpuybOTfuL66eYNGUbk9FezdYD2hxt2juA/Ry4wdG+k+Sty2f/Ng01ofvS45iPU+7XheNqdGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092079; c=relaxed/simple;
	bh=OMeezIS6H4pb0DAO1sPwLmLYxQE9W3UpuZAe54uaBm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYqFIQcUPXaOZ1LGXbv2+THX14Hw7uJq56xjerfad/zdUR/uuhtOTIZAtpk2ytfdtaOedxk9XeE2JMkAsQF91ZOxInZOJqbaRO339DUWyg7Y1U5rCNtTGboZLi1HiPndvXbQSIvS3mQOlXDrHhqg6CiebrxD+fc7blafyno4fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Zxl0xZSa; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MqFEM027978
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pnnkPBGQ0gRBLybx/TION3BTRcap0tbm0RMeiLyF+rc=; b=Zxl0xZSaUwtj
	aBOHhx32Oa8mYi4FkV+U3tNqJj36xQOgeLkrCxjO1iZY3cl+cFiwC8ShlJ0gE3H5
	yj9G5yp3uVPHxvOSTLtrUIga7E1JljZJOwAUHfSfKpqYQNMPImidO3lartdHxaKv
	i1kWYO1PGA3tvkVPPvzPZNaFvBIQvYSSiaGtYdmF6Fari8NvVkdwXqTIISeWlOkT
	F3/ckY4e8N2Z4r24yLl6qzWNqaaSywTY6q0k+zerMLgP4kJbvqbYnlSZNemnEjJC
	BOZBgaAaDmqafvDyLKrlbBHdO41WHbU8yRKWkqZBbAz/zYrA/dMsEgcPLZDxnnkJ
	v+GwUkIbVA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 489286t1ts-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:57 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C96753105F6; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6/7] blk-integrity: use simpler alignment check
Date: Fri, 1 Aug 2025 16:47:35 -0700
Message-ID: <20250801234736.1913170-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
References: <20250801234736.1913170-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX6OcUKDrGUW2u CwSX/fGrKZ5NcAPaVRscFXwR35DAuRs62TTirIo+PJyvKnKge8rHADn5dSIfUwyOnUSKfD2T7qw k3bqkH3AFlcNN0jNkCjumqJIJUvKWs2n2IAZrJDAcbrsXd68UWRAPIYQdyVlslziLzh4PPOIOSd
 NAymrfKQoZaQshhAtc73Evwy/7lvKQlOR+n1bs8PL9CiEKhLwl84bvqmd+PIp5X+frOinkcPt0a fxcupr5Y1brtTyvBqAndkLf9uH9N2gV3N3t7SVKs843Q/nDbQKOXNvH6jPo/LZ+8UFhZQbWrDF5 c+CqsID2/CezIkDAjv/z/wJaOy7pZ1greK5Qtbo2w1qinP4/cMyH3sPFoLlBiY/zIxHB/VFTCv9
 /RSAP2CrJ6+I5yykI4JDwBnAgZ5ZfxrLGGL8VNkm+1LtTNzkknAavux73aLSCYvk/NVD7WcT
X-Authority-Analysis: v=2.4 cv=ANL1oDcN c=1 sm=1 tr=0 ts=688d522d cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-GUID: ZdJTLSCx70yby1zmgIpHAxb9eq1vGg3C
X-Proofpoint-ORIG-GUID: ZdJTLSCx70yby1zmgIpHAxb9eq1vGg3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..6d069a49b4aad 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -262,7 +262,6 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
 	size_t offset, bytes =3D iter->count;
@@ -285,7 +284,8 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
 		pages =3D NULL;
 	}
=20
-	copy =3D !iov_iter_is_aligned(iter, align, align);
+	copy =3D iov_iter_alignment(iter) &
+			blk_lim_dma_alignment_and_pad(&q->limits);
 	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
 	if (unlikely(ret < 0))
 		goto free_bvec;
--=20
2.47.3


