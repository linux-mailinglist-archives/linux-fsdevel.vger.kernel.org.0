Return-Path: <linux-fsdevel+bounces-66780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19379C2BDE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3503189741B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EED3126DB;
	Mon,  3 Nov 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8WNuQZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABD311C1D;
	Mon,  3 Nov 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174388; cv=none; b=fL+T/JxSdF96ari4IrwiYuZMFFkcyI1B478+fxzTwcj2FRiEyYdz0A+8BIpeVaMo4MD0yV1VkilhXsjwzaNDSt4YJFvTDav9OPMSqKnN//uAJoNBZwB2sk6ndHVPENlQ70AvzF6dVv2m2s0INtpAZQhIq3P+uk+HMt9AdYMzexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174388; c=relaxed/simple;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyWtHGFuF7TGiRfiGelTZ9mQnzvDBJLW1GLXQ1Jx3LgmjKC2y+GQDM4p6AM1R7yH66X1QAX0uUMZMXCJJBqhu5REOUh7C3JZfXuET+YW+j9Ckn0sYz2jYJ1hljWov7zAmXqFxnPWaDXbNfwYZq7YwXijnbnmqcrt6R+l3qzOHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8WNuQZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D627AC19421;
	Mon,  3 Nov 2025 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174388;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t8WNuQZf/kzSPGRjVLQyzGc7WYcDArrpNvuVtYBmgiak+XHJfo+zNiB3GdwPOEAR5
	 8REUMYjXWpcpF+XWu+L0bzkHygxUsIvUm9yvyL4zHbi6jqXJoRRgac6D2+IwcKPtuz
	 uSxjKPLUAb0FKOiCt5tyZpA9eFxYuumJsi+SZ3ZuEQBvYgXy/AxU8OJpCNsLCf52v3
	 iNaTLXw8oA29Hsou8rZqA7ZQ46bIxHZlebaeCjTJOJelzSzxKKMlXmq0lQUNbVp4aa
	 iitJdvAkSyhFxGBeHLqP0O4CvbanacMWZohgfaY2yVrzhPWQcEGhZxaFb6dWdUcFV1
	 ZKySgJ++7YK5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:33 -0500
Subject: [PATCH v4 05/17] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-5-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWclntQx/8PRv2BbaTngqKuyH32QU2T1bZ/I
 soArbOjwd6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilnAAKCRAADmhBGVaC
 FU1iD/46oyEma0ymTkvoMS8V+8HmUzthQ+9tuWdLHyybCM86sjRa8l3a8hXUUnwaUN/wywmzwGT
 7a+0wiemnErUCEq870UsbCTeSoslaZYNWkjJtzirifVaKdEZB7cj/uoRXIRQty9ks14PuWaLc/V
 wP6OEM4zpRTK3q3hDd/b9A6pGAGPA6z2Xi/5BI6oQhAFWROKcupgF+J0IluG1d8Z/zKZtY0VmJz
 on5UOXJuTxYPyUdSuCMVG4kg9XQGkLSgOEHHOVpBNULJt//vZE2CvyPpAZoexXKA/jhE8raoTXt
 Okv5+nWY86QPiVR4t6IFhpG1DlIcYq928aMyCXYaup0j4QBhYl8CgNSw+iaVuwbhAW9DTTa0q2P
 H/QhWBLTSTWcU9MnC1iJVgy5W4zQF3PukKVJRGTgXG1PZOklXL7CIIMB7X6L7y6RvI5x4UQiNs+
 NkfliFKkPBiK5DCxqTV9yP2bEL2Jw9dvH8I70i9fZqEDCGQUci1RhKv7+8H+nMYVxUVl47WQQaC
 c9YeTj3jD5LPrgL1lwlU5+P5zkCAFjTp5n8M/AZgeXOdWOnnqfP74MBvMFZox8tQDYLNobMatt4
 qGjMpW3nAL7CtDWIP6J+BR9c5liexCLRZnt3CFO9ENNV/rlnzy+y2ccv7rJtOvMyJ//j+OKzmlT
 mANTXuVPQE00S/w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

vfs_link, vfs_unlink, and vfs_rename all have existing delegation break
handling for the children in the rename. Add the necessary calls for
breaking delegations in the parent(s) as well.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf42f146f847a5330fc581595c7256af28d9db90..5bcf3e93d350ffd290f72725c378d3dffeeae364 100644
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
2.51.1


