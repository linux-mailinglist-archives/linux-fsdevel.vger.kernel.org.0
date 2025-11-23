Return-Path: <linux-fsdevel+bounces-69567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC57C7E417
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6A3A5C7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6532D97BD;
	Sun, 23 Nov 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2LMhf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE52D4B6D
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915713; cv=none; b=h4TaYvueytlfVj+IdBAm4W/mzNuVvJXBbQVdaIjSnVRrcZCZIfN8BkLxHEM0xKnAiI1JPOGJRWeblFceyUOhimkt3YiTyD1j7wFis3oeGcdz6KrsglHd5OmqjM3Do/V1iBZEfUxaX9RF9N3KplKuYp5DI9u8/3WYqlu8KGBLFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915713; c=relaxed/simple;
	bh=SRwTI7+u/NnCve5Pm/cjwoHxbLU3bHYLwo13qncLgNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+0ySI7VI+nV6ibe7WmDxddLu2xFxM6hZ5FHJvCq0mKbtO0SRPx+H9FN+mEaGUM2bphDhBe+AyTyUsWfzWF77gVkt3037EmWavuB6mqQI+DONeCVRATEy2bJERItg/LTQ+7gNfg5qVkKcwei/T5HsBcZ74noDbblZKHeKhMSae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ2LMhf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7A1C19421;
	Sun, 23 Nov 2025 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915713;
	bh=SRwTI7+u/NnCve5Pm/cjwoHxbLU3bHYLwo13qncLgNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iJ2LMhf78ZBYtsUXb/eiaGrcmYvBk+qVY/C+JfJQ8laUu2gGUN1WZVk6qw0ktj8TK
	 rCl8xfsbWwdMXE1EziKq8imlRs6HkkEWSDB183rly5azt3ODbB2TgZdKUPAQVJZT7p
	 Ae6prUQWC2O0ISkGvo3Fn9oy+VmpGJt18wuEBfyis7UHiVtmioqPszwiFDIBFTRld2
	 wmt84mO9XScPqtoXD7cFxdGAfQU9Ps2nphYHnfG6T+FnAAfu661XdTrgm3KubAL0K4
	 SU18WO53QQO6IxXDAuyu77eGz7hZagTTc9HwuDAESm6qu0LK9KXxIUFyKIEv8SPtcc
	 9P31PxtkcR/5Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:34:03 +0100
Subject: [PATCH v4 45/47] io_uring: convert io_create_mock_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-45-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SRwTI7+u/NnCve5Pm/cjwoHxbLU3bHYLwo13qncLgNk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cr7Z3e4vppxXOtQI9HSu8nvrosLvKiSnfTdYP/T
 5b/4d1h11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR9M8M/9O+vuZvkBde0iyw
 M8ys7lK2qOY77VPyCtL3fryWmzrbcBkjw9Oas/xCQp+Sfwn8l69b/nvrzCNba693PrAI37mgz8f
 hIwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 io_uring/mock_file.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/io_uring/mock_file.c b/io_uring/mock_file.c
index 45d3735b2708..a2116c79e67e 100644
--- a/io_uring/mock_file.c
+++ b/io_uring/mock_file.c
@@ -211,10 +211,9 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	const struct file_operations *fops = &io_mock_fops;
 	const struct io_uring_sqe *sqe = cmd->sqe;
 	struct io_uring_mock_create mc, __user *uarg;
-	struct io_mock_file *mf = NULL;
-	struct file *file = NULL;
+	struct file *file;
+	struct io_mock_file *mf __free(kfree) = NULL;
 	size_t uarg_size;
-	int fd = -1, ret;
 
 	/*
 	 * It's a testing only driver that allows exercising edge cases
@@ -246,10 +245,6 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
 	if (!mf)
 		return -ENOMEM;
 
-	ret = fd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		goto fail;
-
 	init_waitqueue_head(&mf->poll_wq);
 	mf->size = mc.file_size;
 	mf->rw_delay_ns = mc.rw_delay_ns;
@@ -258,33 +253,24 @@ static int io_create_mock_file(struct io_uring_cmd *cmd, unsigned int issue_flag
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
+	if (fdf.err)
+		return fdf.err;
 
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


