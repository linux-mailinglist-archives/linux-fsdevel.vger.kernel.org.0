Return-Path: <linux-fsdevel+bounces-69305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430FC7685E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 168064E571D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB4314B83;
	Thu, 20 Nov 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV0PihmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD022ED873
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677989; cv=none; b=jwEPZV7u2rWWLBAZv8+1tswUZUilf4N5gwQOuB2kbsnO3tcwRlB1kEQkAqVp5skRzizC3tuBlWTrmBq7lTXop9ls6XCmGTj+hoycnOvzmjz7C1pVevutgzIrXquhM5h+eXEJDAYhPjpIIuGkQoSeOaQvbbacTIXpeLgDn9eR63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677989; c=relaxed/simple;
	bh=Bxgbkxy3cykwNVu7i51y1yBJK780UCDda7ApbdBQTDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sg411HfHvQoYr3NsSenBnCg7uuD5Z682IarIH1xnJrQ9g7PGt9M8CLeRfrrzrpqGBCVddVZk5X6HGRtSR76HMFuPPFHBc6yb8hCGAHZOKNlZ1s/T0DXfkolaqwu6svxMyAPsvSKoz6FWxafORlkVtbz69CGY2jO7UPtApG3u2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV0PihmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C5EC116B1;
	Thu, 20 Nov 2025 22:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677988;
	bh=Bxgbkxy3cykwNVu7i51y1yBJK780UCDda7ApbdBQTDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lV0PihmBepa5bGImQowTvBCrx4jiucPIYN7fADAMMXEHK3s7Us3vdsboDlXh+VSsJ
	 jUW6V64JlGxAxrBqrDlTNWwIV26M6JZRZOStoe2YsQ5FBCDBCC8Hhu928c/j5OJ4Pj
	 EeSOJcOFRCH4dZ4cVhxVKxTPaTbcSsC6W4Ypvykkcy/3KnOBvr3/a3xdYIGGQ6kvR4
	 MvYEWAzv55XAnCCtzSXjX3onDLW62FmiWfnSWRAMB4M7FvYf4U1EcvePhiZwXbzX7W
	 T48bbq5IOkfCRE5qIkJ46Kt62jlSTefF/dXSYkOjWZAlc+7ndxxBpms0xITXszyV/e
	 DoT4rIv72JSSg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:22 +0100
Subject: [PATCH RFC v2 25/48] bpf: convert bpf_token_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-25-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bxgbkxy3cykwNVu7i51y1yBJK780UCDda7ApbdBQTDI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3ur0rpqL2vPjmnhj5w2fe1kdeffp73xorPSxfstd
 RPv13se7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpS3DP80zZVe9N6rPlPra
 HSE6YfG5+827alhDtA08z/DWBUhdN2L4n9cVOyVkpllJcG4rd5Wr+8qQ15Unja4xTPczuzD9xKV
 r7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/token.c | 80 ++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 0bbe412f854e..fcec0f6d42fa 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -111,16 +111,14 @@ const struct file_operations bpf_token_fops = {
 int bpf_token_create(union bpf_attr *attr)
 {
 	struct bpf_mount_opts *mnt_opts;
-	struct bpf_token *token = NULL;
 	struct user_namespace *userns;
 	struct inode *inode;
-	struct file *file;
-	CLASS(fd, f)(attr->token_create.bpffs_fd);
 	struct path path;
 	struct super_block *sb;
 	umode_t mode;
-	int err, fd;
+	int err;
 
+	CLASS(fd, f)(attr->token_create.bpffs_fd);
 	if (fd_empty(f))
 		return -EBADF;
 
@@ -166,48 +164,40 @@ int bpf_token_create(union bpf_attr *attr)
 	inode->i_fop = &bpf_token_fops;
 	clear_nlink(inode); /* make sure it is unlinked */
 
-	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
-	if (IS_ERR(file)) {
-		iput(inode);
-		return PTR_ERR(file);
-	}
-
-	token = kzalloc(sizeof(*token), GFP_USER);
-	if (!token) {
-		err = -ENOMEM;
-		goto out_file;
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
+				     O_RDWR, &bpf_token_fops)) {
+		struct bpf_token *token __free(kfree) = NULL;
+
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+
+		token = kzalloc(sizeof(*token), GFP_USER);
+		if (!token)
+			return -ENOMEM;
+
+		atomic64_set(&token->refcnt, 1);
+
+		/*
+		 * Remember bpffs owning userns for future ns_capable() checks.
+		 * Delay taking a reference until the security check succeeded.
+		 * The userns can't go away and we can just rely on automatic
+		 * cleanup this way.
+		 */
+		token->userns = userns;
+		token->allowed_cmds = mnt_opts->delegate_cmds;
+		token->allowed_maps = mnt_opts->delegate_maps;
+		token->allowed_progs = mnt_opts->delegate_progs;
+		token->allowed_attachs = mnt_opts->delegate_attachs;
+
+		err = security_bpf_token_create(token, attr, &path);
+		if (err)
+			return err;
+
+		get_user_ns(token->userns);
+		fd_prepare_file(fdf)->private_data = no_free_ptr(token);
+		return fd_publish(fdf);
 	}
-
-	atomic64_set(&token->refcnt, 1);
-
-	/* remember bpffs owning userns for future ns_capable() checks */
-	token->userns = get_user_ns(userns);
-
-	token->allowed_cmds = mnt_opts->delegate_cmds;
-	token->allowed_maps = mnt_opts->delegate_maps;
-	token->allowed_progs = mnt_opts->delegate_progs;
-	token->allowed_attachs = mnt_opts->delegate_attachs;
-
-	err = security_bpf_token_create(token, attr, &path);
-	if (err)
-		goto out_token;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto out_token;
-	}
-
-	file->private_data = token;
-	fd_install(fd, file);
-
-	return fd;
-
-out_token:
-	bpf_token_free(token);
-out_file:
-	fput(file);
-	return err;
 }
 
 int bpf_token_get_info_by_fd(struct bpf_token *token,

-- 
2.47.3


