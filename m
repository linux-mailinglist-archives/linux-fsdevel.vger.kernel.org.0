Return-Path: <linux-fsdevel+bounces-69400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C279EC7B2DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1944E6CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1333A6E9;
	Fri, 21 Nov 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD13bXDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765834F241
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748056; cv=none; b=YiRGg5ChxUbHPSyJ/fBIK2d0n2IscZLgNN9Lbw2Dd/Z6FRteBjbIjqFHnWNFpPqmB84g5xM4DF/Q3Z92VGD7x0fxSwxAtT2tlu6TtyeZXqMGjaqlkkvrV6xPOn2JKL0EYYXkUr2wj+LEfxYVjjwR250IM1YxdsZDtY+VEc4yn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748056; c=relaxed/simple;
	bh=6cIlExUBP+T0ZRJrWHqLo0KSdIslvdZhJxyXYo4p2uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zlg7xReqEEYx/DDdRUfyo7OWp4MJh8RYFztfB2jw1w1831SmBcVMKJdK1TtcG/kD1b6wByq+Ynd8PPmH0WOUHdduSMjaYubcyD/a4ag7AgJSI+Ou3P1/MY7Ev4hcCOcujNaafrMh5M1FRFGO+438cHLW0PlyMPQJf56My0OnUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD13bXDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627F2C116C6;
	Fri, 21 Nov 2025 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748056;
	bh=6cIlExUBP+T0ZRJrWHqLo0KSdIslvdZhJxyXYo4p2uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eD13bXDsfn3oF5xAVHyjmLdTjdnre82F5JwkDjhkDPnpYI03bhD+v4qHWCn55uvWz
	 ulFKi/2ImfiTF5n9/Si8jVDrh2E6r6fJYm88Qu0qPGfyyLb2bpP42Y4yiRIXXTs39y
	 qMVGE9deMXDUcQz+HajfNLpUpilDOf+N1AUEncjXqzjQeuQa8yzxh6iz2Gr5wUtFUq
	 LyLPWMthOEQpDXlTPSREgsGTjD1bzwVlMshmcWN2YFHK4r9YfpIzTXOSuZt9Vs6Eqa
	 2w2auhPr9yLWVV0dAuXTHsEo10OD5sZxx+Zmqh16iZLGwmHKAg28DCBNj9aKuoQs8Z
	 sTWMOGEY7UA+w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:41 +0100
Subject: [PATCH RFC v3 02/47] anon_inodes: convert __anon_inode_getfd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-2-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6cIlExUBP+T0ZRJrWHqLo0KSdIslvdZhJxyXYo4p2uE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDhvNmPKQhuzhQIXfPWtAq+U7lvbGf1RaSbf0rIfN
 xtX+voe7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/XyGfxoXvwncbd/b5lvo
 dfGsgErSlKUXP/3ttbIU4f4VuvddcwAjw3Extlm5TAIB1xWfVfFMvizc7jfp+pu6pNTMbqX7Leq
 vOQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 180a458fc4f7..5b15547ca693 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -280,27 +280,14 @@ static int __anon_inode_getfd(const char *name,
 			      const struct inode *context_inode,
 			      bool make_inode)
 {
-	int error, fd;
-	struct file *file;
+	int error;
 
-	error = get_unused_fd_flags(flags);
-	if (error < 0)
+	FD_PREPARE(fdf, flags, __anon_inode_getfile(name, fops, priv, flags,
+						    context_inode, make_inode));
+	error = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (error)
 		return error;
-	fd = error;
-
-	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
-				    make_inode);
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto err_put_unused_fd;
-	}
-	fd_install(fd, file);
-
-	return fd;
-
-err_put_unused_fd:
-	put_unused_fd(fd);
-	return error;
+	return fd_publish(fdf);
 }
 
 /**

-- 
2.47.3


