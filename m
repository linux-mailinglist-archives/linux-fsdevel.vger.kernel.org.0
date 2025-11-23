Return-Path: <linux-fsdevel+bounces-69547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C0C7E3EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C66BC34970F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890422D7B5;
	Sun, 23 Nov 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su4idC5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79852192EA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915669; cv=none; b=W7GxkCZIOhqgIY3sSsEvO5Lf4EEz9WVdvm/uLhN8PmVH9BQLgR2jtUG9eFrJqj0xGmonp97bFiHVyhd5XeXLSbMAIy5QvNd8g8oC230btD3VCBD3Hgj+eHoc4TOSUayLnzP43eh2vxZ3Jv+y6m5zyHU2VWK4W3TzU1+bwBh74/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915669; c=relaxed/simple;
	bh=Y+C05yjNdXMRp/TRjRJRWmQ64myOm27Sdz0tFD3ojuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OA3Up0Ppq2F6JvK1Zkz7yWUAuEivcF3Gkq9Qmt1VwFqEaRb8sj5DiUcwWYUwkAqOng1FdDvlILd3TnO8lPcmrE0UOSE3mwnsBqNgeXKzsEcoJ9Wcvj5TGBdGiNB/jLl8PQE5p+9M2r+8kOh3kWEbXkVtZVxYt2AFUnRJq1TJT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su4idC5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA81C16AAE;
	Sun, 23 Nov 2025 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915669;
	bh=Y+C05yjNdXMRp/TRjRJRWmQ64myOm27Sdz0tFD3ojuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=su4idC5vNmyf3cqTGjg73/7j50nIT6LQLl7T+49qs+HpQIL1phLNKp757dGblsBwR
	 IN9Bajal+7hwNvYN6HSEGp/qfMM3ZFexrYP7KKtWlYwAqhLXLTCjFW/NpsIKYAZZKK
	 3rm02XDh/5cWZ32H9IqaucGqA4Ijs9S7wmVcHd3tgOBElhRdCUFqehi/fPDvczjUu1
	 Ly6uZLyXOjb95RNj0avAx1iV8A7h7RvbQ/JuCwrsalShm5pPaAcI6Eki66cVIm6dQh
	 VUJ2GChfwhAv9g2m+UkJAc5+2PW0CWsJHvQ0XnTsuXh+nWyfajeygdRkLe/cCDUWC1
	 DT8MZ2DH8Bs1A==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:43 +0100
Subject: [PATCH v4 25/47] memfd: convert memfd_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-25-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Y+C05yjNdXMRp/TRjRJRWmQ64myOm27Sdz0tFD3ojuQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0elbXoZfCRBp6Pxql2v0pfdl/neaqyv/nbv5NcHH
 uXnuUsfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEupzhr9iLCONP7/48PbNx
 18yEC0fnfFuenGuVZb5399xA7cfM/b8ZGZ5xW554f8SkqXD/jgv+qzg7Q969qzwto/Tce93lCKV
 0aX4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/memfd.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1d109c1acf21..2a6614b7c4ea 100644
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
@@ -482,25 +482,6 @@ SYSCALL_DEFINE2(memfd_create,
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
-
-err_free_fd:
-	put_unused_fd(fd);
-err_free_name:
-	kfree(name);
-	return error;
+	fd_flags = (flags & MFD_CLOEXEC) ? O_CLOEXEC : 0;
+	return FD_ADD(fd_flags, alloc_file(name, flags));
 }

-- 
2.47.3


