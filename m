Return-Path: <linux-fsdevel+bounces-62624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2350B9B351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A94E5521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE331E111;
	Wed, 24 Sep 2025 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0G9XJfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B131DD88;
	Wed, 24 Sep 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737195; cv=none; b=pbv56Ii54Z5BgBSUdNvukMDub+9XGzJ7+tsPe4VEzz9nnVNx71FHt12EbpNz0dCQ0rN68hPEeqpu7FixuUANvzIf6JDWp1ADUWe9cusJZu8Pg3CgpoGuYQcul0UFA901p1d+Qj30zAOzJyGP10xf713yshDVcLxtQp46qqR/KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737195; c=relaxed/simple;
	bh=/rGKACJVapVZosNEcIK3h5sgPzU1r4dQmXmxapnTdJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2NWComHd4IMS+t09u6YmcL73l9Onc3HjOX2Evi9DBIsVEab1rBhoYsYsoAtlv1gz4KuuwYOHMNyKmy/an96GeaUou278c/1axzTRrMbvxq/sBPmwIhlPDMREZUzX7vMatQIMgS+tCV7v64mTlKOqt7s5qFA8rPwgRimNlXs3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0G9XJfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC24C4CEF4;
	Wed, 24 Sep 2025 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737195;
	bh=/rGKACJVapVZosNEcIK3h5sgPzU1r4dQmXmxapnTdJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o0G9XJfZVvS5JK4rUakOzhiJhLhYQJie+QeZ2e7aSdTDNG9T/S6gGwvd3I0enTEu1
	 7sjXYorfVNW9OVhGAhV50z9/vF8kZcIjMbe5pooeCyMUMmlgd7Yz2ueUZ/OiKU5hBW
	 u3FrSPnvc4IbMTmskW8mbZBKoFOnc2sDjUvBgKOeKk052lboqZ1NCNrsMJ91HCxZcX
	 82Xjisdu0FySxpk3sOk9r2pLRxvIXuX6jqqqcOCRhdHk/agh1Rg6plbzIzaXxDzXyQ
	 vU5y7EAFIjeDXLqcmugybgGDb6AIT6UpoJ0VdAUkJ+MUaRkWnYPiIiDQwqq2lfIsZk
	 GQWQ3fkNfT38A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:52 -0400
Subject: [PATCH v3 06/38] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-6-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/rGKACJVapVZosNEcIK3h5sgPzU1r4dQmXmxapnTdJs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMLEtx8ddr3q1GkIhixr2rTop873a3yh3mYt
 ydyME18RTKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCwAKCRAADmhBGVaC
 FbthD/4yIsIQJP64VJYlR/X2sm0ruoTRvy2W2CBsKaB9p3JzSMZzd+mj6sTSq1Lol7tmKdYTFsF
 lv/yPEHsHzLoi1gIUvMx18yMn2NYKOxdSl4uSZx4wWR1Wpai6vqaE8bw8LfoF8Elfp/wwD/L22T
 gBpY9td8v4MxtN7EStgcfqOpdmOqvQbmCLDcpdKcJidzXkiKanLLCD5kIOidvTcpo5zT6QedBxk
 Bel0KfQFp2ywwDKX4PgJ84P7VIwgrNbEQQ6xGZ2SZcyWlpoSJqaRhZ4F2BhLy5o7eVx65xl5rHS
 Ug/X+t81uBlDupMGvalYNYtACQkg/CcMBzQ8O31znGQgbueemKpRTmERyt/OZWQ/wBr5/FfB/Js
 8jBAOvI5qCJjKZAIQmQYHdHkiUDTTgBkR5UD2O7EuYTKM/kycrBBw3DHRSy0E6my9oRqUmOhsUK
 fVCaMh+Fcj3iGV4OjstG4TnwpspejpDgGAi8VlE+3Vzn33A6AFr9vc/HhJ1Nd1YzSR2WjVAkqz/
 vdw67fyYmxL3Ad5oJqKez/odqh0mPlGhy0jfMDqCw819x7QoOyvbDo8nxfUz7Y7D/KkPNCvRMns
 TyDBA/xH82lWwzbLnzWHRw0/xFARtfnwI0e8kC6Dz7DAVjN3xTPNNEnm/wWc0swBsYIq4gbeG7D
 xsdWIQKZYArxkBw==
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
index 4e058b00208c1663ba828c6f8ed1f82c26a4f136..903b70a82530938a0fdf10508529a1b7cc38136d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3609,7 +3609,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write)
+				  bool got_write, struct inode **delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -3698,6 +3698,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
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
@@ -3761,6 +3766,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
+	struct inode *delegated_inode = NULL;
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -3791,7 +3797,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-
+retry:
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
@@ -3804,7 +3810,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write);
+	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
 			fsnotify_create(dir->d_inode, dentry);
@@ -3819,8 +3825,16 @@ static const char *open_last_lookups(struct nameidata *nd,
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


