Return-Path: <linux-fsdevel+bounces-51560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A1AD841F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50123B163B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3E2E175E;
	Fri, 13 Jun 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s1QQeFCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640D2D877C;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=llrnu5/U+TkO4k5Wih2qGVs0L+okpyCcs7Rh5212YCdy2OeOE4hS040vBw1G3njnuQT1GJdo+mXux80IAEfAq8/LtH7haDolJo9WY/R4UbvQtbPVz7k3nF/D8QhCsxI79M0VJKR3+eef+CtxfEZG2bxjRk9ZdAIg6qJZFDUtNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=lkqzpEz5YjPhUa4ggLA3hs8e1o0VEw+At00NhXqCmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibvjY/+PzgeLT0lpCzA7QMnVBRSBErfHyIJbIwn5KW0nW03jJwZfOnnRm3ya6OP6z+tmexONLdF+d3tXeOjWkbnpXofd7fHuupcP7VUi0Oz1plxO5uC06SooCNTeMUvHbWP21FFtCs76coQmqeEQT6zqiqBjN2Foe0Ijl/tJM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s1QQeFCk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ie6EZz8DmgqI8Uw7/nlSoN+ZU43kNcGnpWi0x74r63Y=; b=s1QQeFCkSJlifJEaE+r3gvWGbR
	RiCoW1+cu8vEYMY2rC0hQHJJ73P8cnxGRejJqsEyeAIUXhxNUn5EkZ9xh5F7mskXLGjghAce7aLUZ
	frWS3zaMDHP9XaCkE50/U2nl+rRdvxGOl/eSiveqJmo2Xgxltlzgmw3JdejkP4WKeQcKGvzuKuvM7
	PhnqLasF01+WMmzZVwxOYvxeQjmYUO2J5nR1Bogm/mAyRSrXgMRtZ00ts3IVKqtqs0677SZLVy/iT
	iezV+G6wCL3XKgmXEiVArlkjwJcT2Iu3fXq40yG3amcMKg+d/AJwFWcXJkJj1fCDuA9Bu/RGOJoWP
	uh1e2IWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpo-2Yjw;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 06/17] rpc_populate(): lift cleanup into callers
Date: Fri, 13 Jun 2025 08:34:21 +0100
Message-ID: <20250613073432.1871345-6-viro@zeniv.linux.org.uk>
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

rpc_populate() is called either from fill_super (where we don't
need to remove any files on failure - rpc_kill_sb() will take
them all out anyway) or from rpc_mkdir_populate(), where we need
to remove the directory we'd been trying to populate along with
whatever we'd put into it before we failed.  Simpler to combine
that into simple_recursive_removal() there.

Note that rpc_pipe is overlocking directories quite a bit -
locked parent is no obstacle to finding a child in dcache, so
keeping it locked won't prevent userland observing a partially
built subtree.

All we need is to follow minimal VFS requirements; it's not
as if clients used directory locking for exclusion - tree
changes are serialized, but that's done on ->pipefs_sb_lock.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 71 +++----------------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 67621a94f67b..46fa00ac5e0e 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -594,32 +594,6 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 	return 0;
 }
 
-static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
-{
-	int ret;
-
-	dget(dentry);
-	ret = simple_rmdir(dir, dentry);
-	d_drop(dentry);
-	if (!ret)
-		fsnotify_rmdir(dir, dentry);
-	dput(dentry);
-	return ret;
-}
-
-static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
-{
-	int ret;
-
-	dget(dentry);
-	ret = simple_unlink(dir, dentry);
-	d_drop(dentry);
-	if (!ret)
-		fsnotify_unlink(dir, dentry);
-	dput(dentry);
-	return ret;
-}
-
 static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
@@ -636,41 +610,6 @@ static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 	return ERR_PTR(-EEXIST);
 }
 
-/*
- * FIXME: This probably has races.
- */
-static void __rpc_depopulate(struct dentry *parent,
-			     const struct rpc_filelist *files,
-			     int start, int eof)
-{
-	struct inode *dir = d_inode(parent);
-	struct dentry *dentry;
-	struct qstr name;
-	int i;
-
-	for (i = start; i < eof; i++) {
-		name.name = files[i].name;
-		name.len = strlen(files[i].name);
-		dentry = try_lookup_noperm(&name, parent);
-
-		if (dentry == NULL)
-			continue;
-		if (d_really_is_negative(dentry))
-			goto next;
-		switch (d_inode(dentry)->i_mode & S_IFMT) {
-			default:
-				BUG();
-			case S_IFREG:
-				__rpc_unlink(dir, dentry);
-				break;
-			case S_IFDIR:
-				__rpc_rmdir(dir, dentry);
-		}
-next:
-		dput(dentry);
-	}
-}
-
 static int rpc_populate(struct dentry *parent,
 			const struct rpc_filelist *files,
 			int start, int eof,
@@ -707,7 +646,6 @@ static int rpc_populate(struct dentry *parent,
 	inode_unlock(dir);
 	return 0;
 out_bad:
-	__rpc_depopulate(parent, files, start, eof);
 	inode_unlock(dir);
 	printk(KERN_WARNING "%s: %s failed to populate directory %pd\n",
 			__FILE__, __func__, parent);
@@ -731,14 +669,15 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 		goto out_err;
 	if (populate != NULL) {
 		error = populate(dentry, args_populate);
-		if (error)
-			goto err_rmdir;
+		if (error) {
+			inode_unlock(dir);
+			simple_recursive_removal(dentry, NULL);
+			return ERR_PTR(error);
+		}
 	}
 out:
 	inode_unlock(dir);
 	return dentry;
-err_rmdir:
-	__rpc_rmdir(dir, dentry);
 out_err:
 	dentry = ERR_PTR(error);
 	goto out;
-- 
2.39.5


