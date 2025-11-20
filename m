Return-Path: <linux-fsdevel+bounces-69294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E8C76831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 55D6A2F252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76429314B69;
	Thu, 20 Nov 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8M9viF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99942EFD86
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677968; cv=none; b=ffwCt1miUnlisg0Llp3pyItyivoRrq0ujMgEpNeh4hxdC+VZomAwiUynpyUsEUKr1pynjVIAh9xrcsxEnDDxT3wQ2GVQdWpi4Maoea6IxA6r0kkJwp4KxZ/nFlWe5wEenmZDFrqJbS1ErhTkL3L/NmIT2OY5wukBicsop9VkJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677968; c=relaxed/simple;
	bh=h7fxisE986SV0BFUJHKFzztT8udVQ5ENDQJlCU652jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHRXNQzV8Ce97+yXaMCneq1scOU11whM4b9SJjyub98JvBpyHA/m24XrWDlqY6KsFlm/E8kDlYI1YhplDeCEge5zkFUvFAR7Pdz1Q1DEoP1V5DYtpE0nMoNZmXMeftWQVLDBrQt2E3ob7mKH5LrnbU2/c5OdqXQer/DjWbL2/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8M9viF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA4EC19423;
	Thu, 20 Nov 2025 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677968;
	bh=h7fxisE986SV0BFUJHKFzztT8udVQ5ENDQJlCU652jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c8M9viF80mbX1rZm19kxEKothfZdgOgTz3ADopga7tmkMcqI9Zh6KYMfrE0k3Vq3n
	 Nw+DhPX4jnGjBkVAyvcuVR8lr3mQcAFM8bohQGdRQNfUxseyBanGYrP613IqgpA6YE
	 ARNAsUedms0UamHs/FpVbV+i517+82ZuAZMPNnhopxLqu0dY+dEK6WH81X353NIAg4
	 MwesABlb6xyELlyvMCgK3tsBDlWapGknIyCEbSSLSuxZUGm7jJYvIhaALKgm/v5qmf
	 JL+sZDlsJmZigEZlG3A3go7Vn00durLeiDoOmAujtbJ22edRPQaWIY8NwPA0DW9lMF
	 tK3HEh31mfI+g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:12 +0100
Subject: [PATCH RFC v2 15/48] timerfd: convert timerfd_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-15-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h7fxisE986SV0BFUJHKFzztT8udVQ5ENDQJlCU652jQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vTtH3rnK8FPub7nqtO2fl/zZV5klEHhTd3G8rnC
 usfyEnJ7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIzF6Gv5JnRHtTL2yTVfP7
 Xzgt7NWK1ZefcjevP5mxJbaMx2Lu23MMf6WYXWoSMs5NnfJso+HWsylXb6zp4J7u9uP86ux2HZY
 JJiwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/timerfd.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index c68f28d9c426..58424e54a51a 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -393,9 +393,7 @@ static const struct file_operations timerfd_fops = {
 
 SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
-	int ufd;
-	struct timerfd_ctx *ctx;
-	struct file *file;
+	struct timerfd_ctx *ctx __free(kfree) = NULL;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -432,23 +430,16 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
 	ctx->moffs = ktime_mono_to_real(0);
 
-	ufd = get_unused_fd_flags(flags & TFD_SHARED_FCNTL_FLAGS);
-	if (ufd < 0) {
-		kfree(ctx);
-		return ufd;
-	}
+	FD_PREPARE(fdf, flags & TFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
+					    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
+					    FMODE_NOWAIT)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	file = anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
-			    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
-			    FMODE_NOWAIT);
-	if (IS_ERR(file)) {
-		put_unused_fd(ufd);
-		kfree(ctx);
-		return PTR_ERR(file);
+		retain_and_null_ptr(ctx);
+		return fd_publish(fdf);
 	}
-
-	fd_install(ufd, file);
-	return ufd;
 }
 
 static int do_timerfd_settime(int ufd, int flags, 

-- 
2.47.3


