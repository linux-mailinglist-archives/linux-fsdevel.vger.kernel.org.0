Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7E103E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfKTP3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:29:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730310AbfKTP2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDZEUumrmm72LH3M4zYe8gRwKffSxband5tl6GYjPQc=;
        b=M1qwzFcvWcTLkw3iIVBKUSx1c+7FYnpBYgOQYpdmpuiL+P9f7TBkWsiiZa+n9QdW4h2GVr
        WDRzsorioieQJCoeFHk6bDpPKLRjAluo2xQJzkaiCEVyTrnZ2z61E5aasd7ckfAH0h3hqv
        9BOxLcY3lhGwjElLcfVseoZZCB+3uTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-sbLt45RBM2GjfBOXZBi-UQ-1; Wed, 20 Nov 2019 10:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6252F1005512;
        Wed, 20 Nov 2019 15:27:53 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAAB85C1D4;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id A1AB220AC2; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 25/27] NFS: Add fs_context support.
Date:   Wed, 20 Nov 2019 10:27:48 -0500
Message-Id: <20191120152750.6880-26-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sbLt45RBM2GjfBOXZBi-UQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
[SM -- Deferred some refactoring to a later patch]
[SM -- Fixed referral mounts, which were broken in the original patch]
[SM -- Fixed leak of nfs_fattr when fs_context is freed]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c     | 470 +++++++++++++++++++++++++++-------------
 fs/nfs/internal.h       |  74 +++----
 fs/nfs/namespace.c      | 134 +++++++-----
 fs/nfs/nfs3proc.c       |   2 +-
 fs/nfs/nfs4_fs.h        |   9 +-
 fs/nfs/nfs4namespace.c  | 291 ++++++++++++++-----------
 fs/nfs/nfs4proc.c       |   2 +-
 fs/nfs/nfs4super.c      | 151 +++++++------
 fs/nfs/proc.c           |   2 +-
 fs/nfs/super.c          | 286 +++++++-----------------
 include/linux/nfs_xdr.h |   6 +-
 11 files changed, 768 insertions(+), 659 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9a3162055d5d..ac1a8d7d7393 100644
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
@@ -467,21 +468,31 @@ static int nfs_parse_version_string(struct nfs_fs_con=
text *ctx,
 /*
  * Parse a single mount parameter.
  */
-static int nfs_fs_context_parse_param(struct nfs_fs_context *ctx,
+static int nfs_fs_context_parse_param(struct fs_context *fc,
 =09=09=09=09      struct fs_parameter *param)
 {
 =09struct fs_parse_result result;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09unsigned short protofamily, mountfamily;
 =09unsigned int len;
 =09int ret, opt;
=20
 =09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
=20
-=09opt =3D fs_parse(NULL, &nfs_fs_parameters, param, &result);
+=09opt =3D fs_parse(fc, &nfs_fs_parameters, param, &result);
 =09if (opt < 0)
 =09=09return ctx->sloppy ? 1 : opt;
=20
 =09switch (opt) {
+=09case Opt_source:
+=09=09if (fc->source) {
+=09=09=09dfprintk(MOUNT, "NFS: Multiple sources not supported\n");
+=09=09=09return -EINVAL;
+=09=09}
+=09=09fc->source =3D param->string;
+=09=09param->string =3D NULL;
+=09=09break;
+
 =09=09/*
 =09=09 * boolean options:  foo/nofoo
 =09=09 */
@@ -807,112 +818,6 @@ static int nfs_fs_context_parse_param(struct nfs_fs_c=
ontext *ctx,
 =09return -ERANGE;
 }
=20
-/* cribbed from generic_parse_monolithic and vfs_parse_fs_string */
-static int nfs_fs_context_parse_option(struct nfs_fs_context *ctx, char *p=
)
-{
-=09int ret;
-=09char *key =3D p, *value;
-=09size_t v_size =3D 0;
-=09struct fs_parameter param;
-
-=09memset(&param, 0, sizeof(param));
-=09value =3D strchr(key, '=3D');
-=09if (value && value !=3D key) {
-=09=09*value++ =3D 0;
-=09=09v_size =3D strlen(value);
-=09}
-=09param.key =3D key;
-=09param.type =3D fs_value_is_flag;
-=09param.size =3D v_size;
-=09if (v_size > 0) {
-=09=09param.type =3D fs_value_is_string;
-=09=09param.string =3D kmemdup_nul(value, v_size, GFP_KERNEL);
-=09=09if (!param.string)
-=09=09=09return -ENOMEM;
-=09}
-=09ret =3D nfs_fs_context_parse_param(ctx, &param);
-=09kfree(param.string);
-=09return ret;
-}
-
-/*
- * Error-check and convert a string of mount options from user space into
- * a data structure.  The whole mount string is processed; bad options are
- * skipped as they are encountered.  If there were no errors, return 1;
- * otherwise return 0 (zero).
- */
-int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
-{
-=09char *p;
-=09int rc, sloppy =3D 0, invalid_option =3D 0;
-
-=09if (!raw) {
-=09=09dfprintk(MOUNT, "NFS: mount options string was NULL.\n");
-=09=09return 1;
-=09}
-=09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
-
-=09rc =3D security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
-=09if (rc)
-=09=09goto out_security_failure;
-
-=09while ((p =3D strsep(&raw, ",")) !=3D NULL) {
-=09=09if (!*p)
-=09=09=09continue;
-=09=09if (nfs_fs_context_parse_option(ctx, p) < 0)
-=09=09=09invalid_option =3D true;
-=09}
-
-=09if (!sloppy && invalid_option)
-=09=09return 0;
-
-=09if (ctx->minorversion && ctx->version !=3D 4)
-=09=09goto out_minorversion_mismatch;
-
-=09if (ctx->options & NFS_OPTION_MIGRATION &&
-=09    (ctx->version !=3D 4 || ctx->minorversion !=3D 0))
-=09=09goto out_migration_misuse;
-
-=09/*
-=09 * verify that any proto=3D/mountproto=3D options match the address
-=09 * families in the addr=3D/mountaddr=3D options.
-=09 */
-=09if (ctx->protofamily !=3D AF_UNSPEC &&
-=09    ctx->protofamily !=3D ctx->nfs_server.address.sa_family)
-=09=09goto out_proto_mismatch;
-
-=09if (ctx->mountfamily !=3D AF_UNSPEC) {
-=09=09if (ctx->mount_server.addrlen) {
-=09=09=09if (ctx->mountfamily !=3D ctx->mount_server.address.sa_family)
-=09=09=09=09goto out_mountproto_mismatch;
-=09=09} else {
-=09=09=09if (ctx->mountfamily !=3D ctx->nfs_server.address.sa_family)
-=09=09=09=09goto out_mountproto_mismatch;
-=09=09}
-=09}
-
-=09return 1;
-
-out_minorversion_mismatch:
-=09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
-=09=09=09 "minorversion=3D%u\n", ctx->version, ctx->minorversion);
-=09return 0;
-out_mountproto_mismatch:
-=09printk(KERN_INFO "NFS: mount server address does not match mountproto=
=3D "
-=09=09=09 "option\n");
-=09return 0;
-out_proto_mismatch:
-=09printk(KERN_INFO "NFS: server address does not match proto=3D option\n"=
);
-=09return 0;
-out_migration_misuse:
-=09printk(KERN_INFO
-=09=09"NFS: 'migration' not supported for this NFS version\n");
-=09return -EINVAL;
-out_security_failure:
-=09printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
-=09return 0;
-}
-
 /*
  * Split "dev_name" into "hostname:export_path".
  *
@@ -990,6 +895,11 @@ static int nfs_parse_devname(struct nfs_fs_context *ct=
x,
 =09return -ENAMETOOLONG;
 }
=20
+static inline bool is_remount_fc(struct fs_context *fc)
+{
+=09return fc->root !=3D NULL;
+}
+
 /*
  * Parse monolithic NFS2/NFS3 mount data
  * - fills in the mount root filehandle
@@ -1006,12 +916,11 @@ static int nfs_parse_devname(struct nfs_fs_context *=
ctx,
  * + breaking back: trying proto=3Dudp after proto=3Dtcp, v2 after v3,
  *   mountproto=3Dtcp after mountproto=3Dudp, and so on
  */
-static int nfs23_validate_mount_data(void *options,
-=09=09=09=09     struct nfs_fs_context *ctx,
-=09=09=09=09     struct nfs_fh *mntfh,
-=09=09=09=09     const char *dev_name)
+static int nfs23_parse_monolithic(struct fs_context *fc,
+=09=09=09=09  struct nfs_mount_data *data)
 {
-=09struct nfs_mount_data *data =3D (struct nfs_mount_data *)options;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct nfs_fh *mntfh =3D ctx->mount_info.mntfh;
 =09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
 =09int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
=20
@@ -1083,6 +992,9 @@ static int nfs23_validate_mount_data(void *options,
 =09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09/* N.B. caller will free nfs_server.hostname in all cases */
 =09=09ctx->nfs_server.hostname =3D kstrdup(data->hostname, GFP_KERNEL);
+=09=09if (!ctx->nfs_server.hostname)
+=09=09=09goto out_nomem;
+
 =09=09ctx->namlen=09=09=3D data->namlen;
 =09=09ctx->bsize=09=09=3D data->bsize;
=20
@@ -1090,8 +1002,6 @@ static int nfs23_validate_mount_data(void *options,
 =09=09=09ctx->selected_flavor =3D data->pseudoflavor;
 =09=09else
 =09=09=09ctx->selected_flavor =3D RPC_AUTH_UNIX;
-=09=09if (!ctx->nfs_server.hostname)
-=09=09=09goto out_nomem;
=20
 =09=09if (!(data->flags & NFS_MOUNT_NONLM))
 =09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
@@ -1109,12 +1019,13 @@ static int nfs23_validate_mount_data(void *options,
 =09=09 */
 =09=09if (data->context[0]){
 #ifdef CONFIG_SECURITY_SELINUX
-=09=09=09int rc;
+=09=09=09int ret;
+
 =09=09=09data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
-=09=09=09rc =3D security_add_mnt_opt("context", data->context,
-=09=09=09=09=09strlen(data->context), ctx->lsm_opts);
-=09=09=09if (rc)
-=09=09=09=09return rc;
+=09=09=09ret =3D vfs_parse_fs_string(fc, "context",
+=09=09=09=09=09=09  data->context, strlen(data->context));
+=09=09=09if (ret < 0)
+=09=09=09=09return ret;
 #else
 =09=09=09return -EINVAL;
 #endif
@@ -1122,12 +1033,20 @@ static int nfs23_validate_mount_data(void *options,
=20
 =09=09break;
 =09default:
-=09=09return NFS_TEXT_DATA;
+=09=09goto generic;
 =09}
=20
+=09ctx->skip_reconfig_option_check =3D true;
 =09return 0;
=20
+generic:
+=09return generic_parse_monolithic(fc, data);
+
 out_no_data:
+=09if (is_remount_fc(fc)) {
+=09=09ctx->skip_reconfig_option_check =3D true;
+=09=09return 0;
+=09}
 =09dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
 =09return -EINVAL;
=20
@@ -1163,12 +1082,11 @@ static void nfs4_validate_mount_flags(struct nfs_fs=
_context *ctx)
 /*
  * Validate NFSv4 mount options
  */
-static int nfs4_validate_mount_data(void *options,
-=09=09=09=09    struct nfs_fs_context *ctx,
-=09=09=09=09    const char *dev_name)
+static int nfs4_parse_monolithic(struct fs_context *fc,
+=09=09=09=09 struct nfs4_mount_data *data)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
-=09struct nfs4_mount_data *data =3D (struct nfs4_mount_data *)options;
 =09char *c;
=20
 =09if (data =3D=3D NULL)
@@ -1218,7 +1136,7 @@ static int nfs4_validate_mount_data(void *options,
 =09=09ctx->client_address =3D c;
=20
 =09=09/*
-=09=09 * Translate to nfs_fs_context, which nfs4_fill_super
+=09=09 * Translate to nfs_fs_context, which nfs_fill_super
 =09=09 * can deal with.
 =09=09 */
=20
@@ -1238,12 +1156,20 @@ static int nfs4_validate_mount_data(void *options,
=20
 =09=09break;
 =09default:
-=09=09return NFS_TEXT_DATA;
+=09=09goto generic;
 =09}
=20
+=09ctx->skip_reconfig_option_check =3D true;
 =09return 0;
=20
+generic:
+=09return generic_parse_monolithic(fc, data);
+
 out_no_data:
+=09if (is_remount_fc(fc)) {
+=09=09ctx->skip_reconfig_option_check =3D true;
+=09=09return 0;
+=09}
 =09dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
 =09return -EINVAL;
=20
@@ -1260,39 +1186,66 @@ static int nfs4_validate_mount_data(void *options,
 =09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 =09return -EINVAL;
 }
+#endif
=20
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-=09=09=09    void *options,
-=09=09=09    struct nfs_fs_context *ctx,
-=09=09=09    struct nfs_fh *mntfh,
-=09=09=09    const char *dev_name)
-{
-=09if (fs_type =3D=3D &nfs_fs_type)
-=09=09return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-=09return nfs4_validate_mount_data(options, ctx, dev_name);
-}
-#else
-int nfs_validate_mount_data(struct file_system_type *fs_type,
-=09=09=09    void *options,
-=09=09=09    struct nfs_fs_context *ctx,
-=09=09=09    struct nfs_fh *mntfh,
-=09=09=09    const char *dev_name)
+/*
+ * Parse a monolithic block of data from sys_mount().
+ */
+static int nfs_fs_context_parse_monolithic(struct fs_context *fc,
+=09=09=09=09=09   void *data)
 {
-=09return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
-}
+=09if (fc->fs_type =3D=3D &nfs_fs_type)
+=09=09return nfs23_parse_monolithic(fc, data);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+=09if (fc->fs_type =3D=3D &nfs4_fs_type)
+=09=09return nfs4_parse_monolithic(fc, data);
 #endif
=20
-int nfs_validate_text_mount_data(void *options,
-=09=09=09=09 struct nfs_fs_context *ctx,
-=09=09=09=09 const char *dev_name)
+=09dfprintk(MOUNT, "NFS: Unsupported monolithic data version\n");
+=09return -EINVAL;
+}
+
+/*
+ * Validate the preparsed information in the config.
+ */
+static int nfs_fs_context_validate(struct fs_context *fc)
 {
-=09int port =3D 0;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct nfs_subversion *nfs_mod;
+=09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
 =09int max_namelen =3D PAGE_SIZE;
 =09int max_pathlen =3D NFS_MAXPATHLEN;
-=09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
+=09int port =3D 0;
+=09int ret;
=20
-=09if (nfs_parse_mount_options((char *)options, ctx) =3D=3D 0)
-=09=09return -EINVAL;
+=09if (!fc->source)
+=09=09goto out_no_device_name;
+
+=09/* Check for sanity first. */
+=09if (ctx->minorversion && ctx->version !=3D 4)
+=09=09goto out_minorversion_mismatch;
+
+=09if (ctx->options & NFS_OPTION_MIGRATION &&
+=09    (ctx->version !=3D 4 || ctx->minorversion !=3D 0))
+=09=09goto out_migration_misuse;
+
+=09/* Verify that any proto=3D/mountproto=3D options match the address
+=09 * families in the addr=3D/mountaddr=3D options.
+=09 */
+=09if (ctx->protofamily !=3D AF_UNSPEC &&
+=09    ctx->protofamily !=3D ctx->nfs_server.address.sa_family)
+=09=09goto out_proto_mismatch;
+
+=09if (ctx->mountfamily !=3D AF_UNSPEC) {
+=09=09if (ctx->mount_server.addrlen) {
+=09=09=09if (ctx->mountfamily !=3D ctx->mount_server.address.sa_family)
+=09=09=09=09goto out_mountproto_mismatch;
+=09=09} else {
+=09=09=09if (ctx->mountfamily !=3D ctx->nfs_server.address.sa_family)
+=09=09=09=09goto out_mountproto_mismatch;
+=09=09}
+=09}
=20
 =09if (!nfs_verify_server_address(sap))
 =09=09goto out_no_address;
@@ -1320,8 +1273,24 @@ int nfs_validate_text_mount_data(void *options,
=20
 =09nfs_set_port(sap, &ctx->nfs_server.port, port);
=20
-=09return nfs_parse_devname(ctx, dev_name, max_namelen, max_pathlen);
+=09ret =3D nfs_parse_devname(ctx, fc->source, max_namelen, max_pathlen);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* Load the NFS protocol module if we haven't done so yet */
+=09if (!ctx->mount_info.nfs_mod) {
+=09=09nfs_mod =3D get_nfs_version(ctx->version);
+=09=09if (IS_ERR(nfs_mod)) {
+=09=09=09ret =3D PTR_ERR(nfs_mod);
+=09=09=09goto out_version_unavailable;
+=09=09}
+=09=09ctx->mount_info.nfs_mod =3D nfs_mod;
+=09}
+=09return 0;
=20
+out_no_device_name:
+=09dfprintk(MOUNT, "NFS: Device name not specified\n");
+=09return -EINVAL;
 #if !IS_ENABLED(CONFIG_NFS_V4)
 out_v4_not_compiled:
 =09dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
@@ -1331,8 +1300,201 @@ int nfs_validate_text_mount_data(void *options,
 =09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 =09return -EINVAL;
 #endif /* !CONFIG_NFS_V4 */
-
 out_no_address:
 =09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
 =09return -EINVAL;
+out_mountproto_mismatch:
+=09dfprintk(MOUNT, "NFS: Mount server address does not match mountproto=3D=
 option\n");
+=09return -EINVAL;
+out_proto_mismatch:
+=09dfprintk(MOUNT, "NFS: Server address does not match proto=3D option\n")=
;
+=09return -EINVAL;
+out_minorversion_mismatch:
+=09dfprintk(MOUNT, "NFS: Mount option vers=3D%u does not support minorvers=
ion=3D%u\n",
+=09=09=09  ctx->version, ctx->minorversion);
+=09return -EINVAL;
+out_migration_misuse:
+=09dfprintk(MOUNT, "NFS: 'Migration' not supported for this NFS version\n"=
);
+=09return -EINVAL;
+out_version_unavailable:
+=09dfprintk(MOUNT, "NFS: Version unavailable\n");
+=09return ret;
+}
+
+/*
+ * Create an NFS superblock by the appropriate method.
+ */
+static int nfs_get_tree(struct fs_context *fc)
+{
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09int err =3D nfs_fs_context_validate(fc);
+
+=09if (err)
+=09=09return err;
+=09if (!ctx->internal)
+=09=09return ctx->mount_info.nfs_mod->rpc_ops->try_get_tree(fc);
+=09else
+=09=09return nfs_get_tree_common(fc);
 }
+
+/*
+ * Handle duplication of a configuration.  The caller copied *src into *sc=
, but
+ * it can't deal with resource pointers in the filesystem context, so we h=
ave
+ * to do that.  We need to clear pointers, copy data or get extra refs as
+ * appropriate.
+ */
+static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *sr=
c_fc)
+{
+=09struct nfs_fs_context *src =3D nfs_fc2context(src_fc), *ctx;
+
+=09ctx =3D kmemdup(src, sizeof(struct nfs_fs_context), GFP_KERNEL);
+=09if (!ctx)
+=09=09return -ENOMEM;
+
+=09ctx->mount_info.mntfh =3D nfs_alloc_fhandle();
+=09if (!ctx->mount_info.mntfh) {
+=09=09kfree(ctx);
+=09=09return -ENOMEM;
+=09}
+=09nfs_copy_fh(ctx->mount_info.mntfh, src->mount_info.mntfh);
+
+=09__module_get(ctx->mount_info.nfs_mod->owner);
+=09ctx->client_address=09=09=3D NULL;
+=09ctx->mount_server.hostname=09=3D NULL;
+=09ctx->nfs_server.export_path=09=3D NULL;
+=09ctx->nfs_server.hostname=09=3D NULL;
+=09ctx->fscache_uniq=09=09=3D NULL;
+=09ctx->clone_data.addr=09=09=3D NULL;
+=09ctx->clone_data.fattr=09=09=3D NULL;
+=09fc->fs_private =3D ctx;
+=09return 0;
+}
+
+static void nfs_fs_context_free(struct fs_context *fc)
+{
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+
+=09if (ctx) {
+=09=09if (ctx->mount_info.server)
+=09=09=09nfs_free_server(ctx->mount_info.server);
+=09=09if (ctx->mount_info.nfs_mod)
+=09=09=09put_nfs_version(ctx->mount_info.nfs_mod);
+=09=09kfree(ctx->client_address);
+=09=09kfree(ctx->mount_server.hostname);
+=09=09kfree(ctx->nfs_server.export_path);
+=09=09kfree(ctx->nfs_server.hostname);
+=09=09kfree(ctx->fscache_uniq);
+=09=09nfs_free_fhandle(ctx->mount_info.mntfh);
+=09=09kfree(ctx->clone_data.addr);
+=09=09nfs_free_fattr(ctx->clone_data.fattr);
+=09=09kfree(ctx);
+=09}
+}
+
+static const struct fs_context_operations nfs_fs_context_ops =3D {
+=09.free=09=09=09=3D nfs_fs_context_free,
+=09.dup=09=09=09=3D nfs_fs_context_dup,
+=09.parse_param=09=09=3D nfs_fs_context_parse_param,
+=09.parse_monolithic=09=3D nfs_fs_context_parse_monolithic,
+=09.get_tree=09=09=3D nfs_get_tree,
+=09.reconfigure=09=09=3D nfs_reconfigure,
+};
+
+/*
+ * Prepare superblock configuration.  We use the namespaces attached to th=
e
+ * context.  This may be the current process's namespaces, or it may be a
+ * container's namespaces.
+ */
+static int nfs_init_fs_context(struct fs_context *fc)
+{
+=09struct nfs_fs_context *ctx;
+
+=09ctx =3D kzalloc(sizeof(struct nfs_fs_context), GFP_KERNEL);
+=09if (unlikely(!ctx))
+=09=09return -ENOMEM;
+
+=09ctx->mount_info.ctx =3D ctx;
+=09ctx->mount_info.mntfh =3D nfs_alloc_fhandle();
+=09if (unlikely(!ctx->mount_info.mntfh)) {
+=09=09kfree(ctx);
+=09=09return -ENOMEM;
+=09}
+
+=09ctx->protofamily=09=3D AF_UNSPEC;
+=09ctx->mountfamily=09=3D AF_UNSPEC;
+=09ctx->mount_server.port=09=3D NFS_UNSPEC_PORT;
+
+=09if (fc->root) {
+=09=09/* reconfigure, start with the current config */
+=09=09struct nfs_server *nfss =3D fc->root->d_sb->s_fs_info;
+=09=09struct net *net =3D nfss->nfs_client->cl_net;
+
+=09=09ctx->flags=09=09=3D nfss->flags;
+=09=09ctx->rsize=09=09=3D nfss->rsize;
+=09=09ctx->wsize=09=09=3D nfss->wsize;
+=09=09ctx->retrans=09=09=3D nfss->client->cl_timeout->to_retries;
+=09=09ctx->selected_flavor=09=3D nfss->client->cl_auth->au_flavor;
+=09=09ctx->acregmin=09=09=3D nfss->acregmin / HZ;
+=09=09ctx->acregmax=09=09=3D nfss->acregmax / HZ;
+=09=09ctx->acdirmin=09=09=3D nfss->acdirmin / HZ;
+=09=09ctx->acdirmax=09=09=3D nfss->acdirmax / HZ;
+=09=09ctx->timeo=09=09=3D 10U * nfss->client->cl_timeout->to_initval / HZ;
+=09=09ctx->nfs_server.port=09=3D nfss->port;
+=09=09ctx->nfs_server.addrlen=09=3D nfss->nfs_client->cl_addrlen;
+=09=09ctx->version=09=09=3D nfss->nfs_client->rpc_ops->version;
+=09=09ctx->minorversion=09=3D nfss->nfs_client->cl_minorversion;
+
+=09=09memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+=09=09=09ctx->nfs_server.addrlen);
+
+=09=09if (fc->net_ns !=3D net) {
+=09=09=09put_net(fc->net_ns);
+=09=09=09fc->net_ns =3D get_net(net);
+=09=09}
+
+=09=09ctx->mount_info.nfs_mod =3D nfss->nfs_client->cl_nfs_mod;
+=09=09__module_get(ctx->mount_info.nfs_mod->owner);
+=09} else {
+=09=09/* defaults */
+=09=09ctx->timeo=09=09=3D NFS_UNSPEC_TIMEO;
+=09=09ctx->retrans=09=09=3D NFS_UNSPEC_RETRANS;
+=09=09ctx->acregmin=09=09=3D NFS_DEF_ACREGMIN;
+=09=09ctx->acregmax=09=09=3D NFS_DEF_ACREGMAX;
+=09=09ctx->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
+=09=09ctx->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
+=09=09ctx->nfs_server.port=09=3D NFS_UNSPEC_PORT;
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09ctx->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
+=09=09ctx->minorversion=09=3D 0;
+=09=09ctx->need_mount=09=09=3D true;
+=09}
+=09ctx->net =3D fc->net_ns;
+=09fc->fs_private =3D ctx;
+=09fc->ops =3D &nfs_fs_context_ops;
+=09return 0;
+}
+
+struct file_system_type nfs_fs_type =3D {
+=09.owner=09=09=09=3D THIS_MODULE,
+=09.name=09=09=09=3D "nfs",
+=09.init_fs_context=09=3D nfs_init_fs_context,
+=09.parameters=09=09=3D &nfs_fs_parameters,
+=09.kill_sb=09=09=3D nfs_kill_super,
+=09.fs_flags=09=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs");
+EXPORT_SYMBOL_GPL(nfs_fs_type);
+
+#if IS_ENABLED(CONFIG_NFS_V4)
+struct file_system_type nfs4_fs_type =3D {
+=09.owner=09=09=09=3D THIS_MODULE,
+=09.name=09=09=09=3D "nfs4",
+=09.init_fs_context=09=3D nfs_init_fs_context,
+=09.parameters=09=09=3D &nfs_fs_parameters,
+=09.kill_sb=09=09=3D nfs_kill_super,
+=09.fs_flags=09=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+};
+MODULE_ALIAS_FS("nfs4");
+MODULE_ALIAS("nfs4");
+EXPORT_SYMBOL_GPL(nfs4_fs_type);
+#endif /* CONFIG_NFS_V4 */
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 06aae88a8fa1..ccbff3a9ccf6 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -4,7 +4,7 @@
  */
=20
 #include "nfs4_fs.h"
-#include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/security.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
@@ -16,6 +16,7 @@
 extern const struct export_operations nfs_export_ops;
=20
 struct nfs_string;
+struct nfs_pageio_descriptor;
=20
 static inline void nfs_attr_check_mountpoint(struct super_block *parent, s=
truct nfs_fattr *fattr)
 {
@@ -34,12 +35,13 @@ static inline int nfs_attr_use_mounted_on_fileid(struct=
 nfs_fattr *fattr)
=20
 struct nfs_clone_mount {
 =09const struct super_block *sb;
-=09const struct dentry *dentry;
+=09struct dentry *dentry;
 =09char *hostname;
 =09char *mnt_path;
 =09struct sockaddr *addr;
 =09size_t addrlen;
 =09rpc_authflavor_t authflavor;
+=09struct nfs_fattr *fattr;
 };
=20
 /*
@@ -78,10 +80,23 @@ struct nfs_client_initdata {
 =09const struct cred *cred;
 };
=20
+struct nfs_mount_info {
+=09unsigned int inherited_bsize;
+=09struct nfs_fs_context *ctx;
+=09struct nfs_clone_mount *cloned;
+=09struct nfs_server *server;
+=09struct nfs_fh *mntfh;
+=09struct nfs_subversion *nfs_mod;
+};
+
 /*
  * In-kernel mount arguments
  */
 struct nfs_fs_context {
+=09bool=09=09=09internal;
+=09bool=09=09=09skip_reconfig_option_check;
+=09bool=09=09=09need_mount;
+=09bool=09=09=09sloppy;
 =09unsigned int=09=09flags;=09=09/* NFS{,4}_MOUNT_* flags */
 =09unsigned int=09=09rsize, wsize;
 =09unsigned int=09=09timeo, retrans;
@@ -98,8 +113,6 @@ struct nfs_fs_context {
 =09char=09=09=09*fscache_uniq;
 =09unsigned short=09=09protofamily;
 =09unsigned short=09=09mountfamily;
-=09bool=09=09=09need_mount;
-=09bool=09=09=09sloppy;
=20
 =09struct {
 =09=09union {
@@ -124,14 +137,23 @@ struct nfs_fs_context {
 =09=09int=09=09=09port;
 =09=09unsigned short=09=09protocol;
 =09=09unsigned short=09=09nconnect;
+=09=09unsigned short=09=09export_path_len;
 =09} nfs_server;
=20
 =09void=09=09=09*lsm_opts;
 =09struct net=09=09*net;
=20
 =09char=09=09=09buf[32];=09/* Parse buffer */
+
+=09struct nfs_mount_info=09mount_info;
+=09struct nfs_clone_mount=09clone_data;
 };
=20
+static inline struct nfs_fs_context *nfs_fc2context(const struct fs_contex=
t *fc)
+{
+=09return fc->fs_private;
+}
+
 /* mount_clnt.c */
 struct nfs_mount_request {
 =09struct sockaddr=09=09*sap;
@@ -147,15 +169,6 @@ struct nfs_mount_request {
 =09struct net=09=09*net;
 };
=20
-struct nfs_mount_info {
-=09unsigned int inherited_bsize;
-=09struct nfs_fs_context *ctx;
-=09struct nfs_clone_mount *cloned;
-=09struct nfs_server *server;
-=09struct nfs_fh *mntfh;
-=09struct nfs_subversion *nfs_mod;
-};
-
 extern int nfs_mount(struct nfs_mount_request *info);
 extern void nfs_umount(const struct nfs_mount_request *info);
=20
@@ -235,22 +248,8 @@ static inline void nfs_fs_proc_exit(void)
 extern const struct svc_version nfs4_callback_version1;
 extern const struct svc_version nfs4_callback_version4;
=20
-struct nfs_pageio_descriptor;
-
-/* mount.c */
-#define NFS_TEXT_DATA=09=091
-
-extern struct nfs_fs_context *nfs_alloc_parsed_mount_data(void);
-extern void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx);
-extern int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx);
-extern int nfs_validate_mount_data(struct file_system_type *fs_type,
-=09=09=09=09   void *options,
-=09=09=09=09   struct nfs_fs_context *ctx,
-=09=09=09=09   struct nfs_fh *mntfh,
-=09=09=09=09   const char *dev_name);
-extern int nfs_validate_text_mount_data(void *options,
-=09=09=09=09=09struct nfs_fs_context *ctx,
-=09=09=09=09=09const char *dev_name);
+/* fs_context.c */
+extern struct file_system_type nfs_fs_type;
=20
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
@@ -411,14 +410,9 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsig=
ned int mode);
=20
 /* super.c */
 extern const struct super_operations nfs_sops;
-extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_prepared_fs_type;
-#if IS_ENABLED(CONFIG_NFS_V4)
-extern struct file_system_type nfs4_referral_fs_type;
-#endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, =
void *);
+int nfs_try_get_tree(struct fs_context *);
+int nfs_get_tree_common(struct fs_context *);
 void nfs_kill_super(struct super_block *);
=20
 extern struct rpc_stat nfs_rpcstat;
@@ -446,10 +440,8 @@ static inline bool nfs_file_io_is_buffered(struct nfs_=
inode *nfsi)
 extern char *nfs_path(char **p, struct dentry *dentry,
 =09=09      char *buffer, ssize_t buflen, unsigned flags);
 extern struct vfsmount *nfs_d_automount(struct path *path);
-struct vfsmount *nfs_submount(struct nfs_server *, struct dentry *,
-=09=09=09      struct nfs_fh *, struct nfs_fattr *);
-struct vfsmount *nfs_do_submount(struct dentry *, struct nfs_fh *,
-=09=09=09=09 struct nfs_fattr *, rpc_authflavor_t);
+int nfs_submount(struct fs_context *, struct nfs_server *);
+int nfs_do_submount(struct fs_context *);
=20
 /* getroot.c */
 extern struct dentry *nfs_get_root(struct super_block *, struct nfs_fh *,
@@ -476,7 +468,7 @@ int  nfs_show_options(struct seq_file *, struct dentry =
*);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
 int  nfs_show_stats(struct seq_file *, struct dentry *);
-int nfs_remount(struct super_block *sb, int *flags, char *raw_data);
+int  nfs_reconfigure(struct fs_context *);
=20
 /* write.c */
 extern void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 72a99f9c7390..927b0f732148 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -140,31 +140,62 @@ EXPORT_SYMBOL_GPL(nfs_path);
  */
 struct vfsmount *nfs_d_automount(struct path *path)
 {
-=09struct vfsmount *mnt;
+=09struct nfs_fs_context *ctx;
+=09struct fs_context *fc;
+=09struct vfsmount *mnt =3D ERR_PTR(-ENOMEM);
 =09struct nfs_server *server =3D NFS_SERVER(d_inode(path->dentry));
-=09struct nfs_fh *fh =3D NULL;
-=09struct nfs_fattr *fattr =3D NULL;
+=09struct nfs_client *client =3D server->nfs_client;
+=09int ret;
=20
 =09if (IS_ROOT(path->dentry))
 =09=09return ERR_PTR(-ESTALE);
=20
-=09mnt =3D ERR_PTR(-ENOMEM);
-=09fh =3D nfs_alloc_fhandle();
-=09fattr =3D nfs_alloc_fattr();
-=09if (fh =3D=3D NULL || fattr =3D=3D NULL)
-=09=09goto out;
+=09/* Open a new filesystem context, transferring parameters from the
+=09 * parent superblock, including the network namespace.
+=09 */
+=09fc =3D fs_context_for_submount(&nfs_fs_type, path->dentry);
+=09if (IS_ERR(fc))
+=09=09return ERR_CAST(fc);
=20
-=09mnt =3D server->nfs_client->rpc_ops->submount(server, path->dentry, fh,=
 fattr);
+=09ctx =3D nfs_fc2context(fc);
+=09ctx->clone_data.dentry=09=3D path->dentry;
+=09ctx->clone_data.sb=09=3D path->dentry->d_sb;
+=09ctx->clone_data.fattr=09=3D nfs_alloc_fattr();
+=09if (!ctx->clone_data.fattr)
+=09=09goto out_fc;
+
+=09if (fc->net_ns !=3D client->cl_net) {
+=09=09put_net(fc->net_ns);
+=09=09fc->net_ns =3D get_net(client->cl_net);
+=09}
+
+=09/* for submounts we want the same server; referrals will reassign */
+=09memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
+=09ctx->nfs_server.addrlen=09=3D client->cl_addrlen;
+=09ctx->nfs_server.port=09=3D server->port;
+
+=09ctx->version=09=09=3D client->rpc_ops->version;
+=09ctx->minorversion=09=3D client->cl_minorversion;
+=09ctx->mount_info.nfs_mod=09=3D client->cl_nfs_mod;
+=09__module_get(ctx->mount_info.nfs_mod->owner);
+
+=09ret =3D client->rpc_ops->submount(fc, server);
+=09if (ret < 0) {
+=09=09mnt =3D ERR_PTR(ret);
+=09=09goto out_fc;
+=09}
+
+=09up_write(&fc->root->d_sb->s_umount);
+=09mnt =3D vfs_create_mount(fc);
 =09if (IS_ERR(mnt))
-=09=09goto out;
+=09=09goto out_fc;
=20
 =09mntget(mnt); /* prevent immediate expiration */
 =09mnt_set_expiry(mnt, &nfs_automount_list);
 =09schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeou=
t);
=20
-out:
-=09nfs_free_fattr(fattr);
-=09nfs_free_fhandle(fh);
+out_fc:
+=09put_fs_context(fc);
 =09return mnt;
 }
=20
@@ -219,61 +250,62 @@ void nfs_release_automount_timer(void)
  * @authflavor: security flavor to use when performing the mount
  *
  */
-struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
-=09=09=09=09 struct nfs_fattr *fattr, rpc_authflavor_t authflavor)
+int nfs_do_submount(struct fs_context *fc)
 {
-=09struct super_block *sb =3D dentry->d_sb;
-=09struct nfs_clone_mount mountdata =3D {
-=09=09.sb =3D sb,
-=09=09.dentry =3D dentry,
-=09=09.authflavor =3D authflavor,
-=09};
-=09struct nfs_mount_info mount_info =3D {
-=09=09.inherited_bsize =3D sb->s_blocksize_bits,
-=09=09.cloned =3D &mountdata,
-=09=09.mntfh =3D fh,
-=09=09.nfs_mod =3D NFS_SB(sb)->nfs_client->cl_nfs_mod,
-=09};
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct dentry *dentry =3D ctx->clone_data.dentry;
 =09struct nfs_server *server;
-=09struct vfsmount *mnt;
-=09char *page =3D (char *) __get_free_page(GFP_USER);
-=09char *devname;
+=09char *buffer, *p;
+=09int ret;
=20
-=09if (page =3D=3D NULL)
-=09=09return ERR_PTR(-ENOMEM);
+=09/* create a new volume representation */
+=09server =3D ctx->mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(ctx->c=
lone_data.sb),
+=09=09=09=09=09=09     ctx->mount_info.mntfh,
+=09=09=09=09=09=09     ctx->clone_data.fattr,
+=09=09=09=09=09=09     ctx->selected_flavor);
=20
-=09server =3D mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-=09=09=09=09=09=09=09   fattr, authflavor);
 =09if (IS_ERR(server))
-=09=09return ERR_CAST(server);
+=09=09return PTR_ERR(server);
=20
-=09mount_info.server =3D server;
+=09ctx->mount_info.server =3D server;
=20
-=09devname =3D nfs_devname(dentry, page, PAGE_SIZE);
-=09if (IS_ERR(devname))
-=09=09mnt =3D ERR_CAST(devname);
-=09else
-=09=09mnt =3D vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_=
info);
+=09buffer =3D kmalloc(4096, GFP_USER);
+=09if (!buffer)
+=09=09return -ENOMEM;
=20
-=09if (mount_info.server)
-=09=09nfs_free_server(mount_info.server);
-=09free_page((unsigned long)page);
-=09return mnt;
+=09ctx->internal=09=09=3D true;
+=09ctx->mount_info.inherited_bsize =3D ctx->clone_data.sb->s_blocksize_bit=
s;
+
+=09p =3D nfs_devname(dentry, buffer, 4096);
+=09if (IS_ERR(p)) {
+=09=09dprintk("NFS: Couldn't determine submount pathname\n");
+=09=09ret =3D PTR_ERR(p);
+=09} else {
+=09=09ret =3D vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
+=09=09if (!ret)
+=09=09=09ret =3D vfs_get_tree(fc);
+=09}
+=09kfree(buffer);
+=09return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_do_submount);
=20
-struct vfsmount *nfs_submount(struct nfs_server *server, struct dentry *de=
ntry,
-=09=09=09      struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 {
-=09int err;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct dentry *dentry =3D ctx->clone_data.dentry;
 =09struct dentry *parent =3D dget_parent(dentry);
+=09int err;
=20
 =09/* Look it up again to get its attributes */
-=09err =3D server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d=
_name, fh, fattr, NULL);
+=09err =3D server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d=
_name,
+=09=09=09=09=09=09  ctx->mount_info.mntfh, ctx->clone_data.fattr,
+=09=09=09=09=09=09  NULL);
 =09dput(parent);
 =09if (err !=3D 0)
-=09=09return ERR_PTR(err);
+=09=09return err;
=20
-=09return nfs_do_submount(dentry, fh, fattr, server->client->cl_auth->au_f=
lavor);
+=09ctx->selected_flavor =3D server->client->cl_auth->au_flavor;
+=09return nfs_do_submount(fc);
 }
 EXPORT_SYMBOL_GPL(nfs_submount);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 9eb2f1a503ab..657041c3a03f 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -990,7 +990,7 @@ const struct nfs_rpc_ops nfs_v3_clientops =3D {
 =09.nlmclnt_ops=09=3D &nlmclnt_fl_close_lock_ops,
 =09.getroot=09=3D nfs3_proc_get_root,
 =09.submount=09=3D nfs_submount,
-=09.try_mount=09=3D nfs_try_mount,
+=09.try_get_tree=09=3D nfs_try_get_tree,
 =09.getattr=09=3D nfs3_proc_getattr,
 =09.setattr=09=3D nfs3_proc_setattr,
 =09.lookup=09=09=3D nfs3_proc_lookup,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 784608d4982a..638d09cdb584 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -268,14 +268,13 @@ extern const struct dentry_operations nfs4_dentry_ope=
rations;
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
 =09=09    unsigned, umode_t);
=20
-/* super.c */
+/* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
=20
 /* nfs4namespace.c */
 struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *=
,
 =09=09=09=09=09 const struct qstr *);
-struct vfsmount *nfs4_submount(struct nfs_server *, struct dentry *,
-=09=09=09       struct nfs_fh *, struct nfs_fattr *);
+int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 =09=09=09=09const struct nfs4_fs_locations *locations);
=20
@@ -515,7 +514,6 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
@@ -525,6 +523,9 @@ extern bool recover_lost_locks;
 #define NFS4_CLIENT_ID_UNIQ_LEN=09=09(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
=20
+extern int nfs4_try_get_tree(struct fs_context *);
+extern int nfs4_get_referral_tree(struct fs_context *);
+
 /* nfs4sysctl.c */
 #ifdef CONFIG_SYSCTL
 int nfs4_register_sysctl(void);
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 2e460c33ae48..04985aebe184 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -8,6 +8,7 @@
  * NFSv4 namespace
  */
=20
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
=20
 #define NFSDBG_FACILITY=09=09NFSDBG_VFS
=20
+/*
+ * Work out the length that an NFSv4 path would render to as a standard po=
six
+ * path, with a leading slash but no terminating slash.
+ */
+static ssize_t nfs4_pathname_len(const struct nfs4_pathname *pathname)
+{
+=09ssize_t len =3D 0;
+=09int i;
+
+=09for (i =3D 0; i < pathname->ncomponents; i++) {
+=09=09const struct nfs4_string *component =3D &pathname->components[i];
+
+=09=09if (component->len > NAME_MAX)
+=09=09=09goto too_long;
+=09=09len +=3D 1 + component->len; /* Adding "/foo" */
+=09=09if (len > PATH_MAX)
+=09=09=09goto too_long;
+=09}
+=09return len;
+
+too_long:
+=09return -ENAMETOOLONG;
+}
+
 /*
  * Convert the NFSv4 pathname components into a standard posix path.
- *
- * Note that the resulting string will be placed at the end of the buffer
  */
-static inline char *nfs4_pathname_string(const struct nfs4_pathname *pathn=
ame,
-=09=09=09=09=09 char *buffer, ssize_t buflen)
+static char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
+=09=09=09=09  unsigned short *_len)
 {
-=09char *end =3D buffer + buflen;
-=09int n;
+=09ssize_t len;
+=09char *buf, *p;
+=09int i;
+
+=09len =3D nfs4_pathname_len(pathname);
+=09if (len < 0)
+=09=09return ERR_PTR(len);
+=09*_len =3D len;
+
+=09p =3D buf =3D kmalloc(len + 1, GFP_KERNEL);
+=09if (!buf)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09for (i =3D 0; i < pathname->ncomponents; i++) {
+=09=09const struct nfs4_string *component =3D &pathname->components[i];
=20
-=09*--end =3D '\0';
-=09buflen--;
-
-=09n =3D pathname->ncomponents;
-=09while (--n >=3D 0) {
-=09=09const struct nfs4_string *component =3D &pathname->components[n];
-=09=09buflen -=3D component->len + 1;
-=09=09if (buflen < 0)
-=09=09=09goto Elong;
-=09=09end -=3D component->len;
-=09=09memcpy(end, component->data, component->len);
-=09=09*--end =3D '/';
+=09=09*p++ =3D '/';
+=09=09memcpy(p, component->data, component->len);
+=09=09p +=3D component->len;
 =09}
-=09return end;
-Elong:
-=09return ERR_PTR(-ENAMETOOLONG);
+
+=09*p =3D 0;
+=09return buf;
 }
=20
 /*
@@ -100,21 +128,28 @@ static char *nfs4_path(struct dentry *dentry, char *b=
uffer, ssize_t buflen)
  */
 static int nfs4_validate_fspath(struct dentry *dentry,
 =09=09=09=09const struct nfs4_fs_locations *locations,
-=09=09=09=09char *page, char *page2)
+=09=09=09=09struct nfs_fs_context *ctx)
 {
 =09const char *path, *fs_path;
+=09char *buf;
+=09unsigned short len;
+=09int n;
=20
-=09path =3D nfs4_path(dentry, page, PAGE_SIZE);
-=09if (IS_ERR(path))
+=09buf =3D kmalloc(4096, GFP_KERNEL);
+=09path =3D nfs4_path(dentry, buf, 4096);
+=09if (IS_ERR(path)) {
+=09=09kfree(buf);
 =09=09return PTR_ERR(path);
+=09}
=20
-=09fs_path =3D nfs4_pathname_string(&locations->fs_path, page2, PAGE_SIZE)=
;
-=09if (IS_ERR(fs_path))
-=09=09return PTR_ERR(fs_path);
+=09fs_path =3D nfs4_pathname_string(&locations->fs_path, &len);
=20
-=09if (strncmp(path, fs_path, strlen(fs_path)) !=3D 0) {
+=09n =3D strncmp(path, fs_path, len);
+=09kfree(buf);
+=09kfree(fs_path);
+=09if (n !=3D 0) {
 =09=09dprintk("%s: path %s does not begin with fsroot %s\n",
-=09=09=09__func__, path, fs_path);
+=09=09=09__func__, path, ctx->nfs_server.export_path);
 =09=09return -ENOENT;
 =09}
=20
@@ -236,55 +271,83 @@ nfs4_negotiate_security(struct rpc_clnt *clnt, struct=
 inode *inode,
 =09return new;
 }
=20
-static struct vfsmount *try_location(struct nfs_clone_mount *mountdata,
-=09=09=09=09     char *page, char *page2,
-=09=09=09=09     const struct nfs4_fs_location *location)
+static int try_location(struct fs_context *fc,
+=09=09=09const struct nfs4_fs_location *location)
 {
 =09const size_t addr_bufsize =3D sizeof(struct sockaddr_storage);
-=09struct net *net =3D rpc_net_ns(NFS_SB(mountdata->sb)->client);
-=09struct vfsmount *mnt =3D ERR_PTR(-ENOENT);
-=09char *mnt_path;
-=09unsigned int maxbuflen;
-=09unsigned int s;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09unsigned int len, s;
+=09char *export_path, *source, *p;
+=09int ret =3D -ENOENT;
+
+=09/* Allocate a buffer big enough to hold any of the hostnames plus a
+=09 * terminating char and also a buffer big enough to hold the hostname
+=09 * plus a colon plus the path.
+=09 */
+=09len =3D 0;
+=09for (s =3D 0; s < location->nservers; s++) {
+=09=09const struct nfs4_string *buf =3D &location->servers[s];
+=09=09if (buf->len > len)
+=09=09=09len =3D buf->len;
+=09}
+
+=09kfree(ctx->nfs_server.hostname);
+=09ctx->nfs_server.hostname =3D kmalloc(len + 1, GFP_KERNEL);
+=09if (!ctx->nfs_server.hostname)
+=09=09return -ENOMEM;
=20
-=09mnt_path =3D nfs4_pathname_string(&location->rootpath, page2, PAGE_SIZE=
);
-=09if (IS_ERR(mnt_path))
-=09=09return ERR_CAST(mnt_path);
-=09mountdata->mnt_path =3D mnt_path;
-=09maxbuflen =3D mnt_path - 1 - page2;
+=09export_path =3D nfs4_pathname_string(&location->rootpath,
+=09=09=09=09=09   &ctx->nfs_server.export_path_len);
+=09if (IS_ERR(export_path))
+=09=09return PTR_ERR(export_path);
=20
-=09mountdata->addr =3D kmalloc(addr_bufsize, GFP_KERNEL);
-=09if (mountdata->addr =3D=3D NULL)
-=09=09return ERR_PTR(-ENOMEM);
+=09ctx->nfs_server.export_path =3D export_path;
=20
+=09source =3D kmalloc(len + 1 + ctx->nfs_server.export_path_len + 1,
+=09=09=09 GFP_KERNEL);
+=09if (!source)
+=09=09return -ENOMEM;
+
+=09kfree(fc->source);
+=09fc->source =3D source;
+
+=09ctx->clone_data.addr =3D kmalloc(addr_bufsize, GFP_KERNEL);
+=09if (ctx->clone_data.addr =3D=3D NULL)
+=09=09return -ENOMEM;
 =09for (s =3D 0; s < location->nservers; s++) {
 =09=09const struct nfs4_string *buf =3D &location->servers[s];
=20
-=09=09if (buf->len <=3D 0 || buf->len >=3D maxbuflen)
-=09=09=09continue;
-
 =09=09if (memchr(buf->data, IPV6_SCOPE_DELIMITER, buf->len))
 =09=09=09continue;
=20
-=09=09mountdata->addrlen =3D nfs_parse_server_name(buf->data, buf->len,
-=09=09=09=09mountdata->addr, addr_bufsize, net);
-=09=09if (mountdata->addrlen =3D=3D 0)
+=09=09ctx->clone_data.addrlen =3D
+=09=09=09nfs_parse_server_name(buf->data, buf->len,
+=09=09=09=09=09      ctx->clone_data.addr,
+=09=09=09=09=09      addr_bufsize,
+=09=09=09=09=09      fc->net_ns);
+=09=09if (ctx->clone_data.addrlen =3D=3D 0)
 =09=09=09continue;
=20
-=09=09memcpy(page2, buf->data, buf->len);
-=09=09page2[buf->len] =3D '\0';
-=09=09mountdata->hostname =3D page2;
+=09=09rpc_set_port(ctx->clone_data.addr, NFS_PORT);
=20
-=09=09snprintf(page, PAGE_SIZE, "%s:%s",
-=09=09=09=09mountdata->hostname,
-=09=09=09=09mountdata->mnt_path);
+=09=09memcpy(ctx->nfs_server.hostname, buf->data, buf->len);
+=09=09ctx->nfs_server.hostname[buf->len] =3D '\0';
+=09=09ctx->clone_data.hostname =3D ctx->nfs_server.hostname;
=20
-=09=09mnt =3D vfs_submount(mountdata->dentry, &nfs4_referral_fs_type, page=
, mountdata);
-=09=09if (!IS_ERR(mnt))
-=09=09=09break;
+=09=09p =3D source;
+=09=09memcpy(p, buf->data, buf->len);
+=09=09p +=3D buf->len;
+=09=09*p++ =3D ':';
+=09=09memcpy(p, ctx->nfs_server.export_path, ctx->nfs_server.export_path_l=
en);
+=09=09p +=3D ctx->nfs_server.export_path_len;
+=09=09*p =3D 0;
+
+=09=09ret =3D nfs4_get_referral_tree(fc);
+=09=09if (ret =3D=3D 0)
+=09=09=09return 0;
 =09}
-=09kfree(mountdata->addr);
-=09return mnt;
+
+=09return ret;
 }
=20
 /**
@@ -293,38 +356,23 @@ static struct vfsmount *try_location(struct nfs_clone=
_mount *mountdata,
  * @locations: array of NFSv4 server location information
  *
  */
-static struct vfsmount *nfs_follow_referral(struct dentry *dentry,
-=09=09=09=09=09    const struct nfs4_fs_locations *locations)
+static int nfs_follow_referral(struct fs_context *fc,
+=09=09=09       const struct nfs4_fs_locations *locations)
 {
-=09struct vfsmount *mnt =3D ERR_PTR(-ENOENT);
-=09struct nfs_clone_mount mountdata =3D {
-=09=09.sb =3D dentry->d_sb,
-=09=09.dentry =3D dentry,
-=09=09.authflavor =3D NFS_SB(dentry->d_sb)->client->cl_auth->au_flavor,
-=09};
-=09char *page =3D NULL, *page2 =3D NULL;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09int loc, error;
=20
 =09if (locations =3D=3D NULL || locations->nlocations <=3D 0)
-=09=09goto out;
-
-=09dprintk("%s: referral at %pd2\n", __func__, dentry);
-
-=09page =3D (char *) __get_free_page(GFP_USER);
-=09if (!page)
-=09=09goto out;
+=09=09return -ENOENT;
=20
-=09page2 =3D (char *) __get_free_page(GFP_USER);
-=09if (!page2)
-=09=09goto out;
+=09dprintk("%s: referral at %pd2\n", __func__, ctx->clone_data.dentry);
=20
 =09/* Ensure fs path is a prefix of current dentry path */
-=09error =3D nfs4_validate_fspath(dentry, locations, page, page2);
-=09if (error < 0) {
-=09=09mnt =3D ERR_PTR(error);
-=09=09goto out;
-=09}
+=09error =3D nfs4_validate_fspath(ctx->clone_data.dentry, locations, ctx);
+=09if (error < 0)
+=09=09return error;
=20
+=09error =3D -ENOENT;
 =09for (loc =3D 0; loc < locations->nlocations; loc++) {
 =09=09const struct nfs4_fs_location *location =3D &locations->locations[lo=
c];
=20
@@ -332,15 +380,12 @@ static struct vfsmount *nfs_follow_referral(struct de=
ntry *dentry,
 =09=09    location->rootpath.ncomponents =3D=3D 0)
 =09=09=09continue;
=20
-=09=09mnt =3D try_location(&mountdata, page, page2, location);
-=09=09if (!IS_ERR(mnt))
-=09=09=09break;
+=09=09error =3D try_location(fc, location);
+=09=09if (error =3D=3D 0)
+=09=09=09return 0;
 =09}
=20
-out:
-=09free_page((unsigned long) page);
-=09free_page((unsigned long) page2);
-=09return mnt;
+=09return error;
 }
=20
 /*
@@ -348,71 +393,73 @@ static struct vfsmount *nfs_follow_referral(struct de=
ntry *dentry,
  * @dentry - dentry of referral
  *
  */
-static struct vfsmount *nfs_do_refmount(struct rpc_clnt *client, struct de=
ntry *dentry)
+static int nfs_do_refmount(struct fs_context *fc, struct rpc_clnt *client)
 {
-=09struct vfsmount *mnt =3D ERR_PTR(-ENOMEM);
-=09struct dentry *parent;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct dentry *dentry, *parent;
 =09struct nfs4_fs_locations *fs_locations =3D NULL;
 =09struct page *page;
-=09int err;
+=09int err =3D -ENOMEM;
=20
 =09/* BUG_ON(IS_ROOT(dentry)); */
 =09page =3D alloc_page(GFP_KERNEL);
-=09if (page =3D=3D NULL)
-=09=09return mnt;
+=09if (!page)
+=09=09return -ENOMEM;
=20
 =09fs_locations =3D kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-=09if (fs_locations =3D=3D NULL)
+=09if (!fs_locations)
 =09=09goto out_free;
=20
 =09/* Get locations */
-=09mnt =3D ERR_PTR(-ENOENT);
-
+=09dentry =3D ctx->clone_data.dentry;
 =09parent =3D dget_parent(dentry);
 =09dprintk("%s: getting locations for %pd2\n",
 =09=09__func__, dentry);
=20
 =09err =3D nfs4_proc_fs_locations(client, d_inode(parent), &dentry->d_name=
, fs_locations, page);
 =09dput(parent);
-=09if (err !=3D 0 ||
-=09    fs_locations->nlocations <=3D 0 ||
+=09if (err !=3D 0)
+=09=09goto out_free_2;
+
+=09err =3D -ENOENT;
+=09if (fs_locations->nlocations <=3D 0 ||
 =09    fs_locations->fs_path.ncomponents <=3D 0)
-=09=09goto out_free;
+=09=09goto out_free_2;
=20
-=09mnt =3D nfs_follow_referral(dentry, fs_locations);
+=09err =3D nfs_follow_referral(fc, fs_locations);
+out_free_2:
+=09kfree(fs_locations);
 out_free:
 =09__free_page(page);
-=09kfree(fs_locations);
-=09return mnt;
+=09return err;
 }
=20
-struct vfsmount *nfs4_submount(struct nfs_server *server, struct dentry *d=
entry,
-=09=09=09       struct nfs_fh *fh, struct nfs_fattr *fattr)
+int nfs4_submount(struct fs_context *fc, struct nfs_server *server)
 {
-=09rpc_authflavor_t flavor =3D server->client->cl_auth->au_flavor;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct dentry *dentry =3D ctx->clone_data.dentry;
 =09struct dentry *parent =3D dget_parent(dentry);
 =09struct inode *dir =3D d_inode(parent);
 =09const struct qstr *name =3D &dentry->d_name;
 =09struct rpc_clnt *client;
-=09struct vfsmount *mnt;
+=09int ret;
=20
 =09/* Look it up again to get its attributes and sec flavor */
-=09client =3D nfs4_proc_lookup_mountpoint(dir, name, fh, fattr);
+=09client =3D nfs4_proc_lookup_mountpoint(dir, name, ctx->mount_info.mntfh=
,
+=09=09=09=09=09     ctx->clone_data.fattr);
 =09dput(parent);
 =09if (IS_ERR(client))
-=09=09return ERR_CAST(client);
+=09=09return PTR_ERR(client);
=20
-=09if (fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
-=09=09mnt =3D nfs_do_refmount(client, dentry);
-=09=09goto out;
+=09ctx->selected_flavor =3D client->cl_auth->au_flavor;
+=09if (ctx->clone_data.fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
+=09=09ret =3D nfs_do_refmount(fc, client);
+=09} else {
+=09=09ret =3D nfs_do_submount(fc);
 =09}
=20
-=09if (client->cl_auth->au_flavor !=3D flavor)
-=09=09flavor =3D client->cl_auth->au_flavor;
-=09mnt =3D nfs_do_submount(dentry, fh, fattr, flavor);
-out:
 =09rpc_shutdown_client(client);
-=09return mnt;
+=09return ret;
 }
=20
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index caacf5e7f5e1..7fc56d528afb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9978,7 +9978,7 @@ const struct nfs_rpc_ops nfs_v4_clientops =3D {
 =09.file_ops=09=3D &nfs4_file_operations,
 =09.getroot=09=3D nfs4_proc_get_root,
 =09.submount=09=3D nfs4_submount,
-=09.try_mount=09=3D nfs4_try_mount,
+=09.try_get_tree=09=3D nfs4_try_get_tree,
 =09.getattr=09=3D nfs4_proc_getattr,
 =09.setattr=09=3D nfs4_proc_setattr,
 =09.lookup=09=09=3D nfs4_proc_lookup,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index ca9740137cfe..96edee546b8a 100644
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
=20
 static int nfs4_write_inode(struct inode *inode, struct writeback_control =
*wbc);
 static void nfs4_evict_inode(struct inode *inode);
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type=
,
-=09int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs4_referral_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs4",
-=09.mount=09=09=3D nfs4_referral_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
=20
 static const struct super_operations nfs4_sops =3D {
 =09.alloc_inode=09=3D nfs_alloc_inode,
@@ -41,7 +32,6 @@ static const struct super_operations nfs4_sops =3D {
 =09.show_devname=09=3D nfs_show_devname,
 =09.show_path=09=3D nfs_show_path,
 =09.show_stats=09=3D nfs_show_stats,
-=09.remount_fs=09=3D nfs_remount,
 };
=20
 struct nfs_subversion nfs_v4 =3D {
@@ -147,102 +137,121 @@ static void nfs_referral_loop_unprotect(void)
 =09kfree(p);
 }
=20
-static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
-=09=09=09=09    struct nfs_mount_info *info,
-=09=09=09=09    const char *hostname,
-=09=09=09=09    const char *export_path)
+static int do_nfs4_mount(struct nfs_server *server,
+=09=09=09 struct fs_context *fc,
+=09=09=09 const char *hostname,
+=09=09=09 const char *export_path)
 {
+=09struct nfs_fs_context *root_ctx;
+=09struct fs_context *root_fc;
 =09struct vfsmount *root_mnt;
 =09struct dentry *dentry;
-=09char *root_devname;
-=09int err;
 =09size_t len;
+=09int ret;
+
+=09struct fs_parameter param =3D {
+=09=09.key=09=3D "source",
+=09=09.type=09=3D fs_value_is_string,
+=09=09.dirfd=09=3D -1,
+=09};
=20
 =09if (IS_ERR(server))
-=09=09return ERR_CAST(server);
+=09=09return PTR_ERR(server);
=20
-=09len =3D strlen(hostname) + 5;
-=09root_devname =3D kmalloc(len, GFP_KERNEL);
-=09if (root_devname =3D=3D NULL) {
+=09root_fc =3D vfs_dup_fs_context(fc);
+=09if (IS_ERR(root_fc)) {
 =09=09nfs_free_server(server);
-=09=09return ERR_PTR(-ENOMEM);
+=09=09return PTR_ERR(root_fc);
+=09}
+=09kfree(root_fc->source);
+=09root_fc->source =3D NULL;
+
+=09root_ctx =3D nfs_fc2context(root_fc);
+=09root_ctx->internal =3D true;
+=09root_ctx->mount_info.server =3D server;
+=09/* We leave export_path unset as it's not used to find the root. */
+
+=09len =3D strlen(hostname) + 5;
+=09param.string =3D kmalloc(len, GFP_KERNEL);
+=09if (param.string =3D=3D NULL) {
+=09=09put_fs_context(root_fc);
+=09=09return -ENOMEM;
 =09}
=20
 =09/* Does hostname needs to be enclosed in brackets? */
 =09if (strchr(hostname, ':'))
-=09=09snprintf(root_devname, len, "[%s]:/", hostname);
+=09=09param.size =3D snprintf(param.string, len, "[%s]:/", hostname);
 =09else
-=09=09snprintf(root_devname, len, "%s:/", hostname);
-=09info->server =3D server;
-=09root_mnt =3D vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname,=
 info);
-=09if (info->server)
-=09=09nfs_free_server(info->server);
-=09info->server =3D NULL;
-=09kfree(root_devname);
+=09=09param.size =3D snprintf(param.string, len, "%s:/", hostname);
+=09ret =3D vfs_parse_fs_param(root_fc, &param);
+=09kfree(param.string);
+=09if (ret < 0) {
+=09=09put_fs_context(root_fc);
+=09=09return ret;
+=09}
+=09root_mnt =3D fc_mount(root_fc);
+=09put_fs_context(root_fc);
=20
 =09if (IS_ERR(root_mnt))
-=09=09return ERR_CAST(root_mnt);
+=09=09return PTR_ERR(root_mnt);
=20
-=09err =3D nfs_referral_loop_protect();
-=09if (err) {
+=09ret =3D nfs_referral_loop_protect();
+=09if (ret) {
 =09=09mntput(root_mnt);
-=09=09return ERR_PTR(err);
+=09=09return ret;
 =09}
=20
 =09dentry =3D mount_subtree(root_mnt, export_path);
 =09nfs_referral_loop_unprotect();
=20
-=09return dentry;
+=09if (IS_ERR(dentry))
+=09=09return PTR_ERR(dentry);
+
+=09fc->root =3D dentry;
+=09return 0;
 }
=20
-struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-=09=09=09      struct nfs_mount_info *mount_info)
+int nfs4_try_get_tree(struct fs_context *fc)
 {
-=09struct nfs_fs_context *ctx =3D mount_info->ctx;
-=09struct dentry *res;
-
-=09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09int err;
=20
-=09res =3D do_nfs4_mount(nfs4_create_server(mount_info),
-=09=09=09    flags, mount_info,
-=09=09=09    ctx->nfs_server.hostname,
-=09=09=09    ctx->nfs_server.export_path);
+=09dfprintk(MOUNT, "--> nfs4_try_get_tree()\n");
=20
-=09dfprintk(MOUNT, "<-- nfs4_try_mount() =3D %d%s\n",
-=09=09 PTR_ERR_OR_ZERO(res),
-=09=09 IS_ERR(res) ? " [error]" : "");
-=09return res;
+=09/* We create a mount for the server's root, walk to the requested
+=09 * location and then create another mount for that.
+=09 */
+=09err=3D do_nfs4_mount(nfs4_create_server(&ctx->mount_info),
+=09=09=09   fc, ctx->nfs_server.hostname,
+=09=09=09   ctx->nfs_server.export_path);
+=09if (err) {
+=09=09dfprintk(MOUNT, "<-- nfs4_try_get_tree() =3D %d [error]\n", err);
+=09} else {
+=09=09dfprintk(MOUNT, "<-- nfs4_try_get_tree() =3D 0\n");
+=09}
+=09return err;
 }
=20
 /*
  * Create an NFS4 server record on referral traversal
  */
-static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type=
,
-=09=09int flags, const char *dev_name, void *raw_data)
+int nfs4_get_referral_tree(struct fs_context *fc)
 {
-=09struct nfs_clone_mount *data =3D raw_data;
-=09struct nfs_mount_info mount_info =3D {
-=09=09.cloned =3D data,
-=09=09.nfs_mod =3D &nfs_v4,
-=09};
-=09struct dentry *res;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09int err;
=20
 =09dprintk("--> nfs4_referral_mount()\n");
=20
-=09mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (!mount_info.mntfh)
-=09=09return ERR_PTR(-ENOMEM);
-
-=09res =3D do_nfs4_mount(nfs4_create_referral_server(mount_info.cloned,
-=09=09=09=09=09=09=09mount_info.mntfh),
-=09=09=09    flags, &mount_info, data->hostname, data->mnt_path);
-
-=09dprintk("<-- nfs4_referral_mount() =3D %d%s\n",
-=09=09PTR_ERR_OR_ZERO(res),
-=09=09IS_ERR(res) ? " [error]" : "");
-
-=09nfs_free_fhandle(mount_info.mntfh);
-=09return res;
+=09/* create a new volume representation */
+=09err =3D do_nfs4_mount(nfs4_create_referral_server(&ctx->clone_data, ctx=
->mount_info.mntfh),
+=09=09=09    fc, ctx->nfs_server.hostname,
+=09=09=09    ctx->nfs_server.export_path);
+=09if (err) {
+=09=09dfprintk(MOUNT, "<-- nfs4_get_referral_tree() =3D %d [error]\n", err=
);
+=09} else {
+=09=09dfprintk(MOUNT, "<-- nfs4_get_referral_tree() =3D 0\n");
+=09}
+=09return err;
 }
=20
=20
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 0f7288b94633..44a15523bf40 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -710,7 +710,7 @@ const struct nfs_rpc_ops nfs_v2_clientops =3D {
 =09.file_ops=09=3D &nfs_file_operations,
 =09.getroot=09=3D nfs_proc_get_root,
 =09.submount=09=3D nfs_submount,
-=09.try_mount=09=3D nfs_try_mount,
+=09.try_get_tree=09=3D nfs_try_get_tree,
 =09.getattr=09=3D nfs_proc_getattr,
 =09.setattr=09=3D nfs_proc_setattr,
 =09.lookup=09=09=3D nfs_proc_lookup,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index bb51618df142..6ff99da978a8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -70,28 +70,6 @@
=20
 #define NFSDBG_FACILITY=09=09NFSDBG_VFS
=20
-static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
-=09=09int flags, const char *dev_name, void *raw_data);
-
-struct file_system_type nfs_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs",
-=09.mount=09=09=3D nfs_fs_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs");
-EXPORT_SYMBOL_GPL(nfs_fs_type);
-
-struct file_system_type nfs_prepared_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs",
-=09.mount=09=09=3D nfs_prepared_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-EXPORT_SYMBOL_GPL(nfs_prepared_fs_type);
-
 const struct super_operations nfs_sops =3D {
 =09.alloc_inode=09=3D nfs_alloc_inode,
 =09.free_inode=09=3D nfs_free_inode,
@@ -104,22 +82,10 @@ const struct super_operations nfs_sops =3D {
 =09.show_devname=09=3D nfs_show_devname,
 =09.show_path=09=3D nfs_show_path,
 =09.show_stats=09=3D nfs_show_stats,
-=09.remount_fs=09=3D nfs_remount,
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
-struct file_system_type nfs4_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs4",
-=09.mount=09=09=3D nfs_fs_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-MODULE_ALIAS_FS("nfs4");
-MODULE_ALIAS("nfs4");
-EXPORT_SYMBOL_GPL(nfs4_fs_type);
-
 static int __init register_nfs4_fs(void)
 {
 =09return register_filesystem(&nfs4_fs_type);
@@ -911,20 +877,19 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09return nfs_mod->rpc_ops->create_server(mount_info);
 }
=20
-static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mo=
unt_info *);
-
-struct dentry *nfs_try_mount(int flags, const char *dev_name,
-=09=09=09     struct nfs_mount_info *mount_info)
+int nfs_try_get_tree(struct fs_context *fc)
 {
-=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
-=09if (mount_info->ctx->need_mount)
-=09=09mount_info->server =3D nfs_try_mount_request(mount_info);
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+
+=09if (ctx->need_mount)
+=09=09ctx->mount_info.server =3D nfs_try_mount_request(&ctx->mount_info);
 =09else
-=09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info);
+=09=09ctx->mount_info.server =3D ctx->mount_info.nfs_mod->rpc_ops->create_=
server(&ctx->mount_info);
=20
-=09return nfs_fs_mount_common(flags, dev_name, mount_info);
+=09return nfs_get_tree_common(fc);
 }
-EXPORT_SYMBOL_GPL(nfs_try_mount);
+EXPORT_SYMBOL_GPL(nfs_try_get_tree);
+
=20
 #define NFS_REMOUNT_CMP_FLAGMASK ~(NFS_MOUNT_INTR \
 =09=09| NFS_MOUNT_SECURE \
@@ -965,15 +930,11 @@ nfs_compare_remount_data(struct nfs_server *nfss,
 =09return 0;
 }
=20
-int
-nfs_remount(struct super_block *sb, int *flags, char *raw_data)
+int nfs_reconfigure(struct fs_context *fc)
 {
-=09int error;
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct super_block *sb =3D fc->root->d_sb;
 =09struct nfs_server *nfss =3D sb->s_fs_info;
-=09struct nfs_fs_context *ctx;
-=09struct nfs_mount_data *options =3D (struct nfs_mount_data *)raw_data;
-=09struct nfs4_mount_data *options4 =3D (struct nfs4_mount_data *)raw_data=
;
-=09u32 nfsvers =3D nfss->nfs_client->rpc_ops->version;
=20
 =09sync_filesystem(sb);
=20
@@ -983,57 +944,24 @@ nfs_remount(struct super_block *sb, int *flags, char =
*raw_data)
 =09 * ones were explicitly specified. Fall back to legacy behavior and
 =09 * just return success.
 =09 */
-=09if ((nfsvers =3D=3D 4 && (!options4 || options4->version =3D=3D 1)) ||
-=09    (nfsvers <=3D 3 && (!options || (options->version >=3D 1 &&
-=09=09=09=09=09   options->version <=3D 6))))
+=09if (ctx->skip_reconfig_option_check)
 =09=09return 0;
=20
-=09ctx =3D nfs_alloc_parsed_mount_data();
-=09if (ctx =3D=3D NULL)
-=09=09return -ENOMEM;
-
-=09/* fill out struct with values from existing mount */
-=09ctx->flags =3D nfss->flags;
-=09ctx->rsize =3D nfss->rsize;
-=09ctx->wsize =3D nfss->wsize;
-=09ctx->retrans =3D nfss->client->cl_timeout->to_retries;
-=09ctx->selected_flavor =3D nfss->client->cl_auth->au_flavor;
-=09ctx->acregmin =3D nfss->acregmin / HZ;
-=09ctx->acregmax =3D nfss->acregmax / HZ;
-=09ctx->acdirmin =3D nfss->acdirmin / HZ;
-=09ctx->acdirmax =3D nfss->acdirmax / HZ;
-=09ctx->timeo =3D 10U * nfss->client->cl_timeout->to_initval / HZ;
-=09ctx->nfs_server.port =3D nfss->port;
-=09ctx->nfs_server.addrlen =3D nfss->nfs_client->cl_addrlen;
-=09ctx->version =3D nfsvers;
-=09ctx->minorversion =3D nfss->nfs_client->cl_minorversion;
-=09ctx->net =3D current->nsproxy->net_ns;
-=09memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
-=09=09ctx->nfs_server.addrlen);
-
-=09/* overwrite those values with any that were specified */
-=09error =3D -EINVAL;
-=09if (!nfs_parse_mount_options((char *)options, ctx))
-=09=09goto out;
-
 =09/*
 =09 * noac is a special case. It implies -o sync, but that's not
-=09 * necessarily reflected in the mtab options. do_remount_sb
+=09 * necessarily reflected in the mtab options. reconfigure_super
 =09 * will clear SB_SYNCHRONOUS if -o sync wasn't specified in the
 =09 * remount options, so we have to explicitly reset it.
 =09 */
-=09if (ctx->flags & NFS_MOUNT_NOAC)
-=09=09*flags |=3D SB_SYNCHRONOUS;
+=09if (ctx->flags & NFS_MOUNT_NOAC) {
+=09=09fc->sb_flags |=3D SB_SYNCHRONOUS;
+=09=09fc->sb_flags_mask |=3D SB_SYNCHRONOUS;
+=09}
=20
 =09/* compare new mount options with old ones */
-=09error =3D nfs_compare_remount_data(nfss, ctx);
-=09if (!error)
-=09=09error =3D security_sb_remount(sb, ctx->lsm_opts);
-out:
-=09nfs_free_parsed_mount_data(ctx);
-=09return error;
+=09return nfs_compare_remount_data(nfss, ctx);
 }
-EXPORT_SYMBOL_GPL(nfs_remount);
+EXPORT_SYMBOL_GPL(nfs_reconfigure);
=20
 /*
  * Finish setting up an NFS superblock
@@ -1112,19 +1040,11 @@ static int nfs_compare_mount_options(const struct s=
uper_block *s, const struct n
 =09return 0;
 }
=20
-struct nfs_sb_mountdata {
-=09struct nfs_server *server;
-=09int mntflags;
-};
-
-static int nfs_set_super(struct super_block *s, void *data)
+static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 {
-=09struct nfs_sb_mountdata *sb_mntdata =3D data;
-=09struct nfs_server *server =3D sb_mntdata->server;
+=09struct nfs_server *server =3D fc->s_fs_info;
 =09int ret;
=20
-=09s->s_flags =3D sb_mntdata->mntflags;
-=09s->s_fs_info =3D server;
 =09s->s_d_op =3D server->nfs_client->rpc_ops->dentry_ops;
 =09ret =3D set_anon_super(s, server);
 =09if (ret =3D=3D 0)
@@ -1189,11 +1109,9 @@ static int nfs_compare_userns(const struct nfs_serve=
r *old,
 =09return 1;
 }
=20
-static int nfs_compare_super(struct super_block *sb, void *data)
+static int nfs_compare_super(struct super_block *sb, struct fs_context *fc=
)
 {
-=09struct nfs_sb_mountdata *sb_mntdata =3D data;
-=09struct nfs_server *server =3D sb_mntdata->server, *old =3D NFS_SB(sb);
-=09int mntflags =3D sb_mntdata->mntflags;
+=09struct nfs_server *server =3D fc->s_fs_info, *old =3D NFS_SB(sb);
=20
 =09if (!nfs_compare_super_address(old, server))
 =09=09return 0;
@@ -1204,13 +1122,12 @@ static int nfs_compare_super(struct super_block *sb=
, void *data)
 =09=09return 0;
 =09if (!nfs_compare_userns(old, server))
 =09=09return 0;
-=09return nfs_compare_mount_options(sb, server, mntflags);
+=09return nfs_compare_mount_options(sb, server, fc->sb_flags);
 }
=20
 #ifdef CONFIG_NFS_FSCACHE
 static void nfs_get_cache_cookie(struct super_block *sb,
-=09=09=09=09 struct nfs_fs_context *ctx,
-=09=09=09=09 struct nfs_clone_mount *cloned)
+=09=09=09=09 struct nfs_fs_context *ctx)
 {
 =09struct nfs_server *nfss =3D NFS_SB(sb);
 =09char *uniq =3D NULL;
@@ -1219,30 +1136,32 @@ static void nfs_get_cache_cookie(struct super_block=
 *sb,
 =09nfss->fscache_key =3D NULL;
 =09nfss->fscache =3D NULL;
=20
-=09if (ctx) {
+=09if (!ctx)
+=09=09return;
+
+=09if (ctx->clone_data.sb) {
+=09=09struct nfs_server *mnt_s =3D NFS_SB(ctx->clone_data.sb);
+=09=09if (!(mnt_s->options & NFS_OPTION_FSCACHE))
+=09=09=09return;
+=09=09if (mnt_s->fscache_key) {
+=09=09=09uniq =3D mnt_s->fscache_key->key.uniquifier;
+=09=09=09ulen =3D mnt_s->fscache_key->key.uniq_len;
+=09=09}
+=09} else {
 =09=09if (!(ctx->options & NFS_OPTION_FSCACHE))
 =09=09=09return;
 =09=09if (ctx->fscache_uniq) {
 =09=09=09uniq =3D ctx->fscache_uniq;
 =09=09=09ulen =3D strlen(ctx->fscache_uniq);
 =09=09}
-=09} else if (cloned) {
-=09=09struct nfs_server *mnt_s =3D NFS_SB(cloned->sb);
-=09=09if (!(mnt_s->options & NFS_OPTION_FSCACHE))
-=09=09=09return;
-=09=09if (mnt_s->fscache_key) {
-=09=09=09uniq =3D mnt_s->fscache_key->key.uniquifier;
-=09=09=09ulen =3D mnt_s->fscache_key->key.uniq_len;
-=09=09};
-=09} else
 =09=09return;
+=09}
=20
 =09nfs_fscache_get_super_cookie(sb, uniq, ulen);
 }
 #else
 static void nfs_get_cache_cookie(struct super_block *sb,
-=09=09=09=09 struct nfs_fs_context *parsed,
-=09=09=09=09 struct nfs_clone_mount *cloned)
+=09=09=09=09 struct nfs_fs_context *ctx)
 {
 }
 #endif
@@ -1254,40 +1173,41 @@ static void nfs_set_readahead(struct backing_dev_in=
fo *bdi,
 =09bdi->io_pages =3D iomax_pages;
 }
=20
-static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-=09=09=09=09   struct nfs_mount_info *mount_info)
+int nfs_get_tree_common(struct fs_context *fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct super_block *s;
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
-=09int (*compare_super)(struct super_block *, void *) =3D nfs_compare_supe=
r;
-=09struct nfs_server *server =3D mount_info->server;
+=09int (*compare_super)(struct super_block *, struct fs_context *) =3D nfs=
_compare_super;
+=09struct nfs_server *server =3D ctx->mount_info.server;
 =09unsigned long kflags =3D 0, kflags_out =3D 0;
-=09struct nfs_sb_mountdata sb_mntdata =3D {
-=09=09.mntflags =3D flags,
-=09=09.server =3D server,
-=09};
 =09int error;
=20
-=09mount_info->server =3D NULL;
+=09ctx->mount_info.server =3D NULL;
 =09if (IS_ERR(server))
-=09=09return ERR_CAST(server);
+=09=09return PTR_ERR(server);
=20
 =09if (server->flags & NFS_MOUNT_UNSHARED)
 =09=09compare_super =3D NULL;
=20
 =09/* -o noac implies -o sync */
 =09if (server->flags & NFS_MOUNT_NOAC)
-=09=09sb_mntdata.mntflags |=3D SB_SYNCHRONOUS;
+=09=09fc->sb_flags |=3D SB_SYNCHRONOUS;
+
+=09if (ctx->clone_data.sb)
+=09=09if (ctx->clone_data.sb->s_flags & SB_SYNCHRONOUS)
+=09=09=09fc->sb_flags |=3D SB_SYNCHRONOUS;
=20
-=09if (mount_info->cloned !=3D NULL && mount_info->cloned->sb !=3D NULL)
-=09=09if (mount_info->cloned->sb->s_flags & SB_SYNCHRONOUS)
-=09=09=09sb_mntdata.mntflags |=3D SB_SYNCHRONOUS;
+=09if (server->caps & NFS_CAP_SECURITY_LABEL)
+=09=09fc->lsm_flags |=3D SECURITY_LSM_NATIVE_LABELS;
=20
 =09/* Get a superblock - note that we may end up sharing one that already =
exists */
-=09s =3D sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
-=09=09 flags, &sb_mntdata);
+=09fc->s_fs_info =3D server;
+=09s =3D sget_fc(fc, compare_super, nfs_set_super);
+=09fc->s_fs_info =3D NULL;
 =09if (IS_ERR(s)) {
-=09=09mntroot =3D ERR_CAST(s);
+=09=09error =3D PTR_ERR(s);
+=09=09dfprintk(MOUNT, "NFS: Couldn't get superblock\n");
 =09=09goto out_err_nosb;
 =09}
=20
@@ -1297,44 +1217,43 @@ static struct dentry *nfs_fs_mount_common(int flags=
, const char *dev_name,
 =09} else {
 =09=09error =3D super_setup_bdi_name(s, "%u:%u", MAJOR(server->s_dev),
 =09=09=09=09=09     MINOR(server->s_dev));
-=09=09if (error) {
-=09=09=09mntroot =3D ERR_PTR(error);
+=09=09if (error)
 =09=09=09goto error_splat_super;
-=09=09}
 =09=09nfs_set_readahead(s->s_bdi, server->rpages);
 =09=09server->super =3D s;
 =09}
=20
 =09if (!s->s_root) {
-=09=09unsigned bsize =3D mount_info->inherited_bsize;
+=09=09unsigned bsize =3D ctx->mount_info.inherited_bsize;
 =09=09/* initial superblock/root creation */
-=09=09nfs_fill_super(s, mount_info);
+=09=09nfs_fill_super(s, &ctx->mount_info);
 =09=09if (bsize) {
 =09=09=09s->s_blocksize_bits =3D bsize;
 =09=09=09s->s_blocksize =3D 1U << bsize;
 =09=09}
-=09=09nfs_get_cache_cookie(s, mount_info->ctx, mount_info->cloned);
-=09=09if (!(server->flags & NFS_MOUNT_UNSHARED))
-=09=09=09s->s_iflags |=3D SB_I_MULTIROOT;
+=09=09nfs_get_cache_cookie(s, ctx);
 =09}
=20
-=09mntroot =3D nfs_get_root(s, mount_info->mntfh, dev_name);
-=09if (IS_ERR(mntroot))
+=09mntroot =3D nfs_get_root(s, ctx->mount_info.mntfh, fc->source);
+=09if (IS_ERR(mntroot)) {
+=09=09error =3D PTR_ERR(mntroot);
+=09=09dfprintk(MOUNT, "NFS: Couldn't get root dentry\n");
 =09=09goto error_splat_super;
-
+=09}
+=09fc->root =3D mntroot;
=20
 =09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
 =09=09kflags |=3D SECURITY_LSM_NATIVE_LABELS;
-=09if (mount_info->cloned) {
-=09=09if (d_inode(mntroot)->i_fop !=3D &nfs_dir_operations) {
+=09if (ctx->clone_data.sb) {
+=09=09if (d_inode(fc->root)->i_fop !=3D &nfs_dir_operations) {
 =09=09=09error =3D -ESTALE;
 =09=09=09goto error_splat_root;
 =09=09}
 =09=09/* clone any lsm security options from the parent to the new sb */
-=09=09error =3D security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kfla=
gs,
+=09=09error =3D security_sb_clone_mnt_opts(ctx->clone_data.sb, s, kflags,
 =09=09=09=09&kflags_out);
 =09} else {
-=09=09error =3D security_sb_set_mnt_opts(s, mount_info->ctx->lsm_opts,
+=09=09error =3D security_sb_set_mnt_opts(s, fc->security,
 =09=09=09=09=09=09=09kflags, &kflags_out);
 =09}
 =09if (error)
@@ -1342,67 +1261,25 @@ static struct dentry *nfs_fs_mount_common(int flags=
, const char *dev_name,
 =09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
 =09=09!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 =09=09NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
-=09if (error)
-=09=09goto error_splat_root;
=20
 =09s->s_flags |=3D SB_ACTIVE;
+=09error =3D 0;
=20
 out:
-=09return mntroot;
+=09return error;
=20
 out_err_nosb:
 =09nfs_free_server(server);
 =09goto out;
=20
 error_splat_root:
-=09dput(mntroot);
-=09mntroot =3D ERR_PTR(error);
+=09dput(fc->root);
+=09fc->root =3D NULL;
 error_splat_super:
 =09deactivate_locked_super(s);
 =09goto out;
 }
=20
-struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
-=09int flags, const char *dev_name, void *raw_data)
-{
-=09struct nfs_mount_info mount_info =3D {
-=09};
-=09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
-=09struct nfs_subversion *nfs_mod;
-=09int error;
-
-=09mount_info.ctx =3D nfs_alloc_parsed_mount_data();
-=09mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (mount_info.ctx =3D=3D NULL || mount_info.mntfh =3D=3D NULL)
-=09=09goto out;
-
-=09/* Validate the mount data */
-=09error =3D nfs_validate_mount_data(fs_type, raw_data, mount_info.ctx, mo=
unt_info.mntfh, dev_name);
-=09if (error =3D=3D NFS_TEXT_DATA)
-=09=09error =3D nfs_validate_text_mount_data(raw_data,
-=09=09=09=09=09=09     mount_info.ctx, dev_name);
-=09if (error < 0) {
-=09=09mntroot =3D ERR_PTR(error);
-=09=09goto out;
-=09}
-
-=09nfs_mod =3D get_nfs_version(mount_info.ctx->version);
-=09if (IS_ERR(nfs_mod)) {
-=09=09mntroot =3D ERR_CAST(nfs_mod);
-=09=09goto out;
-=09}
-=09mount_info.nfs_mod =3D nfs_mod;
-
-=09mntroot =3D nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
-
-=09put_nfs_version(nfs_mod);
-out:
-=09nfs_free_parsed_mount_data(mount_info.ctx);
-=09nfs_free_fhandle(mount_info.mntfh);
-=09return mntroot;
-}
-EXPORT_SYMBOL_GPL(nfs_fs_mount);
-
 /*
  * Destroy an NFS2/3 superblock
  */
@@ -1420,17 +1297,6 @@ void nfs_kill_super(struct super_block *s)
 }
 EXPORT_SYMBOL_GPL(nfs_kill_super);
=20
-/*
- * Internal use only: mount_info is already set up by caller.
- * Used for mountpoint crossings and for nfs4 root.
- */
-static struct dentry *
-nfs_prepared_mount(struct file_system_type *fs_type, int flags,
-=09=09   const char *dev_name, void *raw_data)
-{
-=09return nfs_fs_mount_common(flags, dev_name, raw_data);
-}
-
 #if IS_ENABLED(CONFIG_NFS_V4)
=20
 /*
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 82bdb91da2ae..3de843888bc0 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1622,6 +1622,7 @@ struct nfs_subversion;
 struct nfs_mount_info;
 struct nfs_client_initdata;
 struct nfs_pageio_descriptor;
+struct fs_context;
=20
 /*
  * RPC procedure vector for NFSv2/NFSv3 demuxing
@@ -1636,9 +1637,8 @@ struct nfs_rpc_ops {
=20
 =09int=09(*getroot) (struct nfs_server *, struct nfs_fh *,
 =09=09=09    struct nfs_fsinfo *);
-=09struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
-=09=09=09=09      struct nfs_fh *, struct nfs_fattr *);
-=09struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *=
);
+=09int=09(*submount) (struct fs_context *, struct nfs_server *);
+=09int=09(*try_get_tree) (struct fs_context *);
 =09int=09(*getattr) (struct nfs_server *, struct nfs_fh *,
 =09=09=09    struct nfs_fattr *, struct nfs4_label *,
 =09=09=09    struct inode *);
--=20
2.17.2

