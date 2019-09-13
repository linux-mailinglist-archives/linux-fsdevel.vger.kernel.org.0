Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C310B1D31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfIMMRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:17:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfIMMRw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0263307CDFC;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AB435D9CD;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 31FBB20F42; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 25/26] NFS: Add fs_context support.
Date:   Fri, 13 Sep 2019 08:17:47 -0400
Message-Id: <20190913121748.25391-26-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 13 Sep 2019 12:17:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add filesystem context support to NFS, parsing the options in advance and
attaching the information to struct nfs_fs_context.  The highlights are:

 (*) Merge nfs_mount_info and nfs_clone_mount into nfs_fs_context.  This
     structure represents NFS's superblock config.

 (*) Make use of the VFS's parsing support to split comma-separated lists

 (*) Pin the NFS protocol module in the nfs_fs_context.

 (*) Attach supplementary error information to fs_context.  This has the
     downside that these strings must be static and can't be formatted.

 (*) Remove the auxiliary file_system_type structs since the information
     necessary can be conveyed in the nfs_fs_context struct instead.

 (*) Root mounts are made by duplicating the config for the requested mount
     so as to have the same parameters.  Submounts pick up their parameters
     from the parent superblock.

[AV -- retrans is u32, not string]
[SM -- Renamed cfg to ctx in a few functions in an earlier patch]
[SM -- Moved fs_context mount option parsing to an earlier patch]
[SM -- Moved fs_context error logging to a later patch]
[SM -- Fixed printks in nfs4_try_get_tree() and nfs4_get_referral_tree()]
[SM -- Added is_remount_fc() helper]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/client.c         |  22 +-
 fs/nfs/fs_context.c     | 579 ++++++++++++++++++++++++----------------
 fs/nfs/fscache.c        |   2 +-
 fs/nfs/getroot.c        |  70 ++---
 fs/nfs/internal.h       | 100 +++----
 fs/nfs/namespace.c      | 134 ++++++----
 fs/nfs/nfs3_fs.h        |   2 +-
 fs/nfs/nfs3client.c     |   5 +-
 fs/nfs/nfs3proc.c       |   2 +-
 fs/nfs/nfs4_fs.h        |   9 +-
 fs/nfs/nfs4client.c     |  62 ++---
 fs/nfs/nfs4namespace.c  | 285 +++++++++++---------
 fs/nfs/nfs4proc.c       |   2 +-
 fs/nfs/nfs4super.c      | 164 ++++++------
 fs/nfs/proc.c           |   2 +-
 fs/nfs/super.c          | 312 ++++++----------------
 include/linux/nfs_xdr.h |   8 +-
 17 files changed, 898 insertions(+), 862 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 511d1d629786..a26e7d1d74bc 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -648,17 +648,17 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-			   const struct nfs_fs_context *ctx,
