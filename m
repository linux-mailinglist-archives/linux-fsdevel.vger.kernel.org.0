Return-Path: <linux-fsdevel+bounces-56759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C74B1B602
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12D84E28B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC97277CB4;
	Tue,  5 Aug 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v6cWwqKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC255277CBA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403096; cv=none; b=Ug3bRsUhBDEuFQtPkjd7rVwEhxhZ5YGY94U0vfZzTHQSDyHgc4NYLSbRAjqdXUGtrSgG7NJWW6bCWuEZNOtlsKrkfP1hEAWK/EQAe4T//qBPONV75Tqc3+2LUTxlBLRmKmlCrHkSeIH2MTUYvdQURXQy2gI7oJ6TrqAqVWV+yRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403096; c=relaxed/simple;
	bh=Cb/apwBa1XVQidI+ebNpQwF40xzuYGiCtR3Uc6Osrpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av1Jwhjsfze8iQ/7ndW/K6aNYeiu6i+C51s8Tg/MwvvaUT35YuqMlCDGKruJf1McLo9FCZ28AxcHQWauDAeX6f+7s7a8CXpv7+oN1UR2CSVAxUfrUj+xvcQ3NESHyNycMKmpbH0mL3h35/rtFCYGY8IwGdMXvQFApUuSyqJ4JB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v6cWwqKn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYQMe015353
	for <linux-fsdevel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9oaQH3kl86GzPCGUrph1aYzlnnowT/NAZF60rXSdYc8=; b=v6cWwqKn2+rg
	meQ7In+yjWjKQ+F9rRcDxVR3Ur35/vOLNoW1APxdJ/i4twLFooen0rfSbeCi+T+x
	67DtpE/Wow7mcQJgxJRSlM6GGHdgraZSzodTRI5uRbdRCMQ3Puhfd4g1HMzzKwZ4
	SxTj59U/VIQXBZxYysdWgLdM86mI+UBDmdsIs1PmxfwcuzvGM4FhZobm1LIT5nqp
	HlsSi604HEuQylBHiUz7eH/X+bxdN96QSfaU5aH3sQuhnEwviGdfA1IPDe32slFN
	cNEPowtnmSrkLbNAntt35DOEBLjZqaH9DDc6fshxaxJEteZwEE9vglT4qYqPKdwj
	2j+8ywwoKg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bdg9aay0-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:34 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A23A44FDD4F; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 3/7] block: simplify direct io validity check
Date: Tue, 5 Aug 2025 07:11:19 -0700
Message-ID: <20250805141123.332298-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dLymmPZb c=1 sm=1 tr=0 ts=68921116 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=IZBY3vBkjIs1pqmLj1YA:9
X-Proofpoint-ORIG-GUID: MebOM-pF2Tkutvy0CpVzLonoZVJ_9lAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfXznkjFC1lnu8M /iAn2JgXp3bnDG5Byd97FkbOwJNf84JKTDLFm9A1vIenh03i/daBds8VE1mIvJL8jaYM8wFM7zP 2iE19Cf36Mctb6J+PH0uYOQDt1Rk81ENs6j4ul40q4UStdqJ7EPrg1HLGDfQxu/XCwp24mcxrfV
 GiLWC3DFszorUMu1xVoFZ1EN55cfwQu1bnQMEP1oC3b3FPtR9qNMOSuhqi8evtG6hIlCd+DJtm/ KYq84VhfiZc9WxH/uRhStNEEAkYY2Z5bBuR7Kt9aUHttt2NJQfcwtI+1EU7RzBGavQXFsbR1aNk 64wZMoUWse/BDpbPNxV9wi69oYRpot40LhpYcWPPLQbHz9DcjNAzHLpqcZcmk5iqnCAIML5VJVL
 UKxf/b8iw2tYTUsAGiQ8eDJo5DZnEA3oVvuoUwpzf7lWEjsN1oZPev8zsWctoLaxI3lH4m5x
X-Proofpoint-GUID: MebOM-pF2Tkutvy0CpVzLonoZVJ_9lAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..820902cf10730 100644
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


