Return-Path: <linux-fsdevel+bounces-36593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA999E63B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B59D16B033
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5629E15381A;
	Fri,  6 Dec 2024 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="is3SY7wB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71714A4F0
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450012; cv=none; b=B7bnqd+suKvTsiHtrAo1sSTbG27IASiF+4q+yO1YXR7g1+ewsylnbXf8txThz5acm9BUzK1L+mLzL7x7Fo2T5LNrOZ8ssZIJGyVPCTeaS/qxu/GWg9F5PKakKnEk9UQ7IeItq0UjZw7u/45E+GVMEixeRuOT9C12cuTsUIhQSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450012; c=relaxed/simple;
	bh=5JWKIlok/LlWB3ujWNzJ8mifN5u1BcG97Q8pMGFe0PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzoR6QZS1bqggKxc5qjjnXLZtwUrEPr6VhAme/Jo6qaUzJQyHJ+UbQWIpd6d3XBfsCn5z0pf5F9Yc1ijzix5AhkxVQKHrIxhmhFgP9htc1GzYLCmP/4AlhUdI0GkyVW6UWe29snp/0Ut7KCI+6sxOibYtwINA0U46AKuehj7/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=is3SY7wB; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B605dJ3013872
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=IaesBJajvy2XJvCSejkRh5S+DvrgGK6zlymIWSzBoyc=; b=is3SY7wB49cy
	EB3OemMXg+FNcvfC0dgf5GMZTFf6pnI99KR76zYftHDeQ7bGB3NqAP4UY71yz0dG
	S9zrdssa03GK8kQ2590zIsilbxmzWL2sKBJAbbBvCASlQmyxmwsMdxjzDnuFKL7Z
	MuZMI9nvgtOQOkJ+B0GJ9Dp8Fg+Pr1btASr8L1inX3muUIiFpvImqNpo5a3mAeUC
	XMXE3U93+E5VkvhZ66GUFov4hYAJpIYQFmDshZ5em28MTf/udZR+Atkh84s6c7nS
	KjWdwOrRCdpgxpA0jH9Hu0NhVvKn3C4GKluIPk7A5bLEcekI/lZpnaiBYlM44uRx
	3gZn68x22Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43bmrwh5m0-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:29 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1ADCA15B21151; Thu,  5 Dec 2024 17:53:09 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 04/10] block: add a bi_write_stream field
Date: Thu, 5 Dec 2024 17:53:02 -0800
Message-ID: <20241206015308.3342386-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lS-jTupprrwW8JvEFNeINuyNbR-S3ryJ
X-Proofpoint-ORIG-GUID: lS-jTupprrwW8JvEFNeINuyNbR-S3ryJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Christoph Hellwig <hch@lst.de>

Add the ability to pass a write stream for placement control in the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 4 ++++
 block/bounce.c              | 1 +
 include/linux/blk_types.h   | 1 +
 5 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 699a78c85c756..2aa86edc7cd6f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_flags =3D 0;
 	bio->bi_ioprio =3D 0;
 	bio->bi_write_hint =3D 0;
+	bio->bi_write_stream =3D 0;
 	bio->bi_status =3D 0;
 	bio->bi_iter.bi_sector =3D 0;
 	bio->bi_iter.bi_size =3D 0;
@@ -827,6 +828,7 @@ static int __bio_clone(struct bio *bio, struct bio *b=
io_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio =3D bio_src->bi_ioprio;
 	bio->bi_write_hint =3D bio_src->bi_write_hint;
+	bio->bi_write_stream =3D bio_src->bi_write_stream;
 	bio->bi_iter =3D bio_src->bi_iter;
=20
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 29a205482617c..66762243a886b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -173,6 +173,7 @@ static struct bio *blk_crypto_fallback_clone_bio(stru=
ct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		=3D bio_src->bi_ioprio;
 	bio->bi_write_hint	=3D bio_src->bi_write_hint;
+	bio->bi_write_stream	=3D bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index e01383c6e534b..1e5327fb6c45b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -866,6 +866,8 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
=20
 	if (req->bio->bi_write_hint !=3D next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream !=3D next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio !=3D next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -987,6 +989,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *=
bio)
 		return false;
 	if (rq->bio->bi_write_hint !=3D bio->bi_write_hint)
 		return false;
+	if (rq->bio->bi_write_stream !=3D bio->bi_write_stream)
+		return false;
 	if (rq->bio->bi_ioprio !=3D bio->bi_ioprio)
 		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) =3D=3D false)
diff --git a/block/bounce.c b/block/bounce.c
index 0d898cd5ec497..fb8f60f114d7d 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -170,6 +170,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_s=
rc)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		=3D bio_src->bi_ioprio;
 	bio->bi_write_hint	=3D bio_src->bi_write_hint;
+	bio->bi_write_stream	=3D bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
=20
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7e..4ca3449ce9c95 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,6 +220,7 @@ struct bio {
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
 	enum rw_hint		bi_write_hint;
+	u8			bi_write_stream;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
=20
--=20
2.43.5


