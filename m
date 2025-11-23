Return-Path: <linux-fsdevel+bounces-69531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 323DEC7E3AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A30794E1802
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C82C17A1;
	Sun, 23 Nov 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiLdMHDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AB233149
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915634; cv=none; b=B292H+C6jwD2XEvVcTeZ9+QKqiEfRv9fsQj2brr4DDkekylgPfVjYqsIwIifYtnPnPTAYwvZbCZyxBvUHnPlZnVzpY9Fr72vxDrwxH9zW85LaqeEAuSY9HlY5o6PuRwwNE96rlY8Fh0eNVW6ZW56um9YJ+RcQNftZnSNm8MhMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915634; c=relaxed/simple;
	bh=EkpfxeDTpGAh6ieRdnwWwju0+uvB1XopK+piZonUMEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh8dXCn9qyQSFr8AgIYmKZsS5iCsLPRRlAbhGLnpfqtYC79JNhMM+VkjonJtGE2ox/MsxlPbEm5hRkVZ4Ri9YNLJrmHv5KRuBPzz5o1wOEgLbrRo7f+mOz6r5BolfrICWGsRhrqtvHkMox9JUF/X1aq8/y2Aw5QOF5ZJl8/v9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiLdMHDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3392BC116D0;
	Sun, 23 Nov 2025 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915634;
	bh=EkpfxeDTpGAh6ieRdnwWwju0+uvB1XopK+piZonUMEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jiLdMHDVL/sDpI5/7IyIpmRxwnGwzyz/wcrUkugnJ3vY+HQE4DTICYK3oEXbQZh1w
	 SoDJigsGYpQSyN1BKdprLPe+KiQHcYpe6CrjyJR3HPc/0l6cGO1HHFFaveF6i58EOv
	 bnG3l9xyemaGXDv9uKcYH1866FsCj/q651VkkeH4oNmzgVHZR41boHGUHkvClMDrGP
	 sJudxkG2uRs0eJTXWgeZcq4o2/onCwseVCZrpz68ndQ+ABDcAfZx1WH8jiEk6WBdvI
	 EjKRVZMrL1K+CNkwa/fxBk9hKlht7y/xum93B7Kz8ZCHiROrKGF8tJm8a2VHmFKg1G
	 ISXVtOd8vKBCw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:27 +0100
Subject: [PATCH v4 09/47] nsfs: convert open_namespace() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-9-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EkpfxeDTpGAh6ieRdnwWwju0+uvB1XopK+piZonUMEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cmZj5tEH/nUbJwac5W7VP5vTcTDuoIXMza4HiIT
 VE0Nby8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK77zAy/LH4tM30gSOnAJuC
 h/f8n6rbFW742/X2r1hgVNP02/5IJiNDg7rKS39+aeeJX+Pz5rb+1t5zQOf4u6Ylotn/3IW0pFp
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 79b026a36fb6..7b26cb49a62c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -108,7 +108,6 @@ int ns_get_path(struct path *path, struct task_struct *task,
 int open_namespace(struct ns_common *ns)
 {
 	struct path path __free(path_put) = {};
-	struct file *f;
 	int err;
 
 	/* call first to consume reference */
@@ -116,16 +115,7 @@ int open_namespace(struct ns_common *ns)
 	if (err < 0)
 		return err;
 
-	CLASS(get_unused_fd, fd)(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	f = dentry_open(&path, O_RDONLY, current_cred());
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-
-	fd_install(fd, f);
-	return take_fd(fd);
+	return FD_ADD(O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
 }
 
 int open_related_ns(struct ns_common *ns,

-- 
2.47.3


