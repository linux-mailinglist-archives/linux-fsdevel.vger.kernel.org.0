Return-Path: <linux-fsdevel+bounces-51571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022DAD843B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA5C189B00B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C62E62DD;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hj4H9CMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0D2DECCC;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800079; cv=none; b=LveKyxsp1mGc5aSiVvn1Jme5zmWohK3WNSKn5Vp28+3fd2UG6ET09edYHM5c3ckZoQO8nx+AvJSjXQFR7kldMhspSoTYQx5hlQ9M/dhlF1QIoVSAlMxQKej4hdJcwlvR+R1ODXpJNczVjcpKTWzEpHWajGDQ2M5JqQkfooHX2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800079; c=relaxed/simple;
	bh=AJ/iBAARWg+hiQ5XuhDNoVEfdp/Rg7GrZuBckcuK9/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO3ZbkAFKqYf27GjQtdWmKRflHXYGHJY4q4en9LZpaZ480CUnbZ1mKtjzICppdKNS7b0PMwgT1yj96dFvTpIGQtBwi2YNo+5lNIkMBcQthts4SRLe+bu4Sc3aV0fU5Lgv8PZubgxS/ruDU7HqOLRVPqD1nJgHCdJ6BjsAtVCIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hj4H9CMH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WwU2MxvvT6viCDTE8lan9Z8XY4uaHgfShOqyFMlRjAU=; b=hj4H9CMH8lXq0NQ7B+l8gYldp8
	C6/cOrXEiG21N7HSDjuryqhwiTcEEvzVttx4BXa+w4YC7aRgs8+zCqt4p8j+vHmS8yVjGcfdohyaU
	KoyUqpkGMNZJQiC/RuF5thsUEMx+9rQouzDrZo2gqhUlybxZqCcOaBTJo9L/vsJVEdz5egq2oHumZ
	Gob+XEFRdSMzhbH8IGrtLY9mBV8dClc04lGDlLXojNWo5rggFRLhho0/YbWTXb7GdAikXQujZbM9h
	F/czhicZg6fi4ovlBJoGFjsO2fzGEbBbZL20AmrE8Wk2mCRBWdbFSABRtr6mE/KGjGK9k05DtFdV/
	YK4aFJTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqZ-1N7q;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 12/17] rpc_mkpipe_dentry(): switch to start_creating()
Date: Fri, 13 Jun 2025 08:34:27 +0100
Message-ID: <20250613073432.1871345-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and make sure we set the rpc_pipe-private part of inode up before
attaching it to dentry.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 83 +++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 8f88c75c9b30..a52fe3bbf9dc 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -485,31 +485,6 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
 	return inode;
 }
 
-static int __rpc_create_common(struct inode *dir, struct dentry *dentry,
-			       umode_t mode,
-			       const struct file_operations *i_fop,
-			       void *private)
-{
-	struct inode *inode;
-
-	d_drop(dentry);
-	inode = rpc_get_inode(dir->i_sb, mode);
-	if (!inode)
-		goto out_err;
-	inode->i_ino = iunique(dir->i_sb, 100);
-	if (i_fop)
-		inode->i_fop = i_fop;
-	if (private)
-		rpc_inode_setowner(inode, private);
-	d_add(dentry, inode);
-	return 0;
-out_err:
-	printk(KERN_WARNING "%s: %s failed to allocate inode for dentry %pd\n",
-			__FILE__, __func__, dentry);
-	dput(dentry);
-	return -ENOMEM;
-}
-
 static void
 init_pipe(struct rpc_pipe *pipe)
 {
@@ -546,25 +521,6 @@ struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pipe_ops *ops, int flags)
 }
 EXPORT_SYMBOL_GPL(rpc_mkpipe_data);
 
-static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
-			       umode_t mode,
-			       const struct file_operations *i_fop,
-			       void *private,
-			       struct rpc_pipe *pipe)
-{
-	struct rpc_inode *rpci;
-	int err;
-
-	err = __rpc_create_common(dir, dentry, S_IFIFO | mode, i_fop, private);
-	if (err)
-		return err;
-	rpci = RPC_I(d_inode(dentry));
-	rpci->private = private;
-	rpci->pipe = pipe;
-	fsnotify_create(dir, dentry);
-	return 0;
-}
-
 static int rpc_new_file(struct dentry *parent,
 			   const char *name,
 			   umode_t mode,
@@ -704,8 +660,10 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 				 void *private, struct rpc_pipe *pipe)
 {
-	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct rpc_inode *rpci;
 	umode_t umode = S_IFIFO | 0600;
 	int err;
 
@@ -715,16 +673,33 @@ int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 		umode &= ~0222;
 
 	dentry = simple_start_creating(parent, name);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	err = __rpc_mkpipe_dentry(dir, dentry, umode, &rpc_pipe_fops,
-				  private, pipe);
-	if (unlikely(err))
-		pr_warn("%s() failed to create pipe %pd/%s (errno = %d)\n",
-			__func__, parent, name, err);
-	else
-		pipe->dentry = dentry;
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto failed;
+	}
+
+	inode = rpc_get_inode(dir->i_sb, umode);
+	if (unlikely(!inode)) {
+		dput(dentry);
+		inode_unlock(dir);
+		err = -ENOMEM;
+		goto failed;
+	}
+	inode->i_ino = iunique(dir->i_sb, 100);
+	inode->i_fop = &rpc_pipe_fops;
+	rpci = RPC_I(inode);
+	rpci->private = private;
+	rpci->pipe = pipe;
+	rpc_inode_setowner(inode, private);
+	d_instantiate(dentry, inode);
+	pipe->dentry = dentry;
+	fsnotify_create(dir, dentry);
 	inode_unlock(dir);
+	return 0;
+
+failed:
+	pr_warn("%s() failed to create pipe %pd/%s (errno = %d)\n",
+			__func__, parent, name, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
-- 
2.39.5