-			   struct nfs_subversion *nfs_mod)
+			   const struct fs_context *fc)
 {
+	const struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct rpc_timeout timeparms;
 	struct nfs_client_initdata cl_init = {
 		.hostname = ctx->nfs_server.hostname,
 		.addr = (const struct sockaddr *)&ctx->nfs_server.address,
 		.addrlen = ctx->nfs_server.addrlen,
-		.nfs_mod = nfs_mod,
+		.nfs_mod = ctx->nfs_mod,
 		.proto = ctx->nfs_server.protocol,
-		.net = ctx->net,
+		.net = fc->net_ns,
 		.timeparms = &timeparms,
 		.cred = server->cred,
 		.nconnect = ctx->nfs_server.nconnect,
@@ -940,10 +940,10 @@ EXPORT_SYMBOL_GPL(nfs_free_server);
  * Create a version 2 or 3 volume record
  * - keyed on server and FSID
  */
-struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs_create_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_server *server;
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	struct nfs_fattr *fattr;
 	int error;
 
@@ -959,18 +959,18 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 		goto error;
 
 	/* Get a client representation */
-	error = nfs_init_server(server, mount_info->ctx, nfs_mod);
+	error = nfs_init_server(server, fc);
 	if (error < 0)
 		goto error;
 
 	/* Probe the root fh to retrieve its FSID */
-	error = nfs_probe_fsinfo(server, mount_info->mntfh, fattr);
+	error = nfs_probe_fsinfo(server, ctx->mntfh, fattr);
 	if (error < 0)
 		goto error;
 	if (server->nfs_client->rpc_ops->version == 3) {
 		if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
 			server->namelen = NFS3_MAXNAMLEN;
-		if (!(mount_info->ctx->flags & NFS_MOUNT_NORDIRPLUS))
+		if (!(ctx->flags & NFS_MOUNT_NORDIRPLUS))
 			server->caps |= NFS_CAP_READDIRPLUS;
 	} else {
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
@@ -978,8 +978,8 @@ struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 	}
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
-		error = nfs_mod->rpc_ops->getattr(server, mount_info->mntfh,
-				fattr, NULL, NULL);
+		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
+						       fattr, NULL, NULL);
 		if (error < 0) {
 			dprintk("nfs_create_server: getattr error = %d\n", -error);
 			goto error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9a3162055d5d..0bf346cdea18 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -3,6 +3,7 @@
  * linux/fs/nfs/fs_context.c
  *
  * Copyright (C) 1992 Rick Sladkey
+ * Conversion to new mount api Copyright (C) David Howells
  *
  * NFS mount handling.
  *
@@ -240,43 +241,6 @@ static const struct constant_table nfs_secflavor_tokens[] = {
 	{ "sys",	Opt_sec_sys },
 };
 
-struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
-{
-	struct nfs_fs_context *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (ctx) {
-		ctx->timeo		= NFS_UNSPEC_TIMEO;
-		ctx->retrans		= NFS_UNSPEC_RETRANS;
-		ctx->acregmin		= NFS_DEF_ACREGMIN;
-		ctx->acregmax		= NFS_DEF_ACREGMAX;
-		ctx->acdirmin		= NFS_DEF_ACDIRMIN;
-		ctx->acdirmax		= NFS_DEF_ACDIRMAX;
-		ctx->mount_server.port	= NFS_UNSPEC_PORT;
-		ctx->nfs_server.port	= NFS_UNSPEC_PORT;
-		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
-		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
-		ctx->minorversion	= 0;
-		ctx->need_mount	= true;
-		ctx->net		= current->nsproxy->net_ns;
-		ctx->lsm_opts = NULL;
-	}
-	return ctx;
-}
-
-void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx)
-{
-	if (ctx) {
-		kfree(ctx->client_address);
-		kfree(ctx->mount_server.hostname);
-		kfree(ctx->nfs_server.export_path);
-		kfree(ctx->nfs_server.hostname);
-		kfree(ctx->fscache_uniq);
-		security_free_mnt_opts(&ctx->lsm_opts);
-		kfree(ctx);
-	}
-}
-
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -341,7 +305,7 @@ static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
  * Add 'flavor' to 'auth_info' if not already present.
  * Returns true if 'flavor' ends up in the list, false otherwise
  */
-static int nfs_auth_info_add(struct nfs_fs_context *ctx,
+static int nfs_auth_info_add(struct fs_context *fc,
 			     struct nfs_auth_info *auth_info,
 			     rpc_authflavor_t flavor)
 {
@@ -366,9 +330,10 @@ static int nfs_auth_info_add(struct nfs_fs_context *ctx,
 /*
  * Parse the value of the 'sec=' option.
  */
-static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
+static int nfs_parse_security_flavors(struct fs_context *fc,
 				      struct fs_parameter *param)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	rpc_authflavor_t pseudoflavor;
 	char *string = param->string, *p;
 	int ret;
@@ -418,7 +383,7 @@ static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
 			return -EINVAL;
 		}
 
-		ret = nfs_auth_info_add(ctx, &ctx->auth_info, pseudoflavor);
+		ret = nfs_auth_info_add(fc, &ctx->auth_info, pseudoflavor);
 		if (ret < 0)
 			return ret;
 	}
@@ -426,9 +391,11 @@ static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
 	return 0;
 }
 
-static int nfs_parse_version_string(struct nfs_fs_context *ctx,
+static int nfs_parse_version_string(struct fs_context *fc,
 				    const char *string)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
 	ctx->flags &= ~NFS_MOUNT_VER3;
 	switch (lookup_constant(nfs_vers_tokens, string, -1)) {
 	case Opt_vers_2:
@@ -467,21 +434,31 @@ static int nfs_parse_version_string(struct nfs_fs_context *ctx,
 /*
  * Parse a single mount parameter.
  */
-static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
+static int nfs_fs_context_parse_param(struct fs_context *fc,
 				      struct fs_parameter *param)
 {
 	struct fs_parse_result result;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	unsigned short protofamily, mountfamily;
 	unsigned int len;
 	int ret, opt;
 
 	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
 
-	opt = fs_parse(NULL, &nfs_fs_parameters, param, &result);
+	opt = fs_parse(fc, &nfs_fs_parameters, param, &result);
 	if (opt < 0)
 		return ctx->sloppy ? 1 : opt;
 
 	switch (opt) {
+	case Opt_source:
+		if (fc->source) {
+			dfprintk(MOUNT, "NFS: Multiple sources not supported\n");
+			return -EINVAL;
+		}
+		fc->source = param->string;
+		param->string = NULL;
+		break;
+
 		/*
 		 * boolean options:  foo/nofoo
 		 */
@@ -645,17 +622,17 @@ static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
 		 * options that take text values
 		 */
 	case Opt_v:
-		ret = nfs_parse_version_string(ctx, param->key + 1);
+		ret = nfs_parse_version_string(fc, param->key + 1);
 		if (ret < 0)
 			return ret;
 		break;
 	case Opt_vers:
-		ret = nfs_parse_version_string(ctx, param->string);
+		ret = nfs_parse_version_string(fc, param->string);
 		if (ret < 0)
 			return ret;
 		break;
 	case Opt_sec:
-		ret = nfs_parse_security_flavors(ctx, param);
+		ret = nfs_parse_security_flavors(fc, param);
 		if (ret < 0)
 			return ret;
 		break;
@@ -718,7 +695,7 @@ static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
 		break;
 
 	case Opt_addr:
-		len = rpc_pton(ctx->net, param->string, param->size,
+		len = rpc_pton(fc->net_ns, param->string, param->size,
 			       &ctx->nfs_server.address,
 			       sizeof(ctx->nfs_server._address));
 		if (len == 0)
@@ -736,7 +713,7 @@ static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
 		param->string = NULL;
 		break;
 	case Opt_mountaddr:
-		len = rpc_pton(ctx->net, param->string, param->size,
+		len = rpc_pton(fc->net_ns, param->string, param->size,
 			       &ctx->mount_server.address,
 			       sizeof(ctx->mount_server._address));
 		if (len == 0)
@@ -807,114 +784,8 @@ static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
 	return -ERANGE;
 }
 
-/* cribbed from generic_parse_monolithic and vfs_parse_fs_string */
-static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
-{
-	int ret;
-	char *key = p, *value;
-	size_t v_size = 0;
-	struct fs_parameter param;
-
-	memset(&param, 0, sizeof(param));
-	value = strchr(key, '=');
-	if (value && value != key) {
-		*value++ = 0;
-		v_size = strlen(value);
-	}
-	param.key = key;
-	param.type = fs_value_is_flag;
-	param.size = v_size;
-	if (v_size > 0) {
-		param.type = fs_value_is_string;
-		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
-		if (!param.string)
-			return -ENOMEM;
-	}
-	ret = nfs_fs_context_parse_param(ctx, &param);
-	kfree(param.string);
-	return ret;
-}
-
 /*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
- */
-int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
-{
-	char *p;
-	int rc, sloppy = 0, invalid_option = 0;
-
-	if (!raw) {
-		dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
-		return 1;
-	}
-	dfprintk(MOUNT, "NFS: nfs mount opts='%s'\n", raw);
-
-	rc = security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
-	if (rc)
-		goto out_security_failure;
-
-	while ((p = strsep(&raw, ",")) != NULL) {
-		if (!*p)
-			continue;
-		if (nfs_fs_context_parse_option(ctx, p) < 0)
-			invalid_option = true;
-	}
-
-	if (!sloppy && invalid_option)
-		return 0;
-
-	if (ctx->minorversion && ctx->version != 4)
-		goto out_minorversion_mismatch;
-
-	if (ctx->options & NFS_OPTION_MIGRATION &&
-	    (ctx->version != 4 || ctx->minorversion != 0))
-		goto out_migration_misuse;
-
-	/*
-	 * verify that any proto=/mountproto= options match the address
-	 * families in the addr=/mountaddr= options.
-	 */
-	if (ctx->protofamily != AF_UNSPEC &&
-	    ctx->protofamily != ctx->nfs_server.address.sa_family)
-		goto out_proto_mismatch;
-
-	if (ctx->mountfamily != AF_UNSPEC) {
-		if (ctx->mount_server.addrlen) {
-			if (ctx->mountfamily != ctx->mount_server.address.sa_family)
-				goto out_mountproto_mismatch;
-		} else {
-			if (ctx->mountfamily != ctx->nfs_server.address.sa_family)
-				goto out_mountproto_mismatch;
-		}
-	}
-
-	return 1;
-
-out_minorversion_mismatch:
-	printk(KERN_INFO "NFS: mount option vers=%u does not support "
-			 "minorversion=%u\n", ctx->version, ctx->minorversion);
-	return 0;
-out_mountproto_mismatch:
-	printk(KERN_INFO "NFS: mount server address does not match mountproto= "
-			 "option\n");
-	return 0;
-out_proto_mismatch:
-	printk(KERN_INFO "NFS: server address does not match proto= option\n");
-	return 0;
-out_migration_misuse:
-	printk(KERN_INFO
-		"NFS: 'migration' not supported for this NFS version\n");
-	return -EINVAL;
-out_security_failure:
-	printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
-	return 0;
-}
-
-/*
- * Split "dev_name" into "hostname:export_path".
+ * Split fc->source into "hostname:export_path".
  *
  * The leftmost colon demarks the split between the server's hostname
  * and the export path.  If the hostname starts with a left square
@@ -922,12 +793,13 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
  *
  * Note: caller frees hostname and export path, even on error.
  */
-static int nfs_parse_devname(struct nfs_fs_context *ctx,
-			     const char *dev_name,
-			     size_t maxnamlen, size_t maxpathlen)
+static int nfs_parse_source(struct fs_context *fc,
+			    size_t maxnamlen, size_t maxpathlen)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	const char *dev_name = fc->source;
 	size_t len;
-	char *end;
+	const char *end;
 
 	if (unlikely(!dev_name || !*dev_name)) {
 		dfprintk(MOUNT, "NFS: device name not specified\n");
@@ -943,7 +815,7 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 		len = end - dev_name;
 		end++;
 	} else {
-		char *comma;
+		const char *comma;
 
 		end = strchr(dev_name, ':');
 		if (end == NULL)
@@ -951,8 +823,8 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 		len = end - dev_name;
 
 		/* kill possible hostname list: not supported */
-		comma = strchr(dev_name, ',');
-		if (comma != NULL && comma < end)
+		comma = memchr(dev_name, ',', len);
+		if (comma)
 			len = comma - dev_name;
 	}
 
@@ -990,6 +862,11 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
 	return -ENAMETOOLONG;
 }
 
+static inline bool is_remount_fc(struct fs_context *fc)
+{
+	return fc->root != NULL;
+}
+
 /*
  * Parse monolithic NFS2/NFS3 mount data
  * - fills in the mount root filehandle
@@ -1006,12 +883,11 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx,
  * + breaking back: trying proto=udp after proto=tcp, v2 after v3,
  *   mountproto=tcp after mountproto=udp, and so on
  */
-static int nfs23_validate_mount_data(void *options,
-				     struct nfs_fs_context *ctx,
-				     struct nfs_fh *mntfh,
-				     const char *dev_name)
+static int nfs23_parse_monolithic(struct fs_context *fc,
+				  struct nfs_mount_data *data)
 {
-	struct nfs_mount_data *data = (struct nfs_mount_data *)options;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_fh *mntfh = ctx->mntfh;
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
 
@@ -1083,6 +959,9 @@ static int nfs23_validate_mount_data(void *options,
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 		/* N.B. caller will free nfs_server.hostname in all cases */
 		ctx->nfs_server.hostname = kstrdup(data->hostname, GFP_KERNEL);
+		if (!ctx->nfs_server.hostname)
+			goto out_nomem;
+
 		ctx->namlen		= data->namlen;
 		ctx->bsize		= data->bsize;
 
@@ -1090,8 +969,6 @@ static int nfs23_validate_mount_data(void *options,
 			ctx->selected_flavor = data->pseudoflavor;
 		else
 			ctx->selected_flavor = RPC_AUTH_UNIX;
-		if (!ctx->nfs_server.hostname)
-			goto out_nomem;
 
 		if (!(data->flags & NFS_MOUNT_NONLM))
 			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK|
@@ -1099,6 +976,7 @@ static int nfs23_validate_mount_data(void *options,
 		else
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK|
 					NFS_MOUNT_LOCAL_FCNTL);
+
 		/*
 		 * The legacy version 6 binary mount data from userspace has a
 		 * field used only to transport selinux information into the
@@ -1109,12 +987,13 @@ static int nfs23_validate_mount_data(void *options,
 		 */
 		if (data->context[0]){
 #ifdef CONFIG_SECURITY_SELINUX
-			int rc;
+			int ret;
+
 			data->context[NFS_MAX_CONTEXT_LEN] = '\0';
-			rc = security_add_mnt_opt("context", data->context,
-					strlen(data->context), ctx->lsm_opts);
-			if (rc)
-				return rc;
+			ret = vfs_parse_fs_string(fc, "context",
+						  data->context, strlen(data->context));
+			if (ret < 0)
+				return ret;
 #else
 			return -EINVAL;
 #endif
@@ -1122,12 +1001,20 @@ static int nfs23_validate_mount_data(void *options,
 
 		break;
 	default:
-		return NFS_TEXT_DATA;
+		goto generic;
 	}
 
+	ctx->skip_reconfig_option_check = true;
 	return 0;
 
+generic:
+	return generic_parse_monolithic(fc, data);
+
 out_no_data:
+	if (is_remount_fc(fc)) {
+		ctx->skip_reconfig_option_check = true;
+		return 0;
+	}
 	dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
 	return -EINVAL;
 
@@ -1154,21 +1041,14 @@ static int nfs23_validate_mount_data(void *options,
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-static void nfs4_validate_mount_flags(struct nfs_fs_context *ctx)
-{
-	ctx->flags &= ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
-			 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
-}
-
 /*
  * Validate NFSv4 mount options
  */
-static int nfs4_validate_mount_data(void *options,
-				    struct nfs_fs_context *ctx,
-				    const char *dev_name)
+static int nfs4_parse_monolithic(struct fs_context *fc,
+				 struct nfs4_mount_data *data)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
-	struct nfs4_mount_data *data = (struct nfs4_mount_data *)options;
 	char *c;
 
 	if (data == NULL)
@@ -1218,7 +1098,7 @@ static int nfs4_validate_mount_data(void *options,
 		ctx->client_address = c;
 
 		/*
-		 * Translate to nfs_fs_context, which nfs4_fill_super
+		 * Translate to nfs_fs_context, which nfs_fill_super
 		 * can deal with.
 		 */
 
@@ -1238,12 +1118,20 @@ static int nfs4_validate_mount_data(void *options,
 
 		break;
 	default:
-		return NFS_TEXT_DATA;
+		goto generic;
 	}
 
+	ctx->skip_reconfig_option_check = true;
 	return 0;
 
+generic:
+	return generic_parse_monolithic(fc, data);
+
 out_no_data:
+	if (is_remount_fc(fc)) {
+		ctx->skip_reconfig_option_check = true;
+		return 0;
+	}
 	dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
 	return -EINVAL;
 
@@ -1260,58 +1148,87 @@ static int nfs4_validate_mount_data(void *options,
 	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 	return -EINVAL;
 }
+#endif
 
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-			    void *options,
-			    struct nfs_fs_context *ctx,
-			    struct nfs_fh *mntfh,
-			    const char *dev_name)
-{
-	if (fs_type == &nfs_fs_type)
-		return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-	return nfs4_validate_mount_data(options, ctx, dev_name);
-}
-#else
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-			    void *options,
-			    struct nfs_fs_context *ctx,
-			    struct nfs_fh *mntfh,
-			    const char *dev_name)
+/*
+ * Parse a monolithic block of data from sys_mount().
+ */
+static int nfs_fs_context_parse_monolithic(struct fs_context *fc,
+					   void *data)
 {
-	return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-}
+	if (fc->fs_type == &nfs_fs_type)
+		return nfs23_parse_monolithic(fc, data);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+	if (fc->fs_type == &nfs4_fs_type)
+		return nfs4_parse_monolithic(fc, data);
 #endif
 
-int nfs_validate_text_mount_data(void *options,
-				 struct nfs_fs_context *ctx,
-				 const char *dev_name)
+	dfprintk(MOUNT, "NFS: Unsupported monolithic data version\n");
+	return -EINVAL;
+}
+
+/*
+ * Validate the preparsed information in the config.
+ */
+static int nfs_fs_context_validate(struct fs_context *fc)
 {
-	int port = 0;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_subversion *nfs_mod;
+	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
 	int max_namelen = PAGE_SIZE;
 	int max_pathlen = NFS_MAXPATHLEN;
-	struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
+	int port = 0;
+	int ret;
 
-	if (nfs_parse_mount_options((char *)options, ctx) == 0)
-		return -EINVAL;
+	if (!fc->source)
+		goto out_no_device_name;
+
+	/* Check for sanity first. */
+	if (ctx->minorversion && ctx->version != 4)
+		goto out_minorversion_mismatch;
+
+	if (ctx->options & NFS_OPTION_MIGRATION &&
+	    (ctx->version != 4 || ctx->minorversion != 0))
+		goto out_migration_misuse;
+
+	/* Verify that any proto=/mountproto= options match the address
+	 * families in the addr=/mountaddr= options.
+	 */
+	if (ctx->protofamily != AF_UNSPEC &&
+	    ctx->protofamily != ctx->nfs_server.address.sa_family)
+		goto out_proto_mismatch;
+
+	if (ctx->mountfamily != AF_UNSPEC) {
+		if (ctx->mount_server.addrlen) {
+			if (ctx->mountfamily != ctx->mount_server.address.sa_family)
+				goto out_mountproto_mismatch;
+		} else {
+			if (ctx->mountfamily != ctx->nfs_server.address.sa_family)
+				goto out_mountproto_mismatch;
+		}
+	}
 
 	if (!nfs_verify_server_address(sap))
 		goto out_no_address;
 
 	if (ctx->version == 4) {
-#if IS_ENABLED(CONFIG_NFS_V4)
-		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
-			port = NFS_RDMA_PORT;
-		else
-			port = NFS_PORT;
-		max_namelen = NFS4_MAXNAMLEN;
-		max_pathlen = NFS4_MAXPATHLEN;
-		nfs_validate_transport_protocol(ctx);
-		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
-			goto out_invalid_transport_udp;
-		nfs4_validate_mount_flags(ctx);
-#else
-		goto out_v4_not_compiled;
-#endif /* CONFIG_NFS_V4 */
+		if (IS_ENABLED(CONFIG_NFS_V4)) {
+			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
+				port = NFS_RDMA_PORT;
+			else
+				port = NFS_PORT;
+			max_namelen = NFS4_MAXNAMLEN;
+			max_pathlen = NFS4_MAXPATHLEN;
+			nfs_validate_transport_protocol(ctx);
+			if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
+				goto out_invalid_transport_udp;
+			ctx->flags &= ~(NFS_MOUNT_NONLM | NFS_MOUNT_NOACL |
+					NFS_MOUNT_VER3 | NFS_MOUNT_LOCAL_FLOCK |
+					NFS_MOUNT_LOCAL_FCNTL);
+		} else {
+			goto out_v4_not_compiled;
+		}
 	} else {
 		nfs_set_mount_transport_protocol(ctx);
 		if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
@@ -1320,19 +1237,219 @@ int nfs_validate_text_mount_data(void *options,
 
 	nfs_set_port(sap, &ctx->nfs_server.port, port);
 
-	return nfs_parse_devname(ctx, dev_name, max_namelen, max_pathlen);
+	ret = nfs_parse_source(fc, max_namelen, max_pathlen);
+	if (ret < 0)
+		return ret;
+
+	/* Load the NFS protocol module if we haven't done so yet */
+	if (!ctx->nfs_mod) {
+		nfs_mod = get_nfs_version(ctx->version);
+		if (IS_ERR(nfs_mod)) {
+			ret = PTR_ERR(nfs_mod);
+			goto out_version_unavailable;
+		}
+		ctx->nfs_mod = nfs_mod;
+	}
+	return 0;
 
-#if !IS_ENABLED(CONFIG_NFS_V4)
+out_no_device_name:
+	dfprintk(MOUNT, "NFS: Device name not specified\n");
+	return -EINVAL;
 out_v4_not_compiled:
 	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
 	return -EPROTONOSUPPORT;
-#else
 out_invalid_transport_udp:
 	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 	return -EINVAL;
-#endif /* !CONFIG_NFS_V4 */
-
 out_no_address:
 	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
 	return -EINVAL;
+out_mountproto_mismatch:
+	dfprintk(MOUNT, "NFS: Mount server address does not match mountproto= option\n");
+	return -EINVAL;
+out_proto_mismatch:
+	dfprintk(MOUNT, "NFS: Server address does not match proto= option\n");
+	return -EINVAL;
+out_minorversion_mismatch:
+	dfprintk(MOUNT, "NFS: Mount option vers=%u does not support minorversion=%u\n",
+			  ctx->version, ctx->minorversion);
+	return -EINVAL;
+out_migration_misuse:
+	dfprintk(MOUNT, "NFS: 'Migration' not supported for this NFS version\n");
+	return -EINVAL;
+out_version_unavailable:
+	dfprintk(MOUNT, "NFS: Version unavailable\n");
+	return ret;
+}
+
+/*
+ * Create an NFS superblock by the appropriate method.
+ */
+static int nfs_get_tree(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err = nfs_fs_context_validate(fc);
+
+	if (err)
+		return err;
+	if (!ctx->internal)
+		return ctx->nfs_mod->rpc_ops->try_get_tree(fc);
+	else
+		return nfs_get_tree_common(fc);
+}
+
+/*
+ * Handle duplication of a configuration.  The caller copied *src into *sc, but
+ * it can't deal with resource pointers in the filesystem context, so we have
+ * to do that.  We need to clear pointers, copy data or get extra refs as
+ * appropriate.
+ */
+static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct nfs_fs_context *src = nfs_fc2context(src_fc), *ctx;
+
+	ctx = kmemdup(src, sizeof(struct nfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->mntfh = nfs_alloc_fhandle();
+	if (!ctx->mntfh) {
+		kfree(ctx);
+		return -ENOMEM;
+	}
+	nfs_copy_fh(ctx->mntfh, src->mntfh);
+
+	__module_get(ctx->nfs_mod->owner);
+	ctx->client_address		= NULL;
+	ctx->mount_server.hostname	= NULL;
+	ctx->nfs_server.export_path	= NULL;
+	ctx->nfs_server.hostname	= NULL;
+	ctx->fscache_uniq		= NULL;
+	fc->fs_private = ctx;
+	return 0;
+}
+
+static void nfs_fs_context_free(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	if (ctx) {
+		if (ctx->server)
+			nfs_free_server(ctx->server);
+		if (ctx->nfs_mod)
+			put_nfs_version(ctx->nfs_mod);
+		kfree(ctx->client_address);
+		kfree(ctx->mount_server.hostname);
+		kfree(ctx->nfs_server.export_path);
+		kfree(ctx->nfs_server.hostname);
+		kfree(ctx->fscache_uniq);
+		nfs_free_fhandle(ctx->mntfh);
+		kfree(ctx);
+	}
+}
+
+static const struct fs_context_operations nfs_fs_context_ops = {
+	.free			= nfs_fs_context_free,
+	.dup			= nfs_fs_context_dup,
+	.parse_param		= nfs_fs_context_parse_param,
+	.parse_monolithic	= nfs_fs_context_parse_monolithic,
+	.get_tree		= nfs_get_tree,
+	.reconfigure		= nfs_reconfigure,
+};
+
+/*
+ * Prepare superblock configuration.  We use the namespaces attached to the
+ * context.  This may be the current process's namespaces, or it may be a
+ * container's namespaces.
+ */
+static int nfs_init_fs_context(struct fs_context *fc)
+{
+	struct nfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct nfs_fs_context), GFP_KERNEL);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+
+	ctx->mntfh = nfs_alloc_fhandle();
+	if (unlikely(!ctx->mntfh)) {
+		kfree(ctx);
+		return -ENOMEM;
+	}
+
+	ctx->protofamily	= AF_UNSPEC;
+	ctx->mountfamily	= AF_UNSPEC;
+	ctx->mount_server.port	= NFS_UNSPEC_PORT;
+
+	if (fc->root) {
+		/* reconfigure, start with the current config */
+		struct nfs_server *nfss = fc->root->d_sb->s_fs_info;
+		struct net *net = nfss->nfs_client->cl_net;
+
+		ctx->flags		= nfss->flags;
+		ctx->rsize		= nfss->rsize;
+		ctx->wsize		= nfss->wsize;
+		ctx->retrans		= nfss->client->cl_timeout->to_retries;
+		ctx->selected_flavor	= nfss->client->cl_auth->au_flavor;
+		ctx->acregmin		= nfss->acregmin / HZ;
+		ctx->acregmax		= nfss->acregmax / HZ;
+		ctx->acdirmin		= nfss->acdirmin / HZ;
+		ctx->acdirmax		= nfss->acdirmax / HZ;
+		ctx->timeo		= 10U * nfss->client->cl_timeout->to_initval / HZ;
+		ctx->nfs_server.port	= nfss->port;
+		ctx->nfs_server.addrlen	= nfss->nfs_client->cl_addrlen;
+		ctx->version		= nfss->nfs_client->rpc_ops->version;
+		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
+
+		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+			ctx->nfs_server.addrlen);
+
+		if (fc->net_ns != net) {
+			put_net(fc->net_ns);
+			fc->net_ns = get_net(net);
+		}
+
+		ctx->nfs_mod = nfss->nfs_client->cl_nfs_mod;
+		__module_get(ctx->nfs_mod->owner);
+	} else {
+		/* defaults */
+		ctx->timeo		= NFS_UNSPEC_TIMEO;
+		ctx->retrans		= NFS_UNSPEC_RETRANS;
+		ctx->acregmin		= NFS_DEF_ACREGMIN;
+		ctx->acregmax		= NFS_DEF_ACREGMAX;
+		ctx->acdirmin		= NFS_DEF_ACDIRMIN;
+		ctx->acdirmax		= NFS_DEF_ACDIRMAX;
+		ctx->nfs_server.port	= NFS_UNSPEC_PORT;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
+		ctx->minorversion	= 0;
+		ctx->need_mount		= true;
+	}
+	fc->fs_private = ctx;
+	fc->ops = &nfs_fs_context_ops;
+	return 0;
 }
+
+struct file_system_type nfs_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "nfs",
+	.init_fs_context	= nfs_init_fs_context,
+	.parameters		= &nfs_fs_parameters,
+	.kill_sb		= nfs_kill_super,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs");
+EXPORT_SYMBOL_GPL(nfs_fs_type);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+struct file_system_type nfs4_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "nfs4",
+	.init_fs_context	= nfs_init_fs_context,
+	.parameters		= &nfs_fs_parameters,
+	.kill_sb		= nfs_kill_super,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs4");
+MODULE_ALIAS("nfs4");
+EXPORT_SYMBOL_GPL(nfs4_fs_type);
+#endif /* CONFIG_NFS_V4 */
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 3800ab6f08fa..4a8df8c30a03 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -128,7 +128,7 @@ void nfs_fscache_get_super_cookie(struct super_block *sb, const char *uniq, int
 		return;
 
 	key->nfs_client = nfss->nfs_client;
-	key->key.super.s_flags = sb->s_flags & NFS_MS_MASK;
+	key->key.super.s_flags = sb->s_flags & NFS_SB_MASK;
 	key->key.nfs_server.flags = nfss->flags;
 	key->key.nfs_server.rsize = nfss->rsize;
 	key->key.nfs_server.wsize = nfss->wsize;
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 878c4c5982d9..ab45496d23a6 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -64,66 +64,68 @@ static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *i
 /*
  * get an NFS2/NFS3 root dentry from the root filehandle
  */
-struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh,
-			    const char *devname)
+int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
-	struct nfs_server *server = NFS_SB(sb);
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct nfs_server *server = NFS_SB(s);
 	struct nfs_fsinfo fsinfo;
-	struct dentry *ret;
+	struct dentry *root;
 	struct inode *inode;
-	void *name = kstrdup(devname, GFP_KERNEL);
-	int error;
+	char *name;
+	int error = -ENOMEM;
 
+	name = kstrdup(fc->source, GFP_KERNEL);
 	if (!name)
-		return ERR_PTR(-ENOMEM);
+		goto out;
 
 	/* get the actual root for this mount */
 	fsinfo.fattr = nfs_alloc_fattr();
-	if (fsinfo.fattr == NULL) {
-		kfree(name);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (fsinfo.fattr == NULL)
+		goto out_name;
 
-	error = server->nfs_client->rpc_ops->getroot(server, mntfh, &fsinfo);
+	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
-		ret = ERR_PTR(error);
-		goto out;
+		goto out_fattr;
 	}
 
-	inode = nfs_fhget(sb, mntfh, fsinfo.fattr, NULL);
+	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
-		ret = ERR_CAST(inode);
-		goto out;
+		error = PTR_ERR(inode);
+		goto out_fattr;
 	}
 
-	error = nfs_superblock_set_dummy_root(sb, inode);
-	if (error != 0) {
-		ret = ERR_PTR(error);
-		goto out;
-	}
+	error = nfs_superblock_set_dummy_root(s, inode);
+	if (error != 0)
+		goto out_fattr;
 
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
 	 */
-	ret = d_obtain_root(inode);
-	if (IS_ERR(ret)) {
+	root = d_obtain_root(inode);
+	if (IS_ERR(root)) {
 		dprintk("nfs_get_root: get root dentry failed\n");
-		goto out;
+		error = PTR_ERR(root);
+		goto out_fattr;
 	}
 
-	security_d_instantiate(ret, inode);
-	spin_lock(&ret->d_lock);
-	if (IS_ROOT(ret) && !ret->d_fsdata &&
-	    !(ret->d_flags & DCACHE_NFSFS_RENAMED)) {
-		ret->d_fsdata = name;
+	security_d_instantiate(root, inode);
+	spin_lock(&root->d_lock);
+	if (IS_ROOT(root) && !root->d_fsdata &&
+	    !(root->d_flags & DCACHE_NFSFS_RENAMED)) {
+		root->d_fsdata = name;
 		name = NULL;
 	}
-	spin_unlock(&ret->d_lock);
-out:
-	kfree(name);
+	spin_unlock(&root->d_lock);
+	fc->root = root;
+	error = 0;
+
+out_fattr:
 	nfs_free_fattr(fsinfo.fattr);
-	return ret;
+out_name:
+	kfree(name);
+out:
+	return error;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index caaf0af1bc7f..e0911815e153 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -4,18 +4,19 @@
  */
 
 #include "nfs4_fs.h"
-#include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/security.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
 
-#define NFS_MS_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
+#define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
 extern const struct export_operations nfs_export_ops;
 
 struct nfs_string;
+struct nfs_pageio_descriptor;
 
 /* Maximum number of readahead requests
  * FIXME: this should really be a sysctl so that users may tune it to suit
@@ -40,16 +41,6 @@ static inline int nfs_attr_use_mounted_on_fileid(struct nfs_fattr *fattr)
 	return 1;
 }
 
-struct nfs_clone_mount {
-	const struct super_block *sb;
-	const struct dentry *dentry;
-	char *hostname;
-	char *mnt_path;
-	struct sockaddr *addr;
-	size_t addrlen;
-	rpc_authflavor_t authflavor;
-};
-
 /*
  * Note: RFC 1813 doesn't limit the number of auth flavors that
  * a server can return, so make something up.
@@ -90,6 +81,10 @@ struct nfs_client_initdata {
  * In-kernel mount arguments
  */
 struct nfs_fs_context {
+	bool			internal;
+	bool			skip_reconfig_option_check;
+	bool			need_mount;
+	bool			sloppy;
 	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
@@ -106,8 +101,6 @@ struct nfs_fs_context {
 	char			*fscache_uniq;
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
-	bool			need_mount;
-	bool			sloppy;
 
 	struct {
 		union {
@@ -132,14 +125,27 @@ struct nfs_fs_context {
 		int			port;
 		unsigned short		protocol;
 		unsigned short		nconnect;
+		unsigned short		export_path_len;
 	} nfs_server;
 
-	void			*lsm_opts;
-	struct net		*net;
-
-	char			buf[32];	/* Parse buffer */
+	struct nfs_fh		*mntfh;
+	struct nfs_server	*server;
+	struct nfs_subversion	*nfs_mod;
+
+	/* Information for a cloned mount. */
+	struct nfs_clone_mount {
+		struct super_block	*sb;
+		struct dentry		*dentry;
+		struct nfs_fattr	*fattr;
+		unsigned int		inherited_bsize;
+	} clone_data;
 };
 
+static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
+{
+	return fc->fs_private;
+}
+
 /* mount_clnt.c */
 struct nfs_mount_request {
 	struct sockaddr		*sap;
@@ -155,15 +161,6 @@ struct nfs_mount_request {
 	struct net		*net;
 };
 
-struct nfs_mount_info {
-	unsigned int inherited_bsize;
-	struct nfs_fs_context *ctx;
-	struct nfs_clone_mount *cloned;
-	struct nfs_server *server;
-	struct nfs_fh *mntfh;
-	struct nfs_subversion *nfs_mod;
-};
-
 extern int nfs_mount(struct nfs_mount_request *info);
 extern void nfs_umount(const struct nfs_mount_request *info);
 
@@ -189,10 +186,9 @@ extern struct nfs_client *nfs4_find_client_ident(struct net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
-extern struct nfs_server *nfs_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *,
-						      struct nfs_fh *);
+extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_referral_server(struct fs_context *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostname,
 					struct sockaddr *sap, size_t salen,
 					struct net *net);
@@ -243,22 +239,8 @@ static inline void nfs_fs_proc_exit(void)
 extern const struct svc_version nfs4_callback_version1;
 extern const struct svc_version nfs4_callback_version4;
 
-struct nfs_pageio_descriptor;
-
-/* mount.c */
-#define NFS_TEXT_DATA		1
-
-extern struct nfs_fs_context *nfs_alloc_parsed_mount_data(void);
-extern void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx);
-extern int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx);
-extern int nfs_validate_mount_data(struct file_system_type *fs_type,
-				   void *options,
-				   struct nfs_fs_context *ctx,
-				   struct nfs_fh *mntfh,
-				   const char *dev_name);
-extern int nfs_validate_text_mount_data(void *options,
-					struct nfs_fs_context *ctx,
-					const char *dev_name);
+/* fs_context.c */
+extern struct file_system_type nfs_fs_type;
 
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
@@ -419,14 +401,9 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
 
 /* super.c */
 extern const struct super_operations nfs_sops;
-extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_prepared_fs_type;
-#if IS_ENABLED(CONFIG_NFS_V4)
-extern struct file_system_type nfs4_referral_fs_type;
-#endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
+int nfs_try_get_tree(struct fs_context *);
+int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
 
 extern struct rpc_stat nfs_rpcstat;
@@ -454,18 +431,13 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 extern char *nfs_path(char **p, struct dentry *dentry,
 		      char *buffer, ssize_t buflen, unsigned flags);
 extern struct vfsmount *nfs_d_automount(struct path *path);
-struct vfsmount *nfs_submount(struct nfs_server *, struct dentry *,
-			      struct nfs_fh *, struct nfs_fattr *);
-struct vfsmount *nfs_do_submount(struct dentry *, struct nfs_fh *,
-				 struct nfs_fattr *, rpc_authflavor_t);
+int nfs_submount(struct fs_context *, struct nfs_server *);
+int nfs_do_submount(struct fs_context *);
 
 /* getroot.c */
-extern struct dentry *nfs_get_root(struct super_block *, struct nfs_fh *,
-				   const char *);
+extern int nfs_get_root(struct super_block *s, struct fs_context *fc);
 #if IS_ENABLED(CONFIG_NFS_V4)
-extern struct dentry *nfs4_get_root(struct super_block *, struct nfs_fh *,
-				    const char *);
-
+extern int nfs4_get_root(struct super_block *s, struct fs_context *cfg);
 extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool);
 #endif
 
@@ -484,7 +456,7 @@ int  nfs_show_options(struct seq_file *, struct dentry *);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
 int  nfs_show_stats(struct seq_file *, struct dentry *);
-int nfs_remount(struct super_block *sb, int *flags, char *raw_data);
+int  nfs_reconfigure(struct fs_context *);
 
 /* write.c */
 extern void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 72a99f9c7390..3e566a632215 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -140,31 +140,62 @@ EXPORT_SYMBOL_GPL(nfs_path);
  */
 struct vfsmount *nfs_d_automount(struct path *path)
 {
-	struct vfsmount *mnt;
+	struct nfs_fs_context *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
 	struct nfs_server *server = NFS_SERVER(d_inode(path->dentry));
-	struct nfs_fh *fh = NULL;
-	struct nfs_fattr *fattr = NULL;
+	struct nfs_client *client = server->nfs_client;
+	int ret;
 
 	if (IS_ROOT(path->dentry))
 		return ERR_PTR(-ESTALE);
 
-	mnt = ERR_PTR(-ENOMEM);
-	fh = nfs_alloc_fhandle();
-	fattr = nfs_alloc_fattr();
-	if (fh == NULL || fattr == NULL)
-		goto out;
+	/* Open a new filesystem context, transferring parameters from the
+	 * parent superblock, including the network namespace.
+	 */
+	fc = fs_context_for_submount(&nfs_fs_type, path->dentry);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
 
-	mnt = server->nfs_client->rpc_ops->submount(server, path->dentry, fh, fattr);
+	ctx = nfs_fc2context(fc);
+	ctx->clone_data.dentry	= path->dentry;
+	ctx->clone_data.sb	= path->dentry->d_sb;
+	ctx->clone_data.fattr	= nfs_alloc_fattr();
+	if (!ctx->clone_data.fattr)
+		goto out_fc;
+
+	if (fc->net_ns != client->cl_net) {
+		put_net(fc->net_ns);
+		fc->net_ns = get_net(client->cl_net);
+	}
+
+	/* for submounts we want the same server; referrals will reassign */
+	memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
+	ctx->nfs_server.addrlen	= client->cl_addrlen;
+	ctx->nfs_server.port	= server->port;
+
+	ctx->version		= client->rpc_ops->version;
+	ctx->minorversion	= client->cl_minorversion;
+	ctx->nfs_mod		= client->cl_nfs_mod;
+	__module_get(ctx->nfs_mod->owner);
+
+	ret = client->rpc_ops->submount(fc, server);
+	if (ret < 0) {
+		mnt = ERR_PTR(ret);
+		goto out_fc;
+	}
+
+	up_write(&fc->root->d_sb->s_umount);
+	mnt = vfs_create_mount(fc);
 	if (IS_ERR(mnt))
-		goto out;
+		goto out_fc;
 
 	mntget(mnt); /* prevent immediate expiration */
 	mnt_set_expiry(mnt, &nfs_automount_list);
 	schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
 
-out:
-	nfs_free_fattr(fattr);
-	nfs_free_fhandle(fh);
+out_fc:
+	put_fs_context(fc);
 	return mnt;
 }
 
@@ -219,61 +250,62 @@ void nfs_release_automount_timer(void)
  * @authflavor: security flavor to use when performing the mount
  *
  */
-struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
-				 struct nfs_fattr *fattr, rpc_authflavor_t authflavor)
+int nfs_do_submount(struct fs_context *fc)
 {
-	struct super_block *sb = dentry->d_sb;
-	struct nfs_clone_mount mountdata = {
-		.sb = sb,
-		.dentry = dentry,
-		.authflavor = authflavor,
-	};
-	struct nfs_mount_info mount_info = {
-		.inherited_bsize = sb->s_blocksize_bits,
-		.cloned = &mountdata,
-		.mntfh = fh,
-		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
-	};
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct nfs_server *server;
-	struct vfsmount *mnt;
-	char *page = (char *) __get_free_page(GFP_USER);
-	char *devname;
+	char *buffer, *p;
+	int ret;
 
-	if (page == NULL)
-		return ERR_PTR(-ENOMEM);
+	/* create a new volume representation */
+	server = ctx->nfs_mod->rpc_ops->clone_server(NFS_SB(ctx->clone_data.sb),
+						     ctx->mntfh,
+						     ctx->clone_data.fattr,
+						     ctx->selected_flavor);
 
-	server = mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-							   fattr, authflavor);
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
-	mount_info.server = server;
+	ctx->server = server;
 
-	devname = nfs_devname(dentry, page, PAGE_SIZE);
-	if (IS_ERR(devname))
-		mnt = ERR_CAST(devname);
-	else
-		mnt = vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_info);
+	buffer = kmalloc(4096, GFP_USER);
+	if (!buffer)
+		return -ENOMEM;
 
-	if (mount_info.server)
-		nfs_free_server(mount_info.server);
-	free_page((unsigned long)page);
-	return mnt;
+	ctx->internal		= true;
+	ctx->clone_data.inherited_bsize = ctx->clone_data.sb->s_blocksize_bits;
+
+	p = nfs_devname(dentry, buffer, 4096);
+	if (IS_ERR(p)) {
+		dprintk("NFS: Couldn't determine submount pathname\n");
+		ret = PTR_ERR(p);
+	} else {
+		ret = vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
+		if (!ret)
+			ret = vfs_get_tree(fc);
+	}
+	kfree(buffer);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_do_submount);
 
-struct vfsmount *nfs_submount(struct nfs_server *server, struct dentry *dentry,
-			      struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 {
-	int err;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct dentry *parent = dget_parent(dentry);
+	int err;
 
 	/* Look it up again to get its attributes */
-	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d_name, fh, fattr, NULL);
+	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d_name,
+						  ctx->mntfh, ctx->clone_data.fattr,
+						  NULL);
 	dput(parent);
 	if (err != 0)
-		return ERR_PTR(err);
+		return err;
 
-	return nfs_do_submount(dentry, fh, fattr, server->client->cl_auth->au_flavor);
+	ctx->selected_flavor = server->client->cl_auth->au_flavor;
+	return nfs_do_submount(fc);
 }
 EXPORT_SYMBOL_GPL(nfs_submount);
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index 09602dc1889f..1b950b66b3bb 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -27,7 +27,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 #endif /* CONFIG_NFS_V3_ACL */
 
 /* nfs3client.c */
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *);
+struct nfs_server *nfs3_create_server(struct fs_context *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 				     struct nfs_fattr *, rpc_authflavor_t);
 
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index a340b5d0e1a3..bfd9b5f03455 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -46,9 +46,10 @@ static inline void nfs_init_server_aclclient(struct nfs_server *server)
 }
 #endif
 
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs3_create_server(struct fs_context *fc)
 {
-	struct nfs_server *server = nfs_create_server(mount_info);
+	struct nfs_server *server = nfs_create_server(fc);
+
 	/* Create a client RPC handle for the NFS v3 ACL management interface */
 	if (!IS_ERR(server))
 		nfs_init_server_aclclient(server);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a3ad2d46fd42..912a0b0c9bb9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -963,7 +963,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.nlmclnt_ops	= &nlmclnt_fl_close_lock_ops,
 	.getroot	= nfs3_proc_get_root,
 	.submount	= nfs_submount,
-	.try_mount	= nfs_try_mount,
+	.try_get_tree	= nfs_try_get_tree,
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
 	.lookup		= nfs3_proc_lookup,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 67ecd7bb512f..a6ee4de47774 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -268,14 +268,13 @@ extern const struct dentry_operations nfs4_dentry_operations;
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
 		    unsigned, umode_t);
 
-/* super.c */
+/* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
 
 /* nfs4namespace.c */
 struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *,
 					 const struct qstr *);
-struct vfsmount *nfs4_submount(struct nfs_server *, struct dentry *,
-			       struct nfs_fh *, struct nfs_fattr *);
+int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 				const struct nfs4_fs_locations *locations);
 
@@ -517,7 +516,6 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
@@ -527,6 +525,9 @@ extern bool recover_lost_locks;
 #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
 
+extern int nfs4_try_get_tree(struct fs_context *);
+extern int nfs4_get_referral_tree(struct fs_context *);
+
 /* nfs4sysctl.c */
 #ifdef CONFIG_SYSCTL
 int nfs4_register_sysctl(void);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 2ee2281ce404..be26fbe06863 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1052,9 +1052,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 /*
  * Create a version 4 volume record
  */
-static int nfs4_init_server(struct nfs_server *server,
-			    struct nfs_fs_context *ctx)
+static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct rpc_timeout timeparms;
 	int error;
 
@@ -1076,15 +1076,15 @@ static int nfs4_init_server(struct nfs_server *server,
 
 	/* Get a client record */
 	error = nfs4_set_client(server,
-			ctx->nfs_server.hostname,
-			(const struct sockaddr *)&ctx->nfs_server.address,
-			ctx->nfs_server.addrlen,
-			ctx->client_address,
-			ctx->nfs_server.protocol,
-			&timeparms,
-			ctx->minorversion,
-			ctx->nfs_server.nconnect,
-			ctx->net);
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
+				ctx->client_address,
+				ctx->nfs_server.protocol,
+				&timeparms,
+				ctx->minorversion,
+				ctx->nfs_server.nconnect,
+				fc->net_ns);
 	if (error < 0)
 		return error;
 
@@ -1107,10 +1107,9 @@ static int nfs4_init_server(struct nfs_server *server,
  * Create a version 4 volume record
  * - keyed on server and FSID
  */
-/*struct nfs_server *nfs4_create_server(const struct nfs_fs_context *data,
-				      struct nfs_fh *mntfh)*/
-struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs4_create_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_server *server;
 	bool auth_probe;
 	int error;
@@ -1121,14 +1120,14 @@ struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 
 	server->cred = get_cred(current_cred());
 
-	auth_probe = mount_info->ctx->auth_info.flavor_len < 1;
+	auth_probe = ctx->auth_info.flavor_len < 1;
 
 	/* set up the general RPC client */
-	error = nfs4_init_server(server, mount_info->ctx);
+	error = nfs4_init_server(server, fc);
 	if (error < 0)
 		goto error;
 
-	error = nfs4_server_common_setup(server, mount_info->mntfh, auth_probe);
+	error = nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 	if (error < 0)
 		goto error;
 
@@ -1142,9 +1141,9 @@ struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 /*
  * Create an NFS4 referral server record
  */
-struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
-					       struct nfs_fh *mntfh)
+struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_client *parent_client;
 	struct nfs_server *server, *parent_server;
 	bool auth_probe;
@@ -1154,7 +1153,7 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	parent_server = NFS_SB(data->sb);
+	parent_server = NFS_SB(ctx->clone_data.sb);
 	parent_client = parent_server->nfs_client;
 
 	server->cred = get_cred(parent_server->cred);
@@ -1164,10 +1163,11 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 
 	/* Get a client representation */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-	rpc_set_port(data->addr, NFS_RDMA_PORT);
-	error = nfs4_set_client(server, data->hostname,
-				data->addr,
-				data->addrlen,
+	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+	error = nfs4_set_client(server,
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_RDMA,
 				parent_server->client->cl_timeout,
@@ -1178,10 +1178,11 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 		goto init_server;
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
-	rpc_set_port(data->addr, NFS_PORT);
-	error = nfs4_set_client(server, data->hostname,
-				data->addr,
-				data->addrlen,
+	rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
+	error = nfs4_set_client(server,
+				ctx->nfs_server.hostname,
+				&ctx->nfs_server.address,
+				ctx->nfs_server.addrlen,
 				parent_client->cl_ipaddr,
 				XPRT_TRANSPORT_TCP,
 				parent_server->client->cl_timeout,
@@ -1194,13 +1195,14 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 init_server:
 #endif
-	error = nfs_init_server_rpcclient(server, parent_server->client->cl_timeout, data->authflavor);
+	error = nfs_init_server_rpcclient(server, parent_server->client->cl_timeout,
+					  ctx->selected_flavor);
 	if (error < 0)
 		goto error;
 
 	auth_probe = parent_server->auth_info.flavor_len < 1;
 
-	error = nfs4_server_common_setup(server, mntfh, auth_probe);
+	error = nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 	if (error < 0)
 		goto error;
 
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 2e460c33ae48..37999925040a 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -8,6 +8,7 @@
  * NFSv4 namespace
  */
 
+#include <linux/module.h>
 #include <linux/dcache.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -21,37 +22,64 @@
 #include <linux/inet.h>
 #include "internal.h"
 #include "nfs4_fs.h"
+#include "nfs.h"
 #include "dns_resolve.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
+/*
+ * Work out the length that an NFSv4 path would render to as a standard posix
+ * path, with a leading slash but no terminating slash.
+ */
+static ssize_t nfs4_pathname_len(const struct nfs4_pathname *pathname)
+{
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < pathname->ncomponents; i++) {
+		const struct nfs4_string *component = &pathname->components[i];
+
+		if (component->len > NAME_MAX)
+			goto too_long;
+		len += 1 + component->len; /* Adding "/foo" */
+		if (len > PATH_MAX)
+			goto too_long;
+	}
+	return len;
+
+too_long:
+	return -ENAMETOOLONG;
+}
+
 /*
  * Convert the NFSv4 pathname components into a standard posix path.
- *
- * Note that the resulting string will be placed at the end of the buffer
  */
-static inline char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
-					 char *buffer, ssize_t buflen)
+static char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
+				  unsigned short *_len)
 {
-	char *end = buffer + buflen;
-	int n;
+	ssize_t len;
+	char *buf, *p;
+	int i;
+
+	len = nfs4_pathname_len(pathname);
+	if (len < 0)
+		return ERR_PTR(len);
+	*_len = len;
 
-	*--end = '\0';
-	buflen--;
-
-	n = pathname->ncomponents;
-	while (--n >= 0) {
-		const struct nfs4_string *component = &pathname->components[n];
-		buflen -= component->len + 1;
-		if (buflen < 0)
-			goto Elong;
-		end -= component->len;
-		memcpy(end, component->data, component->len);
-		*--end = '/';
+	p = buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < pathname->ncomponents; i++) {
+		const struct nfs4_string *component = &pathname->components[i];
+
+		*p++ = '/';
+		memcpy(p, component->data, component->len);
+		p += component->len;
 	}
-	return end;
-Elong:
-	return ERR_PTR(-ENAMETOOLONG);
+
+	*p = 0;
+	return buf;
 }
 
 /*
@@ -100,21 +128,25 @@ static char *nfs4_path(struct dentry *dentry, char *buffer, ssize_t buflen)
  */
 static int nfs4_validate_fspath(struct dentry *dentry,
 				const struct nfs4_fs_locations *locations,
-				char *page, char *page2)
+				struct nfs_fs_context *ctx)
 {
-	const char *path, *fs_path;
+	const char *path;
+	char *buf;
+	int n;
 
-	path = nfs4_path(dentry, page, PAGE_SIZE);
-	if (IS_ERR(path))
+	buf = kmalloc(4096, GFP_KERNEL);
+	path = nfs4_path(dentry, buf, 4096);
+	if (IS_ERR(path)) {
+		kfree(buf);
 		return PTR_ERR(path);
+	}
 
-	fs_path = nfs4_pathname_string(&locations->fs_path, page2, PAGE_SIZE);
-	if (IS_ERR(fs_path))
-		return PTR_ERR(fs_path);
-
-	if (strncmp(path, fs_path, strlen(fs_path)) != 0) {
+	n = strncmp(path, ctx->nfs_server.export_path,
+		    ctx->nfs_server.export_path_len);
+	kfree(buf);
+	if (n != 0) {
 		dprintk("%s: path %s does not begin with fsroot %s\n",
-			__func__, path, fs_path);
+			__func__, path, ctx->nfs_server.export_path);
 		return -ENOENT;
 	}
 
@@ -236,55 +268,70 @@ nfs4_negotiate_security(struct rpc_clnt *clnt, struct inode *inode,
 	return new;
 }
 
-static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
-				     char *page, char *page2,
-				     const struct nfs4_fs_location *location)
+static int try_location(struct fs_context *fc,
+			const struct nfs4_fs_location *location)
 {
-	const size_t addr_bufsize = sizeof(struct sockaddr_storage);
-	struct net *net = rpc_net_ns(NFS_SB(mountdata->sb)->client);
-	struct vfsmount *mnt = ERR_PTR(-ENOENT);
-	char *mnt_path;
-	unsigned int maxbuflen;
-	unsigned int s;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	unsigned int len, s;
+	char *source, *p;
+	int ret = -ENOENT;
+
+	/* Allocate a buffer big enough to hold any of the hostnames plus a
+	 * terminating char and also a buffer big enough to hold the hostname
+	 * plus a colon plus the path.
+	 */
+	len = 0;
+	for (s = 0; s < location->nservers; s++) {
+		const struct nfs4_string *buf = &location->servers[s];
+		if (buf->len > len)
+			len = buf->len;
+	}
 
-	mnt_path = nfs4_pathname_string(&location->rootpath, page2, PAGE_SIZE);
-	if (IS_ERR(mnt_path))
-		return ERR_CAST(mnt_path);
-	mountdata->mnt_path = mnt_path;
-	maxbuflen = mnt_path - 1 - page2;
+	kfree(ctx->nfs_server.hostname);
+	ctx->nfs_server.hostname = kmalloc(len + 1, GFP_KERNEL);
+	if (!ctx->nfs_server.hostname)
+		return -ENOMEM;
 
-	mountdata->addr = kmalloc(addr_bufsize, GFP_KERNEL);
-	if (mountdata->addr == NULL)
-		return ERR_PTR(-ENOMEM);
+	source = kmalloc(len + 1 + ctx->nfs_server.export_path_len + 1,
+			 GFP_KERNEL);
+	if (!source)
+		return -ENOMEM;
 
+	kfree(fc->source);
+	fc->source = source;
 	for (s = 0; s < location->nservers; s++) {
 		const struct nfs4_string *buf = &location->servers[s];
 
-		if (buf->len <= 0 || buf->len >= maxbuflen)
-			continue;
-
 		if (memchr(buf->data, IPV6_SCOPE_DELIMITER, buf->len))
 			continue;
 
-		mountdata->addrlen = nfs_parse_server_name(buf->data, buf->len,
-				mountdata->addr, addr_bufsize, net);
-		if (mountdata->addrlen == 0)
+		ctx->nfs_server.addrlen =
+			nfs_parse_server_name(buf->data, buf->len,
+					      &ctx->nfs_server.address,
+					      sizeof(ctx->nfs_server._address),
+					      fc->net_ns);
+		if (ctx->nfs_server.addrlen == 0)
 			continue;
 
-		memcpy(page2, buf->data, buf->len);
-		page2[buf->len] = '\0';
-		mountdata->hostname = page2;
+		rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
 
-		snprintf(page, PAGE_SIZE, "%s:%s",
-				mountdata->hostname,
-				mountdata->mnt_path);
+		memcpy(ctx->nfs_server.hostname, buf->data, buf->len);
+		ctx->nfs_server.hostname[buf->len] = '\0';
 
-		mnt = vfs_submount(mountdata->dentry, &nfs4_referral_fs_type, page, mountdata);
-		if (!IS_ERR(mnt))
-			break;
+		p = source;
+		memcpy(p, buf->data, buf->len);
+		p += buf->len;
+		*p++ = ':';
+		memcpy(p, ctx->nfs_server.export_path, ctx->nfs_server.export_path_len);
+		p += ctx->nfs_server.export_path_len;
+		*p = 0;
+
+		ret = nfs4_get_referral_tree(fc);
+		if (ret == 0)
+			return 0;
 	}
-	kfree(mountdata->addr);
-	return mnt;
+
+	return ret;
 }
 
 /**
@@ -293,38 +340,31 @@ static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
  * @locations: array of NFSv4 server location information
  *
  */
-static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
-					    const struct nfs4_fs_locations *locations)
+static int nfs_follow_referral(struct fs_context *fc,
+			       const struct nfs4_fs_locations *locations)
 {
-	struct vfsmount *mnt = ERR_PTR(-ENOENT);
-	struct nfs_clone_mount mountdata = {
-		.sb = dentry->d_sb,
-		.dentry = dentry,
-		.authflavor = NFS_SB(dentry->d_sb)->client->cl_auth->au_flavor,
-	};
-	char *page = NULL, *page2 = NULL;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	char *export_path;
 	int loc, error;
 
 	if (locations == NULL || locations->nlocations <= 0)
-		goto out;
+		return -ENOENT;
 
-	dprintk("%s: referral at %pd2\n", __func__, dentry);
+	dprintk("%s: referral at %pd2\n", __func__, ctx->clone_data.dentry);
 
-	page = (char *) __get_free_page(GFP_USER);
-	if (!page)
-		goto out;
+	export_path = nfs4_pathname_string(&locations->fs_path,
+					   &ctx->nfs_server.export_path_len);
+	if (IS_ERR(export_path))
+		return PTR_ERR(export_path);
 
-	page2 = (char *) __get_free_page(GFP_USER);
-	if (!page2)
-		goto out;
+	ctx->nfs_server.export_path = export_path;
 
 	/* Ensure fs path is a prefix of current dentry path */
-	error = nfs4_validate_fspath(dentry, locations, page, page2);
-	if (error < 0) {
-		mnt = ERR_PTR(error);
-		goto out;
-	}
+	error = nfs4_validate_fspath(ctx->clone_data.dentry, locations, ctx);
+	if (error < 0)
+		return error;
 
+	error = -ENOENT;
 	for (loc = 0; loc < locations->nlocations; loc++) {
 		const struct nfs4_fs_location *location = &locations->locations[loc];
 
@@ -332,15 +372,12 @@ static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
 		    location->rootpath.ncomponents == 0)
 			continue;
 
-		mnt = try_location(&mountdata, page, page2, location);
-		if (!IS_ERR(mnt))
-			break;
+		error = try_location(fc, location);
+		if (error == 0)
+			return 0;
 	}
 
-out:
-	free_page((unsigned long) page);
-	free_page((unsigned long) page2);
-	return mnt;
+	return error;
 }
 
 /*
@@ -348,71 +385,73 @@ static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
  * @dentry - dentry of referral
  *
  */
-static struct vfsmount *nfs_do_refmount(struct rpc_clnt *client, struct dentry *dentry)
+static int nfs_do_refmount(struct fs_context *fc, struct rpc_clnt *client)
 {
-	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
-	struct dentry *parent;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry, *parent;
 	struct nfs4_fs_locations *fs_locations = NULL;
 	struct page *page;
-	int err;
+	int err = -ENOMEM;
 
 	/* BUG_ON(IS_ROOT(dentry)); */
 	page = alloc_page(GFP_KERNEL);
-	if (page == NULL)
-		return mnt;
+	if (!page)
+		return -ENOMEM;
 
 	fs_locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (fs_locations == NULL)
+	if (!fs_locations)
 		goto out_free;
 
 	/* Get locations */
-	mnt = ERR_PTR(-ENOENT);
-
+	dentry = ctx->clone_data.dentry;
 	parent = dget_parent(dentry);
 	dprintk("%s: getting locations for %pd2\n",
 		__func__, dentry);
 
 	err = nfs4_proc_fs_locations(client, d_inode(parent), &dentry->d_name, fs_locations, page);
 	dput(parent);
-	if (err != 0 ||
-	    fs_locations->nlocations <= 0 ||
+	if (err != 0)
+		goto out_free_2;
+
+	err = -ENOENT;
+	if (fs_locations->nlocations <= 0 ||
 	    fs_locations->fs_path.ncomponents <= 0)
-		goto out_free;
+		goto out_free_2;
 
-	mnt = nfs_follow_referral(dentry, fs_locations);
+	err = nfs_follow_referral(fc, fs_locations);
+out_free_2:
+	kfree(fs_locations);
 out_free:
 	__free_page(page);
-	kfree(fs_locations);
-	return mnt;
+	return err;
 }
 
-struct vfsmount *nfs4_submount(struct nfs_server *server, struct dentry *dentry,
-			       struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs4_submount(struct fs_context *fc, struct nfs_server *server)
 {
-	rpc_authflavor_t flavor = server->client->cl_auth->au_flavor;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct dentry *dentry = ctx->clone_data.dentry;
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
 	const struct qstr *name = &dentry->d_name;
 	struct rpc_clnt *client;
-	struct vfsmount *mnt;
+	int ret;
 
 	/* Look it up again to get its attributes and sec flavor */
-	client = nfs4_proc_lookup_mountpoint(dir, name, fh, fattr);
+	client = nfs4_proc_lookup_mountpoint(dir, name, ctx->mntfh,
+					     ctx->clone_data.fattr);
 	dput(parent);
 	if (IS_ERR(client))
-		return ERR_CAST(client);
+		return PTR_ERR(client);
 
-	if (fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
-		mnt = nfs_do_refmount(client, dentry);
-		goto out;
+	if (ctx->clone_data.fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
+		ret = nfs_do_refmount(fc, client);
+	} else {
+		ctx->selected_flavor = client->cl_auth->au_flavor;
+		ret = nfs_do_submount(fc);
 	}
 
-	if (client->cl_auth->au_flavor != flavor)
-		flavor = client->cl_auth->au_flavor;
-	mnt = nfs_do_submount(dentry, fh, fattr, flavor);
-out:
 	rpc_shutdown_client(client);
-	return mnt;
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1406858bae6c..2f31ece2f4a4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9895,7 +9895,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.file_ops	= &nfs4_file_operations,
 	.getroot	= nfs4_proc_get_root,
 	.submount	= nfs4_submount,
-	.try_mount	= nfs4_try_mount,
+	.try_get_tree	= nfs4_try_get_tree,
 	.getattr	= nfs4_proc_getattr,
 	.setattr	= nfs4_proc_setattr,
 	.lookup		= nfs4_proc_lookup,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index ca9740137cfe..3b27c5e3d781 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -4,6 +4,7 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/nfs_fs.h>
 #include "delegation.h"
@@ -18,16 +19,6 @@
 
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc);
 static void nfs4_evict_inode(struct inode *inode);
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs4_referral_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs4_referral_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
 
 static const struct super_operations nfs4_sops = {
 	.alloc_inode	= nfs_alloc_inode,
@@ -41,16 +32,15 @@ static const struct super_operations nfs4_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
-	.remount_fs	= nfs_remount,
 };
 
 struct nfs_subversion nfs_v4 = {
-	.owner = THIS_MODULE,
-	.nfs_fs   = &nfs4_fs_type,
-	.rpc_vers = &nfs_version4,
-	.rpc_ops  = &nfs_v4_clientops,
-	.sops     = &nfs4_sops,
-	.xattr    = nfs4_xattr_handlers,
+	.owner		= THIS_MODULE,
+	.nfs_fs		= &nfs4_fs_type,
+	.rpc_vers	= &nfs_version4,
+	.rpc_ops	= &nfs_v4_clientops,
+	.sops		= &nfs4_sops,
+	.xattr		= nfs4_xattr_handlers,
 };
 
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -147,105 +137,123 @@ static void nfs_referral_loop_unprotect(void)
 	kfree(p);
 }
 
-static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
-				    struct nfs_mount_info *info,
-				    const char *hostname,
-				    const char *export_path)
+static int do_nfs4_mount(struct nfs_server *server,
+			 struct fs_context *fc,
+			 const char *hostname,
+			 const char *export_path)
 {
+	struct nfs_fs_context *root_ctx;
+	struct fs_context *root_fc;
 	struct vfsmount *root_mnt;
 	struct dentry *dentry;
-	char *root_devname;
-	int err;
 	size_t len;
+	int ret;
+
+	struct fs_parameter param = {
+		.key	= "source",
+		.type	= fs_value_is_string,
+		.dirfd	= -1,
+	};
 
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
-	len = strlen(hostname) + 5;
-	root_devname = kmalloc(len, GFP_KERNEL);
-	if (root_devname == NULL) {
+	root_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(root_fc)) {
 		nfs_free_server(server);
-		return ERR_PTR(-ENOMEM);
+		return PTR_ERR(root_fc);
+	}
+	kfree(root_fc->source);
+	root_fc->source = NULL;
+
+	root_ctx = nfs_fc2context(root_fc);
+	root_ctx->internal = true;
+	root_ctx->server = server;
+	/* We leave export_path unset as it's not used to find the root. */
+
+	len = strlen(hostname) + 5;
+	param.string = kmalloc(len, GFP_KERNEL);
+	if (param.string == NULL) {
+		put_fs_context(root_fc);
+		return -ENOMEM;
 	}
 
 	/* Does hostname needs to be enclosed in brackets? */
 	if (strchr(hostname, ':'))
-		snprintf(root_devname, len, "[%s]:/", hostname);
+		param.size = snprintf(param.string, len, "[%s]:/", hostname);
 	else
-		snprintf(root_devname, len, "%s:/", hostname);
-	info->server = server;
-	root_mnt = vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname, info);
-	if (info->server)
-		nfs_free_server(info->server);
-	info->server = NULL;
-	kfree(root_devname);
+		param.size = snprintf(param.string, len, "%s:/", hostname);
+	ret = vfs_parse_fs_param(root_fc, &param);
+	kfree(param.string);
+	if (ret < 0) {
+		put_fs_context(root_fc);
+		return ret;
+	}
+	root_mnt = fc_mount(root_fc);
+	put_fs_context(root_fc);
 
 	if (IS_ERR(root_mnt))
-		return ERR_CAST(root_mnt);
+		return PTR_ERR(root_mnt);
 
-	err = nfs_referral_loop_protect();
-	if (err) {
+	ret = nfs_referral_loop_protect();
+	if (ret) {
 		mntput(root_mnt);
-		return ERR_PTR(err);
+		return ret;
 	}
 
 	dentry = mount_subtree(root_mnt, export_path);
 	nfs_referral_loop_unprotect();
 
-	return dentry;
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	fc->root = dentry;
+	return 0;
 }
 
-struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-			      struct nfs_mount_info *mount_info)
+int nfs4_try_get_tree(struct fs_context *fc)
 {
-	struct nfs_fs_context *ctx = mount_info->ctx;
-	struct dentry *res;
-
-	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err;
 
-	res = do_nfs4_mount(nfs4_create_server(mount_info),
-			    flags, mount_info,
-			    ctx->nfs_server.hostname,
-			    ctx->nfs_server.export_path);
+	dfprintk(MOUNT, "--> nfs4_try_get_tree()\n");
 
-	dfprintk(MOUNT, "<-- nfs4_try_mount() = %d%s\n",
-		 PTR_ERR_OR_ZERO(res),
-		 IS_ERR(res) ? " [error]" : "");
-	return res;
+	/* We create a mount for the server's root, walk to the requested
+	 * location and then create another mount for that.
+	 */
+	err= do_nfs4_mount(nfs4_create_server(fc),
+			   fc, ctx->nfs_server.hostname,
+			   ctx->nfs_server.export_path);
+	if (err) {
+		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = %d [error]\n", err);
+	} else {
+		dfprintk(MOUNT, "<-- nfs4_try_get_tree() = 0\n");
+	}
+	return err;
 }
 
 /*
  * Create an NFS4 server record on referral traversal
  */
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data)
+int nfs4_get_referral_tree(struct fs_context *fc)
 {
-	struct nfs_clone_mount *data = raw_data;
-	struct nfs_mount_info mount_info = {
-		.cloned = data,
-		.nfs_mod = &nfs_v4,
-	};
-	struct dentry *res;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	int err;
 
 	dprintk("--> nfs4_referral_mount()\n");
 
-	mount_info.mntfh = nfs_alloc_fhandle();
-	if (!mount_info.mntfh)
-		return ERR_PTR(-ENOMEM);
-
-	res = do_nfs4_mount(nfs4_create_referral_server(mount_info.cloned,
-							mount_info.mntfh),
-			    flags, &mount_info, data->hostname, data->mnt_path);
-
-	dprintk("<-- nfs4_referral_mount() = %d%s\n",
-		PTR_ERR_OR_ZERO(res),
-		IS_ERR(res) ? " [error]" : "");
-
-	nfs_free_fhandle(mount_info.mntfh);
-	return res;
+	/* create a new volume representation */
+	err = do_nfs4_mount(nfs4_create_referral_server(fc),
+			    fc, ctx->nfs_server.hostname,
+			    ctx->nfs_server.export_path);
+	if (err) {
+		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = %d [error]\n", err);
+	} else {
+		dfprintk(MOUNT, "<-- nfs4_get_referral_tree() = 0\n");
+	}
+	return err;
 }
 
