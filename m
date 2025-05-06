Return-Path: <linux-fsdevel+bounces-48238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36CAAC417
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15EB4C21E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD25281522;
	Tue,  6 May 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tD8ykrXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26DC28136B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534412; cv=none; b=TnrI06cXC9LoBZYjD/AqTsdMKR+jRtQN1i9hUi9ThBxuSYKOL5+I9pgsCqYaHNUB5uXn9EOh7DNotXdK4dtde9DPGm0DdY11FK3ODaHxnwnm5csMWEsDFhI1WGfLdk5s3anQQBc2jF8zNM3jdVB0EcmgYoxCYlET5jp4GXEaQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534412; c=relaxed/simple;
	bh=KvnV3X3wxZNrC7jMAtyurD13a7xoLMJ59StQWRUaAjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TA+rfmv8QWpmipMwpRP2fpOk6yrM6LHa8XrSL8pmwGpNLRLwhGAQ8BN2pai8DZOBd+5HbzqJjWG0f9RAP7avcbBWHc6vysvZMKWGAHb5DYC9fOS/IpY140V29m4tC6uZq5YUlNtSEBcXeYuTaoCQTl/FI/JYdFW/g8j76+/UhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tD8ykrXE; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250506122647epoutp0133d432bbe98bce0e3f92a7de0580e6ba~878o0y8pO2804128041epoutp01l
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 12:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250506122647epoutp0133d432bbe98bce0e3f92a7de0580e6ba~878o0y8pO2804128041epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534407;
	bh=Ljjro079q9uwRgw13jqGTcCMnLnd9SzNPEgxRUxU6ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD8ykrXE5pBouR+sE8Jf8Llb3QwgTA12J0zQXSru7dkPefySWZ5ssTedaO5rYxRg5
	 zCymAI+gJ3r02H6L2P/NihrmEi6uic4o7KO/6JJzkvyc7/TJTHOLEQXfgMFarhDUqZ
	 SmmCpAb1YQqjsMLrNGm62O9lJ+h+6xeTdsoN5eIw=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250506122646epcas5p4545d498ae204a164aaf8df513fe97221~878n8Q1m11362913629epcas5p4D;
	Tue,  6 May 2025 12:26:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZsHh50LGgz6B9m5; Tue,  6 May
	2025 12:26:45 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24~878l_uqDD2629626296epcas5p2e;
	Tue,  6 May 2025 12:26:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250506122644epsmtrp24528d3c8914722ebd4d6ec319bab9deb~878l_FpCV0522005220epsmtrp2P;
	Tue,  6 May 2025 12:26:44 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-94-681a0004a83a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.B6.08766.4000A186; Tue,  6 May 2025 21:26:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122642epsmtip2edfe940f28a765b8e06ac20119c395b2~878kclVT91704417044epsmtip2T;
	Tue,  6 May 2025 12:26:42 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 06/11] io_uring: enable per-io write streams
Date: Tue,  6 May 2025 17:47:27 +0530
Message-Id: <20250506121732.8211-7-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvC4Lg1SGwYVfHBZzVm1jtFh9t5/N
	Ys+iSUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02HtL22LP3pMsFvOXPWW32PZ7PrMDt8fOWXfZ
	PS6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Nh8utrj8ya5AI4oLpuU1JzMstQifbsErowz/X3s
	BY8FK5YvmsjUwHiZr4uRk0NCwERi+uoXbF2MXBxCArsZJXrW/GKESIhLNF/7wQ5hC0us/Pec
	HaLoI6PE6+M3WbsYOTjYBDQlLkwuBakREQiQeLn4MTNIDbPAB0aJPRNngw0SFnCQ6Ji1hhnE
	ZhFQlehetZ8NxOYVMJf4fe4PC8QCeYmZl76DLeMUsJBYvmcWWK8QUM2Lo0fYIeoFJU7OfAJW
	zwxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgot
	zR2M21d90DvEyMTBeIhRgoNZSYT3/n3JDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE
	0hNLUrNTUwtSi2CyTBycUg1Msq9yLjErPjn1f9Ji78Dv5dNjNBrf1gXnhAi+yJNau+nKbLN9
	asdy5WIFd+cmvw5tSff9yFV0SO+F5tb1X2+oajkGuh6qFb03hblCVFlFRXtN/OpTS9q2HNjV
	9TyAt6bNZfK6F+I3tFasNamWOyTlbCP9PHhvw57zxU21s4vKm74VmOYrVyVf/8Pz9fiR7MM2
	06PfV+z8wZI96f9at6RzO0s2qskYn//yf/9DrfclrUd7tjw3ULr13bJVf6XO87MHVP99YFS6
	9TZ6fmDFmZgp4i9//kztnPTC3D/Qotm+6dqF2zzqFz4fEkqMmXon8965C7O3Lw3c+nDiWt63
	v37W/DV4cyWjaaa/o4dA6a4MKyWW4oxEQy3mouJEAAvDjnf5AgAA
X-CMS-MailID: 20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122644epcas5p2b2bf2c66172dbaf3127f6621062efb24@epcas5p2.samsung.com>

From: Keith Busch <kbusch@kernel.org>

Allow userspace to pass a per-I/O write stream in the SQE:

      __u8 write_stream;

The __u8 type matches the size the filesystems and block layer support.

Application can query the supported values from the block devices
max_write_streams sysfs attribute. Unsupported values are ignored by
file operations that do not support write streams or rejected with an
error by those that support them.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 5ce096090b0c..cfd17e382082 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -94,6 +94,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u8	write_stream;
+			__u8	__pad4[3];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 703251f6f4d8..36c689a50126 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3916,6 +3916,8 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u8,   write_stream);
+	BUILD_BUG_SQE_ELEM(45, __u8,   __pad4[0]);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 17a12a1cf3a6..303fdded3758 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,6 +279,7 @@ static int __io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	rw->kiocb.dio_complete = NULL;
 	rw->kiocb.ki_flags = 0;
+	rw->kiocb.ki_write_stream = READ_ONCE(sqe->write_stream);
 
 	if (req->ctx->flags & IORING_SETUP_IOPOLL)
 		rw->kiocb.ki_complete = io_complete_rw_iopoll;
-- 
2.25.1


