Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6563A74EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfICUd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfICUcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2636B3018ECE;
        Tue,  3 Sep 2019 20:32:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFD0160126;
        Tue,  3 Sep 2019 20:32:16 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id AB6B420D2C; Tue,  3 Sep 2019 16:32:15 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/26] nfs: don't pass nfs_subversion to ->create_server()
Date:   Tue,  3 Sep 2019 16:32:01 -0400
Message-Id: <20190903203215.9157-13-smayhew@redhat.com>
In-Reply-To: <20190903203215.9157-1-smayhew@redhat.com>
References: <20190903203215.9157-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 20:32:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

pick it from mount_info

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/client.c         |  4 ++--
 fs/nfs/internal.h       |  7 ++-----
 fs/nfs/nfs3_fs.h        |  2 +-
 fs/nfs/nfs3client.c     |  5 ++---
 fs/nfs/nfs4client.c     |  3 +--
 fs/nfs/nfs4super.c      |  2 +-
 fs/nfs/super.c          | 14 +++++++-------
 include/linux/nfs_xdr.h |  2 +-
 8 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 30838304a0bf..130c065141b3 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -940,10 +940,10 @@ EXPORT_SYMBOL_GPL(nfs_free_server);
  * Create a version 2 or 3 volume record
  * - keyed on server and FSID
  */
-struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info,
-				     struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 {
 	struct nfs_server *server;
+	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	struct nfs_fattr *fattr;
 	int error;
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 207d1574e246..444d0fc2bcca 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -178,11 +178,8 @@ extern struct nfs_client *nfs4_find_client_ident(struct net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
-extern struct nfs_server *nfs_create_server(struct nfs_mount_info *,
-					struct nfs_subversion *);
-extern struct nfs_server *nfs4_create_server(
-					struct nfs_mount_info *,
-					struct nfs_subversion *);
+extern struct nfs_server *nfs_create_server(struct nfs_mount_info *);
+extern struct nfs_server *nfs4_create_server(struct nfs_mount_info *);
 extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *,
 						      struct nfs_fh *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index f82e11c4cb56..09602dc1889f 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -27,7 +27,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 #endif /* CONFIG_NFS_V3_ACL */
 
 /* nfs3client.c */
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *, struct nfs_subversion *);
+struct nfs_server *nfs3_create_server(struct nfs_mount_info *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 				     struct nfs_fattr *, rpc_authflavor_t);
 
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 148ceb74d27c..a340b5d0e1a3 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -46,10 +46,9 @@ static inline void nfs_init_server_aclclient(struct nfs_server *server)
 }
 #endif
 
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info,
-				      struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info)
 {
-	struct nfs_server *server = nfs_create_server(mount_info, nfs_mod);
+	struct nfs_server *server = nfs_create_server(mount_info);
 	/* Create a client RPC handle for the NFS v3 ACL management interface */
 	if (!IS_ERR(server))
 		nfs_init_server_aclclient(server);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index da6204025a2d..16fba83b5c4b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1109,8 +1109,7 @@ static int nfs4_init_server(struct nfs_server *server,
  */
 /*struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data *data,
 				      struct nfs_fh *mntfh)*/
-struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info,
-				      struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 {
 	struct nfs_server *server;
 	bool auth_probe;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 5bca30f704e4..b6cf62125380 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -205,7 +205,7 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
-	res = do_nfs4_mount(nfs4_create_server(mount_info, &nfs_v4),
+	res = do_nfs4_mount(nfs4_create_server(mount_info),
 			    flags, mount_info,
 			    data->nfs_server.hostname,
 			    data->nfs_server.export_path);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c3ee83c17f07..157d340333c8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1820,8 +1820,7 @@ static int nfs_request_mount(struct nfs_parsed_mount_data *args,
 	return 0;
 }
 
-static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_info,
-					struct nfs_subversion *nfs_mod)
+static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_info)
 {
 	int status;
 	unsigned int i;
@@ -1831,6 +1830,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	struct nfs_parsed_mount_data *args = mount_info->parsed;
 	rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 	unsigned int authlist_len = ARRAY_SIZE(authlist);
+	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 
 	status = nfs_request_mount(args, mount_info->mntfh, authlist,
 					&authlist_len);
@@ -1847,7 +1847,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 			 args->selected_flavor);
 		if (status)
 			return ERR_PTR(status);
-		return nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+		return nfs_mod->rpc_ops->create_server(mount_info);
 	}
 
 	/*
@@ -1874,7 +1874,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		args->selected_flavor = flavor;
-		server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+		server = nfs_mod->rpc_ops->create_server(mount_info);
 		if (!IS_ERR(server))
 			return server;
 	}
@@ -1890,7 +1890,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	/* Last chance! Try AUTH_UNIX */
 	dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNIX);
 	args->selected_flavor = RPC_AUTH_UNIX;
-	return nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+	return nfs_mod->rpc_ops->create_server(mount_info);
 }
 
 static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
@@ -1900,9 +1900,9 @@ struct dentry *nfs_try_mount(int flags, const char *dev_name,
 {
 	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	if (mount_info->parsed->need_mount)
-		mount_info->server = nfs_try_mount_request(mount_info, nfs_mod);
+		mount_info->server = nfs_try_mount_request(mount_info);
 	else
-		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info);
 
 	return nfs_fs_mount_common(flags, dev_name, mount_info);
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 4fdf4a523185..82bdb91da2ae 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1705,7 +1705,7 @@ struct nfs_rpc_ops {
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
 	void	(*free_client) (struct nfs_client *);
-	struct nfs_server *(*create_server)(struct nfs_mount_info *, struct nfs_subversion *);
+	struct nfs_server *(*create_server)(struct nfs_mount_info *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
 };
-- 
2.17.2

