Return-Path: <linux-fsdevel+bounces-68974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692CC6A70E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43F423630DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74236998E;
	Tue, 18 Nov 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwCfkqu0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC9369990
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481008; cv=none; b=P3HsqvyI2iA/y5kkQSbyZBl1duR95AxMVcxLxJa/OlY0QBWvrw/6/TR7hydxgA3Oep+ZAENS3tWKMF6le9Bih9p8BtA40rqFY4BlzF0900RoOIMNh0LxNaZPOTJr2MZ81fWkRr2Vck98FpgCFjo9RTREZGtVInrEtigTOlCiI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481008; c=relaxed/simple;
	bh=YEqrx8szKXwPFtnAIVa7V3oMoLR+Hbrueaiqf5h9KQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyLZLlOWkVP6LywXnyoaxMcCYaiEAHv3QoYluwH1wymklS3vnHpFXpSvNRbn6G6PjVlGr+/rWA6anPt3SWHMx1Om2G6flRznRzEZO//L85/UK4Zlue2YrwGr46mNcJYpSdLycBNyh2ytY2vAWFvIRwileB0XjVB4FF0Lf9pfF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwCfkqu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C2C19424;
	Tue, 18 Nov 2025 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481007;
	bh=YEqrx8szKXwPFtnAIVa7V3oMoLR+Hbrueaiqf5h9KQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwCfkqu0zJAUKTDFsyOrtNJdmuffAmcanEWJTjC0BGr/ITsTZz/WJr/ACSHa6yOag
	 bhNKc7EBe7V8S/UUr//9HJe/ecybfPq6JrDBACpm2JvmRxBQai3hYQrGnpht9RC2Ic
	 Dbsok4gyN4CQkSNFY5QcVWkux7l1oMPEgaKFWLf0oRDA6654e9hftvqQCHz3qLeGOk
	 ouRrMTFDtlmrK/XQN83Ia9Qo7aNtgOAE2r4NgKRm5TP6qlketHjKKJ3e4gJBDHqzsm
	 n0i9+whyw+BN8JB6WjYTwwQrbt0hOUbPDBBBk/J+RhBIt3N0ilLtyBlaO73nvHp05p
	 3UMrFsV9e4ZYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:55 +0100
Subject: [PATCH DRAFT RFC UNTESTED 15/18] fs: timerfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-15-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YEqrx8szKXwPFtnAIVa7V3oMoLR+Hbrueaiqf5h9KQM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO0P5ndZ287w7re193GTXLNDN57PLal5WvpBL9CA7
 23ZntdTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZycAPDP4uTt2viprnyfGG3
 OdG553ZOlOKlVxk2N7YaLH72Ver5xnsM/9S65x+/ft2H6fjvyUtdPMUv8kaapOcKW+xtsNGzfeN
 /mRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/timerfd.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index c68f28d9c426..acaad0a086b1 100644
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
@@ -432,23 +430,15 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
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
+	FD_PREPARE(fdprep, flags & TFD_SHARED_FCNTL_FLAGS,
+		   anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
+					    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
+					    FMODE_NOWAIT));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-	fd_install(ufd, file);
-	return ufd;
+	retain_and_null_ptr(ctx);
+	return fd_publish(fdprep);
 }
 
 static int do_timerfd_settime(int ufd, int flags, 

-- 
2.47.3


