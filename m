Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1F1FD59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEPBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:33108 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 712CA2FC1; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 04/12] nfsd: add nfsd/clients directory
Date:   Wed, 15 May 2019 21:20:11 -0400
Message-Id: <1557969619-17157-7-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I plan to expose some information about nfsv4 clients here.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/netns.h     |   2 +
 fs/nfsd/nfs4state.c |  23 ++++++----
 fs/nfsd/nfsctl.c    | 108 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h      |   9 ++++
 fs/nfsd/state.h     |   6 ++-
 5 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index cce335e1ec98..46d956676480 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -58,6 +58,8 @@ struct nfsd_net {
 	/* internal mount of the "nfsd" pseudofilesystem: */
 	struct vfsmount *nfsd_mnt;
 
+	struct dentry *nfsd_client_dir;
+
 	/*
 	 * reclaim_str_hashtbl[] holds known client info from previous reset/reboot
 	 * used in reboot/reset lease grace period processing
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 83d0ee329e14..dfcb90743861 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1871,20 +1871,19 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 
 static void __free_client(struct kref *k)
 {
-	struct nfs4_client *clp = container_of(k, struct nfs4_client, cl_ref);
+	struct nfsdfs_client *c = container_of(k, struct nfsdfs_client, cl_ref);
+	struct nfs4_client *clp = container_of(c, struct nfs4_client, cl_nfsdfs);
 
 	free_svc_cred(&clp->cl_cred);
 	kfree(clp->cl_ownerstr_hashtbl);
 	kfree(clp->cl_name.data);
 	idr_destroy(&clp->cl_stateids);
-	if (clp->cl_nfsd_dentry)
-		nfsd_client_rmdir(clp->cl_nfsd_dentry);
 	kmem_cache_free(client_slab, clp);
 }
 
 void drop_client(struct nfs4_client *clp)
 {
-	kref_put(&clp->cl_ref, __free_client);
+	kref_put(&clp->cl_nfsdfs.cl_ref, __free_client);
 }
 
 static void
@@ -1899,6 +1898,8 @@ free_client(struct nfs4_client *clp)
 		free_session(ses);
 	}
 	rpc_destroy_wait_queue(&clp->cl_cb_waitq);
+	if (clp->cl_nfsd_dentry)
+		nfsd_client_rmdir(clp->cl_nfsd_dentry);
 	drop_client(clp);
 }
 
@@ -2199,6 +2200,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	struct sockaddr *sa = svc_addr(rqstp);
 	int ret;
 	struct net *net = SVC_NET(rqstp);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	clp = alloc_client(name);
 	if (clp == NULL)
@@ -2209,8 +2211,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 		free_client(clp);
 		return NULL;
 	}
-
-	kref_init(&clp->cl_ref);
+	gen_clid(clp, nn);
+	kref_init(&clp->cl_nfsdfs.cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
 	clp->cl_time = get_seconds();
 	clear_bit(0, &clp->cl_cb_slot_busy);
@@ -2218,6 +2220,12 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	rpc_copy_addr((struct sockaddr *) &clp->cl_addr, sa);
 	clp->cl_cb_session = NULL;
 	clp->net = net;
+	clp->cl_nfsd_dentry = nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
+						clp->cl_clientid.cl_id);
+	if (!clp->cl_nfsd_dentry) {
+		free_client(clp);
+		return NULL;
+	}
 	return clp;
 }
 
@@ -2661,7 +2669,6 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new->cl_spo_must_allow.u.words[0] = exid->spo_must_allow[0];
 	new->cl_spo_must_allow.u.words[1] = exid->spo_must_allow[1];
 
-	gen_clid(new, nn);
 	add_to_unconfirmed(new);
 	swap(new, conf);
 out_copy:
@@ -3404,7 +3411,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		copy_clid(new, conf);
 		gen_confirm(new, nn);
 	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
-		gen_clid(new, nn);
+		;
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8d2062428569..8a2261cdefee 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/gss_krb5_enctypes.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/module.h>
+#include <linux/fsnotify.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -52,6 +53,7 @@ enum {
 	NFSD_RecoveryDir,
 	NFSD_V4EndGrace,
 #endif
+	NFSD_MaxReserved
 };
 
 /*
@@ -1146,8 +1148,99 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
  *	populating the filesystem.
  */
 
+/* Basically copying rpc_get_inode. */
+static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
+{
+	struct inode *inode = new_inode(sb);
+	if (!inode)
+		return NULL;
+	/* Following advice from simple_fill_super documentation: */
+	inode->i_ino = iunique(sb, NFSD_MaxReserved);
+	inode->i_mode = mode;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	switch (mode & S_IFMT) {
+	case S_IFDIR:
+		inode->i_fop = &simple_dir_operations;
+		inode->i_op = &simple_dir_inode_operations;
+		inc_nlink(inode);
+	default:
+		break;
+	}
+	return inode;
+}
+
+static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = nfsd_get_inode(dir->i_sb, mode);
+	if (!inode)
+		return -ENOMEM;
+	d_add(dentry, inode);
+	inc_nlink(dir);
+	fsnotify_mkdir(dir, dentry);
+	return 0;
+}
+
+static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *ncl, char *name)
+{
+	struct inode *dir = parent->d_inode;
+	struct dentry *dentry;
+	int ret = -ENOMEM;
+
+	inode_lock(dir);
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		goto out_err;
+	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600);
+	if (ret)
+		goto out_err;
+	if (ncl) {
+		d_inode(dentry)->i_private = ncl;
+		kref_get(&ncl->cl_ref);
+	}
+out:
+	inode_unlock(dir);
+	return dentry;
+out_err:
+	dentry = ERR_PTR(ret);
+	goto out;
+}
+
+/* on success, returns positive number unique to that client. */
+struct dentry *nfsd_client_mkdir(struct nfsd_net *nn, struct nfsdfs_client *ncl, u32 id)
+{
+	char name[11];
+
+	sprintf(name, "%d", id++);
+
+	return nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
+}
+
+/* Taken from __rpc_rmdir: */
+void nfsd_client_rmdir(struct dentry *dentry)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	struct inode *inode = d_inode(dentry);
+	struct nfsdfs_client *ncl = inode->i_private;
+	int ret;
+
+	inode->i_private = NULL;
+	synchronize_rcu();
+	kref_put(&ncl->cl_ref, ncl->cl_release);
+	dget(dentry);
+	ret = simple_rmdir(dir, dentry);
+	WARN_ON_ONCE(ret);
+	d_delete(dentry);
+}
+
 static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
 {
+	struct nfsd_net *nn = net_generic(current->nsproxy->net_ns,
+							nfsd_net_id);
+	struct dentry *dentry;
+	int ret;
+
 	static const struct tree_descr nfsd_files[] = {
 		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
 		[NFSD_Export_features] = {"export_features",
@@ -1177,7 +1270,20 @@ static int nfsd_fill_super(struct super_block * sb, void * data, int silent)
 		/* last one */ {""}
 	};
 	get_net(sb->s_fs_info);
-	return simple_fill_super(sb, 0x6e667364, nfsd_files);
+	ret = simple_fill_super(sb, 0x6e667364, nfsd_files);
+	if (ret)
+		return ret;
+	dentry = nfsd_mkdir(sb->s_root, NULL, "clients");
+	if (IS_ERR(dentry)) {
+		/* XXX: test: */
+		d_genocide(sb->s_root);
+		shrink_dcache_parent(sb->s_root);
+		dput(sb->s_root);
+		return PTR_ERR(dentry);
+	}
+	nn->nfsd_client_dir = dentry;
+	return 0;
+
 }
 
 static struct dentry *nfsd_mount(struct file_system_type *fs_type,
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 066899929863..fe7418c2b88f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -21,6 +21,7 @@
 
 #include <uapi/linux/nfsd/debug.h>
 
+#include "netns.h"
 #include "stats.h"
 #include "export.h"
 
@@ -85,6 +86,14 @@ int		nfsd_pool_stats_release(struct inode *, struct file *);
 
 void		nfsd_destroy(struct net *net);
 
+struct nfsdfs_client {
+	struct kref cl_ref;
+	void (*cl_release)(struct kref *kref);
+};
+
+struct dentry *nfsd_client_mkdir(struct nfsd_net *nn, struct nfsdfs_client *ncl, u32 id);
+void nfsd_client_rmdir(struct dentry *dentry);
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 #ifdef CONFIG_NFSD_V2_ACL
 extern const struct svc_version nfsd_acl_version2;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index aa26ae520fb6..5a999e4b766e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -39,6 +39,7 @@
 #include <linux/refcount.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include "nfsfh.h"
+#include "nfsd.h"
 
 typedef struct {
 	u32             cl_boot;
@@ -347,9 +348,12 @@ struct nfs4_client {
 	u32			cl_exchange_flags;
 	/* number of rpc's in progress over an associated session: */
 	atomic_t		cl_rpc_users;
-	struct kref		cl_ref;
+	struct nfsdfs_client	cl_nfsdfs;
 	struct nfs4_op_map      cl_spo_must_allow;
 
+	/* debugging info directory under nfsd/clients/ : */
+	struct dentry		*cl_nfsd_dentry;
+
 	/* for nfs41 callbacks */
 	/* We currently support a single back channel with a single slot */
 	unsigned long		cl_cb_slot_busy;
-- 
2.21.0

