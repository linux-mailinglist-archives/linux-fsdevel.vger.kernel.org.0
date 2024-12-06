Return-Path: <linux-fsdevel+bounces-36592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A829E63AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5402A2857CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9591442E8;
	Fri,  6 Dec 2024 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="J5obIwmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC481142E76
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450010; cv=none; b=C/cf6eP8+Hqf0rE5y/n4BOppJT9p6rn/gPZp/Ftt7L/XlI+IJzIHM1QZiVEwLHCs2NEqSuSCYgjpZ8uDnhjufEIaQm7CaC7XxbcrBb3jpQZM9yoGEUwDLPgfL957D/L5NaYWSF8HZdT0fx/n1Woiq+KMsomRYLl7WajYqMS57eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450010; c=relaxed/simple;
	bh=vQCj16/aGlHlGXxd0RymI3pYUEiOQrHyrx/mFrcpbCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSFWcsBNTzaE9nssx2NGZ2ETu9tN/oRTLmkAZ0RpEzK0PLI9Jp0I/T8A1vlyBDYStU1TNTzNYob85jpG847Ecc9U7gv8Kiie56nhD7xHAgnd6eDcSt4IZe3R4LzcYo++iTbiWVKtn2PmqQFZZNnrDkhowICASEeaKcEOgEnR+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=J5obIwmy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603JgW014117
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=53paUo/NtLhsF7pN8C+cqET+3d6cf3Dy8gzuWV/ss+Y=; b=J5obIwmyGd33
	rMG4bodX1ku1bH1vXzNy1csP/LmXIAZcXNQLdGS4OhmxrcYHBZmChjzQ15AG8yjq
	TjWYmDQl1HFQapS21YYGuAPkQOdU4fEMJXCV0nBl/9nkPTjXx9QfkSy/uVNis+kJ
	PXTbkhyrvOqtEq2J5YODrCf36FAWHtNu12jJgKTZ+T9RgixjzMF7Wl6pmADPLnKx
	KBNcAUCbbNb+b5n8zgdlNKKsqdiCBrRBUYQaP1evEJJaQW3+M9IjeUkmncPlQ0H5
	Ge0nFqeFlrMDut2lycpYU7ZGEgcpiDTMGkCGoSLXOTZwYWlUZy6KnYYF64KtexxA
	pm82awKELg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bmru153e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:27 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:22 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0EB7F15B2114F; Thu,  5 Dec 2024 17:53:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 03/10] io_uring: add write stream attribute
Date: Thu, 5 Dec 2024 17:53:01 -0800
Message-ID: <20241206015308.3342386-4-kbusch@meta.com>
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
X-Proofpoint-GUID: Dup7hTimAOtxgg35GcDiYVaiMBsTymzK
X-Proofpoint-ORIG-GUID: Dup7hTimAOtxgg35GcDiYVaiMBsTymzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Adds a new attribute type to specify a write stream per-IO.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h |  9 ++++++++-
 io_uring/rw.c                 | 28 +++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 5fa38467d6070..263cd57aae72d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -123,7 +123,14 @@ struct io_uring_attr_pi {
 	__u64	rsvd;
 };
=20
-#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI)
+#define IORING_RW_ATTR_FLAG_WRITE_STREAM (1U << 1)
+struct io_uring_write_stream {
+	__u16	write_stream;
+	__u8	rsvd[6];
+};
+
+#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI | 	\
+					IORING_RW_ATTR_FLAG_WRITE_STREAM)
=20
 /*
  * If sqe->file_index is set to this for opcodes that instantiate a new
diff --git a/io_uring/rw.c b/io_uring/rw.c
index a2987aefb2cec..69b566e296f6d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -299,6 +299,22 @@ static int io_prep_rw_pi(struct io_kiocb *req, struc=
t io_rw *rw, int ddir,
 	return ret;
 }
=20
+static int io_prep_rw_write_stream(struct io_rw *rw, u64 *attr_ptr)
+{
+	struct io_uring_write_stream write_stream;
+
+	if (copy_from_user(&write_stream, u64_to_user_ptr(*attr_ptr),
+			   sizeof(write_stream)))
+		return -EFAULT;
+
+	if (!memchr_inv(write_stream.rsvd, 0, sizeof(write_stream.rsvd)))
+		return -EINVAL;
+
+	rw->kiocb.ki_write_stream =3D write_stream.write_stream;
+	*attr_ptr +=3D sizeof(write_stream);
+	return 0;
+}
+
 static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *s=
qe,
 		      int ddir, bool do_import)
 {
@@ -340,7 +356,17 @@ static int io_prep_rw(struct io_kiocb *req, const st=
ruct io_uring_sqe *sqe,
 			return -EINVAL;
=20
 		attr_ptr =3D READ_ONCE(sqe->attr_ptr);
-		ret =3D io_prep_rw_pi(req, rw, ddir, attr_ptr, attr_type_mask);
+		if (attr_type_mask & IORING_RW_ATTR_FLAG_PI) {
+			ret =3D io_prep_rw_pi(req, rw, ddir, &attr_ptr);
+			if (ret)
+				return ret;
+		}
+
+		if (attr_type_mask & IORING_RW_ATTR_FLAG_WRITE_STREAM) {
+			ret =3D io_prep_rw_write_stream(rw, &attr_ptr);
+			if (ret)
+				return ret;
+		}
 	}
 	return ret;
 }
--=20
2.43.5


