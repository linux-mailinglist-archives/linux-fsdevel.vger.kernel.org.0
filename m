Return-Path: <linux-fsdevel+bounces-51567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D2AD8438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E8E189BA82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECA2E612E;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TfDxJ6vI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5302D8765;
	Fri, 13 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800078; cv=none; b=QsxttVTRgkkp6IEJx5M8dTKf3ol22sE26CC4khFztqCdEmxx2dIHyC0oNQCSVd2xj7S06LPEWlMbe3WNrN46kHn+of6Y0F9pVK7VnPBRQbPtixDnAVE9zVSqjgu76wb9IPbOS03WDyF+R8cS1n6C6WFLXJjdtQU6vmvh4Jm1P6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800078; c=relaxed/simple;
	bh=QnCm73DgZ3ae//ewOnc34JLmSAzVp4gY8JMGrTwlUfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSWWSAq5Wxw8JngjIl5WRqYJ5NbnYjzYf2bNrESCovKfSqLnvc77EtBchZDa439yi8YymDtiboFuxrQ81ytnvKNkXhxix16MFnQ4dCrVR/3NFs0MCjbAmtm7FP8HcyLFFahdcazbaJGfdBdMg93zl7dZRbsIeaU4ntdBqoJ1lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TfDxJ6vI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8i1qOMry5btHh+8xoNytWyAO+wP99bcN2uJBcQ2hjoE=; b=TfDxJ6vIkhgqjfMcL3MklxM8Z2
	Ry3DryL9PlD+30RziBhSprdNadz9oZHXh6PL5MNdfgweQk4UbxnOdDyhVMVO82sDcgVEndPyzlSNx
	aBfdI7IT1RI64mAB38aGNGMMogTbsb27MKAzil6RCN6/PuR7ncXqG/1XPHfXqlYMWdiHFUewt4wsV
	Oc17pNn28qiNxcrDesEfATVehIkOYLa7tY9ggCxPhC4LbRmQEhrh8iGTvVJ8nK49rYBUcNoTOlzMB
	O3CGN3NIJLdvaQ+evNX1T5GgZVtzDWRCfXJOXtjuV7WOFp9dYM5cS8RbYRMzwQLTSPek8iOpNB9ML
	Cp9vxjlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpS-1s3i;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 05/17] rpc_unlink(): use simple_recursive_removal()
Date: Fri, 13 Jun 2025 08:34:20 +0100
Message-ID: <20250613073432.1871345-5-viro@zeniv.linux.org.uk>
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

note that the callback of simple_recursive_removal() is called with
the parent locked; the victim isn't locked by the caller.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9571cbd91305..67621a94f67b 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -168,8 +168,9 @@ rpc_inode_setowner(struct inode *inode, void *private)
 }
 
 static void
-rpc_close_pipes(struct inode *inode)
+rpc_close_pipes(struct dentry *dentry)
 {
+	struct inode *inode = dentry->d_inode;
 	struct rpc_pipe *pipe = RPC_I(inode)->pipe;
 	int need_release;
 	LIST_HEAD(free_list);
@@ -619,14 +620,6 @@ static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-
-	rpc_close_pipes(inode);
-	return __rpc_unlink(dir, dentry);
-}
-
 static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
@@ -814,17 +807,8 @@ EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 int
 rpc_unlink(struct dentry *dentry)
 {
-	struct dentry *parent;
-	struct inode *dir;
-	int error = 0;
-
-	parent = dget_parent(dentry);
-	dir = d_inode(parent);
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	error = __rpc_rmpipe(dir, dentry);
-	inode_unlock(dir);
-	dput(parent);
-	return error;
+	simple_recursive_removal(dentry, rpc_close_pipes);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rpc_unlink);
 
-- 
2.39.5