-
 static int __init init_nfs_v4(void)
 {
 	int err;
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 5552fa8b6e12..03b175fd94b9 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -707,7 +707,7 @@ const struct nfs_rpc_ops nfs_v2_clientops = {
 	.file_ops	= &nfs_file_operations,
 	.getroot	= nfs_proc_get_root,
 	.submount	= nfs_submount,
-	.try_mount	= nfs_try_mount,
+	.try_get_tree	= nfs_try_get_tree,
 	.getattr	= nfs_proc_getattr,
 	.setattr	= nfs_proc_setattr,
 	.lookup		= nfs_proc_lookup,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 9aa27093d8b6..60174a30a91a 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -70,28 +70,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs",
-	.mount		= nfs_fs_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs");
-EXPORT_SYMBOL_GPL(nfs_fs_type);
-
-struct file_system_type nfs_prepared_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs",
-	.mount		= nfs_prepared_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-EXPORT_SYMBOL_GPL(nfs_prepared_fs_type);
-
 const struct super_operations nfs_sops = {
 	.alloc_inode	= nfs_alloc_inode,
 	.free_inode	= nfs_free_inode,
@@ -104,22 +82,10 @@ const struct super_operations nfs_sops = {
 	.show_devname	= nfs_show_devname,
 	.show_path	= nfs_show_path,
 	.show_stats	= nfs_show_stats,
-	.remount_fs	= nfs_remount,
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-struct file_system_type nfs4_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs_fs_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs4");
-MODULE_ALIAS("nfs4");
-EXPORT_SYMBOL_GPL(nfs4_fs_type);
-
 static int __init register_nfs4_fs(void)
 {
 	return register_filesystem(&nfs4_fs_type);
@@ -779,11 +745,12 @@ static int nfs_verify_authflavors(struct nfs_fs_context *ctx,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_fs_context *ctx,
+static int nfs_request_mount(struct fs_context *fc,
 			     struct nfs_fh *root_fh,
 			     rpc_authflavor_t *server_authlist,
 			     unsigned int *server_authlist_len)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_mount_request request = {
 		.sap		= (struct sockaddr *)
 						&ctx->mount_server.address,
@@ -793,7 +760,7 @@ static int nfs_request_mount(struct nfs_fs_context *ctx,
 		.noresvport	= ctx->flags & NFS_MOUNT_NORESVPORT,
 		.auth_flav_len	= server_authlist_len,
 		.auth_flavs	= server_authlist,
-		.net		= ctx->net,
+		.net		= fc->net_ns,
 	};
 	int status;
 
@@ -838,20 +805,18 @@ static int nfs_request_mount(struct nfs_fs_context *ctx,
 	return 0;
 }
 
-static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_info)
+static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	int status;
 	unsigned int i;
 	bool tried_auth_unix = false;
 	bool auth_null_in_list = false;
 	struct nfs_server *server = ERR_PTR(-EACCES);
-	struct nfs_fs_context *ctx = mount_info->ctx;
 	rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 	unsigned int authlist_len = ARRAY_SIZE(authlist);
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 
-	status = nfs_request_mount(ctx, mount_info->mntfh, authlist,
-					&authlist_len);
+	status = nfs_request_mount(fc, ctx->mntfh, authlist, &authlist_len);
 	if (status)
 		return ERR_PTR(status);
 
@@ -865,7 +830,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 			 ctx->selected_flavor);
 		if (status)
 			return ERR_PTR(status);
-		return nfs_mod->rpc_ops->create_server(mount_info);
+		return ctx->nfs_mod->rpc_ops->create_server(fc);
 	}
 
 	/*
@@ -892,7 +857,7 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-		server = nfs_mod->rpc_ops->create_server(mount_info);
+		server = ctx->nfs_mod->rpc_ops->create_server(fc);
 		if (!IS_ERR(server))
 			return server;
 	}
@@ -908,23 +873,22 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	/* Last chance! Try AUTH_UNIX */
 	dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNIX);
 	ctx->selected_flavor = RPC_AUTH_UNIX;
-	return nfs_mod->rpc_ops->create_server(mount_info);
+	return ctx->nfs_mod->rpc_ops->create_server(fc);
 }
 
-static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
-
-struct dentry *nfs_try_mount(int flags, const char *dev_name,
-			     struct nfs_mount_info *mount_info)
+int nfs_try_get_tree(struct fs_context *fc)
 {
-	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
-	if (mount_info->ctx->need_mount)
-		mount_info->server = nfs_try_mount_request(mount_info);
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+
+	if (ctx->need_mount)
+		ctx->server = nfs_try_mount_request(fc);
 	else
-		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info);
+		ctx->server = ctx->nfs_mod->rpc_ops->create_server(fc);
 
-	return nfs_fs_mount_common(flags, dev_name, mount_info);
+	return nfs_get_tree_common(fc);
 }
-EXPORT_SYMBOL_GPL(nfs_try_mount);
+EXPORT_SYMBOL_GPL(nfs_try_get_tree);
+
 
 #define NFS_REMOUNT_CMP_FLAGMASK ~(NFS_MOUNT_INTR \
 		| NFS_MOUNT_SECURE \
@@ -965,15 +929,11 @@ nfs_compare_remount_data(struct nfs_server *nfss,
 	return 0;
 }
 
-int
-nfs_remount(struct super_block *sb, int *flags, char *raw_data)
+int nfs_reconfigure(struct fs_context *fc)
 {
-	int error;
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
+	struct super_block *sb = fc->root->d_sb;
 	struct nfs_server *nfss = sb->s_fs_info;
-	struct nfs_fs_context *ctx;
-	struct nfs_mount_data *options = (struct nfs_mount_data *)raw_data;
-	struct nfs4_mount_data *options4 = (struct nfs4_mount_data *)raw_data;
-	u32 nfsvers = nfss->nfs_client->rpc_ops->version;
 
 	sync_filesystem(sb);
 
@@ -983,64 +943,30 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 	 * ones were explicitly specified. Fall back to legacy behavior and
 	 * just return success.
 	 */
-	if ((nfsvers == 4 && (!options4 || options4->version == 1)) ||
-	    (nfsvers <= 3 && (!options || (options->version >= 1 &&
-					   options->version <= 6))))
+	if (ctx->skip_reconfig_option_check)
 		return 0;
 
-	ctx = nfs_alloc_parsed_mount_data();
-	if (ctx == NULL)
-		return -ENOMEM;
-
-	/* fill out struct with values from existing mount */
-	ctx->flags = nfss->flags;
-	ctx->rsize = nfss->rsize;
-	ctx->wsize = nfss->wsize;
-	ctx->retrans = nfss->client->cl_timeout->to_retries;
-	ctx->selected_flavor = nfss->client->cl_auth->au_flavor;
-	ctx->acregmin = nfss->acregmin / HZ;
-	ctx->acregmax = nfss->acregmax / HZ;
-	ctx->acdirmin = nfss->acdirmin / HZ;
-	ctx->acdirmax = nfss->acdirmax / HZ;
-	ctx->timeo = 10U * nfss->client->cl_timeout->to_initval / HZ;
-	ctx->nfs_server.port = nfss->port;
-	ctx->nfs_server.addrlen = nfss->nfs_client->cl_addrlen;
-	ctx->version = nfsvers;
-	ctx->minorversion = nfss->nfs_client->cl_minorversion;
-	ctx->net = current->nsproxy->net_ns;
-	memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
-		ctx->nfs_server.addrlen);
-
-	/* overwrite those values with any that were specified */
-	error = -EINVAL;
-	if (!nfs_parse_mount_options((char *)options, ctx))
-		goto out;
-
 	/*
 	 * noac is a special case. It implies -o sync, but that's not
-	 * necessarily reflected in the mtab options. do_remount_sb
+	 * necessarily reflected in the mtab options. reconfigure_super
 	 * will clear SB_SYNCHRONOUS if -o sync wasn't specified in the
 	 * remount options, so we have to explicitly reset it.
 	 */
-	if (ctx->flags & NFS_MOUNT_NOAC)
-		*flags |= SB_SYNCHRONOUS;
+	if (ctx->flags & NFS_MOUNT_NOAC) {
+		fc->sb_flags |= SB_SYNCHRONOUS;
+		fc->sb_flags_mask |= SB_SYNCHRONOUS;
+	}
 
 	/* compare new mount options with old ones */
-	error = nfs_compare_remount_data(nfss, ctx);
-	if (!error)
-		error = security_sb_remount(sb, ctx->lsm_opts);
-out:
-	nfs_free_parsed_mount_data(ctx);
-	return error;
+	return nfs_compare_remount_data(nfss, ctx);
 }
