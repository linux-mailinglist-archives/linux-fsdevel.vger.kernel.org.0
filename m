Return-Path: <linux-fsdevel+bounces-59375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFAB384A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10367B2F67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527E35A2B8;
	Wed, 27 Aug 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="s/yuSPnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D735AACD
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304004; cv=none; b=ALm6bIA5apKy9UAiVX8Q3tPovQJizy8yeIXcdPTPJwDEDxM4O8bNyFJ+tgDqwqTB4VbpO1WXdXg3bYDD5JJ6wisMmKYbsXuz665FO8/1brGSbtGs5W/qbYGSH1hBmJ++0hCUyIWuSCeWOrJ8ZHj1OLtEJ4zXLo3D1djLLLBrMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304004; c=relaxed/simple;
	bh=atJOODdClqHiyWABtn7H99XGCZCvMKi85VrukrFv7JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeWI7yxNZytvjCQtkx3LlF/NRuzsTc+TyL/t3Y/aNr3YCLI+yH3J/srU+FWZ+MWu6lfiXcgYFobJwNRmvHC02P1vv8fb90SckQvD1O3zSdDBiVVmbDZiWkcI1f8gi0BWr88KjA6Lfvph7fsYkUVriF3puRAacvnxfPr0HD4klJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=s/yuSPnT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R7vwcp1426096
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2i4RKxVSmTVz22+jjLC/Bkwn43paFJfceol2ANqhmp0=; b=s/yuSPnTmTQY
	pI2eHsMCwjwuP//kGstYYD/57RtV7Zo29w1vD53tM8ob39g49BYDB9oinvyOhS/H
	H/S6Wn1azBlfKQUfeNafyvTzQFyXE0Mcu/iBnnA1CGropzltw7x7o858JCPJETjK
	wzkSjGYaFv7DMtIFtmd+FaR+CB0c23OvP7CP0EWOsr9W2adxdGSGfXtRSsIa3kv3
	DNL1x6X3r1nu28tJNsgaXrLJQ1PfI3RGUj9dtbsgqLAPWzNJ57DCq+VXUfEBYYqF
	U7cyrS5O6ALD48pX3uTe7NVtJE0FAAsmQf5gvhQF5BC/5nxpQUfPoU32wEi2SQUM
	2xR1Njm0uA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sx3bhvgy-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:17 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B16AA10CF621; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 4/8] block: simplify direct io validity check
Date: Wed, 27 Aug 2025 07:12:54 -0700
Message-ID: <20250827141258.63501-5-kbusch@meta.com>
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
X-Proofpoint-GUID: adCfz-p5w0pcbnZopz2cdC6afXHHjax5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX4MPbnciTymgu
 R8y50oDLvOrJDiyqLTXCPAsPi6+TWZ042N3PXTMZ7T0yAWnWiWFQ05G6lBr6y4Ugh2Cs+YnHVGj
 X3FL1JwDrBmpq0cPSbaK6Mtu9Vfv7es+AXfSppYULfAXEkceVNcnE/ri3e3v7WPGX4ZRA1X6BbN
 pLqyxWGzM0vzuUvQOlwxl6bOqsplawcx2Xd/LGNlh2x+H0xskEo3b9c2j54W9fHeINpRjN6VAsg
 DTe1MT2dMD4KbuDbKURY/SPqOftc0RQ9EbgdwdSUbE19bygFvkE3qvz4m1g4TL1s/Dfl4QCuLBh
 NUW7usUo73k0CKL81VBLk5TGfk4P4vLLCd1q6F1AXgway7AFJOy/gWhNlBafG4=
X-Authority-Analysis: v=2.4 cv=B6u50PtM c=1 sm=1 tr=0 ts=68af127d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=wgemLMbJKI-cAGOf0tMA:9
X-Proofpoint-ORIG-GUID: adCfz-p5w0pcbnZopz2cdC6afXHHjax5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
check, and defer the more invasive segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d136fb5f6b6ab..19814bddd77e2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *=
iocb,
 				struct iov_iter *iter)
 {
-	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
+	return (iocb->ki_pos | iov_iter_count(iter)) &
+			(bdev_logical_block_size(bdev) - 1);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
--=20
2.47.3


