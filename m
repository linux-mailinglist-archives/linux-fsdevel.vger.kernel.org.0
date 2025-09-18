Return-Path: <linux-fsdevel+bounces-60866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D38B523CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD7C1C831C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 21:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F030F81F;
	Wed, 10 Sep 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/VrsBye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586132D1926
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540871; cv=none; b=rGltfFmQefOyqqBBFd/6JkNusA2olsGTrAkZqgx425NZqx4acA6cBdontfajnvkXmyrtnkM+RvU6T1ioKWdVKRaBE1DbRrLqZX0L/YaQ6/Raax7oz9q5itTaUUkhHkApyHOLAhcvUVc/PdW+xZWjBqr7VekV7/UMefHgYeRR3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540871; c=relaxed/simple;
	bh=f2/McxWim3UKJhky8G1fVMzgzt6FRuFaXzfhuMIgIDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvo2XKF9u3QD8zGXGRzHheWeTTGWgV1k88ZyX8OQDJT+1jHcRFHqqk9KR2v8uTZ4HWI3ezEa7B8vajqviNXshWAbW9oqhndP/CChtes33fF8zSqsGpXmUg4OhyI/QbOLUONTOgESkWUB6u4wT5KsGSRyt1Du8YVMdXwhl584je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/VrsBye; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7741991159bso116098b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757540869; x=1758145669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXfs+1bZrl7Ru70tWZxxoQLLBzYZCPrutEmNF7NhiU0=;
        b=e/VrsByeMKTCerktztXolw6MlKnvzuvfBh73UT0iz8UfOpFilUekSZvR2l6myIy0df
         98baMumVkoMTfUufRvo23r6K9j/sC9xuld2eUlfl8xP8SUcXhw/ZjKvB6euTtnASr5lY
         8FxI18KQmlbg7DrR5VnHG3vsVreOVd3Z9FJ9ObHSt+NmwT8wTT+Kek/4K0ZTFCNkRTdV
         Z3w6E4P/BSq5Ut3KN2pSKzJuUmQF3xsdQE1Jl68ChsJu44qx0OucJcCdvFFjoqHnrQvY
         YNu+IH1huud7Sgg6608gplZAx6LCfh3wXBPUyYojCrOUVgnFgCTNN7mJxqFPhWF9F8Y3
         E2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540869; x=1758145669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXfs+1bZrl7Ru70tWZxxoQLLBzYZCPrutEmNF7NhiU0=;
        b=oOrivJiUa+I/1LMHraPwRDc5pCIm/Y36g4n3l3fX41CMJhAEkAh5+iNTJbdPoigVPn
         fg8qNxLdqwEN+TlVBPY8hyta63ClhdnAURma9zDDgKNFOzT8Z+ESMq4fxtS+YwaukGCl
         TCdjB+QKflvw06qGwRYzB6FmTIxi8M5fq/dLBBUflM/AkpqK2fS+xmIKXpQd8/ev5Rl9
         bP/hwISG4MGfCjXAzpTRpFTLEiuk/taO94Ad+258UoOaS0o7aBD3LuVlYH2fZ3rxqcpN
         EvuhCr+wAj+ocm7jSmOpdoh4spp3t2Uk4uMBvWqmNI/HxngVVLll9YSBojDi8Xdcc6Ea
         h5KA==
X-Forwarded-Encrypted: i=1; AJvYcCWFjEbjCW9g40YtkTMNeX83MM608xQGulUJDhXhYgXSjW+9oC73Cxuve4kOEKzDOL4YARhx8nNxoddLW+xk@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZrq7TFw6fk3sp+GwXfHyaOvP3F3JJd2RFqh3GnbBhadUZrdx
	tuhF2gt+/OFL9paBenEUeKi7uipj6/zm8DyZua/F9Zt9DVzjU/6mw8Im
