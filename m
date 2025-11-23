Return-Path: <linux-fsdevel+bounces-69552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A041C7E3E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F06CD4E175E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E592D9EE5;
	Sun, 23 Nov 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vthw/8w1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD62C17A1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915680; cv=none; b=ui8xfus0mogwGEcwqxSbmx/UBZx3xc8EuANC+4/fZFDEM7rWVNVIJhlWA90AdmHYaf6j5dbfKoXHWb2VjxIIPVjS5X5fDAjRnUoe+bxKVF4wn3rzjtxA/jrrkEDivAuyNyjYgfRYbQ6NxDBcL/9jMA4VwVyjk4mAVEhYwYU6Wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915680; c=relaxed/simple;
	bh=6l74Ppnfe1TKXhO65TABiJq4qs+d6+2Bj5PS9dpRzhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDD/kILMoobAg2v6lz7B3YNAe4bI24XRWV1LwIRLDFTC4meUNW0a4LefnanS5aAuC+cDaV2CWWsP3AkwhF2V1XF7rPBT1U809sudrbAQWXiJNeUQneheBhDTr1cnFnlsYz1DXIlxhrG63rn7wR3l7t5KR0OX8Nr89uh3RV3O6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vthw/8w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5100DC16AAE;
	Sun, 23 Nov 2025 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915680;
	bh=6l74Ppnfe1TKXhO65TABiJq4qs+d6+2Bj5PS9dpRzhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vthw/8w1LKlyunLTlfyYgeA+Ip2ZZWdAd9YAcHMTHzr5+/H/CfzPttCyjlUT39aHz
	 Cz1Q+ZjgF/+JssHZqlWERDdHrDMN13r6uiLPCi7anXcL/tuSwPZJ7cWTHJdItfDORV
	 AmTLnQ+dN9XXnpRwX7gLm7Wor8CHKNJj6kAJAmcemNAOm9yw2h1j5FruFdXKyhudEh
	 dnSDyHCO7ZH8Ujp+CLhqE8XvEbchfSP6lbwBmFRxPxT9al78FhxXH4c8Y2AkAt0rZa
	 yLR5cGJvjKmjNS6phydKjNeXB90n8sAp31pXfzkdfGIttBQerh7t3J5oN+3OVEI2gQ
	 YFitg5m6TLONg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:48 +0100
Subject: [PATCH v4 30/47] net/socket: convert sock_map_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-30-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6l74Ppnfe1TKXhO65TABiJq4qs+d6+2Bj5PS9dpRzhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fdn1rRI63FuatlY7CqpuWyffU8DkUfk291uXPdk
 /dz2l/bUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEDtxkZJgWFCp299NLsWapt
 we8fc/5NU3olur88NP5n3k7p+p06cYwMzRe1Qzaxr+fjn6LsPsnqTsWuE1FlizcltAjKLT76rVS
 fHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e8892b218708..db2065051d33 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -503,21 +503,12 @@ EXPORT_SYMBOL(sock_alloc_file);
 
 static int sock_map_fd(struct socket *sock, int flags)
 {
-	struct file *newfile;
-	int fd = get_unused_fd_flags(flags);
-	if (unlikely(fd < 0)) {
-		sock_release(sock);
-		return fd;
-	}
+	int fd;
 
-	newfile = sock_alloc_file(sock, flags, NULL);
-	if (!IS_ERR(newfile)) {
-		fd_install(fd, newfile);
-		return fd;
-	}
-
-	put_unused_fd(fd);
-	return PTR_ERR(newfile);
+	fd = FD_ADD(flags, sock_alloc_file(sock, flags, NULL));
+	if (fd < 0)
+		sock_release(sock);
+	return fd;
 }
 
 /**

-- 
2.47.3


