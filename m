Return-Path: <linux-fsdevel+bounces-69423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C7BC7B33D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDF0E3672F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1B34F254;
	Fri, 21 Nov 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AluNIcVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA52E8B76
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748104; cv=none; b=GmmA+NHy//bUXIkpvoOV4F6ZDakKNDl0NL82CdGdS0M/syAZdIZNzAnLw6geph+Q7Gpo1woJdG3VaNeH0CYmz0eTIyrcWyEkVByOfoTry0ZFDQr/7ztc5t58QvVcC/QwO5OTPicBQGCylgDIJQs5Vf7e6LDblsCLpfM+3/UwYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748104; c=relaxed/simple;
	bh=ZJZ1lhtuYeVEQQ6K+rH8FYow1tcFxu9d4bq1vtEFPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBCS1dxokknhSVjZ/YUdqesd8g6K2NPvtuAlm2SQdS9tM0oBd2GL2NXYmu30Pi8UQ3OrKnqzXhRhd4UsEXN/ARkAkTpxi0P1VUrB4lkbW2AHODYX7R4uRZC/d9B3IhWjc+8S0wIjI0pIFULLFuqUJPUo87QdhxWyMPQahR8N0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AluNIcVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BDFC116D0;
	Fri, 21 Nov 2025 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748104;
	bh=ZJZ1lhtuYeVEQQ6K+rH8FYow1tcFxu9d4bq1vtEFPkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AluNIcVjpOCZ3GNv4qtF67bNjVpLK7DcpIBAWc980prADbHBTram2+TmzNZaUmVg9
	 Y1U7wWdcbiHQSNjUYShtElCMVQFKDBYB902AtfizjDOce+pRT3kefEyUaqSwHWMIeQ
	 cAe1B3J8NpktNcgSd417kpydDIF1DXoaw2p25NSS9v14qXfTaiBAidJwHslMCujv9A
	 wZfEJiu9/99Wa/90IrteLEQbSFw+ygv5iUsTC4seGYH95js+NROn5PmjMNs1OV7UW8
	 6pD/rOPSuRh5kT5jYx36uZTW24CaVXDcD1MX6AnN09DwIeuO3RtkMLjwb3lSYrGHdB
	 +7WmNckWXcWYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:04 +0100
Subject: [PATCH RFC v3 25/47] memfd: convert memfd_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-25-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZJZ1lhtuYeVEQQ6K+rH8FYow1tcFxu9d4bq1vtEFPkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLhQ/n+pLKsBJ+81/QPbLU7Wvbx/6dOVKfJ+6fwbl
 I++aWlM6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIUCHD/0qhPSsOMDj67cjX
 X8W5XjLSbO+PmxYN9d1mGW43nf8+E2T4X7rx8Cpz5R1Lbq/PufDba8OpIhWGGeYvPPLk3m3K0LO
 s5wQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/memfd.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..4267ab8e9099 100644
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
-
-	file = alloc_file(name, flags);
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto err_free_fd;
-	}
-
-	fd_install(fd, file);
-	kfree(name);
-	return fd;
+	fd_flags = (flags & MFD_CLOEXEC) ? O_CLOEXEC : 0;
+	FD_PREPARE(fdf, fd_flags, alloc_file(name, flags));
+	error = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (error)
+		return error;
 
-err_free_fd:
-	put_unused_fd(fd);
-err_free_name:
-	kfree(name);
-	return error;
+	return fd_publish(fdf);
 }

-- 
2.47.3


