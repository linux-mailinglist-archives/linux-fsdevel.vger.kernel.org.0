Return-Path: <linux-fsdevel+bounces-40635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC97A26023
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B003A43FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFCF20C46A;
	Mon,  3 Feb 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eDun3atx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6A20B80A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600296; cv=none; b=iLC1fiK/uQXzD0AvuKyXlZSzj2+BJEuTAKisvrTEAB5JNobEjaBxHSyBf7qEFipzlYYlevtbjZWjd64L2kGVoBH/wHrqGrC8qbK1VqAkZ3QLk+HC5ddYEYr0Jq0zxNGRbMpJpapDSlJBNa+OsrVnDZjNNRQr2qx3DV+bBV4nR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600296; c=relaxed/simple;
	bh=SiJFHOGW3I3zFqN3kp56SHJQkVmhHehxUSx0Yzr7T3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNM8XI4r1pueeut53xXcnsH1RGeBtlQuPlBEiXfVrp35oTiSvqK/AG7Kw4149Fe6JjwsQKVifaVBKexSFYLwobNZqvO3C3yQPhc3tBYc3YBGJoCj85R1ZBJHVJwCiJc9+l7dba9HjdxEe8tbTVHXSN53kAF7EstGbe5bRG6MePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eDun3atx; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844ef6275c5so114463239f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738600294; x=1739205094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/fjiuRElsEUMm3xq1l9P9axtS1BBAUWMYirAwWU00g=;
        b=eDun3atxS7vxUznNqvzlHscmKmp+culWjhLBvNJamQbJNI3zSSllnwE6H20E5RhVlC
         GdeexBEgDdaMRNCM0Rp/xsAiKCBkwWytUDtmeOf2qjZjDClIS86rNr7jCmP9m3ThkGAD
         adgOQ+QR+e+dKkHlVgbT2H67SmahIgrsqwb9k7hFeB/HZSJJkEYywJAC9x+DKMbNhw95
         8wkvfAy10YfwYLhmM+FvoT1up2XAi/FoX6I93aWMYrr/8NyxiYRy6iPpCSfrO5dS6Dru
         ylXEMNStmLLB4J1BgnhhXJy7PoJayyYxNNKHoX0VSpb0KzFwEgDZTYvF78m3dt+sg9UK
         bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600294; x=1739205094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/fjiuRElsEUMm3xq1l9P9axtS1BBAUWMYirAwWU00g=;
        b=r387JNf/F6KUPjqB9Kdty+nHZExmHSi7RxxtaPqA/tqXhXbaVtirkHZX0xXrBKTx0d
         jauRrxLv9aAV8G4URCpq+RQ8KgfD67IUVQWH1HBj94IpU8WibvefATPXDkZ9/7pJCeuy
         4SF0yqtQfSKm7JAQRL+2c9vZbc4UVVhrP0p5EUWHRkpcsfkLojds1k/Zq9sJ6NsF8Ymi
         mXPgYoCIPef37DJWHKaPNsGBQJs1y2WJCyQd8WFHsW7gbmimPOl8/mbk+jqf2MvHtoUd
         z6giVmudIBEzhVM9lcwiKFA8C+fwpxlLN0hOOJmx7C87brFUBnmz6ODu8Z/JjUgvVf2q
         TL4w==
X-Gm-Message-State: AOJu0YxiIzPDHth1G/GT9W4SkoFEaTuc/jpQ5DzwlmiyLA/zTshqdfKI
	DrQurnolcqirGH5T06YnXhJIR+o2xDvzHpQ5VCoYljCgZfwchqpxpSf89+jHezQ=
X-Gm-Gg: ASbGncva44jAo85arzuwT5Z2gKf4nTKwMEHjEXl2g7xcxTQyOjbsnqHAgaQfsmDPbOG
	gjlK/ioJUaXyvTbYLonBOWYHCQRB5mtptVkYsS3itNoaqpct3HTuxTm46MmiJNaDRj/vOjHBX1c
	jF1y4SlXinbPOv1NM2ITE+QWALsn6cXqSgrJhWwWomo3aqkqp2p5CqE4WJVUkGLjgQwYVQ2ZdvY
	SKCpcbudW3jG8FV4NTQa841ex+7nouW2uJJ8g/TvI5cVO4FCdhXVJFPDK3yUKlvGLw7LgLlBVGG
	vv1/q3yVdVFeEPx6Lm4=
X-Google-Smtp-Source: AGHT+IH2wV2mJH512YPftlISVyZWUOTcz9QVi4y2nD/702D7EXmTUdDrOmfIKi7tAhOGaOpiBEGhqg==
X-Received: by 2002:a05:6602:3990:b0:844:debf:24dc with SMTP id ca18e2360f4ac-85411111991mr2269268639f.5.1738600292695;
        Mon, 03 Feb 2025 08:31:32 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16123c6sm243748139f.24.2025.02.03.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:31:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 9/9] io_uring/epoll: add multishot support for IORING_OP_EPOLL_WAIT
Date: Mon,  3 Feb 2025 09:23:47 -0700
Message-ID: <20250203163114.124077-10-axboe@kernel.dk>
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

As with other multishot requests, submitting a multishot epoll wait
request will keep it re-armed post the initial trigger. This allows
multiple epoll wait completions per request submitted, every time
events are available. If more completions are expected for this
epoll wait request, then IORING_CQE_F_MORE will be set in the posted
cqe->flags.

For multishot, the request remains on the epoll callback waitqueue
head. This means that epoll doesn't need to juggle the ep->lock
writelock (and disable/enable IRQs) for each invocation of the
reaping loop. That should translate into nice efficiency gains.

