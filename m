Return-Path: <linux-fsdevel+bounces-67163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D8C36D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D529434F735
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA58342CA9;
	Wed,  5 Nov 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6QU04ya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D70341ACC;
	Wed,  5 Nov 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361667; cv=none; b=C4GSMixImEwx+TIRfUH/lflCPq82lWKN9VMkH8w9rZ4pNh0sSoZgGppY/8TnM6N9y5jE1yy26YZolsnLQvFL06PQTgMkhWVU4Eup6VGBaxJjB8AfgokAVXTS1Nt6VrUBf1UK4GyKXO4LVVRzOStEDLK+aJRnS7wUxS7A31eTEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361667; c=relaxed/simple;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZfGoQdau5Z8SxpB5EjD/X0dFOcYByUAaAYOaoC8EDbO511vdTs4GIKCdujJbMUhqIAMJdZy5t6skoF2/vTk9FxNhSt5WvT4aasvDReYJFueqygq538GLB+W1jI1lizuS20dsp5AWVb5rVd4BLDd20pD6L9JkwFPkYPnJXlBMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6QU04ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768BDC4CEF5;
	Wed,  5 Nov 2025 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361666;
	bh=3+ZClpFIpySqsQF9IacI3LgDcwpX/JfG6YtjN83vd9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6QU04yaFVASh9D9aUDxbgzVCRgbIYXAI3/IkF++zTRdI/MSgRg1TcXF1TE8W4Et4
	 VMWOQnVKkCo/mCIUVYqNpwbGiUJXKdxoH9gKXpy1TmMCOjTzC9uz7DLkLC7GWhgYoI
	 wkSD6Jelon2Y2kXHr1L/OMKzCZeh20SLj37p1kHOoTLHMQxaY1Jo54lDe1xWC4aMi6
	 kAvAtAsU2/ue8nMbVpBVKZaB29c9CPqlzMygtuLWnKZ1SYQuDRO0nJ201THIjIF8ZW
	 wgnC4RqPHh9zoGZealY3hw+TVhmDmGhJ2vkMZTJcKywzOlrhlNBu4uilHJxyqT8pE4
	 2wP0fLskJH4KA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Nov 2025 11:53:51 -0500
Subject: [PATCH v5 05/17] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-dir-deleg-ro-v5-5-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
In-Reply-To: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpC4ErSTvwO6KqZ2UnxssHQPNA/tzdjcWxFtshh
 3hCPwzM80SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQuBKwAKCRAADmhBGVaC
 Fb6PD/9g4scqOiSBEL+2vOllOWmp0Sh6Zpy8m/gtGl+pukCZirrupXBCuBiQtAfgAv/L5WDaXjO
 2/zx31lESIUJnq03f+Ty9wpvmQQ2BlrOANAXuqiC3RzwN596eMrvylxxbCL5VguATwfwgfdMCFQ
 LwQSCE1yz2AUyEXmwS+YqjaIuAMxdcRBVCTHj6sofsJR4Y/xh+zU+Web2rGfV+ADXkX9lHlBfZj
 znObtjZmiOkmg5MXUOQnSgJLGFHgGl+9YRQQoIa/XlKye2DurfasWVqUtX6bYDKrSHQE87g5Bte
 5RRn4RL22A6VEpwbpWokmkBOZZ7hqa6RO+/vXJ9Obgow2UZZEjWXv4p1nhV4T50XSlUWyRvnMuy
 l3y4sSZibjE0A+6yOupBi/S4lG9Stxa+cq2eV02yGIFkBnZUcBwM/J1UDXps1bsECsxMGZeEwQf
 2PTudQ6duXGBKeLgAehexXrGLcmQvebhF/mdHUsuKFCf79/wgRaufZPUVPiwRI7QWfzEDu24F/x
 zJ0R9PK4vl080tFzA4wGs3ZlfusgVXy+NrNbN463WvXzDphdaTAiI2nxxbyL3H9SfM40iih0QMH
 /+PXHoHj7q63elF9RWQkBn7iLUPxEtEbxvFrNq0cN4zdjgTO7bZ0KDo95+9mbhVf+4fepuKXQjy
 bBLLG+gJrDT/lpA==
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


