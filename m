Return-Path: <linux-fsdevel+bounces-69443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F63C7B36D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF9F834E1DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30935471A;
	Fri, 21 Nov 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Xq275G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0873546E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748147; cv=none; b=OmVMBohaRfWR+qmQfdnTlNU21nEm8n+yi1PTmY+I4VtHlYw2gjj8scYQOb1GzqtFY7zbtgEkWTuNTjBm81/kEg+OTh3ax6+SkDwU3PD7YxTS8QO+i+zcC8O58fGzaVtTj4lIAXMzp5K/xmzDMPIXr67TQBuAm2W+zcSPf8z8bVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748147; c=relaxed/simple;
	bh=f/xV9U1QFKUv7ZXYA7inFGXBaekcbdaOfpgx1vP3m7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0LzHk5FvHIu9WNtGRV6hwnJMocKn2ubw2v8GO1ZUe99WO1J2Fj0Sqx+f4Ook10NoIqjo5OTE/J0uXwODtV9kbIvhVg/PXBkf/tnPg5HpFFVjIft0GsoMCJrJsImDhIadVVAa3qPCFT+EC50Fp84ZruNTjph+GXrrO9dNeAueZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Xq275G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3187C116C6;
	Fri, 21 Nov 2025 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748146;
	bh=f/xV9U1QFKUv7ZXYA7inFGXBaekcbdaOfpgx1vP3m7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V6Xq275GrzBCET5lh+Yw4JM1lkBg9ni872x/gaaDgnrKZeUhi8CLbUFnmaPsl/eNN
	 GHrj6VILeuOcUGK2lXAks5qoXe89pQaNQEnu/gbkhOAFCsXT1KVMWxlKc2QK3+UQXP
	 lM7muivspckPeRlxIlkb/m5BU+fE2EnYpFfxjKHY2g8JqMbQnB7Tc+flH96WbGVxVr
	 4SwAA2Mr1RwdjWhhqG2BqdhcQQDVYFREJRlBjX9SeuAlaVV/zLgPGCN6Qq5Gv7IU4j
	 cqzZQKc0g2gdBHedN8WU7o47655mlxDNHAOT9TXnyHec7gyeWsAlkYfar6Qqrp85rd
	 J35tiPliVsh+A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:24 +0100
Subject: [PATCH RFC v3 45/47] io_uring: convert io_create_mock_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-45-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f/xV9U1QFKUv7ZXYA7inFGXBaekcbdaOfpgx1vP3m7w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLhotGD+kQd/Si98nhNfcmbh5zvMIoZpS4+/dsxxO
 Jh/Xz/euKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiTKkM/yNv89Xear+ZeqL0
 5M6za4sjbh83uc1wpHP+oc3O1Y3/y34zMuwLyDT5tFbJtjRX3eaDyRzBptl/HtVujklcqhsm3PF
 mIwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/mock_file.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/io_uring/mock_file.c b/io_uring/mock_file.c
index 45d3735b2708..5200a3ed0735 100644
--- a/io_uring/mock_file.c
+++ b/io_uring/mock_file.c
@@ -211,10 +211,10 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	const struct file_operations *fops = &io_mock_fops;
 	const struct io_uring_sqe *sqe = cmd->sqe;
 	struct io_uring_mock_create mc, __user *uarg;
-	struct io_mock_file *mf = NULL;
-	struct file *file = NULL;
+	struct file *file;
+	struct io_mock_file *mf __free(kfree) = NULL;
 	size_t uarg_size;
-	int fd = -1, ret;
+	int ret;
 
 	/*
 	 * It's a testing only driver that allows exercising edge cases
@@ -246,10 +246,6 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	if (!mf)
 		return -ENOMEM;
 
-	ret = fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		goto fail;
-
 	init_waitqueue_head(&mf->poll_wq);
 	mf->size = mc.file_size;
 	mf->rw_delay_ns = mc.rw_delay_ns;
@@ -258,33 +254,25 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 		mf->pollable = true;
 	}
 
-	file = anon_inode_create_getfile("[io_uring_mock]", fops,
-					 mf, O_RDWR | O_CLOEXEC, NULL);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto fail;
-	}
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_create_getfile("[io_uring_mock]", fops, mf,
+					     O_RDWR | O_CLOEXEC, NULL));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
-	file->f_mode |= FMODE_READ | FMODE_CAN_READ |
-			FMODE_WRITE | FMODE_CAN_WRITE |
-			FMODE_LSEEK;
+	file = fd_prepare_file(fdf);
+	file->f_mode |= FMODE_READ | FMODE_CAN_READ | FMODE_WRITE |
+			FMODE_CAN_WRITE | FMODE_LSEEK;
 	if (mc.flags & IORING_MOCK_CREATE_F_SUPPORT_NOWAIT)
 		file->f_mode |= FMODE_NOWAIT;
 
-	mc.out_fd = fd;
-	if (copy_to_user(uarg, &mc, uarg_size)) {
-		fput(file);
-		ret = -EFAULT;
-		goto fail;
-	}
+	mc.out_fd = fd_prepare_fd(fdf);
+	if (copy_to_user(uarg, &mc, uarg_size))
+		return -EFAULT;
 
-	fd_install(fd, file);
-	return 0;
-fail:
-	if (fd >= 0)
-		put_unused_fd(fd);
-	kfree(mf);
-	return ret;
+	retain_and_null_ptr(mf);
+	return fd_publish(fdf);
 }
 
 static int io_probe_mock(struct io_uring_cmd *cmd)

-- 
2.47.3


