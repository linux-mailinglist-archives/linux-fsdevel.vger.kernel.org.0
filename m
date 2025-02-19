Return-Path: <linux-fsdevel+bounces-42097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F8A3C62F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4513AABEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49631214801;
	Wed, 19 Feb 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C2nFRDgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8F214A6A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985972; cv=none; b=CkHFT7ieUAl6bFAJZweDKX6NAPm3W8etWCA7MYbWPHF8EtTJnxUzcKIhKdbLcZ/zZflqkr5hrZhju6h5jaX1TTBBzV3GiiwgDlwLREK8aOZL7qQXaImFu3fP3AtYcWjZx1aaUFAKRrCttrnfnkT4lCq4q7n7iNwvQUcLOUNGqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985972; c=relaxed/simple;
	bh=Dgu/2bYkWXrAMq3iF1/8GI7X79S6G6gmhyLC1ec2mfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS9FkTk5V0dbtpMjzxZknyS98wkFaDwQCI2Qvxg8FiS/cD4rE374tU6X1gCPyq4jw5THhdsI3IVPyzA2sHIl8wslGwyLZsB8hpj70YaQTKQNJWmUt4EDbR0GToiOmSYSutEnKoEtW4ULB2AizjkSkXv9BVhRZCVVX85JJf5AFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C2nFRDgx; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-854a68f5aeeso1110239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 09:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739985970; x=1740590770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gAHZg9kSYTvKQ33H52aoGebUTskPe032Qb9P2hQu70=;
        b=C2nFRDgxkeUJxOFus0XdLUwXUYVZZEsSkdAI1XHXzqRNSSQQmrJD9OXmqK81dXZ+BU
         niwem1/kEPxvdxUZ4YiskDmNk3XSt7OfAbpvEKkdN7ArTzI6ot1FF25GTJ5yH7Pn9+uZ
         flvqOxHUsldj7pQwY3oAWiOs9wBRDD647+RID/uADI4JAAEs46G5JA7AsA7MMk5HErtN
         XhWEQDxMA0mD9Ygz5zU2DfKt8w2L6YiZuftaXcoJiiDHarie7tDMknHTp/GULPB2F199
         xFwnXfySPzu1SCSPP34lIziFl53ES2XTG+iMHkehQXmKmPF++FLWcvkUio6s1clC0SOr
         tiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985970; x=1740590770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gAHZg9kSYTvKQ33H52aoGebUTskPe032Qb9P2hQu70=;
        b=B4j7Wg89dz0nqDfgwzTK4HNd6MViN361thmAmvvvh3KcS0QbcFLv+PGQqa1LuKMXn1
         vTNBWNt+8MU7R1HsrPFjXr+DMZVoRZO9ZZjvfkD7XUZ7h4f0alS2KQoiXRDqwOAU0TsM
         UDBMgzDaM+c/hxv81krOon4tdbk7AEs4BQSG4PuR70dNrRWq/ZTbqXDbV6ODIWVpkVbr
         BL33JYMvDrckQrGnmLSD2kbuY2k0OHrdQGKSIdwKzy4RwpK+LG2jkFqt4QOfbsNH+ZlA
         s+Mh81WgpSzidEmAwBjBjpwbEkMF1luhVfAgnkH5xzctXPSkwLzEItYtuoztg00mMOtw
         +TBg==
X-Gm-Message-State: AOJu0Yx6bUOOf0haMEbOgAd9FpzVLF5fYS2Eluv50SL6FP4MOOKRmAV+
	HCqeaJt3g3920dv37ekKPdQv20RXXWB+JeoKi0qdnMIopygB+3rnjQytP+kuYNY=
X-Gm-Gg: ASbGncu0FDcmVVBl245lRuKtFdi668TUD1R7pgHG2xCSHs94UbRACqZ0G5vA5iE1gKG
	qcJOhdI7DjZVF5SHBBj13gHC/cODP6zo5p2jt5bUvdvSCfRUtcTy1ucWmgxxAA60NQ8IDfJatTZ
	VP8FFpeUEghKTxsvMPuFYAuEEbu+LAozu6HI318b0NJh8sbU+wTzDZxG+aXlExktC2kDJisEJsl
	ITrgM4sqDEv0KOqgJF/P+blta4y2NsWkp8zpzr5NIiwc36baYw4HBqsIiSoG0slQRIO1nn0+tcB
	qNPTDiBKEvX4Vx8jShc=
