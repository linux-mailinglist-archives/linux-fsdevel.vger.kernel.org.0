Return-Path: <linux-fsdevel+bounces-56542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF3B1899F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D24AA66BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6328FA87;
	Fri,  1 Aug 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dl1NAjHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B928CF77
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092078; cv=none; b=uYojQYlQKK2tnHPbSSj5m9cMSMmUdg13tGt2wOjvzQdmQKlMB8ykvnI+PAMfgxLWT2FX22W848DIE+ZIROm5ih5+yfzm2qWo0rEGkE78pDDhhjccGMeLpdtf3MX/cRJieGUDmai9N1HZpY0zlCpfQktwHHGvna8Aw2/kC49Rt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092078; c=relaxed/simple;
	bh=gdIVjT3vlKOt+2mbfWTWwWZ2gPoA7XxoHfplCpsaon8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeW47uvzkOzCWTukJVcLEu6Ag60TFZKuWnpGDl8PLjkSl2TV8KWH6uZB1gB+MuPCKqJ8fIh/Lr96LSFSbWNfLRH+SNsBIBNtP53BQP+UyhLhZoa10TXwZUE/9WsK9JzMsTqxSUmXDRFKhS/GYQXwNl/ADmm7zS6/XoGlbBDhKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dl1NAjHo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MqFEK027978
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=1SMXkSebdaxUaoNdomo0qGyDMDQR8jUQzMvUjgNXeBc=; b=dl1NAjHoKtdf
	40azB8cH8aKrpu4U3nB5u/zuNbF0DRTB8fjdNMKIwt1sD9/ZeCMQdBAP4GcG5Ym+
	x/9j7HeJROiIgrlrGoEyeqLQTcJN+g/S+Yd0S518B8oKpx4uxfMxAoIhY71F4jvx
	5hbH220NfU28MPv8DuCuEmRnOZOWM+ZueLSTdESDWlH8u1I0dcFU4ItUKAJAGhT5
	vCbHMj9VZvn6pZ9R4I3+Pj+Eajbkc9/9bELORqhwDRn4hOxJagchN/iVX0DIDNQI
	z0b/tI4dP7rTs2d6YCdGfQVRnhjHtYNd5854I1HhNYrOKnmPOQTioiEpvV/b8rX6
	n9yiGf6ycg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 489286t1ts-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:55 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B2F063105EF; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/7] block: simplify direct io validity check
Date: Fri, 1 Aug 2025 16:47:32 -0700
Message-ID: <20250801234736.1913170-4-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXyGqNAfOijI1C 5vdLn1EX4OPEOuCEhFn9NVEmfl8br2YC5VV4Bza3opbURuvHXUYnC7TWXgWs9j+PABVEH3inSkL pPIMxAG4C+kUOuyy2LpJL45n9wGUgZnuOz0q8YQMZ7lkV6vJn0xQgsiDKMn1qgP+MOvGRJFDaWf
 VhMp3Pa1QHVj0YUmQSQANNDNhySNAONEctHwbSXRd89mtIBsajwbf4+uj/TJm42OFTdMkgmBwi5 S5EdJBruxkzGbDYCsWo2GCyALZvyklLBje2I417kjPL+CO8RxJawN5T5rm+wxCi2ItkroWBnS80 nlSNBTtxYSodu9A5XEldEIFC83iXRz8LdI9Ys+NDe87ezrTCiz/9mSP1DAk/q92DYniBKUIkLJ7
 Y/sKEcOqeugBe8K85y4rLxzlYGljwsYXiyp4PSzkTrOdXKdNHEJpaUQLl9qqtJahpgrE4XMy
X-Authority-Analysis: v=2.4 cv=ANL1oDcN c=1 sm=1 tr=0 ts=688d522b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=IZBY3vBkjIs1pqmLj1YA:9
X-Proofpoint-GUID: wTpSlYIjMKQ9lB-rvebafxG7lchU4TWf
X-Proofpoint-ORIG-GUID: wTpSlYIjMKQ9lB-rvebafxG7lchU4TWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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


