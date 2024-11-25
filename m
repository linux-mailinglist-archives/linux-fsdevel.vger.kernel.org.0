Return-Path: <linux-fsdevel+bounces-35819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE69D8796
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36852160FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA91CF2B7;
	Mon, 25 Nov 2024 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO1fN8dB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA51CEEAE;
	Mon, 25 Nov 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543871; cv=none; b=EJfQIMh9Wc8sTXRaVXSufPRs4jjFs+Y3C2+4K8N+gibOUdGszZm0Xo1IGVsbzgq1HbjwKPPJ6y8u6NjNkYgku33L9VWDsk3VU18849Ov++I7LeKfKPFZYWQblRNuEi7z3B0qWEFB64PeegKg39PbIZ4dVPeL1FeKDCcPwcw6JWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543871; c=relaxed/simple;
	bh=jRtvthJGewUfHc1mOQfwDm7bvOrXc360RRI5kgtRqCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQqeaExjx6sBn5URMXwO8h05OabT6ppdJ9wDq2Oq4PKu8roveerviu82UT+2Ver5Lxivp6fs7v3g90KyJY/vQRrV0dv9l6x1aijAHKkMxDnYfm92WbX4LNk7LLznHmx+Lp3z8ys366IlXYjDaYJd7ZXk93O8In0NWol9vjdctlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO1fN8dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC89AC4CECE;
	Mon, 25 Nov 2024 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543871;
	bh=jRtvthJGewUfHc1mOQfwDm7bvOrXc360RRI5kgtRqCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tO1fN8dBxhC0vnv9Isqr8UJc1PmO89Hp16Vk6pHikpFM1kWMTNwaQIubhuwdxM3UA
	 Lt9t/StAZfwMkN/1qzyrET9HB+vm+TVkcWcM5o1phg/jh25TAvar8W4uu1eR6MMbrd
	 Ud2xSczgcueLLWZtFRE8hj4vxG1cp6fXOfw+2gY65wlJLrFuPKFdDTQkdKJq2XLLJN
	 InrWgswe6HD8brnYN6LCjwsi35YwWhjRtC6fWSkf2K5Dqq4RHfeyFjGBKUwcXv7Nqt
	 /Z+cq+jrHf/eRXPoqPEd9JdtN8PlxMFYgTD/GIA1+ouwyDJyjmydW/9QM9SeMkkjLs
	 W3REUb6A71hyw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:18 +0100
Subject: [PATCH v2 22/29] io_uring: avoid pointless cred reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-22-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jRtvthJGewUfHc1mOQfwDm7bvOrXc360RRI5kgtRqCQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHo9Xhk/I+lTT+uVNNEt8boSV9N+Zwl/fxYz6c7lc
 5MW3frm0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARzkSGX0y/dKYY7Hj34dcU
 +RkdKUdZtq2xN//w76y/mu/l+uW/TtQy/GZvXKwYJ7rjxZ2JIUHfFfTzniTdmvbyiN7Bh5bCffv
 2/OMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

req->creds and ctx->sq_creds already hold reference counts that are
stable during the operations.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/io_uring.c | 4 ++--
 io_uring/sqpoll.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ad4d8e94a8665cf5f3e9ea0fd9bc6c03a03cc48f..8012933998837ddcef45c14f1dfe543947a9eaec 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1704,7 +1704,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		return -EBADF;
 
 	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
-		creds = override_creds(get_new_cred(req->creds));
+		creds = override_creds(req->creds);
 
 	if (!def->audit_skip)
 		audit_uring_entry(req->opcode);
@@ -1715,7 +1715,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		audit_uring_exit(!ret, ret);
 
 	if (creds)
-		put_cred(revert_creds(creds));
+		revert_creds(creds);
 
 	if (ret == IOU_OK) {
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 1ca96347433695de1eb0e3bec7c6da4299e9ceb0..6df5e649c413e39e36db6cde2a8c6745e533bea9 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -174,7 +174,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		const struct cred *creds = NULL;
 
 		if (ctx->sq_creds != current_cred())
-			creds = override_creds(get_new_cred(ctx->sq_creds));
+			creds = override_creds(ctx->sq_creds);
 
 		mutex_lock(&ctx->uring_lock);
 		if (!wq_list_empty(&ctx->iopoll_list))
@@ -192,7 +192,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		if (to_submit && wq_has_sleeper(&ctx->sqo_sq_wait))
 			wake_up(&ctx->sqo_sq_wait);
 		if (creds)
-			put_cred(revert_creds(creds));
+			revert_creds(creds);
 	}
 
 	return ret;

-- 
2.45.2


