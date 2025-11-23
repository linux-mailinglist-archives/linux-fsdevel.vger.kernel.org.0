Return-Path: <linux-fsdevel+bounces-69534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F16C7E3BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98C554E33F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860B42D3EDF;
	Sun, 23 Nov 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVo48tUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E72D6E5B
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915640; cv=none; b=Ur7R6RtUxpKxreWTE+9fA2P5S/vPAIDtCQnGrXiYTYsyb0oyBF0gxR9Iv7Ura1zSL2yz/BnM7i4GPnJpCkWM4AZaD7iutweh3tuMON8bVK2OpDYQhYskcnagcpikC8UwHSNq6pk/6FJLXzNf6waMfzwl+frncfIgA7WDwz39FsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915640; c=relaxed/simple;
	bh=sbrmFF7YEpZSmcMQDMkrSDulPAV1vB46SgkwIHvU5ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnE77BFZZv4SundcTTEQbFWRs0DMIv0pZWPQ8PrLehUk9hqzorAExFRRHzmEpjB+KMdCg3ytxGkBzizcHmcGDOIStKRw1B8VS10JN124yxcxoX+bYQeUsAT0lNeCq+A5up3zq7SmzCTmbnzUUeHiKoNVe7D3a3fmjJG+nbd5aWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVo48tUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAD1C16AAE;
	Sun, 23 Nov 2025 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915640;
	bh=sbrmFF7YEpZSmcMQDMkrSDulPAV1vB46SgkwIHvU5ME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZVo48tUKK1XSZUnwcbKefrI9YmNUFNbyqJaD2WbQFWWCz7qlOClJy1MGVEVFCxbqS
	 uthwfbnEVpUweTHd0RxcOVJDRbA36Gcjjgd4GarjlZN+sgkouwInaV4j8s/VnrTiLA
	 R0FxwOWSVoZhQKgtzR4JX1omz6fO8F4Wr6gAw4JfXyYxk8vReXAh/7tZ5KldtYyP7C
	 cez+H+btW0jsV6UM6/lJw0YZ/n+mrd86jxpL2qkG1GJP5YG3LhJi7eizigpF+GvI23
	 HU4wWeQ3YmgRVOrH0k/ARaVKdyJp/eNc7+sCv2HtEl411k1SjzolIZNLRXm3DoIpV2
	 K62n5xmAfMc/g==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:30 +0100
Subject: [PATCH v4 12/47] eventpoll: convert do_epoll_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-12-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sbrmFF7YEpZSmcMQDMkrSDulPAV1vB46SgkwIHvU5ME=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fOk7mpdvpvrk5q+eqO65fUg/W9OSZzKT+dc6XlV
 ppTBl9fRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESeHmRk2PZllofv44X/2295
 LdLe+zTx97JLfObKx959VDltc3JFxQNGhkv1/yUY/1r2HbzKxtBTL75R7IP+obmr2VQuWPmtN/I
 q4QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ee7c4b683ec3..6c36d9dc6926 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2165,9 +2165,8 @@ static void clear_tfile_check_list(void)
  */
 static int do_epoll_create(int flags)
 {
-	int error, fd;
-	struct eventpoll *ep = NULL;
-	struct file *file;
+	int error;
+	struct eventpoll *ep;
 
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
@@ -2184,26 +2183,15 @@ static int do_epoll_create(int flags)
 	 * Creates all the items needed to setup an eventpoll file. That is,
 	 * a file structure and a free file descriptor.
 	 */
-	fd = get_unused_fd_flags(O_RDWR | (flags & O_CLOEXEC));
-	if (fd < 0) {
-		error = fd;
-		goto out_free_ep;
-	}
-	file = anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
-				 O_RDWR | (flags & O_CLOEXEC));
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto out_free_fd;
+	FD_PREPARE(fdf, O_RDWR | (flags & O_CLOEXEC),
+		   anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
+				      O_RDWR | (flags & O_CLOEXEC)));
+	if (fdf.err) {
+		ep_clear_and_put(ep);
+		return fdf.err;
 	}
-	ep->file = file;
-	fd_install(fd, file);
-	return fd;
-
-out_free_fd:
-	put_unused_fd(fd);
-out_free_ep:
-	ep_clear_and_put(ep);
-	return error;
+	ep->file = fd_prepare_file(fdf);
+	return fd_publish(fdf);
 }
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)

-- 
2.47.3


