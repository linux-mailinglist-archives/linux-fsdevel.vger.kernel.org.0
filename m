Return-Path: <linux-fsdevel+bounces-61105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C4B55386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67531D67F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A330EF65;
	Fri, 12 Sep 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyynvr90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2230EF91
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690891; cv=none; b=LdsTowhzbfjr3KQNsWT4790U81iJ8AINFOSxk8uGVH8zduKJeMPP5Ep3WINLjYYrGU7km8e2t+8SWkbqvGoKHGaDHRsHnLzsIGOTpd0FM1yi6sFqsi95PCByuS6pDBY/zD/i6J026nnGzpeZR2Foo4Q2gWE6uT7HEv2XFP7uxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690891; c=relaxed/simple;
	bh=K07NRUo9zqY4nN5kRcvIAFfqMj5VZl1mhqG/F4Xn2WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjUgwjc3EOMm8LGQDnjdfl0OSx3wjWHXUD3olQU1Xi+E/4WuONWYahr2zfXzd/4pTSg7VglsxmxbSALJXkgxh505b0rBgLSXpZtcLNTTyBen3s3v6Bk3lQ1R21lvpTuCQXnd0eCrym63mVXZsQ98bUfY3Oqfpi4z9aHD213mDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyynvr90; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2094632b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690889; x=1758295689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrAwY5JfDrvJYw4ViEeSxknJLuWu6wVTQX+QkSjS5Eg=;
        b=fyynvr90e5Y2BHQUMi9j9P2nol+bLdRSVREpQHg8BSONbBAlX2PV8lyNqiPMXKGRz5
         0VDp34EkhztUVpFdjVdXY578O9kzzKAs2s0yee8gkUbd5aWHbyi+gJ9A7MC6yhm80Rw2
         gcNLDMhAKG8T+r33yehhvvxtyw1uq9gm7TDEDlwgXOphlcZtjnfZX1FgGrcmiqu1NJ8h
         yzMPK1LBGzQf7jhd/QdXtSzIVZDbA16CipFnSh7oXZRT4kroYtnS2/UWlcmTZxBlomn8
         w6PXPZ6TxBNMS3I09p+nq+3f+B/tVm+Zdyow7UdF5WOH9/csJmY9KhM4gBxeSP5O2KuJ
         cRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690889; x=1758295689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrAwY5JfDrvJYw4ViEeSxknJLuWu6wVTQX+QkSjS5Eg=;
        b=i32PQ/GQh7RjNTIpWi5wPzv6Fiq3dg9S7c4ZjeHXJCrtbyDmtBo8aadc9djAKT7sr2
         5zgETatH8qLpkNLM4atuQs2Xhe7Kn71yUONRdP61m2Sm5t0ULydWQDLbMarKHY7GRtdL
         IfPHvNVJDXKaD7PEZ2YnoqhFMx4nqpFSDEYLr6e5u+MUJnVpdGtuLveDVODsol/FjaeP
         0UaqPgyBQbOZLpQpxRfS/6IYNTJO/LjT/hI5JiUI03jSRM4xqHqlBxqbFJZQBOzQvvbv
         M5sqD8puXza4BDW26hLiBqQfP2C1eRkFNv4SJAkTXLHmG2XR597qYQXjEUqcsXvNUxyL
         uz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtCKYw+BW0PtDCmAFJIxToBO6/s4rjm+kUL2hwIkWCIHbbhwEowwEpoBTQIOhRMdROB8VGQlyQwaIPu9Ok@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hiT+zU6/1XiVeSidyv9g/MC55YFJDSYoiLK3U7EKamDoun2d
	BylQwyAkEdR0GvaOUqcNgMztpBe+OvzBJG1Dgvm2BkBCtodmwDmc7OfM
X-Gm-Gg: ASbGncsyrLNFU/i/eiIuJqNAcnt6jZ93EEBIHK8n3iATrzxw8tcUZ1KpGmlinZGilQ1
	K/OXhQCxWwD7bUdCiC0tMX6ErHnKETjcXHb0OmRMKRYJvJjkRt5GzQbljs8tbsTrwbN6Cwhewft
	0Y1DFY10cKfyraPE9v2dN33qS5Ph6j56oGBioE391WgzT6sbQbz3Y5mTcdD3wMH1yXbAtIu1Fm5
	ArIjUVW5YcR5/WCd5qXn77XT/TY0tAotq4raVqyO07YGDAgoC4bKtIIBzWjOq0kc1yj7Rw8WkEu
	DLPLSko34n1LmN759YM7cS570sFTIDIj++fn2Cenn6jA+fOGJH4zbZInNksMbIR4+mdTOr0qFXr
	P5i8HGxTrOnAMqldb9f7cVWAoudtB4CCd3ilq
X-Google-Smtp-Source: AGHT+IHXjF/YrVBz4mMGetnwhko7i25Vp3SjUA9r6o22PANiDSx6Iqp70TZfGVsCdF/6nIvuJ2zKUw==
X-Received: by 2002:a05:6a00:1883:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-77612060bc4mr4061361b3a.7.1757690889383;
        Fri, 12 Sep 2025 08:28:09 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:28:08 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 09/10] io_uring: add support for IORING_OP_OPEN_BY_HANDLE_AT
Date: Fri, 12 Sep 2025 09:28:54 -0600
Message-ID: <20250912152855.689917-10-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
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
index 4da2afdb9773..289d61373567 100644
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
+	file = do_file_handle_open(&ah->path, &op);
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
+
+	if (ah->path.dentry)
+		path_put(&ah->path);
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


