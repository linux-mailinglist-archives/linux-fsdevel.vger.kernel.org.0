Return-Path: <linux-fsdevel+bounces-67945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C1C4E664
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE6E14F5210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40927363C67;
	Tue, 11 Nov 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+JXl/qO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62576342528;
	Tue, 11 Nov 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870411; cv=none; b=R4L91U+5iWqwjNI6ZtUfGufYlTCjopukn1Tvan7zlHbpRHl6CI9TDGiM5UpxMgB5guwUOIDDpCYri+ld+c71XwZ7OHOfdC17kovhbaPoCgkb9S5zaFm+nDnexF5ucRNTfuMfe7g/lF0CuZeI/Ii4w4d+A/5+/rrSblk4NWwvGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870411; c=relaxed/simple;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUwigvQJVfysQ9GM2GTMlJsQziT3PTD1c6l/aeuR+1JDl6/2w3Ukm6c+JJy/yEAqqXkucRy/o6mycdGcZZUwMk3usRpT6Y9RO67W2ZhhcUK7vSZfTjzlwHtc0/a2HjZdUWdVM9PxKuXAPpTOSGDqLT4aoxLLVltghauoGCA2u+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+JXl/qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9007CC19423;
	Tue, 11 Nov 2025 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870410;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+JXl/qOGBjpG971jort9qetqPG0oOrL22kJpq2iodt2tQrpO9RtyTQFjG+aJ7a64
	 AGS8cjOAJ5M6QcE8tsK88YH6DvZ/Z//UmFl0OkCfci7nd8WmtSsy5CFBQzsKALsAXf
	 SoOUro4hPgnDhsvE6t3dLwcfmFe2FxFqTRz2slxf7b5TnXNJuV4ftBxK8Bkxif6F3E
	 bYclh+GkyH++my3xz28CE46eI3pdTyyjyZNf8SsmhfPv72F2ZvD5XAU2mA8gb8XFgJ
	 Mg/RgAHrfij7j4CgsJT9sBFrA7KrCw6MW/MwpG1z3qaWqJgcV4cMbBbJyOpCYGRPKz
	 lEf3Ry59HlzFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:49 -0500
Subject: [PATCH v6 08/17] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-8-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0Rove0vkRkFCV/1Wn8zmFJ9RHK9gxr/mOYAQ
 4Pet5flOdyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEaAAKCRAADmhBGVaC
 FQGKD/4sjIDoZy81s0foS2X40pi3J9sEGDlAZ2xEWmBBgxf4QOJluiLEaGvnXoXqAwuIgZxBoP2
 FIJ0p0AKVbvFcu2WE288jAYyOlIy4mwjTR+MQhNNd+fsx89l4PsAJ3gLaEi+q36kDzHTtWiExCm
 VVy37eBlp/pNo0Ha8w/E4+d3iizh3XiJOiEET7516yQLthrC5sLEsSmoWLIBpCone8AroXGFW7c
 uPdnlxSu/XJEV9nZxuthyRE4adIXWjUcGXVvg03f5uwaj5ZcUF4dRufENFurgBNeP6NOA4sCP3k
 Ot9hasCXOHBc/nx8w/ZawJY16QWmJlXQku/jNycCvVuuJ4m5vl4P8M56sitEc4G1U4Psjx3dfnd
 wvkpdnKmdD+e1O8RlY1es8qEY50poTV9RxN3Y8GMI6H/qp7zkXvHUV/UjVDtng50afyiJBlU+En
 9Uf/v7HFz/q8aZGFO9BozaqyjOs7epR7vGmrf3hR78dd4uvObj6/1TT1qpfHgGuVuG85S5rc8d3
 qcLxlrf9oYJyNvO6Vb+LIotj0uahaxtfRDB5skZ2fOMljHAjBY/zt+fEFtCfysQeFanOdT5qmUI
 SWr/cOSlZ9mkM/fFqYuOjN8uY8TL4uFFlli5fS4RgeMsY1pbjOvXaT7KUgfO/MJ9vPD5zG1knYE
 CcJvNDnRUF5oGXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to lookup_open and have it break the
delegation. Then, open_last_lookups can wait for the delegation break
and retry the call to lookup_open once it's done.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9e0393a92091ac522b5324fcdad8c5592a948e8d..f439429bdfa271ccc64c937771ef4175597feb53 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3697,7 +3697,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write)
+				  bool got_write, struct delegated_inode *delegated_inode)
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
@@ -3848,6 +3853,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct delegated_inode delegated_inode = { };
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
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
+		if (is_delegated(&delegated_inode)) {
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
2.51.1


