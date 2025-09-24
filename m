Return-Path: <linux-fsdevel+bounces-62625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57EB9B35A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FBF19C8482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E98320A01;
	Wed, 24 Sep 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj6wznBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE631FECA;
	Wed, 24 Sep 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737199; cv=none; b=mlBiguhKPdTpFQA6Kq0A09NNFXMJ5d07rrPOOOJKyp5ExCm5UkvgzVjgRlgbR7rIpdsAHz2UxvMzEchLhriUJu73oXI6Wr9k6rHhx07xaNR78Gnsou/p6/HAxJe1jmOwGURbJygI4YG8VWd1TW6/uJOfW0UtU7fbc4ujYyLyFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737199; c=relaxed/simple;
	bh=tjutMUi8ns3+qavkIbH7Fit29ONOCsHDq1iZNxVk/QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoN/WH2ad5yAE7Y0oTE2XjyYZco9e+v1qIuxuaHoLhpfF1pjHLDxyL+UNb5Eg6yGdqYieOvO55tJn18L6iXK2nLnk+qcYhudIErKrGXsKeUdUn8FguGFXGqBk12AtDNCYdmVDtBr52paAmFLhqTuGhMNo1YK2i2/Tm7jxqRcvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj6wznBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2BBC4CEE7;
	Wed, 24 Sep 2025 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737198;
	bh=tjutMUi8ns3+qavkIbH7Fit29ONOCsHDq1iZNxVk/QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cj6wznBjV3IIqeZ2Kx4Qs1+Oi9PUYdntqfzlDcK4+jlsESVMJPX2ITlwaJ8mxoRi0
	 4rLbTIOF0aPg328KQxUFJTViOmDjTvx24W3C8PNdlMxsqtMhFE7dRf9I7l3cXdz98v
	 TGgutolQnbOg/TFeDDCfEMk0e99JCYg/UjVMFwPgdPEmXkOk3WcHnRlh1RteWC4lQ5
	 UqvywJPwuPvfjsd6kscSdMXyxb9KMyZnpfDt6rwiQaQgPATcmEmnqAPJ4dOLpOtAeR
	 sxtRIYS64lo9WcatDuT21knfDWgMmccUofT96HhRDQsLzRF+tBn226ND5PBL3A5cT8
	 FafVotEdf/Eiw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:53 -0400
Subject: [PATCH v3 07/38] vfs: make vfs_create break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-7-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tjutMUi8ns3+qavkIbH7Fit29ONOCsHDq1iZNxVk/QM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMLqyJ8CfHxZkg8beahg59WseXlgxBytyHOX
 XdPohWkNl2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCwAKCRAADmhBGVaC
 Fe7kD/9PwvvEfZ8OZcstCOcxRlgJs1qDH6v50h9o79mi1TmmD2tZaxDIfYk0QUqcqxVDlm56Kjd
 ffeo6Ok9k2kRo22RtGr0PglUEAXGzAl/H1Uc43aqMn6RKqnY2x/D3hcUL1dx7oMF1y3px9D78mW
 emS1gCpLsjq63AtREcBmnbzpOMQmyJDaaSELP087bFG3leRuPQNbHjkK7TeMxcujbTXL+/H++xI
 eJTivbcbXJQX5jgL/hk7ZROHDiBkSWyMnAsOWOHu9GvL4FrHU65Nd0TMuHog/lhP+J9QkjELoVB
 8jmbEFvq3gWOxMhtTpDJrTyexFZqk7yPUQNPNMfJ6AtrkinDOdL/BeMQ9n+BQ5QYtB38TxWdUwS
 I/y6hya9OnmPmg5cYa5KOuycUvu9AUMlZ4uCkXDycZIlDmgZtRZqJ26VZtBix/5S4fh2C08wraY
 Vzp96HRwAFHJ3iO9meRJ7BfD14RlrOcTTrJPn/Z4tkwT+Jrl6ed8RaBvSaZe0TEyoaP+J2pm6PL
 q5WPz8DnpwnhtUThbd5Sz/3B2ai/HSYRIRBx6dsrSvG3xsnhmINkc9kZXZSvXgTlUIgdAXXk7re
 +bDfcD0rKuUg5WdvpRRC1IgtsfLCnvrYTp1ctVJ+M1IMVsUI5rES8Y3Vh/KyEAkDuS9K1+Omk6n
 upWQSo04pfNX6fQ==
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
index 903b70a82530938a0fdf10508529a1b7cc38136d..d4b8330a3eb97e205dc2e71766fed1e45503323b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3370,6 +3370,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
@@ -3389,23 +3415,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
 
@@ -4278,6 +4288,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4296,8 +4307,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
@@ -4312,6 +4324,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	done_path_create(&path, dentry);
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


