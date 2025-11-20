Return-Path: <linux-fsdevel+bounces-69326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42635C76870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0B8E12B2B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104A33373D;
	Thu, 20 Nov 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lle70Ohs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BE2FB09A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678032; cv=none; b=nKHvqvRKB5zD7GSmYW4tB1ylSZt/KUfVXdQKexmKx7WKhJtZIq0Cx5P1pshH9862XQPD8CEn3rwYnMHbJ3UMYCD8+LwX2FieQ+M//nW6Ge5hp6wKZMl+tZHIP8l3xIIjfaGsat8LZitH5DNa6EvAEPQHZnP/g6ciGcEBeKVT7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678032; c=relaxed/simple;
	bh=NwimdXCZcXjpJsQsJrK1ua/m3Br4wF/poAIpiqFFL08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaT0wf2v8cQvcda2Oybe7IGRdSOqytbCIiJQfLUVStwkRW2N3bMworO66N4IVB6pA/BM8eFI0jZMKtab8C35ambsr2oJ5v3p7KsMi30Z7ZnG9t1PkGmozfA4QnIcn8LMkFVBjIuHLMblsD581tANgk5flCk2znfv9ogMqWGKalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lle70Ohs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A9C113D0;
	Thu, 20 Nov 2025 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678032;
	bh=NwimdXCZcXjpJsQsJrK1ua/m3Br4wF/poAIpiqFFL08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lle70OhsvvIyzcA5EiW0tkEEV8JS9kKY6y6gpbJ/c+ia+B5/YZSVe8Zx5g895KYdA
	 rUJfA/kJAGYlXzrCwJOZqEmV55BI7CoWWpp1ayA6jbCodEO/Zbbw+KKIS7zgMEGdcY
	 Vxx6mz1gxsx12FQPWS3U1WvOkA8h43xny7Xfl4/jdiz5EK1dDc4mXt4FabakzpO/CR
	 NNfnSoWRo/ivXPU0MZK6ypsDHDbILc01U/58KU1UrDEyXIkEnF0BVFi9s/WSYTjzEO
	 GCcGpSIG+PuXEViXns0Pj6NCsb6FnE8Y0q3hywugzQZM1wA9gSPBQpIsu5L5okUAY7
	 FGldSL+h2kzBg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:43 +0100
Subject: [PATCH RFC v2 46/48] io_uring: convert io_create_mock_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-46-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NwimdXCZcXjpJsQsJrK1ua/m3Br4wF/poAIpiqFFL08=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3t/c/mD9YrN2gFrTorXMDUFmEuEi8xlP3rFJuQ25
 9pfztuvdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE6zIjw9Nr6cfCvC+/Zzic
 0Ouqp7BRNnzVyUj/Q7oOogt1un5/6mD47/DnzGK7Nb05Jx+tXVW8pWCVuyH7639bos7d1/vpfeP
 pVVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/mock_file.c | 53 +++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/io_uring/mock_file.c b/io_uring/mock_file.c
index 45d3735b2708..f3d2823824d9 100644
--- a/io_uring/mock_file.c
+++ b/io_uring/mock_file.c
@@ -211,10 +211,8 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	const struct file_operations *fops = &io_mock_fops;
 	const struct io_uring_sqe *sqe = cmd->sqe;
 	struct io_uring_mock_create mc, __user *uarg;
-	struct io_mock_file *mf = NULL;
-	struct file *file = NULL;
+	struct io_mock_file *mf __free(kfree) = NULL;
 	size_t uarg_size;
-	int fd = -1, ret;
 
 	/*
 	 * It's a testing only driver that allows exercising edge cases
@@ -246,10 +244,6 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	if (!mf)
 		return -ENOMEM;
 
-	ret = fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		goto fail;
-
 	init_waitqueue_head(&mf->poll_wq);
 	mf->size = mc.file_size;
 	mf->rw_delay_ns = mc.rw_delay_ns;
@@ -258,33 +252,28 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 		mf->pollable = true;
 	}
 
-	file = anon_inode_create_getfile("[io_uring_mock]", fops,
-					 mf, O_RDWR | O_CLOEXEC, NULL);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto fail;
-	}
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_create_getfile("[io_uring_mock]", fops,
+					     mf, O_RDWR | O_CLOEXEC, NULL)) {
+		struct file *file;
 
-	file->f_mode |= FMODE_READ | FMODE_CAN_READ |
-			FMODE_WRITE | FMODE_CAN_WRITE |
-			FMODE_LSEEK;
-	if (mc.flags & IORING_MOCK_CREATE_F_SUPPORT_NOWAIT)
-		file->f_mode |= FMODE_NOWAIT;
-
-	mc.out_fd = fd;
-	if (copy_to_user(uarg, &mc, uarg_size)) {
-		fput(file);
-		ret = -EFAULT;
-		goto fail;
-	}
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd_install(fd, file);
-	return 0;
-fail:
-	if (fd >= 0)
-		put_unused_fd(fd);
-	kfree(mf);
-	return ret;
+		file = fd_prepare_file(fdf);
+		file->f_mode |= FMODE_READ | FMODE_CAN_READ |
+				FMODE_WRITE | FMODE_CAN_WRITE |
+				FMODE_LSEEK;
+		if (mc.flags & IORING_MOCK_CREATE_F_SUPPORT_NOWAIT)
+			file->f_mode |= FMODE_NOWAIT;
+
+		mc.out_fd = fd_prepare_fd(fdf);
+		if (copy_to_user(uarg, &mc, uarg_size))
+			return -EFAULT;
+
+		retain_and_null_ptr(mf);
+		return fd_publish(fdf);
+	}
 }
 
 static int io_probe_mock(struct io_uring_cmd *cmd)

-- 
2.47.3


