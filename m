Return-Path: <linux-fsdevel+bounces-67942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C5C4E56A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A0A1884091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D935F8B6;
	Tue, 11 Nov 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBgLV+Y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3E33F8A7;
	Tue, 11 Nov 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870400; cv=none; b=awtQTmDYdFeIMPNn0ERKE6Lt7AUVJ1faTb9Rl3AqOJvhOxZ2k8hkWsipBofMeWzivxdQgCZhgHg8ioY5t9IWFeQ1nTIkbC3pQFXggXt4KSWWon82Ub000m90QcV5Zae23Obuzt1hHqfrjrXhLgw1/D37ew9EwNALuwZR12FGbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870400; c=relaxed/simple;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcgLkqAiZmzhKk7PHML0ORtKeSXnrsZeir91CPfJVtX8cyQKZZ+FFeZkZyg3JqbQKlKg7uWJ3picQrLHkgkep6jIKwWCUlzEP/LJcG3N0iZSWusg2JrkGU9qMqUNVttnMAtLPKB5Oe2Rl6pPMmM/sn15WfQneb4YZfVxkfwsvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBgLV+Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6969C19423;
	Tue, 11 Nov 2025 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870400;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BBgLV+Y2bM2cCIEiouEHiXnUo6Hc6aloXBXMBLGsp1JmSbQmkZolk3kPcbtIJP1Ru
	 J62tYSNG+SL7GAvRKAuC3APnQOIC1ISdBi5WgpqjUW+RiYEzHT4biA1k/ChCdq8IQy
	 TCXSuy6dW4dD3pwBST1Qt4lGZUqXb97xFISMKeQLNQfx01h9FsuUQN79gEo5kM+cI4
	 fJ0g4Cgk5nqe+hooQdtGPXkpQvJiQcp7rpHwj6bTgyzMx0ZXZzknTJalGDBFqplol3
	 CET8GVXNvKj2j+uj+lAvqlrrRdAZVvyUmISDW9ug5x0dEt8wE3YkeoaF34GBOpgk4d
	 8p0UJWQJ4DhRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:46 -0500
Subject: [PATCH v6 05/17] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-5-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
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
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RnGMZtdn1x+LYL7VkmMQxhx/2imw/qsb2u+
 ANbnARa4weJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEZwAKCRAADmhBGVaC
 Fd1MD/9rBfdwEp19fPzoIbMxyGyERq7h5UvA+/X6v4WNDDlRIuc0LUM3J1zhJKeUTFHrjjCTa+T
 W2i2rXMwkpcwwpzhxzniLIV/fMsVMkOsTP5YY+woGbayopCeNok5yaQITIrjrYTJNQuYQUJ2O/e
 DGtYIMWXVJ7nRvez6zvMm8nXYpMpFN2eN4zmTbC4tpCTGKFjrVOEXmyvXhp+j4KY6MryXSkKfbV
 Pq1GZ3g2vlCgJfSRzljBl7MLWKHg8MXvM5C8orWtthHm2rUbECe6r9uuSFWTS+bqPoHdNKGdF+G
 HAoRc87XuVIVhVGonOq5UF9GBfm+0LifJLvkBeP6kSxp23gxvv79W9LUB0T2ZegbBJwQkgrS92u
 T/QaFWikIb03PVrLM2WFieX+6YDky7PG8I4lBntkSgsHeN7/cm8sMshpFRvSMvX2nI4mF56Mnsn
 JdEyuoT7DPPlkZ8qByPxi4dIdhI3tIQVqYomMRFS9OTgGKovmPs3/37nWgiUL35qu6LnziVgKdV
 gEvxankJuGVgAdceIrAWUMtpPjh4bd7xrkPPLwEB65OY/LxUDfw1v7i4ipttVfyeIPegC41eJ98
 lApAcuJYFpzi1YktAfqBj9dAOk/yI6tSd0XK7WdNjvAUwJesNHoOFoXy+8n62cgc/+k3545wWFk
 EC8E5CPghYnDkOQ==
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