-EXPORT_SYMBOL_GPL(nfs_remount);
+EXPORT_SYMBOL_GPL(nfs_reconfigure);
 
 /*
  * Finish setting up an NFS superblock
  */
-static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
+static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 {
-	struct nfs_fs_context *ctx = mount_info->ctx;
 	struct nfs_server *server = NFS_SB(sb);
 
 	sb->s_blocksize_bits = 0;
@@ -1072,13 +998,14 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_
 	nfs_super_set_maxbytes(sb, server->maxfilesize);
 }
 
-static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b, int flags)
+static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b,
+				     const struct fs_context *fc)
 {
 	const struct nfs_server *a = s->s_fs_info;
 	const struct rpc_clnt *clnt_a = a->client;
 	const struct rpc_clnt *clnt_b = b->client;
 
-	if ((s->s_flags & NFS_MS_MASK) != (flags & NFS_MS_MASK))
+	if ((s->s_flags & NFS_SB_MASK) != (fc->sb_flags & NFS_SB_MASK))
 		goto Ebusy;
 	if (a->nfs_client != b->nfs_client)
 		goto Ebusy;
@@ -1103,19 +1030,11 @@ static int nfs_compare_mount_options(const struct super_block *s, const struct n
 	return 0;
 }
 
-struct nfs_sb_mountdata {
-	struct nfs_server *server;
-	int mntflags;
-};
-
-static int nfs_set_super(struct super_block *s, void *data)
+static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 {
-	struct nfs_sb_mountdata *sb_mntdata = data;
-	struct nfs_server *server = sb_mntdata->server;
+	struct nfs_server *server = fc->s_fs_info;
 	int ret;
 
-	s->s_flags = sb_mntdata->mntflags;
-	s->s_fs_info = server;
 	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
 	ret = set_anon_super(s, server);
 	if (ret == 0)
@@ -1180,11 +1099,9 @@ static int nfs_compare_userns(const struct nfs_server *old,
 	return 1;
 }
 
-static int nfs_compare_super(struct super_block *sb, void *data)
+static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct nfs_sb_mountdata *sb_mntdata = data;
-	struct nfs_server *server = sb_mntdata->server, *old = NFS_SB(sb);
-	int mntflags = sb_mntdata->mntflags;
+	struct nfs_server *server = fc->s_fs_info, *old = NFS_SB(sb);
 
 	if (!nfs_compare_super_address(old, server))
 		return 0;
@@ -1195,13 +1112,12 @@ static int nfs_compare_super(struct super_block *sb, void *data)
 		return 0;
 	if (!nfs_compare_userns(old, server))
 		return 0;
-	return nfs_compare_mount_options(sb, server, mntflags);
+	return nfs_compare_mount_options(sb, server, fc);
 }
 
 #ifdef CONFIG_NFS_FSCACHE
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *ctx,
-				 struct nfs_clone_mount *cloned)
+				 struct nfs_fs_context *ctx)
 {
 	struct nfs_server *nfss = NFS_SB(sb);
 	char *uniq = NULL;
@@ -1210,68 +1126,70 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 	nfss->fscache_key = NULL;
 	nfss->fscache = NULL;
 
-	if (ctx) {
+	if (!ctx)
+		return;
+
+	if (ctx->clone_data.sb) {
+		struct nfs_server *mnt_s = NFS_SB(ctx->clone_data.sb);
+		if (!(mnt_s->options & NFS_OPTION_FSCACHE))
+			return;
+		if (mnt_s->fscache_key) {
+			uniq = mnt_s->fscache_key->key.uniquifier;
+			ulen = mnt_s->fscache_key->key.uniq_len;
+		}
+	} else {
 		if (!(ctx->options & NFS_OPTION_FSCACHE))
 			return;
 		if (ctx->fscache_uniq) {
 			uniq = ctx->fscache_uniq;
 			ulen = strlen(ctx->fscache_uniq);
 		}
-	} else if (cloned) {
-		struct nfs_server *mnt_s = NFS_SB(cloned->sb);
-		if (!(mnt_s->options & NFS_OPTION_FSCACHE))
-			return;
-		if (mnt_s->fscache_key) {
-			uniq = mnt_s->fscache_key->key.uniquifier;
-			ulen = mnt_s->fscache_key->key.uniq_len;
-		};
-	} else
 		return;
+	}
 
 	nfs_fscache_get_super_cookie(sb, uniq, ulen);
 }
 #else
 static void nfs_get_cache_cookie(struct super_block *sb,
-				 struct nfs_fs_context *parsed,
-				 struct nfs_clone_mount *cloned)
+				 struct nfs_fs_context *ctx)
 {
 }
 #endif
 
