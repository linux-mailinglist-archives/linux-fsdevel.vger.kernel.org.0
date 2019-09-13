Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCFB1D69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbfIMMS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbfIMMRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 856C758487;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51B9360CD0;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 0F63720D63; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/26] NFS: Split nfs_parse_mount_options()
Date:   Fri, 13 Sep 2019 08:17:41 -0400
Message-Id: <20190913121748.25391-20-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Split nfs_parse_mount_options() to move the prologue, list-splitting and
epilogue into one function and the per-option processing into another.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 126 ++++++++++++++++++++++++--------------------
 fs/nfs/internal.h   |   3 ++
 2 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 63aa5faed9da..3ad8fc68e623 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -496,36 +496,18 @@ static int nfs_get_option_ul_bound(substring_t args[], unsigned long *option,
 }
 
 /*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
+ * Parse a single mount option in "key[=val]" form.
  */
-int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
+static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 {
-	char *p, *string;
-	int rc, sloppy = 0, invalid_option = 0;
-	unsigned short protofamily = AF_UNSPEC;
-	unsigned short mountfamily = AF_UNSPEC;
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
+	char *string;
+	int rc;
 
-	while ((p = strsep(&raw, ",")) != NULL) {
+	{
 		substring_t args[MAX_OPT_ARGS];
 		unsigned long option;
 		int token;
 
-		if (!*p)
-			continue;
-
 		dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
 
 		token = match_token(p, nfs_mount_option_tokens, args);
@@ -734,7 +716,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 			if (!rc) {
 				dfprintk(MOUNT, "NFS:   unrecognized "
 						"security flavor\n");
-				return 0;
+				return -EINVAL;
 			}
 			break;
 		case Opt_proto:
@@ -744,24 +726,24 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 			token = match_token(string,
 					    nfs_xprt_protocol_tokens, args);
 
-			protofamily = AF_INET;
+			ctx->protofamily = AF_INET;
 			switch (token) {
 			case Opt_xprt_udp6:
-				protofamily = AF_INET6;
+				ctx->protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_udp:
 				ctx->flags &= ~NFS_MOUNT_TCP;
 				ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 				break;
 			case Opt_xprt_tcp6:
-				protofamily = AF_INET6;
+				ctx->protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_tcp:
 				ctx->flags |= NFS_MOUNT_TCP;
 				ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 				break;
 			case Opt_xprt_rdma6:
-				protofamily = AF_INET6;
+				ctx->protofamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_rdma:
 				/* vector side protocols to TCP */
@@ -773,7 +755,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 				dfprintk(MOUNT, "NFS:   unrecognized "
 						"transport protocol\n");
 				kfree(string);
-				return 0;
+				return -EINVAL;
 			}
 			kfree(string);
 			break;
@@ -785,16 +767,16 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 					    nfs_xprt_protocol_tokens, args);
 			kfree(string);
 
-			mountfamily = AF_INET;
+			ctx->mountfamily = AF_INET;
 			switch (token) {
 			case Opt_xprt_udp6:
-				mountfamily = AF_INET6;
+				ctx->mountfamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_udp:
 				ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 				break;
 			case Opt_xprt_tcp6:
-				mountfamily = AF_INET6;
+				ctx->mountfamily = AF_INET6;
 				/* fall through */
 			case Opt_xprt_tcp:
 				ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
@@ -803,7 +785,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 			default:
 				dfprintk(MOUNT, "NFS:   unrecognized "
 						"transport protocol\n");
-				return 0;
+				return -EINVAL;
 			}
 			break;
 		case Opt_addr:
@@ -867,7 +849,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 				default:
 					dfprintk(MOUNT, "NFS:   invalid "
 							"lookupcache argument\n");
-					return 0;
+					return -EINVAL;
 			};
 			break;
 		case Opt_fscache_uniq:
@@ -900,7 +882,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 			default:
 				dfprintk(MOUNT, "NFS:	invalid	"
 						"local_lock argument\n");
-				return 0;
+				return -EINVAL;
 			};
 			break;
 
@@ -908,7 +890,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 		 * Special options
 		 */
 		case Opt_sloppy:
