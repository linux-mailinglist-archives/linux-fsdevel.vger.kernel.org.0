Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC16B1D52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfIMMSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:18:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbfIMMRv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1EA23091785;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 552455D717;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 2C08B20F24; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/26] NFS: Convert mount option parsing to use functionality from fs_parser.h
Date:   Fri, 13 Sep 2019 08:17:46 -0400
Message-Id: <20190913121748.25391-25-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Convert existing mount option definitions to fs_parameter_enum's and
fs_parameter_spec's.  Parse mount options using fs_parse() and
lookup_constant().

Notes:

1) Fixed a typo in the udp6 definition in nfs_xprt_protocol_tokens
from the original commit.

2) fs_parse() expects an fs_context as the first arg so that any
errors can be logged to the fs_context.  We're passing NULL for the
fs_context (this will change in commit "NFS: Add fs_context support.")
which is okay as it will cause logfc() to do a printk() instead.

3) fs_parse() expects an fs_paramter as the third arg.  We're
building an fs_parameter manually in nfs_fs_context_parse_option(),
which will go away in commit "NFS: Add fs_context support.".

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 789 ++++++++++++++++++++------------------------
 1 file changed, 365 insertions(+), 424 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 96720cfd1065..9a3162055d5d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -11,7 +11,8 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -28,218 +29,215 @@
 
 #define NFS_MAX_CONNECTIONS 16
 
