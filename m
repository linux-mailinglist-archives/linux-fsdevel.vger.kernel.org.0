Return-Path: <linux-fsdevel+bounces-51559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4BAD842A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0AE189B49C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AA2D8DB0;
	Fri, 13 Jun 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cG7ou85v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76422D6633;
	Fri, 13 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=tPPHyLZODlmvkxXWwdGyLlTyC7ZL+kcMTltB3BASrb65oWfnl3DlfRuBUgTyZrZIRfcwC1MqkrK2uYjWzyQhz6iDXA85lmZ1CGv5k2rLCMEXW+4KN+V+/odXlIM1Io06Whf9z1ijBSrpzKhNA/xoTm8nzRMRVvB03225cmIcJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=2GRlbDzOSFS8GGdy++z8bSoBOZCJUPuEDjPSmsPQnLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH88TDxXTb0OY4I3Wi4iU2gJlJuc9ftid5RVE0AmofeGz+moBm1MqIKe0QXUgjXldxu7kFqnnS9nZfIugpo8tn5NQU403mj2qClil0tQIZexJutY675nXiIaOkBMBjqgfiT4XuhMX6qloJtjBOg96rok4iTtz60KbzJNAPCfGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cG7ou85v; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F588zEM0h0U7uHwHc5wav0oR+hElK+Md0j8ACmYPDko=; b=cG7ou85v14YpidnvELYsEiTwTA
	mf8em5/Zy0MfF32StrjwWFVOW4oYucrATyVBrY47+micAW0MiGK3COz/sUm5YFQMrb6ABL7R844gE
	+JceEoHkAbkp5abaYQT8hI4RSQ1ulxi9wtymNfS6kpiEEkraCwJWTn5XdwOheMQtR1kqp56lvE4gA
	36eQJ3k3q1eJbUkF1bptRXkar6eAv1pRvjVz3WEQj/nWQPoUvT8qeFGkukoYvKcIK0Pz/nHfxuFD4
	ZSTGBxRujLvYOEL2wXSmgmwB8Cb/fYfva1uZDIgQYsIqMmMumAVXeuRThM5rfRvF1vgq1qMHdEZhO
	mZUBG+pQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpM-0hg7;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 03/17] rpc_pipe: clean failure exits in fill_super
Date: Fri, 13 Jun 2025 08:34:18 +0100
Message-ID: <20250613073432.1871345-3-viro@zeniv.linux.org.uk>
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

->kill_sb() will be called immediately after a failure return
anyway, so we don't need to bother with notifier chain and
rpc_gssd_dummy_depopulate().  What's more, rpc_gssd_dummy_populate()
failure exits do not need to bother with __rpc_depopulate() -
anything added to the tree will be taken out by ->kill_sb().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 67 +++++++++++--------------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 98f78cd55905..580e078e49a3 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1292,7 +1292,7 @@ static const struct rpc_filelist gssd_dummy_info_file[] = {
  * Create a dummy set of directories and a pipe that gssd can hold open to
  * indicate that it is up and running.
  */
-static struct dentry *
+static int
 rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 {
 	int ret = 0;
@@ -1303,58 +1303,37 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	/* We should never get this far if "gssd" doesn't exist */
 	gssd_dentry = try_lookup_noperm(&QSTR(files[RPCAUTH_gssd].name), root);
 	if (!gssd_dentry)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	ret = rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
 	if (ret) {
-		pipe_dentry = ERR_PTR(ret);
-		goto out;
+		dput(gssd_dentry);
+		return ret;
 	}
 
 	clnt_dentry = try_lookup_noperm(&QSTR(gssd_dummy_clnt_dir[0].name),
 					  gssd_dentry);
-	if (!clnt_dentry) {
-		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
-		pipe_dentry = ERR_PTR(-ENOENT);
-		goto out;
-	}
+	dput(gssd_dentry);
+	if (!clnt_dentry)
+		return -ENOENT;
 
 	ret = rpc_populate(clnt_dentry, gssd_dummy_info_file, 0, 1, NULL);
 	if (ret) {
-		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
-		pipe_dentry = ERR_PTR(ret);
-		goto out;
+		dput(clnt_dentry);
+		return ret;
 	}
-
 	pipe_dentry = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
-	if (IS_ERR(pipe_dentry)) {
-		__rpc_depopulate(clnt_dentry, gssd_dummy_info_file, 0, 1);
-		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
-	}
-out:
 	dput(clnt_dentry);
-	dput(gssd_dentry);
-	return pipe_dentry;
-}
-
-static void
-rpc_gssd_dummy_depopulate(struct dentry *pipe_dentry)
-{
-	struct dentry *clnt_dir = pipe_dentry->d_parent;
-	struct dentry *gssd_dir = clnt_dir->d_parent;
-
-	dget(pipe_dentry);
-	__rpc_rmpipe(d_inode(clnt_dir), pipe_dentry);
-	__rpc_depopulate(clnt_dir, gssd_dummy_info_file, 0, 1);
-	__rpc_depopulate(gssd_dir, gssd_dummy_clnt_dir, 0, 1);
-	dput(pipe_dentry);
+	if (IS_ERR(pipe_dentry))
+		ret = PTR_ERR(pipe_dentry);
+	return ret;
 }
 
 static int
 rpc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct dentry *root, *gssd_dentry;
+	struct dentry *root;
 	struct net *net = sb->s_fs_info;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	int err;
@@ -1373,11 +1352,9 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (rpc_populate(root, files, RPCAUTH_lockd, RPCAUTH_RootEOF, NULL))
 		return -ENOMEM;
 
-	gssd_dentry = rpc_gssd_dummy_populate(root, sn->gssd_dummy);
-	if (IS_ERR(gssd_dentry)) {
-		__rpc_depopulate(root, files, RPCAUTH_lockd, RPCAUTH_RootEOF);
-		return PTR_ERR(gssd_dentry);
-	}
+	err = rpc_gssd_dummy_populate(root, sn->gssd_dummy);
+	if (err)
+		return err;
 
 	dprintk("RPC:       sending pipefs MOUNT notification for net %x%s\n",
 		net->ns.inum, NET_NAME(net));
@@ -1386,18 +1363,6 @@ rpc_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = blocking_notifier_call_chain(&rpc_pipefs_notifier_list,
 					   RPC_PIPEFS_MOUNT,
 					   sb);
-	if (err)
-		goto err_depopulate;
-	mutex_unlock(&sn->pipefs_sb_lock);
-	return 0;
-
-err_depopulate:
-	rpc_gssd_dummy_depopulate(gssd_dentry);
-	blocking_notifier_call_chain(&rpc_pipefs_notifier_list,
-					   RPC_PIPEFS_UMOUNT,
-					   sb);
-	sn->pipefs_sb = NULL;
-	__rpc_depopulate(root, files, RPCAUTH_lockd, RPCAUTH_RootEOF);
 	mutex_unlock(&sn->pipefs_sb_lock);
 	return err;
 }
-- 
2.39.5


