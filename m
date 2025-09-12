Return-Path: <linux-fsdevel+bounces-61098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A0B55361
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C565A71ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE29226D1E;
	Fri, 12 Sep 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq5C6nyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1A22154F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690851; cv=none; b=AO/hEuTnO1HmxeHuEwo3kd0p8Rf01VbaGvFHICybpjA3iDc2Wv3UnfcnWpvEGCptRh/fZsfKFiJ+NUyn/l+hUnql5jRTomUNvdaG3dUvBx+wOWpgAkLbC7GKBvvmDlgkH7sTfNYsL9pyJf3KNYrjnojIy35OniSELCWJ6QXqkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690851; c=relaxed/simple;
	bh=gX9LM04WuGkmadDIeCCzsTULPHnflype1+UrWxWmNd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6xkzh/vqdQsfhQ1ATBbaSHpJ0Ev91sD/503At+naszHzFB8ubEWgNc6KE1RsG85GZQ0Bt/T9UBLqf/WLULMpg2ii6fK1P7xOyIbcVYFlTm+ykoVycELgUE+7KVy4gBjmWV+2v3bpqh1PWbn2CqnwgZNOe4XNwHIo374wpcZa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq5C6nyX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7741991159bso3052556b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690847; x=1758295647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkS1HpoO21kqYsaFddGIvi50oyb/ms3N1SDnlykzSp4=;
        b=Cq5C6nyXfYUZ/oAMt3BrfWNxoseLIW5v8L7owvmXwhuygiegx3wjHX76XESS8FgHmh
         p1EC/KgIDp3SLSnEOzGychfvTJ6cvtBXD1Udnb6izdZzlZVYYESHBfQCNSEdmqKwd2p2
         RupMlKMcX3eLuRiqnqYDJVIs1JPNHJ2IrlkCSrjqy12qwNoTr/ybAjNfL5njfvPaGD1a
         zLM/Pog+GshljgjbXbqIfMluCQUmh4oLBusq2Abn9TWflCMJRxHtG+HkXjnSeBJ4Ujfa
         Sa5jZfWN3NCKlFZ7bIwR9gUMSVNOkmFIkdCKCdnP+yN8bM4WaLRxaDuiCGUX2U3RhFI1
         Se6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690847; x=1758295647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkS1HpoO21kqYsaFddGIvi50oyb/ms3N1SDnlykzSp4=;
        b=NKHhBXzrvRa/+2uyHr2HRlwqXabn/5jS+v9GUUmrfgYlY0Tt4tKT7xf68CnvEE6q/3
         M5TaPJxwTiPPPEGw60cu7EUXtSL4z1SUSigZzFvWW0VS8dRzfM5fa4uYu61o5ZKXa4cf
         ptEjikZh/Px8XKuuhy4KGxSpJxzvRFmRAbIXnMrOB5w01/CtD608IEyq7ghuMdHkzwCG
         ss+XqKSU1cLWlSppORJS3YruiIy1wyIlOCYg7ka9srMXTR2cN0QNaJu1TqZJ7Rbsgb1P
         Ysz+xAuso488/bBeFw3sOW/jRR7lXIvkY84ijuEAqkkhmV99Nsy1UUkmWGNhKt4WAOOa
         964Q==
X-Forwarded-Encrypted: i=1; AJvYcCUG08U22EfP+kWkE57BuB7uFE/UNq6R/NWaOJmzamfIBEar/aH/52irxTQkHdTJZoXIxBs7XByuOVyv+43Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSYkK0SGkT5qWvWEu4eOWZw5oCYJKBYlypaLjoD6MG9C9gu39
	hIychqGSiSbWTUyC4kzH7OXrMetRQ3LlqYyvzzl56vD6JissdNh8yI9e
X-Gm-Gg: ASbGncs1D7rZAWoCh8qcyApOkwhyG+POugaiRAQz/trkHhdqGdeSBFnFykh8LO2pYRh
	GneHHaipTLByykQEkowPG9I4xBvpj6r38DwqlEPk1HJbv1mYJ++v5KvK6cJR+kMB3x38WT0GOY9
	2RsHyHTHBCxHGwd9MxMVzaEmFdIdNlJFWcQGkK5ia7VxpKa9f0cCSJRUQfzoImWAxbhlpDDpWJf
	M0jPgvmBu9oY8CE6YXWnQhUbdUo0mxTrn8+rjzIaobilmn/TQ06r55ugvOpSUWDCXAcXMsbiKgw
	NidHHH3F7zIG/gXzyIjNMt38MOBQJjY2MRczMpM+lwALmDn22S4ini0Zkwbos/BeacFICQcgLhc
	6jiUgtiS4QKux/MjDhQ7FELR/RAcOdf3BVg70
