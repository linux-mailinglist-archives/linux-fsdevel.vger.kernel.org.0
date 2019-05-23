Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D09282B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfEWQSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbfEWQSx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71540308FBA9;
        Thu, 23 May 2019 16:18:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6568604CC;
        Thu, 23 May 2019 16:18:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/23] NFS: Add a small buffer in nfs_fs_context to avoid
 string dup
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:50 +0100
Message-ID: <155862832993.26654.13644247168126569903.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 23 May 2019 16:18:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a small buffer in nfs_fs_context to avoid string duplication when
parsing numbers.  Also make the parsing function wrapper place the parsed
integer directly in the appropriate nfs_fs_context struct member.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/fs_context.c |   82 +++++++++++++++++++--------------------------------
 fs/nfs/internal.h   |    2 +
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index c7796fb76732..5ba534127c0b 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -467,27 +467,22 @@ static int nfs_get_option_str(substring_t args[], char **option)
 	return !*option;
 }
 
-static int nfs_get_option_ul(substring_t args[], unsigned long *option)
+static int nfs_get_option_ui(struct nfs_fs_context *ctx,
+			     substring_t args[], unsigned int *option)
 {
-	int rc;
-	char *string;
-
-	string = match_strdup(args);
-	if (string == NULL)
-		return -ENOMEM;
-	rc = kstrtoul(string, 10, option);
-	kfree(string);
-
-	return rc;
+	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
+	return kstrtouint(ctx->buf, 10, option);
 }
 
-static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
-		unsigned long l_bound, unsigned long u_bound)
+static int nfs_get_option_ui_bound(struct nfs_fs_context *ctx,
+				   substring_t args[], unsigned int *option,
+				   unsigned int l_bound, unsigned u_bound)
 {
 	int ret;
 
-	ret = nfs_get_option_ul(args, option);
-	if (ret != 0)
+	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
+	ret = kstrtouint(ctx->buf, 10, option);
+	if (ret < 0)
 		return ret;
 	if (*option < l_bound || *option > u_bound)
 		return -ERANGE;
@@ -500,7 +495,6 @@ static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
 static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 {
 	substring_t args[MAX_OPT_ARGS];
-	unsigned long option;
 	char *string;
 	int token, rc;
 
@@ -608,86 +602,70 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		 * options that take numeric values
 		 */
 	case Opt_port:
-		if (nfs_get_option_ul(args, &option) ||
-		    option > USHRT_MAX)
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->nfs_server.port,
+					    0, USHRT_MAX))
 			goto out_invalid_value;
-		ctx->nfs_server.port = option;
 		break;
 	case Opt_rsize:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->rsize))
 			goto out_invalid_value;
-		ctx->rsize = option;
 		break;
 	case Opt_wsize:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->wsize))
 			goto out_invalid_value;
-		ctx->wsize = option;
 		break;
 	case Opt_bsize:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->bsize))
 			goto out_invalid_value;
-		ctx->bsize = option;
 		break;
 	case Opt_timeo:
-		if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->timeo, 1, INT_MAX))
 			goto out_invalid_value;
-		ctx->timeo = option;
 		break;
 	case Opt_retrans:
-		if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->retrans, 0, INT_MAX))
 			goto out_invalid_value;
-		ctx->retrans = option;
 		break;
 	case Opt_acregmin:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->acregmin))
 			goto out_invalid_value;
-		ctx->acregmin = option;
 		break;
 	case Opt_acregmax:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->acregmax))
 			goto out_invalid_value;
-		ctx->acregmax = option;
 		break;
 	case Opt_acdirmin:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->acdirmin))
 			goto out_invalid_value;
-		ctx->acdirmin = option;
 		break;
 	case Opt_acdirmax:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
 			goto out_invalid_value;
-		ctx->acdirmax = option;
 		break;
 	case Opt_actimeo:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
 			goto out_invalid_value;
 		ctx->acregmin = ctx->acregmax =
-			ctx->acdirmin = ctx->acdirmax = option;
+			ctx->acdirmin = ctx->acdirmax;
 		break;
 	case Opt_namelen:
-		if (nfs_get_option_ul(args, &option))
+		if (nfs_get_option_ui(ctx, args, &ctx->namlen))
 			goto out_invalid_value;
-		ctx->namlen = option;
 		break;
 	case Opt_mountport:
-		if (nfs_get_option_ul(args, &option) ||
-		    option > USHRT_MAX)
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.port,
+					    0, USHRT_MAX))
 			goto out_invalid_value;
-		ctx->mount_server.port = option;
 		break;
 	case Opt_mountvers:
-		if (nfs_get_option_ul(args, &option) ||
-		    option < NFS_MNT_VERSION ||
-		    option > NFS_MNT3_VERSION)
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.version,
+					    NFS_MNT_VERSION, NFS_MNT3_VERSION))
 			goto out_invalid_value;
-		ctx->mount_server.version = option;
 		break;
 	case Opt_minorversion:
-		if (nfs_get_option_ul(args, &option))
-			goto out_invalid_value;
-		if (option > NFS4_MAX_MINOR_VERSION)
+		if (nfs_get_option_ui_bound(ctx, args, &ctx->minorversion,
+					    0, NFS4_MAX_MINOR_VERSION))
 			goto out_invalid_value;
-		ctx->minorversion = option;
 		break;
 
 		/*
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c4a1203163ba..6efdbedeeee8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -129,6 +129,8 @@ struct nfs_fs_context {
 
 	void			*lsm_opts;
 	struct net		*net;
+
+	char			buf[32];	/* Parse buffer */
 };
 
 /* mount_clnt.c */

