Return-Path: <linux-fsdevel+bounces-14494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5629687D1B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C671C1F240B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50F56B6D;
	Fri, 15 Mar 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taAB791R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FC56758;
	Fri, 15 Mar 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521606; cv=none; b=oXe6FOA+/6KN8+NzhlKriSic6Ll6pWyVfA8LQ25aWsKZUvu8fX/Uc/C5DollD0XChhUeypIjyF3F1IclT22rukC5mjRPsBNvWzmFxeDyEOX4+BnLkCUdto+BYXWIzTnkHfr6xW5Tpf+O/BaAqFv61yh36TjrA7f9uT/3sHH6WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521606; c=relaxed/simple;
	bh=pNsngRzgw8CEGDxcLrFjYZpk10rAX7yWtKnMHw2YxwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp3VRwMdQeFdnfyjTjWZvR95zX6q6YAMUGP32jcFClo5yQQFYuzx+BjNMjJhBA7rcoh6Tj4vd4R/ZBsADpQpZyJnuKu+BBnr5VNYMy1/bAjKf8wnYofjg2ov42+aJRTZ/QPXxbNmbxedU0U7z51COuViCHhPhowpELgQXg7Zhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taAB791R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AAFC43601;
	Fri, 15 Mar 2024 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521606;
	bh=pNsngRzgw8CEGDxcLrFjYZpk10rAX7yWtKnMHw2YxwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=taAB791R5Xdjx0ThiJdW+vqwgJ+WDVR5BELTZ9zupxXhg6Bkc+GotPp+PPLOTQcu5
	 Jl+RUQuAa54BcCD2IPeyBKB4+YjtyvJakN+R0EPtGatqoH2m1z9BKDxOC7+jDu1AVr
	 5wAHTvNaSTobg7b+42t2SuGZf6gzP+0ECNT3uckB/km51Bf+p/AqMIxHor+ZqGVOie
	 uE2sAYylN8qtVz353c51w4I1wQfgrCYiIUElTUwLCI6VYiDWVoduUiqPTxiIewjmxe
	 lMUgWA5r9AQGmYaz28YEQc4VSoHUfoclXASRCXM+O4n7QOQ94Qeym91b6PlmMj5nJA
	 G6dSWDl0MILcQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:57 -0400
Subject: [PATCH RFC 06/24] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-6-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pNsngRzgw8CEGDxcLrFjYZpk10rAX7yWtKnMHw2YxwE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HztCX4vyElQrHztHrMIhenbB3r+5vTs620Ft
 ibHnhreb96JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FeVWD/9HXrfF8C9gMMmlb/yPm/eZKZ+0UHcF/vvMd2O+2tMmSMQqO0lAD0BNjn+q02XGoga3GXJ
 y2q3eR+ez9xLCEVoICGz7rJXG9laxCleebaQk8p9mroi2ULPwIzkqb6HDx5dChIahfT9dtUneOO
 WiXzmgW+fBPkXHL5Bzrl3aKL32BeV6r7HOeX2AqPZC8li35Kl9zlvfpKbu0mRn+44K6hWamilLo
 vCuAOJTrnxuvPv3gxdTJW4ly5A5l/Bcn2SE1Ah0EEcQysluzy183G34X9taw7eDIpa1QJ5pmqaY
 tuDw0A4BEpk20WymMN92EtfdTJ/FM2c+gdg3tQxOsSdmxSzljb15j0YqfzTm9UJWc/wjriBIETe
 ll4FDW16YLwAxN167qoEBhbd+Kg/EAIlePcFD3YpFcU7Zjr5W/cOu0HKYaipxFiGOoN8Y11zMMo
 mohdx5hBYkcmqcYgHIgIqjFOSNNudIEdhkKZpZJP7jxPkHJZCa9MlqpbVwp+uX9NPaV9N9Y3bGU
 hqN7nf3kPGs9t6ZZGbPLCRW+nsyzgD24cGBsrXCWktlbYU/i8DWAsd3JxTBuVlT07rDUcidJefA
 Q0yElVrkmg3clEvHNQGaei1uVg1aps5SAgp5rVHf642TFdxajBoAtlbqzQXUvE74OHkpzrGsHrl
 b6afdnHiFZjlC1w==
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
index f00d8d708001..88598a62ec64 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3404,7 +3404,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write)
+				  bool got_write, struct inode **delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -3490,6 +3490,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
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
@@ -3517,6 +3522,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
+	struct inode *delegated_inode = NULL;
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -3553,7 +3559,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (unlikely(nd->last.name[nd->last.len]))
 			return ERR_PTR(-EISDIR);
 	}
-
+retry:
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
@@ -3566,7 +3572,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write);
+	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);
 	if (open_flag & O_CREAT)
@@ -3577,8 +3583,16 @@ static const char *open_last_lookups(struct nameidata *nd,
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
2.44.0


