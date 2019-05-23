Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A604282B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfEWQTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfEWQTA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:19:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4300F307C945;
        Thu, 23 May 2019 16:19:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82C89BA57;
        Thu, 23 May 2019 16:18:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/23] NFS: Do some tidying of the parsing code
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:57 +0100
Message-ID: <155862833769.26654.15400933665829349780.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 16:19:00 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do some tidying of the parsing code, including:

 (*) Returning 0/error rather than true/false.

 (*) Putting the nfs_fs_context pointer first in some arg lists.

 (*) Unwrap some lines that will now fit on one line.

 (*) Provide unioned sockaddr/sockaddr_storage fields to avoid casts.

 (*) nfs_parse_devname() can paste its return values directly into the
     nfs_fs_context struct as that's where the caller puts them.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/fs_context.c |  128 ++++++++++++++++++++++-----------------------------
 fs/nfs/internal.h   |   16 ++++--
 fs/nfs/super.c      |    2 -
 3 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 5ba534127c0b..3afacdee37c8 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -342,8 +342,9 @@ static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
  * Add 'flavor' to 'auth_info' if not already present.
  * Returns true if 'flavor' ends up in the list, false otherwise
  */
-static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
-			      rpc_authflavor_t flavor)
+static int nfs_auth_info_add(struct nfs_fs_context *ctx,
+			     struct nfs_auth_info *auth_info,
+			     rpc_authflavor_t flavor)
 {
 	unsigned int i;
 	unsigned int max_flavor_len = ARRAY_SIZE(auth_info->flavors);
@@ -351,26 +352,27 @@ static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
 	/* make sure this flavor isn't already in the list */
 	for (i = 0; i < auth_info->flavor_len; i++) {
 		if (flavor == auth_info->flavors[i])
-			return true;
+			return 0;
 	}
 
 	if (auth_info->flavor_len + 1 >= max_flavor_len) {
 		dfprintk(MOUNT, "NFS: too many sec= flavors\n");
-		return false;
+		return -EINVAL;
 	}
 
 	auth_info->flavors[auth_info->flavor_len++] = flavor;
-	return true;
+	return 0;
 }
 
 /*
  * Parse the value of the 'sec=' option.
  */
-static int nfs_parse_security_flavors(char *value, struct nfs_fs_context *ctx)
+static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
 {
 	substring_t args[MAX_OPT_ARGS];
 	rpc_authflavor_t pseudoflavor;
 	char *p;
+	int ret;
 
 	dfprintk(MOUNT, "NFS: parsing sec=%s option\n", value);
 
@@ -412,19 +414,20 @@ static int nfs_parse_security_flavors(char *value, struct nfs_fs_context *ctx)
 		default:
 			dfprintk(MOUNT,
 				 "NFS: sec= option '%s' not recognized\n", p);
-			return 0;
+			return -EINVAL;
 		}
 
-		if (!nfs_auth_info_add(&ctx->auth_info, pseudoflavor))
-			return 0;
+		ret = nfs_auth_info_add(ctx, &ctx->auth_info, pseudoflavor);
+		if (ret < 0)
+			return ret;
 	}
 
-	return 1;
+	return 0;
 }
 
-static int nfs_parse_version_string(char *string,
-		struct nfs_fs_context *ctx,
-		substring_t *args)
+static int nfs_parse_version_string(struct nfs_fs_context *ctx,
+				    char *string,
+				    substring_t *args)
 {
 	ctx->flags &= ~NFS_MOUNT_VER3;
 	switch (match_token(string, nfs_vers_tokens, args)) {
@@ -455,9 +458,10 @@ static int nfs_parse_version_string(char *string,
 		ctx->minorversion = 2;
 		break;
 	default:
-		return 0;
+		dfprintk(MOUNT, "NFS:   Unsupported NFS version\n");
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static int nfs_get_option_str(substring_t args[], char **option)
@@ -496,7 +500,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *string;
-	int token, rc;
+	int token, ret;
 
 	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
 
@@ -536,13 +540,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		break;
 	case Opt_lock:
 		ctx->flags &= ~NFS_MOUNT_NONLM;
-		ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
-				NFS_MOUNT_LOCAL_FCNTL);
+		ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 		break;
 	case Opt_nolock:
 		ctx->flags |= NFS_MOUNT_NONLM;
-		ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
-			       NFS_MOUNT_LOCAL_FCNTL);
+		ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 		break;
 	case Opt_udp:
 		ctx->flags &= ~NFS_MOUNT_TCP;
@@ -675,29 +677,25 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		rc = nfs_parse_version_string(string, ctx, args);
+		ret = nfs_parse_version_string(ctx, string, args);
 		kfree(string);
-		if (!rc)
-			goto out_invalid_value;
+		if (ret < 0)
+			return ret;
 		break;
 	case Opt_sec:
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		rc = nfs_parse_security_flavors(string, ctx);
+		ret = nfs_parse_security_flavors(ctx, string);
 		kfree(string);
-		if (!rc) {
-			dfprintk(MOUNT, "NFS:   unrecognized "
-				 "security flavor\n");
-			return -EINVAL;
-		}
+		if (ret < 0)
+			return ret;
 		break;
 	case Opt_proto:
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		token = match_token(string,
-				    nfs_xprt_protocol_tokens, args);
+		token = match_token(string, nfs_xprt_protocol_tokens, args);
 
 		ctx->protofamily = AF_INET;
 		switch (token) {
@@ -725,9 +723,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			xprt_load_transport(string);
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:   unrecognized "
-				 "transport protocol\n");
 			kfree(string);
+			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 			return -EINVAL;
 		}
 		kfree(string);
