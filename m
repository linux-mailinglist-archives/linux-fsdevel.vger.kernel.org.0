Return-Path: <linux-fsdevel+bounces-51561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91687AD842B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87845189BB09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE92C326C;
	Fri, 13 Jun 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lz5fKDLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D012D8DA4;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=PM8VR4RvHuPNZb6OrUtEt1S3bmv2beUNpCBEGaSn0OIOM2XRS2QOG9Bvlgfpc2Ij7sKJ5GIiuRgM4vOvSkFzfPOFvPCJ3gtvNSUd0WtOsLlg7rQQd32gOxpszQbc5jyKNZcu8H/QsvhNVwuiKiVUgPPamAxlQ7KU5t0+HIz+244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=XOrBHs4cf6FCURq4PY4nxsjA30kCiU6NO2zF+3jq5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPZUVgVNJdvgWrNTW/w2LGFXPP5uN9mLzj84yFxNakGyerFENtFGhEkoON7M1q5CVkioi14K/I2NXGqqMrZDxmbK4rGh5ydoQEQVoVs/E92OlEfh2Qwsn9JmE5bEK4J8C8KnlkeWPV0k8XfLeVMcyvSxEDuueqoCIky8bavBa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Lz5fKDLo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=t7yy3AQ/m/A1w/woRi9LcPWOSSiZXsngfDAP4RO6pvU=; b=Lz5fKDLoCmfELrbUG/sHyXKN0T
	xAeStDbUxxacqQzseomVuj6OVF2nhZ60KAI+lTxQehc5bMHBoWwhNGSuBGpkyFhIJGQdDLn8rthll
	2sYZBNH+o9glFU9CVLWoe7FlgOtugaeL94P+hPGpAejqlCaYqOkq3jC9T0Q96AcXeLTEXXDTKWLDi
	HWwwaJfFZwXqaY1tDv/3DFveZdANUP+LWEceMvACzh4E7bs3orsjStAfAmT4SH/VWCRkN+QTLaKoA
	7NwvdcKmGxh0HqkA8ZChi67khqqvWFAr0lvJ8ciXXYOQSAFGfQ6LqA3i4jJBgBl1mfRAPDm3EBaRx
	tb2AztVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qq3-3zYq;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 08/17] rpc_mkpipe_dentry(): saner calling conventions
Date: Fri, 13 Jun 2025 08:34:23 +0100
Message-ID: <20250613073432.1871345-8-viro@zeniv.linux.org.uk>
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

Instead of returning a dentry or ERR_PTR(-E...), return 0 and store
dentry into pipe->dentry on success and return -E... on failure.

Callers are happier that way...

