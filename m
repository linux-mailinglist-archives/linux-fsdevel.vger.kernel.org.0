Return-Path: <linux-fsdevel+bounces-33122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C19B4D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13019285509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2E194A52;
	Tue, 29 Oct 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ho3jedvR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDF1946A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215194; cv=none; b=brcdsetiRwvL+ygHzaRW+RnrH5bKKHHNG4RuM0WsnR6MyzZAF7x8JWZ6xOLY+WBOqe3xcQ86g/3oeNtfOLCLyXZoXwfFIEs8gMbmeqbFmpA3MFXMZFnKMu+8+UAt+TPKPPP+BALs1cXndtO9zWCH8q2R19faeZvV01yQeRpK0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215194; c=relaxed/simple;
	bh=GD7uThjhDzyP28oGcsmN6/eNWGUs4YiXhY9KVTQmUTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec7FTy8BVcEP8vLHb+iBn8kCfce9C5Ftc5JoPbpX6QFzhI1n/79ui1UOP8IXmb7SVdi49iEX/0Mhhi1M4yCL6XoyZnzWCx9hNTBriVBDBqIwEXq8vEnLWuxHELdsKhKWw2dIfB3+8bXx84/hd7Mk6ykKiMihWp3rae4ytFx/i7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ho3jedvR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEaXlj009750
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=7vuu9MU8HwzONpvRjqiHwphNE/Y6asPy43+abByRhi8=; b=Ho3jedvRtHL/
	2BIwDRamOsQyk4bI0ern4VkA0Sgxm9CGZRA7LFeFM/8Sokt+oJIFrVBgg57/ro6e
	4EH2C4uv9ohV4DiI0t2VJPll7Y/ADbUIFNUXC73O4eG+kCJ+k32fnuq7yEWH6mI1
	6jgMa4/ZNWPvHbifiA3s/NzfL4/pyx1jrMQ8FzfnXY4Ua8PkGZ2NGye+XnKOnDoY
	MunY6kSk8oQ6fE/krdLzs2hnL0SdZm26LjcVGXStmKbejOYv+Pv6jVtKQihIvBct
	1JchLnv0UC4SysCD62DjH6oJuE8WGuLE79n5YhuhjiRqb2rAOado9J+P8rQCM8xY
	e8v7XR8gNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42k1m9rd37-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:51 -0700 (PDT)
Received: from twshared26373.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1676C14920EA5; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 5/9] block, fs: add write hint to kiocb
Date: Tue, 29 Oct 2024 08:19:18 -0700
Message-ID: <20241029151922.459139-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5l7XokHU0cJ_XoK-fGQBel2-SeiLpKkR
X-Proofpoint-ORIG-GUID: 5l7XokHU0cJ_XoK-fGQBel2-SeiLpKkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

This prepares for sources other than the inode to provide a write hint.
The block layer will use it for direct IO if the requested hint is
within the block device's allowed hints.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c       | 31 ++++++++++++++++++++++++++++---
 include/linux/fs.h |  1 +
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 2d01c90076813..bb3855ee044f0 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -71,7 +71,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
 	}
 	bio.bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
-	bio.bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio.bi_write_hint =3D iocb->ki_write_hint;
 	bio.bi_ioprio =3D iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |=3D REQ_ATOMIC;
@@ -200,7 +200,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
=20
 	for (;;) {
 		bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
-		bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+		bio->bi_write_hint =3D iocb->ki_write_hint;
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
@@ -316,7 +316,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	dio->flags =3D 0;
 	dio->iocb =3D iocb;
 	bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
-	bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio->bi_write_hint =3D iocb->ki_write_hint;
 	bio->bi_end_io =3D blkdev_bio_end_io_async;
 	bio->bi_ioprio =3D iocb->ki_ioprio;
=20
@@ -362,6 +362,23 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb=
 *iocb,
 	return -EIOCBQUEUED;
 }
=20
+static int blkdev_write_hint(struct kiocb *iocb, struct block_device *bd=
ev)
+{
+	u16 hint =3D iocb->ki_write_hint;
+
+	if (!hint)
+		return file_inode(iocb->ki_filp)->i_write_hint;
+
+	if (hint > bdev_max_write_hints(bdev))
+		return -EINVAL;
+
+	if (bdev_is_partition(bdev) &&
+	    !test_bit(hint - 1, bdev->write_hint_mask))
+		return -EINVAL;
+
+	return hint;
+}
+
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *ite=
r)
 {
 	struct block_device *bdev =3D I_BDEV(iocb->ki_filp->f_mapping->host);
@@ -373,6 +390,14 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, =
struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
=20
+	if (iov_iter_rw(iter) =3D=3D WRITE) {
+		int hint =3D blkdev_write_hint(iocb, bdev);
+
+		if (hint < 0)
+			return hint;
+		iocb->ki_write_hint =3D hint;
+	}
+
 	nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <=3D BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4b5cad44a1268..1a00accf412e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -370,6 +370,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u16			ki_write_hint;
 	union {
 		/*
 		 * Only used for async buffered reads, where it denotes the
--=20
2.43.5


