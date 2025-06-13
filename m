Return-Path: <linux-fsdevel+bounces-51566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD83AD842E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84183A0E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524002E6126;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lSS31qvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466A2DECB1;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800078; cv=none; b=re3rQTI7QFopJKi+oKChHIled++/vq1pZ9+wOyqMTg5pssI5E2LLxTSVS28gOlrr9eKcLi/WI71pD89emFI89MoRgoJHyEJVrCuwo0nr8gg/DPiib13TCkpwkDcgq+UTjJscp96VCztt1WM5CM2VslGwwOaYqI4EJLhmwcROrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800078; c=relaxed/simple;
	bh=T/AjENTLv1TMIokiki+J3q7JzVxZJv/JAX8oX0Ncg54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roZIwEvejCeWtgx+J3NSxDiM6EXRbuTjN3eYRp+m2myDayZztqSi0XB+YVzqOJ7oyrmaBIwfNM7G/wipqgmP36qZaOSPokORar0zwVLO1dTFHLbX8XVkgMcqNwo4HBYqYvs5PUK19nf5tahMSZZjNdD6J0K6nOV4NveGpUhDcwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lSS31qvx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fxiAVoHxF0IiS4UX0vBmteoNgKUDFrneK63qK9IOhrE=; b=lSS31qvxTNVG9TZ6z++lisUpXO
	csn1bYXcGFFxGwQg+7qN+4OTXC4WuZAqkAPvC/EvjmoKudNi7sbCuepZtyZeYOCTfmnx7ilwGTNUE
	ckYxE5Lv4EhbEijI2sssKcW6Oh3/05b+Th68wCNysYgUzLeuQflslMuYfkwE6lMVI3wy6Xb4nyGHv
	ZgWUPOSnAOu82P0+Sv7XA0Cdqp5aeEZIQRJ7gjqnx49Bd301Z+coK9WGjPjNoShRU+JqpSIX63Th4
	3P6bgsGPmZiOZ+RcQNmTN4AwRerKjjZHSpz4uaLzayimrW/d3xQIR2GMR4ELWb7yeuQsYXiDGfOj9
	Wcc9P8qw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpv-3NQj;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 07/17] rpc_unlink(): saner calling conventions
Date: Fri, 13 Jun 2025 08:34:22 +0100
Message-ID: <20250613073432.1871345-7-viro@zeniv.linux.org.uk>
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

1) pass it pipe instead of pipe->dentry
2) zero pipe->dentry afterwards
3) it always returns 0; why bother?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/blocklayout/rpc_pipefs.c    | 12 ++----------
 fs/nfs/nfs4idmap.c                 |  6 +-----
 fs/nfsd/nfs4recover.c              | 12 ++----------
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/auth_gss/auth_gss.c     |  6 +-----
 net/sunrpc/rpc_pipe.c              | 12 +++++++-----
 6 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index d8d50a88de04..25d429e44eb4 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -154,13 +154,6 @@ static struct dentry *nfs4blocklayout_register_sb(struct super_block *sb,
 	return dentry;
 }
 
