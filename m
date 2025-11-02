Return-Path: <linux-fsdevel+bounces-66705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B4C299B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223183ADB35
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A224BCF5;
	Sun,  2 Nov 2025 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Sho3mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054624A079;
	Sun,  2 Nov 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125190; cv=none; b=SmR6sBUhVKAH46bhubGrJeTfweccvJ9yM01kvROyxTnLvK56LnIPCilErum86t7j69/Sns5xzqt9uW0KuUKxFZfj0PH2EAOsyWOVgzdDiOkhEHn48U2QaWslxnv/cQmULh6oGWEwbKA7QuZuHxJUThobiH72Qy6zJU7qLn4lhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125190; c=relaxed/simple;
	bh=8qvEulndLNp7rN8gRGXI+meMz26/CIvolGUpF+mARqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFDLBRUlpeYrOxiTmbjljvdK8cTizE7bFlcVwfouxIevPk5qpF0tuksy5AJjcAiKxdzQqF5nXZGxP8jXTI360LVIpTa9n/LC6nD4ea20tqESHWVF7sWSvhYlp/DcfQeVXDfjCCSEn2f0XDhBr5TK0xp06b6QdcNrdHMh6vj4amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Sho3mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6FBC116C6;
	Sun,  2 Nov 2025 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125188;
	bh=8qvEulndLNp7rN8gRGXI+meMz26/CIvolGUpF+mARqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6Sho3mrgPIrSo0cessW6hKWN9uJvLa/4MTzAkXUY1QEHDMYJjiSPaPtV1CUBKMqf
	 DwquINhwzDd8MGIdqLVyN8/9UC5ddWgMxKkSVx8f1Q/qSuxw7YTOYGXOl1vUivFR8l
	 svEQR9xvxsXJdno6+bOvT6csFmX4DaU+cBt8E4vC34b8oQ4VIm6DRAuZmLQMJwv+5j
	 FYfiqJ1scBFDzZ7gh+287kjqG36bNbf6k/VkzSqosBQrhuPa/ReX3I8kTK08LZFNd8
	 5cHInGap2IQ6NH08sbzx6sV9CshdZ2hnauKxKcOdllu3Hk2K638XW1mmFvq797Dcjt
	 g9O2hVLqzP2oA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:47 +0100
Subject: [PATCH 8/8] unix: don't copy creds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-8-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8qvEulndLNp7rN8gRGXI+meMz26/CIvolGUpF+mARqY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy2tLMtLaLbPvi/ndHPXsghVyUVTl55P1PvY0MjcK
 CLgvXZnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESsNjEyNJ99vf3E0wRJNe7e
 +jOKraL255a/ZQtdy37y29G0RadYWBj+aZzezdfpaTDnxYWkjIi6jxtt2JdzHlVcu/1D9gvbEKk
 SXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-6-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..68c94f49f7b5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1210,25 +1210,16 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	unix_mkname_bsd(sunaddr, addr_len);
 
 	if (flags & SOCK_COREDUMP) {
-		const struct cred *cred;
-		struct cred *kcred;
 		struct path root;
 
-		kcred = prepare_kernel_cred(&init_task);
-		if (!kcred) {
-			err = -ENOMEM;
-			goto fail;
-		}
-
 		task_lock(&init_task);
 		get_fs_root(init_task.fs, &root);
 		task_unlock(&init_task);
 
-		cred = override_creds(kcred);
-		err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
-				      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
-				      LOOKUP_NO_MAGICLINKS, &path);
-		put_cred(revert_creds(cred));
+		scoped_with_kernel_creds()
+			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
+					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
+					      LOOKUP_NO_MAGICLINKS, &path);
 		path_put(&root);
 		if (err)
 			goto fail;

-- 
2.47.3


