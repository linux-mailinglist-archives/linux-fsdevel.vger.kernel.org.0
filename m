Return-Path: <linux-fsdevel+bounces-35697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F39D75E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8757BC715E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312220D50A;
	Sun, 24 Nov 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS2JeZSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC520DD5B;
	Sun, 24 Nov 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455902; cv=none; b=Tg4HmqaPF/BNURHSz9opeZPbFR30SJg7dvFsN0Ic93ihn3f+R6sO9y3peOUpuZ+BhElsAbyhPZdpfIZfPw1xRHNAD8SWlXj0wlnA0RSz3RGGxPNgV2ZwpALjEEI9TjTJA/3UIwqSJslYabNItKjK9vBcD4f/DfHcMj971hFAd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455902; c=relaxed/simple;
	bh=zrNjxsAjCHPuNaCLSpJvKnvN3m8hTYHZar8IMmrrZ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyriOHyR5frz6PUvfAGB0r0XEeKGevVl47K8kLAzXB6WJMMOELlZZjnIxi0A0kRuH33TCWPbovU4QmnWm9uA3WH6aEhYVDryM2fTVdxbML3bXi0FiR+siS2sO1YWIYl92qG1pOPXIT3YfZ5uFv7Z3NxzSIWE0G7ubXu5jtMy20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS2JeZSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA7C4CED1;
	Sun, 24 Nov 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455901;
	bh=zrNjxsAjCHPuNaCLSpJvKnvN3m8hTYHZar8IMmrrZ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS2JeZSHY1mgMlhvxOAZvcwdSZlhVxyVXXQBH48ROlGFbdKVTKnER3kTqjuIoQwMp
	 yCyVt9JCKUFoQcOVAsIlM9gkvGZ14bBerCjWH1Iwswu5WluB5aw3dE+cMdxoJnprTI
	 c8R9M9CT5QPAW3Gm0qfmth18wcrbC93bve4wo6r6Z/spG6xlNB9K4tr179wdRhwIB/
	 e0RyQj5cX2xc8rYyrrfMZ+RaWtsBgGmiU5yropv4+2+v8VSkxneKp++dkKc55Qi6aM
	 Z8dlalq83fDsQNoc3lRfJSF4VzCSZYRZWcgTAeGkdEnNmeLhISz4ZQ3dMK2JRA+QVT
	 VAdoxtZ5Ly6gA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/26] io_uring: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:08 +0100
Message-ID: <20241124-work-cred-v1-22-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=brauner@kernel.org; h=from:subject:message-id; bh=zrNjxsAjCHPuNaCLSpJvKnvN3m8hTYHZar8IMmrrZ2o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y5cJX/+QvW8vq7f3e8T1L787PCUtTpjevvw69mRK XILG9/d6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhITRgjw2Wzm9OZrFK737K3 2TlOiArnPnm06foRXpu/8hsOeoYrfmH4p8q1bk83i8SBBa9WXr374PNGUdYkz0dP2J10DatX/+X rZwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

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


