Return-Path: <linux-fsdevel+bounces-62619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D564FB9B2D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B64E53FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF931A561;
	Wed, 24 Sep 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/pB2CFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5113319870;
	Wed, 24 Sep 2025 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737178; cv=none; b=q7Gb8ojG2viJ4pecwC67DOEoJEB7AZAsRWq8V3oAdt+MSMI/A3HKaSGa0HKMDOZsd23ye2VdzrascYI5czNbwQzxV70eun/rkmofWzZHQDv9dkzKn9vbUoDQwdTBUJxL+yca6TWhRiE66KjuXvAg+9orFLhu3uMp/JV21vZ1JK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737178; c=relaxed/simple;
	bh=9AjT+AaiaX08nvR68ixQA95zs9kkNi9YWMeGZ1kCmxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiNOUDZRrQ6D5z2wNnW/ltU0w+E1aFnqh9sLE7xVrJN90jTeSgZqUAYQ8LqkMPlUPshM4BQf+xL+luI0iZn1ZIz1JKgSYhdQn4dW+Nn3UnezQJ9LQNEsw+CgeuBvoCf5Wcle8yAmsgR1Bt4FLLVyCoJrStGNeTrWf9F/PxlRThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/pB2CFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8945CC4CEF8;
	Wed, 24 Sep 2025 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737177;
	bh=9AjT+AaiaX08nvR68ixQA95zs9kkNi9YWMeGZ1kCmxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n/pB2CFBo8rYTRAZJacTV0AIDBdAYNN5OTRLB18LcUNYl3rMTYVbpE6+hfKhyRv32
	 DuaS+Ne2c8Ry2MG0Kfhw8fsyT5JWNYTlsvX5E7vM1z+Qje7EysixHhk9VoqZea7kpr
	 Luq+6YfOgj6n9Lm0O+x2orC2hGn290NtrblhUiL1h8Jv02lGHFCFzh7WuNQ7xcGtde
	 0w3r8EvkuhmLwD8YZDU661ayeT0X9ClVFoqw4C4dH8FTN6iBAwznQ0kWgIUegXf26n
	 m1hPegc5zKxy/qaa08YUCl+eMap3OwBM3+MTUNOAhL60/GWqVZxUyAxT7hN/IKNK06
	 L2ZN7GP5t5UIw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:47 -0400
Subject: [PATCH v3 01/38] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-1-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9AjT+AaiaX08nvR68ixQA95zs9kkNi9YWMeGZ1kCmxM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMKr59GADeYxKPNjlIm1EV6Jv5cIvUNmjtX6
 Xq1/mXwVT6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCgAKCRAADmhBGVaC
 FVeFEAC26OjBODxK1pK6z302+VDbd52gX7EgjpEk+diPyOcbL/M3qy+XQQv0UoKDGXKHuiSXX3h
 xLtBSVm2/MoFYTMov961lYMAD8JfTXNgBtwhn0QPU6V1QaGN6mbtmXLNOA88uKdwM/eQ8p6CwvA
 O9ShhO96oGYW9UWqjF8OT8HRBugiz8zPAkuRY+56aDgWeZ7BedfAr0zwjDaoACg9GjLAY2EJs8w
 Ji3j/r012TbLUp5yAOvwe5ato1WdgCA0W9Az6+dCnRH8xQuGAQ0P5Fjl3BE/Nf7A9EnKl8ADvPW
 4TrrCqz7YHhVY/xzxkJQsuSaCy/w3HF35Nq0HzFBjCT+AP+m5vA0V19F48mL0kMZXn2/LVoOGLN
 20xd74gD7q0NDldMWlcT7BLG9qJ6ffkjBxUJRXDjtt1YpakKhZhRTmArGhF4pCS+5RxsZ34cB4d
 ovSFxjRnBelWMNvB+22dl3oy0ypf5ZqM91QgNgJ2DWnRvtAPssAoYrbFYKot332NzgM1B4Pa0n8
 XrE0Nw9s/QrQL7G6Cw8dLER/ezoW7PGPI4hUD3rJdou5GEyrYnmCcLHTwCaV/sA0hsDPVUgr6rW
 4mgeMMqPV8QJ50elqkpZkKT+Yg9PjJy/Mew5yTHF8apX0Mg6MeYUpSPhmquuTC/DR7f71GYINHw
 SlcKvE9snSs7i3g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When nfsd starts requesting directory delegations, setlease handlers may
see requests for leases on directories. Push the !S_ISREG check down
into the non-trivial setlease handlers, so we can selectively enable
them where they're supported.

FUSE is special: It's the only filesystem that supports atomic_open and
allows kernel-internal leases. Ensure that we don't allow directory
leases by default going forward by explicitly disabling them there.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dir.c          | 1 +
 fs/locks.c             | 5 +++--
 fs/nfs/nfs4file.c      | 2 ++
 fs/smb/client/cifsfs.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f3d20a9f284124dee657fca5ffc9a..f5288eef5711dca46e78ef6b784ae78737e92201 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2237,6 +2237,7 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
+	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/locks.c b/fs/locks.c
index 559f02aa4172214a14d907b7bc090c1a9235967c..edf34b9859a16c34dd75ce4d1a6a412dd426c875 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1929,6 +1929,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
+	if (!S_ISREG(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -2018,8 +2021,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 
 	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
 	error = security_file_lock(filp, arg);
 	if (error)
 		return error;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c9a0d1e420c6cb17b209e3f7f48a12dd479dbc24..730e04b8a768debd34ec0c97a0cf0c44f1c18de5 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -431,6 +431,8 @@ void nfs42_ssc_unregister_ops(void)
 static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return -EINVAL;
 	return nfs4_proc_setlease(file, arg, lease, priv);
 }
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e1848276bab41364f894f5f92d7ec08f343aeb1c..8364eed8a246bef43a10bc4078906d8a9aaf26fc 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1093,6 +1093,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||

-- 
2.51.0