-enum {
-	/* Mount options that take no arguments */
-	Opt_soft, Opt_softerr, Opt_hard,
-	Opt_posix, Opt_noposix,
-	Opt_cto, Opt_nocto,
-	Opt_ac, Opt_noac,
-	Opt_lock, Opt_nolock,
-	Opt_udp, Opt_tcp, Opt_rdma,
-	Opt_acl, Opt_noacl,
-	Opt_rdirplus, Opt_nordirplus,
-	Opt_sharecache, Opt_nosharecache,
-	Opt_resvport, Opt_noresvport,
-	Opt_fscache, Opt_nofscache,
-	Opt_migration, Opt_nomigration,
-
-	/* Mount options that take integer arguments */
-	Opt_port,
-	Opt_rsize, Opt_wsize, Opt_bsize,
-	Opt_timeo, Opt_retrans,
-	Opt_acregmin, Opt_acregmax,
-	Opt_acdirmin, Opt_acdirmax,
+enum nfs_param {
+	Opt_ac,
+	Opt_acdirmax,
+	Opt_acdirmin,
+	Opt_acl,
+	Opt_acregmax,
+	Opt_acregmin,
 	Opt_actimeo,
-	Opt_namelen,
+	Opt_addr,
+	Opt_bg,
+	Opt_bsize,
+	Opt_clientaddr,
+	Opt_cto,
+	Opt_fg,
+	Opt_fscache,
+	Opt_hard,
+	Opt_intr,
+	Opt_local_lock,
+	Opt_lock,
+	Opt_lookupcache,
+	Opt_migration,
+	Opt_minorversion,
+	Opt_mountaddr,
+	Opt_mounthost,
 	Opt_mountport,
+	Opt_mountproto,
 	Opt_mountvers,
-	Opt_minorversion,
-
-	/* Mount options that take string arguments */
-	Opt_nfsvers,
-	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
-	Opt_addr, Opt_mountaddr, Opt_clientaddr,
+	Opt_namelen,
 	Opt_nconnect,
-	Opt_lookupcache,
-	Opt_fscache_uniq,
-	Opt_local_lock,
-
-	/* Special mount options */
-	Opt_userspace, Opt_deprecated, Opt_sloppy,
-
-	Opt_err
+	Opt_port,
+	Opt_posix,
+	Opt_proto,
+	Opt_rdirplus,
+	Opt_rdma,
+	Opt_resvport,
+	Opt_retrans,
+	Opt_retry,
+	Opt_rsize,
+	Opt_sec,
+	Opt_sharecache,
+	Opt_sloppy,
+	Opt_soft,
+	Opt_softerr,
+	Opt_source,
+	Opt_tcp,
+	Opt_timeo,
+	Opt_udp,
+	Opt_v,
+	Opt_vers,
+	Opt_wsize,
 };
 
-static const match_table_t nfs_mount_option_tokens = {
-	{ Opt_userspace, "bg" },
-	{ Opt_userspace, "fg" },
-	{ Opt_userspace, "retry=%s" },
-
-	{ Opt_sloppy, "sloppy" },
-
-	{ Opt_soft, "soft" },
-	{ Opt_softerr, "softerr" },
-	{ Opt_hard, "hard" },
-	{ Opt_deprecated, "intr" },
-	{ Opt_deprecated, "nointr" },
-	{ Opt_posix, "posix" },
-	{ Opt_noposix, "noposix" },
-	{ Opt_cto, "cto" },
-	{ Opt_nocto, "nocto" },
-	{ Opt_ac, "ac" },
-	{ Opt_noac, "noac" },
-	{ Opt_lock, "lock" },
-	{ Opt_nolock, "nolock" },
-	{ Opt_udp, "udp" },
-	{ Opt_tcp, "tcp" },
-	{ Opt_rdma, "rdma" },
-	{ Opt_acl, "acl" },
-	{ Opt_noacl, "noacl" },
-	{ Opt_rdirplus, "rdirplus" },
-	{ Opt_nordirplus, "nordirplus" },
-	{ Opt_sharecache, "sharecache" },
-	{ Opt_nosharecache, "nosharecache" },
-	{ Opt_resvport, "resvport" },
-	{ Opt_noresvport, "noresvport" },
-	{ Opt_fscache, "fsc" },
-	{ Opt_nofscache, "nofsc" },
-	{ Opt_migration, "migration" },
-	{ Opt_nomigration, "nomigration" },
-
-	{ Opt_port, "port=%s" },
-	{ Opt_rsize, "rsize=%s" },
-	{ Opt_wsize, "wsize=%s" },
-	{ Opt_bsize, "bsize=%s" },
-	{ Opt_timeo, "timeo=%s" },
-	{ Opt_retrans, "retrans=%s" },
-	{ Opt_acregmin, "acregmin=%s" },
-	{ Opt_acregmax, "acregmax=%s" },
-	{ Opt_acdirmin, "acdirmin=%s" },
-	{ Opt_acdirmax, "acdirmax=%s" },
-	{ Opt_actimeo, "actimeo=%s" },
-	{ Opt_namelen, "namlen=%s" },
-	{ Opt_mountport, "mountport=%s" },
-	{ Opt_mountvers, "mountvers=%s" },
-	{ Opt_minorversion, "minorversion=%s" },
-
-	{ Opt_nfsvers, "nfsvers=%s" },
-	{ Opt_nfsvers, "vers=%s" },
-
-	{ Opt_sec, "sec=%s" },
-	{ Opt_proto, "proto=%s" },
-	{ Opt_mountproto, "mountproto=%s" },
-	{ Opt_addr, "addr=%s" },
-	{ Opt_clientaddr, "clientaddr=%s" },
-	{ Opt_mounthost, "mounthost=%s" },
-	{ Opt_mountaddr, "mountaddr=%s" },
-
-	{ Opt_nconnect, "nconnect=%s" },
-
-	{ Opt_lookupcache, "lookupcache=%s" },
-	{ Opt_fscache_uniq, "fsc=%s" },
-	{ Opt_local_lock, "local_lock=%s" },
-
-	/* The following needs to be listed after all other options */
-	{ Opt_nfsvers, "v%s" },
-
-	{ Opt_err, NULL }
+static const struct fs_parameter_spec nfs_param_specs[] = {
+	fsparam_flag_no("ac",		Opt_ac),
+	fsparam_u32   ("acdirmax",	Opt_acdirmax),
+	fsparam_u32   ("acdirmin",	Opt_acdirmin),
+	fsparam_flag_no("acl",		Opt_acl),
+	fsparam_u32   ("acregmax",	Opt_acregmax),
+	fsparam_u32   ("acregmin",	Opt_acregmin),
+	fsparam_u32   ("actimeo",	Opt_actimeo),
+	fsparam_string("addr",		Opt_addr),
+	fsparam_flag  ("bg",		Opt_bg),
+	fsparam_u32   ("bsize",		Opt_bsize),
+	fsparam_string("clientaddr",	Opt_clientaddr),
+	fsparam_flag_no("cto",		Opt_cto),
+	fsparam_flag  ("fg",		Opt_fg),
+	__fsparam(fs_param_is_string, "fsc",		Opt_fscache,
+		  fs_param_neg_with_no|fs_param_v_optional),
+	fsparam_flag  ("hard",		Opt_hard),
+	__fsparam(fs_param_is_flag, "intr",		Opt_intr,
+		  fs_param_neg_with_no|fs_param_deprecated),
+	fsparam_enum  ("local_lock",	Opt_local_lock),
+	fsparam_flag_no("lock",		Opt_lock),
+	fsparam_enum  ("lookupcache",	Opt_lookupcache),
+	fsparam_flag_no("migration",	Opt_migration),
+	fsparam_u32   ("minorversion",	Opt_minorversion),
+	fsparam_string("mountaddr",	Opt_mountaddr),
+	fsparam_string("mounthost",	Opt_mounthost),
+	fsparam_u32   ("mountport",	Opt_mountport),
+	fsparam_string("mountproto",	Opt_mountproto),
+	fsparam_u32   ("mountvers",	Opt_mountvers),
+	fsparam_u32   ("namlen",	Opt_namelen),
+	fsparam_u32   ("nconnect",	Opt_nconnect),
+	fsparam_string("nfsvers",	Opt_vers),
+	fsparam_u32   ("port",		Opt_port),
+	fsparam_flag_no("posix",	Opt_posix),
+	fsparam_string("proto",		Opt_proto),
+	fsparam_flag_no("rdirplus",	Opt_rdirplus),
+	fsparam_flag  ("rdma",		Opt_rdma),
+	fsparam_flag_no("resvport",	Opt_resvport),
+	fsparam_u32   ("retrans",	Opt_retrans),
+	fsparam_string("retry",		Opt_retry),
+	fsparam_u32   ("rsize",		Opt_rsize),
+	fsparam_string("sec",		Opt_sec),
+	fsparam_flag_no("sharecache",	Opt_sharecache),
+	fsparam_flag  ("sloppy",	Opt_sloppy),
+	fsparam_flag  ("soft",		Opt_soft),
+	fsparam_flag  ("softerr",	Opt_softerr),
+	fsparam_string("source",	Opt_source),
+	fsparam_flag  ("tcp",		Opt_tcp),
+	fsparam_u32   ("timeo",		Opt_timeo),
+	fsparam_flag  ("udp",		Opt_udp),
+	fsparam_flag  ("v2",		Opt_v),
+	fsparam_flag  ("v3",		Opt_v),
+	fsparam_flag  ("v4",		Opt_v),
+	fsparam_flag  ("v4.0",		Opt_v),
+	fsparam_flag  ("v4.1",		Opt_v),
+	fsparam_flag  ("v4.2",		Opt_v),
+	fsparam_string("vers",		Opt_vers),
+	fsparam_u32   ("wsize",		Opt_wsize),
+	{}
 };
 
 enum {
-	Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, Opt_xprt_rdma,
-	Opt_xprt_rdma6,
-
-	Opt_xprt_err
-};
-
-static const match_table_t nfs_xprt_protocol_tokens = {
-	{ Opt_xprt_udp, "udp" },
-	{ Opt_xprt_udp6, "udp6" },
-	{ Opt_xprt_tcp, "tcp" },
-	{ Opt_xprt_tcp6, "tcp6" },
-	{ Opt_xprt_rdma, "rdma" },
-	{ Opt_xprt_rdma6, "rdma6" },
-
-	{ Opt_xprt_err, NULL }
+	Opt_local_lock_all,
+	Opt_local_lock_flock,
+	Opt_local_lock_none,
+	Opt_local_lock_posix,
 };
 
 enum {
-	Opt_sec_none, Opt_sec_sys,
-	Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
-	Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
-	Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
-
-	Opt_sec_err
+	Opt_lookupcache_all,
+	Opt_lookupcache_none,
+	Opt_lookupcache_positive,
 };
 
-static const match_table_t nfs_secflavor_tokens = {
-	{ Opt_sec_none, "none" },
-	{ Opt_sec_none, "null" },
-	{ Opt_sec_sys, "sys" },
-
-	{ Opt_sec_krb5, "krb5" },
-	{ Opt_sec_krb5i, "krb5i" },
-	{ Opt_sec_krb5p, "krb5p" },
-
-	{ Opt_sec_lkey, "lkey" },
-	{ Opt_sec_lkeyi, "lkeyi" },
-	{ Opt_sec_lkeyp, "lkeyp" },
-
-	{ Opt_sec_spkm, "spkm3" },
-	{ Opt_sec_spkmi, "spkm3i" },
-	{ Opt_sec_spkmp, "spkm3p" },
+static const struct fs_parameter_enum nfs_param_enums[] = {
+	{ Opt_local_lock,	"all",		Opt_local_lock_all },
+	{ Opt_local_lock,	"flock",	Opt_local_lock_flock },
+	{ Opt_local_lock,	"none",		Opt_local_lock_none },
+	{ Opt_local_lock,	"posix",	Opt_local_lock_posix },
+	{ Opt_lookupcache,	"all",		Opt_lookupcache_all },
+	{ Opt_lookupcache,	"none",		Opt_lookupcache_none },
+	{ Opt_lookupcache,	"pos",		Opt_lookupcache_positive },
+	{ Opt_lookupcache,	"positive",	Opt_lookupcache_positive },
+	{}
+};
 
-	{ Opt_sec_err, NULL }
+static const struct fs_parameter_description nfs_fs_parameters = {
+	.name		= "nfs",
+	.specs		= nfs_param_specs,
+	.enums		= nfs_param_enums,
 };
 
 enum {
-	Opt_lookupcache_all, Opt_lookupcache_positive,
-	Opt_lookupcache_none,
-
-	Opt_lookupcache_err
+	Opt_vers_2,
+	Opt_vers_3,
+	Opt_vers_4,
+	Opt_vers_4_0,
+	Opt_vers_4_1,
+	Opt_vers_4_2,
 };
 
-static const match_table_t nfs_lookupcache_tokens = {
-	{ Opt_lookupcache_all, "all" },
-	{ Opt_lookupcache_positive, "pos" },
-	{ Opt_lookupcache_positive, "positive" },
-	{ Opt_lookupcache_none, "none" },
-
-	{ Opt_lookupcache_err, NULL }
+static const struct constant_table nfs_vers_tokens[] = {
+	{ "2",		Opt_vers_2 },
+	{ "3",		Opt_vers_3 },
+	{ "4",		Opt_vers_4 },
+	{ "4.0",	Opt_vers_4_0 },
+	{ "4.1",	Opt_vers_4_1 },
+	{ "4.2",	Opt_vers_4_2 },
 };
 
 enum {
-	Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
-	Opt_local_lock_none,
-
-	Opt_local_lock_err
+	Opt_xprt_rdma,
+	Opt_xprt_rdma6,
+	Opt_xprt_tcp,
+	Opt_xprt_tcp6,
+	Opt_xprt_udp,
+	Opt_xprt_udp6,
+	nr__Opt_xprt
 };
 
-static const match_table_t nfs_local_lock_tokens = {
-	{ Opt_local_lock_all, "all" },
-	{ Opt_local_lock_flock, "flock" },
-	{ Opt_local_lock_posix, "posix" },
-	{ Opt_local_lock_none, "none" },
-
-	{ Opt_local_lock_err, NULL }
+static const struct constant_table nfs_xprt_protocol_tokens[nr__Opt_xprt] = {
+	{ "rdma",	Opt_xprt_rdma },
+	{ "rdma6",	Opt_xprt_rdma6 },
+	{ "tcp",	Opt_xprt_tcp },
+	{ "tcp6",	Opt_xprt_tcp6 },
+	{ "udp",	Opt_xprt_udp },
+	{ "udp6",	Opt_xprt_udp6 },
 };
 
 enum {
-	Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
-	Opt_vers_4_1, Opt_vers_4_2,
-
-	Opt_vers_err
+	Opt_sec_krb5,
+	Opt_sec_krb5i,
+	Opt_sec_krb5p,
+	Opt_sec_lkey,
+	Opt_sec_lkeyi,
+	Opt_sec_lkeyp,
+	Opt_sec_none,
+	Opt_sec_spkm,
+	Opt_sec_spkmi,
+	Opt_sec_spkmp,
+	Opt_sec_sys,
+	nr__Opt_sec
 };
 
-static const match_table_t nfs_vers_tokens = {
-	{ Opt_vers_2, "2" },
-	{ Opt_vers_3, "3" },
-	{ Opt_vers_4, "4" },
-	{ Opt_vers_4_0, "4.0" },
-	{ Opt_vers_4_1, "4.1" },
-	{ Opt_vers_4_2, "4.2" },
-
-	{ Opt_vers_err, NULL }
+static const struct constant_table nfs_secflavor_tokens[] = {
+	{ "krb5",	Opt_sec_krb5 },
+	{ "krb5i",	Opt_sec_krb5i },
+	{ "krb5p",	Opt_sec_krb5p },
+	{ "lkey",	Opt_sec_lkey },
+	{ "lkeyi",	Opt_sec_lkeyi },
+	{ "lkeyp",	Opt_sec_lkeyp },
+	{ "none",	Opt_sec_none },
+	{ "null",	Opt_sec_none },
+	{ "spkm3",	Opt_sec_spkm },
+	{ "spkm3i",	Opt_sec_spkmi },
+	{ "spkm3p",	Opt_sec_spkmp },
+	{ "sys",	Opt_sec_sys },
 };
 
 struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
@@ -368,17 +366,19 @@ static int nfs_auth_info_add(struct nfs_fs_context *ctx,
 /*
  * Parse the value of the 'sec=' option.
  */
-static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
+static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
+				      struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
 	rpc_authflavor_t pseudoflavor;
-	char *p;
+	char *string = param->string, *p;
 	int ret;
 
-	dfprintk(MOUNT, "NFS: parsing sec=%s option\n", value);
+	dfprintk(MOUNT, "NFS: parsing %s=%s option\n", param->key, param->string);
 
-	while ((p = strsep(&value, ":")) != NULL) {
-		switch (match_token(p, nfs_secflavor_tokens, args)) {
+	while ((p = strsep(&string, ":")) != NULL) {
+		if (!*p)
+			continue;
+		switch (lookup_constant(nfs_secflavor_tokens, p, -1)) {
 		case Opt_sec_none:
 			pseudoflavor = RPC_AUTH_NULL;
 			break;
@@ -427,11 +427,10 @@ static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *value)
 }
 
 static int nfs_parse_version_string(struct nfs_fs_context *ctx,
-				    char *string,
-				    substring_t *args)
+				    const char *string)
 {
 	ctx->flags &= ~NFS_MOUNT_VER3;
-	switch (match_token(string, nfs_vers_tokens, args)) {
+	switch (lookup_constant(nfs_vers_tokens, string, -1)) {
 	case Opt_vers_2:
 		ctx->version = 2;
 		break;
@@ -465,64 +464,24 @@ static int nfs_parse_version_string(struct nfs_fs_context *ctx,
 	return 0;
 }
 
-static int nfs_get_option_str(substring_t args[], char **option)
-{
-	kfree(*option);
-	*option = match_strdup(args);
-	return !*option;
-}
-
-static int nfs_get_option_ui(struct nfs_fs_context *ctx,
-			     substring_t args[], unsigned int *option)
-{
-	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-	return kstrtouint(ctx->buf, 10, option);
-}
-
-static int nfs_get_option_ui_bound(struct nfs_fs_context *ctx,
-				   substring_t args[], unsigned int *option,
-				   unsigned int l_bound, unsigned u_bound)
-{
-	int ret;
-
-	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-	ret = kstrtouint(ctx->buf, 10, option);
-	if (ret < 0)
-		return ret;
-	if (*option < l_bound || *option > u_bound)
-		return -ERANGE;
-	return 0;
-}
-
-static int nfs_get_option_us_bound(struct nfs_fs_context *ctx,
-				   substring_t args[], unsigned short *option,
-				   unsigned short l_bound,
-				   unsigned short u_bound)
-{
-	int ret;
-
-	match_strlcpy(ctx->buf, args, sizeof(ctx->buf));
-	ret = kstrtou16(ctx->buf, 10, option);
-	if (ret < 0)
-		return ret;
-	if (*option < l_bound || *option > u_bound)
-		return -ERANGE;
-	return 0;
-}
-
 /*
- * Parse a single mount option in "key[=val]" form.
+ * Parse a single mount parameter.
  */
-static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
+static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
+				      struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	char *string;
-	int token, ret;
+	struct fs_parse_result result;
+	unsigned short protofamily, mountfamily;
+	unsigned int len;
+	int ret, opt;
 
-	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
+	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
 
-	token = match_token(p, nfs_mount_option_tokens, args);
-	switch (token) {
+	opt = fs_parse(NULL, &nfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return ctx->sloppy ? 1 : opt;
+
+	switch (opt) {
 		/*
 		 * boolean options:  foo/nofoo
 		 */
@@ -538,30 +497,31 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 		ctx->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
 		break;
 	case Opt_posix:
-		ctx->flags |= NFS_MOUNT_POSIX;
-		break;
-	case Opt_noposix:
-		ctx->flags &= ~NFS_MOUNT_POSIX;
+		if (result.negated)
+			ctx->flags &= ~NFS_MOUNT_POSIX;
+		else
+			ctx->flags |= NFS_MOUNT_POSIX;
 		break;
 	case Opt_cto:
-		ctx->flags &= ~NFS_MOUNT_NOCTO;
-		break;
-	case Opt_nocto:
-		ctx->flags |= NFS_MOUNT_NOCTO;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOCTO;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOCTO;
 		break;
 	case Opt_ac:
-		ctx->flags &= ~NFS_MOUNT_NOAC;
-		break;
-	case Opt_noac:
-		ctx->flags |= NFS_MOUNT_NOAC;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOAC;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOAC;
 		break;
 	case Opt_lock:
-		ctx->flags &= ~NFS_MOUNT_NONLM;
-		ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
-		break;
-	case Opt_nolock:
-		ctx->flags |= NFS_MOUNT_NONLM;
-		ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		if (result.negated) {
+			ctx->flags |= NFS_MOUNT_NONLM;
+			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		} else {
+			ctx->flags &= ~NFS_MOUNT_NONLM;
+			ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
+		}
 		break;
 	case Opt_udp:
 		ctx->flags &= ~NFS_MOUNT_TCP;
@@ -574,195 +534,177 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 	case Opt_rdma:
 		ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
 		ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-		xprt_load_transport(p);
+		xprt_load_transport(param->key);
 		break;
 	case Opt_acl:
-		ctx->flags &= ~NFS_MOUNT_NOACL;
-		break;
-	case Opt_noacl:
-		ctx->flags |= NFS_MOUNT_NOACL;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NOACL;
+		else
+			ctx->flags &= ~NFS_MOUNT_NOACL;
 		break;
 	case Opt_rdirplus:
-		ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
-		break;
-	case Opt_nordirplus:
-		ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+		else
+			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
 		break;
 	case Opt_sharecache:
-		ctx->flags &= ~NFS_MOUNT_UNSHARED;
-		break;
-	case Opt_nosharecache:
-		ctx->flags |= NFS_MOUNT_UNSHARED;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_UNSHARED;
+		else
+			ctx->flags &= ~NFS_MOUNT_UNSHARED;
 		break;
 	case Opt_resvport:
-		ctx->flags &= ~NFS_MOUNT_NORESVPORT;
-		break;
-	case Opt_noresvport:
-		ctx->flags |= NFS_MOUNT_NORESVPORT;
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NORESVPORT;
+		else
+			ctx->flags &= ~NFS_MOUNT_NORESVPORT;
 		break;
 	case Opt_fscache:
-		ctx->options |= NFS_OPTION_FSCACHE;
 		kfree(ctx->fscache_uniq);
-		ctx->fscache_uniq = NULL;
-		break;
-	case Opt_nofscache:
-		ctx->options &= ~NFS_OPTION_FSCACHE;
-		kfree(ctx->fscache_uniq);
-		ctx->fscache_uniq = NULL;
+		ctx->fscache_uniq = param->string;
+		param->string = NULL;
+		if (result.negated)
+			ctx->options &= ~NFS_OPTION_FSCACHE;
+		else
+			ctx->options |= NFS_OPTION_FSCACHE;
 		break;
 	case Opt_migration:
-		ctx->options |= NFS_OPTION_MIGRATION;
-		break;
-	case Opt_nomigration:
-		ctx->options &= ~NFS_OPTION_MIGRATION;
+		if (result.negated)
+			ctx->options &= ~NFS_OPTION_MIGRATION;
+		else
+			ctx->options |= NFS_OPTION_MIGRATION;
 		break;
 
 		/*
 		 * options that take numeric values
 		 */
 	case Opt_port:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->nfs_server.port,
-					    0, USHRT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > USHRT_MAX)
+			goto out_of_bounds;
+		ctx->nfs_server.port = result.uint_32;
 		break;
 	case Opt_rsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->rsize))
-			goto out_invalid_value;
+		ctx->rsize = result.uint_32;
 		break;
 	case Opt_wsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->wsize))
-			goto out_invalid_value;
+		ctx->wsize = result.uint_32;
 		break;
 	case Opt_bsize:
-		if (nfs_get_option_ui(ctx, args, &ctx->bsize))
-			goto out_invalid_value;
+		ctx->bsize = result.uint_32;
 		break;
 	case Opt_timeo:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->timeo, 1, INT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 < 1 || result.uint_32 > INT_MAX)
+			goto out_of_bounds;
+		ctx->timeo = result.uint_32;
 		break;
 	case Opt_retrans:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->retrans, 0, INT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > INT_MAX)
+			goto out_of_bounds;
+		ctx->retrans = result.uint_32;
 		break;
 	case Opt_acregmin:
-		if (nfs_get_option_ui(ctx, args, &ctx->acregmin))
-			goto out_invalid_value;
+		ctx->acregmin = result.uint_32;
 		break;
 	case Opt_acregmax:
-		if (nfs_get_option_ui(ctx, args, &ctx->acregmax))
-			goto out_invalid_value;
+		ctx->acregmax = result.uint_32;
 		break;
 	case Opt_acdirmin:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmin))
-			goto out_invalid_value;
+		ctx->acdirmin = result.uint_32;
 		break;
 	case Opt_acdirmax:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-			goto out_invalid_value;
+		ctx->acdirmax = result.uint_32;
 		break;
 	case Opt_actimeo:
-		if (nfs_get_option_ui(ctx, args, &ctx->acdirmax))
-			goto out_invalid_value;
-		ctx->acregmin = ctx->acregmax =
-			ctx->acdirmin = ctx->acdirmax;
+		ctx->acregmin = result.uint_32;
+		ctx->acregmax = result.uint_32;
+		ctx->acdirmin = result.uint_32;
+		ctx->acdirmax = result.uint_32;
 		break;
 	case Opt_namelen:
-		if (nfs_get_option_ui(ctx, args, &ctx->namlen))
-			goto out_invalid_value;
+		ctx->namlen = result.uint_32;
 		break;
 	case Opt_mountport:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.port,
-					    0, USHRT_MAX))
-			goto out_invalid_value;
+		if (result.uint_32 > USHRT_MAX)
+			goto out_of_bounds;
+		ctx->mount_server.port = result.uint_32;
 		break;
 	case Opt_mountvers:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->mount_server.version,
-					    NFS_MNT_VERSION, NFS_MNT3_VERSION))
-			goto out_invalid_value;
+		if (result.uint_32 < NFS_MNT_VERSION ||
+		    result.uint_32 > NFS_MNT3_VERSION)
+			goto out_of_bounds;
+		ctx->mount_server.version = result.uint_32;
 		break;
 	case Opt_minorversion:
-		if (nfs_get_option_ui_bound(ctx, args, &ctx->minorversion,
-					    0, NFS4_MAX_MINOR_VERSION))
-			goto out_invalid_value;
+		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
+			goto out_of_bounds;
+		ctx->minorversion = result.uint_32;
 		break;
 
 		/*
 		 * options that take text values
 		 */
-	case Opt_nfsvers:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ret = nfs_parse_version_string(ctx, string, args);
-		kfree(string);
+	case Opt_v:
+		ret = nfs_parse_version_string(ctx, param->key + 1);
+		if (ret < 0)
+			return ret;
+		break;
+	case Opt_vers:
+		ret = nfs_parse_version_string(ctx, param->string);
 		if (ret < 0)
 			return ret;
 		break;
 	case Opt_sec:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ret = nfs_parse_security_flavors(ctx, string);
-		kfree(string);
+		ret = nfs_parse_security_flavors(ctx, param);
 		if (ret < 0)
 			return ret;
 		break;
-	case Opt_proto:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_xprt_protocol_tokens, args);
 
