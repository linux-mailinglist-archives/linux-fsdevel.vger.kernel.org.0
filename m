Return-Path: <linux-fsdevel+bounces-40808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9AA27BED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6FB163CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626821A45C;
	Tue,  4 Feb 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nC+RRdxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B2204F7F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698512; cv=none; b=iQmcoRfibM9JcFhPtVq7iFvkKgay++LTYGaAezssTNjQ/WVOwdjso+G6xAC8zFxsjJOx3MXOqus7Mgci3nkXWpcRkRhu6bScR2PYHNATJTkqHUyAJl4MgR4V8xDV+5zjeHBka656igdcAxDALnevTDJZq6MB816xG9fq0wFbUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698512; c=relaxed/simple;
	bh=rMFiX9v+6Qn9eaEXSN5YhNQY8Wccxwgd3xMBzNbmH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeAGngr0eV4eARmQ9hr2h6A/mQ3v/6GIyAJJZziuR/zH17aUXln3FOg8VGBermgcDXOmlMwS4QvG+wWdEkasbaJ54Brud9iMDM3hAJ+/eaeszGdniKh1h2meNyAVTdF59vfU/uaCNhAEYCnnclCDrfakrs5LugHm6tIyeqBrHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nC+RRdxA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-84cdacbc3dbso109098139f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738698510; x=1739303310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58iy4j9boE/URjl057boaZ+KOAekFDkHOf6N1Ju+vZY=;
        b=nC+RRdxASnCRNCeerBYaNVopoVENoRF2mcFCdAHXxO0TBOz60PE2ABBcY3YEQfamfr
         V+A5B8lhK+Q5ts/L/bHmNQX06H+xD/FKJFtzAO2W2jH47qz+NoP1Sl2tHtIAqiu+G/cW
         +lOIosu6ZfdFU0EgvC87PbgSjzDofkH+Nl0l02xNU4G8veQYlvO21lNQahgmyJi5ZAI6
         SFLsKLqOUC2k0j/BcQp+yEsg1m7t/URSZm4lW4FzWAp9fbavlb7Vt9GOqTCG2fg4J7Sz
         YzDwnME2vyzuWbfn3et5yom+Q5WGfI3T0o1tD1G1mP2JdmEvgFHCCw2ySsi7qIZIU+mC
         Sdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698510; x=1739303310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58iy4j9boE/URjl057boaZ+KOAekFDkHOf6N1Ju+vZY=;
        b=dT5Zx2N/Wb7c3aLq3P/gGGrHQjKyqumnZdUtfm2sZewwltFmvUN0xnIHUtOSThiRSI
         jUXctZb5sD8HwxmNcPI34ngtlgPw8jq5Iyo/Zr+kTMbhlsjjHO0HHzJJ20mlHRkzfl1/
         mqUD/kr8s2z/S+RS1JUIEyBLik0ygzz2yhYz3/lw7Pc/+twHElnzdicW8GCAxWvY39dT
         TFGSemgRMy486xr4tOaIhqi3bVHuSXs34+ZB1FmAwOeypqwWX/nxWtV0LaykW+mKJM98
         0dvICoOMqqX/ynjJyiG66RIPMc/1CGRAMlkqq0faWRxkyvH1X5jF1iCn1l3JeWAbxEnM
         Q+qw==
X-Gm-Message-State: AOJu0Ywadko84Ui3ndgz26d5Z6kEqqH/RIAKXX/u2JwImBUye6gzTs9D
	ov7gkO1yQM8q1WusPQyPLUXFp6CztjFt57/0gc+slezNw30H4cgkprbYHprup6kpfFOfw6A5BMX
	S
X-Gm-Gg: ASbGncuuolhuox1ZwdPs3WR7b7+CBITqx2+Dl40iETrZ2EQcVGHq9oEh9gy5D4JLEGX
	PZOJKYbTEENtvf66r0ZdTB/iqLm+uwVDsJzNW85LgQmWxAWwXWuYDCKKx8cxxcRDwT6lRFXAfZa
	b8MgN7Fd+kTVhjzuYYEIaiGlFaE50H5h5EraPdJ5czSXPympIF3niXtJhSkcxKLaCrz0BPVPqvo
	odrpYqccblv6IU/yqXrKuudC3r0RKYHULuqYPPqNjEcTGP1YIyBBVSJbm49RuDT5xkKw9DfctmQ
	hPmWQjMWEv1iIrrSd2w=
