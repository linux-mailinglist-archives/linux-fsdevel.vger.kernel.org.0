Return-Path: <linux-fsdevel+bounces-56763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D9B1B629
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0818951A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D9275113;
	Tue,  5 Aug 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="smf83hak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FA272E6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403105; cv=none; b=Zx2X+y/i6I0ok0WD1lHVRA1jfjmjpOa9Acmzwemg4iGhERbclyyKTm2CAymaZjXLEAXeczj1vIppL8IVOX9w9oQuA730r3JWrC2i0p7D2tfOkZK6bavGHCMmtNhMpTIXLYnsPlBJrxxSCPvmJWrLzFdZtyXuMBLuyvu6CGD3Z8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403105; c=relaxed/simple;
	bh=qqM7XP0L7nIP6eDwvhuc1u0A0DYGoKFdOJeN8XlyoZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IncpA/T2xXnsIyzr7+X1j0KpeYWipd9iI2H4GuE+xK0Le8dbNKIl9gRbRKsbUMT9IxPR/PFs0jHMOaeXzirXmFgOsk2ty9P4YjJlaM4hrlvcQdBoonnP9iwDvcW9xEY99qh84SQjezSw3o6nW0hYEf0d1Lbv/kQUVonEmsFhiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=smf83hak; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYSqX015603
	for <linux-fsdevel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uuy065QjwhzxX+HyBnYJHygu3ula9t7x2rGLsBYiE7k=; b=smf83hakFr7g
	V0gu1KqILWOVPd84yiV+anKYNwB57noydqOL06rNesA4fhoXXAm0JAazSru+9H8E
	fjX1CTZ2Tbqqer6siMp9DCyicSdAYaW1RrjEx5s6zyZpNuBmCHzRoIfBMk8pDu1S
	f6mHujy03FAUmu9BeexAhiIW6Reyeq4Y0+d+fqT3OMupj9CK7EiD6A+kVas+16YG
	g2wsUHcaVeARM+2OvN78MQy/XFkn4BBxvlvroS5uZdd6qAeCUV+txWzkBM77uny5
	fRakYOV23w5EPcXpsKrTsDsy5w3DE+gP2daf7AmIo1K2Yf4nLCrrGwSk51KocnpU
	Mlr9M8Zwgg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bdg9ab2b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:43 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C21374FDD51; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/7] iomap: simplify direct io validity check
Date: Tue, 5 Aug 2025 07:11:20 -0700
Message-ID: <20250805141123.332298-5-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=dLymmPZb c=1 sm=1 tr=0 ts=6892111f cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=N-9tSbTDVoy7b94FiVkA:9
X-Proofpoint-ORIG-GUID: C65myNNuUmVWVKBRAHUiZrVa7uwQ9tix
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfXzN319uwpdy/+ 6ub4w4EgEydXqLCZ1f4IlJS9cU2OYgUeACEpoj0gKwXEySA6ijPi+k+tyKE0gkzRL7tTqmaInZy tUcABPGJCnb91yJeoejWBtUYPSPJfNjydG7gfuy1MCuUZQp+ZwpEjfXcQhrT/GheueAO25davs8
 aKW1dPlEd+XoeuBWeSasdDFJZgmoBqrj14hcHeiAugth8uQE23Vp/KkPZzeE7N6i2nw39a+miTu AZN/is9iGW9/uWoI/pdwoMfxZF4IdNryvfPdGP1Gb41F1fx3UozOBP6VlbgVR8e/GT5xsimNQFv 1/0edaR2zaMYBuadue+gJxluqZxSQONIzoJn9p2oX4h/95uM+kOec0JmQURjti3VuxDw7OAsieD
 1+9RJz6htz09+LqJqfJ3ySKldsBOZKreM9l42uPGxeqHlsZdX++/d8shtM75Cny7SdFfsTWi
X-Proofpoint-GUID: C65myNNuUmVWVKBRAHUiZrVa7uwQ9tix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f25d4cfea9f7..2c1a45e46dc75 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter=
, struct iomap_dio *dio)
 	u64 copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
=20
 	if (dio->flags & IOMAP_DIO_WRITE) {
--=20
2.47.3


