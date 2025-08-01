Return-Path: <linux-fsdevel+bounces-56543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B78B189A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E12AA6BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48B290D8E;
	Fri,  1 Aug 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="M6zi21Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4A28EA67
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092079; cv=none; b=T7ZLAvD0dspZGCL4yr6bhwXDVhMFmBDHPj0o69NrzvtU9a4fBP6tyR8N9J2UdLicoZeI5vEPeX1Mt6z8Lq2NK+KdTldMTnAwKKWv6p4hdGby62xjniUuyGyjLOzUSa4vBPOVPR0ZUL2OQefVE6ADC4Hrgy+OvyY5hGQ3b3lqDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092079; c=relaxed/simple;
	bh=jzlRcqxemBScBaRTLQp2jW6SAY6QfbaJO5r5WJ+UUAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEvIpAawNXDYWp27wbr7XWqLWZ8ei5OnIMuYHkqKv4VWo/S6rXuz+gKuuRnJou1/mPHulbkPvSNUAu3IspVlLQ1uWao7E7VnwIGp2owsiEqzjfBDXzYGNuiu9HtYGbtDyhb9Gdx6gs798X6KrEumU3dLukHifw9TcUe2o7qgewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=M6zi21Id; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Mms2j016719
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XtBdupgbjKwCohMaMZDsYVHKfLDcKQSvu9287xyburU=; b=M6zi21IdQ41s
	DY5P2QZg/ySFDsISkZzN8UxvKhnxrYAKUhE2elhH2O1FRMR1EMPZm2y1X+I/+TS4
	AzWuUOKHX8K+QnVE085dX07IvuOD0J2hhsnCB9q7Jgduva+V2wU3Hr1eNMqV9P3w
	q3GeVCwQ3nXUqno2k418XU07mFEXYyo2Jjv+LeEvoCoVIMmTQjHvbgRccxBCaPBN
	UJIVP2VNgbSSqVFfDKPrUrVAOMUEbOhd78GHl7l3Lbh26P8D54axSUsztF79nML+
	TLkqdS96WukXc9+DBZ5emRTI6k58wb+eKRM1TzmwB94QlYBqcGgo61LzozU0Kpqg
	qkCd1YhxVQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488rn2nkme-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:56 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AC5823105EB; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/7] block: align the bio after building it
Date: Fri, 1 Aug 2025 16:47:31 -0700
Message-ID: <20250801234736.1913170-3-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 9dA8UVKowOHHp43LSPVJs0zsJf7YtVPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX2e/Q51hN4iAW QFxgrZzpnhyDF5m2PeLMhuPG4r7N7rJdqeTTUIaA8GROEOS033/HBijG8JugSscgsXfGKVIYZF1 UPrQiQTzM+9ATAVp9HXRoeyWQSvTdiTTqrt7rfWybEpCs5m+6Fo69AN+l/hLRTMUJN/WsxejxZu
 F4JAHRCx2wyErMl26ATGFoWAUfjmCcilj3b+c+z7VhexEHgGofQMPwtqESojGvFApXRDuoNxy8a +NBvUDXCqUhMiKN1+9JSfBkjaqZZOXsJd74rWzKTEvyZd3OaDcFv70thhbn/80WRnWOaLhf3Os6 OoQXgI1Z+AHjwFRG3hkPcmdGKHXSsXBP5IaXfliLw699r/bdtf2JK//u6qPMkBYapHgXtW7qv85
 H6C2Gm8bKO0K+jOtw1urW243nvA5XEPJxGDNrxm8GZ6zM2cdA6YiJlAXIzlmvzNxDRy6lVKA
X-Authority-Analysis: v=2.4 cv=HOnDFptv c=1 sm=1 tr=0 ts=688d522c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=vjHh1zdRauUgFv1HwnwA:9
X-Proofpoint-GUID: 9dA8UVKowOHHp43LSPVJs0zsJf7YtVPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Ensure the entire size is aligned after it's built instead of ensuring
each vector is block size aligned while constructing it. This makes it
more flexible to accepting device valid vectors that would otherwise get
rejected by overzealous alignment checks.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 58 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 92c512e876c8d..c050903e1be0c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1227,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |=3D ITER_ALLOW_P2PDMA;
=20
-	/*
-	 * Each segment in the iov is required to be a block size multiple.
-	 * However, we may not be able to get the entire segment if it spans
-	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
-	 * result to ensure the bio's total size is correct. The remainder of
-	 * the iov data will be picked up in the next bio iteration.
-	 */
 	size =3D iov_iter_extract_pages(iter, &pages,
 				      UINT_MAX - bio->bi_iter.bi_size,
 				      nr_pages, extraction_flags, &offset);
@@ -1241,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 		return size ? size : -EFAULT;
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
-
-	if (bio->bi_bdev) {
-		size_t trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-		iov_iter_revert(iter, trim);
-		size -=3D trim;
-	}
-
-	if (unlikely(!size)) {
-		ret =3D -EFAULT;
-		goto out;
-	}
-
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i +=3D num_pages)=
 {
 		struct page *page =3D pages[i];
 		struct folio *folio =3D page_folio(page);
@@ -1297,6 +1278,44 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	return ret;
 }
=20
+static inline void bio_revert(struct bio *bio, unsigned int nbytes)
+{
+	bio->bi_iter.bi_size -=3D nbytes;
+
+	while (nbytes) {
+		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (nbytes < bv->bv_len) {
+			bv->bv_len -=3D nbytes;
+			return;
+		}
+
+		bio_release_page(bio, bv->bv_page);
+		bio->bi_vcnt--;
+		nbytes -=3D bv->bv_len;
+       }
+}
+
+static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
+{
+	struct block_device *bdev =3D bio->bi_bdev;
+	size_t nbytes;
+
+	if (!bdev)
+		return 0;
+
+	nbytes =3D bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
+	if (!nbytes)
+		return 0;
+
+	bio_revert(bio, nbytes);
+	iov_iter_revert(iter, nbytes);
+	if (!bio->bi_iter.bi_size)
+		return -EFAULT;
+
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1336,6 +1355,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct =
iov_iter *iter)
 		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
+	ret =3D bio_align_to_lbs(bio, iter);
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
--=20
2.47.3