X-Google-Smtp-Source: AGHT+IFE7ZhJCuBp+WjGdKWIbdxjAaCNfYYqYgyd7hMpS8QJF7O6hJJrVQWqdpwEDpEaYYbdGFmAFA==
X-Received: by 2002:a05:6602:3a8a:b0:841:a9d3:3b39 with SMTP id ca18e2360f4ac-854ea436a47mr37859239f.5.1738698510572;
        Tue, 04 Feb 2025 11:48:30 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746c95c4sm2841466173.127.2025.02.04.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:48:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] io_uring/epoll: add support for provided buffers
Date: Tue,  4 Feb 2025 12:46:44 -0700
Message-ID: <20250204194814.393112-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204194814.393112-1-axboe@kernel.dk>
References: <20250204194814.393112-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be a prerequisite for adding multishot support, but can be
used with single shot support as well. Works like any other request that
supports provided buffers - set addr to NULL and ensure that
sqe->buf_group is set, and IOSQE_BUFFER_SELECT in sqe->flags. Then epoll
wait will pick a buffer from that group and store the events there.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/epoll.c | 31 +++++++++++++++++++++++++++----
 io_uring/opdef.c |  1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 5a47f0cce647..134112e7a505 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
+#include "kbuf.h"
 #include "epoll.h"
 #include "poll.h"
 
@@ -189,11 +190,13 @@ int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
 
-	if (sqe->off || sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->off || sqe->rw_flags || sqe->splice_fd_in)
 		return -EINVAL;
 
 	iew->maxevents = READ_ONCE(sqe->len);
 	iew->events = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	if (req->flags & REQ_F_BUFFER_SELECT && iew->events)
+		return -EINVAL;
 
 	iew->wait.flags = 0;
 	iew->wait.private = req;
@@ -207,22 +210,42 @@ int io_epoll_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 int io_epoll_wait(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_epoll_wait *iew = io_kiocb_to_cmd(req, struct io_epoll_wait);
+	struct epoll_event __user *evs = iew->events;
 	struct io_ring_ctx *ctx = req->ctx;
+	int maxevents = iew->maxevents;
+	unsigned int cflags = 0;
 	int ret;
 
 	io_ring_submit_lock(ctx, issue_flags);
 
-	ret = epoll_wait(req->file, iew->events, iew->maxevents, NULL, &iew->wait);
+	if (io_do_buffer_select(req)) {
+		size_t len = iew->maxevents * sizeof(*evs);
+
+		evs = io_buffer_select(req, &len, 0);
+		if (!evs) {
+			ret = -ENOBUFS;
+			goto err;
+		}
+		maxevents = len / sizeof(*evs);
+	}
+
+	ret = epoll_wait(req->file, evs, maxevents, NULL, &iew->wait);
 	if (ret == -EIOCBQUEUED) {
+		io_kbuf_recycle(req, 0);
 		if (hlist_unhashed(&req->hash_node))
 			hlist_add_head(&req->hash_node, &ctx->epoll_list);
 		io_ring_submit_unlock(ctx, issue_flags);
 		return IOU_ISSUE_SKIP_COMPLETE;
-	} else if (ret < 0) {
+	} else if (ret > 0) {
+		cflags = io_put_kbuf(req, ret * sizeof(*evs), 0);
+	} else if (!ret) {
+		io_kbuf_recycle(req, 0);
+	} else {
+err:
 		req_set_fail(req);
 	}
 	hlist_del_init(&req->hash_node);
 	io_ring_submit_unlock(ctx, issue_flags);
-	io_req_set_res(req, ret, 0);
+	io_req_set_res(req, ret, cflags);
 	return IOU_OK;
 }
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 44553a657476..04ff2b438531 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -520,6 +520,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.needs_file		= 1,
 		.unbound_nonreg_file	= 1,
 		.audit_skip		= 1,
+		.buffer_select		= 1,
 #if defined(CONFIG_EPOLL)
 		.prep			= io_epoll_wait_prep,
 		.issue			= io_epoll_wait,
-- 
2.47.2


