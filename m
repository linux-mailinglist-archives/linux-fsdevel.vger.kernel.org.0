Return-Path: <linux-fsdevel+bounces-69546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5BC7E3EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8248C34A1F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028502D8360;
	Sun, 23 Nov 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGCCsaak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DF22D7B5
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915667; cv=none; b=sXJ/5awP2Y1SzSKm0A3Eksntm9RikZuUWgEBeu83282Z2cDG7VH2/peDWDgV9O1hW9svAQWwNtRMB+pUGVvZrlSDvG+vrrqP+diFeqH2tE5x6i60M1aE9Ao+DiiYW4Ki55v+G6OGeighkMHzoZnO+zkPxVwQpPubiyLKRuuqzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915667; c=relaxed/simple;
	bh=iEzqTorNUOdR04JOrP+Ou9XmBTpZeFNFw3L7sf8/Zxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xy5DrQLg63PyTIosWXT9M8Fx4x/S8wyjfbjvWdLxSeU5NxnYtvIgFTTRH09b0Dt1wz47pxKdYpp8SxjSNI1SEqYHXacKuXj4FhKZKMO9lnHbpOB7fbS97sz5GybVWcCxPhbiR9FUfsjeG1sGRXUmpg0li6wBlJoFYeZ7FSOMn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGCCsaak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8EAC19421;
	Sun, 23 Nov 2025 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915667;
	bh=iEzqTorNUOdR04JOrP+Ou9XmBTpZeFNFw3L7sf8/Zxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGCCsaakXAsETxpsqrN3oMAWBZqL3wWxY2Ubd+pJG09WNZ7q58WlBVvrpSsYJ/tFG
	 QRRcqLue8QmozKYgn6hVWmGVGpH6bOpdpCIPUXEu1U/c5zmUPrvOBjodQcOMlxLJc5
	 hsY/jSUJ2YOOrJeFqfgAgpSgPPYDHNKOVwEjzAK8hlIzn5x9W7pXvr1Yqz56mE98Z/
	 ImqXoCoj3mQcwXk3/nL9pJ34BPZE1vo96uilFO0yCuFxNjxahM34N4vhrTrN2M53X4
	 luihXYYMqN/94Oka6F/DnKfY9HU2N2TBc35Fwthogm0nvX5poTUWuGBmR8uVL9a546
	 a3czqbRj49Ubw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:42 +0100
Subject: [PATCH v4 24/47] bpf: convert bpf_token_create() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-24-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iEzqTorNUOdR04JOrP+Ou9XmBTpZeFNFw3L7sf8/Zxc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0cJ87W0WXxT8Ptdetnu7BGXrgLTnB92Fe+ecV1Ns
 p2sF3Who5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIr1zD8L624qntwhQ/zwacP
 k/N9el9NlVpyObaW3Uf9o8edg80tKYwMcxKd7PyUUuRifI4dn3TV9FNQ/tPbC5zmnXl+cPrxnvX
 7WAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/token.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 0bbe412f854e..feecd8f4dbf9 100644
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
@@ -166,23 +165,20 @@ int bpf_token_create(union bpf_attr *attr)
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
+	if (fdf.err)
+		return fdf.err;
 
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
@@ -190,24 +186,11 @@ int bpf_token_create(union bpf_attr *attr)
 
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


