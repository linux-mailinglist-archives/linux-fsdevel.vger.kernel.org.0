Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D951282A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfEWQSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbfEWQS3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:18:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06AC8317917D;
        Thu, 23 May 2019 16:18:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9F845C219;
        Thu, 23 May 2019 16:18:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/23] NFS: Rename struct nfs_parsed_mount_data to struct
 nfs_fs_context
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:26 +0100
Message-ID: <155862830607.26654.17544079891001252500.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 23 May 2019 16:18:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename struct nfs_parsed_mount_data to struct nfs_fs_context and rename
pointers to it to "ctx".  At some point this will be pointed to by an
fs_context struct's fs_private pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/client.c     |   64 ++++---
 fs/nfs/fs_context.c |  444 +++++++++++++++++++++++++--------------------------
 fs/nfs/internal.h   |   14 +-
 fs/nfs/nfs4client.c |   58 +++----
 fs/nfs/nfs4super.c  |    6 -
 fs/nfs/super.c      |  192 +++++++++++-----------
 6 files changed, 389 insertions(+), 389 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d30e38e3802f..4534ecebe380 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -649,26 +649,26 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-			   const struct nfs_parsed_mount_data *data,
+			   const struct nfs_fs_context *cfg,
 			   struct nfs_subversion *nfs_mod)
 {
 	struct rpc_timeout timeparms;
 	struct nfs_client_initdata cl_init = {
-		.hostname = data->nfs_server.hostname,
-		.addr = (const struct sockaddr *)&data->nfs_server.address,
-		.addrlen = data->nfs_server.addrlen,
+		.hostname = cfg->nfs_server.hostname,
+		.addr = (const struct sockaddr *)&cfg->nfs_server.address,
+		.addrlen = cfg->nfs_server.addrlen,
 		.nfs_mod = nfs_mod,
-		.proto = data->nfs_server.protocol,
-		.net = data->net,
+		.proto = cfg->nfs_server.protocol,
+		.net = cfg->net,
 		.timeparms = &timeparms,
 		.cred = server->cred,
 	};
 	struct nfs_client *clp;
 	int error;
 
-	nfs_init_timeout_values(&timeparms, data->nfs_server.protocol,
-			data->timeo, data->retrans);
-	if (data->flags & NFS_MOUNT_NORESVPORT)
+	nfs_init_timeout_values(&timeparms, cfg->nfs_server.protocol,
+				cfg->timeo, cfg->retrans);
+	if (cfg->flags & NFS_MOUNT_NORESVPORT)
 		set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	/* Allocate or find a client reference we can use */
@@ -679,46 +679,46 @@ static int nfs_init_server(struct nfs_server *server,
 	server->nfs_client = clp;
 
 	/* Initialise the client representation from the mount data */
-	server->flags = data->flags;
-	server->options = data->options;
+	server->flags = cfg->flags;
+	server->options = cfg->options;
 	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
 		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
 		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
 
-	if (data->rsize)
-		server->rsize = nfs_block_size(data->rsize, NULL);
-	if (data->wsize)
-		server->wsize = nfs_block_size(data->wsize, NULL);
+	if (cfg->rsize)
+		server->rsize = nfs_block_size(cfg->rsize, NULL);
+	if (cfg->wsize)
+		server->wsize = nfs_block_size(cfg->wsize, NULL);
 
-	server->acregmin = data->acregmin * HZ;
-	server->acregmax = data->acregmax * HZ;
-	server->acdirmin = data->acdirmin * HZ;
-	server->acdirmax = data->acdirmax * HZ;
+	server->acregmin = cfg->acregmin * HZ;
+	server->acregmax = cfg->acregmax * HZ;
+	server->acdirmin = cfg->acdirmin * HZ;
+	server->acdirmax = cfg->acdirmax * HZ;
 
 	/* Start lockd here, before we might error out */
 	error = nfs_start_lockd(server);
 	if (error < 0)
 		goto error;
 
-	server->port = data->nfs_server.port;
-	server->auth_info = data->auth_info;
+	server->port = cfg->nfs_server.port;
+	server->auth_info = cfg->auth_info;
 
 	error = nfs_init_server_rpcclient(server, &timeparms,
-					  data->selected_flavor);
+					  cfg->selected_flavor);
 	if (error < 0)
 		goto error;
 
 	/* Preserve the values of mount_server-related mount options */
-	if (data->mount_server.addrlen) {
-		memcpy(&server->mountd_address, &data->mount_server.address,
-			data->mount_server.addrlen);
-		server->mountd_addrlen = data->mount_server.addrlen;
+	if (cfg->mount_server.addrlen) {
+		memcpy(&server->mountd_address, &cfg->mount_server.address,
+			cfg->mount_server.addrlen);
+		server->mountd_addrlen = cfg->mount_server.addrlen;
 	}
-	server->mountd_version = data->mount_server.version;
-	server->mountd_port = data->mount_server.port;
-	server->mountd_protocol = data->mount_server.protocol;
+	server->mountd_version = cfg->mount_server.version;
+	server->mountd_port = cfg->mount_server.port;
+	server->mountd_protocol = cfg->mount_server.protocol;
 
-	server->namelen  = data->namlen;
+	server->namelen  = cfg->namlen;
 	return 0;
 
 error:
@@ -959,7 +959,7 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 		goto error;
 
 	/* Get a client representation */
-	error = nfs_init_server(server, mount_info->parsed, nfs_mod);
+	error = nfs_init_server(server, mount_info->ctx, nfs_mod);
 	if (error < 0)
 		goto error;
 
@@ -970,7 +970,7 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 	if (server->nfs_client->rpc_ops->version == 3) {
 		if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
 			server->namelen = NFS3_MAXNAMLEN;
-		if (!(mount_info->parsed->flags & NFS_MOUNT_NORDIRPLUS))
+		if (!(mount_info->ctx->flags & NFS_MOUNT_NORDIRPLUS))
 			server->caps |= NFS_CAP_READDIRPLUS;
 	} else {
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 265c22b3367f..10fe721756eb 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -241,40 +241,40 @@ static const match_table_t nfs_vers_tokens = {
 	{ Opt_vers_err, NULL }
 };
 
-struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void)
+struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
 {
-	struct nfs_parsed_mount_data *data;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (data) {
-		data->timeo		= NFS_UNSPEC_TIMEO;
-		data->retrans		= NFS_UNSPEC_RETRANS;
-		data->acregmin		= NFS_DEF_ACREGMIN;
-		data->acregmax		= NFS_DEF_ACREGMAX;
-		data->acdirmin		= NFS_DEF_ACDIRMIN;
-		data->acdirmax		= NFS_DEF_ACDIRMAX;
-		data->mount_server.port	= NFS_UNSPEC_PORT;
-		data->nfs_server.port	= NFS_UNSPEC_PORT;
-		data->nfs_server.protocol = XPRT_TRANSPORT_TCP;
-		data->selected_flavor	= RPC_AUTH_MAXFLAVOR;
-		data->minorversion	= 0;
-		data->need_mount	= true;
-		data->net		= current->nsproxy->net_ns;
-		data->lsm_opts		= NULL;
+	struct nfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx) {
+		ctx->timeo		= NFS_UNSPEC_TIMEO;
+		ctx->retrans		= NFS_UNSPEC_RETRANS;
+		ctx->acregmin		= NFS_DEF_ACREGMIN;
+		ctx->acregmax		= NFS_DEF_ACREGMAX;
+		ctx->acdirmin		= NFS_DEF_ACDIRMIN;
+		ctx->acdirmax		= NFS_DEF_ACDIRMAX;
+		ctx->mount_server.port	= NFS_UNSPEC_PORT;
+		ctx->nfs_server.port	= NFS_UNSPEC_PORT;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
+		ctx->minorversion	= 0;
+		ctx->need_mount	= true;
+		ctx->net		= current->nsproxy->net_ns;
+		ctx->lsm_opts = NULL;
 	}
-	return data;
+	return ctx;
 }
 
-void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)
+void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx)
 {
-	if (data) {
-		kfree(data->client_address);
-		kfree(data->mount_server.hostname);
-		kfree(data->nfs_server.export_path);
-		kfree(data->nfs_server.hostname);
-		kfree(data->fscache_uniq);
-		security_free_mnt_opts(&data->lsm_opts);
-		kfree(data);
+	if (ctx) {
+		kfree(ctx->client_address);
+		kfree(ctx->mount_server.hostname);
+		kfree(ctx->nfs_server.export_path);
+		kfree(ctx->nfs_server.hostname);
+		kfree(ctx->fscache_uniq);
+		security_free_mnt_opts(&ctx->lsm_opts);
+		kfree(ctx);
 	}
 }
 
@@ -305,15 +305,15 @@ static int nfs_verify_server_address(struct sockaddr *addr)
  * Sanity check the NFS transport protocol.
  *
  */
-static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *mnt)
+static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
 {
-	switch (mnt->nfs_server.protocol) {
+	switch (ctx->nfs_server.protocol) {
 	case XPRT_TRANSPORT_UDP:
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
 		break;
 	default:
-		mnt->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 	}
 }
 
@@ -321,20 +321,20 @@ static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *mnt)
  * For text based NFSv2/v3 mounts, the mount protocol transport default
  * settings should depend upon the specified NFS transport.
  */
