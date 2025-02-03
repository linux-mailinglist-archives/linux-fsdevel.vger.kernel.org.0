Return-Path: <linux-fsdevel+bounces-40633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9CA26020
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126CE3A895C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE620B808;
	Mon,  3 Feb 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2WV48dbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2F20B1EC
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600292; cv=none; b=iCsrboZ1A2LFTjhmmPqbEJWNt+ihZYBVSQPVBgkPNspGM4d7I5lG6k9IkGrFANSpADpTW/TwTw7CzQfZeJ+7oqAtQVRdEbUeArXq+U3jvqc0fDlxWhUYQk3LxTbbLHhuE6P+8eIiT30k/jJD+uahf/B4Tx7RM8WNREKHvDzb4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600292; c=relaxed/simple;
	bh=im1ntOsYLHYjJiEvx6njeC6vx3wirWuYtKuqP171Gs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxIpJGUKmXmTT1SFQbrqDkDjtB5LI9sG9aUEco00pVpYsI5naihjukzCwTxV9Pk3DYtsqKW61uRJxa9e3WTQgZd4x3wA7Q1T71HojC2cH9T6vvchxMp6C8Wxo+ocwQyxYdM392VWiKVqZmRC2dyjASXcfglNjpCUFaQia+N771w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2WV48dbb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84a1ce51187so125329739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600290; x=1739205090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ8sKu9TA7JXcFTCTxuSEZOOG4qI+mYE1gZPeZ19VjI=;
        b=2WV48dbbfKhGaSERDCCzZF60fGOeZyC03tkpBZK7RgjcKch27ArVCY3GVA5Hu0IZ7g
         GDdZd6C329mlV4MdXKJfiBRbRBuEqtEYwLsg2IjIm93/REwy3wUC0xyFaJf+DOf0cyfu
         pVFdvT9HYWKiGYhc17JYskY7kHZw+QcSAhe+Puw0QXemx67vG6DXEM/D02DlmUDWT518
         qCiU+Uvrr2rIpS5gD8t5MRG8HqPSPebin5aphGYbjJRN5mVlRK94b9/dhxb3UEqgQnvQ
         PlBmhaXEfHsQDxRLErCo8KC4JsF/vIVG1FcjDm73jyFUJgwaRdzzpJ0s6j97yDUvSxeR
         SIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600290; x=1739205090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ8sKu9TA7JXcFTCTxuSEZOOG4qI+mYE1gZPeZ19VjI=;
        b=Wja7ypyvhBiyOgEZ27NuFiOr/YREkwJh7/ef9lXCCJG1vn4s0SzrjQMVmnzUMggraP
         /wkJ75i1hkfD6WyA+RxUZZP/1um9gj2V+IpKA0AXS+aOsA7/Ym6thnYbDL0ktdwGXGUn
         iI2Uuf2+mg57HwmV7h8WOqoP+/jG7fl4kM1o+7K47VePPjELiyXCqT7enIvsYNPS3z7e
         UJ3nDncZ5DAS3EVMA7P2Ie4ULJRJsReEaA5xZZaoRGRkh/BNSN40f6g5iRf6uRv+eF/7
         nhI4alumdd5s+09LHMaAMDzvdFt0CVmdXxOKn3Y2upQFgto1cZ0DZy5tnEzYdtj8/zS0
         taTg==
X-Gm-Message-State: AOJu0Yz9hHBMND1fgemTtv0wDFmyZ/z1OxEe1Jk0GWHqGSrUhPILBneP
	aaH8tBAe2zWT6JHXLJ+H5yvh/tJ4qyrLfgDjq5BcLykm0FuT6Tq7OD0GTC6D6gA=
X-Gm-Gg: ASbGncvwa8bvrYecZ6Wm0ldZEpaPSoUkh0u6l/Sj1X6Sg3AvfAvhF8Kb9LNFpm+AjpP
	sTBh0OZiYc5KUdccm8nMMvCrOrRUc2pKz16U+PgImSMdSl1Z2HVk6DWd2u3Aqk1oRN62V94S5rP
	4C/jmRvYlsLSIASTlANiBAq1Cism1hUuHhissFz2CyqlfPjP8u3h13tr6vhLrlto/h6rK830jxv
	Hcfz8SsdJy34PUHURjAy2qnsFbftasavvI3nBXT+xdtj9srWnutZyxGIFS1/k5zghORh+4pDxXZ
	5WLp64kogktqmue96Eg=