X-Google-Smtp-Source: AGHT+IHjnt3iA5lsKLTSE6k9kN1FP0fHcpHTu6e9TZVmjZOfhdBtx2VkZxFxTUM+se6BvwdrScUk8Q==
X-Received: by 2002:a05:6602:6d8d:b0:855:b5fe:3fb7 with SMTP id ca18e2360f4ac-855b5fe4041mr283100139f.7.1739985970155;
        Wed, 19 Feb 2025 09:26:10 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8558f3ccdcesm142192839f.16.2025.02.19.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:26:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] io_uring/epoll: add support for IORING_OP_EPOLL_WAIT
Date: Wed, 19 Feb 2025 10:22:28 -0700
Message-ID: <20250219172552.1565603-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219172552.1565603-1-axboe@kernel.dk>
References: <20250219172552.1565603-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For existing epoll event loops that can't fully convert to io_uring,
the used approach is usually to add the io_uring fd to the epoll
instance and use epoll_wait() to wait on both "legacy" and io_uring
events. While this work, it isn't optimal as:

1) epoll_wait() is pretty limited in what it can do. It does not support
   partial reaping of events, or waiting on a batch of events.

2) When an io_uring ring is added to an epoll instance, it activates the
   io_uring "I'm being polled" logic which slows things down.

Rather than use this approach, with EPOLL_WAIT support added to io_uring,
event loops can use the normal io_uring wait logic for everything, as
long as an epoll wait request has been armed with io_uring.

Note that IORING_OP_EPOLL_WAIT does NOT take a timeout value, as this
is an async request. Waiting on io_uring events in general has various
timeout parameters, and those are the ones that should be used when
waiting on any kind of request. If events are immediately available for
reaping, then This opcode will return those immediately. If none are
available, then it will post an async completion when they become
available.

cqe->res will contain either an error code (< 0 value) for a malformed
request, invalid epoll instance, etc. It will return a positive result
indicating how many events were reaped.

IORING_OP_EPOLL_WAIT requests may be canceled using the normal io_uring
cancelation infrastructure.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h |  1 +
 io_uring/epoll.c              | 33 +++++++++++++++++++++++++++++++++
 io_uring/epoll.h              |  2 ++
 io_uring/opdef.c              | 14 ++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 05d6255b0f6a..135eb9296296 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -280,6 +280,7 @@ enum io_uring_op {
 	IORING_OP_BIND,
 	IORING_OP_LISTEN,
 	IORING_OP_RECV_ZC,
+	IORING_OP_EPOLL_WAIT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 7848d9cc073d..6d2c48ba1923 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -20,6 +20,12 @@ struct io_epoll {
 	struct epoll_event		event;
 };
 
+struct io_epoll_wait {
+	struct file			*file;
+	int				maxevents;
+	struct epoll_event __user	*events;
+};
+
 int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_epoll *epoll = io_kiocb_to_cmd(req, struct io_epoll);
@@ -57,3 +63,30 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
+
+int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
+
+	if (sqe->off || sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+		return -EINVAL;
+
+	iew->maxevents = READ_ONCE(sqe->len);
+	iew->events = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	return 0;
+}
+
+int io_epoll_wait(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
+	int ret;
+
+	ret = epoll_sendevents(req->file, iew->events, iew->maxevents);
+	if (ret == 0)
+		return -EAGAIN;
+	if (ret < 0)
+		req_set_fail(req);
+
+	io_req_set_res(req, ret, 0);
+	return IOU_OK;
+}
diff --git a/io_uring/epoll.h b/io_uring/epoll.h
index 870cce11ba98..4111997c360b 100644
--- a/io_uring/epoll.h
+++ b/io_uring/epoll.h
@@ -3,4 +3,6 @@
 #if defined(CONFIG_EPOLL)
 int io_epoll_ctl_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags);
+int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_epoll_wait(struct io_kiocb *req, unsigned int issue_flags);
 #endif
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 89f50ecadeaf..9344534780a0 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -527,6 +527,17 @@ const struct io_issue_def io_issue_defs[] = {
 		.issue			= io_recvzc,
 #else
 		.prep			= io_eopnotsupp_prep,
+#endif
+	},
+	[IORING_OP_EPOLL_WAIT] = {
+		.needs_file		= 1,
+		.audit_skip		= 1,
+		.pollin			= 1,
+#if defined(CONFIG_EPOLL)
+		.prep			= io_epoll_wait_prep,
+		.issue			= io_epoll_wait,
+#else
+		.prep			= io_eopnotsupp_prep,
 #endif
 	},
 };
@@ -761,6 +772,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_RECV_ZC] = {
 		.name			= "RECV_ZC",
 	},
+	[IORING_OP_EPOLL_WAIT] = {
+		.name			= "EPOLL_WAIT",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
-- 
2.47.2