-		ctx->protofamily = AF_INET;
-		switch (token) {
+	case Opt_proto:
+		protofamily = AF_INET;
+		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_udp:
 			ctx->flags &= ~NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_tcp:
 			ctx->flags |= NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
 			break;
 		case Opt_xprt_rdma6:
-			ctx->protofamily = AF_INET6;
+			protofamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_rdma:
 			/* vector side protocols to TCP */
 			ctx->flags |= NFS_MOUNT_TCP;
 			ctx->nfs_server.protocol = XPRT_TRANSPORT_RDMA;
-			xprt_load_transport(string);
+			xprt_load_transport(param->string);
 			break;
 		default:
-			kfree(string);
 			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 			return -EINVAL;
 		}
-		kfree(string);
+
+		ctx->protofamily = protofamily;
 		break;
-	case Opt_mountproto:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_xprt_protocol_tokens, args);
-		kfree(string);
 
-		ctx->mountfamily = AF_INET;
-		switch (token) {
+	case Opt_mountproto:
+		mountfamily = AF_INET;
+		switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
 		case Opt_xprt_udp6:
-			ctx->mountfamily = AF_INET6;
+			mountfamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_udp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 			break;
 		case Opt_xprt_tcp6:
-			ctx->mountfamily = AF_INET6;
+			mountfamily = AF_INET6;
 			/* fall through */
 		case Opt_xprt_tcp:
 			ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
@@ -772,51 +714,42 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 			return -EINVAL;
 		}
