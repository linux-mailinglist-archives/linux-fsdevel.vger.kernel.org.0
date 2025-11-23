Return-Path: <linux-fsdevel+bounces-69541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09EC7E3D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8B3A5142
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3674D2D3EC1;
	Sun, 23 Nov 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4wGiFEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCBA221264
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915656; cv=none; b=q4MSoWHqSU8PCSwUYgjSchk81nWVuv0FicqhzLFrxBUH9eRCYo4lQ/IfVXOlmcRPMW7cPfbyrHQz+jglaFBU65OY93PUXnaFCL/un9KCplS0pR3ijLpln/cjbxYjeUPDuYC6ikrsYsRw7cbW8cSvdHMRrfYZbJ3kwAdAk1+j2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915656; c=relaxed/simple;
	bh=fzTc1026B1GGbo4uHWRW3Q2mjbUhR7O3e9vTmKGledM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISZI4bpYBpJOagds9dcpE6wZYT+RStt4/YYfG4piOqqnNHrptsiBZS18Qu1dKAYcgt9i+UWKxQSgFH5fWyjg7KPx+OuXA/Bz92C9M1ynPGf0kzOMZeOA0mqZ7FQB/RDnpPPL7EsOBGK7KLY1HT1fJMXubRTsEcNcomWLRrRIa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4wGiFEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A33FC19421;
	Sun, 23 Nov 2025 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915656;
	bh=fzTc1026B1GGbo4uHWRW3Q2mjbUhR7O3e9vTmKGledM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H4wGiFEl8H3cz8+FWGqJoSD0GLwFdNRY9qmSyOGIWw1brc58+GhiYiARJV/2WMAh+
	 UVwXMCV0+nyFkeSGyvzKNY6zLu/LG5Ql27ka0CjCLFz8zg6aZ8KjHHuEKscO9MlqOJ
	 AvZvJrmWX2YITPKdOGnxTNfho34NVCIVnIlSJx5fL4F1FAwUfbbjgIFAq6BrGAM3Of
	 UVvcDG7p7gCnsfl6AHENk5u8F6NswlwKcOMmTEDgjV1Uv4bkvT6MwyandU93+CakAQ
	 TNw3C6mQSPMrMKt7LyMt3DmY+enXMFiZ/1MWQVJKOZJde4369vK748uwjWp52CHcU9
	 sVM7OKjDKuqrg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:37 +0100
Subject: [PATCH v4 19/47] af_unix: convert unix_file_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-19-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fzTc1026B1GGbo4uHWRW3Q2mjbUhR7O3e9vTmKGledM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dutr+U9ePoHNbEJzPYZ3qelTFunJr0puHvFuGow
 0IsjcbNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpk2Rk+FV2k+/vwz37UtLD
 SstSmXZc7TTU95o+jX26qkD0DSMPN0aGixMl3kXO3MOlIPHkheyKGQtfPlc99HXStQS3Eya3Ba5
 GMQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 68c94f49f7b5..6de7909182ee 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3277,9 +3277,6 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
 
 static int unix_open_file(struct sock *sk)
 {
-	struct file *f;
-	int fd;
-
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
@@ -3289,18 +3286,7 @@ static int unix_open_file(struct sock *sk)
 	if (!unix_sk(sk)->path.dentry)
 		return -ENOENT;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
-	if (IS_ERR(f)) {
-		put_unused_fd(fd);
-		return PTR_ERR(f);
-	}
-
-	fd_install(fd, f);
-	return fd;
+	return FD_ADD(O_CLOEXEC, dentry_open(&unix_sk(sk)->path, O_PATH, current_cred()));
 }
 
 static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)

-- 
2.47.3


