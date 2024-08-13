Return-Path: <linux-fsdevel+bounces-25838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAA951048
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD251F2489D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F911AED53;
	Tue, 13 Aug 2024 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1KYjVtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887E1AED41;
	Tue, 13 Aug 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590222; cv=none; b=oK51qdH/0QT9yxrdiQ+Q47kZQiTkuNnRqzDKMhl1LL2G8na9CTYVSlf+w9Ep7DVLlEteo9nnyPcpctDDUFvcBahqmRHou9RyNTU1GSZs+//+DpTjf3kl67vwvIwx/9wRnvKC8Z7rMml/MQXO6kexbBgkNiygASQRoEyA3Dblyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590222; c=relaxed/simple;
	bh=3XLbwFQpkBOWGlLgFAKTYFBYzBTlmuWaksnaoMjeTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyS2Pb94dU25F1Uq/tNHWGIxH4NGYZb5ObAOMQAgux2Ub62EKKq75gJqgpfazsYXdxB+04FS+ndqloZEHfswiOu55DQUykIe28KO1YkkLql9MvQHHHqhw+YROarqkoxQHETiUBbQrRciXM5sH0a2Ww9gwy4InJGi3tePN9LlBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1KYjVtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C26AC32782;
	Tue, 13 Aug 2024 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590221;
	bh=3XLbwFQpkBOWGlLgFAKTYFBYzBTlmuWaksnaoMjeTH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1KYjVtxrodqI8+XHMOrUMRcWbNZ9s3p9JY+WMkUTRoXXtQx8gg3ynEkwACWXJQve
	 CH9o/xRHwaDm3pczmsHVNW/PfgAATK1vLpPMR/l3rcTMjHeyvAFyRepZbP5G28QGpN
	 2v61vz/+FYP/8sCsT9E1+3c2EVJsvSFNailBdU0CAm6r33eAd6mMpKGVbpMpsfN8St
	 v893GOf/cKT4j+XfoXYzU+eoVcMJWw2oBSwqd8xkXU1R1J4/IDxybJ+YnHDjaKNp2M
	 wGEmdDO1sFd+CtHnwRurPtj8dOxNf9NNMQRiO6cfWpQyBW/fezjvudtEeAPFAJKA54
	 lji9MR16RP64A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH bpf-next 8/8] bpf: convert bpf_token_create() to CLASS(fd, ...)
Date: Tue, 13 Aug 2024 16:03:00 -0700
Message-ID: <20240813230300.915127-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
References: <20240813230300.915127-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Keep file reference through the entire thing, don't bother with grabbing
struct path reference and while we are at it, don't confuse the hell out
of readers by random mix of path.dentry->d_sb and path.mnt->mnt_sb uses -
these two are equal, so just put one of those into a local variable and
use that.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/token.c | 65 ++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 9b92cb886d49..dcbec1a0dfb3 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -116,67 +116,52 @@ int bpf_token_create(union bpf_attr *attr)
 	struct user_namespace *userns;
 	struct inode *inode;
 	struct file *file;
+	CLASS(fd, f)(attr->token_create.bpffs_fd);
 	struct path path;
-	struct fd f;
+	struct super_block *sb;
 	umode_t mode;
 	int err, fd;
 
-	f = fdget(attr->token_create.bpffs_fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	path = fd_file(f)->f_path;
-	path_get(&path);
-	fdput(f);
+	sb = path.dentry->d_sb;
 
-	if (path.dentry != path.mnt->mnt_sb->s_root) {
-		err = -EINVAL;
-		goto out_path;
-	}
-	if (path.mnt->mnt_sb->s_op != &bpf_super_ops) {
-		err = -EINVAL;
-		goto out_path;
-	}
+	if (path.dentry != sb->s_root)
+		return -EINVAL;
+	if (sb->s_op != &bpf_super_ops)
+		return -EINVAL;
 	err = path_permission(&path, MAY_ACCESS);
 	if (err)
-		goto out_path;
+		return err;
 
-	userns = path.dentry->d_sb->s_user_ns;
+	userns = sb->s_user_ns;
 	/*
 	 * Enforce that creators of BPF tokens are in the same user
 	 * namespace as the BPF FS instance. This makes reasoning about
 	 * permissions a lot easier and we can always relax this later.
 	 */
-	if (current_user_ns() != userns) {
-		err = -EPERM;
-		goto out_path;
-	}
-	if (!ns_capable(userns, CAP_BPF)) {
-		err = -EPERM;
-		goto out_path;
-	}
+	if (current_user_ns() != userns)
+		return -EPERM;
+	if (!ns_capable(userns, CAP_BPF))
+		return -EPERM;
 
 	/* Creating BPF token in init_user_ns doesn't make much sense. */
-	if (current_user_ns() == &init_user_ns) {
-		err = -EOPNOTSUPP;
-		goto out_path;
-	}
+	if (current_user_ns() == &init_user_ns)
+		return -EOPNOTSUPP;
 
-	mnt_opts = path.dentry->d_sb->s_fs_info;
+	mnt_opts = sb->s_fs_info;
 	if (mnt_opts->delegate_cmds == 0 &&
 	    mnt_opts->delegate_maps == 0 &&
 	    mnt_opts->delegate_progs == 0 &&
-	    mnt_opts->delegate_attachs == 0) {
-		err = -ENOENT; /* no BPF token delegation is set up */
-		goto out_path;
-	}
+	    mnt_opts->delegate_attachs == 0)
+		return -ENOENT; /* no BPF token delegation is set up */
 
 	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
-	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto out_path;
-	}
+	inode = bpf_get_inode(sb, NULL, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	inode->i_op = &bpf_token_iops;
 	inode->i_fop = &bpf_token_fops;
@@ -185,8 +170,7 @@ int bpf_token_create(union bpf_attr *attr)
 	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
 	if (IS_ERR(file)) {
 		iput(inode);
-		err = PTR_ERR(file);
-		goto out_path;
+		return PTR_ERR(file);
 	}
 
 	token = kzalloc(sizeof(*token), GFP_USER);
@@ -218,15 +202,12 @@ int bpf_token_create(union bpf_attr *attr)
 	file->private_data = token;
 	fd_install(fd, file);
 
-	path_put(&path);
 	return fd;
 
 out_token:
 	bpf_token_free(token);
 out_file:
 	fput(file);
-out_path:
-	path_put(&path);
 	return err;
 }
 
-- 
2.43.5