NOTE: dummy rpc_pipe is getting ->dentry set; we never access that,
since we
	1) never call rpc_unlink() for it (dentry is taken out by
->kill_sb())
	2) never call rpc_queue_upcall() for it (writing to that
sucker fails; no downcalls are ever submitted, so no replies are
going to arrive)
IOW, having that ->dentry set (and left dangling) is harmless,
if ugly; cleaner solution will take more massage.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/blocklayout/rpc_pipefs.c    | 41 ++++++++++++------------------
 fs/nfs/nfs4idmap.c                 |  8 +-----
 fs/nfsd/nfs4recover.c              | 37 ++++++++++-----------------
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/auth_gss/auth_gss.c     |  7 +----
 net/sunrpc/rpc_pipe.c              | 29 +++++++++------------
 6 files changed, 45 insertions(+), 79 deletions(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index 25d429e44eb4..d526f5ba7887 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -141,17 +141,18 @@ static const struct rpc_pipe_ops bl_upcall_ops = {
 	.destroy_msg	= bl_pipe_destroy_msg,
 };
 
-static struct dentry *nfs4blocklayout_register_sb(struct super_block *sb,
+static int nfs4blocklayout_register_sb(struct super_block *sb,
 					    struct rpc_pipe *pipe)
 {
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, NFS_PIPE_DIRNAME);
 	if (dir == NULL)
-		return ERR_PTR(-ENOENT);
-	dentry = rpc_mkpipe_dentry(dir, "blocklayout", NULL, pipe);
+		return -ENOENT;
+	err = rpc_mkpipe_dentry(dir, "blocklayout", NULL, pipe);
 	dput(dir);
-	return dentry;
+	return err;
 }
 
 static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
@@ -160,7 +161,6 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 	struct super_block *sb = ptr;
 	struct net *net = sb->s_fs_info;
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
-	struct dentry *dentry;
 	int ret = 0;
 
 	if (!try_module_get(THIS_MODULE))
@@ -173,12 +173,7 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = nfs4blocklayout_register_sb(sb, nn->bl_device_pipe);
-		if (IS_ERR(dentry)) {
-			ret = PTR_ERR(dentry);
-			break;
-		}
-		nn->bl_device_pipe->dentry = dentry;
+		ret = nfs4blocklayout_register_sb(sb, nn->bl_device_pipe);
 		break;
 	case RPC_PIPEFS_UMOUNT:
 		rpc_unlink(nn->bl_device_pipe);
@@ -195,18 +190,17 @@ static struct notifier_block nfs4blocklayout_block = {
 	.notifier_call = rpc_pipefs_event,
 };
 
-static struct dentry *nfs4blocklayout_register_net(struct net *net,
-						   struct rpc_pipe *pipe)
+static int nfs4blocklayout_register_net(struct net *net, struct rpc_pipe *pipe)
 {
 	struct super_block *pipefs_sb;
-	struct dentry *dentry;
+	int ret;
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (!pipefs_sb)
-		return NULL;
-	dentry = nfs4blocklayout_register_sb(pipefs_sb, pipe);
+		return 0;
+	ret = nfs4blocklayout_register_sb(pipefs_sb, pipe);
 	rpc_put_sb_net(net);
-	return dentry;
+	return ret;
 }
 
 static void nfs4blocklayout_unregister_net(struct net *net,
@@ -224,20 +218,17 @@ static void nfs4blocklayout_unregister_net(struct net *net,
 static int nfs4blocklayout_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
-	struct dentry *dentry;
+	int err;
 
 	mutex_init(&nn->bl_mutex);
 	init_waitqueue_head(&nn->bl_wq);
 	nn->bl_device_pipe = rpc_mkpipe_data(&bl_upcall_ops, 0);
 	if (IS_ERR(nn->bl_device_pipe))
 		return PTR_ERR(nn->bl_device_pipe);
-	dentry = nfs4blocklayout_register_net(net, nn->bl_device_pipe);
-	if (IS_ERR(dentry)) {
+	err = nfs4blocklayout_register_net(net, nn->bl_device_pipe);
+	if (unlikely(err))
 		rpc_destroy_pipe_data(nn->bl_device_pipe);
-		return PTR_ERR(dentry);
-	}
-	nn->bl_device_pipe->dentry = dentry;
-	return 0;
+	return err;
 }
 
 static void nfs4blocklayout_net_exit(struct net *net)
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index adc03232b851..00932500fce4 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -432,14 +432,8 @@ static int nfs_idmap_pipe_create(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct idmap *idmap = pdo->pdo_data;
-	struct rpc_pipe *pipe = idmap->idmap_pipe;
-	struct dentry *dentry;
 
-	dentry = rpc_mkpipe_dentry(dir, "idmap", idmap, pipe);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	pipe->dentry = dentry;
-	return 0;
+	return rpc_mkpipe_dentry(dir, "idmap", idmap, idmap->idmap_pipe);
 }
 
 static const struct rpc_pipe_dir_object_ops nfs_idmap_pipe_dir_object_ops = {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index bbd29b3b573f..2231192ec33f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -950,31 +950,32 @@ static const struct rpc_pipe_ops cld_upcall_ops = {
 	.destroy_msg	= cld_pipe_destroy_msg,
 };
 
-static struct dentry *
+static int
 nfsd4_cld_register_sb(struct super_block *sb, struct rpc_pipe *pipe)
 {
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, NFSD_PIPE_DIR);
 	if (dir == NULL)
-		return ERR_PTR(-ENOENT);
-	dentry = rpc_mkpipe_dentry(dir, NFSD_CLD_PIPE, NULL, pipe);
+		return -ENOENT;
+	err = rpc_mkpipe_dentry(dir, NFSD_CLD_PIPE, NULL, pipe);
 	dput(dir);
-	return dentry;
+	return err;
 }
 
-static struct dentry *
+static int
 nfsd4_cld_register_net(struct net *net, struct rpc_pipe *pipe)
 {
 	struct super_block *sb;
-	struct dentry *dentry;
+	int err;
 
 	sb = rpc_get_sb_net(net);
 	if (!sb)
-		return NULL;
-	dentry = nfsd4_cld_register_sb(sb, pipe);
+		return 0;
+	err = nfsd4_cld_register_sb(sb, pipe);
 	rpc_put_sb_net(net);
-	return dentry;
+	return err;
 }
 
 static void
@@ -994,7 +995,6 @@ static int
 __nfsd4_init_cld_pipe(struct net *net)
 {
 	int ret;
-	struct dentry *dentry;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct cld_net *cn;
 
@@ -1015,13 +1015,10 @@ __nfsd4_init_cld_pipe(struct net *net)
 	spin_lock_init(&cn->cn_lock);
 	INIT_LIST_HEAD(&cn->cn_list);
 
-	dentry = nfsd4_cld_register_net(net, cn->cn_pipe);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
+	ret = nfsd4_cld_register_net(net, cn->cn_pipe);
+	if (unlikely(ret))
 		goto err_destroy_data;
-	}
 
-	cn->cn_pipe->dentry = dentry;
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	cn->cn_has_legacy = false;
 #endif
@@ -2114,7 +2111,6 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 	struct net *net = sb->s_fs_info;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
-	struct dentry *dentry;
 	int ret = 0;
 
 	if (!try_module_get(THIS_MODULE))
@@ -2127,12 +2123,7 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = nfsd4_cld_register_sb(sb, cn->cn_pipe);
-		if (IS_ERR(dentry)) {
-			ret = PTR_ERR(dentry);
-			break;
-		}
-		cn->cn_pipe->dentry = dentry;
+		ret = nfsd4_cld_register_sb(sb, cn->cn_pipe);
 		break;
 	case RPC_PIPEFS_UMOUNT:
 		rpc_unlink(cn->cn_pipe);
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index a8c0a500d55c..8cc3a5df9801 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -127,7 +127,7 @@ extern void rpc_remove_cache_dir(struct dentry *);
 
 struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pipe_ops *ops, int flags);
 void rpc_destroy_pipe_data(struct rpc_pipe *pipe);
-extern struct dentry *rpc_mkpipe_dentry(struct dentry *, const char *, void *,
+extern int rpc_mkpipe_dentry(struct dentry *, const char *, void *,
 					struct rpc_pipe *);
 extern void rpc_unlink(struct rpc_pipe *);
 extern int register_rpc_pipefs(void);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index f2a44d589cfb..6c23d46a1dcc 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -895,13 +895,8 @@ static int gss_pipe_dentry_create(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct gss_pipe *p = pdo->pdo_data;
-	struct dentry *dentry;
 
-	dentry = rpc_mkpipe_dentry(dir, p->name, p->clnt, p->pipe);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	p->pipe->dentry = dentry;
-	return 0;
+	return rpc_mkpipe_dentry(dir, p->name, p->clnt, p->pipe);
 }
 
 static const struct rpc_pipe_dir_object_ops gss_pipe_dir_object_ops = {
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 2046582c4f35..dac1c35a642f 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -702,7 +702,7 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
  * The @private argument passed here will be available to all these methods
  * from the file pointer, via RPC_I(file_inode(file))->private.
  */
-struct dentry *rpc_mkpipe_dentry(struct dentry *parent, const char *name,
+int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 				 void *private, struct rpc_pipe *pipe)
 {
 	struct dentry *dentry;
@@ -717,21 +717,19 @@ struct dentry *rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	dentry = __rpc_lookup_create_exclusive(parent, name);
-	if (IS_ERR(dentry))
-		goto out;
+	if (IS_ERR(dentry)) {
+		inode_unlock(dir);
+		return PTR_ERR(dentry);
+	}
 	err = __rpc_mkpipe_dentry(dir, dentry, umode, &rpc_pipe_fops,
 				  private, pipe);
-	if (err)
-		goto out_err;
-out:
+	if (unlikely(err))
+		pr_warn("%s() failed to create pipe %pd/%s (errno = %d)\n",
+			__func__, parent, name, err);
+	else
+		pipe->dentry = dentry;
 	inode_unlock(dir);
-	return dentry;
-out_err:
-	dentry = ERR_PTR(err);
-	printk(KERN_WARNING "%s: %s() failed to create pipe %pd/%s (errno = %d)\n",
-			__FILE__, __func__, parent, name,
-			err);
-	goto out;
+	return err;
 }
 EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 
@@ -1185,7 +1183,6 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	int ret = 0;
 	struct dentry *gssd_dentry;
 	struct dentry *clnt_dentry = NULL;
-	struct dentry *pipe_dentry = NULL;
 
 	/* We should never get this far if "gssd" doesn't exist */
 	gssd_dentry = try_lookup_noperm(&QSTR(files[RPCAUTH_gssd].name), root);
@@ -1209,10 +1206,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		dput(clnt_dentry);
 		return ret;
 	}
-	pipe_dentry = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
+	ret = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
 	dput(clnt_dentry);
-	if (IS_ERR(pipe_dentry))
-		ret = PTR_ERR(pipe_dentry);
 	return ret;
 }
 
-- 
2.39.5


