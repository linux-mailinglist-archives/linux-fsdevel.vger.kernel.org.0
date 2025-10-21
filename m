Return-Path: <linux-fsdevel+bounces-64945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B016BF7540
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2C919A1614
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239E345723;
	Tue, 21 Oct 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZNAWojH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BF3446B5;
	Tue, 21 Oct 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060369; cv=none; b=JOqqgZ4Eya1C/d4PJ55pU9UdN/pdJ+SsOKgHKZ3Zl2mV1q16EXG1FN+eXDrNzODIQJ58zIVb4AZ1j/WJhJUPnJ4u1myfDl+9KShhpJcsnXMZsQfF/mIZQ8pxvHNiiOadaQljmw0/K5lgO1s5FwCLMNLrJkCuBjF1UP1YwauZxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060369; c=relaxed/simple;
	bh=i348Ph7fxJZlvNatYcFVNpQ/4JzywLWgI/chglRS2Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMKQu0FSIX89EqgN2m6z425thO4r9KKewmxBT0ru1FlS13+ERV0NbMA/oz0IDH95Dflfu/mUO658/WeiQUH7kXFf0xqdwt3FzdCL3xJzVV0HPzIaU6Kj2rw/lTLNXT3qopCrmhaRqnvItXhYA52U1xkZaw2BNB6Pc7W1DJ1MuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZNAWojH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEEC4CEF5;
	Tue, 21 Oct 2025 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060369;
	bh=i348Ph7fxJZlvNatYcFVNpQ/4JzywLWgI/chglRS2Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KZNAWojHSy0zMPLG2xp6wivs9G8aFPa8C8r9uP2a5IrVN9y3NVaZDv1JkpXCBpCIM
	 ST8OgKfLxXMQtxryT95GKpqKO4weyBNYPg8pqN9A3U6hzu7ykXlR885dKzYqV9AxNs
	 9anObsKA1PNJbqB/8jKpma6b5mVCbDq0mzR6R/GXkxNOnzLnhH/ldXwM6VXxUsLJ1Y
	 qG0eUmnQKR89yTyCNvOSPNT8Zsy3YwuzmttQevfeBew5EEjs2jGeJNBBSjJsI8pPue
	 MGWlweEjr2nvfNI946p3qn4dM5oTvWRWUFd8dVdMi3oQBI+oj9cVW+sbI2E6Z55/m2
	 hhgm3k6IIfyww==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:37 -0400
Subject: [PATCH v3 02/13] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-2-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
 h=from:subject:message-id; bh=i348Ph7fxJZlvNatYcFVNpQ/4JzywLWgI/chglRS2Bk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YESrzIdn0YyHqW0yDMTvi1tTcZpTcDxDe55
 NNB2EfxRnWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBAAKCRAADmhBGVaC
 FaShEAC7Aq23NlSZeHJDisQkXnXppDvQlgXgqlrBkyprAdVBYTB02zjmLMSisSrLjw/8Ubt5xAf
 LAoSAe3cc0bPVW1H7nersMBONx3k6M2AhV7Tk8/Txj6oyuEh02z4uaAhXZ1O/ahqK9QGFhvxw3w
 iHkHLluu1KqjHXfm1b1luACSjxYuh9MSJRrOLHXZQorM9ad70ncsp/pzgq6JJWXGB3k4hOK0AQi
 3NzKtsSC9kzcMfNrQUxqshhp4OjEGqhIs80EqzhIL9fw301TztNF/6nEELVrSZHrM66hsqMUpgC
 0EhRPdK8pCFAxV2jclcIlwlytSWdzdV3ujYs4mjMP0erP5cQPl2vu+ZGVLpXOwQyK6tAKlJGmEy
 LKEV1e5IdIlkcB/hbqPuDgvmrKAkUlIiB4nxzCgNxfkQYHnQXUbV7oeZB/SRZ3fqt+93za8PyHD
 CeE0A46aD2MEBBz+oSg8wOpw1UbQuoBNoWJ1Bwki1T98lb98ga4cWkML2J+QTggqgbymSXHJgXB
 vplUt0C2yMvxLRFKi/3kUsgCBuJnz39uBEaAI35RQ9EuTJHjM4RRH02CHfggoFNbITfPpdQQWOB
 Q+7hFHWvRRawbvuWkpGfB9qH8I2ZLYDdK/9WCEMK4/u+nQXJ79uqRs9H/746M/3AIAehNnfqQ47
 N/rtmRAkAxlIV+Q==
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


