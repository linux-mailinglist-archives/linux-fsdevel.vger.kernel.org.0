Return-Path: <linux-fsdevel+bounces-65800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36361C11B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2AA560C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328732C937;
	Mon, 27 Oct 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwHHEmgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81832C92A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604184; cv=none; b=YtzaqP+XFchZNicFrV4kGYJ/97ix0gLAYYAYfH7qkT6fOxTa2rHoiqw1qeRgmybkOG7W1dLwVzgpT8DRaVeVktr30VaGi/CPx5yIozLcZsNx0fHcIAa/+TruqnuEk9gTftQK0NioeUTK8rJm7D0hW/Qy1aEQOSu759y/SPxOpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604184; c=relaxed/simple;
	bh=q0CIG4sg3YcHVlE6O1hVSe7wVahN3MkLZ6EDbg4kQ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFZNnXaHMkx/utAGUJ7hMqOgd3aSw8w83DJJ31RZVYO9GyjW6PjxwaLzQ4aoRLXgrjLg6qdHFbQMKPaonP7rVPMIPPOVyw8kLXSoUX117nTPiuLC6NCCnT+qLrix/sLklZXGwIW+7Ss8S/Kdz5qXSIi1vxe2aCOvmg8LvgIqQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwHHEmgI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5084780b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604182; x=1762208982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIIe7J+2Fjq2fETJFbES/k/BB7orrQTU6gidQxHEsTo=;
        b=CwHHEmgID7HCJgLs+JGaOZMHcCZQAI/v+cuXLbVMWk6DcSQ9xwyC+ToDuwRdbbAi4w
         g7ysQZj7nTHDkIqsBqKLC56j8/v5DS+oUtkFV9DGSBgbE9WqW90p5htS+JqINlDwFJUV
         Jfk8smgYiSYIB0TLwyppTQvRga6Lie6nG3gGmoy5e+Zv2xsXR2wmAbfsrqdqZjiqeD/s
         p1061+Qdff1W51xa5kKado81ljg9cXCNUEIPUKkQYczHDhZ74wBpN9bpp9N5r42t5Lpe
         RQ0GCZdEo/uKSjy7O4YB7s7dN7sYLnNnQHwR5jg+UgpO21bekRDtTwUo9HnfJqKikPj9
         Qhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604182; x=1762208982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIIe7J+2Fjq2fETJFbES/k/BB7orrQTU6gidQxHEsTo=;
        b=F7Usad1GvOTSRxe7I5qdpfywUg3Wz0DcEqFG7dnShgKne9on4Gqjvn4C4Ik9A1ba/k
         l7sVCKJg69SqyIsEoO4qQ3vfh9rl7iQ4Md+uhMxW08f4Lvincm5eY8EFKSpLiba4O4TF
         /96sNgFbmH72DpLiFPPdgiMHmaLDJ5TKLq1Vbhe5InD1eu1QMBmWxUPxmiO/pg+L0S7m
         cGSqTy02dCI2XDMPHnR2OqSon55wv2s6lyPHBqKLb2Y29uY76T3PTjAjw+ZTVc4x5mhf
         6CGH0+XoPr27dbZb52LyXUlG9SDU5MbDeSonDuTtUtGT/fc55GE4jr7zGXB1MOJ9a9RC
         RtRg==
X-Gm-Message-State: AOJu0YwxnIxC/MufX/6GeB0Xi/am6pnzwPDos4b5CNElSfKSuQj+e7JD
	XhIqp/ui8rPxPMH5BkLbtllXlinVihKIionKrFv4y7gp2Rsv9cO1ITs9
X-Gm-Gg: ASbGnctdQfidNJNsih3qEqWD0/8OTcqRGIoymlS/IluLQmq0XK0sFuSiXHnuMwZH/hx
	pjrlN82l8fZDG2hYwxzHIMjVDncHO4Xt5BuZOI8kpa0E2/l/u55l2tJFdvXMusbZtKhBgGW+rOS
	kQB0932k4MG4vijqN3s5rkVunbiBkLuP4vTvBgoLf9JnA32O6vZclnpdtq95DYzpcJdSzjNqc3x
	HV9qn15On0NeFYpUknoVFLfUkVO7Db6jkiPlHGDmAdo+l8cfp8pymq7IaeUwj1A13PFNcjqmxpj
	DeGVB8nA5RfOsUdaSJzteQwS5zdC4tgyVLMjBvCLUYbI5QDh7erk7YMYb5MiiEXS88mMMujzXrf
	cyoQ1H79a+xbTcFkttCMh2QYFi5SBWM8Dg7McsgBVhuAjQbfY9MZmcPU32Yldcw2M3EmnevucXu
	9vL7AUxP/edJuD0BgSAvAikkWcULXDGVZWwEX0Pg==
X-Google-Smtp-Source: AGHT+IH/BlVDqq1xxpbiFJEvAxmdcEjzo1ibdPGr2BOfyfg8AS3BRphzOlQdrvhB8RrWeSysDEW2BA==
X-Received: by 2002:a05:6a00:9505:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-7a442e5a7f5mr1189940b3a.9.1761604182189;
        Mon, 27 Oct 2025 15:29:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301ecsm9448576b3a.24.2025.10.27.15.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:41 -0700 (PDT)
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
Subject: [PATCH v2 1/8] io_uring/uring_cmd: add io_uring_cmd_import_fixed_full()
Date: Mon, 27 Oct 2025 15:28:00 -0700
Message-ID: <20251027222808.2332692-2-joannelkoong@gmail.com>
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

Add an API for fetching the registered buffer associated with a
io_uring cmd. This is useful for callers who need access to the buffer
but do not have prior knowledge of the buffer's user address or length.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h |  3 +++
 io_uring/rsrc.c              | 14 ++++++++++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..8c11d9a92733 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -43,6 +43,9 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
+int io_uring_cmd_import_fixed_full(int rw, struct iov_iter *iter,
+				   struct io_uring_cmd *ioucmd,
+				   unsigned int issue_flags);
 int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..2c3d8489ae52 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1147,6 +1147,20 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+int io_import_reg_buf_full(struct io_kiocb *req, struct iov_iter *iter,
+			   int ddir, unsigned issue_flags)
+{
+	struct io_rsrc_node *node;
+	struct io_mapped_ubuf *imu;
+
+	node = io_find_buf_node(req, issue_flags);
+	if (!node)
+		return -EFAULT;
+
+	imu = node->buf;
+	return io_import_fixed(ddir, iter, imu, imu->ubuf, imu->len);
+}
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index a3ca6ba66596..4e01eb0f277e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -64,6 +64,8 @@ struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
+int io_import_reg_buf_full(struct io_kiocb *req, struct iov_iter *iter,
+			   int ddir, unsigned issue_flags);
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..07730ced9449 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -292,6 +292,19 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_full(int rw, struct iov_iter *iter,
+				   struct io_uring_cmd *ioucmd,
+				   unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
+		return -EINVAL;
+
+	return io_import_reg_buf_full(req, iter, rw, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_full);
+
 int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 				  const struct iovec __user *uvec,
 				  size_t uvec_segs,
-- 
2.47.3


