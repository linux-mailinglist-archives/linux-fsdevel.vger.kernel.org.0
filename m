Return-Path: <linux-fsdevel+bounces-64479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9599BE8592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5245935CAE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646A21B1BC;
	Fri, 17 Oct 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZQXdcqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CC243969;
	Fri, 17 Oct 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700750; cv=none; b=qTVX9rBjhprn0e1k4DOdKDe7E0xzxkHasmB57aNijAxrE6I3DM/HxhECpVpsz7QWiUzcyL4bqOrjWGJofhrWBJhRHVPoDPM+THZtebG2vvd25n4tIIHZNoz13Nu+19lLiT1t2K0z9aEM1S58NFcQRx097DGuNwAaDQYBh7Lps7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700750; c=relaxed/simple;
	bh=DfXWfe3J6JP43Ux1a6sZKAEITJvGozUQi9wSKd1pfSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEKwwkLhKG3ndWRTZO/qa94iyb6nKRF+7cW27+kaFkhPe2xipJBC8zuli33ZiHAuAkVJEZ6hmugLSvVBJXOpvoUaLMpjy74l3VNwwGSHKc6+9fmknuNlpmvcpyTgZzRyU0Z7z1AZdv3DJ5Sl8uV4mvIE6xKS9r7qb6xphBCPWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZQXdcqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593DC4CEFB;
	Fri, 17 Oct 2025 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700749;
	bh=DfXWfe3J6JP43Ux1a6sZKAEITJvGozUQi9wSKd1pfSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZQXdcqBXZBTDNpq92GVE2t0F4DVnA5PEccQJTxEvjp/uk/bbNwKsHV643BNEEZ90
	 zDw3GOJRIM9WUhfXLubrQpRVq02aKtyUTnUCVH5X/CUCw1zdT/y0MT23LS6NcurVNy
	 ndFekQ2+PGBtq5WsuQtPHp9WvciwRCPJLDjesifXX4kKV4sjJg6FMYNQnhSj+buAkp
	 v6JzAdmSuzm6DieTVTh7vmo5lIw4LZdQhyg3A/roUiJ9wOG9Rc6EyeVVhN74l9fzS2
	 0CIg0YSFp28SYVXYDFwJqV2DSTckLjmoRtepY5/vo5yz4kpfJGiWOxH4Zw69o3lO2z
	 Xo+RD87i4Gn0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:31:54 -0400
Subject: [PATCH v2 02/11] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-2-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilAN+ikWjrHaX/OAFroMEY3fNO3V+zI3L/wQ
 aPqQB2Nub2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQAAKCRAADmhBGVaC
 FXvbEADRwufv1CGsbQDcBQnYpIc8VIiT4K59XwkYcyy4KNnpVd7AZ/+sWJj1NxbjllepFE6kx+Q
 R/1mLpZoqyvnzMM0al01nsF0wzrz0dkM4tE9OuN5NUPq0e4V1yDdFYMjqnTvxtx4MqDvgB+sTfa
 LUk661uV6zik/3hdk/uCOLyLg6zxhyXO9jivEu7Y8TuNAkzBIaYOcSqngyMt8USh0C0sRQVsDEf
 rsCe0/0ErNkEUsq0HDMsMMCzbyDLijCzfqecv+zNndTXob7P8qS2B3+fT8yaAYcub/+0SweSw8u
 yGYwJHWhNQ38WXbOe6NKoNzMLLUjuXH3th/BYq8vZb2S6jrj3ueMeNgY9ULtD045W9vKYma1J9d
 px+yN5h7YFxKh/XTgUORi7X6eQHnxNlz3jQPEounbAwNMxOToRYgeBsSfYi9GH7hwAHXX6wUS02
 YE3KcULTJXDd0dmBATpUQqkSWtp9S+x3U10EIkM0aMLOMXH1fOBU/ZW4jEjyqrRjv2qNbqVdXuk
 j+fqk5AeBKve3UzMgOnYJ5zxOJvwFAg4ITBRfDD1R1G7V7D3WGLnm30nqcNMGitnAExnZBE21A3
 dVb5GAV+0+ci0jDEd9Ffdpg406SiXox6tZOZtO6BytSnQV4FN5OsADlBh+axBt+Edegk7neJJ+Z
 SnXY7F5EpBKnmgw==
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