-static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-				   struct nfs_mount_info *mount_info)
+int nfs_get_tree_common(struct fs_context *fc)
 {
+	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct super_block *s;
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
-	struct nfs_server *server = mount_info->server;
+	int (*compare_super)(struct super_block *, struct fs_context *) = nfs_compare_super;
+	struct nfs_server *server = ctx->server;
 	unsigned long kflags = 0, kflags_out = 0;
-	struct nfs_sb_mountdata sb_mntdata = {
-		.mntflags = flags,
-		.server = server,
-	};
 	int error;
 
-	mount_info->server = NULL;
+	ctx->server = NULL;
 	if (IS_ERR(server))
-		return ERR_CAST(server);
+		return PTR_ERR(server);
 
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
-		sb_mntdata.mntflags |= SB_SYNCHRONOUS;
+		fc->sb_flags |= SB_SYNCHRONOUS;
 
-	if (mount_info->cloned != NULL && mount_info->cloned->sb != NULL)
-		if (mount_info->cloned->sb->s_flags & SB_SYNCHRONOUS)
-			sb_mntdata.mntflags |= SB_SYNCHRONOUS;
+	if (ctx->clone_data.sb)
+		if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
+			fc->sb_flags |= SB_SYNCHRONOUS;
+
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		fc->lsm_flags |= SECURITY_LSM_NATIVE_LABELS;
 
 	/* Get a superblock - note that we may end up sharing one that already exists */
-	s = sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
-		 flags, &sb_mntdata);
+	fc->s_fs_info = server;
+	s = sget_fc(fc, compare_super, nfs_set_super);
+	fc->s_fs_info = NULL;
 	if (IS_ERR(s)) {
-		mntroot = ERR_CAST(s);
+		error = PTR_ERR(s);
+		dfprintk(MOUNT, "NFS: Couldn't get superblock\n");
 		goto out_err_nosb;
 	}
 
