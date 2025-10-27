Return-Path: <linux-fsdevel+bounces-65804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB706C11B57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AD1A63BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58232E157;
	Mon, 27 Oct 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kssTMzm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF632C952
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604190; cv=none; b=LbOY5p6LiRLhAapecIe/uDV7zfsApZz0OxGtlIaqv9sW791OMEXrq+cIhTHSnKuzCpv8uEzkuLR+Tt9j6pnmaQ1VuGgWvNaRz39ZeYRDInXKIrswlKK/RHSQGEVFV1SCOGXY1q75v5d6AV+8MPX9jbNYt5usPO4y2uQTyMQMufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604190; c=relaxed/simple;
	bh=5trlzOSoRPBFJPoaGzJTtndg8Nr6g9bCoxITw82CJq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uycN0otWYdz63wbarREs812fRc9vaWAZbN8/+Sudgd4+jnzEC08ac18YeQXXnETPrHjTu+CH19gvg2W8BO/J8rRpp3QnLlRASjFjGpGuHyycdMcTDj0opO6EEXyu0mIkg1Pm1D08eTNuA3prqlcqRl/1iyoM2TiUqFT1i5F/3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kssTMzm/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-79af647cef2so4452980b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604188; x=1762208988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIHHD2cgpgFsPTROt8Cpq6Fz2TimP3yx8nTisLh/mlQ=;
        b=kssTMzm/q/kimiBVq15ecfBPF8CuLRqD/WaJNaOnCIMQ/SZ65wdv1YuicBx4F1LROZ
         +OTmfKewKxvbhrnO3tZ6BCCsdanf1MvByZs4MX50/9VZYSlGSRQZhZir5RkPpbLtj+K1
         AOTAZLCXNtDynH9YQki/tEQKudNsvBA1/99okNcj69qy64OU6XIfon9hGiZnPb/8YrN/
         FdY7G4bas2/h3oFdhBIif2hWOV7N02MDPN9HqP/ErBkIFqKbfy820hG493J3+BaEUGJW
         ujZxn1/QAyln+TcBLG3OtKviLGMNlD+aQGEvMsASLTfawobZoOyg9Ml5GYPHcvfUb2k4
         FDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604188; x=1762208988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIHHD2cgpgFsPTROt8Cpq6Fz2TimP3yx8nTisLh/mlQ=;
        b=t/q/7+J7Fr7xd2B7pi77A4VVOB5b6kZA5PgcN0cw8bV3inKqkcu9OPDsdVquqz2tGh
         UklIwfibDPfYzHlsgOZ8ho4hyAd8CR9K09DhTuL1rhgDHNuA1HR5Z9p4f+znRMCZY1Bw
         6WSubidJmGmYzAwFuFnK95IkUQ69ZCgK6mcMILUWLQXIoI7QWQLXBk64k8SD1AceOAkZ
         3CxgJE+32md/h+cx1X7DieClixF2dkQWttRRRTWH//Dh5q00NEnxtZKTMZ5G63fug02L
         F9DkrRtzR4yRSWhGjbxDvfYn5KEJSl+eWmqyhd1YaGxRtfblHpxIry3E1NzN99SeZ1Mi
         Xv8g==
X-Gm-Message-State: AOJu0YwDCciPFDjCRSPxUuXnE6DPLKmPJKhRY1ZR2k6o794VOWQqFOu3
	Y52Xo2bsdTVrO0y0uijX/epfQbbgDV4otfInaptZFiLFxlp+cLrw4/1pnJtofA==
