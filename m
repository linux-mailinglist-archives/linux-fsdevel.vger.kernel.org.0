Return-Path: <linux-fsdevel+bounces-50336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E915ACB06D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E17A9589
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954D22A4E8;
	Mon,  2 Jun 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCvjZxmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB5229B36;
	Mon,  2 Jun 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872955; cv=none; b=M1xs+Du5tvMqjDKPznMVfxlYXQCt+EGY09CGZScZ8IyT7K4CkB6SKjjAQ2Yn7gf3GtHuyhxO1cUrhXuxn/JEdbW1ZFMufbeP06HFqJY/Ldfftvpx4HQxNHHdZlApNBUp4uMs3YM6Bv1bADhLPC5Ag0XRoUhMRUqtW4/lPjW4EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872955; c=relaxed/simple;
	bh=T94FDtoTtbYpTjGCzZH79quGDn7pSbDy81dX+17IVpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GE94LvmrL2LkDwr26ZL2A83bMQO4aZ0EzmF7sBeKTRQxHU+t6wR4tPoQVZh3XTVXZNjdN8bnu1LINx9DWAOQdTCZAMGz+83+gty0wV66WWZ62kVb4rePQP9BxexYtUizjknOeWkju7gP+zZcHiTKC/wEFdD7ZJ/21Pmbg7HstEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCvjZxmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C7C4CEEB;
	Mon,  2 Jun 2025 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872954;
	bh=T94FDtoTtbYpTjGCzZH79quGDn7pSbDy81dX+17IVpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FCvjZxmrXPRKqP9fjB09AhKpJ1s8ezYUH7qDZHn62yg6FWjyTIahWKevQ6ONtoDhj
	 oNsTCa22wMrTL7CT71kCfYGn3IVkH5JfGwE+tgkBKwPNqJ2SoaZTzbcaEU2nnmEQ6/
	 gJKZAy8pUuf7esRXJfgNJJstQRllQBj1h0RIUBrtuLYOoySdAMGku/0BA25KzfZcX9
	 DeG3Jh3rNyERqq3iQTTZmbXVxqTvhL7rHuzG4CSq/WXkm3zv8RV98nAySxvK6oaFSp
	 Fm5Z4EE+wNKG29ujFsACJkmk7R7lLRXzankuy+sr59Z74/F+gjMgrz87vOFtCXitPG
	 ydM6fR1nXpxMA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:49 -0400
Subject: [PATCH RFC v2 06/28] vfs: break parent dir delegations in
 open(..., O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-6-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2938; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=T94FDtoTtbYpTjGCzZH79quGDn7pSbDy81dX+17IVpQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7lDHCHXDtRTgcsP29dczBxlTCC3zLfhHy37
 Y3wjJ9G9r2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5QAKCRAADmhBGVaC
 FW6LD/9qJP89ewOUrBbOy2ZEUZwFXLnFUTqIpFdhTVyOLsHuqdI+aYIVUxWvbSMhzxt8wm+ukq/
 +xri6d0S72UtabzktdUrxp+x7dNUhV+Jb0+81RyQID++S5rLvgL2q1qZNgEyte18gvnh3a9xY10
 YApueces7xvftACob86hu0KWEqT2P3Rz38tH5aU9xkhKLkAf0DN1poU/ic2CD/BUjQgh1axEEOz
 yJCjJjeBTTnczbKCiqRe0VI781IHWVXHAVCCagfnTWPcdG7q7xdKwVaeU4SP4aLZDIRNnPog916
 +3xp9q9hzM98Knfz/dvVJIQTg+UTI5HYPjDPTwMXztF075J02FioF875r74785Q7zhNG9pWtrUx
 crMdJ3K+67bsm8X0wBr8dtpG21hreRzB1Ep9L7kuDtBBR9XTJh9yrgbf9SXlOxgHM+XALS3o6CP
 wLCxhmWc4mwOzqonY8RvEvajsWaLBWVUGIENUz1bnfqKBxXtWMmYuPpeJACa8D4TtV15h9Pehaq
 x9YYIw72rsyx1DZVbr43TMj54Ms4U5C0ooWQVOPuTOdByChPnQtC+5kx5wSjgH8HziR6S789JMZ
 9TNzWkrx1DSiNY0WtjYB0Omba3kjej0Sje3DXWWRPfkFJ/LfHv3aZwodsA2vSTWRcT30eEdgje3
 HvXgdaE3btVVjEw==
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
index 2211ed9f427cc97391d068b1a33ce388266a3e02..c8fe924cbb7dcefac9a4930df9f8303d9a478508 100644
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
2.49.0