@@ -1281,44 +1199,41 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	} else {
 		error = super_setup_bdi_name(s, "%u:%u", MAJOR(server->s_dev),
 					     MINOR(server->s_dev));
-		if (error) {
-			mntroot = ERR_PTR(error);
+		if (error)
 			goto error_splat_super;
-		}
 		s->s_bdi->ra_pages = server->rpages * NFS_MAX_READAHEAD;
 		server->super = s;
 	}
 
 	if (!s->s_root) {
-		unsigned bsize = mount_info->inherited_bsize;
+		unsigned bsize = ctx->clone_data.inherited_bsize;
 		/* initial superblock/root creation */
-		nfs_fill_super(s, mount_info);
+		nfs_fill_super(s, ctx);
 		if (bsize) {
 			s->s_blocksize_bits = bsize;
 			s->s_blocksize = 1U << bsize;
 		}
-		nfs_get_cache_cookie(s, mount_info->ctx, mount_info->cloned);
-		if (!(server->flags & NFS_MOUNT_UNSHARED))
-			s->s_iflags |= SB_I_MULTIROOT;
+		nfs_get_cache_cookie(s, ctx);
 	}
 
-	mntroot = nfs_get_root(s, mount_info->mntfh, dev_name);
-	if (IS_ERR(mntroot))
+	error = nfs_get_root(s, fc);
+	if (error < 0) {
+		dfprintk(MOUNT, "NFS: Couldn't get root dentry\n");
 		goto error_splat_super;
-
+	}
 
 	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;
