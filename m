Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B84B1D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfIMMSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbfIMMRv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B2E6309174E;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62CC35D71C;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 266C920EF2; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/26] NFS: rename nfs_fs_context pointer arg in a few functions
Date:   Fri, 13 Sep 2019 08:17:45 -0400
Message-Id: <20190913121748.25391-24-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Rename cfg to ctx in nfs_init_server(), nfs_verify_authflavors(),
and nfs_request_mount().  No functional changes.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/client.c | 62 ++++++++++++++++++++++++-------------------------
 fs/nfs/super.c  | 54 +++++++++++++++++++++---------------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 1afd796a3706..511d1d629786 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -648,27 +648,27 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-			   const struct nfs_fs_context *cfg,
+			   const struct nfs_fs_context *ctx,
 			   struct nfs_subversion *nfs_mod)
 {
 	struct rpc_timeout timeparms;
 	struct nfs_client_initdata cl_init = {
-		.hostname = cfg->nfs_server.hostname,
-		.addr = (const struct sockaddr *)&cfg->nfs_server.address,
-		.addrlen = cfg->nfs_server.addrlen,
+		.hostname = ctx->nfs_server.hostname,
+		.addr = (const struct sockaddr *)&ctx->nfs_server.address,
+		.addrlen = ctx->nfs_server.addrlen,
 		.nfs_mod = nfs_mod,
-		.proto = cfg->nfs_server.protocol,
-		.net = cfg->net,
+		.proto = ctx->nfs_server.protocol,
+		.net = ctx->net,
 		.timeparms = &timeparms,
 		.cred = server->cred,
-		.nconnect = cfg->nfs_server.nconnect,
+		.nconnect = ctx->nfs_server.nconnect,
 	};
 	struct nfs_client *clp;
 	int error;
 
-	nfs_init_timeout_values(&timeparms, cfg->nfs_server.protocol,
-				cfg->timeo, cfg->retrans);
-	if (cfg->flags & NFS_MOUNT_NORESVPORT)
+	nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
+				ctx->timeo, ctx->retrans);
+	if (ctx->flags & NFS_MOUNT_NORESVPORT)
 		set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	/* Allocate or find a client reference we can use */
@@ -679,46 +679,46 @@ static int nfs_init_server(struct nfs_server *server,
 	server->nfs_client = clp;
 
 	/* Initialise the client representation from the mount data */
-	server->flags = cfg->flags;
-	server->options = cfg->options;
+	server->flags = ctx->flags;
+	server->options = ctx->options;
 	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
 		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
 		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
 
-	if (cfg->rsize)
-		server->rsize = nfs_block_size(cfg->rsize, NULL);
-	if (cfg->wsize)
-		server->wsize = nfs_block_size(cfg->wsize, NULL);
+	if (ctx->rsize)
+		server->rsize = nfs_block_size(ctx->rsize, NULL);
+	if (ctx->wsize)
+		server->wsize = nfs_block_size(ctx->wsize, NULL);
 
-	server->acregmin = cfg->acregmin * HZ;
-	server->acregmax = cfg->acregmax * HZ;
-	server->acdirmin = cfg->acdirmin * HZ;
-	server->acdirmax = cfg->acdirmax * HZ;
+	server->acregmin = ctx->acregmin * HZ;
+	server->acregmax = ctx->acregmax * HZ;
+	server->acdirmin = ctx->acdirmin * HZ;
+	server->acdirmax = ctx->acdirmax * HZ;
 
 	/* Start lockd here, before we might error out */
 	error = nfs_start_lockd(server);
 	if (error < 0)
 		goto error;
 
-	server->port = cfg->nfs_server.port;
-	server->auth_info = cfg->auth_info;
+	server->port = ctx->nfs_server.port;
+	server->auth_info = ctx->auth_info;
 
 	error = nfs_init_server_rpcclient(server, &timeparms,
-					  cfg->selected_flavor);
+					  ctx->selected_flavor);
 	if (error < 0)
 		goto error;
 
 	/* Preserve the values of mount_server-related mount options */