+		ctx->mountfamily = mountfamily;
 		break;
+
 	case Opt_addr:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ctx->nfs_server.addrlen =
-			rpc_pton(ctx->net, string, strlen(string),
-				 &ctx->nfs_server.address,
-				 sizeof(ctx->nfs_server._address));
-		kfree(string);
-		if (ctx->nfs_server.addrlen == 0)
+		len = rpc_pton(ctx->net, param->string, param->size,
+			       &ctx->nfs_server.address,
+			       sizeof(ctx->nfs_server._address));
+		if (len == 0)
 			goto out_invalid_address;
+		ctx->nfs_server.addrlen = len;
 		break;
 	case Opt_clientaddr:
-		if (nfs_get_option_str(args, &ctx->client_address))
-			goto out_nomem;
+		kfree(ctx->client_address);
+		ctx->client_address = param->string;
+		param->string = NULL;
 		break;
 	case Opt_mounthost:
-		if (nfs_get_option_str(args, &ctx->mount_server.hostname))
-			goto out_nomem;
+		kfree(ctx->mount_server.hostname);
+		ctx->mount_server.hostname = param->string;
+		param->string = NULL;
 		break;
 	case Opt_mountaddr:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		ctx->mount_server.addrlen =
-			rpc_pton(ctx->net, string, strlen(string),
-				 &ctx->mount_server.address,
-				 sizeof(ctx->mount_server._address));
-		kfree(string);
-		if (ctx->mount_server.addrlen == 0)
+		len = rpc_pton(ctx->net, param->string, param->size,
+			       &ctx->mount_server.address,
+			       sizeof(ctx->mount_server._address));
+		if (len == 0)
 			goto out_invalid_address;