X-Gm-Gg: ASbGncuIP58r6MIHPLtGg+J8ZVIDJBQtACC4EJlwXI/zGKonWq+902N6xQr4rn1xaXr
	nI49T5VJ65VoQsOXKiV9+TCYLYZ01z2SnACDOLIs4kykCGwz2T8MLNE0+65COOZp9p1IJZli3SC
	LOY1QB9Unv1xJKmM3NYiJZUFwVkoeN1W1FmAtks+6hFHyTIq9EcMpNBDVTFCGGYPCcNF1jv3F14
	Ta5XjP9hQYpsv6mlmPNwKWu1WsdRAqAGgD7IsNq3MZ+VjubUXwGaU5j7RTA/Qbr8adeewpnXpNz
	rdDE+vQjBktpnyEtYhsPp+jqXOXPRSKeUYq4Pmtmy2QdWY+78qNaJNrodRS/QQtvinenBtiBhLO
	5IMMuvE07Nfeh0vFRbHETH3K4lW7E85oAfeJn
X-Google-Smtp-Source: AGHT+IFWXFpSS3cCGNps/iqGUef71VmcB3I5MgiZK/5qDYMYY/7l0FoOoY8nprxphVPIGYBmJJlLAg==
X-Received: by 2002:a05:6a00:2d26:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-7742dd64853mr19972652b3a.7.1757540868701;
        Wed, 10 Sep 2025 14:47:48 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775fbbc3251sm2422516b3a.103.2025.09.10.14.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:47:48 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>,
	chuck.lever@oracle.com,
	jlayton@kernel.org
Subject: [PATCH 09/10] io_uring: add support for IORING_OP_OPEN_BY_HANDLE_AT
Date: Wed, 10 Sep 2025 15:49:26 -0600
Message-ID: <20250910214927.480316-10-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910214927.480316-1-tahbertschinger@gmail.com>
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for open_by_handle_at(2) to io_uring.

First an attempt to do a non-blocking open by handle is made. If that
fails, for example, because the target inode is not cached, a blocking
attempt is made.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 include/uapi/linux/io_uring.h |   1 +
 io_uring/opdef.c              |  15 +++++
 io_uring/openclose.c          | 111 ++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |   8 +++
 4 files changed, 135 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a4aa83ad9527..c571929e7807 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -291,6 +291,7 @@ enum io_uring_op {
 	IORING_OP_WRITEV_FIXED,
 	IORING_OP_PIPE,
 	IORING_OP_NAME_TO_HANDLE_AT,
+	IORING_OP_OPEN_BY_HANDLE_AT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 76306c9e0ecd..1aa36f3f30de 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -580,6 +580,15 @@ const struct io_issue_def io_issue_defs[] = {
 		.issue			= io_name_to_handle_at,
 #else
 		.prep			= io_eopnotsupp_prep,
+#endif
+	},
+	[IORING_OP_OPEN_BY_HANDLE_AT] = {
+#if defined(CONFIG_FHANDLE)
+		.prep			= io_open_by_handle_at_prep,
+		.issue			= io_open_by_handle_at,
+		.async_size		= sizeof(struct io_open_handle_async),
+#else
+		.prep			= io_eopnotsupp_prep,
 #endif
 	},
 };
@@ -835,6 +844,12 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_NAME_TO_HANDLE_AT] = {
 		.name			= "NAME_TO_HANDLE_AT",
 	},
+	[IORING_OP_OPEN_BY_HANDLE_AT] = {
+		.name			= "OPEN_BY_HANDLE_AT",
+#if defined(CONFIG_FHANDLE)
+		.cleanup		= io_open_by_handle_cleanup,
+#endif
+	}
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index 4da2afdb9773..dbc883f4654c 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/exportfs.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
@@ -245,6 +246,116 @@ int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags)
 	io_req_set_res(req, ret, 0);
 	return IOU_COMPLETE;
 }
