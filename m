Return-Path: <linux-fsdevel+bounces-69536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D2C7E3CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F30E134A036
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38B29A33E;
	Sun, 23 Nov 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcIt7NJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF922FDFF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915645; cv=none; b=iuU5zvBc+eeOrJQPHM3myX8qSsh5eRggF1DZ6N+F753m4KyWbtctccE33vpNjA219cMo3XHaGZausGVJRMN6zGLKfWK/lBJixkm+KO/pwWya21xp270X2pRb8igGShJukcOeVnN8yNg9ygtCjyVenG5xJVsTXFIjFdDAwM3TkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915645; c=relaxed/simple;
	bh=bspYuFuvl4EVp5gfqVVwoR9eZ27yQA6WPD4313ZtTFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLBKsHv45zR+Z/DnELbOl3clnmDAS9iO7QLpw2BS9/syka6PuL4L6HJt0Aw737fVNmpmcrDw03qa2cfSr0MfG74wrSIQ+j9BTHhcCulFujyy0GAVlefVVtgrc10zoqlcJhDFMGnzuvN7+d8o0UAsSG8ZS7aJl3IM3ak48AR1U8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcIt7NJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349D3C113D0;
	Sun, 23 Nov 2025 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915645;
	bh=bspYuFuvl4EVp5gfqVVwoR9eZ27yQA6WPD4313ZtTFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YcIt7NJgVFV+zE4PqluW+lBPyKu7BZNmj0qIcDuIQ14gKaEug1dY9LOEDr6XFJFL9
	 s5JkQhs4tpP9Dt8Uv03sY2yOCgWjtpMi5vH7rKlKwLGh4PO4Q4CkEdAHYLwwp/cW/1
	 142aK6pz6gmmxFdf+0BoOUnFd8YZFV94URqAs1SLi6oTEAz3n1X1/Tdmk2j79ASCf+
	 YOeIv5cQW6ZHJXnteTONghYbJGMfAdDtw53fLk4KoT/y21QiyQLuAk67iHNP8ey2re
	 p0n+jzGRnvVAhqwzfqe0B4nHdHafeAXAioA4ufat/1pS1iI0OAVvoj/tmJUbZ3tDX5
	 BPZRWzxI4JHRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:32 +0100
Subject: [PATCH v4 14/47] signalfd: convert do_signalfd4() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-14-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bspYuFuvl4EVp5gfqVVwoR9eZ27yQA6WPD4313ZtTFw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c+lfrey1r2k+WNaOujezVhS2Pbv8/P26mx/Y7BU
 gaH8CjxjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcrWb47+x4x9bu2OkN5zIr
 QtxE/XoEz4XdeLjiE3NNk2Qdx76bbgz/S/oNvl07E62X+PBJR/hF9fUJpf/ZO35EeAgEa/0/6d7
 LBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/signalfd.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index d469782f97f4..d69eab584bc6 100644
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
@@ -263,7 +261,8 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	signotset(mask);
 
 	if (ufd == -1) {
-		struct file *file;
+		int fd;
+		struct signalfd_ctx *ctx __free(kfree) = NULL;
 
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
@@ -271,22 +270,16 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 
 		ctx->sigmask = *mask;
 
-		ufd = get_unused_fd_flags(flags & O_CLOEXEC);
-		if (ufd < 0) {
-			kfree(ctx);
-			return ufd;
-		}
-
-		file = anon_inode_getfile_fmode("[signalfd]", &signalfd_fops,
-					ctx, O_RDWR | (flags & O_NONBLOCK),
-					FMODE_NOWAIT);
-		if (IS_ERR(file)) {
-			put_unused_fd(ufd);
-			kfree(ctx);
-			return PTR_ERR(file);
-		}
-		fd_install(ufd, file);
+		fd = FD_ADD(flags & O_CLOEXEC,
+			    anon_inode_getfile_fmode(
+				    "[signalfd]", &signalfd_fops, ctx,
+				    O_RDWR | (flags & O_NONBLOCK), FMODE_NOWAIT));
+		if (fd >= 0)
+			retain_and_null_ptr(ctx);
+		return fd;
 	} else {
+		struct signalfd_ctx *ctx;
+
 		CLASS(fd, f)(ufd);
 		if (fd_empty(f))
 			return -EBADF;

-- 
2.47.3


