Return-Path: <linux-fsdevel+bounces-69410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD2C7B32B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA005358110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4D351FA8;
	Fri, 21 Nov 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4m8d8Se"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5B27FB34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748077; cv=none; b=odjbsLfyppMJemdNGX7s5ap920XNGayxs2OlEWfKaeHYyFeK6UkWlb0Oxs0Wj0udHn5UwUgXufLm7MkMLZpBMK4cOHMRxqAuVscAWdncinHJK7FEeEG8w1Ifo9t7BvMZf0S9hfcGN+96VJRm4JWphgCJXrlt68ID717bYJWEfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748077; c=relaxed/simple;
	bh=dJLpBN+VfahAfPI5YMmxMh7BU2ZugfXdb2dCaLqrz90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPeDEPKWrtwjWkx5Gg41INk2S2sYHr0GRPt8dOnpZMAgD0IS7hii2codWxTNxH5cDVPZXCWMR+DOxWvDKgxAbdtDDBp1J9Ht5mam+aWwpDl88Q0UoEFHyi6iOMAf58uwnig+cgshKF/CpNwDc0NkiM/dcumOjPRNPAhjyde274I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4m8d8Se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5D7C16AAE;
	Fri, 21 Nov 2025 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748077;
	bh=dJLpBN+VfahAfPI5YMmxMh7BU2ZugfXdb2dCaLqrz90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N4m8d8SeLMAh9DJ0jV21/ntnwTqgqyEHvkxZX2z2DggLgJKkvpiyWK4bQ4wyqqR1p
	 gb5mXt9FhQbXrHzd7G0kFCftnXMU+ppY0gQy5gN4ATEBZCQ0c+MULJyURF8eZkJr1Y
	 5RcYcdI5vzjNIVFGlg520Xebm8MSfsfL6ScQHd9TSl2RRM76N6Bx4DnmiflDAGEOnq
	 OF8oMxC5Bdg+JkD6BU8GUeXedqkq68Xc1q8JhRlYMjmbmv4PvMUVLJMCxBbhXOQ+E5
	 lDk4DyolIz4A2VNydTmnKfh0NnhTJuvjatb0fc8xFlsRUfvXr+xs1h0Swq1ATDZr5g
	 injQR2m3ZBb6w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:51 +0100
Subject: [PATCH RFC v3 12/47] eventpoll: convert do_epoll_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-12-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dJLpBN+VfahAfPI5YMmxMh7BU2ZugfXdb2dCaLqrz90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDgvFvhkX73av+/FeuliVznXFyfH9S1Z4Faxznr3s
 obpM5MOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEpJDhn+3i96anDX9dil8T
 eOXve8kmvSfzfXWWLjml5Pze9Gv5qX0Mf3i5n5fY/Pp1eIpe4R2NqgK7uT+V1f/Jb3qvKqhyceb
 W6bwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ee7c4b683ec3..f694252d9614 100644
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
@@ -2184,26 +2183,16 @@ static int do_epoll_create(int flags)
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
+	error = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (error) {
+		ep_clear_and_put(ep);
+		return error;
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


