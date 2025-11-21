Return-Path: <linux-fsdevel+bounces-69422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FEC7B33A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5386381B19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1A1AF4D5;
	Fri, 21 Nov 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaQpE29p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA750350D70
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748102; cv=none; b=Vxm8h8CoZjx1IuEwNUAL/tSyENH5PNQliT9yWEhDI/iHioTkr4bTzmY7NDxh/7+e8rmME6ML6Xl1DS8R7JEPo0GOyT0Tt6/sna1sjxXktheUQw5iSaMZTn69IKJ5mdcE/OhDClhHOSgUHzu/IjAn9EpFDiI6x8HKEopKn3HQ+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748102; c=relaxed/simple;
	bh=PC24ZgV5Mco6Ssq4YwBR5MYDMin5sxflJX1dym0roJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHkNRVbq5YTKyx9PBjphAZrCSjP25GBkW1IscOdgLwXRj2ltbK1l27Chv126rSbujJ/qu40KlP1U5sn4cEpXOMsd9QUhTh2vieuFdK4wHfslvHZC2hEeESeT3Ok95rDzo3UQKi5JJgJj2CVi9ka/3rjzWjpZS921N+6bWcVrmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaQpE29p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC43C116C6;
	Fri, 21 Nov 2025 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748102;
	bh=PC24ZgV5Mco6Ssq4YwBR5MYDMin5sxflJX1dym0roJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qaQpE29pyKm+c1fPIQ07VdovvQyPoy1F0N7LBRCWxj6espTXqhNKmhwJLh2SydLBX
	 WTPmu3s9hVs9OITBGYfEkdMowzFkpAAvhkQM/m9gWWXfBMsXWk7uBPC7hxXEXrr2f+
	 +rTb7C4jPJsHxwLM6bassbf1aNw2jv8XGqZvaWsYzE+Vty9UJH0CbKzGijCWiWDzE/
	 ou6KH/fcO7QtNyDh/Om4ds1zvx2aFcU0R4i9TlkbTgvTuILvUXRgebqVQIjumJzxL4
	 +p8ZX6qg0R6dD4SCUgjKTKdixMrgIcr1NnfSC1GIZnUz7UEEzSKe49ov236bQfQjeD
	 1eY2aYrlmFvMw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:03 +0100
Subject: [PATCH RFC v3 24/47] bpf: convert bpf_token_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-24-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PC24ZgV5Mco6Ssq4YwBR5MYDMin5sxflJX1dym0roJM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjA9DwoZaHg9ltfLzRuyllZ/CAl6XY0bzHP+s7nX
 Se4zl850FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR1SUMfzgXM4blB04/X31E
 OPKUztPLmbfiZzfv/11p8nXpKb/95ksYGaZOWR99irP8brW1yjH3H+HCwd3S97bduJHxxTE/dvL
 5bnYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/token.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 0bbe412f854e..100afbe17dfa 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -110,16 +110,15 @@ const struct file_operations bpf_token_fops = {
 
 int bpf_token_create(union bpf_attr *attr)
 {
+	struct bpf_token *token __free(kfree) = NULL;
 	struct bpf_mount_opts *mnt_opts;
-	struct bpf_token *token = NULL;
 	struct user_namespace *userns;
 	struct inode *inode;
-	struct file *file;
 	CLASS(fd, f)(attr->token_create.bpffs_fd);
 	struct path path;
 	struct super_block *sb;
 	umode_t mode;
-	int err, fd;
+	int err;
 
 	if (fd_empty(f))
 		return -EBADF;
@@ -166,23 +165,21 @@ int bpf_token_create(union bpf_attr *attr)
 	inode->i_fop = &bpf_token_fops;
 	clear_nlink(inode); /* make sure it is unlinked */
 
-	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
-	if (IS_ERR(file)) {
-		iput(inode);
-		return PTR_ERR(file);
-	}
+	FD_PREPARE(fdf, O_CLOEXEC,
+		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
+				     O_RDWR, &bpf_token_fops));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
 
 	token = kzalloc(sizeof(*token), GFP_USER);
-	if (!token) {
-		err = -ENOMEM;
-		goto out_file;
-	}
+	if (!token)
+		return -ENOMEM;
 
 	atomic64_set(&token->refcnt, 1);
 
-	/* remember bpffs owning userns for future ns_capable() checks */
-	token->userns = get_user_ns(userns);
-
+	/* remember bpffs owning userns for future ns_capable() checks. */
+	token->userns = userns;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
 	token->allowed_maps = mnt_opts->delegate_maps;
 	token->allowed_progs = mnt_opts->delegate_progs;
@@ -190,24 +187,11 @@ int bpf_token_create(union bpf_attr *attr)
 
 	err = security_bpf_token_create(token, attr, &path);
 	if (err)
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
+		return err;
 
-out_token:
-	bpf_token_free(token);
-out_file:
-	fput(file);
-	return err;
+	get_user_ns(token->userns);
+	fd_prepare_file(fdf)->private_data = no_free_ptr(token);
+	return fd_publish(fdf);
 }
 
 int bpf_token_get_info_by_fd(struct bpf_token *token,

-- 
2.47.3


