Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30B282AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfEWQSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbfEWQSp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B161487645;
        Thu, 23 May 2019 16:18:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC402E043;
        Thu, 23 May 2019 16:18:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/23] NFS: Deindent nfs_fs_context_parse_option()
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:41 +0100
Message-ID: <155862832180.26654.11735963506085471355.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 23 May 2019 16:18:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deindent nfs_fs_context_parse_option().

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/fs_context.c |  729 +++++++++++++++++++++++++--------------------------
 1 file changed, 362 insertions(+), 367 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index f4e04721363f..c7796fb76732 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -499,405 +499,400 @@ static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
  */
 static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 {
+	substring_t args[MAX_OPT_ARGS];
+	unsigned long option;
 	char *string;
-	int rc;
-
-	{
-		substring_t args[MAX_OPT_ARGS];
-		unsigned long option;
-		int token;
+	int token, rc;
 
-		dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
-
-		token = match_token(p, nfs_mount_option_tokens, args);
-		switch (token) {
+	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
 
+	token = match_token(p, nfs_mount_option_tokens, args);
+	switch (token) {
 		/*
 		 * boolean options:  foo/nofoo
 		 */
-		case Opt_soft:
-			ctx->flags |= NFS_MOUNT_SOFT;
-			ctx->flags &= ~NFS_MOUNT_SOFTERR;
-			break;
-		case Opt_softerr:
-			ctx->flags |= NFS_MOUNT_SOFTERR;
-			ctx->flags &= ~NFS_MOUNT_SOFT;
-			break;
-		case Opt_hard:
-			ctx->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
-			break;
-		case Opt_posix:
-			ctx->flags |= NFS_MOUNT_POSIX;
-			break;
-		case Opt_noposix:
-			ctx->flags &= ~NFS_MOUNT_POSIX;
-			break;
-		case Opt_cto:
-			ctx->flags &= ~NFS_MOUNT_NOCTO;
-			break;
-		case Opt_nocto:
-			ctx->flags |= NFS_MOUNT_NOCTO;
-			break;
-		case Opt_ac:
-			ctx->flags &= ~NFS_MOUNT_NOAC;
-			break;
-		case Opt_noac:
-			ctx->flags |= NFS_MOUNT_NOAC;
-			break;
-		case Opt_lock:
-			ctx->flags &= ~NFS_MOUNT_NONLM;
-			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
-					NFS_MOUNT_LOCAL_FCNTL);
-			break;
-		case Opt_nolock:
-			ctx->flags |= NFS_MOUNT_NONLM;
-			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
-				       NFS_MOUNT_LOCAL_FCNTL);
-			break;
-		case Opt_udp:
-			ctx->flags &= ~NFS_MOUNT_TCP;
-			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
-			break;
-		case Opt_tcp:
-			ctx->flags |= NFS_MOUNT_TCP;
-			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
-			break;
-		case Opt_rdma:
-			ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
-			ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-			xprt_load_transport(p);
-			break;
-		case Opt_acl:
-			ctx->flags &= ~NFS_MOUNT_NOACL;
-			break;
-		case Opt_noacl:
-			ctx->flags |= NFS_MOUNT_NOACL;
-			break;
-		case Opt_rdirplus:
-			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
-			break;
-		case Opt_nordirplus:
-			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
-			break;
-		case Opt_sharecache:
-			ctx->flags &= ~NFS_MOUNT_UNSHARED;
-			break;
-		case Opt_nosharecache:
-			ctx->flags |= NFS_MOUNT_UNSHARED;
-			break;
-		case Opt_resvport:
-			ctx->flags &= ~NFS_MOUNT_NORESVPORT;
-			break;
-		case Opt_noresvport:
-			ctx->flags |= NFS_MOUNT_NORESVPORT;
-			break;
-		case Opt_fscache:
-			ctx->options |= NFS_OPTION_FSCACHE;
-			kfree(ctx->fscache_uniq);
-			ctx->fscache_uniq = NULL;
-			break;
-		case Opt_nofscache:
-			ctx->options &= ~NFS_OPTION_FSCACHE;
-			kfree(ctx->fscache_uniq);
-			ctx->fscache_uniq = NULL;
-			break;
-		case Opt_migration:
-			ctx->options |= NFS_OPTION_MIGRATION;
-			break;
-		case Opt_nomigration:
-			ctx->options &= ~NFS_OPTION_MIGRATION;
-			break;
+	case Opt_soft:
+		ctx->flags |= NFS_MOUNT_SOFT;
+		ctx->flags &= ~NFS_MOUNT_SOFTERR;
+		break;
+	case Opt_softerr:
+		ctx->flags |= NFS_MOUNT_SOFTERR;
+		ctx->flags &= ~NFS_MOUNT_SOFT;
+		break;
+	case Opt_hard:
+		ctx->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+		break;
+	case Opt_posix:
+		ctx->flags |= NFS_MOUNT_POSIX;
+		break;
+	case Opt_noposix:
+		ctx->flags &= ~NFS_MOUNT_POSIX;
+		break;
+	case Opt_cto:
+		ctx->flags &= ~NFS_MOUNT_NOCTO;
+		break;
+	case Opt_nocto:
+		ctx->flags |= NFS_MOUNT_NOCTO;
+		break;
+	case Opt_ac:
+		ctx->flags &= ~NFS_MOUNT_NOAC;
+		break;
+	case Opt_noac:
+		ctx->flags |= NFS_MOUNT_NOAC;
+		break;
+	case Opt_lock:
+		ctx->flags &= ~NFS_MOUNT_NONLM;
+		ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
+				NFS_MOUNT_LOCAL_FCNTL);
+		break;
+	case Opt_nolock:
+		ctx->flags |= NFS_MOUNT_NONLM;
+		ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
+			       NFS_MOUNT_LOCAL_FCNTL);
+		break;
+	case Opt_udp:
+		ctx->flags &= ~NFS_MOUNT_TCP;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
+		break;
+	case Opt_tcp:
+		ctx->flags |= NFS_MOUNT_TCP;
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
+		break;
+	case Opt_rdma:
+		ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
+		ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
+		xprt_load_transport(p);
+		break;
+	case Opt_acl:
+		ctx->flags &= ~NFS_MOUNT_NOACL;
+		break;
+	case Opt_noacl:
+		ctx->flags |= NFS_MOUNT_NOACL;
+		break;
+	case Opt_rdirplus:
+		ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
+		break;
+	case Opt_nordirplus:
+		ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+		break;
+	case Opt_sharecache:
+		ctx->flags &= ~NFS_MOUNT_UNSHARED;
+		break;
+	case Opt_nosharecache:
+		ctx->flags |= NFS_MOUNT_UNSHARED;
+		break;
+	case Opt_resvport:
+		ctx->flags &= ~NFS_MOUNT_NORESVPORT;
+		break;
+	case Opt_noresvport:
+		ctx->flags |= NFS_MOUNT_NORESVPORT;
+		break;
+	case Opt_fscache:
+		ctx->options |= NFS_OPTION_FSCACHE;
+		kfree(ctx->fscache_uniq);
+		ctx->fscache_uniq = NULL;
+		break;
+	case Opt_nofscache:
+		ctx->options &= ~NFS_OPTION_FSCACHE;
+		kfree(ctx->fscache_uniq);
+		ctx->fscache_uniq = NULL;
+		break;
+	case Opt_migration:
+		ctx->options |= NFS_OPTION_MIGRATION;
+		break;
+	case Opt_nomigration:
+		ctx->options &= ~NFS_OPTION_MIGRATION;
+		break;
 
 		/*
 		 * options that take numeric values
 		 */
