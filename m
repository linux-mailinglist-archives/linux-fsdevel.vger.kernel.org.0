Return-Path: <linux-fsdevel+bounces-69311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97DC7684F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AA06829BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14730F542;
	Thu, 20 Nov 2025 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1vgooXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A345CCA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678002; cv=none; b=TGI2XSF5FwkWVdEIMvAAaE4CSZB79kU3mhyCBSLXVbTT4+ttAH8aoFgYaPcQcgreaHgDrAEa7eIWMZnporS9XYsUGugAMh59z15sNpuVxIBkU/MxNakpxaqZ7STkwaIdQn2wiAkOQQN9C9h0bAdIAHeqGX5oQ1nOwrD+0FAFU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678002; c=relaxed/simple;
	bh=8Yl0iaI0IYYbj23V/xHVkR4URvnX9SgDj+8rgjkrt5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nm+mphmfW+E+1FQB5rWd4bvv3Ie3ipu4wXBP2vK6qIJkVvuL5PvgIBrZcoSMTBRvwowphincNoo26Vcx6QDqpYcpHQMkVc7HhMTi1r7jpb13112Ksx5/6TxL70lUhWtrTg6puHUORJ7IakSltvtyNnxRX+dqI8rCI7Y1uiHPYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1vgooXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32E0C116B1;
	Thu, 20 Nov 2025 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678001;
	bh=8Yl0iaI0IYYbj23V/xHVkR4URvnX9SgDj+8rgjkrt5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F1vgooXXSKpUXDwNkDHs44dWdzfBLhkwAQeIo7NkEx5gnCMNA5euS1D2DSGH/VbrS
	 UTvYG+l5UHI8iyZ2BbY+FszGvbjXjEKxWjZAsmgbDh4QR0GRzJHIH2qr+dOMqgeqZL
	 D1cclwJBh51CMZitTtR2NiVaOy73KhiJJr5ZgGxv2Nfxm4qSvx6254Wr5aXICpQJf7
	 zzvWaCPuTN1ril7tH8ygtdrugjk8FSHPZLfwbdFvPsK5AHZ1Qcrn7tSEOoetdL67dm
	 09Sti5XqYqZ8/s6SngVksiLsimNE0sjjsgcNuCGRnuQlSCOyKn8a8es+tG8zkQ5kLh
	 5QPT0noLuXZxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:28 +0100
Subject: [PATCH RFC v2 31/48] net/socket: convert sock_map_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-31-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8Yl0iaI0IYYbj23V/xHVkR4URvnX9SgDj+8rgjkrt5Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3uXcKV6lrJucfI9WxVZs6/dm3fES9zeOW+ywMdab
 5bpjNNOdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE/jfDXxkLhoMhj1y1234X
 TPiTlssrdPr+91WLNtvHVO/33aSjKsLwv1bWYT9LyBzJf8YKEa/TGjKm6hxeyrRm9Vr9v7z9dqd
 /sQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e8892b218708..669fecc79851 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -503,21 +503,14 @@ EXPORT_SYMBOL(sock_alloc_file);
 
 static int sock_map_fd(struct socket *sock, int flags)
 {
-	struct file *newfile;
-	int fd = get_unused_fd_flags(flags);
-	if (unlikely(fd < 0)) {
-		sock_release(sock);
-		return fd;
-	}
+	FD_PREPARE(fdf, flags, sock_alloc_file(sock, flags, NULL)) {
+		if (fd_prepare_failed(fdf)) {
+			sock_release(sock);
+			return fd_prepare_error(fdf);
+		}
 
-	newfile = sock_alloc_file(sock, flags, NULL);
-	if (!IS_ERR(newfile)) {
-		fd_install(fd, newfile);
-		return fd;
+		return fd_publish(fdf);
 	}
-
-	put_unused_fd(fd);
-	return PTR_ERR(newfile);
 }
 
 /**

-- 
2.47.3