@@ -736,8 +733,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		token = match_token(string,
-				    nfs_xprt_protocol_tokens, args);
+		token = match_token(string, nfs_xprt_protocol_tokens, args);
 		kfree(string);
 
 		ctx->mountfamily = AF_INET;
@@ -756,8 +752,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			break;
 		case Opt_xprt_rdma: /* not used for side protocols */
 		default:
-			dfprintk(MOUNT, "NFS:   unrecognized "
-				 "transport protocol\n");
+			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 			return -EINVAL;
 		}
 		break;
@@ -767,9 +762,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			goto out_nomem;
 		ctx->nfs_server.addrlen =
 			rpc_pton(ctx->net, string, strlen(string),
-				 (struct sockaddr *)
 				 &ctx->nfs_server.address,
-				 sizeof(ctx->nfs_server.address));
+				 sizeof(ctx->nfs_server._address));
 		kfree(string);
 		if (ctx->nfs_server.addrlen == 0)
 			goto out_invalid_address;
@@ -779,8 +773,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			goto out_nomem;
 		break;
 	case Opt_mounthost:
-		if (nfs_get_option_str(args,
-				       &ctx->mount_server.hostname))
+		if (nfs_get_option_str(args, &ctx->mount_server.hostname))
 			goto out_nomem;
 		break;
 	case Opt_mountaddr:
@@ -789,9 +782,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			goto out_nomem;
 		ctx->mount_server.addrlen =
 			rpc_pton(ctx->net, string, strlen(string),
-				 (struct sockaddr *)
 				 &ctx->mount_server.address,
-				 sizeof(ctx->mount_server.address));
+				 sizeof(ctx->mount_server._address));
 		kfree(string);
 		if (ctx->mount_server.addrlen == 0)
 			goto out_invalid_address;
@@ -800,8 +792,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		token = match_token(string,
-				    nfs_lookupcache_tokens, args);
+		token = match_token(string, nfs_lookupcache_tokens, args);
 		kfree(string);
 		switch (token) {
 		case Opt_lookupcache_all:
@@ -815,10 +806,9 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:   invalid "
-				 "lookupcache argument\n");
+			dfprintk(MOUNT, "NFS:   invalid lookupcache argument\n");
 			return -EINVAL;
-		};
+		}
 		break;
 	case Opt_fscache_uniq:
 		if (nfs_get_option_str(args, &ctx->fscache_uniq))
@@ -829,8 +819,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		string = match_strdup(args);
 		if (string == NULL)
 			goto out_nomem;
-		token = match_token(string, nfs_local_lock_tokens,
-				    args);
+		token = match_token(string, nfs_local_lock_tokens, args);
 		kfree(string);
 		switch (token) {
 		case Opt_local_lock_all:
@@ -848,8 +837,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 					NFS_MOUNT_LOCAL_FCNTL);
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:	invalid	"
-				 "local_lock argument\n");
+			dfprintk(MOUNT, "NFS:	invalid	local_lock argument\n");
 			return -EINVAL;
 		};
 		break;
@@ -863,13 +851,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		break;
 	case Opt_userspace:
 	case Opt_deprecated:
-		dfprintk(MOUNT, "NFS:   ignoring mount option "
-			 "'%s'\n", p);
+		dfprintk(MOUNT, "NFS:   ignoring mount option '%s'\n", p);
 		break;
 
 	default:
-		dfprintk(MOUNT, "NFS:   unrecognized mount option "
-			 "'%s'\n", p);
+		dfprintk(MOUNT, "NFS:   unrecognized mount option '%s'\n", p);
 		return -EINVAL;
 	}
 