-		case Opt_port:
-			if (nfs_get_option_ul(args, &option) ||
-			    option > USHRT_MAX)
-				goto out_invalid_value;
-			ctx->nfs_server.port = option;
-			break;
-		case Opt_rsize:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->rsize = option;
-			break;
-		case Opt_wsize:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->wsize = option;
-			break;
-		case Opt_bsize:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->bsize = option;
-			break;
-		case Opt_timeo:
-			if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
-				goto out_invalid_value;
-			ctx->timeo = option;
-			break;
-		case Opt_retrans:
-			if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
-				goto out_invalid_value;
-			ctx->retrans = option;
-			break;
-		case Opt_acregmin:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->acregmin = option;
-			break;
-		case Opt_acregmax:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->acregmax = option;
-			break;
-		case Opt_acdirmin:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->acdirmin = option;
-			break;
-		case Opt_acdirmax:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->acdirmax = option;
-			break;
-		case Opt_actimeo:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->acregmin = ctx->acregmax =
+	case Opt_port:
+		if (nfs_get_option_ul(args, &option) ||
+		    option > USHRT_MAX)
+			goto out_invalid_value;
+		ctx->nfs_server.port = option;
+		break;
+	case Opt_rsize:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->rsize = option;
+		break;
+	case Opt_wsize:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->wsize = option;
+		break;
+	case Opt_bsize:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->bsize = option;
+		break;
+	case Opt_timeo:
+		if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
+			goto out_invalid_value;
+		ctx->timeo = option;
+		break;
+	case Opt_retrans:
+		if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
+			goto out_invalid_value;
+		ctx->retrans = option;
+		break;
+	case Opt_acregmin:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->acregmin = option;
+		break;
+	case Opt_acregmax:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->acregmax = option;
+		break;
+	case Opt_acdirmin:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->acdirmin = option;
+		break;
+	case Opt_acdirmax:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->acdirmax = option;
+		break;
+	case Opt_actimeo:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->acregmin = ctx->acregmax =
 			ctx->acdirmin = ctx->acdirmax = option;
