Return-Path: <linux-fsdevel+bounces-51572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834EAD843C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A62189B40B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371352C3770;
	Fri, 13 Jun 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HD1rpNQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6E2DECC9;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800079; cv=none; b=fei3Wcy1Bv0AfgeUxWEDHTz7h2tkBJUwmoDlf8rRFDq58xsbr4cVzMBwnopXjP0zwlVLU8OSvstE1TaAHTnhHrW6hPzWTGLIwPQ4PYq20W2kRIjb1iemtCWjyAl/MF9hA/gPxIM7cswSrfpNSFdcjjhorr4AiQi3FOXPIfKEy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800079; c=relaxed/simple;
	bh=8e8y0cH4NE2GLDLxNVdNTat5h2pkIRVNT7ZWAE6izj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA6x+HYN1RAJdtdCFdL28eMb5iWGAO8BccKdsn2TFRUWy5x0Lq5u/HJsvLvAxcqjAy/QTIR9VMwwwUjRd9oPJrAf0GJXKSTNOK/8HldYLMQh9+icSE8+f/CeCzPleQRPWK6SwQLUqy2hJ8f1DDcCiB7XDJkykpH/ZG1z9xn5vS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HD1rpNQU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=26B+rEysAikMF6LvQvkO/EINK07ZM6LEtCbjOLOwf5g=; b=HD1rpNQU6eoo90dbVjXTcIfSRW
	Pi3UFZXlT7NW70fQdaDTOH8R9WjzwPmTKbVzb4OdPih1dyg7WJyJhKkjiQ98B4LibQrmyTwUvVSxN
	1Ls0BsAknLaN6MGZ++FZKJgiAX7buOC7gCyZa88u+DZF1xezjjNLl4iNG3VEZjmCqxsDiacHs4kg5
	9TZ2xmtL9itfgQ3slfoZFYBpuWqHZWu195nsBrwVj5bwh6GvNAYk/UE+11UbTmn0255smbKv6fvGo
	g7Y31C/E/PJoqLZpLkiOlZ1oKI1FUEK5Hj8TeqBwyo4fH+QxZdGfojtpntVz9UHc83rP1MYn4Kj0W
	G3o2RIiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqh-1iOO;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 13/17] rpc_gssd_dummy_populate(): don't bother with rpc_populate()
Date: Fri, 13 Jun 2025 08:34:28 +0100
Message-ID: <20250613073432.1871345-13-viro@zeniv.linux.org.uk>
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

Just have it create gssd (in root), clntXX in gssd, then info and gssd in clntXX
- all with explicit rpc_new_dir()/rpc_new_file()/rpc_mkpipe_dentry().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 55 +++++++++----------------------------------
 1 file changed, 11 insertions(+), 44 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index a52fe3bbf9dc..9051842228ec 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -997,7 +997,6 @@ enum {
 	RPCAUTH_nfsd4_cb,
 	RPCAUTH_cache,
 	RPCAUTH_nfsd,
-	RPCAUTH_gssd,
 	RPCAUTH_RootEOF
 };
 
@@ -1034,10 +1033,6 @@ static const struct rpc_filelist files[] = {
 		.name = "nfsd",
 		.mode = S_IFDIR | 0555,
 	},
-	[RPCAUTH_gssd] = {
-		.name = "gssd",
-		.mode = S_IFDIR | 0555,
-	},
 };
 
 /*
@@ -1097,13 +1092,6 @@ void rpc_put_sb_net(const struct net *net)
 }
 EXPORT_SYMBOL_GPL(rpc_put_sb_net);
 
-static const struct rpc_filelist gssd_dummy_clnt_dir[] = {
-	[0] = {
-		.name = "clntXX",
-		.mode = S_IFDIR | 0555,
-	},
-};
-
 static ssize_t
 dummy_downcall(struct file *filp, const char __user *src, size_t len)
 {
@@ -1132,14 +1120,6 @@ rpc_dummy_info_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(rpc_dummy_info);
 
-static const struct rpc_filelist gssd_dummy_info_file[] = {
-	[0] = {
-		.name = "info",
-		.i_fop = &rpc_dummy_info_fops,
-		.mode = S_IFREG | 0400,
-	},
-};
-
 /**
  * rpc_gssd_dummy_populate - create a dummy gssd pipe
  * @root:	root of the rpc_pipefs filesystem
@@ -1151,35 +1131,22 @@ static const struct rpc_filelist gssd_dummy_info_file[] = {
 static int
 rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 {
-	int ret = 0;
-	struct dentry *gssd_dentry;
-	struct dentry *clnt_dentry = NULL;
+	struct dentry *gssd_dentry, *clnt_dentry;
+	int err;
 
-	/* We should never get this far if "gssd" doesn't exist */
-	gssd_dentry = try_lookup_noperm(&QSTR(files[RPCAUTH_gssd].name), root);
-	if (!gssd_dentry)
+	gssd_dentry = rpc_new_dir(root, "gssd", 0555, NULL);
+	if (IS_ERR(gssd_dentry))
 		return -ENOENT;
 
-	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
-	if (ret) {
-		dput(gssd_dentry);
-		return ret;
-	}
-
-	clnt_dentry = try_lookup_noperm(&QSTR(gssd_dummy_clnt_dir[0].name),
-					  gssd_dentry);
-	dput(gssd_dentry);
-	if (!clnt_dentry)
+	clnt_dentry = rpc_new_dir(gssd_dentry, "clntXX", 0555, NULL);
+	if (IS_ERR(clnt_dentry))
 		return -ENOENT;
 
-	ret = rpc_populate(clnt_dentry, gssd_dummy_info_file, 0, 1, NULL);
-	if (ret) {
-		dput(clnt_dentry);
-		return ret;
-	}
-	ret = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
-	dput(clnt_dentry);
-	return ret;
+	err = rpc_new_file(clnt_dentry, "info", 0400,
+				   &rpc_dummy_info_fops, NULL);
+	if (!err)
+		err = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
+	return err;
 }
 
 static int
-- 
2.39.5