@@ -929,15 +915,15 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 	 * families in the addr=/mountaddr= options.
 	 */
 	if (ctx->protofamily != AF_UNSPEC &&
-	    ctx->protofamily != ctx->nfs_server.address.ss_family)
+	    ctx->protofamily != ctx->nfs_server.address.sa_family)
 		goto out_proto_mismatch;
 
 	if (ctx->mountfamily != AF_UNSPEC) {
 		if (ctx->mount_server.addrlen) {
-			if (ctx->mountfamily != ctx->mount_server.address.ss_family)
+			if (ctx->mountfamily != ctx->mount_server.address.sa_family)
 				goto out_mountproto_mismatch;
 		} else {
-			if (ctx->mountfamily != ctx->nfs_server.address.ss_family)
+			if (ctx->mountfamily != ctx->nfs_server.address.sa_family)
 				goto out_mountproto_mismatch;
 		}
 	}
@@ -973,9 +959,9 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
  *
  * Note: caller frees hostname and export path, even on error.
  */
-static int nfs_parse_devname(const char *dev_name,
-			     char **hostname, size_t maxnamlen,
-			     char **export_path, size_t maxpathlen)
+static int nfs_parse_devname(struct nfs_fs_context *ctx,
+			     const char *dev_name,
+			     size_t maxnamlen, size_t maxpathlen)
 {
 	size_t len;
 	char *end;
@@ -1011,17 +997,17 @@ static int nfs_parse_devname(const char *dev_name,
 		goto out_hostname;
 
 	/* N.B. caller will free nfs_server.hostname in all cases */
-	*hostname = kstrndup(dev_name, len, GFP_KERNEL);
-	if (*hostname == NULL)
+	ctx->nfs_server.hostname = kmemdup_nul(dev_name, len, GFP_KERNEL);
+	if (!ctx->nfs_server.hostname)
 		goto out_nomem;
 	len = strlen(++end);
 	if (len > maxpathlen)
 		goto out_path;
-	*export_path = kstrndup(end, len, GFP_KERNEL);
-	if (!*export_path)
+	ctx->nfs_server.export_path = kmemdup_nul(end, len, GFP_KERNEL);
+	if (!ctx->nfs_server.export_path)
 		goto out_nomem;
 
-	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
+	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", ctx->nfs_server.export_path);
 	return 0;
 
 out_bad_devname:
@@ -1042,7 +1028,7 @@ static int nfs_parse_devname(const char *dev_name,
 }
 
 /*
- * Validate the NFS2/NFS3 mount data
+ * Parse monolithic NFS2/NFS3 mount data
  * - fills in the mount root filehandle
  *
  * For option strings, user space handles the following behaviors:
@@ -1371,11 +1357,7 @@ int nfs_validate_text_mount_data(void *options,
  
 	nfs_set_port(sap, &ctx->nfs_server.port, port);
 
-	return nfs_parse_devname(dev_name,
-				   &ctx->nfs_server.hostname,
-				   max_namelen,
-				   &ctx->nfs_server.export_path,
-				   max_pathlen);
+	return nfs_parse_devname(ctx, dev_name, max_namelen, max_pathlen);
 
 #if !IS_ENABLED(CONFIG_NFS_V4)
 out_v4_not_compiled:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6efdbedeeee8..481f370ab053 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -90,11 +90,11 @@ struct nfs_client_initdata {
  * In-kernel mount arguments
  */
 struct nfs_fs_context {
-	int			flags;
+	unsigned int		flags;		/* NFS{,4}_MOUNT_* flags */
 	unsigned int		rsize, wsize;
 	unsigned int		timeo, retrans;
-	unsigned int		acregmin, acregmax,
-				acdirmin, acdirmax;
+	unsigned int		acregmin, acregmax;
+	unsigned int		acdirmin, acdirmax;
 	unsigned int		namlen;
 	unsigned int		options;
 	unsigned int		bsize;
@@ -110,7 +110,10 @@ struct nfs_fs_context {
 	bool			sloppy;
 
 	struct {
-		struct sockaddr_storage	address;
+		union {
+			struct sockaddr	address;
+			struct sockaddr_storage	_address;
+		};
 		size_t			addrlen;
 		char			*hostname;
 		u32			version;
@@ -119,7 +122,10 @@ struct nfs_fs_context {
 	} mount_server;
 
 	struct {
-		struct sockaddr_storage	address;
+		union {
+			struct sockaddr	address;
+			struct sockaddr_storage	_address;
+		};
 		size_t			addrlen;
 		char			*hostname;
 		char			*export_path;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d7f99526ee73..5c8cf0e35141 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -804,7 +804,7 @@ static int nfs_request_mount(struct nfs_fs_context *cfg,
 	/*
 	 * Construct the mount server's address.
 	 */
-	if (cfg->mount_server.address.ss_family == AF_UNSPEC) {
+	if (cfg->mount_server.address.sa_family == AF_UNSPEC) {
 		memcpy(request.sap, &cfg->nfs_server.address,
 		       cfg->nfs_server.addrlen);
 		cfg->mount_server.addrlen = cfg->nfs_server.addrlen;

