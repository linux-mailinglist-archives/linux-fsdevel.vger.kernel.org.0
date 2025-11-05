Return-Path: <linux-fsdevel+bounces-67166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4782CC37102
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AFE665571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3234345CAC;
	Wed,  5 Nov 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y45UKCTr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66133B970;
	Wed,  5 Nov 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361677; cv=none; b=QoDktXGvXt3JBdOdJnmHsV/47q71qjbwuLHSprcrop+PZqhV+KmXPCSD1bOjJxLUPSSUOrwOesNKdBnbuHSUaKWQ7W7D9LG7RM3AGdiA4mXpcuSC2OVyyT/M1baLtPjpYK1ztmCOAErdwLPpfm1nCUG/3v7jaiHw7LY0+ShcObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361677; c=relaxed/simple;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pst66u5DBmSzQ76tfjqsKYm0lD6nymhWcSaU5VBlYF3JEnTJb0dcnpmXtAUwl7epKb1cROblmE0i+E5TLCce7NQZxoiDJJWrtCyQyCEJhICSa562RQoSZjvKAfbLd8nmt/+/2S8RNy4ZRSPGpKhjlXEUdxBirI8i+ecw00tOu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y45UKCTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B838FC19424;
	Wed,  5 Nov 2025 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361676;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y45UKCTrpPCHbOODGNYGhrqPcwh9QMORc2Iyz6c2TydWutN+pdFX1HreFFIQRPtCe
	 6asDG6ipL0d9pxWRisEaO7QWXSTpMtFsQ8wq6wGYDNt8R+fiRMfF1tqH+4QG33YooA
	 8zYWcmkMK6WdgsDPJroDJnSGpOti1nyDNubfKLn38B8Jd29x0h+7xAwnMqcmuoMaFu
	 P5g/HuH3dnHXNj+4nyCTQkrKO5TGaAjn4qL6EpJtVALD0TBFfJvNtGb6hBjwR/Bixc
	 05PaKuUNwtYsYz6NoC7C8V2sXF21gd+7QU55Gkg8+QKjNoPOWBH7/jl9lpbM3QV6ov
	 qlHxohoxT/FxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:54 -0500
Subject: [PATCH v5 08/17] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-8-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGkLgSzIfD1XscOsnPbbHAdNqYpqIdL5OUrLyaIN/CbYAXxBi
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpC4EsAAoJEAAOaEEZVoIVPJEP/3lu
 M+FOxIMmf5JXzwv8WAfgTWMjrkrQP2yNCluaH9t2WckVoCX8k2i8Z9IMk6RpcnurWyLeBC5yXs6
 vrHXrDYq2iWwRWRFzsQLdNHNqw9quw8bC8sLzETQypmCMp+D3o/ntHc9r4vH8F7YyHqHOd/kZRq
 qZFRRJC1xJ5U4YKLRB+JIJBV66YX1fgka5hVROBLiLAr2EXsCltwld6M2TfXPB7UBaCZO1VlOmR
 t1UjhWuyHouL8fuU3BVV2jt290QTlk2TnDKkEDHtkvm/pY4kauWSu8UARWxnvCDV4OZnD59h5dm
 nJy0mV0/fNaGyV8x4bT6ml/E/q9b+jR2DDSGuwWWNShsVLAKJeYBKhEyugTZY2Uc/9Xt/TSofGs
 hjx38h2EERwrb7gRqjy/E9Nqjk4VKXveI+lLUCHY+38XiJ/2zOUabUQEIn+4XRsfktxC2pYejgD
 S4cwpuM4/sZCjTSxU3rsiQFYM7acpF/MpuHQFeeThhsK3Fv1TOTS6Q3qO9ae9DCpKH4I6zb/KSV
 slvwM336m0CeuS7VNysDj1OR0TIXiOtO2+jHaVvDhuY5KC4zaPwItijFDqwzQWG5BqWIisyKVko
 g7QAdM9U2L9YngwwsGWu7TFHDTZJEI6qHVyrSqm8MFc06Y6/ChRDZ8r4zB5nnCOv0HUh+8YkYLh
 Qe8AH
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


