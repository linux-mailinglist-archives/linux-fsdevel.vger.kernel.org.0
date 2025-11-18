Return-Path: <linux-fsdevel+bounces-68973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68337C6A704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A363C3626DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F436999D;
	Tue, 18 Nov 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saVDCpLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1693002B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481007; cv=none; b=mJyh3hHFEmtZvfKKyWsvw/a/xwjBLJGMn+O+slaeEzAc661hVKUqqaxauGU5u4Yg6jP4MvEjQBwWgPg3MZTdUCS6u+uCx/j7lLeqWL/bpvOd7uGo0PJdnBFwaXWoObOUjmcskRRkKldrF5yZcFQsmQcP6RhE33hmRRINZncEs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481007; c=relaxed/simple;
	bh=6SvvODGgVYpym1A0YSQ5AKcKJgakkNCty92YHK2ZaPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZlpwigpf+aOj6/3sCTxr4heZtLB8wkvRvXxsrXb0zfh/8gnaKTjpH3rrzLMOHXbeyEulm1Hlv6nc6v+gnHXtnbw0qgO/aSKKghpmzb5jKgyQL/fk5xVFNe/C+Zh6LTB8R7iKej3iFM1LIO2RUMNiiQLcRt1bdQybhcmKBe7ba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saVDCpLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C03BC4AF13;
	Tue, 18 Nov 2025 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481005;
	bh=6SvvODGgVYpym1A0YSQ5AKcKJgakkNCty92YHK2ZaPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=saVDCpLg8KgVRKx36sSsB9eBoJF3eKXYkfqG2HuO7GHdVGymU9ST4735kU9r+NYwP
	 vRNfrWK+sgdjdSBtBke0hB3YROQX7Mn4JsyfnIPjO5Bse6kfiSMuKWm+3o0WwboJSE
	 E1vwYMYMhcIBtGu8RVhqHHFqzzp4j2kfg8vORhZ4/sZwi1SdciGPGQ6GWH8n3X4nat
	 MUspcROFfiAzfVjR3pFWGCxSBEg5I5CiQtE/ELaTLLG8VEAsDk4SxN+rQnrccbr5Wr
	 Ld7rcCMUsFxnhYJ97esdFCP4Q3q6ThA9OlNKbmNA5ZqM7EE0qUM/LdR7iwHiPvdciB
	 LOGoZ59opGUvg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:54 +0100
Subject: [PATCH DRAFT RFC UNTESTED 14/18] fs: signalfd64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-14-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6SvvODGgVYpym1A0YSQ5AKcKJgakkNCty92YHK2ZaPk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO2/ZiNyR1vuUNYxm8M3KlsXve83jIy0nmT2jUPrY
 FKDX/TWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0+jMyfH/xcqEj69M/ucXs
 OVaz8zx3BCpw3lSbfrBprmOUbpOWIiPD/zbHrD1nt+tNlLiqed9MobDhw17n7KUXEngO7z1Ss3U
 zNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/signalfd.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index d469782f97f4..45ba6000e9a9 100644
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
+		FD_PREPARE(fdprep, flags & O_CLOEXEC,
+			   anon_inode_getfile_fmode("[signalfd]", &signalfd_fops, ctx,
+						    O_RDWR | (flags & O_NONBLOCK),
+				   		    FMODE_NOWAIT));
+		if (fd_prepare_failed(fdprep))
+			return fd_prepare_error(fdprep);
 
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
+		return fd_publish(fdprep);
 	} else {
+		struct signalfd_ctx *ctx;
+
 		CLASS(fd, f)(ufd);
 		if (fd_empty(f))
 			return -EBADF;

-- 
2.47.3


