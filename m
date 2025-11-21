Return-Path: <linux-fsdevel+bounces-69413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC9C7B331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C77BD360690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE934F248;
	Fri, 21 Nov 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do7tLp5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442A34EEE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748083; cv=none; b=J4P/H1MODWPHV/zEBhM5BiH4o7LV+EaHTeJJDIIS1dxDJOppLgK3qdbiMLwN7rOyfnqFvmGP/74ZRWfcefgDimfcOPeXpz8g83ZlKdZ1lXu8IN1Ay4Iv1sXnAucR7NIncT0gjAM+S508pH2yTve2xKsKpUkdNLUCgvgxqTgV2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748083; c=relaxed/simple;
	bh=w+NeU71+lrf66/e5n9RfiZ5xmaRhBBpuc9WW6IBRFig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVBkp1N2Y6yxoaVMIjWmqvLvCSaFM7UgVbWM4vntMQ+iyQ22Z2EztkDi0nxkVhhyGRRjMZ288dq/gBr0Isf0RaZOiAsuDpGVvP6O/IpOK6OOqNF6e9szcs6R1FqKqPQcpzCGsX7yP1CcLKjY2OM6XBHRi1VRz4jtbRvPvKIimm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do7tLp5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D8DC4CEF1;
	Fri, 21 Nov 2025 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748083;
	bh=w+NeU71+lrf66/e5n9RfiZ5xmaRhBBpuc9WW6IBRFig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=do7tLp5yWnl77mU2eLXkS/2aV5SE3f0sEdGW/IOQ++yhb98lM2WegnLyqtiC7qImL
	 +pF+8kBgcAMrBxYqbZMUcWNXsYx6yYgx8AJxKadhhIu7YWvD6eIbxRgUD0CpXdhlu3
	 EhJ1iwX6o3jj6AqyimicE+AP6oi+KbVAIz35R8MPOCEISPa979u0RfneOnmvWsMmiW
	 AGk5HpmZQZ/uln848Ei9Gp0AsIBAqYXRgoTsXqbKPQyBlwo1N8NotoJw/hPeEdjvPe
	 AbIn/Db0NVTL82Tv5UbzLPpIJVlPgqujRU33pLKGxi5G6p/ULN0wHnFTLTAfl30Koj
	 Hcc5W5RXUfTYw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:54 +0100
Subject: [PATCH RFC v3 15/47] timerfd: convert timerfd_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-15-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w+NeU71+lrf66/e5n9RfiZ5xmaRhBBpuc9WW6IBRFig=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDh/fmL+x/TFNx1vHLB/5nnc/pL3HYk5i6dm9eX8u
 xL/Ob0xt6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAif3QZ/tdJL15pxdTpEmbR
 w3nyTeHqE6k/8hLdNyf9unC55mPpjCUM/1Sn/rveq/TIr7Cv8O+5PY4pv1faFHxy85pqrsce81o
 ymQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/timerfd.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index c68f28d9c426..2ae31663cc63 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -393,9 +393,8 @@ static const struct file_operations timerfd_fops = {
 
 SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
-	int ufd;
-	struct timerfd_ctx *ctx;
-	struct file *file;
+	struct timerfd_ctx *ctx __free(kfree) = NULL;
+	int ret;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -432,23 +431,16 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
 	ctx->moffs = ktime_mono_to_real(0);
 
-	ufd = get_unused_fd_flags(flags & TFD_SHARED_FCNTL_FLAGS);
-	if (ufd < 0) {
-		kfree(ctx);
-		return ufd;
-	}
-
-	file = anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
-			    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
-			    FMODE_NOWAIT);
-	if (IS_ERR(file)) {
-		put_unused_fd(ufd);
-		kfree(ctx);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, flags & TFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
+					    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
+					    FMODE_NOWAIT));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
-	fd_install(ufd, file);
-	return ufd;
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdf);
 }
 
 static int do_timerfd_settime(int ufd, int flags, 

-- 
2.47.3