-			break;
-		case Opt_namelen:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			ctx->namlen = option;
-			break;
-		case Opt_mountport:
-			if (nfs_get_option_ul(args, &option) ||
-			    option > USHRT_MAX)
-				goto out_invalid_value;
-			ctx->mount_server.port = option;
-			break;
-		case Opt_mountvers:
-			if (nfs_get_option_ul(args, &option) ||
-			    option < NFS_MNT_VERSION ||
-			    option > NFS_MNT3_VERSION)
-				goto out_invalid_value;
-			ctx->mount_server.version = option;
-			break;
-		case Opt_minorversion:
-			if (nfs_get_option_ul(args, &option))
-				goto out_invalid_value;
-			if (option > NFS4_MAX_MINOR_VERSION)
-				goto out_invalid_value;
-			ctx->minorversion = option;
-			break;
+		break;
+	case Opt_namelen:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		ctx->namlen = option;
+		break;
+	case Opt_mountport:
+		if (nfs_get_option_ul(args, &option) ||
+		    option > USHRT_MAX)
+			goto out_invalid_value;
+		ctx->mount_server.port = option;
+		break;
+	case Opt_mountvers:
+		if (nfs_get_option_ul(args, &option) ||
+		    option < NFS_MNT_VERSION ||
+		    option > NFS_MNT3_VERSION)
+			goto out_invalid_value;
+		ctx->mount_server.version = option;
+		break;
+	case Opt_minorversion:
+		if (nfs_get_option_ul(args, &option))
+			goto out_invalid_value;
+		if (option > NFS4_MAX_MINOR_VERSION)
+			goto out_invalid_value;
+		ctx->minorversion = option;
+		break;
 
 		/*
 		 * options that take text values
 		 */
-		case Opt_nfsvers:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			rc = nfs_parse_version_string(string, ctx, args);
-			kfree(string);
-			if (!rc)
-				goto out_invalid_value;
+	case Opt_nfsvers:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		rc = nfs_parse_version_string(string, ctx, args);
+		kfree(string);
+		if (!rc)
+			goto out_invalid_value;
+		break;
+	case Opt_sec:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		rc = nfs_parse_security_flavors(string, ctx);
+		kfree(string);
+		if (!rc) {
+			dfprintk(MOUNT, "NFS:   unrecognized "
+				 "security flavor\n");
+			return -EINVAL;
+		}
+		break;
+	case Opt_proto:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		token = match_token(string,
+				    nfs_xprt_protocol_tokens, args);
+
+		ctx->protofamily = AF_INET;
+		switch (token) {
+		case Opt_xprt_udp6:
+			ctx->protofamily = AF_INET6;
+			/* fall through */
+		case Opt_xprt_udp:
+			ctx->flags &= ~NFS_MOUNT_TCP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
-		case Opt_sec:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			rc = nfs_parse_security_flavors(string, ctx);
-			kfree(string);
-			if (!rc) {
-				dfprintk(MOUNT, "NFS:   unrecognized "
-						"security flavor\n");
-				return -EINVAL;
-			}
+		case Opt_xprt_tcp6:
+			ctx->protofamily = AF_INET6;
+			/* fall through */
+		case Opt_xprt_tcp:
+			ctx->flags |= NFS_MOUNT_TCP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
-		case Opt_proto:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			token = match_token(string,
-					    nfs_xprt_protocol_tokens, args);
-
-			ctx->protofamily = AF_INET;
-			switch (token) {
-			case Opt_xprt_udp6:
-				ctx->protofamily = AF_INET6;
-				/* fall through */
-			case Opt_xprt_udp:
-				ctx->flags &= ~NFS_MOUNT_TCP;
-				ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
-				break;
-			case Opt_xprt_tcp6:
-				ctx->protofamily = AF_INET6;
-				/* fall through */
-			case Opt_xprt_tcp:
-				ctx->flags |= NFS_MOUNT_TCP;
-				ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
-				break;
-			case Opt_xprt_rdma6:
-				ctx->protofamily = AF_INET6;
-				/* fall through */
-			case Opt_xprt_rdma:
-				/* vector side protocols to TCP */
-				ctx->flags |= NFS_MOUNT_TCP;
-				ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-				xprt_load_transport(string);
-				break;
-			default:
-				dfprintk(MOUNT, "NFS:   unrecognized "
-						"transport protocol\n");
-				kfree(string);
-				return -EINVAL;
-			}
-			kfree(string);
+		case Opt_xprt_rdma6:
+			ctx->protofamily = AF_INET6;
+			/* fall through */
+		case Opt_xprt_rdma:
+			/* vector side protocols to TCP */
+			ctx->flags |= NFS_MOUNT_TCP;
+			ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
+			xprt_load_transport(string);
 			break;
-		case Opt_mountproto:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			token = match_token(string,
-					    nfs_xprt_protocol_tokens, args);
+		default:
+			dfprintk(MOUNT, "NFS:   unrecognized "
+				 "transport protocol\n");
 			kfree(string);
+			return -EINVAL;
+		}
+		kfree(string);
+		break;
+	case Opt_mountproto:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		token = match_token(string,
+				    nfs_xprt_protocol_tokens, args);
+		kfree(string);
 