X-Gm-Gg: ASbGncuqlaHzinaX0vKsneGHO48WVUr9vMFPoegJL6oz5aL0gw+ss4B7qDkCnsxEOA6
	NKH1Aud7jXGNTN2iO4npxppuaclapj/59WdA8ELWr1ApnZbPNNHzmxOHHvNJBYTbQnJo9vfoZAE
	BkBlR/P9pYrF3dutpi2UOZqCyS0n5o7l9UVIFNNu2OnB70JADkdWeAUXfZQ/L9BwMlROXXPLkp+
	VRaGle6/oKG+ewbpCdKHlc3SB/va5Ubz8QCiTlPjOBx8k8BjSCu5ZQlKwAdYSnRGa/dlPv7nPwL
	X2JbYpZi1adFIIw/LgXX8IEHbOccDXkX5Zco4WUtKBfKyb+uFNWLUbJJt26VUB8Kdaf/R4FIkEk
	KIWst00VXGUwjVWcJBxkn17J8UaKRBhVSuFIwIPr0RyOrlcdXl7lSbBHxJS4KheAAztczqP1uIZ
	Xum8xbzQeB4rnGnrbcroUjC474s/Nt+vQLiWURHvGtssbH7Pw=
X-Google-Smtp-Source: AGHT+IGKmCGKGySNicqs4xJGk+i+s9kw/CHqN9iUzNLfPqlhccuKV5IcvEHMXa4//k4WJEgaY9FAEw==
X-Received: by 2002:a05:6a00:391a:b0:7a2:78ec:4f48 with SMTP id d2e1a72fcca58-7a441c476ffmr1466362b3a.23.1761604187646;
        Mon, 27 Oct 2025 15:29:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068f0fsm9509337b3a.46.2025.10.27.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com,
	csander@purestorage.com,
	kernel-team@meta.com
Subject: [PATCH v2 5/8] fuse: use enum types for header copying
Date: Mon, 27 Oct 2025 15:28:04 -0700
Message-ID: <20251027222808.2332692-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027222808.2332692-1-joannelkoong@gmail.com>
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use enum types to identify which part of the header needs to be copied.
This improves the interface and will simplify both kernel-space and
user-space header addresses when fixed buffer support is added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 55 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index faa7217e85c4..d96368e93e8d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,12 @@ struct fuse_uring_pdu {
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
+enum fuse_uring_header_type {
+	FUSE_URING_HEADER_IN_OUT,
+	FUSE_URING_HEADER_OP,
+	FUSE_URING_HEADER_RING_ENT,
+};
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -574,9 +580,31 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
-static int copy_header_to_ring(void __user *ring, const void *header,
-			       size_t header_size)
+static void __user *get_user_ring_header(struct fuse_ring_ent *ent,
+					 enum fuse_uring_header_type type)
+{
+	switch (type) {
+	case FUSE_URING_HEADER_IN_OUT:
+		return &ent->headers->in_out;
+	case FUSE_URING_HEADER_OP:
+		return &ent->headers->op_in;
+	case FUSE_URING_HEADER_RING_ENT:
+		return &ent->headers->ring_ent_in_out;
+	}
+
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+static int copy_header_to_ring(struct fuse_ring_ent *ent,
+			       enum fuse_uring_header_type type,
+			       const void *header, size_t header_size)
 {
+	void __user *ring = get_user_ring_header(ent, type);
+
+	if (!ring)
+		return -EINVAL;
+
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
 		return -EFAULT;
@@ -585,9 +613,15 @@ static int copy_header_to_ring(void __user *ring, const void *header,
 	return 0;
 }
 
-static int copy_header_from_ring(void *header, const void __user *ring,
-				 size_t header_size)
+static int copy_header_from_ring(struct fuse_ring_ent *ent,
+				 enum fuse_uring_header_type type,
+				 void *header, size_t header_size)
 {
+	const void __user *ring = get_user_ring_header(ent, type);
+
+	if (!ring)
+		return -EINVAL;
+
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
 		return -EFAULT;
@@ -606,8 +640,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -656,7 +690,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -675,7 +709,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out,
 				   sizeof(ent_in_out));
 }
 
@@ -705,7 +740,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -800,7 +835,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				    sizeof(req->out.h));
 	if (err) {
 		req->out.h.error = err;
-- 
2.47.3


