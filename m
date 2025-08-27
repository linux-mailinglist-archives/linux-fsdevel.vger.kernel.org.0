Return-Path: <linux-fsdevel+bounces-59380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9CB384B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D401885473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA435CED1;
	Wed, 27 Aug 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bC/BpT8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7135CEBE
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304012; cv=none; b=rDa+Xp7wpT+hKGGj/CsMiYIHgL4mpmSKf3PXUAuH4zxL/ibIeRj9R962PPu55tbKy5uPuBLevfqFCgdT96TGf6TPf50xuZyHIw0MADSicb7cZYe6cZ1OgM1ye9UQjbw6q9MPeWWFTNQrrDab9bD9ov2UD10StERiE25prUPhmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304012; c=relaxed/simple;
	bh=hNWh89z7bVho/nucDYtzmjo0CgvLk3JXnCFimcvoW48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUTpThPdoorvIIOryGcaFJSA5Uhngu89RHYcCCkky8BWKl5p1ccPR+Wjm5+Y2f+4pML3JyE6R0M/73JgxwUj4Con82xjU6p0DkYmev9kOhUlCQAKcqqawtQaqWZcZkS0C8cAFu9ZinkqLre2udROCYRNiDO889KKlgv0cLQfRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bC/BpT8Y; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R4s9Ee763685
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=TvAw+PhgN5KIMKT9wim4ffyA9Ijp09dFqqsdzWDRAtM=; b=bC/BpT8YEIRS
	0ZSTq8zY4hHjzHh2iyu7vjxwsZ98WtSFlCrfK3r7G8Gk6Se2r94lagSoSxON+DvL
	mAlPkMVgqdpHr33b1rww/IJEHR/vxXXZlA72oMPxmoLAtm5bRExzKdZhst/3SBJ8
	88gOBN0E72i+MejIfwKfPGLNsDRwTwMIjdqZoxURm+a+lur/Wg4NzwESM5OhTBdL
	pjRB80fwTyK2oAzxHCebNiqosYcavSy3Zm9LbbN+Dl8G2n1YD2BZl8fQlHqm57Co
	Q9py5rM9h9wzlDkTR2eFN/7dUfipFwyZT0Qvm/LI0Sm4N28FBBmfJI7pCwCMQF7t
	M2+pXC8r1w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sud32jy8-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:26 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EB42010CF629; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 7/8] blk-integrity: use simpler alignment check
Date: Wed, 27 Aug 2025 07:12:57 -0700
Message-ID: <20250827141258.63501-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 37RgEhcntXCooVfNJW89OLuoy3LP6za3
X-Authority-Analysis: v=2.4 cv=PqeTbxM3 c=1 sm=1 tr=0 ts=68af1286 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX7ccMTruXT8+a
 TVTn28myvzgC0B2kfjb4eAgKVwPLt/2Ch0MWYz5qSxK7/dEF9T718VqKpLeFVQe+WXYwdroSmjB
 v04A0lX8zVVHtGsE0eZURi0ESgTYq8zdGpXKybYQu+TG+iJjwLac5CHxxMphJkDpbUtWNT0pICF
 17lbrsGRAJ7lJQw3ZhEt0NCKaRj37X/oCOstYZf0E9Lwv4NdC6mxQoEuXEghwhyyKjoujjYZi3/
 mBR7JRRi4LofDUC/lpcHC07EoCXbjVuODBXUhS4qTsqwuwSqAgXq6k9YjwFPFYZQFYTz4e0KICi
 V03afRHDfD9meOF3zn1BYBIffpxEb5H/2BHho3w1xiSjBC4RfBbL2kZsgCYhvM=
X-Proofpoint-GUID: 37RgEhcntXCooVfNJW89OLuoy3LP6za3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


