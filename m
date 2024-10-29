Return-Path: <linux-fsdevel+bounces-33130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1229B4DA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401681F2267B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8A194137;
	Tue, 29 Oct 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hcLQSWnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77609192D83
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215339; cv=none; b=U3sRZJaBKPK2bQ/OyKp8PNqV+2h+RYoJi5ZfNlJtaG5MaOwmwJ7Mxk1xtBRgVTkDZab2TZXN48KDp+HMCwUMPjq47ORAahZvGTD9H32e+77PNAjT8wszr6cNN0LI0QqNGkRJbgYHGq0UeL6HbS1QPNx4j2RIciZq/cWQfHEz7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215339; c=relaxed/simple;
	bh=GatvhlV7oUxm3X13UhOaSbBplvyWZ8hbwVUR2itl5VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQt5bdSZ0xKu2MUbZSWTqeZNAgWbSmeJPGTAKhH68tFq3bcfmfJ2asbDGCQ9A6TWa0vlok+f1tFQ3quF2Cxd0/8EmZ5fCd2PnOvWY/FIZmW/Y+79mpUdCjSd7diZuojmruSp97K6Xk7H6/7YhDZpyUqB8IWlZz7aanGHY2PnM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hcLQSWnO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAagKd031486
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:22:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=XTdC5rR2uiEoWSlqFgEly23JIAf0RJlPvmvSok+NdlE=; b=hcLQSWnOVHOI
	0qRKrNYi6oeZ0MEUslUgWB/VQcN7Dfo9RWgtsJbJLgVh4p1+J7FfzmXzyKZdKbFc
	jB3FjoYh5QJ3L5wwr2hY+ScSm1Xl9xqvltzrPvHSUoil8dByH6YrFzXLlSBSRz2M
	SchBlvcsTKzBC7BadT/zqK793ECEr+4emLrPQxLb7Jtv07LBgoNo/wLHHSWFMW60
	bA5keRS4PSyg6jK4GI/kINLciLVpnNaWz2A/PZ0FPi+ZVXh+g9OuRSwffYGNNkWo
	vxrrDzfP5HWlq3UNkY27aFy3Itsf+ObcRtbPy+DI5dX4zYMZLT+rXp+YdMAJBOp5
	rENyqe23aw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jx3phvsk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:22:16 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:22:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 24BAC14920EA8; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv10 6/9] io_uring: enable per-io hinting capability
Date: Tue, 29 Oct 2024 08:19:19 -0700
Message-ID: <20241029151922.459139-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -oX55JervJkWI1AYK1PA32CDYlzND6Rp
X-Proofpoint-ORIG-GUID: -oX55JervJkWI1AYK1PA32CDYlzND6Rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Kanchan Joshi <joshi.k@samsung.com>

With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
all the subsequent writes on the file pass that hint value down. This
can be limiting for block device as all the writes will be tagged with
only one lifetime hint value. Concurrent writes (with different hint
values) are hard to manage. Per-IO hinting solves that problem.

Allow userspace to pass additional metadata in the SQE.

	__u16 write_hint;

If the hint is provided, filesystems may optionally use it. A filesytem
may ignore this field if it does not support per-io hints, or if the
value is invalid for its backing storage. Just like the inode hints,
requesting values that are not supported by the hardware are not an
error.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/io_uring.c           | 2 ++
 io_uring/rw.c                 | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 0247452837830..6e1985d3b306c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -92,6 +92,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u16	write_hint;
+			__u16	__pad4[1];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4514644fdf52e..65b8e29b67ec7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3875,7 +3875,9 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 	BUILD_BUG_SQE_ELEM(44, __u16,  addr_len);
+	BUILD_BUG_SQE_ELEM(44, __u16,  write_hint);
 	BUILD_BUG_SQE_ELEM(46, __u16,  __pad3[0]);
+	BUILD_BUG_SQE_ELEM(46, __u16,  __pad4[0]);
 	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
 	BUILD_BUG_SQE_ELEM_SIZE(48, 0, cmd);
 	BUILD_BUG_SQE_ELEM(56, __u64,  __pad2);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 7ce1cbc048faf..b5dea58356d93 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio =3D get_current_ioprio();
 	}
 	rw->kiocb.dio_complete =3D NULL;
-
+	if (ddir =3D=3D ITER_SOURCE)
+		rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
--=20
2.43.5


