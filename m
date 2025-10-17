Return-Path: <linux-fsdevel+bounces-64482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCBBE85DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7234F6743
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91F369966;
	Fri, 17 Oct 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nazua681"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55743570BD;
	Fri, 17 Oct 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700760; cv=none; b=ld4DjwaG0A7WNp9YlCs3TrK5YJJsbPFIxLSGDFNo7xFYva49qmf+EXvf1SGGA8M9UwsqwTmIE20lCRAopZewOSHAxz1ZpHh+k7PWfj+3EodRazVSxfv6GcByRt1JJffbhoWbPsbq15eSWC4hBR/C4hiFsaU135tPmFV/5hAb8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700760; c=relaxed/simple;
	bh=D4Q1z5eeaVUO9Z+ECTf/6Zqc/vYd4ncdAUbJ5tZDhnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4poEgnrNCSqOvEs7Bv5rJNE2fupfvu2MUyqn7FMhVt9VVHo58VrnNnk7L+MtqHCq8pR1ARiGDKtk4k1P6S34lLf+NjaWrC1jzbRbhYL5WY8xLI45zsq5T51LRi20Fv+pz4mijXy2XRr0ZXwFCU13LX2YDxqz6ZmyVKOizp1BuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nazua681; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE66C19422;
	Fri, 17 Oct 2025 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700759;
	bh=D4Q1z5eeaVUO9Z+ECTf/6Zqc/vYd4ncdAUbJ5tZDhnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nazua681MDmxCfAADBeKoKoXjKBoTE5qTGtfKw5xWgCx3wo857DQiydef7HU7/sec
	 Hy+Cm4hWlc5ArNojD6Oygw8gujKQryeUuBAXBKVxYdHrFDGFBnvC37feBfsuFRbhMh
	 gEiTkexyBcWYN7a7lntnuPnbJsMc6yQ4w6i7AiBMcRoawC5AQ2W33pFFIr26RI2iuL
	 Iov0nCCpQlYF2BNhFfMiOc+Mi4KzPzb40twt1UF6TsqH3WiTVcFzK1PozieYXifn1w
	 SBykJR30X+dvOrI/6alzuQd2uYubameM/QqlVxYSPcRPQulSXonaAH5l31TNyUziOV
	 gYGsySYe9jQUQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:31:57 -0400
Subject: [PATCH v2 05/11] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-5-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D4Q1z5eeaVUO9Z+ECTf/6Zqc/vYd4ncdAUbJ5tZDhnY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilBNTnGzrb8DXfbDlwA6q/me4Sh1t39E3gG7
 zGkjXhAEWmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQQAKCRAADmhBGVaC
 FaZoEACN7N2X/NuqHDlhSOWJ++Tu6tmQYKHtTPY1W8zWpn6VLcXtNzK8NgaXqC6NGVTdB19mMlY
 yw50XHwCWIXtXty29UGSwOx+sZD69XNxcX+pjfd7Q0o3AxsBmvzKy4j3xJ9f6F/Yg0f7s2uWiW/
 YS29dMN5B1z76Up6V+OiquUm57pvKK9c9fsS660otGUXzbTPcEo/5Nqm7qLEpxgQnTa+5es2jrz
 4sEViVh/F2YfGNGGAzSg/nKSHajvY1y7ASdbRn81FGZKRTLHm1Lk5GbMKQ0CnYjT+KCugKT89c6
 B8UE+aUYMHUpo/yXUytMpo34s5j47InA1ZPOB02tfqYj6eMhsd7+9+aBRmnV7Km545EnKpHNuC9
 GQAmr1h1w85n5A+Z6/qrxcwkXIwli9LrB/ZT3HO7bDVQjqj6JwMenYnLTwxIkc1AjGVH2XnLWt9
 vMj5EkNMJ3DSpFqjw80PtWGAtoKmPNZ3DY6yYFPmK9k5TtJPLuFFpZcnxCkz7MQLRqCjaSsCz5y
 ZD0+bgyPsK4uF79e+yMZoUNidPPHKRMCTxHvagPBE+auNyogEOnwJgK7UdPcEG875wNYqSZqOQH
 1xUZFjBUXZRbVLdFijL1WGaeinMV9y/YIxIqP8sp/HHE5i9J4I2H1tnlnXpu2nbhxR3sqNKxvl6
 bX7IDi9vvmCWThQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to lookup_open and have it break the
delegation. Then, open_last_lookups can wait for the delegation break
and retry the call to lookup_open once it's done.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4b5a99653c558397e592715d9d4663cd4a63ef86..786f42bd184b5dbf6d754fa1fb6c94c0f75429f2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3697,7 +3697,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write)
+				  bool got_write, struct inode **delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -3786,6 +3786,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
+		/* but break the directory lease first! */
+		error = try_break_deleg(dir_inode, delegated_inode);
+		if (error)
+			goto out_dput;
+
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
@@ -3849,6 +3854,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
+	struct inode *delegated_inode = NULL;
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -3879,7 +3885,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-
+retry:
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
@@ -3892,7 +3898,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write);
+	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
 			fsnotify_create(dir->d_inode, dentry);
@@ -3907,8 +3913,16 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry)) {
+		if (delegated_inode) {
+			int error = break_deleg_wait(&delegated_inode);
+
+			if (!error)
+				goto retry;
+			return ERR_PTR(error);
+		}
 		return ERR_CAST(dentry);
+	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);

-- 
2.51.0