Use by setting IORING_EPOLL_WAIT_MULTISHOT in the sqe->epoll_flags
member.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  6 ++++++
 io_uring/epoll.c              | 40 ++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a559e1e1544a..93f504b6d4ec 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -73,6 +73,7 @@ struct io_uring_sqe {
 		__u32		futex_flags;
 		__u32		install_fd_flags;
 		__u32		nop_flags;
+		__u32		epoll_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -405,6 +406,11 @@ enum io_uring_op {
 #define IORING_ACCEPT_DONTWAIT	(1U << 1)
 #define IORING_ACCEPT_POLL_FIRST	(1U << 2)
 
+/*
+ * epoll_wait flags, stored in sqe->epoll_flags
+ */
+#define IORING_EPOLL_WAIT_MULTISHOT	(1U << 0)
+
 /*
  * IORING_OP_MSG_RING command types, stored in sqe->addr
  */
diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 2a9c679516c8..730f4b729f5b 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -24,6 +24,7 @@ struct io_epoll {
 struct io_epoll_wait {
 	struct file			*file;
 	int				maxevents;
+	int				flags;
 	struct epoll_event __user	*events;
 	struct wait_queue_entry		wait;
 };
@@ -145,12 +146,15 @@ static void io_epoll_retry(struct io_kiocb *req, struct io_tw_state *ts)
 	io_req_task_submit(req, ts);
 }
 
-static int io_epoll_execute(struct io_kiocb *req)
+static int io_epoll_execute(struct io_kiocb *req, __poll_t mask)
 {
 	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
 
 	if (io_poll_get_ownership(req)) {
-		list_del_init_careful(&iew->wait.entry);
+		if (mask & EPOLL_URING_WAKE)
+			req->flags &= ~REQ_F_APOLL_MULTISHOT;
+		if (!(req->flags & REQ_F_APOLL_MULTISHOT))
+			list_del_init_careful(&iew->wait.entry);
 		req->io_task_work.func = io_epoll_retry;
 		io_req_task_work_add(req);
 		return 1;
@@ -159,13 +163,13 @@ static int io_epoll_execute(struct io_kiocb *req)
 	return 0;
 }
 
-static __cold int io_epoll_pollfree_wake(struct io_kiocb *req)
+static __cold int io_epoll_pollfree_wake(struct io_kiocb *req, __poll_t mask)
 {
 	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
 
 	io_poll_mark_cancelled(req);
 	list_del_init_careful(&iew->wait.entry);
-	io_epoll_execute(req);
+	io_epoll_execute(req, mask);
 	return 1;
 }
 
@@ -176,18 +180,23 @@ static int io_epoll_wait_fn(struct wait_queue_entry *wait, unsigned mode,
 	__poll_t mask = key_to_poll(key);
 
 	if (unlikely(mask & POLLFREE))
-		return io_epoll_pollfree_wake(req);
+		return io_epoll_pollfree_wake(req, mask);
 
-	return io_epoll_execute(req);
+	return io_epoll_execute(req, mask);
 }
 
 int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
 
-	if (sqe->off || sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->off || sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 
+	iew->flags = READ_ONCE(sqe->epoll_flags);
+	if (iew->flags & ~IORING_EPOLL_WAIT_MULTISHOT)
+		return -EINVAL;
+	else if (iew->flags & IORING_EPOLL_WAIT_MULTISHOT)
+		req->flags |= REQ_F_APOLL_MULTISHOT;
 	iew->maxevents = READ_ONCE(sqe->len);
 	iew->events = u64_to_user_ptr(READ_ONCE(sqe->addr));
 
@@ -195,6 +204,7 @@ int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	iew->wait.private = req;
 	iew->wait.func = io_epoll_wait_fn;
 	INIT_LIST_HEAD(&iew->wait.entry);
+	INIT_HLIST_NODE(&req->hash_node);
 	atomic_set(&req->poll_refs, 0);
 	return 0;
 }
@@ -205,9 +215,11 @@ int io_epoll_wait(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	io_ring_submit_lock(ctx, issue_flags);
-	hlist_add_head(&req->hash_node, &ctx->epoll_list);
-	io_ring_submit_unlock(ctx, issue_flags);
+	if (hlist_unhashed(&req->hash_node)) {
+		io_ring_submit_lock(ctx, issue_flags);
+		hlist_add_head(&req->hash_node, &ctx->epoll_list);
+		io_ring_submit_unlock(ctx, issue_flags);
+	}
 
 	/*
 	 * Timeout is fake here, it doesn't indicate any kind of sleep time.
@@ -219,9 +231,17 @@ int io_epoll_wait(struct io_kiocb *req, unsigned int issue_flags)
 		return IOU_ISSUE_SKIP_COMPLETE;
 	else if (ret < 0)
 		req_set_fail(req);
+
+	if (ret >= 0 && req->flags & REQ_F_APOLL_MULTISHOT &&
+	    io_req_post_cqe(req, ret, IORING_CQE_F_MORE))
+		return IOU_ISSUE_SKIP_COMPLETE;
+
 	io_ring_submit_lock(ctx, issue_flags);
 	hlist_del_init(&req->hash_node);
 	io_ring_submit_unlock(ctx, issue_flags);
 	io_req_set_res(req, ret, 0);
+
+	if (issue_flags & IO_URING_F_MULTISHOT)
+		return IOU_STOP_MULTISHOT;
 	return IOU_OK;
 }
-- 
2.47.2


