Return-Path: <linux-fsdevel+bounces-56541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33817B1899E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3927DAA65DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08CA28ECDF;
	Fri,  1 Aug 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i3gngBtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A20242D94
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092077; cv=none; b=kDr/oL07qEeVA06TPIam2Y9ZO+4bzu0quGigZZsYeaTRPluo6DO9zWVnWrn/vvMmHg5/WOo7bF3Cf0fl1QQ5LXYIkeyvv4Mql3EpOJ+iGjCdcXUy9AzBT0tYw5iGBNeTeTewt9dQo2KdNdvNVdo55GQEWLVSTm6HGxfaBszJNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092077; c=relaxed/simple;
	bh=LwfLMBx23lediDy38Qjg9yw1tMW2Thke+PTvuAKHnIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skgIjZC/UXiYIO64sJZ42YiMTpiXm41QdjFcqo4u2dAd93eME1hzFYgxg6efVI9yxzeXq3H1xnuleZ6ewnxNudqTojji8ofU4NNMISt8yCdJ2EqY3pGL2/HTE15hMHfBJ72GDey8ha6KxQ0y6dmKqQTMmldhA8EDik7S+j62TWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i3gngBtl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoU2020635
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xevAOEXt3D+HBE/6RPgSfiie3n3mLq2ykCT4rEmyCL0=; b=i3gngBtlYCiq
	YEtmqr/iv/A/VarP+J0KLQ4KiHpba58/NrV5MpjqTSZlJtjtGwJF3c+vz4A4Xe2v
	QMlQ9pFFmNz6Y/WQc8w7wFjgTddVhchUmiWMnLRM/v2dZDV+NNCQQn91xT8tAQQI
	OCMmGOObBQbDsegzPqKaWdQD0Ong46WlVqfQMIm8Qkzky7IHkBkHBgpUhqN2JFgM
	z+FW7iIytTfNHd/qvN+EPJewZHxhW051YA7F/IrJP/N57gCvtnGHMlT91Gty+fef
	tZ0fanjTESwa1hsNsE0Bhy1jEAzFNVK4lfqjr2euHGqc4wDJ8/v9lX4RH1sHPvnH
	7wRw/HX3Zw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 488rmynk9w-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:54 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C30BB3105F4; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/7] block: remove bdev_iter_is_aligned
Date: Fri, 1 Aug 2025 16:47:34 -0700
Message-ID: <20250801234736.1913170-6-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=DptW+H/+ c=1 sm=1 tr=0 ts=688d522a cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=x-sBDG6hxYFL5DTe09MA:9
X-Proofpoint-ORIG-GUID: GjZxArcpNFvI6t39JBBPztAcdFESKHaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX0TbOXjlzpT+n yGYEP7+MT6LuTg3Mjx2LV8r/Scc6FHGtzy3seEfF+5QULP90jAHA1Aww6RT+b42TT6AL0oCH0/C hFuOEqpbFMDp+9prG/6whI/hVkqvzSLVTbl2bPAsaGm7fT0XkGSwKmIlgKzphfUF7yE2PvQDwmN
 ycOVJmXAxjEfJVE4JWMy/48OTf5GaGhE1kq89uh7A5Msnn0n46cjIZkDW7RvahS5c8R0SwGWzPD M6DndRwKytwf+1PrcZaW3RpDer3JK8msO1Aukl8DYCuqzgX/1ycm8Xye0qRq2+QMNNbHKVn54ma oyjYN8UDH4gXlpupPYhSm0990jzQiixiLjVetHveh1OxSTeUqrulyGg0v5sj5VcE5Rw71vpRal3
 yW6UOJmhveAk/GsamApFWaQxkRElzY7rkaZfvVKN4yTdGd0L0GvXFa+58OMEVe1pzr1vXP+3
X-Proofpoint-GUID: GjZxArcpNFvI6t39JBBPztAcdFESKHaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95886b404b16b..f86aecbb87385 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1589,13 +1589,6 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
-static inline bool bdev_iter_is_aligned(struct block_device *bdev,
-					struct iov_iter *iter)
-{
-	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
-				   bdev_logical_block_size(bdev) - 1);
-}
-
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
--=20
2.47.3


