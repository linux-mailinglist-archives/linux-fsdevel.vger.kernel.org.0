Return-Path: <linux-fsdevel+bounces-63973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503DBD3E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01759400CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C030AD10;
	Mon, 13 Oct 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNLk5C/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31430AAD6;
	Mon, 13 Oct 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366900; cv=none; b=JrZFmNGfOsfU6gwmPQBEQIdyITR2GBcLwPm25mNVwyuUnQqus9OAsFimvBR8rUyng1+Hkm1sBtNg6lNsXyLmbn4YLa5kZ3mxQjat2J5kFLbV7KRu9gd0qPqQs6MfoVId4rnzcYqM7Dzwpu0hgRhLLzsg8RObirvmjd0Wx685snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366900; c=relaxed/simple;
	bh=8uRrXI+jAp2WOh+hrCQ/nfUXhlceOD4BPQxB/TDmaSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4cmQdN6yo+5dR7W126OhZR+wUbggGvZ/yaYSnuuvuzsdO5iLiizkCZdhraQUXyDQs1ieTDPe2CVdMHKSz9PksOy6fLHFOP+1Z25zotk2vKRNitnqdkaPyKeQrdL5frexmY05hbsezhRo5cjYXunHA8uI8kF9S6R12yBg3H+iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNLk5C/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DDBC116D0;
	Mon, 13 Oct 2025 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366899;
	bh=8uRrXI+jAp2WOh+hrCQ/nfUXhlceOD4BPQxB/TDmaSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cNLk5C/jKcPgG8lJYqdnbMfSauyIpT6pFOljy+VPSW/otrZrnuqylgK87eVQiRpv0
	 I29L/vEh6ZobwHebArqgpuMnCVdGOfiIlYZvFFSKnuFIqQibcOl+wrPUWFwdBN28X4
	 //QR5TNjEXhkc6OW2qkBgdXWYYFLFmflOa4Q3vbfxy0IaIoh/iNQVmzT5Nk3klWWdk
	 5H3rdmiRMSaiAOzx/2YYSSCBD3ocuC/yXd5kkqoGwMzt2foabFyGUczL9gYiHFHHpx
	 e58f89K2iS+b7010jl/PUXActNZqkYcjaoauIbp9+JJHAin8z7cYCZbxvk6h8k//lF
	 tzCcKSx84lzwQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:47:59 -0400
Subject: [PATCH 01/13] filelock: push the S_ISREG check down to ->setlease
 handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-1-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8uRrXI+jAp2WOh+hrCQ/nfUXhlceOD4BPQxB/TDmaSY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REpusIvVkARYUoHp93zRS89i1Rksr6uyeczG
 +t7MEXFsB+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKQAKCRAADmhBGVaC
 FQ4cEADMRSRph7CppQp10aXJ9lg3lIQsFj3LcY1koZinnhvIKf7ZQSGqK/SqN0HGDe+CMWrxTta
 GJO7NyX4PNBG42TVhKRPv4lhYCkkae+ZjqWMibiOCQNrP8c8BfwskFjxeeMBHBQOj4TEu9j/bdk
 tEAbp4jXxLRD979LmGwDCrwxUxYk4/fL4jjBKSXr7oZvBqnnhJqe5IUfy9iuTaRao5GqRpO50Wq
 E6Zl7jm4l8LnJyKmSLT31wx+RvxkenuU+gZd8kAA/MOhct0cKufE/eDUC7XBVKQYaX0COoKIKqb
 lk/mqk9z5bBDzmvuGHqfsrSeSl1HPytENzaqMFxLKIoeKC3gmhJeyyvpP7HWj5mXOsO4BGApKA1
 h1WQD1C7U8j2IZhHhY9Ci9dVHMd20HIl2qoPhvODGCrvVfNa3aF6bC4QUKwm+wSmbUabowYkxz6
 rnLuMZ4eZq2RgCvHJh2oonB73Llmde3pJeVCnlq4Fyu3pgZW7OsEROEg1NZSO0O1o6+sF5hfnuT
 ER1S2qOD3Q4alUYCWTkIv5n+6aFZvtRm1W3sYtNK4p9/TDXeyIGl3WmvV/6xjg1xTJ4hqTOwByb
 rZD3eRjxWe+Ko/F+Lfb2wINatKLNnnUx0hlFtSPUI4kHHg8tTui2taJv3DdZyxBwJRdK/6TC6ib
 x0ICQEaFoT8p1Nw==
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
index ecaec0fea3a132e7cbb88121e7db7fb504d57d3c..667774cc72a1d49796f531fcb342d2e4878beb85 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2230,6 +2230,7 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
+	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..0b16921fb52e602ea2e0c3de39d9d772af98ba7d 100644
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
index 7f43e890d3564a000dab9365048a3e17dc96395c..7317f26892c5782a39660cae87ec1afea24e36c0 100644
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
index 05b1fa76e8ccf1e86f0c174593cd6e1acb84608d..03c44c1d9bb631b87a8b67aa16e481d6bb3c7d14 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1149,6 +1149,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
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