-	if (cfg->mount_server.addrlen) {
-		memcpy(&server->mountd_address, &cfg->mount_server.address,
-			cfg->mount_server.addrlen);
-		server->mountd_addrlen = cfg->mount_server.addrlen;
+	if (ctx->mount_server.addrlen) {
+		memcpy(&server->mountd_address, &ctx->mount_server.address,
+			ctx->mount_server.addrlen);
+		server->mountd_addrlen = ctx->mount_server.addrlen;
 	}
-	server->mountd_version = cfg->mount_server.version;
-	server->mountd_port = cfg->mount_server.port;
-	server->mountd_protocol = cfg->mount_server.protocol;
+	server->mountd_version = ctx->mount_server.version;
+	server->mountd_port = ctx->mount_server.port;
+	server->mountd_protocol = ctx->mount_server.protocol;
 
-	server->namelen  = cfg->namlen;
+	server->namelen  = ctx->namlen;
 	return 0;
 
 error:
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d44de53c17a6..9aa27093d8b6 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -726,11 +726,11 @@ bool nfs_auth_info_match(const struct nfs_auth_info *auth_info,
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
 
 /*
- * Ensure that a specified authtype in cfg->auth_info is supported by
- * the server. Returns 0 and sets cfg->selected_flavor if it's ok, and
+ * Ensure that a specified authtype in ctx->auth_info is supported by
+ * the server. Returns 0 and sets ctx->selected_flavor if it's ok, and
  * -EACCES if not.
  */
-static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
+static int nfs_verify_authflavors(struct nfs_fs_context *ctx,
 				  rpc_authflavor_t *server_authlist,
 				  unsigned int count)
 {
@@ -753,7 +753,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	for (i = 0; i < count; i++) {
 		flavor = server_authlist[i];
 
-		if (nfs_auth_info_match(&cfg->auth_info, flavor))
+		if (nfs_auth_info_match(&ctx->auth_info, flavor))
 			goto out;
 
 		if (flavor == RPC_AUTH_NULL)
@@ -761,7 +761,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	}
 
 	if (found_auth_null) {
-		flavor = cfg->auth_info.flavors[0];
+		flavor = ctx->auth_info.flavors[0];
 		goto out;
 	}
 
@@ -770,8 +770,8 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
 	return -EACCES;
 
 out:
-	cfg->selected_flavor = flavor;
-	dfprintk(MOUNT, "NFS: using auth flavor %u\n", cfg->selected_flavor);
+	ctx->selected_flavor = flavor;
+	dfprintk(MOUNT, "NFS: using auth flavor %u\n", ctx->selected_flavor);
 	return 0;
 }
 
@@ -779,50 +779,50 @@ static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_fs_context *cfg,
+static int nfs_request_mount(struct nfs_fs_context *ctx,
 			     struct nfs_fh *root_fh,
 			     rpc_authflavor_t *server_authlist,
 			     unsigned int *server_authlist_len)
 {
 	struct nfs_mount_request request = {
 		.sap		= (struct sockaddr *)
-						&cfg->mount_server.address,
-		.dirpath	= cfg->nfs_server.export_path,
-		.protocol	= cfg->mount_server.protocol,
+						&ctx->mount_server.address,
+		.dirpath	= ctx->nfs_server.export_path,
+		.protocol	= ctx->mount_server.protocol,
 		.fh		= root_fh,
-		.noresvport	= cfg->flags & NFS_MOUNT_NORESVPORT,
+		.noresvport	= ctx->flags & NFS_MOUNT_NORESVPORT,
 		.auth_flav_len	= server_authlist_len,
 		.auth_flavs	= server_authlist,
-		.net		= cfg->net,
+		.net		= ctx->net,
 	};
 	int status;
 
-	if (cfg->mount_server.version == 0) {
-		switch (cfg->version) {
+	if (ctx->mount_server.version == 0) {
+		switch (ctx->version) {
 			default:
-				cfg->mount_server.version = NFS_MNT3_VERSION;
+				ctx->mount_server.version = NFS_MNT3_VERSION;
 				break;
 			case 2:
-				cfg->mount_server.version = NFS_MNT_VERSION;
+				ctx->mount_server.version = NFS_MNT_VERSION;
 		}
 	}
-	request.version = cfg->mount_server.version;
+	request.version = ctx->mount_server.version;
 
-	if (cfg->mount_server.hostname)
-		request.hostname = cfg->mount_server.hostname;
+	if (ctx->mount_server.hostname)
+		request.hostname = ctx->mount_server.hostname;
 	else
-		request.hostname = cfg->nfs_server.hostname;
+		request.hostname = ctx->nfs_server.hostname;
 
 	/*
 	 * Construct the mount server's address.
 	 */
-	if (cfg->mount_server.address.sa_family == AF_UNSPEC) {
-		memcpy(request.sap, &cfg->nfs_server.address,
-		       cfg->nfs_server.addrlen);
-		cfg->mount_server.addrlen = cfg->nfs_server.addrlen;
+	if (ctx->mount_server.address.sa_family == AF_UNSPEC) {
+		memcpy(request.sap, &ctx->nfs_server.address,
+		       ctx->nfs_server.addrlen);
+		ctx->mount_server.addrlen = ctx->nfs_server.addrlen;
 	}
-	request.salen = cfg->mount_server.addrlen;
-	nfs_set_port(request.sap, &cfg->mount_server.port, 0);
+	request.salen = ctx->mount_server.addrlen;
+	nfs_set_port(request.sap, &ctx->mount_server.port, 0);
 
 	/*
 	 * Now ask the mount server to map our export path
-- 
2.17.2

