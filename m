Return-Path: <linux-fsdevel+bounces-62623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E405B9B330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D04166EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFE31D744;
	Wed, 24 Sep 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHS8ATg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5531D388;
	Wed, 24 Sep 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737192; cv=none; b=caeVxGpO/Hjp6C3se9BrIV4tDmp86lvVDXwPJIbZQl8beMDX06VtfdCASSEIf8l0V4GAr/5s87sCRXke6civACx1R/kJfwTCWYo1tQ26lyS8Z4KKSnOTwvR6WK0Etgy3MB8FjN/Ca0FyLjgYJ9wAWklT87GrxJ5n/EVJiXlMCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737192; c=relaxed/simple;
	bh=vwH7b3Hg14I6yNkAomIczFjqPUVjTjxdhWNr1rOuVO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4FOHZg28KX7G67SbwZAG5v+kHsiHzp5e99G2uooXBXA4MxD9EaWSnre836dsSqyRgadIirais9m+RQOVmzpKj8zP7nUWq1yVwpn0dvocA7Id1mkaS1buBwAt0XhTwRhJyi9jAXIq5RkJmvQevSV1iGWpKeAw6Z9dBohRlJyl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHS8ATg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A2C4CEF0;
	Wed, 24 Sep 2025 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737191;
	bh=vwH7b3Hg14I6yNkAomIczFjqPUVjTjxdhWNr1rOuVO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbHS8ATg2bHxheDTMUp0gzBevbzIp35GmppIAW325Phpg4LSyinpbaXzvwHu6BvwW
	 0tAPoJYfeKz65y8y2K7N4wlzvkdetVY5cRojPZkLRD3ecs4wFqDzL6fsrcoI5V/dKm
	 +uMGZldZLnSlCVxgUOcombtdJgouEjrEfWqcJ3stynrpT3paZsoFJuBPIiO4NcZli+
	 pvaBonB7LxwegaR49Eh1xN5kSzZttdIhe7Wg3SbI7Dz0p/bXk0w8eoVL85P115ONin
	 ZDxx0DFpcily3Jj+WeorySb/L6Q/Qnl/TDqZTnjM3nMffMDYBvFxDEDJvoIMN2AM0Y
	 rd3nqhVUYf8TQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:51 -0400
Subject: [PATCH v3 05/38] vfs: allow rmdir to wait for delegation break on
 parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-5-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vwH7b3Hg14I6yNkAomIczFjqPUVjTjxdhWNr1rOuVO4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMLSvttSOaor3+CpbrOP1EMYq7w7oiAl7wif
 akkCV8lCN6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCwAKCRAADmhBGVaC
 FfXAD/9WyaWmsTAsi5Bx1+CoF+2HK5qkU6vP2w3VFlY5O9T8rweBoVzOKR5r0Xad5DF2jGerkCI
 Jhj5DCDlgcJ3sOSh2csHBh1OetmxIxbt39nH2GzczZpFmiCXFQK524dT5Ba91u24nnlWYk5TPoZ
 ksMIMKac1S16XWr2HJUECKzZTI7pkolizUMedaoqEzLqCWJOUgxvAVYLT6/f0UiXo6plzuQq4M+
 qNViIevDDyotv8TggKfL5qhxptFLD2ETXpkL28+ZEoHUeJfARg7OCj/FVMC/9Zp04FnvQN7Qz+J
 PuPxyF1iY0+aaNj4f4y1CARX2CcXSQ2DDBTBbA8B1GmMKBnP90LnmzHv1NSQ5Qj0Giu9P9QErGA
 F6HdRtmnlkOl5CCVZi1pEiIBd86MADFxXVGF1lH/hn3utHVvIzovLS5BFa2/MOo58Py5SdLZM9+
 EhJQA5lvB3C/ikP1sV358Oa1M8Pl4I/bfl9t4N9YWcuNwDC1kS1J3CZ+YwrRoaw0zYd9pnP1O2D
 4Acb+c84GLoFZQNOKoM+o/ylIdxRU/Jxgj0ymzv+6Kkj4Yph8S0vA7NO+zf+nsn0EXDEdtHkjjP
 h30K38xbS0McHe8Nyrb4y2Z2x2A8dVChmlr/o+Uf6IsOM366QCheSClhQIbSkSnoIHoqFU0UMmP
 wg/qvjImyg20B4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename vfs_rmdir as __vfs_rmdir, make it static and add a new
delegated_inode parameter. Add a vfs_rmdir wrapper that passes in a NULL
pointer for it. Add the necessary try_break_deleg calls to
__vfs_rmdir(). Convert do_rmdir to use __vfs_rmdir and wait for the
delegation break to complete before proceeding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c939a58f16f9c4edded424475aff52f2c423d301..4e058b00208c1663ba828c6f8ed1f82c26a4f136 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4433,22 +4433,8 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 	return do_mkdirat(AT_FDCWD, getname(pathname), mode);
 }
 
-/**
- * vfs_rmdir - remove directory
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child directory
- *
- * Remove a directory.
- *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
- * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply pass @nop_mnt_idmap.
- */
-int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry)
+static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, struct inode **delegated_inode)
 {
 	int error = may_delete(idmap, dir, dentry, 1);
 
@@ -4470,6 +4456,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto out;
+
 	error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
@@ -4486,6 +4476,26 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		d_delete_notify(dir, dentry);
 	return error;
 }
+
+/**
+ * vfs_rmdir - remove directory
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
+ *
+ * Remove a directory.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ */
+int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
+		     struct dentry *dentry)
+{
+	return __vfs_rmdir(idmap, dir, dentry, NULL);
+}
 EXPORT_SYMBOL(vfs_rmdir);
 
 int do_rmdir(int dfd, struct filename *name)
@@ -4496,6 +4506,7 @@ int do_rmdir(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
@@ -4525,7 +4536,8 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
+	error = __vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+			    dentry, &delegated_inode);
 exit4:
 	dput(dentry);
 exit3:
@@ -4533,6 +4545,11 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
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


