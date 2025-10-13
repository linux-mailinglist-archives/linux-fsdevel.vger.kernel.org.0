Return-Path: <linux-fsdevel+bounces-63975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0463BD3D74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01ED3E5302
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349430BBA4;
	Mon, 13 Oct 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U41xBfkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3D30B53B;
	Mon, 13 Oct 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366907; cv=none; b=WphCqTcpNww1muSKcR6nki0xyis08KhdWVLnZH3hOqhDs92CKnqpF7M3xRTCEba0MEaraf6zU1eGn/yp5ACp6ELEQiwMLqIBO+ZCISMbwWHHswThJFbi6xtGWHJ6V5Wm8GorprzHpwtNGtbCmdpuORc1zzyN2QFKKD9bxO1Z19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366907; c=relaxed/simple;
	bh=DfXWfe3J6JP43Ux1a6sZKAEITJvGozUQi9wSKd1pfSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POQ5RiimYBiftqMGt+2W6tLxfeBGEdPK43lXyhYOg0pszPHgqv0GSS6MU0jMy9CZI0+TSw+k03AxwamgpX4c6Nou4vRB/RoTwNFPXzOsoHUiIZmLEcAsy3N0+9+okI5R83gj+lHLckAGxRif+Vbw3tukzPVZ6+5ntvxdokR+NWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U41xBfkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE4C4CEE7;
	Mon, 13 Oct 2025 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366906;
	bh=DfXWfe3J6JP43Ux1a6sZKAEITJvGozUQi9wSKd1pfSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U41xBfkmh0PJspKJM8N4+TCJFm2sfKJdAtFt9kGnrF6zQAL/EIuZSzX1bzvZzXyAf
	 vT5i3lMJGL5LQZGtusiQeLbnrD7oErMlik2p6Df8NQBrQhIPA0fm2WrMpPdw6rkgAD
	 Irfo3qJNrAbj8iT9pvvEuBJWvtVIpQQqQ16ID/jahqiZBj42GB/FLdj7dhefh99oQ6
	 C9rLsQJ7VvqCEJ+H8FPmxclmVK3Ka/tyWFdHFrT2zk2HsSJQ48puKC776rBgZCXDmY
	 XV6tBqdLCQYyKNwsDpD4vsz5rdpEYz85JqOU5bGLIglwL+bFIRjxvBUCSRJfb2ahDY
	 GEyP5zLOCXAKw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:01 -0400
Subject: [PATCH 03/13] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-3-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DfXWfe3J6JP43Ux1a6sZKAEITJvGozUQi9wSKd1pfSk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REqLBDtAp7T756QdxqxCHGT/naplNwnFPdaI
 RmmwSk2CpqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKgAKCRAADmhBGVaC
 FRBzD/96GcXuNAIL+15ZatEftjZLlG96Tdk8dUoOd2ehdFY2nHjZ7RuX9TJze+i46RUopvmVHTh
 KoDNFEo0497SoqdNghJFJSWGcB+VPdUhU9rx6txNYijPqHfgpSYtYEy+G0C+j/KnraIwHmG+mYt
 EMq95CzHRPBqfg9+emtB8PmV46b/6bYqDN7Uk4B7M1F9F6sok++o00iRckeXMzaMBiAj6U4WZjP
 6gm6AYPcCxxrntLCQFEkjsIcAz3Jm3Yja8fJ4oUXSFUgMmcpm3rgtJhkBbRvrJCh4R2W4xc+2d4
 q9TrRtB8IFTUK4uE9boMuhZw8yRz+8VuAxBuGC8a5qqhapNvLXZe1YRDSQXA8Kc2Wbd21mjch6v
 YJ6zqisp3rr4hg4h+OY9I73KkqlCA9RoutXRLVQvrL3Eqt+pcP/MpRTxGz0R0QmlddK//NDCW1u
 VnxaTAaMp6wqo5C5XBhTWDlwyLN9y1O+aOIlOXwtV9CToD4CZoJo2mxpuPQbJpAH3ZDYvmOlOXx
 Tuh5FHXQEZDCz5jPliKCAv7pL7fD6ia3QEIlY1bDlIjLwEj8M2dS16nQogbbO0GW7EVsKgQEYzJ
 Le1MbQjKl1zUK3eV6lOkMWOJnKcApEhCSe5x5H94KhmXvQZfWFDoD12OZktLqBreVPYobqmHvII
 4YVVs5EZl6vsfPA==
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
 fs/namei.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7377020a2cba02501483020e0fc93c279fb38d3e..6e61e0215b34134b1690f864e2719e3f82cf71a8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4667,6 +4667,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
+			error = try_break_deleg(dir, delegated_inode);
+			if (error)
+				goto out;
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
@@ -4936,7 +4939,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	else if (max_links && inode->i_nlink >= max_links)
 		error = -EMLINK;
 	else {
-		error = try_break_deleg(inode, delegated_inode);
+		error = try_break_deleg(dir, delegated_inode);
+		if (!error)
+			error = try_break_deleg(inode, delegated_inode);
 		if (!error)
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
@@ -5203,6 +5208,14 @@ int vfs_rename(struct renamedata *rd)
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
2.51.0


