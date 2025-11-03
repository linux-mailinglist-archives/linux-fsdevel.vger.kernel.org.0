Return-Path: <linux-fsdevel+bounces-66783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79222C2BE3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D463188549C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37E313E3D;
	Mon,  3 Nov 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K005a3dC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE6313E08;
	Mon,  3 Nov 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174398; cv=none; b=a5E4mIYPDqKoaeh7iMi8lR3JR2HlDNpbfo1ys5afYBzykR9tfF+Uw9/sNO4imJZzb2BRfp2h9L9beP2ktRdDwLbMHzuSbPHrGv8GBloCjOBzL8OCkMxomvMxw4KD5X/ehd2GvDCtDvdDlJM3GkGN6eUzRPALcj9EYtYOcFATEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174398; c=relaxed/simple;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZTmWH8siVnMBL2xE6F+ZzUoX/UVKF0LH06ee7rS8yWZ230jbfJ1HIZqtnKfoWmN8lf6L0Xr51wzjnquMICoSJ9s8Qz8tUh+A8UUaSmNPqIJj3vSg1rTKPaYprySNCHSc4lp4VfO64H7lTYJP5oOr8XuyDueCGt1Oz2DjM0lEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K005a3dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CDDC19421;
	Mon,  3 Nov 2025 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174398;
	bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K005a3dClFRlVkCQx2mxrAew4WgX2j9tDcI9PhFNb8lWXC9k/cvqwfqktV33YBdES
	 OxgO4iGpp/lvE5GrK76eKbhZtF1gUdp0ovjkPMYT88uHOwBUM/aHMVcR+ga61PXb6t
	 5xfFxD8/4HhKiN7z1tbKnvBxo3MZ+jd2v4dD9G9JiPJ00Fk5tAZFslMghlw4XJQR+h
	 g52j6cxGu3WVUlMbHekYZW3VhTcVSn3JOhd57ijB0g/u19Or5I8FX6SaJ1cyRcPK4r
	 vjwrpr01hEthr9OI/FVettQBV5PrZVgFu2FbC9lqnfrLBHr0S4NBq4jr1jz0FzPJKj
	 FRBzYZJElwUJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:36 -0500
Subject: [PATCH v4 08/17] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-8-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zBQyD4C+LOu4tUZSnzQKyrp9sE+YBQAdVnnbBh8HRrY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWdF28PWpNhmabGcgJBnMa4PUb64CV+jturl
 YtCe62Z/GqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnQAKCRAADmhBGVaC
 FUm3EADDrhqGTPH46E1VAb1qeQ2BvFl40DH/jHgjbwnbyGm7mAbh6WQiGsfUbc2ETePYVvd9mY5
 sUU9YiU/+Y/dLxL/2zppKnYcs48WXE2XYWzBRNgvhdRSX7WdlFRGHFo8bmILDNiRI5J30CmhGh+
 IY3p2mFxCZjHqEgnDBrPikwpjjZQeVnclyrIYN12kVBbnWYNIafHYKXlV4ZP6ghaOn1Q/6tbZ8G
 0AamJGLaUmPTeY+ewLzGrPayeuUFgBJYTSuB+XgmswnqIMV09ucf0Y3ef2ull46egfNqf2nDtfL
 ilx7qi74O85CfcxxsdqIjiSgjXfZEUaRo3hfAcTD8pB5kYnrEePN9evuDxO+B3AZHrMPAZf7Y3t
 vGQ5ydRq69FNnJcJbEqTg05lQ1OPvvrZXEAncHbRHQBRO2yUNQgHQ8DnkmEW1LITMK+H3AnRADC
 aXoVABskPWA+J2zbhf4HxGjmSOCvrZijlZrSSXyWYMnhpdFxMNVQKTawfjnnhJHTva1e55bPZDV
 k714QBM6/D22IgM7GXURFpGrZhsINgAZhyq14kocIgWYHppKsJ4pcHBqFTgdiV/bUzMtEm+mdgh
 KsW4dZ7ibvGLfl66fe0aG/lFHiMyAmT7YmavLic3KVJtf0psICdkmL7fq76T6VFm252Xm2lqdMD
 FtQdIBCPgc/oLww==
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


