Return-Path: <linux-fsdevel+bounces-14510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14987D235
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B31F21AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF65F877;
	Fri, 15 Mar 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPqL1sgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E215F552;
	Fri, 15 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521658; cv=none; b=dBJp9vyfrzmDXm+U8UNWK/taPZ7w+lRIcVaUFDuOLhK2QTQUbBQdB1Tw5uTMaZt5ntlkacpqSvqeERtQ8meeIbBQh5najxrKg4wdujynddon+u/+tsMrgjUuly0Mad4p/8zqp2uM+w4wzEirNlnZW8fkXzJDoYsGvgDa8dKcSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521658; c=relaxed/simple;
	bh=cwlCJIwXq4jLYj8xEadkur+JgJytFkV45+NwlxKS2a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ubs367vwC/T4JJZQiQV4Z6+M2WzllvedS2tLALXpsQGLLbtM1lkGxBXtPtB3RTLI6xfFSINng5e6wBQTfMlD8iFdL6JWqxGJa67On2FoKSp5qcva7etwEBHW7TQoSX/pN8br29K+jljP3WELN57qUx1O1RUq5gL5+g6A6rljN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPqL1sgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF7C43399;
	Fri, 15 Mar 2024 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521657;
	bh=cwlCJIwXq4jLYj8xEadkur+JgJytFkV45+NwlxKS2a8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tPqL1sgnIbKuNXMdfr6Nq20Jxh4ZY8k3BC/LIY8ogvxyKLhNu0pFcUKaUZXIRADB9
	 LtNZUmZhMG7uOJXJBAKgInIZZruVxf/w2KdWIqEm1qq29EfLCKGcXgQweQc8snGBcx
	 KR+fDqHBDmqxBeejTd7wRXW/JVOpiJv2sVmhZJDtHBR95sDA68tTLjpCsMlwpJVKXM
	 Ec6oNeT4luagh4UXxg8T+hXPd11kiIF7m+mTAkYQSdf6HnsSVeWCMZf92j3Fx8HsvD
	 xOv8xowmAZwYC3Xba10LT5vwbn1G8bf23UyuaMXLqGlr3a+qBnsgPmFv23o03/QHK2
	 JWlp6rWlExcZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:13 -0400
Subject: [PATCH RFC 22/24] nfs: skip dentry revalidation when parent dir
 has a delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-22-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cwlCJIwXq4jLYj8xEadkur+JgJytFkV45+NwlxKS2a8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzvUGXRZhpo+O5qRvOO/lXxItvQyNLMF8p79
 zQf7Owopu+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 FdfPEACrH+59z1NoZpi+wFkOJRpdR/q/s3fax50n67RvHg1kVtQvAVxXOGBKmKtnKX76SZTgO+H
 6x/qrY7yukKkFiqdZb7ovq74b6xgfzdl/UKCTRntf/TkkdbmYF3TyWSdweJSVakj2bMXDxZMlW9
 F6ezSmEPaEpTnQZ/1jBJ4x4UYAwV6nBKBFF4orFUjraxWjbE4PymCErndXXEIrbsT3psnzcL4OO
 94j3ujIdoDBGoyRSIi/ecqEISHT9Ba728/gYtCtgf8/hlLXnMZaxRLEnUq9++B0AKj/CbcL19Yj
 xNqSsv4LxTjX9d/WoMy/paRt2jkgI3YYwg4eqZGB6+3gjsuKnmv2SACmOw41IIo7aFMGyGDT3jX
 XhPrlvFuP2l9nJvHvGH5hi0WEQ0owON4os9IaXwcU4SWeukYhv5HJOfkwrvIGgjrPC+CM7lt9yH
 xBkU/7rqPMe2+kuIhYjDW8X8myF7StjHbfZb9ANxGYDRzcAkzeQtc1tUaUTn4v7MmQW65kr4Xth
 yEgpKlKSixMD9QfvSCaUPp4Go8X5tzipgwGU91IfNP7bJgvz+oWMi3VX6Cj4ehAXIlHgHOSy68S
 znaKqznDxWnxikviYE+FXPJW1Ov13luk71gN2iPY189OJdP0ypVIxXcShOFnhOw8e+Z+tMA4/Yb
 WKQM8jp5lLcH/mg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the parent has a valid delegation, then test whether the
dentry->d_time matches the current change attr on the directory. If it
does, then we can declare the dentry valid with no further checks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..061648c73116 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2188,6 +2188,15 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
 
+static int
+nfs_lookup_revalidate_delegated_parent(struct inode *dir, struct dentry *dentry,
+				       struct inode *inode)
+{
+	return nfs_lookup_revalidate_done(dir, dentry, inode,
+					  nfs_verify_change_attribute(dir, dentry->d_time) ?
+					  1 : 0);
+}
+
 static int
 nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
@@ -2212,6 +2221,9 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (nfs_verifier_is_delegated(dentry))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
 
+	if (nfs_have_delegated_attributes(dir))
+		return nfs_lookup_revalidate_delegated_parent(dir, dentry, inode);
+
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto full_reval;

-- 
2.44.0


