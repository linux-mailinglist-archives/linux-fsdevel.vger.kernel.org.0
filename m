Return-Path: <linux-fsdevel+bounces-69293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C27C76829
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C1FE34E4B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351130DEDD;
	Thu, 20 Nov 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4VHGVFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AA2AF1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677966; cv=none; b=J/arc92bi644keMBwmNfaPZ8quWdijxizUUSNi1MDNBLuiHIMXLnfm2NZUwlCbImUZw43vasEeuSjP7MExROgf3vA+1foi+ITO18uvtKsrXDUEaCZPjQac74rHcplE1E5mF1cH80iz9UfipkN4NuWMxRcfztv5en98SqlJ91W2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677966; c=relaxed/simple;
	bh=sO+C0Ko2ZL8ULcwW0zkLDSwWSMR3tfiC0W9Y5Af7fFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+64vHoay3rTW+tgMuugvjYULVgXYIS95i+PvvNm0zEWRsN9Bw8Qhi9y0+TkLatzKB2V/payxeg7G5Ps5UajN+ur2HBOCNj1ZU9PbtAtOaFhF2kkroAV4jVvPfOvIFPlGI11gevh4lZESNi8+O96RYfq8ljmKO1953O/BrpLSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4VHGVFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A7CC113D0;
	Thu, 20 Nov 2025 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677966;
	bh=sO+C0Ko2ZL8ULcwW0zkLDSwWSMR3tfiC0W9Y5Af7fFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4VHGVFzfbAd6VNiIIeIwTr4rQJHj/C4i3Op0DyzU+W9KKyrpaPio+oFp5X9fniiO
	 Br1eOY3BMXGE34l0TXxbS9dCoo+R2PRriM983L0jfynJj1oudmgcVnXPdYMeMG+ZXu
	 HMKQmZIwqTsVmubikGS83CfYkcTqEx39snoPKNkOIDi6Knk8H1S0aAZtCXGXvORCqc
	 LVV5XlqTkv53URRYTzgNBZDwIoLgfUe+J8HfJGYVpZWgS00GdnUj/lllFlm4wGQZc8
	 hAOz0Y102JAC0AFHO91Q/k9FjGkjap3eIalYcDBX0RJ2W+UztiQ73A/Xom0XBXHAMM
	 UvZDPBCULXotw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:11 +0100
Subject: [PATCH RFC v2 14/48] signalfd: convert do_signalfd4() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-14-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sO+C0Ko2ZL8ULcwW0zkLDSwWSMR3tfiC0W9Y5Af7fFI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3sz5W3R1PuJuZL37NhVlBlaT9kKGUQl/Vo/hZn5G
 dvFzNhTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5u4+RYa1y+pHzWvx5uzRN
 BJb3b7krsJDzzoMYj/vSptFvG74xb2dk+K+4ZfOZwlVVfPP/OtY/WWL7yrpi3cUr+SVtfi9NmLW
 UWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/signalfd.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index d469782f97f4..1ff1cd99e5a4 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -250,8 +250,6 @@ static const struct file_operations signalfd_fops = {
 
 static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 {
-	struct signalfd_ctx *ctx;
-
 	/* Check the SFD_* constants for consistency.  */
 	BUILD_BUG_ON(SFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(SFD_NONBLOCK != O_NONBLOCK);
@@ -263,7 +261,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	signotset(mask);
 
 	if (ufd == -1) {
-		struct file *file;
+		struct signalfd_ctx *ctx __free(kfree) = NULL;
 
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
@@ -271,22 +269,18 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 
 		ctx->sigmask = *mask;
 
-		ufd = get_unused_fd_flags(flags & O_CLOEXEC);
-		if (ufd < 0) {
-			kfree(ctx);
-			return ufd;
-		}
+		FD_PREPARE(fdf, flags & O_CLOEXEC,
+			   anon_inode_getfile_fmode("[signalfd]", &signalfd_fops, ctx,
+						    O_RDWR | (flags & O_NONBLOCK), FMODE_NOWAIT)) {
+			if (fd_prepare_failed(fdf))
+				return fd_prepare_error(fdf);
 
-		file = anon_inode_getfile_fmode("[signalfd]", &signalfd_fops,
-					ctx, O_RDWR | (flags & O_NONBLOCK),
-					FMODE_NOWAIT);
-		if (IS_ERR(file)) {
-			put_unused_fd(ufd);
-			kfree(ctx);
-			return PTR_ERR(file);
+			retain_and_null_ptr(ctx);
+			return fd_publish(fdf);
 		}
-		fd_install(ufd, file);
 	} else {
+		struct signalfd_ctx *ctx;
+
 		CLASS(fd, f)(ufd);
 		if (fd_empty(f))
 			return -EBADF;

-- 
2.47.3