-			sloppy = 1;
+			ctx->sloppy = 1;
 			dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 			break;
 		case Opt_userspace:
@@ -918,12 +900,53 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 			break;
 
 		default:
-			invalid_option = 1;
 			dfprintk(MOUNT, "NFS:   unrecognized mount option "
 					"'%s'\n", p);
+			return -EINVAL;
 		}
 	}
 
+	return 0;
+
+out_invalid_address:
+	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
+	return -EINVAL;
+out_invalid_value:
+	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
+	return -EINVAL;
+out_nomem:
+	printk(KERN_INFO "NFS: not enough memory to parse option\n");
+	return -ENOMEM;
+}
+
+/*
+ * Error-check and convert a string of mount options from user space into
+ * a data structure.  The whole mount string is processed; bad options are
+ * skipped as they are encountered.  If there were no errors, return 1;
+ * otherwise return 0 (zero).
+ */
+int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
+{
+	char *p;
+	int rc, sloppy = 0, invalid_option = 0;
+
+	if (!raw) {
+		dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
+		return 1;
+	}
+	dfprintk(MOUNT, "NFS: nfs mount opts='%s'\n", raw);
+
+	rc = security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
+	if (rc)
+		goto out_security_failure;
+
+	while ((p = strsep(&raw, ",")) != NULL) {
+		if (!*p)
+			continue;
+		if (nfs_fs_context_parse_option(ctx, p) < 0)
+			invalid_option = true;
+	}
+
 	if (!sloppy && invalid_option)
 		return 0;
 
@@ -938,22 +961,26 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 	 * verify that any proto=/mountproto= options match the address
 	 * families in the addr=/mountaddr= options.
 	 */
-	if (protofamily != AF_UNSPEC &&
-	    protofamily != ctx->nfs_server.address.ss_family)
+	if (ctx->protofamily != AF_UNSPEC &&
+	    ctx->protofamily != ctx->nfs_server.address.ss_family)
 		goto out_proto_mismatch;
 
-	if (mountfamily != AF_UNSPEC) {
+	if (ctx->mountfamily != AF_UNSPEC) {
 		if (ctx->mount_server.addrlen) {
-			if (mountfamily != ctx->mount_server.address.ss_family)
+			if (ctx->mountfamily != ctx->mount_server.address.ss_family)
 				goto out_mountproto_mismatch;
 		} else {
-			if (mountfamily != ctx->nfs_server.address.ss_family)
+			if (ctx->mountfamily != ctx->nfs_server.address.ss_family)
 				goto out_mountproto_mismatch;
 		}
 	}
 
 	return 1;
 
+out_minorversion_mismatch:
+	printk(KERN_INFO "NFS: mount option vers=%u does not support "
+			 "minorversion=%u\n", ctx->version, ctx->minorversion);
+	return 0;
 out_mountproto_mismatch:
 	printk(KERN_INFO "NFS: mount server address does not match mountproto= "
 			 "option\n");
@@ -961,23 +988,10 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 out_proto_mismatch:
 	printk(KERN_INFO "NFS: server address does not match proto= option\n");
 	return 0;
-out_invalid_address:
-	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-	return 0;
-out_invalid_value:
-	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
-	return 0;
-out_minorversion_mismatch:
-	printk(KERN_INFO "NFS: mount option vers=%u does not support "
-			 "minorversion=%u\n", ctx->version, ctx->minorversion);
-	return 0;
 out_migration_misuse:
 	printk(KERN_INFO
 		"NFS: 'migration' not supported for this NFS version\n");
-	return 0;
-out_nomem:
-	printk(KERN_INFO "NFS: not enough memory to parse option\n");
-	return 0;
+	return -EINVAL;
 out_security_failure:
 	printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
 	return 0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 632174d666a8..d084182f8e43 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -104,7 +104,10 @@ struct nfs_fs_context {
 	unsigned int		version;
 	unsigned int		minorversion;
 	char			*fscache_uniq;
+	unsigned short		protofamily;
+	unsigned short		mountfamily;
 	bool			need_mount;
+	bool			sloppy;
 
 	struct {
 		struct sockaddr_storage	address;
-- 
2.17.2

