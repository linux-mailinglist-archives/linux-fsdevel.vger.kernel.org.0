Return-Path: <linux-fsdevel+bounces-69548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F2C7E3DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062DD4E1BEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596F2D97BF;
	Sun, 23 Nov 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHbt3Yv1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CA2192EA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915671; cv=none; b=Y18sdT05jnfKwRBKU1NRWVx1daPhbj8QuEeWsPmaT5FGz0yRLAZVBTKkSyI4ZaVvTx82ojzdhEoA7VuT1YwTqTg4kxN0nnhnAmAex9KtlNtuayXotTmrVC/dAugb5bp7oYoKC7B3V2Kp58NX7H9DuKvEQKhom/Efr/IZii2nBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915671; c=relaxed/simple;
	bh=piNSnUBKA8ymHPvROrsae51X6yVFzAIHQHj0fGLw/7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTR+h9vFUaYb+nXt7kC1PqkKpfgaVuTyNTBHquuv3iC6Dxn4h0rt4hbYxUz5e5//BVQGypCp7zOkFMo/nM28BOrr46ykt/1/3iQVxgTqNaVFGBoZh7nQs+M/c5HMdiPxtX5nY8BlsMN5zoDRL2QTtp6o59QPQl0rdoZu83PdkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHbt3Yv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2283C116D0;
	Sun, 23 Nov 2025 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915671;
	bh=piNSnUBKA8ymHPvROrsae51X6yVFzAIHQHj0fGLw/7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VHbt3Yv1zoisswavx80OV2Z6tVI1aHbxrj0ORqbWbcnBQ2+XHp2Ze/Mxn9GD0j1BC
	 baFcxV0MUip5TyWFrUqXFw//lx6Ru2TD4x3/wwXoH9T/CKm+DpH0FcgAitNcGj8zXV
	 lUDD7q3HEJ6hyyhPeasnP1cYH28bdVFWCSxRkYuFB0xtKKot3kI5E/8etDfCWdcgS9
	 RRVTcR5CxIFSblRgz1ntXyer77XpWDerPG6U4Gd7FZHhmyDMqmaebES2DmZFGvVoKv
	 2iAeML9t4N7KIRh4OhG4lhfnu6ayU30DRzL3nXrAjSUIBrwLGWgfEYDfpr3jgs3V64
	 D8k2QEhSf7muw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:44 +0100
Subject: [PATCH v4 26/47] secretmem: convert memfd_secret() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-26-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=brauner@kernel.org;
 h=from:subject:message-id; bh=piNSnUBKA8ymHPvROrsae51X6yVFzAIHQHj0fGLw/7s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c92rLyTu23F6f3WD28/cP6z0LXGWamEY8CD7rf/
 txfvDW8s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAieycwMsxKj7n0Wkrt1IPe
 eU4pD2+yCHeKbWRIqS6ZJfMrRFp09lZGhtYNzeu/Lz+2oHCpUeHfL4d2fH/6XX2nyMv3uyQFO16
 mhjECAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/secretmem.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..eb950f8193c9 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -224,9 +224,6 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 {
-	struct file *file;
-	int fd, err;
-
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
@@ -238,22 +235,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	if (atomic_read(&secretmem_users) < 0)
 		return -ENFILE;
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	file = secretmem_file_create(flags);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_put_fd;
-	}
-
-	fd_install(fd, file);
-	return fd;
-
-err_put_fd:
-	put_unused_fd(fd);
-	return err;
+	return FD_ADD(flags & O_CLOEXEC, secretmem_file_create(flags));
 }
 
 static int secretmem_init_fs_context(struct fs_context *fc)

-- 
2.47.3


