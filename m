Return-Path: <linux-fsdevel+bounces-69306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB45C76861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97D384E5A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867D36657F;
	Thu, 20 Nov 2025 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJFhuDYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63A2EFD86
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677991; cv=none; b=nxUBpD7Hw2i5eY+4C501IpvnoGg2z3d5acfz8WaxgDoNe4kIwc08dqmSgdxo0XaygkwuxmSAwDtCV0W5SefGuTnKs5QpL/6khsT1Z5Iqg6qsWP8ngcyI84FZL8khYUza6JdlHHySxHBUsR4YDReno1Ji8DylUIEO8bPHofBHzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677991; c=relaxed/simple;
	bh=MTWqJD/TEm3lCXtbnY9mEqp8RdvFxX8U+MRJy18dpvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeanA84ByqiTgUM6DyHOpcCfxUgxbRL7ECB4LAO49M/ed8B3AOy+s5Y90YWGNp46HpWDQeBxAR5Bai4wtn44rGfZhNDQxPuuZkikUYz8xklnYrJTGe/pq0Rf2j2L0C1YNuqojdAgqXs4ytZ81RQyIs098twiU0trBw9bleIuzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJFhuDYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5619EC113D0;
	Thu, 20 Nov 2025 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677991;
	bh=MTWqJD/TEm3lCXtbnY9mEqp8RdvFxX8U+MRJy18dpvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qJFhuDYbtEIDfEozf+9Qrz2dzw7due0c1b5zi3m5/5lAkM38kgaE+smoSliES0/jq
	 rDsmUL39OIyDkT79OoOk/GSlUT5Alm+nC2yjDkEBJnkV7O5aH2EcpjWFW9kEA8+SFd
	 5P8+mvnYgIpicwPJRwtVlvrUg/VAGhFZgpDhpfeNI6FUB2BPFZ40mlJ4bUAG/aqVaD
	 iJz8VbCpwvJtfeGgt/pPUDDCDt3LdhvRJFRtD7CFJ8dDS9ZnSaniWRP4cLrVX6L8Sb
	 6KHDq2xpek+/PZ7UNPGFVKkYoJq97GWnhNIQwqNacqVFGbOn7ZyQhjjDDT+6VPqpjt
	 yb2bn9G0v1u0g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:23 +0100
Subject: [PATCH RFC v2 26/48] memfd: convert memfd_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-26-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MTWqJD/TEm3lCXtbnY9mEqp8RdvFxX8U+MRJy18dpvI=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkflu2i12IUC9vs0YO0ouvkTGjNRNX6OQhxUOcaHsnv9RnPb
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkflu0ACgkQkcYbwGV43KKRFgEA7bZs
 n3Jb5KtEGqYxlAM12tM9eHDO99USZRcxFyI6rK8A/0uL0R97obWttcAedisc8gOnI7s6GOW2Df/
 VCSQuXs8I
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/memfd.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..843d34e7b1a9 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -470,9 +470,9 @@ SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
-	struct file *file;
-	int fd, error;
-	char *name;
+	char *name __free(kfree) = NULL;
+	unsigned int fd_flags;
+	int error;
 
 	error = sanitize_flags(&flags);
 	if (error < 0)
@@ -482,25 +482,11 @@ SYSCALL_DEFINE2(memfd_create,
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	fd = get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
-	if (fd < 0) {
-		error = fd;
-		goto err_free_name;
-	}
+	fd_flags = (flags & MFD_CLOEXEC) ? O_CLOEXEC : 0;
+	FD_PREPARE(fdf, fd_flags, alloc_file(name, flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	file = alloc_file(name, flags);
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto err_free_fd;
+		return fd_publish(fdf);
 	}
-
-	fd_install(fd, file);
-	kfree(name);
-	return fd;
-
-err_free_fd:
-	put_unused_fd(fd);
-err_free_name:
-	kfree(name);
-	return error;
 }

-- 
2.47.3