X-Google-Smtp-Source: AGHT+IHbguIeZfHTdu65ziKGW6ATBjS2yiHfTO/r9nckYu6FLpo07OrSWeS6IHMC5zGBM2+H37rscA==
X-Received: by 2002:a05:6602:394e:b0:83a:a305:d9ee with SMTP id ca18e2360f4ac-85439fbbbf9mr2298125539f.12.1738600289812;
        Mon, 03 Feb 2025 08:31:29 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] io_uring/poll: pull ownership handling into poll.h
Date: Mon,  3 Feb 2025 09:23:45 -0700
Message-ID: <20250203163114.124077-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203163114.124077-1-axboe@kernel.dk>
References: <20250203163114.124077-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using it from somewhere else. Rather than try and
duplicate the functionality, just make it generically available to
io_uring opcodes.

Note: would have to be used carefully, cannot be used by opcodes that
can trigger poll logic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 30 +-----------------------------
 io_uring/poll.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index bb1c0cd4f809..5e44ac562491 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -41,16 +41,6 @@ struct io_poll_table {
 	__poll_t result_mask;
 };
 
-#define IO_POLL_CANCEL_FLAG	BIT(31)
-#define IO_POLL_RETRY_FLAG	BIT(30)
-#define IO_POLL_REF_MASK	GENMASK(29, 0)
-
-/*
- * We usually have 1-2 refs taken, 128 is more than enough and we want to
- * maximise the margin between this amount and the moment when it overflows.
- */
-#define IO_POLL_REF_BIAS	128
-
 #define IO_WQE_F_DOUBLE		1
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -70,7 +60,7 @@ static inline bool wqe_is_double(struct wait_queue_entry *wqe)
 	return priv & IO_WQE_F_DOUBLE;
 }
 
-static bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
+bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
 {
 	int v;
 
@@ -85,24 +75,6 @@ static bool io_poll_get_ownership_slowpath(struct io_kiocb *req)
 	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
 }
 
-/*
- * If refs part of ->poll_refs (see IO_POLL_REF_MASK) is 0, it's free. We can
- * bump it and acquire ownership. It's disallowed to modify requests while not
- * owning it, that prevents from races for enqueueing task_work's and b/w
- * arming poll and wakeups.
- */
-static inline bool io_poll_get_ownership(struct io_kiocb *req)
-{
-	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
-		return io_poll_get_ownership_slowpath(req);
-	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
-}
-
-static void io_poll_mark_cancelled(struct io_kiocb *req)
-{
-	atomic_or(IO_POLL_CANCEL_FLAG, &req->poll_refs);
-}
-
 static struct io_poll *io_poll_get_double(struct io_kiocb *req)
 {
 	/* pure poll stashes this in ->async_data, poll driven retry elsewhere */
diff --git a/io_uring/poll.h b/io_uring/poll.h
index 04ede93113dc..2f416cd3be13 100644
--- a/io_uring/poll.h
+++ b/io_uring/poll.h
@@ -21,6 +21,18 @@ struct async_poll {
 	struct io_poll		*double_poll;
 };
 
+#define IO_POLL_CANCEL_FLAG	BIT(31)
+#define IO_POLL_RETRY_FLAG	BIT(30)
+#define IO_POLL_REF_MASK	GENMASK(29, 0)
+
+bool io_poll_get_ownership_slowpath(struct io_kiocb *req);
+
+/*
+ * We usually have 1-2 refs taken, 128 is more than enough and we want to
+ * maximise the margin between this amount and the moment when it overflows.
+ */
+#define IO_POLL_REF_BIAS	128
+
 /*
  * Must only be called inside issue_flags & IO_URING_F_MULTISHOT, or
  * potentially other cases where we already "own" this poll request.
@@ -30,6 +42,25 @@ static inline void io_poll_multishot_retry(struct io_kiocb *req)
 	atomic_inc(&req->poll_refs);
 }
 
+/*
+ * If refs part of ->poll_refs (see IO_POLL_REF_MASK) is 0, it's free. We can
+ * bump it and acquire ownership. It's disallowed to modify requests while not
+ * owning it, that prevents from races for enqueueing task_work's and b/w
+ * arming poll and wakeups.
+ */
+static inline bool io_poll_get_ownership(struct io_kiocb *req)
+{
+	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
+		return io_poll_get_ownership_slowpath(req);
+	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
+}
+
+static inline void io_poll_mark_cancelled(struct io_kiocb *req)
+{
+	atomic_or(IO_POLL_CANCEL_FLAG, &req->poll_refs);
+}
+
+
 int io_poll_add_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_poll_add(struct io_kiocb *req, unsigned int issue_flags);
 
-- 
2.47.2