-			ctx->mountfamily = AF_INET;
-			switch (token) {
-			case Opt_xprt_udp6:
-				ctx->mountfamily = AF_INET6;
-				/* fall through */
-			case Opt_xprt_udp:
-				ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
-				break;
-			case Opt_xprt_tcp6:
-				ctx->mountfamily = AF_INET6;
-				/* fall through */
-			case Opt_xprt_tcp:
-				ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
-				break;
-			case Opt_xprt_rdma: /* not used for side protocols */
-			default:
-				dfprintk(MOUNT, "NFS:   unrecognized "
-						"transport protocol\n");
-				return -EINVAL;
-			}
-			break;
-		case Opt_addr:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			ctx->nfs_server.addrlen =
-				rpc_pton(ctx->net, string, strlen(string),
-					(struct sockaddr *)
-					&ctx->nfs_server.address,
-					sizeof(ctx->nfs_server.address));
-			kfree(string);
-			if (ctx->nfs_server.addrlen == 0)
-				goto out_invalid_address;
+		ctx->mountfamily = AF_INET;
+		switch (token) {
+		case Opt_xprt_udp6:
+			ctx->mountfamily = AF_INET6;
+			/* fall through */
+		case Opt_xprt_udp:
+			ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
+			break;
+		case Opt_xprt_tcp6:
+			ctx->mountfamily = AF_INET6;
+			/* fall through */
+		case Opt_xprt_tcp:
+			ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
+			break;
+		case Opt_xprt_rdma: /* not used for side protocols */
+		default:
+			dfprintk(MOUNT, "NFS:   unrecognized "
+				 "transport protocol\n");
+			return -EINVAL;
+		}
+		break;
+	case Opt_addr:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		ctx->nfs_server.addrlen =
+			rpc_pton(ctx->net, string, strlen(string),
+				 (struct sockaddr *)
+				 &ctx->nfs_server.address,
+				 sizeof(ctx->nfs_server.address));
+		kfree(string);
+		if (ctx->nfs_server.addrlen == 0)
+			goto out_invalid_address;
+		break;
+	case Opt_clientaddr:
+		if (nfs_get_option_str(args, &ctx->client_address))
+			goto out_nomem;
+		break;
+	case Opt_mounthost:
+		if (nfs_get_option_str(args,
+				       &ctx->mount_server.hostname))
+			goto out_nomem;
+		break;
+	case Opt_mountaddr:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		ctx->mount_server.addrlen =
+			rpc_pton(ctx->net, string, strlen(string),
+				 (struct sockaddr *)
+				 &ctx->mount_server.address,
+				 sizeof(ctx->mount_server.address));
+		kfree(string);
+		if (ctx->mount_server.addrlen == 0)
+			goto out_invalid_address;
+		break;
+	case Opt_lookupcache:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		token = match_token(string,
+				    nfs_lookupcache_tokens, args);
+		kfree(string);
+		switch (token) {
+		case Opt_lookupcache_all:
+			ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
 			break;
-		case Opt_clientaddr:
-			if (nfs_get_option_str(args, &ctx->client_address))
-				goto out_nomem;
+		case Opt_lookupcache_positive:
+			ctx->flags &= ~NFS_MOUNT_LOOKUP_CACHE_NONE;
+			ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG;
 			break;
-		case Opt_mounthost:
-			if (nfs_get_option_str(args,
-					       &ctx->mount_server.hostname))
-				goto out_nomem;
+		case Opt_lookupcache_none:
+			ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
 			break;
-		case Opt_mountaddr:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			ctx->mount_server.addrlen =
-				rpc_pton(ctx->net, string, strlen(string),
-					(struct sockaddr *)
-					&ctx->mount_server.address,
-					sizeof(ctx->mount_server.address));
-			kfree(string);
-			if (ctx->mount_server.addrlen == 0)
-				goto out_invalid_address;
+		default:
+			dfprintk(MOUNT, "NFS:   invalid "
+				 "lookupcache argument\n");
+			return -EINVAL;
+		};
+		break;
+	case Opt_fscache_uniq:
+		if (nfs_get_option_str(args, &ctx->fscache_uniq))
+			goto out_nomem;
+		ctx->options |= NFS_OPTION_FSCACHE;
+		break;
+	case Opt_local_lock:
+		string = match_strdup(args);
+		if (string == NULL)
+			goto out_nomem;
+		token = match_token(string, nfs_local_lock_tokens,
+				    args);
+		kfree(string);
+		switch (token) {
+		case Opt_local_lock_all:
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
+				       NFS_MOUNT_LOCAL_FCNTL);
 			break;