+		ctx->mount_server.addrlen = len;
 		break;
 	case Opt_nconnect:
-		if (nfs_get_option_us_bound(ctx, args, &ctx->nfs_server.nconnect,
-					    1, NFS_MAX_CONNECTIONS))
-			goto out_invalid_value;
+		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_CONNECTIONS)
+			goto out_of_bounds;
+		ctx->nfs_server.nconnect = result.uint_32;
 		break;
 	case Opt_lookupcache:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_lookupcache_tokens, args);
-		kfree(string);
-		switch (token) {
+		switch (result.uint_32) {
 		case Opt_lookupcache_all:
 			ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
 			break;
@@ -828,22 +761,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 			ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:   invalid lookupcache argument\n");
-			return -EINVAL;
+			goto out_invalid_value;
 		}
 		break;
-	case Opt_fscache_uniq:
-		if (nfs_get_option_str(args, &ctx->fscache_uniq))
-			goto out_nomem;
-		ctx->options |= NFS_OPTION_FSCACHE;
-		break;
 	case Opt_local_lock:
-		string = match_strdup(args);
-		if (string == NULL)
-			goto out_nomem;
-		token = match_token(string, nfs_local_lock_tokens, args);
-		kfree(string);
-		switch (token) {
+		switch (result.uint_32) {
 		case Opt_local_lock_all:
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
 				       NFS_MOUNT_LOCAL_FCNTL);
@@ -859,39 +781,58 @@ static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
 					NFS_MOUNT_LOCAL_FCNTL);
 			break;
 		default:
-			dfprintk(MOUNT, "NFS:	invalid	local_lock argument\n");
-			return -EINVAL;
-		};
+			goto out_invalid_value;
+		}
 		break;
 
 		/*
 		 * Special options
 		 */
 	case Opt_sloppy:
