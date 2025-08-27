Return-Path: <linux-fsdevel+bounces-59379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF104B384B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE231B613C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACC35FC0C;
	Wed, 27 Aug 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Go4c14Gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AD35AAA0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304010; cv=none; b=gwIHl8v+wn2I3myhlkdN1azzHUBtlzmJaBdHPfQOOs+GZg7T2ed3SAMzm33bNf+Hsu2IWfeiI8gA6919ZuGipZf5dzhsPwBrrV9W4OFEV8b3DR40JWpgf8Lgae4HWKy2Uqu2GULIUZDrYHbZRAIlcdAsvVKbzrstQ3M0GZF7wAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304010; c=relaxed/simple;
	bh=bcUEMpPiHt7VvaFkp8lNnO1waUmVMZJHfle1D1FOeE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZL9fwqhPNAQ9dNgPsIBqi7xi5pT46kb54ZXcAYvszPEnNRQb6cQEBYhZOISXkdTM8EKAX/PiR9uuC6ksr6ns/gGin6pw/NC2sx598totD9PYUhgf15BGOfl1gUoG4/JuzxIejfzQECDYAy7cW0vlCoulPZRVXqgwuPhe4K0ZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Go4c14Gu; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R8gjBU1314737
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RByCczx/7FpRpdRDsHohLgIVxF5gNPvGUZQEW/OSmVs=; b=Go4c14GuDauN
	lpkXi9njME3o1Pe4J9B17SBQCtGoJ/06GNmJvbA5Bhe/Lw4jSrIhNYxqekOwMcNa
	/nR5PMYNeTpCuI4XxQ2XsBigaEGUC374gxcpAfP9ATFX+UDMfjYqcvqiVCjThmZg
	a3mOfRPUUu6Dl3qX3YJl98Ev4whypz8QtQzh/K8fly6G7UmKqHgQuW10KrL46Am9
	2cKcmR8ngQvmvNocxK8KQ9hChn1+UOQQQSA6uE6rMFnMhyKLmckLZADCZArh0yx6
	fsfK51qktDyVzQvKtx7iyt3RVXC/+oottbe4gd/nbL8L2JeXjKMixjXPPa9NC5gr
	cRjNYkV4/A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sxrdhpky-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:25 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id F25E210CF62B; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 8/8] iov_iter: remove iov_iter_is_aligned
Date: Wed, 27 Aug 2025 07:12:58 -0700
Message-ID: <20250827141258.63501-9-kbusch@meta.com>
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
X-Proofpoint-GUID: jKQzHRzlZCQUtWS6VBAIF833ENtw3tRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX+OhjqodyU5uC
 63p0OnL5uYeQSJ6ZjEyGJG3cJKzdRSdTtLqWc9iBgeUFzbq09UdeQpMaoMH7evu/6WaFLJWZ0l8
 h8UgCWgCoK+QUTmjfivtbx1YaEvyCenf6012Mt16c4Qzkjy9Wgv/74W20c0okUGnD0Dr41koTKh
 vtM3LcQYo4MqwvRTHX3P5ULf9ykjO41/jLyQidzR25+Nv9jM18EvFuhTsc3QjUGcr/huQUaAOYa
 U36ZbqD6ZMqRB1yweokrVvJhBcZv/hD4BXjlovlhDxy1Iy926fOCE4JQ5ehtlLUUJnNsD9l7XgP
 AkgC8zzDC8pmBMtqo2GXdkke04sXZVfbow2t/1BBdC9OEkfrdaLBFyr6GQOYZM=
X-Authority-Analysis: v=2.4 cv=XuX6OUF9 c=1 sm=1 tr=0 ts=68af1285 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=S-mNSWGAXQVMvOK0xjcA:9
X-Proofpoint-ORIG-GUID: jKQzHRzlZCQUtWS6VBAIF833ENtw3tRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h |  2 -
 lib/iov_iter.c      | 95 ---------------------------------------------
 2 files changed, 97 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e86c653186c6..5b127043a1519 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -286,8 +286,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t byte=
s, struct iov_iter *i);
 #endif
=20
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const str=
uct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f499..2fe66a6b8789e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -784,101 +784,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned =
int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
=20
-static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned ad=
dr_mask,
-				   unsigned len_mask)
-{
-	const struct iovec *iov =3D iter_iov(i);
-	size_t size =3D i->count;
-	size_t skip =3D i->iov_offset;
-
-	do {
-		size_t len =3D iov->iov_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
-			return false;
-
-		iov++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned add=
r_mask,
-				  unsigned len_mask)
-{
-	const struct bio_vec *bvec =3D i->bvec;
-	unsigned skip =3D i->iov_offset;
-	size_t size =3D i->count;
-
-	do {
-		size_t len =3D bvec->bv_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
-			return false;
-
-		bvec++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-/**
- * iov_iter_is_aligned() - Check if the addresses and lengths of each se=
gments
- * 	are aligned to the parameters.
- *
- * @i: &struct iov_iter to restore
- * @addr_mask: bit mask to check against the iov element's addresses
- * @len_mask: bit mask to check against the iov element's lengths
- *
- * Return: false if any addresses or lengths intersect with the provided=
 masks
- */
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			 unsigned len_mask)
-{
-	if (likely(iter_is_ubuf(i))) {
-		if (i->count & len_mask)
-			return false;
-		if ((unsigned long)(i->ubuf + i->iov_offset) & addr_mask)
-			return false;
-		return true;
-	}
-
-	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
-		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
-
-	if (iov_iter_is_bvec(i))
-		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
-
-	/* With both xarray and folioq types, we're dealing with whole folios. =
*/
-	if (iov_iter_is_xarray(i)) {
-		if (i->count & len_mask)
-			return false;
-		if ((i->xarray_start + i->iov_offset) & addr_mask)
-			return false;
-	}
-	if (iov_iter_is_folioq(i)) {
-		if (i->count & len_mask)
-			return false;
-		if (i->iov_offset & addr_mask)
-			return false;
-	}
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
-
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	const struct iovec *iov =3D iter_iov(i);
--=20
2.47.3