-	if (mount_info->cloned) {
-		if (d_inode(mntroot)->i_fop != &nfs_dir_operations) {
+	if (ctx->clone_data.sb) {
+		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
 			error = -ESTALE;
 			goto error_splat_root;
 		}
 		/* clone any lsm security options from the parent to the new sb */
-		error = security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
+		error = security_sb_clone_mnt_opts(ctx->clone_data.sb, s, kflags,
 				&kflags_out);
 	} else {
-		error = security_sb_set_mnt_opts(s, mount_info->ctx->lsm_opts,
+		error = security_sb_set_mnt_opts(s, fc->security,
 							kflags, &kflags_out);
 	}
 	if (error)
@@ -1326,67 +1241,25 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
-	if (error)
-		goto error_splat_root;
 
 	s->s_flags |= SB_ACTIVE;
+	error = 0;
 
 out:
-	return mntroot;
+	return error;
 
 out_err_nosb:
 	nfs_free_server(server);
 	goto out;
 
 error_splat_root:
-	dput(mntroot);
-	mntroot = ERR_PTR(error);
+	dput(fc->root);
+	fc->root = NULL;
 error_splat_super:
 	deactivate_locked_super(s);
 	goto out;
 }
 
-struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data)
-{
-	struct nfs_mount_info mount_info = {
-	};
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-	struct nfs_subversion *nfs_mod;
-	int error;
-
-	mount_info.ctx = nfs_alloc_parsed_mount_data();
-	mount_info.mntfh = nfs_alloc_fhandle();
-	if (mount_info.ctx == NULL || mount_info.mntfh == NULL)
-		goto out;
-
-	/* Validate the mount data */
-	error = nfs_validate_mount_data(fs_type, raw_data, mount_info.ctx, mount_info.mntfh, dev_name);
-	if (error == NFS_TEXT_DATA)
-		error = nfs_validate_text_mount_data(raw_data,
-						     mount_info.ctx, dev_name);
-	if (error < 0) {
-		mntroot = ERR_PTR(error);
-		goto out;
-	}
-
-	nfs_mod = get_nfs_version(mount_info.ctx->version);
-	if (IS_ERR(nfs_mod)) {
-		mntroot = ERR_CAST(nfs_mod);
-		goto out;
-	}
-	mount_info.nfs_mod = nfs_mod;
-
-	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
-
-	put_nfs_version(nfs_mod);
-out:
-	nfs_free_parsed_mount_data(mount_info.ctx);
-	nfs_free_fhandle(mount_info.mntfh);
-	return mntroot;
-}
-EXPORT_SYMBOL_GPL(nfs_fs_mount);
-
 /*
  * Destroy an NFS2/3 superblock
  */
