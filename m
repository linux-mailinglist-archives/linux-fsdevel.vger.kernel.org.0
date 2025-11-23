Return-Path: <linux-fsdevel+bounces-69553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D7C7E3EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36D0C4E34CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512522D7387;
	Sun, 23 Nov 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNi0DspK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07A2D24BF
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915682; cv=none; b=GCIfIzS+jfmv9LqXpJjuNo5mDDjqIARY51gltOwnXgc1wlAozTk4zvmisJWqARjOu2wsLS5ghfgo3lLgTlnU7FlRdJ37GQvUE9lISi+7vdd4L6pGC3ZvANVX9X/lxZlDYKAOcA88WmXuj9CaAn4HzB4EFmPRHH2cIu9n8/qvT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915682; c=relaxed/simple;
	bh=n5pNvFuLJE95JRz/c+qTAN+mGQWAXiNfUaZiyiOYthM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FF0V0dl+T3iqv1tOt5SaJ2PdtC479v1T/k6ZlImt/7We/F1QgXzGmNfBkV6kawZ0Ptv91yLzwPdos66dJRN6WSWwG4AcvrN+YJLWjDhyc4/zeHanJHPwvSa14ytlxec61GnRBMDRTwdWIUq+0EsZ9iCyiTTZnoOTy2JVLacjhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNi0DspK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF9EC116D0;
	Sun, 23 Nov 2025 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915682;
	bh=n5pNvFuLJE95JRz/c+qTAN+mGQWAXiNfUaZiyiOYthM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hNi0DspK0PNgkHI5wMujkku1n35+jyjgluZGIdF5vCD883yiHokRJdldEmJ8fselT
	 ukB7cwrHhUXznQtoq3ptYbSTO8Ne47+0dRkX4V+dao/ST/zD+g4DikHlO9cQQJe4Ag
	 YjJc/89bV5iLuClkDMaPN/RMp47nRP0huShZipazfPbGqI6l5a3seVfAiy6XGzJTtf
	 01oxBMasFGcod6GgM+EbRwS8eEfZqu7PhxmAJ8kG33S0SDiLmQmUdZQQfmx2Vr4g0P
	 bSRcmUVPUV3w1TPnrwesTRFW7HYyf4mAuZhvF3P0j6ppe2NVAyNFXTg3P6qCNkf/O3
	 ylbNXLwjFKkTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:49 +0100
Subject: [PATCH v4 31/47] net/socket: convert __sys_accept4_file() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-31-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n5pNvFuLJE95JRz/c+qTAN+mGQWAXiNfUaZiyiOYthM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c5Rr6r1uZew3BE7eWLG/4r8/Y8mFjbW2jWV7N8n
 frpVdz+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRymNkeLzh0YPYYuc2VY3u
 pd+OuP99vVVbqKhnLdPdg5Ev5K5fWcPwz+h4fdqKnG3rH00/KV91OrMxWt6ZeUe49+ZD31JUN+1
 awQoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index db2065051d33..e1bf93508f05 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2003,8 +2003,6 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 			      int __user *upeer_addrlen, int flags)
 {
 	struct proto_accept_arg arg = { };
-	struct file *newfile;
-	int newfd;
 
 	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
 		return -EINVAL;
@@ -2012,18 +2010,7 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
 		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
 
-	newfd = get_unused_fd_flags(flags);
-	if (unlikely(newfd < 0))
-		return newfd;
-
-	newfile = do_accept(file, &arg, upeer_sockaddr, upeer_addrlen,
-			    flags);
-	if (IS_ERR(newfile)) {
-		put_unused_fd(newfd);
-		return PTR_ERR(newfile);
-	}
-	fd_install(newfd, newfile);
-	return newfd;
+	return FD_ADD(flags, do_accept(file, &arg, upeer_sockaddr, upeer_addrlen, flags));
 }
 
 /*

-- 
2.47.3