-static void nfs4blocklayout_unregister_sb(struct super_block *sb,
-					  struct rpc_pipe *pipe)
-{
-	if (pipe->dentry)
-		rpc_unlink(pipe->dentry);
-}
-
 static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 			   void *ptr)
 {
@@ -188,8 +181,7 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 		nn->bl_device_pipe->dentry = dentry;
 		break;
 	case RPC_PIPEFS_UMOUNT:
-		if (nn->bl_device_pipe->dentry)
-			nfs4blocklayout_unregister_sb(sb, nn->bl_device_pipe);
+		rpc_unlink(nn->bl_device_pipe);
 		break;
 	default:
 		ret = -ENOTSUPP;
@@ -224,7 +216,7 @@ static void nfs4blocklayout_unregister_net(struct net *net,
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		nfs4blocklayout_unregister_sb(pipefs_sb, pipe);
+		rpc_unlink(pipe);
 		rpc_put_sb_net(net);
 	}
 }
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25a7c771cfd8..adc03232b851 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -424,12 +424,8 @@ static void nfs_idmap_pipe_destroy(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct idmap *idmap = pdo->pdo_data;
-	struct rpc_pipe *pipe = idmap->idmap_pipe;
 
-	if (pipe->dentry) {
-		rpc_unlink(pipe->dentry);
-		pipe->dentry = NULL;
-	}
+	rpc_unlink(idmap->idmap_pipe);
 }
 
 static int nfs_idmap_pipe_create(struct dentry *dir,
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 82785db730d9..bbd29b3b573f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -963,13 +963,6 @@ nfsd4_cld_register_sb(struct super_block *sb, struct rpc_pipe *pipe)
 	return dentry;
 }
 
-static void
-nfsd4_cld_unregister_sb(struct rpc_pipe *pipe)
-{
-	if (pipe->dentry)
-		rpc_unlink(pipe->dentry);
-}
-
 static struct dentry *
 nfsd4_cld_register_net(struct net *net, struct rpc_pipe *pipe)
 {
@@ -991,7 +984,7 @@ nfsd4_cld_unregister_net(struct net *net, struct rpc_pipe *pipe)
 
 	sb = rpc_get_sb_net(net);
 	if (sb) {
-		nfsd4_cld_unregister_sb(pipe);
+		rpc_unlink(pipe);
 		rpc_put_sb_net(net);
 	}
 }
@@ -2142,8 +2135,7 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 		cn->cn_pipe->dentry = dentry;
 		break;
 	case RPC_PIPEFS_UMOUNT:
-		if (cn->cn_pipe->dentry)
-			nfsd4_cld_unregister_sb(cn->cn_pipe);
+		rpc_unlink(cn->cn_pipe);
 		break;
 	default:
 		ret = -ENOTSUPP;
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 3b35b6f6533a..a8c0a500d55c 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -129,7 +129,7 @@ struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pipe_ops *ops, int flags);
 void rpc_destroy_pipe_data(struct rpc_pipe *pipe);
 extern struct dentry *rpc_mkpipe_dentry(struct dentry *, const char *, void *,
 					struct rpc_pipe *);
-extern int rpc_unlink(struct dentry *);
+extern void rpc_unlink(struct rpc_pipe *);
 extern int register_rpc_pipefs(void);
 extern void unregister_rpc_pipefs(void);
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 0fa244f16876..f2a44d589cfb 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -887,12 +887,8 @@ static void gss_pipe_dentry_destroy(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct gss_pipe *gss_pipe = pdo->pdo_data;
-	struct rpc_pipe *pipe = gss_pipe->pipe;
 
-	if (pipe->dentry != NULL) {
-		rpc_unlink(pipe->dentry);
-		pipe->dentry = NULL;
-	}
+	rpc_unlink(gss_pipe->pipe);
 }
 
 static int gss_pipe_dentry_create(struct dentry *dir,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 46fa00ac5e0e..2046582c4f35 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -737,17 +737,19 @@ EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 
 /**
  * rpc_unlink - remove a pipe
- * @dentry: dentry for the pipe, as returned from rpc_mkpipe
+ * @pipe: the pipe to be removed
  *
  * After this call, lookups will no longer find the pipe, and any
  * attempts to read or write using preexisting opens of the pipe will
  * return -EPIPE.
  */
-int
-rpc_unlink(struct dentry *dentry)
+void
+rpc_unlink(struct rpc_pipe *pipe)
 {
-	simple_recursive_removal(dentry, rpc_close_pipes);
-	return 0;
+	if (pipe->dentry) {
+		simple_recursive_removal(pipe->dentry, rpc_close_pipes);
+		pipe->dentry = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(rpc_unlink);
 
-- 
2.39.5


