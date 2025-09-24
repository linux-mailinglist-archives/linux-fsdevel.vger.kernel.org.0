Return-Path: <linux-fsdevel+bounces-62621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7373B9B2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D704E19C7FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853D314B73;
	Wed, 24 Sep 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTxV/Nhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19731AF16;
	Wed, 24 Sep 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737185; cv=none; b=NBPEoznJ8Z0RgXuCnRBEn0ZrySQ4tNTQU+bFckf5JzV0Zssoau5KYtwO5BXOCfg/OF1W3HGeLCwnMPEzxJeCmh97LDkYedBcpRQpbdf2QfQ4UaZjTKNlujUehPRiem0vD6nCMATe2dzDcFE9loQozMZQ7a+cIi/DnnpxoPO53Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737185; c=relaxed/simple;
	bh=471fyt2PXq9w/sidnZtPLq17xCxME2NlEBE6WqhLIMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REb1fJASa/iBGTd8SEo0RqJ/TydKyxtpnfxYF85In2c83IYfAfYtBG6sBNLlTMFiSlWawKR/wcvmP3hLt1Omgw1iO6Hh1TumcmrUpKgHuEPMSd7qkt6wb8gsRjrg0MW+yLTPAk8kBOnBS0413m8FTmeqGdefJhfFtm2GFe5WkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTxV/Nhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808AAC113CF;
	Wed, 24 Sep 2025 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737184;
	bh=471fyt2PXq9w/sidnZtPLq17xCxME2NlEBE6WqhLIMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WTxV/NhnGse9KZIiZ7Z8d6i4eQbKoqTmtAPaV1Pt9iOBG1aHj8ppJhIo7IqZO3HyT
	 +AgHjV/HBqxdtkQOk9GrMViWnxqUSzZJNfB30kRg9hP259AwMDUEA9Ob9JxowfyEx0
	 XjbWjQHlNeImkkzYJu2i6dwuZePPauFi8ojhb5xoRXKcMnDD/iI7LehDPEBpqha0HR
	 xMkcee8uzrWy+oerrIha7igzGJlwFzusrlcWtdKWuFyre4VL/t+9rN59+a/3s6hbs9
	 LDjkA1GbC8M6ZR+0S6COkXAJ8LErNWgwp0kB4o374Tek5gtQomV57KJpuP06WA0n5I
	 LsMSsyt0N1cMg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:49 -0400
Subject: [PATCH v3 03/38] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-3-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=471fyt2PXq9w/sidnZtPLq17xCxME2NlEBE6WqhLIMY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMLDgT6Srym488wxcsB9KKdsr97A+eHiOhoL
 iex4KwABLmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCwAKCRAADmhBGVaC
 FYgTD/9VvdPKupCfAIWZZrrNrf//5NQGK28AugvkzOTk1Nxk4Qu3XGMaeq/WX09XOdUBVTc4l73
 bxrba6SPZrOTiLKfPcW93gMEPCdYqyY9WdF2X1XMorXTv5+ivNKVDLcIp9MuM/oDqxGTiVHac4a
 /L2z49CacnokNgO4TgJ5ddOJFeIdXlgKysd4NgNzc560dLy/sU1SpdywdxDwVsCsbTw+0ryH5BM
 EJEYc58suCTzwE1pKDJAlMPaYsdCM7/P20fxw8+yGYsdMjlSdoyPv47i4nyVlxVfw8ba9qudaqT
 NvFGIfWAAxalIEb5IVcO64FhEkPSThE56nMdXa5FXug/w5p1/ge+4aqJKuIi9SvbsEze4Z8sbZi
 cpgggM5vqxbbAUybV3NfoUEKiuFUZ0NlqZ6kg/SWfWWwl5S+9dpahYbg+q4Pp+CHdXcAyZIqI0m
 qrbxm947G/C5BW/1vf1sFnb5s4TDomSqiaP9wSGMXZC9dru/l+ygcfDvv0aVhXWzHd+Z3nmi1B8
 XYUCPzClCOM81qiOPTH5X+PU2TLZHEstUKEOxAxEhSV/ec8qT/HVVNKm+H5r1FBLU+OlnXE+9Gi
 hyVjzj4TAyTLKYJh+8W6Jltp3ZkD1FkUvUXBbN+JS5ir2YUoNC3ptdl1pTHs3RQPcczDKJyu6mt
 VJUAYcX4SKn7rXg==
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
index cd43ff89fbaa38206db2aec4f097ca119819f92e..cd517eb232317d326e6d2fc5a60cb4c7569a137d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4580,6 +4580,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	else {
 		error = security_inode_unlink(dir, dentry);
 		if (!error) {
+			error = try_break_deleg(dir, delegated_inode);
+			if (error)
+				goto out;
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
@@ -4849,7 +4852,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
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
@@ -5116,6 +5121,14 @@ int vfs_rename(struct renamedata *rd)
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


