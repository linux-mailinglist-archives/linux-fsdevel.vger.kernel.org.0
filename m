Return-Path: <linux-fsdevel+bounces-66785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7CEC2BED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A1A42045C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D19314B93;
	Mon,  3 Nov 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ODCFN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85626314B63;
	Mon,  3 Nov 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174405; cv=none; b=riXtg30pd5l/sRUzuE3Cmnu4fPwa2Qs2hYh0F3TaV8GMf3STEDdsw+bSkcYJ9rmkCkUrDVMXEm1sKuvqX1nwwFJ/YG/sCkXVzFEzUF9JwEG33dD7g7nRd72uTP5SaIFTxDT4IAaidF/Y8NXnTge1kL2Lj0wgft4hov+LYf+YNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174405; c=relaxed/simple;
	bh=F4WtZaIk8X3USLdxrQ+aGC/g5Iz1UkZTcUMEmpFW0Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=No+FuvUZNX0x+0TIQ+mrZ7oWeXzTYaemY6HO0kQB5AMWSygY/zHNaE66LWjWd6h4OwZaWBt+rKEJ3ZuK6h6pUImz88LgXfMOY3aNnAn4IHrmKzqv56pkZNf6sA0iCHbqlSi5CZlAKegveYB/6B/MGcyQNhdHSizNuOqC9HIX9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+ODCFN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE8AC4CEE7;
	Mon,  3 Nov 2025 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174405;
	bh=F4WtZaIk8X3USLdxrQ+aGC/g5Iz1UkZTcUMEmpFW0Y4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K+ODCFN6I1BklSu5/DL83mSHkeKlpinDlIOMys+FtYVpLuA//bqfybPz3E6+Ns/bl
	 6nmeSBpa4MEghIFGFoa0+sw9o62g2v6iiY6jBZzL8uEtSU3TDsbMBr+0n2S/U1L1Po
	 QeexrPQ3tVf7Iqr0L+ujMVd0E6NvNN0NRBaL9S5JmTloAvSj7Kyo6HKVzCG+SPLoap
	 5zXMd9IS7IjqTEylKv6pXQhEIIUdu6X/pVrRONzp2BKeWDN3z6tv+e+nfAzwTQyE+c
	 lIdZcoe7bdBmAUy9CjMMFyhEwlP7ZZ+iM366Ude4/FIuth5dyKaGmtMP6CE2cQVEF/
	 FapauIFaH1sZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:38 -0500
Subject: [PATCH v4 10/17] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=F4WtZaIk8X3USLdxrQ+aGC/g5Iz1UkZTcUMEmpFW0Y4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWdOJgsy8BidAoueXGiHed+Of/fHh9OsDTyH
 Cn2Z5eDBgiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnQAKCRAADmhBGVaC
 FWy/EACvFNMQGKPhqCrxadwV+eLgpp4fp8aG3Mj+VGe/hmrBFwhQiBQyc3aRkDAfrx2BOWR5bfl
 Auox/hpZUTj683sBgT43hAl/22/7ff/KanIFRdlPpsg9rJBWxvLbTe37NwM2ofricWPD74vS4YZ
 4kkE6MLoKzaF/TxkVpaKlEpTQu6PJqxCz+o+bG9YWwjo7fcOjICKNcOFy7+0kdUd3tYpTG1ZJg5
 1wVRhOxcQoSobdsMoIVSsEWBhDWSvN4GIhNtF7wXsho2l8D4dWPgAQz51zXo25nZMYwOFQwpvgY
 SrgDsz1bW5ObNgAZNxadlgq5jOAFT2sF2w0hoATd5YbvCOr/y35I2GzlE7hF1z1SLQbaoVffPwK
 ToCD4kPVkC9AOMcq//xHJ7W8t1KL6xCu152xMEKyRu/5mVZyhmXcL9+awgpbE7qtvvDZSj3cqXj
 /e0qx1/igFU+vgYahAH6SdPksX+MoO8B1wWnvS3E+5VpTf3C7H4pCsUr3T+ASjtYSIi8gKBr7Uw
 CXWB2ytG5aeJgtyCQS0cYNqD92jWIBZBBCk1bvpj9gZNCC7SZSmj+pbVPx74HboFdAwkVG9L0Wz
 wGqms6MRXt196LMJSdYg0mkzKxe3tIa2xG7/hfvUeBXbPC7x4ZZe2WzICxjuju3Ng1pPo2yz80U
 DDf9xjOt/ptbRaQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to struct createdata. Most callers just
leave that as a NULL pointer, but do_mknodat() is changed to wait for a
delegation break if there is one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c         | 26 +++++++++++++++++---------
 include/linux/fs.h |  2 +-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index fdf4e78cd041de8c564b7d1d89a46ba2aaf79d53..e8973000a312fb05ebb63a0d9bd83b9a5f8f805d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3487,6 +3487,9 @@ int vfs_create(struct createdata *args)
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, args->delegated_inode);
 	if (error)
 		return error;
 	error = dir->i_op->create(idmap, dir, dentry, mode, args->excl);
@@ -4359,6 +4362,8 @@ static int may_mknod(umode_t mode)
 static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		unsigned int dev)
 {
+	struct delegated_inode delegated_inode = { };
+	struct createdata cargs = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dentry;
 	struct path path;
@@ -4383,18 +4388,16 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	switch (mode & S_IFMT) {
 		case 0:
 		case S_IFREG:
-		{
-			struct createdata args = { .idmap = idmap,
-						   .dir = path.dentry->d_inode,
-						   .dentry = dentry,
-						   .mode = mode,
-						   .excl = true };
-
-			error = vfs_create(&args);
+			cargs.idmap = idmap,
+			cargs.dir = path.dentry->d_inode,
+			cargs.dentry = dentry,
+			cargs.delegated_inode = &delegated_inode;
+			cargs.mode = mode,
+			cargs.excl = true,
+			error = vfs_create(&cargs);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
-		}
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
 					  dentry, mode, new_decode_dev(dev));
@@ -4406,6 +4409,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	end_creating_path(&path, dentry);
+	if (is_delegated(&delegated_inode)) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b61873767b37591aecadd147623d7dfc866bef82..cfcb20a7c4ce4b6dcec98b3eccbdb5ec8bab6fa9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,12 +2116,12 @@ struct createdata {
 	struct mnt_idmap *idmap;	// idmap of the mount the inode was found from
 	struct inode *dir;		// inode of parent directory
 	struct dentry *dentry;		// dentry of the child file
+	struct delegated_inode *delegated_inode; // returns parent inode, if delegated
 	umode_t mode;			// mode of the child file
 	bool excl;			// whether the file must not yet exist
 };
 
 int vfs_create(struct createdata *);
-
 struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
 			 struct dentry *, umode_t, struct delegated_inode *);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,

-- 
2.51.1