@@ -1404,17 +1277,6 @@ void nfs_kill_super(struct super_block *s)
 }
 EXPORT_SYMBOL_GPL(nfs_kill_super);
 
-/*
- * Internal use only: mount_info is already set up by caller.
- * Used for mountpoint crossings and for nfs4 root.
- */
-static struct dentry *
-nfs_prepared_mount(struct file_system_type *fs_type, int flags,
-		   const char *dev_name, void *raw_data)
-{
-	return nfs_fs_mount_common(flags, dev_name, raw_data);
-}
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 /*
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 82bdb91da2ae..ed9f215d03ea 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1622,6 +1622,7 @@ struct nfs_subversion;
 struct nfs_mount_info;
 struct nfs_client_initdata;
 struct nfs_pageio_descriptor;
+struct fs_context;
 
 /*
  * RPC procedure vector for NFSv2/NFSv3 demuxing
@@ -1636,9 +1637,8 @@ struct nfs_rpc_ops {
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fsinfo *);
-	struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
-				      struct nfs_fh *, struct nfs_fattr *);
-	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *);
+	int	(*submount) (struct fs_context *, struct nfs_server *);
+	int	(*try_get_tree) (struct fs_context *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *,
 			    struct inode *);
@@ -1705,7 +1705,7 @@ struct nfs_rpc_ops {
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
 	void	(*free_client) (struct nfs_client *);
-	struct nfs_server *(*create_server)(struct nfs_mount_info *);
+	struct nfs_server *(*create_server)(struct fs_context *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
 };
-- 
2.17.2