X-Google-Smtp-Source: AGHT+IHFvbnI0pLASoGPdv6sSFlzhJfcFJ7Qel8fvRdrToBY/qELc92CZIVaOr2K4Dl7zx1fqjFbrA==
X-Received: by 2002:a05:6a20:9148:b0:250:429b:9e5c with SMTP id adf61e73a8af0-26029eaa48amr4515323637.10.1757690847453;
        Fri, 12 Sep 2025 08:27:27 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:26 -0700 (PDT)
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
Subject: [PATCH v3 02/10] io_uring: add support for IORING_OP_NAME_TO_HANDLE_AT
Date: Fri, 12 Sep 2025 09:28:47 -0600
Message-ID: <20250912152855.689917-3-tahbertschinger@gmail.com>
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

Add support for name_to_handle_at(2) to io_uring.

Like openat*(), this tries to do a non-blocking lookup first and resorts
to async lookup when that fails.

This uses sqe->addr for the path, ->addr2 for the file handle which is
filled in by the kernel, and ->addr3 for the mouint_id which is filled
in by the kernel.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/opdef.c              | 11 +++++++++
 io_uring/openclose.c          | 45 +++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |  5 ++++
 4 files changed, 63 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6957dc539d83..a4aa83ad9527 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -74,6 +74,7 @@ struct io_uring_sqe {
 		__u32		install_fd_flags;
 		__u32		nop_flags;
 		__u32		pipe_flags;
+		__u32		name_to_handle_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -289,6 +290,7 @@ enum io_uring_op {
 	IORING_OP_READV_FIXED,
 	IORING_OP_WRITEV_FIXED,
 	IORING_OP_PIPE,
+	IORING_OP_NAME_TO_HANDLE_AT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 9568785810d9..76306c9e0ecd 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -574,6 +574,14 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_pipe_prep,
 		.issue			= io_pipe,
 	},
+	[IORING_OP_NAME_TO_HANDLE_AT] = {
+#if defined(CONFIG_FHANDLE)
+		.prep			= io_name_to_handle_at_prep,
+		.issue			= io_name_to_handle_at,
+#else
+		.prep			= io_eopnotsupp_prep,
+#endif
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -824,6 +832,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_PIPE] = {
 		.name			= "PIPE",
 	},
+	[IORING_OP_NAME_TO_HANDLE_AT] = {
+		.name			= "NAME_TO_HANDLE_AT",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index d70700e5cef8..884a66e56643 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -27,6 +27,15 @@ struct io_open {
 	unsigned long			nofile;
 };
 
+struct io_name_to_handle {
+	struct file			*file;
+	int				dfd;
+	int				flags;
+	struct file_handle __user	*ufh;
+	char __user			*path;
+	void __user			*mount_id;
+};
+
 struct io_close {
 	struct file			*file;
 	int				fd;
@@ -187,6 +196,42 @@ void io_open_cleanup(struct io_kiocb *req)
 		putname(open->filename);
 }
 
+#if defined(CONFIG_FHANDLE)
+int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
+
+	nh->dfd = READ_ONCE(sqe->fd);
+	nh->flags = READ_ONCE(sqe->name_to_handle_flags);
+	nh->path = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	nh->ufh = u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	nh->mount_id = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+
+	return 0;
+}
+
+int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
+	int lookup_flags = 0;
+	long ret;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		lookup_flags = LOOKUP_CACHED;
+
+	ret = do_sys_name_to_handle_at(nh->dfd, nh->path, nh->ufh, nh->mount_id,
+				       nh->flags, lookup_flags);
+
+	if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
+		return -EAGAIN;
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+#endif /* CONFIG_FHANDLE */
+
 int __io_close_fixed(struct io_ring_ctx *ctx, unsigned int issue_flags,
 		     unsigned int offset)
 {
diff --git a/io_uring/openclose.h b/io_uring/openclose.h
index 4ca2a9935abc..2fc1c8d35d0b 100644
--- a/io_uring/openclose.h
+++ b/io_uring/openclose.h
@@ -10,6 +10,11 @@ void io_open_cleanup(struct io_kiocb *req);
 int io_openat2_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_openat2(struct io_kiocb *req, unsigned int issue_flags);
 
+#if defined(CONFIG_FHANDLE)
+int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags);
+#endif /* CONFIG_FHANDLE */
+
 int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_close(struct io_kiocb *req, unsigned int issue_flags);
 
-- 
2.51.0


