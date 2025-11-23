Return-Path: <linux-fsdevel+bounces-69528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E38BAC7E3B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 848F6349718
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46A22D7B5;
	Sun, 23 Nov 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhdutFj7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A82D3EC1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915628; cv=none; b=k5trntB8NQc3h08M1Kjg+LJkuSbC97BoTsLo187nXpNglF+mKMS4l5fRotOhzxnBAHcBFBi6HFvuJ1oSsAA3lTzU+tuJwvpS1tQik633n0IVTJGZvMTpPzrY9/I+xXQNz2G/Hfvc3sJizpQgFnfZfaTQPiyyusVLWbsxK0A8tZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915628; c=relaxed/simple;
	bh=0RZXGgLP33kPAVG5XMhUd63mdtBAEBI/Q9v+b9EN6Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGtJWvFVu38uVyKI+6X+ngRWdUw6cWGMQ444ou6Z7icoObirjvLZEE8xDJ66VTz8lWgxRglszhE9cTzdFJ3bAw0ujQ6VPRJghlW+eLlG8SiMmiMcihZV/e5uRKY/7p4ojtFKtvy5y/VDchdNERiqdjf0rwdF5lQ38hiGJ16PSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhdutFj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E2AC16AAE;
	Sun, 23 Nov 2025 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915627;
	bh=0RZXGgLP33kPAVG5XMhUd63mdtBAEBI/Q9v+b9EN6Og=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YhdutFj7qYPrqbgKyo/HFiVRhMDJ9Jz3bS2Stnetpyic0L7L3RkZgI8SZomYqPw12
	 SeRtKmWHA8Pxs4URInYvguz489nQRkbOq/qzjNec+S+kGgge5/7bfu59D3n9Uz73DX
	 RGLGUaXrDPehAvccx4FClIBF+LiG71HEUNIbbs9pKO1c/OWWrhevUqAJUazjT0ZwJE
	 7RPzQMEIHLY9dPrsF6LhE7uae/wYOjgWrAPHjVMsVDHBGf8Tt6p7sRzjP6uzSI5Fg2
	 M1gPStd4z5Z3TQvZu4+NLWulyfnDwlH/ffcw0G6ask1iwQKO/tKYua1qHqk0bTftVX
	 jMirwIIg2Fpgw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:24 +0100
Subject: [PATCH v4 06/47] namespace: convert open_tree_attr() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-6-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0RZXGgLP33kPAVG5XMhUd63mdtBAEBI/Q9v+b9EN6Og=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0ca7H4gf1EtP1Stq0B8bp3QuzvF/rXxfyO781gtZ
 uw58kGzo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKvdRgZlpRWqfPekHn1fPY3
 Fr87557vLNrhcf6k05cd2y11p/beDWRk+GewmqvzXaKG5YakC2YukyZXrunfn/M18lRcosPkhex
 BjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3cf3fa27117d..0c4024558c13 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5023,19 +5023,17 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		unsigned, flags, struct mount_attr __user *, uattr,
 		size_t, usize)
 {
-	struct file __free(fput) *file = NULL;
-	int fd;
-
 	if (!uattr && usize)
 		return -EINVAL;
 
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags));
+	if (fdf.err)
+		return fdf.err;
 
 	if (uattr) {
-		int ret;
 		struct mount_kattr kattr = {};
+		struct file *file = fd_prepare_file(fdf);
+		int ret;
 
 		if (flags & OPEN_TREE_CLONE)
 			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
@@ -5051,12 +5049,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 			return ret;
 	}
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return fd_publish(fdf);
 }
 
 int show_path(struct seq_file *m, struct dentry *root)

-- 
2.47.3


