Return-Path: <linux-fsdevel+bounces-24567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DFD940777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97485B21E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1211A00C4;
	Tue, 30 Jul 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUD4jSK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B419FA85;
	Tue, 30 Jul 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316520; cv=none; b=teVoDjr9DHhqt//gf0hb/NYwaDhjk9oNg7Gsu3QhnqL7nC6apG257B2r0YSzwxo8UqDslgehXnqX5G+g+R+R6F9ns5+InZ6Cpf/yFzq3lldpIPrpHwyci/duGgMQPn5PSGNg2Y25mSjtaMX/vd6xfZ40h8Gfj1zYB16z+qlXD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316520; c=relaxed/simple;
	bh=w7ZWUToN2aMnwOQUo1I5gRl/0RWWMx4chuQE47AftYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSOZVBslud33lThOibFvSsIwJ9Fy3BaLFRE50Q5nCHn/q85NSvFs/fVhG8XMKyKFYrDKMCI7vkYZnKnANWQWl8ZYCprE8/NTStNUX/k5VMZLT1Nxt8+v9StWA4XiTvl4HWyO/czb49brFxjogKJ1xGlRrS6ZV8fUuANew7wdTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUD4jSK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03486C4AF0A;
	Tue, 30 Jul 2024 05:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316519;
	bh=w7ZWUToN2aMnwOQUo1I5gRl/0RWWMx4chuQE47AftYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUD4jSK2g9ZgDg4iUV6gqI73Ro+HWI9w/NODCaBNQtVkDAfdS4+qLi+yQL2qfUVdM
	 sfsQECEVywRsGG/P9HkVg5x+bTPwBy6rn4xBknJ3mM1Wc5ZqEHtahjoMY9OlYXKECL
	 2+5qVorpRjoizlYV/3tOnbHswHL1BI3PzgFVf4ornlchFtnwmfpPfFPQVaxIkb3hIL
	 xo8Njz9/Qibc5zoTW6zVfIOQtgq1TlvQzJJgEf02cdGP+QSiCLmaOPm6pbMZK3pfCw
	 ZWA6GZ6+m1haSDKCW0XAvh3Q/DnGJu4LvJjmEIqkPtw8npytGoKfk7nXGpxKThev5P
	 Hid5Rp4KRjDNg==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 35/39] convert bpf_token_create()
Date: Tue, 30 Jul 2024 01:16:21 -0400
Message-Id: <20240730051625.14349-35-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

keep file reference through the entire thing, don't bother with
grabbing struct path reference (except, for now, around the LSM
call and that only until it gets constified) and while we are
at it, don't confuse the hell out of readers by random mix of
path.dentry->d_sb and path.mnt->mnt_sb uses - these two are equal,
so just put one of those into a local variable and use that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/token.c | 69 +++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 9b92cb886d49..15da405d8302 100644
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
@@ -205,7 +189,9 @@ int bpf_token_create(union bpf_attr *attr)
 	token->allowed_progs = mnt_opts->delegate_progs;
 	token->allowed_attachs = mnt_opts->delegate_attachs;
 
-	err = security_bpf_token_create(token, attr, &path);
+	path_get(&path);	// kill it
+	err = security_bpf_token_create(token, attr, &path); // constify
+	path_put(&path);	// kill it
 	if (err)
 		goto out_token;
 
@@ -218,15 +204,12 @@ int bpf_token_create(union bpf_attr *attr)
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
2.39.2