+
+int io_open_by_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
+	struct io_open_handle_async *ah;
+	u64 flags;
+	int ret;
+
+	flags = READ_ONCE(sqe->open_flags);
+	open->how = build_open_how(flags, 0);
+
+	ret = __io_open_prep(req, sqe);
+	if (ret)
+		return ret;
+
+	ah = io_uring_alloc_async_data(NULL, req);
+	if (!ah)
+		return -ENOMEM;
+	memset(&ah->path, 0, sizeof(ah->path));
+	ah->handle = get_user_handle(u64_to_user_ptr(READ_ONCE(sqe->addr)));
+	if (IS_ERR(ah->handle))
+		return PTR_ERR(ah->handle);
+
+	req->flags |= REQ_F_NEED_CLEANUP;
+
+	return 0;
+}
+
+int io_open_by_handle_at(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_open *open = io_kiocb_to_cmd(req, struct io_open);
+	struct io_open_handle_async *ah = req->async_data;
+	bool nonblock_set = open->how.flags & O_NONBLOCK;
+	bool fixed = !!open->file_slot;
+	struct file *file;
+	struct open_flags op;
+	int ret;
+
+	ret = build_open_flags(&open->how, &op);
+	if (ret)
+		goto err;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		ah->handle->handle_type |= FILEID_CACHED;
+	else
+		ah->handle->handle_type &= ~FILEID_CACHED;
+
+	if (!ah->path.dentry) {
+		/*
+		 * Handle has not yet been converted to path, either because
+		 * this is our first try, or because we tried previously with
+		 * IO_URING_F_NONBLOCK set, and failed.
+		 */
+		ret = handle_to_path(open->dfd, ah->handle, &ah->path, op.open_flag);
+		if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
+			return -EAGAIN;
+
+		if (ret)
+			goto err;
+	}
+
+	if (!fixed) {
+		ret = __get_unused_fd_flags(open->how.flags, open->nofile);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (issue_flags & IO_URING_F_NONBLOCK) {
+		WARN_ON_ONCE(io_openat_force_async(open));
+		op.lookup_flags |= LOOKUP_CACHED;
+		op.open_flag |= O_NONBLOCK;
+	}
+	file = do_filp_path_open(&ah->path, &op);
+
+	if (IS_ERR(file)) {
+		if (!fixed)
+			put_unused_fd(ret);
+		ret = PTR_ERR(file);
+		if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
+			return -EAGAIN;
+		goto err;
+	}
+
+	if ((issue_flags & IO_URING_F_NONBLOCK) && !nonblock_set)
+		file->f_flags &= ~O_NONBLOCK;
+
+	if (!fixed)
+		fd_install(ret, file);
+	else
+		ret = io_fixed_fd_install(req, issue_flags, file,
+					  open->file_slot);
+
+err:
+	io_open_by_handle_cleanup(req);
+	req->flags &= ~REQ_F_NEED_CLEANUP;
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+void io_open_by_handle_cleanup(struct io_kiocb *req)
+{
+	struct io_open_handle_async *ah = req->async_data;
+	if (ah->path.dentry) {
+		path_put(&ah->path);
+	}
+
+	kfree(ah->handle);
+}
 #endif /* CONFIG_FHANDLE */
 
 int __io_close_fixed(struct io_ring_ctx *ctx, unsigned int issue_flags,
diff --git a/io_uring/openclose.h b/io_uring/openclose.h
index 2fc1c8d35d0b..f966859a8a92 100644
--- a/io_uring/openclose.h
+++ b/io_uring/openclose.h
@@ -10,9 +10,17 @@ void io_open_cleanup(struct io_kiocb *req);
 int io_openat2_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_openat2(struct io_kiocb *req, unsigned int issue_flags);
 
+struct io_open_handle_async {
+	struct file_handle		*handle;
+	struct path			path;
+};
+
 #if defined(CONFIG_FHANDLE)
 int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags);
+int io_open_by_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_open_by_handle_at(struct io_kiocb *req, unsigned int issue_flags);
+void io_open_by_handle_cleanup(struct io_kiocb *req);
 #endif /* CONFIG_FHANDLE */
 
 int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
-- 
2.51.0


