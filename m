Return-Path: <linux-fsdevel+bounces-56539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD0B18994
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97CEAA1D69
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1330242913;
	Fri,  1 Aug 2025 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mc+Sqfvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEA23C4EB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092074; cv=none; b=k/GCvBwTqPGartwTqghC5HhxtuRH5cnCsJRDIt2goH8lDc/o5E4uJfO4D/YyLgm5h8rJDeUoLhSbfDV/yc/J3dGR+aHN90IaxquZJ8s7E+sMh4U6sP7Wf/UtkTzVPxNPIBpCaOFuBpANJMW7mXDzb0NtLsJz/ztAsb/ilImpEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092074; c=relaxed/simple;
	bh=qqM7XP0L7nIP6eDwvhuc1u0A0DYGoKFdOJeN8XlyoZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZMd8hAPQzdxI2Q68f4+PQ4ERwcKhG+vqQ8NjWwzNSMpoW0AEPeID4atp5RGjWuaf17Q1GWGK8J8TtoOqwkDVALvEKXGW6CWkdVN0GQIetvpCQ0DtVjDTnOSJYhYgo3cmsvzgulWBzzkq8mys9ya288eAKfTdehsD47iU9Ogjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mc+Sqfvk; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Mms2Y016719
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uuy065QjwhzxX+HyBnYJHygu3ula9t7x2rGLsBYiE7k=; b=mc+SqfvkifZa
	zJMdym2CKp0uKTDtWynLa0wPzKbTdeGXWo5aGqGCsXWtIUHtZzOxE4sf3goyOtK4
	siK1p7VyET6zvFFhLuY/TT24jjzZNrb/mhhl91E+05OsEVOh69l6GJihwH342LZy
	bRZXuApn70aY28AzRMvGLv00mvhKB1CNJxEM/LSn5ows+zIBLkTrn5z7Uwoo5lCc
	WO1tcWWcZ+YEfasZneXcVCzwN3xoBOM2ZybLiH08/iY4raxRZDjKiz2KRihOYYx7
	UJCenrXI/zXrgEAbComUVMnyJGdkenlo/HZ43ku4q4KKfWFFVFEb5LVcyAMm5P5s
	LeNaDMS/rg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488rn2nkme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:51 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BD2F83105F2; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/7] iomap: simplify direct io validity check
Date: Fri, 1 Aug 2025 16:47:33 -0700
Message-ID: <20250801234736.1913170-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 3_Hy3PRtOo4LYY5RgyIUpzeZHy2sPIi4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX+IVojEgIrUn7 wb9fISh0Ik+zC+wR+27WF0akOf00n9CSynG/8XYKsP7NK3ehO9iIzdCkBTV9LllaawtBS7vXoPJ 0ztMJtnH43g2wb0jbGkTXJyQIF9TudC+9MX/SVKtpyZ/LOypD6EuDeqiqx4OMItwfijuE218KGp
 QtWpfWamtO++d1Yue30VJN8mX+zao8bmTDT7Y+kWUTEC0xFFmAr53+FsEIzhWoXGNk1u1QHDz8e 10+S6O8o8gavhHvM1iIo6uq6EjNqP4xVwvV7CtaUX6ZLY86FAIFoPstYxEaGBf8ROOd9oEMtHUs D5KT/gx8rwNTuza1D5vE0ysXSQYYsrUPBeaCVRc+NjqUziCJSxVoYk5LKqEl5MfZpv+K4CA1tFh
 SSuDJmeQ1F7vtBUZz47W/ZCxyGNVojh/IXEQDlmF6Rw19ISrYAsBV28lQ40pCO5KgEYJ1PzF
X-Authority-Analysis: v=2.4 cv=HOnDFptv c=1 sm=1 tr=0 ts=688d5227 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=N-9tSbTDVoy7b94FiVkA:9
X-Proofpoint-GUID: 3_Hy3PRtOo4LYY5RgyIUpzeZHy2sPIi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

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


