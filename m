Return-Path: <linux-fsdevel+bounces-14491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313187D1A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747B91C21DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C8535CC;
	Fri, 15 Mar 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g11P8Vlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE553383;
	Fri, 15 Mar 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521597; cv=none; b=GxF64s2MEkDKAlJCLRRSJ9O7HmVmCh/rvjozEUe3nPLxITrvTucjw7LaAuc3A1kPOo7qH4XP9yWW74z1g4CuJszrOKiKIX22U+bThLBENlt/o+AReiITw0V1kF+dbEt64eMB/T6+9I7Qh+Oh67i6NCcPYvUwh+fPrMnhZDwBbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521597; c=relaxed/simple;
	bh=fKwiuKl53KobzjbKSb1MXdgcO5uYAnMu6jBhF4A2PpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRvo652+pvgffeAqghjyTai9nqlgCXD82TX++JQAaqQYpIvj8aTE/RuKXhgABJ/KGXU0Mu1vZZAUMWghOGadOTLYrLsSfq7+631JHplKlsefn/zIxbEBKpUC4eq/wpKAJ7Z61yp81aWg+qnkakAQxeAXV7hVYumO93X6vYJE8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g11P8Vlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A520CC4166A;
	Fri, 15 Mar 2024 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521596;
	bh=fKwiuKl53KobzjbKSb1MXdgcO5uYAnMu6jBhF4A2PpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g11P8Vlm2QTCw1CH+0YoJtXmCt+YyoAw2XSXSSmPSO+8uzsTW2Vvu9hzzwBraEYJp
	 eeQ8X1IXqvmNKGcBNgRCV4Vj8gS7pERvhzS14SVld3HYTeWjZV0h3qLmmluZmsrmL0
	 lqkZdL0GWfZsXLbs8bQuufw03lN7aDpSS1mjc7Sejie7mIbAScfPRDyrsa3B3ZVZqx
	 /WwsawQl6/lBGsFlZe6Dh/jOJS5Kmh8P8yCsQmomMt6OsfIjE8ymc1mqKTOuqtmxix
	 /Jh6A6vl0GZvHzqQ+vRQ/+nng7bZKnPBdXD9K3lmVPWwiHHjPjTmGJtAPQ9i46pCEC
	 JQrfg/IMuZx6Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:54 -0400
Subject: [PATCH RFC 03/24] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-3-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fKwiuKl53KobzjbKSb1MXdgcO5uYAnMu6jBhF4A2PpI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzsfnDeU1npZ9UPd6x10BjoUFU4+T+gGmHrG
 pQmiDL15LCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87AAKCRAADmhBGVaC
 FSfZD/sHqk1hYBvTn5PMwdUn2UqE4oW7xjGgxauc2340L4WCReb3aBWqjBHXlnJp4KFoJlCF8/R
 CY4BOYfemuI1eHF7hDnuLNdqA5T9SIspmGjKDBnpFYsbwN5w/+iG14qbGkbvib7PJwIa+BVHoIW
 7X5C6Ymhe9esmQ6Jxa15ZznmII+UCZsOIfEOtEvoWtKlGccvKkYnCsJQUPUvW/pkku6z+HAxT4a
 Q0Av79s8GFcU+Bk1DaU7AILv3sLz0zDECwM57TaUxfIFr5epPFmYDI/f8m6+ArFd94UeQJL69bH
 PvhGPth7Pssc0zFSqcLs+A3vLPGlvMHaYXoxW35roYab4rjwke4CKmujzgVT92JZRTdzj7XdPOX
 lg6fYZBJqgOuNGCeEHu1TAK+caqKJht7/zNrChpMFUp6zzKJDbJldLplPSsNcbpBB6iax3fXGxF
 Uklmy8p7Ebz0AJjGGASCaBr/vbIhTzZbNvNjHsfTuHMB4r9anPCTlqCoDOTVOk9nm285gZItuib
 41cdQBAXvpZKsFhcJcsYjUuwZnO8ex9gSI5V6FiRb0uiugwr+vRmU65EDYxhcYHwRFCdjtA+68G
 iGtvhqN4sQA8lQhNYQd9ZAvMfqeC5X8PPEC9EAs4Kf/i+RTl6sThgvMpbizXcaA4TO+HpExKJUa
 Qlqa4vWYaEEsB5w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

vfs_link, vfs_unlink, and vfs_rename all have existing delegation break
handling for the children in the rename. Add the necessary calls for
breaking delegations in the parent(s) as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9342fa6a38c2..56d3ebed7bac 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4332,6 +4332,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
+			error = try_break_deleg(dir, delegated_inode);
+			if (error)
+				goto out;
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
@@ -4603,9 +4606,12 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
 	else {
-		error = try_break_deleg(inode, delegated_inode);
-		if (!error)
-			error = dir->i_op->link(old_dentry, dir, new_dentry);
+		error = try_break_deleg(dir, delegated_inode);
+		if (!error) {
+			error = try_break_deleg(inode, delegated_inode);
+			if (!error)
+				error = dir->i_op->link(old_dentry, dir, new_dentry);
+		}
 	}
 
 	if (!error && (inode->i_state & I_LINKABLE)) {
@@ -4870,6 +4876,14 @@ int vfs_rename(struct renamedata *rd)
 		    old_dir->i_nlink >= max_links)
 			goto out;
 	}
+	error = try_break_deleg(old_dir, delegated_inode);
+	if (error)
+		goto out;
+	if (new_dir != old_dir) {
+		error = try_break_deleg(new_dir, delegated_inode);
+		if (error)
+			goto out;
+	}
 	if (!is_dir) {
 		error = try_break_deleg(source, delegated_inode);
 		if (error)

-- 
2.44.0


