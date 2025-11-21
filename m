Return-Path: <linux-fsdevel+bounces-69428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291FC7B316
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7F1A4E7B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD757352F9D;
	Fri, 21 Nov 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyXAwt8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F82D481F
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748115; cv=none; b=RzBhvFKPSeUsBllznEch9jWQ98qcMq9FSgLYDyOoRpowfRlbYg/zuZNxbqc++ZVD30m1NOP8VoU9P0NqxqvYGxTqIycIvBq9MUPslVkpOtf30JK5JSSW3OrvnZHgGcqiGpBCNdZFDg/V6Rkb5PXN901RvTZXnst/kmBneL160Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748115; c=relaxed/simple;
	bh=M73INiWmbUgQH8GM65xZLJ9X9BQTUU/GMFLNAyhAyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeXDtdm6U+m81bvuKIFJBFCsiaWlB4kXjBTlrWL1n8o33IfQjUhOmJ+3GEE5jrDAXyKfAw0pIBaQEjPNIO+PJeJ9AnKeHfaPMvcicHzAyxMWpeBLsm1F8FL4r1jain+ea9zUQdi1jjBM0k8qtWh2G8fPp8f+vUcmADo2D+GoDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyXAwt8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB5CC116C6;
	Fri, 21 Nov 2025 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748114;
	bh=M73INiWmbUgQH8GM65xZLJ9X9BQTUU/GMFLNAyhAyTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hyXAwt8ZwpIGZ3UhiWC0NUPKXGqGmKazkH23BqKYO/PYwVSNXKffsLcKY8lVQ9rrT
	 kOhEWP9NtdRoICgydPLFWN5bttlMP+8+04Pn/7xiIBYfvdOueIfbxV3JonFdeRZUFr
	 3GUHb3ALL8xDz3UBd+s48tgah0Wu2EsyT169kYiOWiGY69ZW6qEtAw7g1AAgA2iw2N
	 1optRxZPD59jq5vFnEKmvsOskbqmA13TEpvYLnSF/49pxlAhO53oo9oHLGV6jiRn+x
	 O6aaMIYoqnzJSH7tBfwYMKj/xWs7raAuQ8sxGpyj4HoDwYJ87tp8EElJOxpHQFs4lX
	 CyNlQKk4WaqLA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:09 +0100
Subject: [PATCH RFC v3 30/47] net/socket: convert sock_map_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-30-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M73INiWmbUgQH8GM65xZLJ9X9BQTUU/GMFLNAyhAyTc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLiwUvO6sbGqMVNEj6Dve36r3BAdhfV3UsJF9r0Q/
 Wb796thRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQedzD84dq4vX3vpKjrvn0y
 eod8qq47NjlwvuLIYdATNWNpmf2cn+F/1JlTOvW3VqXLiLxpb3h4/W9QW5OFDNO8h/lhIVP7Dof
 yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e8892b218708..af72b10ffe49 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -503,21 +503,16 @@ EXPORT_SYMBOL(sock_alloc_file);
 
 static int sock_map_fd(struct socket *sock, int flags)
 {
-	struct file *newfile;
-	int fd = get_unused_fd_flags(flags);
-	if (unlikely(fd < 0)) {
-		sock_release(sock);
-		return fd;
-	}
+	int err;
 
-	newfile = sock_alloc_file(sock, flags, NULL);
-	if (!IS_ERR(newfile)) {
-		fd_install(fd, newfile);
-		return fd;
+	FD_PREPARE(fdf, flags, sock_alloc_file(sock, flags, NULL));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err) {
+		sock_release(sock);
+		return err;
 	}
 
-	put_unused_fd(fd);
-	return PTR_ERR(newfile);
+	return fd_publish(fdf);
 }
 
 /**

-- 
2.47.3


