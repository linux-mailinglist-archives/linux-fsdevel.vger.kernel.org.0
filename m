Return-Path: <linux-fsdevel+bounces-69537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39355C7E3C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 580BC4E3131
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A02D7DE2;
	Sun, 23 Nov 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp0Y5dpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DE231A41
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915647; cv=none; b=sUR2txgfCiSvo7XQsdhTtltH5RXqrppH0dP6ujsmKRFR+0k9KBQ0JAl7tET1VF2tLqPQvxfxsju6SfDBPmB6gqY81TevQhm+/v3T5ZPlluG1VsaZcm780TrjfLyk68xcAsADDnJDfLjqSuTaX/WD57cVbwrdMZ8DTaWyssuI3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915647; c=relaxed/simple;
	bh=h+zq7Lm02WHcEC1oIp5yu26UN7SCx901pvesd8Uzw3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4j6dIMEqD/HapGwDtODVhtyIDQqDZjR2e2CGOCwmbQGHFtGQmKw8xa4BpCID+UfFKgq0Rkxq+j+GlsWQDOX2jiG86/h59ecC7zAXrzdH0rn0MDwNKLVGlunZ/kMEow28q/kbX/ZJ+ISTpVzDYxX+JBpQkeGjYxPKEMtsPE38BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp0Y5dpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB1DC16AAE;
	Sun, 23 Nov 2025 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915647;
	bh=h+zq7Lm02WHcEC1oIp5yu26UN7SCx901pvesd8Uzw3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xp0Y5dpVgJ+VcL/+8eaZZrI/C4PerheH9zO4Yxrj/UGHsqny+G197OKJn/BgtyURh
	 3VqWn92ZBoacnk20u5jSHS+6YQHnwzAtwuMHGeqftLwWyqtOveZIMOK5VyjSQSV6ea
	 VBKmUXcAfCBFgV2rOIJ3JD/tGFgI4E/CXd5HgIHfkyiKetw8KfSBIdI/oL0ybA2O+S
	 7KlX7IYGEL1IOyEoavxEJX3q1alH82xSgpFF9HxJpoIKpTz8Cb/paYK/1ZrR5RGeuc
	 7RJoC1GYIliYoiDjhxlBSRqqzzI4a6+mXAlgIx/CjjzbDkkQXUolVVl5Z0BI814p4W
	 oSZWXqOExVvHg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:33 +0100
Subject: [PATCH v4 15/47] timerfd: convert timerfd_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-15-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h+zq7Lm02WHcEC1oIp5yu26UN7SCx901pvesd8Uzw3g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0febDJ/537Na9PKg88jFAN7OkMmx4ex3ouRcblg+
 tNhq+3/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0ujH8j/p20E/2oubvn+Zq
 avub5FYLpq5rDJt7Ouv5G59ORm5RV0aGAxZPGP2/LjR486HSbY7UqY9rb15jyD665M/F5G6uM2u
 1WQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/timerfd.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index c68f28d9c426..9fcea7860ddf 100644
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
@@ -432,23 +431,13 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
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
-
-	fd_install(ufd, file);
-	return ufd;
+	ret = FD_ADD(flags & TFD_SHARED_FCNTL_FLAGS,
+		     anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
+					      O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
+					      FMODE_NOWAIT));
+	if (ret >= 0)
+		retain_and_null_ptr(ctx);
+	return ret;
 }
 
 static int do_timerfd_settime(int ufd, int flags, 

-- 
2.47.3


