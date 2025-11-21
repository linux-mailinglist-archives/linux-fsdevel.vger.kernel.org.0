Return-Path: <linux-fsdevel+bounces-69412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33799C7B32E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4358B35E120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC89350A09;
	Fri, 21 Nov 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIgGHDdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73977351FB5
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748081; cv=none; b=sAZbaUDBtpsDOl6fE7q952R+x25Deg00ZAA01eSouKKNbOVO460KwPciUv3j/E0Bni04lBJrKgdc00PmfSD730hchsuXZKU0ZhKcSFq9rf4UyN+hiBu2gmAgw2COFNOwfy0EjVaDZDUCJqRWBxf1PrS3+/Iv2DijEhAvj/8B+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748081; c=relaxed/simple;
	bh=MHILgB4o7Aen0UlYBijwwJN7p7gXp+RqHjtaSnKz+I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+xrj8xm4kpbKSFTroX6sm8oI6BaCUvSXcSSoQk9kcrQwOCy+o2WtJ2q6SHAnLKmSuJVC3UJL9yWMLe4xVluGTJCJWT57PdU57wOkmywk0ijM/uhenV1XOYWBj/H0ejLh2koE+0nV13SqHGW9xw301ponHFiXJpcVctaYLcsQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIgGHDdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F3FC16AAE;
	Fri, 21 Nov 2025 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748081;
	bh=MHILgB4o7Aen0UlYBijwwJN7p7gXp+RqHjtaSnKz+I8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hIgGHDdGq8yGvFSKUjockJXA/Zbo0iRdPjtdmytAf0QPIZWxxQGpqCg6cbhBPNcVz
	 KRJ2nFMbxZRKKOfkRiDD4/36OHGtzUJcttdsOOwYTrE2GVtNIXUxkmp+dSIy6D1i7k
	 RPjWr+ETvST4DU6cUNQhEb0AvW0aqpew+/iwzX2/59EB7oo9BF5lUbxPzH+pUbncOM
	 sXghvYbnrCs21s3S9KMRi5TDCP+jDUld5jBOV1HFnfzR9xoLgaAldn9/SwxFGqicpx
	 BkUlVp+Ajcp01eBu+WyqSeL7+ZonC+E8+pEBsxXxx+wTQPZgGbhAOoYKOZOAAN/fcT
	 lVzAcOnruYuEg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:53 +0100
Subject: [PATCH RFC v3 14/47] signalfd: convert do_signalfd4() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-14-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MHILgB4o7Aen0UlYBijwwJN7p7gXp+RqHjtaSnKz+I8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDiv1ci9ZH97yfRVa73C38l/Wmu/+dO0u6uyzKUnL
 TPe81vWtaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiU+IZGf5obmJbEOk7PdPy
 w9vj8QfX9XjPiGwqfnFv3/XMZru0h1cYGVql8xJL7DSD19TrbdJd+Nshwvnv5gKJSL8T3ywdavR
 kGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/signalfd.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index d469782f97f4..8f1ee3c85f8d 100644
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
+		int err;
+		struct signalfd_ctx *ctx __free(kfree) = NULL;
 
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
@@ -271,22 +270,18 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 
 		ctx->sigmask = *mask;
 
-		ufd = get_unused_fd_flags(flags & O_CLOEXEC);
-		if (ufd < 0) {
-			kfree(ctx);
-			return ufd;
-		}
+		FD_PREPARE(fdf, flags & O_CLOEXEC,
+			   anon_inode_getfile_fmode("[signalfd]", &signalfd_fops, ctx,
+						    O_RDWR | (flags & O_NONBLOCK), FMODE_NOWAIT));
+		err = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (err)
+			return err;
 
-		file = anon_inode_getfile_fmode("[signalfd]", &signalfd_fops,
-					ctx, O_RDWR | (flags & O_NONBLOCK),
-					FMODE_NOWAIT);
-		if (IS_ERR(file)) {
-			put_unused_fd(ufd);
-			kfree(ctx);
-			return PTR_ERR(file);
-		}
-		fd_install(ufd, file);
+		retain_and_null_ptr(ctx);
+		return fd_publish(fdf);
 	} else {
+		struct signalfd_ctx *ctx;
+
 		CLASS(fd, f)(ufd);
 		if (fd_empty(f))
 			return -EBADF;

-- 
2.47.3