-		case Opt_lookupcache:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			token = match_token(string,
-					nfs_lookupcache_tokens, args);
-			kfree(string);
-			switch (token) {
-				case Opt_lookupcache_all:
-					ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
-					break;
-				case Opt_lookupcache_positive:
-					ctx->flags &= ~NFS_MOUNT_LOOKUP_CACHE_NONE;
-					ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG;
-					break;
-				case Opt_lookupcache_none:
-					ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
-					break;
-				default:
-					dfprintk(MOUNT, "NFS:   invalid "
-							"lookupcache argument\n");
-					return -EINVAL;
-			};
+		case Opt_local_lock_flock:
+			ctx->flags |= NFS_MOUNT_LOCAL_FLOCK;
 			break;
-		case Opt_fscache_uniq:
-			if (nfs_get_option_str(args, &ctx->fscache_uniq))
-				goto out_nomem;
-			ctx->options |= NFS_OPTION_FSCACHE;
+		case Opt_local_lock_posix:
+			ctx->flags |= NFS_MOUNT_LOCAL_FCNTL;
 			break;
-		case Opt_local_lock:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-			token = match_token(string, nfs_local_lock_tokens,
-					args);
-			kfree(string);
-			switch (token) {
-			case Opt_local_lock_all:
-				ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
-					       NFS_MOUNT_LOCAL_FCNTL);
-				break;
-			case Opt_local_lock_flock:
-				ctx->flags |= NFS_MOUNT_LOCAL_FLOCK;
-				break;
-			case Opt_local_lock_posix:
-				ctx->flags |= NFS_MOUNT_LOCAL_FCNTL;
-				break;
-			case Opt_local_lock_none:
-				ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
-						NFS_MOUNT_LOCAL_FCNTL);
-				break;
-			default:
-				dfprintk(MOUNT, "NFS:	invalid	"
-						"local_lock argument\n");
-				return -EINVAL;
-			};
+		case Opt_local_lock_none:
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
+					NFS_MOUNT_LOCAL_FCNTL);
 			break;
+		default:
+			dfprintk(MOUNT, "NFS:	invalid	"
+				 "local_lock argument\n");
+			return -EINVAL;
+		};
+		break;
 
 		/*
 		 * Special options
 		 */
-		case Opt_sloppy:
-			ctx->sloppy = 1;
-			dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
-			break;
-		case Opt_userspace:
-		case Opt_deprecated:
-			dfprintk(MOUNT, "NFS:   ignoring mount option "
-					"'%s'\n", p);
-			break;
+	case Opt_sloppy:
+		ctx->sloppy = 1;
+		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
+		break;
+	case Opt_userspace:
+	case Opt_deprecated:
+		dfprintk(MOUNT, "NFS:   ignoring mount option "
+			 "'%s'\n", p);
+		break;
 
-		default:
-			dfprintk(MOUNT, "NFS:   unrecognized mount option "
-					"'%s'\n", p);
-			return -EINVAL;
-		}
+	default:
+		dfprintk(MOUNT, "NFS:   unrecognized mount option "
+			 "'%s'\n", p);
+		return -EINVAL;
 	}
 
 	return 0;