-static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data *mnt)
+static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 {
-	nfs_validate_transport_protocol(mnt);
+	nfs_validate_transport_protocol(ctx);
 
-	if (mnt->mount_server.protocol == XPRT_TRANSPORT_UDP ||
-	    mnt->mount_server.protocol == XPRT_TRANSPORT_TCP)
+	if (ctx->mount_server.protocol == XPRT_TRANSPORT_UDP ||
+	    ctx->mount_server.protocol == XPRT_TRANSPORT_TCP)
 			return;
-	switch (mnt->nfs_server.protocol) {
+	switch (ctx->nfs_server.protocol) {
 	case XPRT_TRANSPORT_UDP:
-		mnt->mount_server.protocol = XPRT_TRANSPORT_UDP;
+		ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 		break;
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
-		mnt->mount_server.protocol = XPRT_TRANSPORT_TCP;
+		ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 	}
 }
 
@@ -366,8 +366,7 @@ static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
 /*
  * Parse the value of the 'sec=' option.
  */
-static int nfs_parse_security_flavors(char *value,
-				      struct nfs_parsed_mount_data *mnt)
+static int nfs_parse_security_flavors(char *value, struct nfs_fs_context *ctx)
 {
 	substring_t args[MAX_OPT_ARGS];
 	rpc_authflavor_t pseudoflavor;
@@ -416,7 +415,7 @@ static int nfs_parse_security_flavors(char *value,
 			return 0;
 		}
 
-		if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
+		if (!nfs_auth_info_add(&ctx->auth_info, pseudoflavor))
 			return 0;
 	}
 
@@ -424,36 +423,36 @@ static int nfs_parse_security_flavors(char *value,
 }
 
 static int nfs_parse_version_string(char *string,
-		struct nfs_parsed_mount_data *mnt,
+		struct nfs_fs_context *ctx,
 		substring_t *args)
 {
-	mnt->flags &= ~NFS_MOUNT_VER3;
+	ctx->flags &= ~NFS_MOUNT_VER3;
 	switch (match_token(string, nfs_vers_tokens, args)) {
 	case Opt_vers_2:
-		mnt->version = 2;
+		ctx->version = 2;
 		break;
 	case Opt_vers_3:
-		mnt->flags |= NFS_MOUNT_VER3;
-		mnt->version = 3;
+		ctx->flags |= NFS_MOUNT_VER3;
+		ctx->version = 3;
 		break;
 	case Opt_vers_4:
 		/* Backward compatibility option. In future,
 		 * the mount program should always supply
 		 * a NFSv4 minor version number.
 		 */
-		mnt->version = 4;
+		ctx->version = 4;
 		break;
 	case Opt_vers_4_0:
-		mnt->version = 4;
-		mnt->minorversion = 0;
+		ctx->version = 4;
+		ctx->minorversion = 0;
 		break;
 	case Opt_vers_4_1:
-		mnt->version = 4;
-		mnt->minorversion = 1;
+		ctx->version = 4;
+		ctx->minorversion = 1;
 		break;
 	case Opt_vers_4_2:
-		mnt->version = 4;
-		mnt->minorversion = 2;
+		ctx->version = 4;
+		ctx->minorversion = 2;
 		break;
 	default:
 		return 0;
@@ -501,7 +500,7 @@ static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
  * skipped as they are encountered.  If there were no errors, return 1;
  * otherwise return 0 (zero).
  */
-int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
+int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 {
 	char *p, *string;
 	int rc, sloppy = 0, invalid_option = 0;
@@ -514,7 +513,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 	}
 	dfprintk(MOUNT, "NFS: nfs mount opts='%s'\n", raw);
 
-	rc = security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
+	rc = security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
 	if (rc)
 		goto out_security_failure;
 
@@ -535,96 +534,96 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 		 * boolean options:  foo/nofoo
 		 */
 		case Opt_soft:
-			mnt->flags |= NFS_MOUNT_SOFT;
-			mnt->flags &= ~NFS_MOUNT_SOFTERR;
+			ctx->flags |= NFS_MOUNT_SOFT;
+			ctx->flags &= ~NFS_MOUNT_SOFTERR;
 			break;
 		case Opt_softerr:
-			mnt->flags |= NFS_MOUNT_SOFTERR;
-			mnt->flags &= ~NFS_MOUNT_SOFT;
+			ctx->flags |= NFS_MOUNT_SOFTERR;
+			ctx->flags &= ~NFS_MOUNT_SOFT;
 			break;
 		case Opt_hard:
-			mnt->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+			ctx->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
 			break;
 		case Opt_posix:
-			mnt->flags |= NFS_MOUNT_POSIX;
+			ctx->flags |= NFS_MOUNT_POSIX;
 			break;
 		case Opt_noposix:
-			mnt->flags &= ~NFS_MOUNT_POSIX;
+			ctx->flags &= ~NFS_MOUNT_POSIX;
 			break;
 		case Opt_cto:
-			mnt->flags &= ~NFS_MOUNT_NOCTO;
+			ctx->flags &= ~NFS_MOUNT_NOCTO;
 			break;
 		case Opt_nocto:
-			mnt->flags |= NFS_MOUNT_NOCTO;
+			ctx->flags |= NFS_MOUNT_NOCTO;
 			break;
 		case Opt_ac:
-			mnt->flags &= ~NFS_MOUNT_NOAC;
+			ctx->flags &= ~NFS_MOUNT_NOAC;
 			break;
 		case Opt_noac:
-			mnt->flags |= NFS_MOUNT_NOAC;
+			ctx->flags |= NFS_MOUNT_NOAC;
 			break;
 		case Opt_lock:
-			mnt->flags &= ~NFS_MOUNT_NONLM;
-			mnt->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
+			ctx->flags &= ~NFS_MOUNT_NONLM;
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
 					NFS_MOUNT_LOCAL_FCNTL);
 			break;
 		case Opt_nolock:
-			mnt->flags |= NFS_MOUNT_NONLM;
-			mnt->flags |= (NFS_MOUNT_LOCAL_FLOCK |
+			ctx->flags |= NFS_MOUNT_NONLM;
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
 				       NFS_MOUNT_LOCAL_FCNTL);
 			break;
 		case Opt_udp:
-			mnt->flags &= ~NFS_MOUNT_TCP;
-			mnt->nfs_server.protocol = XPRT_TRANSPORT_UDP;
+			ctx->flags &= ~NFS_MOUNT_TCP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_tcp:
-			mnt->flags |= NFS_MOUNT_TCP;
-			mnt->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+			ctx->flags |= NFS_MOUNT_TCP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
 		case Opt_rdma:
-			mnt->flags |= NFS_MOUNT_TCP; /* for side protocols */
-			mnt->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
+			ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
 			xprt_load_transport(p);
 			break;
 		case Opt_acl:
-			mnt->flags &= ~NFS_MOUNT_NOACL;
+			ctx->flags &= ~NFS_MOUNT_NOACL;
 			break;
 		case Opt_noacl:
-			mnt->flags |= NFS_MOUNT_NOACL;
+			ctx->flags |= NFS_MOUNT_NOACL;
 			break;
 		case Opt_rdirplus:
-			mnt->flags &= ~NFS_MOUNT_NORDIRPLUS;
+			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
 			break;
 		case Opt_nordirplus:
-			mnt->flags |= NFS_MOUNT_NORDIRPLUS;
+			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
 			break;
 		case Opt_sharecache:
-			mnt->flags &= ~NFS_MOUNT_UNSHARED;
+			ctx->flags &= ~NFS_MOUNT_UNSHARED;
 			break;
 		case Opt_nosharecache:
-			mnt->flags |= NFS_MOUNT_UNSHARED;
+			ctx->flags |= NFS_MOUNT_UNSHARED;
 			break;
 		case Opt_resvport:
-			mnt->flags &= ~NFS_MOUNT_NORESVPORT;
+			ctx->flags &= ~NFS_MOUNT_NORESVPORT;
 			break;
 		case Opt_noresvport:
-			mnt->flags |= NFS_MOUNT_NORESVPORT;
+			ctx->flags |= NFS_MOUNT_NORESVPORT;
 			break;
 		case Opt_fscache:
-			mnt->options |= NFS_OPTION_FSCACHE;
-			kfree(mnt->fscache_uniq);
-			mnt->fscache_uniq = NULL;
+			ctx->options |= NFS_OPTION_FSCACHE;
+			kfree(ctx->fscache_uniq);
+			ctx->fscache_uniq = NULL;
 			break;
 		case Opt_nofscache:
-			mnt->options &= ~NFS_OPTION_FSCACHE;
-			kfree(mnt->fscache_uniq);
-			mnt->fscache_uniq = NULL;
+			ctx->options &= ~NFS_OPTION_FSCACHE;
+			kfree(ctx->fscache_uniq);
+			ctx->fscache_uniq = NULL;
 			break;
 		case Opt_migration:
-			mnt->options |= NFS_OPTION_MIGRATION;
+			ctx->options |= NFS_OPTION_MIGRATION;
 			break;
 		case Opt_nomigration:
-			mnt->options &= ~NFS_OPTION_MIGRATION;
+			ctx->options &= ~NFS_OPTION_MIGRATION;
 			break;
 
 		/*
@@ -634,83 +633,83 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			if (nfs_get_option_ul(args, &option) ||
 			    option > USHRT_MAX)
 				goto out_invalid_value;
-			mnt->nfs_server.port = option;
+			ctx->nfs_server.port = option;
 			break;
 		case Opt_rsize:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->rsize = option;
+			ctx->rsize = option;
 			break;
 		case Opt_wsize:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->wsize = option;
+			ctx->wsize = option;
 			break;
 		case Opt_bsize:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->bsize = option;
+			ctx->bsize = option;
 			break;
 		case Opt_timeo:
 			if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
 				goto out_invalid_value;
-			mnt->timeo = option;
+			ctx->timeo = option;
 			break;
 		case Opt_retrans:
 			if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
 				goto out_invalid_value;
-			mnt->retrans = option;
+			ctx->retrans = option;
 			break;
 		case Opt_acregmin:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->acregmin = option;
+			ctx->acregmin = option;
 			break;
 		case Opt_acregmax:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->acregmax = option;
+			ctx->acregmax = option;
 			break;
 		case Opt_acdirmin:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->acdirmin = option;
+			ctx->acdirmin = option;
 			break;
 		case Opt_acdirmax:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->acdirmax = option;
+			ctx->acdirmax = option;
 			break;
 		case Opt_actimeo:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->acregmin = mnt->acregmax =
-			mnt->acdirmin = mnt->acdirmax = option;
+			ctx->acregmin = ctx->acregmax =
+			ctx->acdirmin = ctx->acdirmax = option;
 			break;
 		case Opt_namelen:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
-			mnt->namlen = option;
+			ctx->namlen = option;
 			break;
 		case Opt_mountport:
 			if (nfs_get_option_ul(args, &option) ||
 			    option > USHRT_MAX)
 				goto out_invalid_value;
-			mnt->mount_server.port = option;
+			ctx->mount_server.port = option;
 			break;
 		case Opt_mountvers:
 			if (nfs_get_option_ul(args, &option) ||
 			    option < NFS_MNT_VERSION ||
 			    option > NFS_MNT3_VERSION)
 				goto out_invalid_value;
-			mnt->mount_server.version = option;
+			ctx->mount_server.version = option;
 			break;
 		case Opt_minorversion:
 			if (nfs_get_option_ul(args, &option))
 				goto out_invalid_value;
 			if (option > NFS4_MAX_MINOR_VERSION)
 				goto out_invalid_value;
-			mnt->minorversion = option;
+			ctx->minorversion = option;
 			break;
 
 		/*
@@ -720,7 +719,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			string = match_strdup(args);
 			if (string == NULL)
 				goto out_nomem;
-			rc = nfs_parse_version_string(string, mnt, args);
+			rc = nfs_parse_version_string(string, ctx, args);
 			kfree(string);
 			if (!rc)
 				goto out_invalid_value;
@@ -729,7 +728,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			string = match_strdup(args);
 			if (string == NULL)
 				goto out_nomem;
-			rc = nfs_parse_security_flavors(string, mnt);
+			rc = nfs_parse_security_flavors(string, ctx);
 			kfree(string);
 			if (!rc) {
 				dfprintk(MOUNT, "NFS:   unrecognized "
@@ -750,23 +749,23 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 				protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_udp:
-				mnt->flags &= ~NFS_MOUNT_TCP;
-				mnt->nfs_server.protocol = XPRT_TRANSPORT_UDP;
+				ctx->flags &= ~NFS_MOUNT_TCP;
+				ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 				break;
 			case Opt_xprt_tcp6:
 				protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_tcp:
-				mnt->flags |= NFS_MOUNT_TCP;
-				mnt->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+				ctx->flags |= NFS_MOUNT_TCP;
+				ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 				break;
 			case Opt_xprt_rdma6:
 				protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_rdma:
 				/* vector side protocols to TCP */
-				mnt->flags |= NFS_MOUNT_TCP;
-				mnt->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
+				ctx->flags |= NFS_MOUNT_TCP;
+				ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
 				xprt_load_transport(string);
 				break;
 			default:
@@ -791,13 +790,13 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 				mountfamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_udp:
-				mnt->mount_server.protocol = XPRT_TRANSPORT_UDP;
+				ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 				break;
 			case Opt_xprt_tcp6:
 				mountfamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_tcp:
-				mnt->mount_server.protocol = XPRT_TRANSPORT_TCP;
+				ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 				break;
 			case Opt_xprt_rdma: /* not used for side protocols */
 			default:
@@ -810,35 +809,35 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			string = match_strdup(args);
 			if (string == NULL)
 				goto out_nomem;
-			mnt->nfs_server.addrlen =
-				rpc_pton(mnt->net, string, strlen(string),
+			ctx->nfs_server.addrlen =
+				rpc_pton(ctx->net, string, strlen(string),
 					(struct sockaddr *)
-					&mnt->nfs_server.address,
-					sizeof(mnt->nfs_server.address));
+					&ctx->nfs_server.address,
+					sizeof(ctx->nfs_server.address));
 			kfree(string);
-			if (mnt->nfs_server.addrlen == 0)
+			if (ctx->nfs_server.addrlen == 0)
 				goto out_invalid_address;
 			break;
 		case Opt_clientaddr:
-			if (nfs_get_option_str(args, &mnt->client_address))
+			if (nfs_get_option_str(args, &ctx->client_address))
 				goto out_nomem;
 			break;
 		case Opt_mounthost:
 			if (nfs_get_option_str(args,
-					       &mnt->mount_server.hostname))
+					       &ctx->mount_server.hostname))
 				goto out_nomem;
 			break;
 		case Opt_mountaddr:
 			string = match_strdup(args);
 			if (string == NULL)
 				goto out_nomem;