-		ctx->sloppy = 1;
+		ctx->sloppy = true;
 		dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
 		break;
-	case Opt_userspace:
-	case Opt_deprecated:
-		dfprintk(MOUNT, "NFS:   ignoring mount option '%s'\n", p);
-		break;
-
-	default:
-		dfprintk(MOUNT, "NFS:   unrecognized mount option '%s'\n", p);
-		return -EINVAL;
 	}
 
 	return 0;
 
-out_invalid_address:
-	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
-	return -EINVAL;
 out_invalid_value:
-	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", p);
+	printk(KERN_INFO "NFS: Bad mount option value specified\n");
 	return -EINVAL;
-out_nomem:
-	printk(KERN_INFO "NFS: not enough memory to parse option\n");
-	return -ENOMEM;
+out_invalid_address:
+	printk(KERN_INFO "NFS: Bad IP address specified\n");
+	return -EINVAL;
+out_of_bounds:
+	printk(KERN_INFO "NFS: Value for '%s' out of range\n", param->key);
+	return -ERANGE;
+}
+
+/* cribbed from generic_parse_monolithic and vfs_parse_fs_string */
+static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p)
+{
+	int ret;
+	char *key = p, *value;
+	size_t v_size = 0;
+	struct fs_parameter param;
+
+	memset(&param, 0, sizeof(param));
+	value = strchr(key, '=');
+	if (value && value != key) {
+		*value++ = 0;
+		v_size = strlen(value);
+	}
+	param.key = key;
+	param.type = fs_value_is_flag;
+	param.size = v_size;
+	if (v_size > 0) {
+		param.type = fs_value_is_string;
+		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+		if (!param.string)
+			return -ENOMEM;
+	}
+	ret = nfs_fs_context_parse_param(ctx, &param);
+	kfree(param.string);
+	return ret;
 }
 
 /*
-- 
2.17.2

