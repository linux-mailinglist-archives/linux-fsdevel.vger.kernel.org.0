Return-Path: <linux-fsdevel+bounces-63979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A0BD3D17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74E5C4F3F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5430CDAC;
	Mon, 13 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT4W7NAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806EE30CD93;
	Mon, 13 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366920; cv=none; b=NKSnNkIi6u6XhKaIO7Gk6T0ql+/GlncQ/y+mDY+lqjlLtL3Ma3iTgPGEMZf9FUNmkdk0IC2adgh3awCqecANw+iJZCgO8QMxzixbYfcxfEV92wLx0+M02+UfF310owfz+KEYcTdUe0S5p0k05dfYYTAHp12jY3DfYYCTL5SCbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366920; c=relaxed/simple;
	bh=7C2fHBBRtUSq2lBVdEoW6vR3dOF799abQITSiYChU7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC+Y8g+5MQadRCq30sn3N8GX8NgJr4QF/ynSoFyUJ+W0f3HQb/5NlvDyRn5ileNVodzYLwOVXbSGCSsdWpj8/ACdHxOhbBmUJ8Or62ujsGFrsFEDEAWVuNonyVMybOwfNePJGBl6uvQ9u8zFl0PlSwTify5htlsiqIMRE72VOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT4W7NAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD07BC4CEFE;
	Mon, 13 Oct 2025 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366920;
	bh=7C2fHBBRtUSq2lBVdEoW6vR3dOF799abQITSiYChU7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JT4W7NATEE2gKo1hwpPS23uYqVqSG2EejlKCjHJJDjxi/TzS0JnvVbeEuEhKYPPQ9
	 Lsg4z+YN3ahcrQ9E/Jq/4C1cg2tolHKAjmmLYP0UBVMKboJb4RQJAU6E8mAXVYriVA
	 teMKsJYqexz+bFfpk7Vij/ETbsyUZwbs6LdTyBNA2Smgra6omUSROs5Rq5ZHQN/CMn
	 b38P55mNi98xBUr5ILPBTESPBMPorn/VrcoqK+cNy6hfOUHMKSTlqVUza7XNc1JoAE
	 nCaB72XyVgcN+pINhHlGnb9fth949QTvmlOoB/YoShwIqrSI6fWZ2ycgz7GzkVsXwd
	 CNV0fRx0JbBQA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:05 -0400
Subject: [PATCH 07/13] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-7-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7C2fHBBRtUSq2lBVdEoW6vR3dOF799abQITSiYChU7c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7RErZ0OXvA0nLRHai3beQ6E7JYIExl/CLVw50
 BW6y7OkK6OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKwAKCRAADmhBGVaC
 FTAnD/9l7NjZwG5Pedn+L3ocjTEP7z6atjtbFEPJVZemMgyoL0tVIAPC1/kf2lnod7ALItFgwrT
 7mncOsFLgcjLCo8cWDzwDzB4JNnPzOwAXai2uTg+PuPTIJ9AKDL4eFBvSFYXz1gOZGmbOcgsBuU
 aeQ/kiFBThtg/ZQZ5sl3z+SnU4Nne8AY/j9iIUehVue57alCVwvql9x1TwAFWVA65VsuE4r3GFJ
 3BHHHcFscJAzE+YI15IZlu7RlhmokCzd/xxFXmBFMUcBg8NqJGkOLcJgkcbs/Vy+OTPMyM3OTPa
 3quEYiSMRkTA39xa3vNShbkOUVSUUYiIVaec2XacWTq9FtCXopp81f5sslXm79iEqkzQUnZZyZv
 D4oWIxiiJNOKhdZTBkGfydzeEDCm7yly1Egz/WUT3rq7WX3VW6Z4s25xSPSe4bvn+G3XODxkt8K
 0FSJ/bqY/rEgBq7FWKjk7PgyjgzWJfY4b44okNcUSUZIKBbJd3lrx1ee2dsspB+KGJ5cXmGRbLE
 AL/G3aphtBepDN6qaEwC7GB5iQhvkE7jBM96TNbDVviNbsQUZx6tKqkkXlI14dr1/OrCBoHTW9f
 KxMVFRYrWosAPT/Cmr1y5SbAsUwarhpxvvqYBo8WhAZGFZJL0/M/q92IEZOWwsbt1MvMQs0ql3f
 8tiRUytDv0pvibQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename vfs_create as __vfs_create, make it static, and add a new
delegated_inode parameter. Fix do_mknodat to call __vfs_create and wait
for a delegation break if there is one. Add a new exported vfs_create
wrapper that passes in NULL for delegated_inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 55 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 786f42bd184b5dbf6d754fa1fb6c94c0f75429f2..1427c53e13978e70adefdc572b71247536985430 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3458,6 +3458,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool want_excl,
+			struct inode **delegated_inode)
+{
+	int error;
+
+	error = may_create(idmap, dir, dentry);
+	if (error)
+		return error;
+
+	if (!dir->i_op->create)
+		return -EACCES;	/* shouldn't it be ENOSYS? */
+
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
+	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+	if (!error)
+		fsnotify_create(dir, dentry);
+	return error;
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -3477,23 +3503,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	int error;
-
-	error = may_create(idmap, dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
-
-	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
-	error = security_inode_create(dir, dentry, mode);
-	if (error)
-		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
-	if (!error)
-		fsnotify_create(dir, dentry);
-	return error;
+	return __vfs_create(idmap, dir, dentry, mode, want_excl, NULL);
 }
 EXPORT_SYMBOL(vfs_create);
 
@@ -4365,6 +4375,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4383,8 +4394,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	idmap = mnt_idmap(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+			error = __vfs_create(idmap, path.dentry->d_inode,
+					     dentry, mode, true,
+					     &delegated_inode);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
@@ -4399,6 +4411,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	end_creating_path(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;

-- 
2.51.0