-			mnt->mount_server.addrlen =
-				rpc_pton(mnt->net, string, strlen(string),
+			ctx->mount_server.addrlen =
+				rpc_pton(ctx->net, string, strlen(string),
 					(struct sockaddr *)
-					&mnt->mount_server.address,
-					sizeof(mnt->mount_server.address));
+					&ctx->mount_server.address,
+					sizeof(ctx->mount_server.address));
 			kfree(string);
-			if (mnt->mount_server.addrlen == 0)
+			if (ctx->mount_server.addrlen == 0)
 				goto out_invalid_address;
 			break;
 		case Opt_lookupcache:
@@ -850,14 +849,14 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			kfree(string);
 			switch (token) {
 				case Opt_lookupcache_all:
-					mnt->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
+					ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
 					break;
 				case Opt_lookupcache_positive:
-					mnt->flags &= ~NFS_MOUNT_LOOKUP_CACHE_NONE;
-					mnt->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG;
+					ctx->flags &= ~NFS_MOUNT_LOOKUP_CACHE_NONE;
+					ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG;
 					break;
 				case Opt_lookupcache_none:
-					mnt->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
+					ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
 					break;
 				default:
 					dfprintk(MOUNT, "NFS:   invalid "
@@ -866,9 +865,9 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			};
 			break;
 		case Opt_fscache_uniq:
-			if (nfs_get_option_str(args, &mnt->fscache_uniq))
+			if (nfs_get_option_str(args, &ctx->fscache_uniq))
 				goto out_nomem;
-			mnt->options |= NFS_OPTION_FSCACHE;
+			ctx->options |= NFS_OPTION_FSCACHE;
 			break;
 		case Opt_local_lock:
 			string = match_strdup(args);
@@ -879,17 +878,17 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 			kfree(string);
 			switch (token) {
 			case Opt_local_lock_all:
-				mnt->flags |= (NFS_MOUNT_LOCAL_FLOCK |
+				ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
 					       NFS_MOUNT_LOCAL_FCNTL);
 				break;
 			case Opt_local_lock_flock:
-				mnt->flags |= NFS_MOUNT_LOCAL_FLOCK;
+				ctx->flags |= NFS_MOUNT_LOCAL_FLOCK;
 				break;
 			case Opt_local_lock_posix:
-				mnt->flags |= NFS_MOUNT_LOCAL_FCNTL;
+				ctx->flags |= NFS_MOUNT_LOCAL_FCNTL;
 				break;
 			case Opt_local_lock_none:
-				mnt->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
+				ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
 						NFS_MOUNT_LOCAL_FCNTL);
 				break;
 			default:
@@ -922,11 +921,11 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 	if (!sloppy && invalid_option)
 		return 0;
 
-	if (mnt->minorversion && mnt->version != 4)
+	if (ctx->minorversion && ctx->version != 4)
 		goto out_minorversion_mismatch;
 
-	if (mnt->options & NFS_OPTION_MIGRATION &&
-	    (mnt->version != 4 || mnt->minorversion != 0))
+	if (ctx->options & NFS_OPTION_MIGRATION &&
+	    (ctx->version != 4 || ctx->minorversion != 0))
 		goto out_migration_misuse;
 
 	/*
@@ -934,15 +933,15 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 	 * families in the addr=/mountaddr= options.
 	 */
 	if (protofamily != AF_UNSPEC &&
-	    protofamily != mnt->nfs_server.address.ss_family)
+	    protofamily != ctx->nfs_server.address.ss_family)
 		goto out_proto_mismatch;
 
 	if (mountfamily != AF_UNSPEC) {
-		if (mnt->mount_server.addrlen) {
-			if (mountfamily != mnt->mount_server.address.ss_family)
+		if (ctx->mount_server.addrlen) {
+			if (mountfamily != ctx->mount_server.address.ss_family)
 				goto out_mountproto_mismatch;
 		} else {
-			if (mountfamily != mnt->nfs_server.address.ss_family)
+			if (mountfamily != ctx->nfs_server.address.ss_family)
 				goto out_mountproto_mismatch;
 		}
 	}
@@ -964,7 +963,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
 	return 0;
 out_minorversion_mismatch:
 	printk(KERN_INFO "NFS: mount option vers=%u does not support "
-			 "minorversion=%u\n", mnt->version, mnt->minorversion);
+			 "minorversion=%u\n", ctx->version, ctx->minorversion);
 	return 0;
 out_migration_misuse:
 	printk(KERN_INFO
@@ -1072,18 +1071,18 @@ static int nfs_parse_devname(const char *dev_name,
  *   mountproto=tcp after mountproto=udp, and so on
  */
 static int nfs23_validate_mount_data(void *options,
-				     struct nfs_parsed_mount_data *args,
+				     struct nfs_fs_context *ctx,
 				     struct nfs_fh *mntfh,
 				     const char *dev_name)
 {
 	struct nfs_mount_data *data = (struct nfs_mount_data *)options;
-	struct sockaddr *sap = (struct sockaddr *)&args->nfs_server.address;
+	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
 
 	if (data == NULL)
 		goto out_no_data;
 
-	args->version = NFS_DEFAULT_VERSION;
+	ctx->version = NFS_DEFAULT_VERSION;
 	switch (data->version) {
 	case 1:
 		data->namlen = 0; /* fall through */
@@ -1109,10 +1108,10 @@ static int nfs23_validate_mount_data(void *options,
 			if (data->root.size > NFS3_FHSIZE || data->root.size == 0)
 				goto out_invalid_fh;
 			mntfh->size = data->root.size;
-			args->version = 3;
+			ctx->version = 3;
 		} else {
 			mntfh->size = NFS2_FHSIZE;
-			args->version = 2;
+			ctx->version = 2;
 		}
 
 
@@ -1122,47 +1121,47 @@ static int nfs23_validate_mount_data(void *options,
 			       sizeof(mntfh->data) - mntfh->size);
 
 		/*
-		 * Translate to nfs_parsed_mount_data, which nfs_fill_super
+		 * Translate to nfs_fs_context, which nfs_fill_super
 		 * can deal with.
 		 */
-		args->flags		= data->flags & NFS_MOUNT_FLAGMASK;
-		args->flags		|= extra_flags;
-		args->rsize		= data->rsize;
-		args->wsize		= data->wsize;
-		args->timeo		= data->timeo;
-		args->retrans		= data->retrans;
-		args->acregmin		= data->acregmin;
-		args->acregmax		= data->acregmax;
-		args->acdirmin		= data->acdirmin;
-		args->acdirmax		= data->acdirmax;
-		args->need_mount	= false;
+		ctx->flags	= data->flags & NFS_MOUNT_FLAGMASK;
+		ctx->flags	|= extra_flags;
+		ctx->rsize	= data->rsize;
+		ctx->wsize	= data->wsize;
+		ctx->timeo	= data->timeo;
+		ctx->retrans	= data->retrans;
+		ctx->acregmin	= data->acregmin;
+		ctx->acregmax	= data->acregmax;
+		ctx->acdirmin	= data->acdirmin;
+		ctx->acdirmax	= data->acdirmax;
+		ctx->need_mount	= false;
 
 		memcpy(sap, &data->addr, sizeof(data->addr));
-		args->nfs_server.addrlen = sizeof(data->addr);
-		args->nfs_server.port = ntohs(data->addr.sin_port);
+		ctx->nfs_server.addrlen = sizeof(data->addr);
+		ctx->nfs_server.port = ntohs(data->addr.sin_port);
 		if (sap->sa_family != AF_INET ||
 		    !nfs_verify_server_address(sap))
 			goto out_no_address;
 
 		if (!(data->flags & NFS_MOUNT_TCP))
-			args->nfs_server.protocol = XPRT_TRANSPORT_UDP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 		/* N.B. caller will free nfs_server.hostname in all cases */
-		args->nfs_server.hostname = kstrdup(data->hostname, GFP_KERNEL);
-		args->namlen		= data->namlen;
-		args->bsize		= data->bsize;
+		ctx->nfs_server.hostname = kstrdup(data->hostname, GFP_KERNEL);
+		ctx->namlen		= data->namlen;
+		ctx->bsize		= data->bsize;
 
 		if (data->flags & NFS_MOUNT_SECFLAVOUR)
-			args->selected_flavor = data->pseudoflavor;
+			ctx->selected_flavor = data->pseudoflavor;
 		else
-			args->selected_flavor = RPC_AUTH_UNIX;
-		if (!args->nfs_server.hostname)
+			ctx->selected_flavor = RPC_AUTH_UNIX;
+		if (!ctx->nfs_server.hostname)
 			goto out_nomem;
 
 		if (!(data->flags & NFS_MOUNT_NONLM))
-			args->flags &= ~(NFS_MOUNT_LOCAL_FLOCK|
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK|
 					 NFS_MOUNT_LOCAL_FCNTL);
 		else
-			args->flags |= (NFS_MOUNT_LOCAL_FLOCK|
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK|
 					NFS_MOUNT_LOCAL_FCNTL);
 		/*
 		 * The legacy version 6 binary mount data from userspace has a
@@ -1177,7 +1176,7 @@ static int nfs23_validate_mount_data(void *options,
 			int rc;
 			data->context[NFS_MAX_CONTEXT_LEN] = '\0';
 			rc = security_add_mnt_opt("context", data->context,
-					strlen(data->context), &args->lsm_opts);
+					strlen(data->context), ctx->lsm_opts);
 			if (rc)
 				return rc;
 #else
@@ -1219,10 +1218,9 @@ static int nfs23_validate_mount_data(void *options,
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-
-static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *args)
+static void nfs4_validate_mount_flags(struct nfs_fs_context *ctx)
 {
-	args->flags &= ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
+	ctx->flags &= ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
 			 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
 }
 
@@ -1230,30 +1228,30 @@ static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *args)
  * Validate NFSv4 mount options
  */
 static int nfs4_validate_mount_data(void *options,
-				    struct nfs_parsed_mount_data *args,
+				    struct nfs_fs_context *ctx,
 				    const char *dev_name)
 {
-	struct sockaddr *sap = (struct sockaddr *)&args->nfs_server.address;
+	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	struct nfs4_mount_data *data = (struct nfs4_mount_data *)options;
 	char *c;
 
 	if (data == NULL)
 		goto out_no_data;
 
-	args->version = 4;
+	ctx->version = 4;
 
 	switch (data->version) {
 	case 1:
-		if (data->host_addrlen > sizeof(args->nfs_server.address))
+		if (data->host_addrlen > sizeof(ctx->nfs_server.address))
 			goto out_no_address;
 		if (data->host_addrlen == 0)
 			goto out_no_address;
-		args->nfs_server.addrlen = data->host_addrlen;
+		ctx->nfs_server.addrlen = data->host_addrlen;
 		if (copy_from_user(sap, data->host_addr, data->host_addrlen))
 			return -EFAULT;
 		if (!nfs_verify_server_address(sap))
 			goto out_no_address;
-		args->nfs_server.port = ntohs(((struct sockaddr_in *)sap)->sin_port);
+		ctx->nfs_server.port = ntohs(((struct sockaddr_in *)sap)->sin_port);
 
 		if (data->auth_flavourlen) {
 			rpc_authflavor_t pseudoflavor;
@@ -1263,43 +1261,43 @@ static int nfs4_validate_mount_data(void *options,
 					   data->auth_flavours,
 					   sizeof(pseudoflavor)))
 				return -EFAULT;
-			args->selected_flavor = pseudoflavor;
+			ctx->selected_flavor = pseudoflavor;
 		} else
-			args->selected_flavor = RPC_AUTH_UNIX;
+			ctx->selected_flavor = RPC_AUTH_UNIX;
 
 		c = strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
 		if (IS_ERR(c))
 			return PTR_ERR(c);
-		args->nfs_server.hostname = c;
+		ctx->nfs_server.hostname = c;
 
 		c = strndup_user(data->mnt_path.data, NFS4_MAXPATHLEN);
 		if (IS_ERR(c))
 			return PTR_ERR(c);
-		args->nfs_server.export_path = c;
+		ctx->nfs_server.export_path = c;
 		dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
 
 		c = strndup_user(data->client_addr.data, 16);
 		if (IS_ERR(c))
 			return PTR_ERR(c);
-		args->client_address = c;
+		ctx->client_address = c;
 
 		/*
-		 * Translate to nfs_parsed_mount_data, which nfs4_fill_super
+		 * Translate to nfs_fs_context, which nfs4_fill_super
 		 * can deal with.
 		 */
 
-		args->flags	= data->flags & NFS4_MOUNT_FLAGMASK;
-		args->rsize	= data->rsize;
-		args->wsize	= data->wsize;
-		args->timeo	= data->timeo;
-		args->retrans	= data->retrans;
-		args->acregmin	= data->acregmin;
-		args->acregmax	= data->acregmax;
-		args->acdirmin	= data->acdirmin;
-		args->acdirmax	= data->acdirmax;
-		args->nfs_server.protocol = data->proto;
-		nfs_validate_transport_protocol(args);
-		if (args->nfs_server.protocol == XPRT_TRANSPORT_UDP)
+		ctx->flags	= data->flags & NFS4_MOUNT_FLAGMASK;
+		ctx->rsize	= data->rsize;
+		ctx->wsize	= data->wsize;
+		ctx->timeo	= data->timeo;
+		ctx->retrans	= data->retrans;
+		ctx->acregmin	= data->acregmin;
+		ctx->acregmax	= data->acregmax;
+		ctx->acdirmin	= data->acdirmin;
+		ctx->acdirmax	= data->acdirmax;
+		ctx->nfs_server.protocol = data->proto;
+		nfs_validate_transport_protocol(ctx);
+		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
 			goto out_invalid_transport_udp;
 
 		break;
@@ -1329,67 +1327,67 @@ static int nfs4_validate_mount_data(void *options,
 
 int nfs_validate_mount_data(struct file_system_type *fs_type,
 			    void *options,
-			    struct nfs_parsed_mount_data *args,
+			    struct nfs_fs_context *ctx,
 			    struct nfs_fh *mntfh,
 			    const char *dev_name)
 {
 	if (fs_type == &nfs_fs_type)
-		return nfs23_validate_mount_data(options, args, mntfh, dev_name);
-	return nfs4_validate_mount_data(options, args, dev_name);
+		return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
+	return nfs4_validate_mount_data(options, ctx, dev_name);
 }
 #else
 int nfs_validate_mount_data(struct file_system_type *fs_type,
 			    void *options,
-			    struct nfs_parsed_mount_data *args,
+			    struct nfs_fs_context *ctx,
 			    struct nfs_fh *mntfh,
 			    const char *dev_name)
 {
-	return nfs23_validate_mount_data(options, args, mntfh, dev_name);
+	return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
 }
 #endif
 
 int nfs_validate_text_mount_data(void *options,
-				 struct nfs_parsed_mount_data *args,
+				 struct nfs_fs_context *ctx,
 				 const char *dev_name)
 {
 	int port = 0;
 	int max_namelen = PAGE_SIZE;
 	int max_pathlen = NFS_MAXPATHLEN;
-	struct sockaddr *sap = (struct sockaddr *)&args->nfs_server.address;
+	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 
-	if (nfs_parse_mount_options((char *)options, args) == 0)
+	if (nfs_parse_mount_options((char *)options, ctx) == 0)
 		return -EINVAL;
 
 	if (!nfs_verify_server_address(sap))
 		goto out_no_address;
 
-	if (args->version == 4) {
+	if (ctx->version == 4) {
 #if IS_ENABLED(CONFIG_NFS_V4)
-		if (args->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
+		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
 			port = NFS_RDMA_PORT;
 		else
 			port = NFS_PORT;
 		max_namelen = NFS4_MAXNAMLEN;
 		max_pathlen = NFS4_MAXPATHLEN;
-		nfs_validate_transport_protocol(args);
-		if (args->nfs_server.protocol == XPRT_TRANSPORT_UDP)
+		nfs_validate_transport_protocol(ctx);
+		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
 			goto out_invalid_transport_udp;
-		nfs4_validate_mount_flags(args);
+		nfs4_validate_mount_flags(ctx);
 #else
 		goto out_v4_not_compiled;
 #endif /* CONFIG_NFS_V4 */
 	} else {
-		nfs_set_mount_transport_protocol(args);
-		if (args->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
+		nfs_set_mount_transport_protocol(ctx);
+		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
 			port = NFS_RDMA_PORT;
 	}
  
-	nfs_set_port(sap, &args->nfs_server.port, port);
+	nfs_set_port(sap, &ctx->nfs_server.port, port);
 
 	return nfs_parse_devname(dev_name,
-				   &args->nfs_server.hostname,
+				   &ctx->nfs_server.hostname,
 				   max_namelen,
-				   &args->nfs_server.export_path,
+				   &ctx->nfs_server.export_path,
 				   max_pathlen);
 
 #if !IS_ENABLED(CONFIG_NFS_V4)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index edc83c901a19..8bb6ee61d99c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -89,7 +89,7 @@ struct nfs_client_initdata {
 /*
  * In-kernel mount arguments
  */
-struct nfs_parsed_mount_data {
+struct nfs_fs_context {
 	int			flags;
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
@@ -145,7 +145,7 @@ struct nfs_mount_request {
 
 struct nfs_mount_info {
 	unsigned int inherited_bsize;
-	struct nfs_parsed_mount_data *parsed;
+	struct nfs_fs_context *ctx;
 	struct nfs_clone_mount *cloned;
 	struct nfs_server *server;
 	struct nfs_fh *mntfh;
@@ -236,16 +236,16 @@ struct nfs_pageio_descriptor;
 /* mount.c */
 #define NFS_TEXT_DATA		1
 
-extern struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void);
-extern void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data);
-extern int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt);
+extern struct nfs_fs_context *nfs_alloc_parsed_mount_data(void);
+extern void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx);
+extern int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx);
 extern int nfs_validate_mount_data(struct file_system_type *fs_type,
 				   void *options,
-				   struct nfs_parsed_mount_data *args,
+				   struct nfs_fs_context *ctx,
 				   struct nfs_fh *mntfh,
 				   const char *dev_name);
 extern int nfs_validate_text_mount_data(void *options,
-					struct nfs_parsed_mount_data *args,
+					struct nfs_fs_context *ctx,
 					const char *dev_name);
 
 /* pagelist.c */
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d8151d2da0ef..e05f754d1eb1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1043,60 +1043,60 @@ static int nfs4_server_common_setup(struct nfs_server *server,
  * Create a version 4 volume record
  */
 static int nfs4_init_server(struct nfs_server *server,
-		struct nfs_parsed_mount_data *data)
+			    struct nfs_fs_context *ctx)
 {
 	struct rpc_timeout timeparms;
 	int error;
 
-	nfs_init_timeout_values(&timeparms, data->nfs_server.protocol,
-			data->timeo, data->retrans);
+	nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
+				ctx->timeo, ctx->retrans);
 
 	/* Initialise the client representation from the mount data */
-	server->flags = data->flags;
-	server->options = data->options;
-	server->auth_info = data->auth_info;
+	server->flags = ctx->flags;
+	server->options = ctx->options;
+	server->auth_info = ctx->auth_info;
 
 	/* Use the first specified auth flavor. If this flavor isn't
 	 * allowed by the server, use the SECINFO path to try the
 	 * other specified flavors */
-	if (data->auth_info.flavor_len >= 1)
-		data->selected_flavor = data->auth_info.flavors[0];
+	if (ctx->auth_info.flavor_len >= 1)
+		ctx->selected_flavor = ctx->auth_info.flavors[0];
 	else
-		data->selected_flavor = RPC_AUTH_UNIX;
+		ctx->selected_flavor = RPC_AUTH_UNIX;
 
 	/* Get a client record */
 	error = nfs4_set_client(server,
-			data->nfs_server.hostname,
-			(const struct sockaddr *)&data->nfs_server.address,
-			data->nfs_server.addrlen,
-			data->client_address,
-			data->nfs_server.protocol,
+			ctx->nfs_server.hostname,
+			(const struct sockaddr *)&ctx->nfs_server.address,
+			ctx->nfs_server.addrlen,
+			ctx->client_address,
+			ctx->nfs_server.protocol,
 			&timeparms,
-			data->minorversion,
-			data->net);
+			ctx->minorversion,
+			ctx->net);
 	if (error < 0)
 		return error;
 
-	if (data->rsize)
-		server->rsize = nfs_block_size(data->rsize, NULL);
-	if (data->wsize)
-		server->wsize = nfs_block_size(data->wsize, NULL);
+	if (ctx->rsize)
+		server->rsize = nfs_block_size(ctx->rsize, NULL);
+	if (ctx->wsize)
+		server->wsize = nfs_block_size(ctx->wsize, NULL);
 
-	server->acregmin = data->acregmin * HZ;
-	server->acregmax = data->acregmax * HZ;
-	server->acdirmin = data->acdirmin * HZ;
-	server->acdirmax = data->acdirmax * HZ;
-	server->port     = data->nfs_server.port;
+	server->acregmin = ctx->acregmin * HZ;
+	server->acregmax = ctx->acregmax * HZ;
+	server->acdirmin = ctx->acdirmin * HZ;
+	server->acdirmax = ctx->acdirmax * HZ;
+	server->port     = ctx->nfs_server.port;
 
 	return nfs_init_server_rpcclient(server, &timeparms,
-					 data->selected_flavor);
+					 ctx->selected_flavor);
 }
 
 /*
  * Create a version 4 volume record
  * - keyed on server and FSID
  */
-/*struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data *data,
+/*struct nfs_server *nfs4_create_server(const struct nfs_fs_context *data,
 				      struct nfs_fh *mntfh)*/
 struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 {
@@ -1110,10 +1110,10 @@ struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 
 	server->cred = get_cred(current_cred());
 
-	auth_probe = mount_info->parsed->auth_info.flavor_len < 1;
+	auth_probe = mount_info->ctx->auth_info.flavor_len < 1;
 
 	/* set up the general RPC client */
-	error = nfs4_init_server(server, mount_info->parsed);
+	error = nfs4_init_server(server, mount_info->ctx);
 	if (error < 0)
 		goto error;
 
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 513861b38b72..48a9f19904e0 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -197,15 +197,15 @@ static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
 struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 			      struct nfs_mount_info *mount_info)
 {
-	struct nfs_parsed_mount_data *data = mount_info->parsed;
+	struct nfs_fs_context *ctx = mount_info->ctx;
 	struct dentry *res;
 
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
 	res = do_nfs4_mount(nfs4_create_server(mount_info),
 			    flags, mount_info,
-			    data->nfs_server.hostname,
-			    data->nfs_server.export_path);
+			    ctx->nfs_server.hostname,
+			    ctx->nfs_server.export_path);
 
 	dfprintk(MOUNT, "<-- nfs4_try_mount() = %d%s\n",
 		 PTR_ERR_OR_ZERO(res),
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 00368e212a85..d7f99526ee73 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -714,12 +714,13 @@ bool nfs_auth_info_match(const struct nfs_auth_info *auth_info,
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
 
 /*
- * Ensure that a specified authtype in args->auth_info is supported by
- * the server. Returns 0 and sets args->selected_flavor if it's ok, and
+ * Ensure that a specified authtype in cfg->auth_info is supported by
+ * the server. Returns 0 and sets cfg->selected_flavor if it's ok, and
  * -EACCES if not.
  */
-static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
-			rpc_authflavor_t *server_authlist, unsigned int count)
+static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
+				  rpc_authflavor_t *server_authlist,
+				  unsigned int count)
 {
 	rpc_authflavor_t flavor = RPC_AUTH_MAXFLAVOR;
 	bool found_auth_null = false;
@@ -740,7 +741,7 @@ static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
 	for (i = 0; i < count; i++) {
 		flavor = server_authlist[i];
 
-		if (nfs_auth_info_match(&args->auth_info, flavor))
+		if (nfs_auth_info_match(&cfg->auth_info, flavor))
 			goto out;
 
 		if (flavor == RPC_AUTH_NULL)
@@ -748,7 +749,7 @@ static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
 	}
 
 	if (found_auth_null) {
-		flavor = args->auth_info.flavors[0];
+		flavor = cfg->auth_info.flavors[0];
 		goto out;
 	}
 
@@ -757,8 +758,8 @@ static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
 	return -EACCES;
 
 out:
-	args->selected_flavor = flavor;
-	dfprintk(MOUNT, "NFS: using auth flavor %u\n", args->selected_flavor);
+	cfg->selected_flavor = flavor;
+	dfprintk(MOUNT, "NFS: using auth flavor %u\n", cfg->selected_flavor);
 	return 0;
 }
 
@@ -766,50 +767,50 @@ static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_parsed_mount_data *args,
+static int nfs_request_mount(struct nfs_fs_context *cfg,
 			     struct nfs_fh *root_fh,
 			     rpc_authflavor_t *server_authlist,
 			     unsigned int *server_authlist_len)
 {
 	struct nfs_mount_request request = {
 		.sap		= (struct sockaddr *)
-						&args->mount_server.address,
-		.dirpath	= args->nfs_server.export_path,
-		.protocol	= args->mount_server.protocol,
+						&cfg->mount_server.address,
+		.dirpath	= cfg->nfs_server.export_path,
+		.protocol	= cfg->mount_server.protocol,
 		.fh		= root_fh,
-		.noresvport	= args->flags & NFS_MOUNT_NORESVPORT,
+		.noresvport	= cfg->flags & NFS_MOUNT_NORESVPORT,
 		.auth_flav_len	= server_authlist_len,
 		.auth_flavs	= server_authlist,
-		.net		= args->net,
+		.net		= cfg->net,
 	};
 	int status;
 
-	if (args->mount_server.version == 0) {
-		switch (args->version) {
+	if (cfg->mount_server.version == 0) {
+		switch (cfg->version) {
 			default:
-				args->mount_server.version = NFS_MNT3_VERSION;
+				cfg->mount_server.version = NFS_MNT3_VERSION;
 				break;
 			case 2:
-				args->mount_server.version = NFS_MNT_VERSION;
+				cfg->mount_server.version = NFS_MNT_VERSION;
 		}
 	}
-	request.version = args->mount_server.version;
+	request.version = cfg->mount_server.version;
 
-	if (args->mount_server.hostname)
-		request.hostname = args->mount_server.hostname;
+	if (cfg->mount_server.hostname)
+		request.hostname = cfg->mount_server.hostname;
 	else
-		request.hostname = args->nfs_server.hostname;
+		request.hostname = cfg->nfs_server.hostname;
 
 	/*
 	 * Construct the mount server's address.
 	 */
-	if (args->mount_server.address.ss_family == AF_UNSPEC) {
-		memcpy(request.sap, &args->nfs_server.address,
-		       args->nfs_server.addrlen);
-		args->mount_server.addrlen = args->nfs_server.addrlen;
+	if (cfg->mount_server.address.ss_family == AF_UNSPEC) {
+		memcpy(request.sap, &cfg->nfs_server.address,
+		       cfg->nfs_server.addrlen);
+		cfg->mount_server.addrlen = cfg->nfs_server.addrlen;
 	}
-	request.salen = args->mount_server.addrlen;
-	nfs_set_port(request.sap, &args->mount_server.port, 0);
+	request.salen = cfg->mount_server.addrlen;
+	nfs_set_port(request.sap, &cfg->mount_server.port, 0);
 
 	/*
 	 * Now ask the mount server to map our export path
@@ -832,12 +833,12 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	bool tried_auth_unix = false;
 	bool auth_null_in_list = false;
 	struct nfs_server *server = ERR_PTR(-EACCES);
-	struct nfs_parsed_mount_data *args = mount_info->parsed;
+	struct nfs_fs_context *ctx = mount_info->ctx;
 	rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 	unsigned int authlist_len = ARRAY_SIZE(authlist);
 	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 
-	status = nfs_request_mount(args, mount_info->mntfh, authlist,
+	status = nfs_request_mount(ctx, mount_info->mntfh, authlist,
 					&authlist_len);
 	if (status)
 		return ERR_PTR(status);
@@ -846,10 +847,10 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	 * Was a sec= authflavor specified in the options? First, verify
 	 * whether the server supports it, and then just try to use it if so.
 	 */
-	if (args->auth_info.flavor_len > 0) {
-		status = nfs_verify_authflavors(args, authlist, authlist_len);
+	if (ctx->auth_info.flavor_len > 0) {
+		status = nfs_verify_authflavors(ctx, authlist, authlist_len);
 		dfprintk(MOUNT, "NFS: using auth flavor %u\n",
-			 args->selected_flavor);
+			 ctx->selected_flavor);
 		if (status)
 			return ERR_PTR(status);
 		return nfs_mod->rpc_ops->create_server(mount_info);
@@ -878,7 +879,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 			/* Fallthrough */
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
-		args->selected_flavor = flavor;
+		ctx->selected_flavor = flavor;
 		server = nfs_mod->rpc_ops->create_server(mount_info);
 		if (!IS_ERR(server))
 			return server;
@@ -894,7 +895,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 
 	/* Last chance! Try AUTH_UNIX */
 	dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNIX);
-	args->selected_flavor = RPC_AUTH_UNIX;
+	ctx->selected_flavor = RPC_AUTH_UNIX;
 	return nfs_mod->rpc_ops->create_server(mount_info);
 }
 
@@ -904,7 +905,7 @@ struct dentry *nfs_try_mount(int flags, const char *dev_name,
 			     struct nfs_mount_info *mount_info)
 {
 	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
-	if (mount_info->parsed->need_mount)
+	if (mount_info->ctx->need_mount)
 		mount_info->server = nfs_try_mount_request(mount_info);
 	else
 		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info);
@@ -928,23 +929,23 @@ EXPORT_SYMBOL_GPL(nfs_try_mount);
 
 static int
 nfs_compare_remount_data(struct nfs_server *nfss,
-			 struct nfs_parsed_mount_data *data)
+			 struct nfs_fs_context *ctx)
 {
-	if ((data->flags ^ nfss->flags) & NFS_REMOUNT_CMP_FLAGMASK ||
-	    data->rsize != nfss->rsize ||
-	    data->wsize != nfss->wsize ||
-	    data->version != nfss->nfs_client->rpc_ops->version ||
-	    data->minorversion != nfss->nfs_client->cl_minorversion ||
-	    data->retrans != nfss->client->cl_timeout->to_retries ||
-	    !nfs_auth_info_match(&data->auth_info, nfss->client->cl_auth->au_flavor) ||
-	    data->acregmin != nfss->acregmin / HZ ||
-	    data->acregmax != nfss->acregmax / HZ ||
-	    data->acdirmin != nfss->acdirmin / HZ ||
-	    data->acdirmax != nfss->acdirmax / HZ ||
-	    data->timeo != (10U * nfss->client->cl_timeout->to_initval / HZ) ||
-	    data->nfs_server.port != nfss->port ||
-	    data->nfs_server.addrlen != nfss->nfs_client->cl_addrlen ||
-	    !rpc_cmp_addr((struct sockaddr *)&data->nfs_server.address,
+	if ((ctx->flags ^ nfss->flags) & NFS_REMOUNT_CMP_FLAGMASK ||
+	    ctx->rsize != nfss->rsize ||
+	    ctx->wsize != nfss->wsize ||
+	    ctx->version != nfss->nfs_client->rpc_ops->version ||
+	    ctx->minorversion != nfss->nfs_client->cl_minorversion ||
+	    ctx->retrans != nfss->client->cl_timeout->to_retries ||
+	    !nfs_auth_info_match(&ctx->auth_info, nfss->client->cl_auth->au_flavor) ||
+	    ctx->acregmin != nfss->acregmin / HZ ||
+	    ctx->acregmax != nfss->acregmax / HZ ||
+	    ctx->acdirmin != nfss->acdirmin / HZ ||
+	    ctx->acdirmax != nfss->acdirmax / HZ ||
+	    ctx->timeo != (10U * nfss->client->cl_timeout->to_initval / HZ) ||
+	    ctx->nfs_server.port != nfss->port ||
+	    ctx->nfs_server.addrlen != nfss->nfs_client->cl_addrlen ||
+	    !rpc_cmp_addr((struct sockaddr *)&ctx->nfs_server.address,
 			  (struct sockaddr *)&nfss->nfs_client->cl_addr))
 		return -EINVAL;
 
@@ -956,7 +957,7 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 {
 	int error;
 	struct nfs_server *nfss = sb->s_fs_info;
-	struct nfs_parsed_mount_data *data;
+	struct nfs_fs_context *ctx;
 	struct nfs_mount_data *options = (struct nfs_mount_data *)raw_data;
 	struct nfs4_mount_data *options4 = (struct nfs4_mount_data *)raw_data;
 	u32 nfsvers = nfss->nfs_client->rpc_ops->version;
@@ -974,32 +975,32 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 					   options->version <= 6))))
 		return 0;
 
-	data = nfs_alloc_parsed_mount_data();
-	if (data == NULL)
+	ctx = nfs_alloc_parsed_mount_data();
+	if (ctx == NULL)
 		return -ENOMEM;
 
 	/* fill out struct with values from existing mount */
-	data->flags = nfss->flags;
-	data->rsize = nfss->rsize;
-	data->wsize = nfss->wsize;
-	data->retrans = nfss->client->cl_timeout->to_retries;
-	data->selected_flavor = nfss->client->cl_auth->au_flavor;
-	data->acregmin = nfss->acregmin / HZ;
-	data->acregmax = nfss->acregmax / HZ;
-	data->acdirmin = nfss->acdirmin / HZ;
-	data->acdirmax = nfss->acdirmax / HZ;
-	data->timeo = 10U * nfss->client->cl_timeout->to_initval / HZ;
-	data->nfs_server.port = nfss->port;
-	data->nfs_server.addrlen = nfss->nfs_client->cl_addrlen;
-	data->version = nfsvers;
-	data->minorversion = nfss->nfs_client->cl_minorversion;
-	data->net = current->nsproxy->net_ns;
-	memcpy(&data->nfs_server.address, &nfss->nfs_client->cl_addr,
-		data->nfs_server.addrlen);
+	ctx->flags = nfss->flags;
+	ctx->rsize = nfss->rsize;
+	ctx->wsize = nfss->wsize;
+	ctx->retrans = nfss->client->cl_timeout->to_retries;
+	ctx->selected_flavor = nfss->client->cl_auth->au_flavor;
+	ctx->acregmin = nfss->acregmin / HZ;
+	ctx->acregmax = nfss->acregmax / HZ;
+	ctx->acdirmin = nfss->acdirmin / HZ;
+	ctx->acdirmax = nfss->acdirmax / HZ;
+	ctx->timeo = 10U * nfss->client->cl_timeout->to_initval / HZ;
+	ctx->nfs_server.port = nfss->port;
+	ctx->nfs_server.addrlen = nfss->nfs_client->cl_addrlen;
+	ctx->version = nfsvers;
+	ctx->minorversion = nfss->nfs_client->cl_minorversion;
+	ctx->net = current->nsproxy->net_ns;
+	memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+		ctx->nfs_server.addrlen);
 
 	/* overwrite those values with any that were specified */
 	error = -EINVAL;
-	if (!nfs_parse_mount_options((char *)options, data))
+	if (!nfs_parse_mount_options((char *)options, ctx))
 		goto out;
 
 	/*
@@ -1008,15 +1009,15 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 	 * will clear SB_SYNCHRONOUS if -o sync wasn't specified in the
 	 * remount options, so we have to explicitly reset it.
 	 */
-	if (data->flags & NFS_MOUNT_NOAC)
+	if (ctx->flags & NFS_MOUNT_NOAC)
 		*flags |= SB_SYNCHRONOUS;
 
 	/* compare new mount options with old ones */
-	error = nfs_compare_remount_data(nfss, data);
+	error = nfs_compare_remount_data(nfss, ctx);
 	if (!error)
-		error = security_sb_remount(sb, data->lsm_opts);
+		error = security_sb_remount(sb, ctx->lsm_opts);
 out:
-	nfs_free_parsed_mount_data(data);
+	nfs_free_parsed_mount_data(ctx);
 	return error;
 }
 EXPORT_SYMBOL_GPL(nfs_remount);
@@ -1026,15 +1027,15 @@ EXPORT_SYMBOL_GPL(nfs_remount);
  */
 static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
 {
-	struct nfs_parsed_mount_data *data = mount_info->parsed;
+	struct nfs_fs_context *ctx = mount_info->ctx;
 	struct nfs_server *server = NFS_SB(sb);
 
 	sb->s_blocksize_bits = 0;
 	sb->s_blocksize = 0;
 	sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
 	sb->s_op = server->nfs_client->cl_nfs_mod->sops;
-	if (data && data->bsize)
-		sb->s_blocksize = nfs_block_size(data->bsize, &sb->s_blocksize_bits);
+	if (ctx && ctx->bsize)
+		sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
 
 	if (server->nfs_client->rpc_ops->version != 2) {
 		/* The VFS shouldn't apply the umask to mode bits. We will do
@@ -1186,7 +1187,7 @@ static int nfs_compare_super(struct super_block *sb, void *data)
 
 #ifdef CONFIG_NFS_FSCACHE
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_parsed_mount_data *parsed,
+				 struct nfs_fs_context *ctx,
 				 struct nfs_clone_mount *cloned)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
@@ -1196,12 +1197,12 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
 
-	if (parsed) {
-		if (!(parsed->options & NFS_OPTION_FSCACHE))
+	if (ctx) {
+		if (!(ctx->options & NFS_OPTION_FSCACHE))
 			return;
-		if (parsed->fscache_uniq) {
-			uniq = parsed->fscache_uniq;
-			ulen = strlen(parsed->fscache_uniq);
+		if (ctx->fscache_uniq) {
+			uniq = ctx->fscache_uniq;
+			ulen = strlen(ctx->fscache_uniq);
 		}
 	} else if (cloned) {
 		struct nfs_server *mnt_s = NFS_SB(cloned->sb);
@@ -1218,7 +1219,7 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 }
 #else
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_parsed_mount_data *parsed,
+				 struct nfs_fs_context *parsed,
 				 struct nfs_clone_mount *cloned)
 {
 }
@@ -1283,7 +1284,7 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 			s->s_blocksize_bits = bsize;
 			s->s_blocksize = 1U << bsize;
 		}
-		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
+		nfs_get_cache_cookie(s, mount_info->ctx, mount_info->cloned);
 		if (!(server->flags & NFS_MOUNT_UNSHARED))
 			s->s_iflags |= SB_I_MULTIROOT;
 	}
@@ -1304,7 +1305,7 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 		error = security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
 				&kflags_out);
 	} else {
-		error = security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
+		error = security_sb_set_mnt_opts(s, mount_info->ctx->lsm_opts,
 							kflags, &kflags_out);
 	}
 	if (error)
@@ -1341,21 +1342,22 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	struct nfs_subversion *nfs_mod;
 	int error;
 
-	mount_info.parsed = nfs_alloc_parsed_mount_data();
+	mount_info.ctx = nfs_alloc_parsed_mount_data();
 	mount_info.mntfh = nfs_alloc_fhandle();
-	if (mount_info.parsed == NULL || mount_info.mntfh == NULL)
+	if (mount_info.ctx == NULL || mount_info.mntfh == NULL)
 		goto out;
 
 	/* Validate the mount data */
-	error = nfs_validate_mount_data(fs_type, raw_data, mount_info.parsed, mount_info.mntfh, dev_name);
+	error = nfs_validate_mount_data(fs_type, raw_data, mount_info.ctx, mount_info.mntfh, dev_name);
 	if (error == NFS_TEXT_DATA)
-		error = nfs_validate_text_mount_data(raw_data, mount_info.parsed, dev_name);
+		error = nfs_validate_text_mount_data(raw_data, 
+						     mount_info.ctx, dev_name);
 	if (error < 0) {
 		mntroot = ERR_PTR(error);
 		goto out;
 	}
 
-	nfs_mod = get_nfs_version(mount_info.parsed->version);
+	nfs_mod = get_nfs_version(mount_info.ctx->version);
 	if (IS_ERR(nfs_mod)) {
 		mntroot = ERR_CAST(nfs_mod);
 		goto out;
@@ -1366,7 +1368,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 
 	put_nfs_version(nfs_mod);
 out:
-	nfs_free_parsed_mount_data(mount_info.parsed);
+	nfs_free_parsed_mount_data(mount_info.ctx);
 	nfs_free_fhandle(mount_info.mntfh);
 	return mntroot;
 }

