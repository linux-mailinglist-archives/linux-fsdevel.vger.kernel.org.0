Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6D118835
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLJMcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:32:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727564AbfLJMb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3h47F9KVVCgqlU/luhc3CGH9JhlY0FncpvhrelnQTF0=;
        b=SALOB/+WFs0wu8P5URc+mLy4m8JnVsoofqs1p96s9eOtTErYfsSyF9KQ2OyTei464fTc8S
        JPT0HZFz5O4Ec6klR8E2uynNgpwbUCj39SdiQdT78gSvESlxsXtULMlNIXrYa1uFm0XBUW
        0vIGqPbnT4kOWA2vIKa0Xl08wT/IzWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-x65W8SZONRaNmgumYz6OBA-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD91801E7A;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788B55C219;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 1A43E20C54; Tue, 10 Dec 2019 07:31:16 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 26/27] NFS: Additional refactoring for fs_context conversion
Date:   Tue, 10 Dec 2019 07:31:14 -0500
Message-Id: <20191210123115.1655-27-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: x65W8SZONRaNmgumYz6OBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

This patch adds additional refactoring for the conversion of NFS to use
fs_context, namely:

 (*) Merge nfs_mount_info and nfs_clone_mount into nfs_fs_context.
     nfs_clone_mount has had several fields removed, and nfs_mount_info
     has been removed altogether.
 (*) Various functions now take an fs_context as an argument instead
     of nfs_mount_info, nfs_fs_context, etc.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/client.c         |  22 +++---
 fs/nfs/fs_context.c     | 155 +++++++++++++++-------------------------
 fs/nfs/fscache.c        |   2 +-
 fs/nfs/getroot.c        |  70 +++++++++---------
 fs/nfs/internal.h       |  53 +++++---------
 fs/nfs/namespace.c      |  14 ++--
 fs/nfs/nfs3_fs.h        |   2 +-
 fs/nfs/nfs3client.c     |   5 +-
 fs/nfs/nfs4client.c     |  62 ++++++++--------
 fs/nfs/nfs4namespace.c  |  23 +++---
 fs/nfs/nfs4super.c      |  19 +++--
 fs/nfs/super.c          |  48 ++++++-------
 include/linux/nfs_xdr.h |   2 +-
 13 files changed, 204 insertions(+), 273 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 69c0708b2acc..8f760f23748c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -658,17 +658,17 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-=09=09=09   const struct nfs_fs_context *ctx,
-=09=09=09   struct nfs_subversion *nfs_mod)
+=09=09=09   const struct fs_context *fc)
 {
+=09const struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct rpc_timeout timeparms;
 =09struct nfs_client_initdata cl_init =3D {
 =09=09.hostname =3D ctx->nfs_server.hostname,
 =09=09.addr =3D (const struct sockaddr *)&ctx->nfs_server.address,
 =09=09.addrlen =3D ctx->nfs_server.addrlen,
-=09=09.nfs_mod =3D nfs_mod,
+=09=09.nfs_mod =3D ctx->nfs_mod,
 =09=09.proto =3D ctx->nfs_server.protocol,
-=09=09.net =3D ctx->net,
+=09=09.net =3D fc->net_ns,
 =09=09.timeparms =3D &timeparms,
 =09=09.cred =3D server->cred,
 =09=09.nconnect =3D ctx->nfs_server.nconnect,
@@ -951,10 +951,10 @@ EXPORT_SYMBOL_GPL(nfs_free_server);
  * Create a version 2 or 3 volume record
  * - keyed on server and FSID
  */
-struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs_create_server(struct fs_context *fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct nfs_server *server;
-=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
 =09struct nfs_fattr *fattr;
 =09int error;
=20
@@ -970,18 +970,18 @@ struct nfs_server *nfs_create_server(struct nfs_mount=
_info *mount_info)
 =09=09goto error;
=20
 =09/* Get a client representation */
-=09error =3D nfs_init_server(server, mount_info->ctx, nfs_mod);
+=09error =3D nfs_init_server(server, fc);
 =09if (error < 0)
 =09=09goto error;
=20
 =09/* Probe the root fh to retrieve its FSID */
-=09error =3D nfs_probe_fsinfo(server, mount_info->mntfh, fattr);
+=09error =3D nfs_probe_fsinfo(server, ctx->mntfh, fattr);
 =09if (error < 0)
 =09=09goto error;
 =09if (server->nfs_client->rpc_ops->version =3D=3D 3) {
 =09=09if (server->namelen =3D=3D 0 || server->namelen > NFS3_MAXNAMLEN)
 =09=09=09server->namelen =3D NFS3_MAXNAMLEN;
-=09=09if (!(mount_info->ctx->flags & NFS_MOUNT_NORDIRPLUS))
+=09=09if (!(ctx->flags & NFS_MOUNT_NORDIRPLUS))
 =09=09=09server->caps |=3D NFS_CAP_READDIRPLUS;
 =09} else {
 =09=09if (server->namelen =3D=3D 0 || server->namelen > NFS2_MAXNAMLEN)
@@ -989,8 +989,8 @@ struct nfs_server *nfs_create_server(struct nfs_mount_i=
nfo *mount_info)
 =09}
=20
 =09if (!(fattr->valid & NFS_ATTR_FATTR)) {
-=09=09error =3D nfs_mod->rpc_ops->getattr(server, mount_info->mntfh,
-=09=09=09=09fattr, NULL, NULL);
+=09=09error =3D ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
+=09=09=09=09=09=09       fattr, NULL, NULL);
 =09=09if (error < 0) {
 =09=09=09dprintk("nfs_create_server: getattr error =3D %d\n", -error);
 =09=09=09goto error;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ac1a8d7d7393..e472334b978d 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -241,43 +241,6 @@ static const struct constant_table nfs_secflavor_token=
s[] =3D {
 =09{ "sys",=09Opt_sec_sys },
 };
=20
-struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
-{
-=09struct nfs_fs_context *ctx;
-
-=09ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
-=09if (ctx) {
-=09=09ctx->timeo=09=09=3D NFS_UNSPEC_TIMEO;
-=09=09ctx->retrans=09=09=3D NFS_UNSPEC_RETRANS;
-=09=09ctx->acregmin=09=09=3D NFS_DEF_ACREGMIN;
-=09=09ctx->acregmax=09=09=3D NFS_DEF_ACREGMAX;
-=09=09ctx->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
-=09=09ctx->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
-=09=09ctx->mount_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09ctx->nfs_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09ctx->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
-=09=09ctx->minorversion=09=3D 0;
-=09=09ctx->need_mount=09=3D true;
-=09=09ctx->net=09=09=3D current->nsproxy->net_ns;
-=09=09ctx->lsm_opts =3D NULL;
-=09}
-=09return ctx;
-}
-
-void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx)
-{
-=09if (ctx) {
-=09=09kfree(ctx->client_address);
-=09=09kfree(ctx->mount_server.hostname);
-=09=09kfree(ctx->nfs_server.export_path);
-=09=09kfree(ctx->nfs_server.hostname);
-=09=09kfree(ctx->fscache_uniq);
-=09=09security_free_mnt_opts(&ctx->lsm_opts);
-=09=09kfree(ctx);
-=09}
-}
-
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -342,7 +305,7 @@ static void nfs_set_mount_transport_protocol(struct nfs=
_fs_context *ctx)
  * Add 'flavor' to 'auth_info' if not already present.
  * Returns true if 'flavor' ends up in the list, false otherwise
  */
-static int nfs_auth_info_add(struct nfs_fs_context *ctx,
+static int nfs_auth_info_add(struct fs_context *fc,
 =09=09=09     struct nfs_auth_info *auth_info,
 =09=09=09     rpc_authflavor_t flavor)
 {
@@ -367,9 +330,10 @@ static int nfs_auth_info_add(struct nfs_fs_context *ct=
x,
 /*
  * Parse the value of the 'sec=3D' option.
  */
-static int nfs_parse_security_flavors(struct nfs_fs_context *ctx,
+static int nfs_parse_security_flavors(struct fs_context *fc,
 =09=09=09=09      struct fs_parameter *param)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09rpc_authflavor_t pseudoflavor;
 =09char *string =3D param->string, *p;
 =09int ret;
@@ -419,7 +383,7 @@ static int nfs_parse_security_flavors(struct nfs_fs_con=
text *ctx,
 =09=09=09return -EINVAL;
 =09=09}
=20
-=09=09ret =3D nfs_auth_info_add(ctx, &ctx->auth_info, pseudoflavor);
+=09=09ret =3D nfs_auth_info_add(fc, &ctx->auth_info, pseudoflavor);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09}
@@ -427,9 +391,11 @@ static int nfs_parse_security_flavors(struct nfs_fs_co=
ntext *ctx,
 =09return 0;
 }
=20
-static int nfs_parse_version_string(struct nfs_fs_context *ctx,
+static int nfs_parse_version_string(struct fs_context *fc,
 =09=09=09=09    const char *string)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+
 =09ctx->flags &=3D ~NFS_MOUNT_VER3;
 =09switch (lookup_constant(nfs_vers_tokens, string, -1)) {
 =09case Opt_vers_2:
@@ -656,17 +622,17 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
 =09=09 * options that take text values
 =09=09 */
 =09case Opt_v:
-=09=09ret =3D nfs_parse_version_string(ctx, param->key + 1);
+=09=09ret =3D nfs_parse_version_string(fc, param->key + 1);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09=09break;
 =09case Opt_vers:
-=09=09ret =3D nfs_parse_version_string(ctx, param->string);
+=09=09ret =3D nfs_parse_version_string(fc, param->string);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09=09break;
 =09case Opt_sec:
-=09=09ret =3D nfs_parse_security_flavors(ctx, param);
+=09=09ret =3D nfs_parse_security_flavors(fc, param);
 =09=09if (ret < 0)
 =09=09=09return ret;
 =09=09break;
@@ -729,7 +695,7 @@ static int nfs_fs_context_parse_param(struct fs_context=
 *fc,
 =09=09break;
=20
 =09case Opt_addr:
-=09=09len =3D rpc_pton(ctx->net, param->string, param->size,
+=09=09len =3D rpc_pton(fc->net_ns, param->string, param->size,
 =09=09=09       &ctx->nfs_server.address,
 =09=09=09       sizeof(ctx->nfs_server._address));
 =09=09if (len =3D=3D 0)
@@ -747,7 +713,7 @@ static int nfs_fs_context_parse_param(struct fs_context=
 *fc,
 =09=09param->string =3D NULL;
 =09=09break;
 =09case Opt_mountaddr:
-=09=09len =3D rpc_pton(ctx->net, param->string, param->size,
+=09=09len =3D rpc_pton(fc->net_ns, param->string, param->size,
 =09=09=09       &ctx->mount_server.address,
 =09=09=09       sizeof(ctx->mount_server._address));
 =09=09if (len =3D=3D 0)
@@ -819,7 +785,7 @@ static int nfs_fs_context_parse_param(struct fs_context=
 *fc,
 }
=20
 /*
- * Split "dev_name" into "hostname:export_path".
+ * Split fc->source into "hostname:export_path".
  *
  * The leftmost colon demarks the split between the server's hostname
  * and the export path.  If the hostname starts with a left square
@@ -827,12 +793,13 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
  *
  * Note: caller frees hostname and export path, even on error.
  */
-static int nfs_parse_devname(struct nfs_fs_context *ctx,
-=09=09=09     const char *dev_name,
-=09=09=09     size_t maxnamlen, size_t maxpathlen)
+static int nfs_parse_source(struct fs_context *fc,
+=09=09=09    size_t maxnamlen, size_t maxpathlen)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09const char *dev_name =3D fc->source;
 =09size_t len;
-=09char *end;
+=09const char *end;
=20
 =09if (unlikely(!dev_name || !*dev_name)) {
 =09=09dfprintk(MOUNT, "NFS: device name not specified\n");
@@ -848,7 +815,7 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx=
,
 =09=09len =3D end - dev_name;
 =09=09end++;
 =09} else {
-=09=09char *comma;
+=09=09const char *comma;
=20
 =09=09end =3D strchr(dev_name, ':');
 =09=09if (end =3D=3D NULL)
@@ -856,8 +823,8 @@ static int nfs_parse_devname(struct nfs_fs_context *ctx=
,
 =09=09len =3D end - dev_name;
=20
 =09=09/* kill possible hostname list: not supported */
-=09=09comma =3D strchr(dev_name, ',');
-=09=09if (comma !=3D NULL && comma < end)
+=09=09comma =3D memchr(dev_name, ',', len);
+=09=09if (comma)
 =09=09=09len =3D comma - dev_name;
 =09}
=20
@@ -920,7 +887,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc=
,
 =09=09=09=09  struct nfs_mount_data *data)
 {
 =09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
-=09struct nfs_fh *mntfh =3D ctx->mount_info.mntfh;
+=09struct nfs_fh *mntfh =3D ctx->mntfh;
 =09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
 =09int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
=20
@@ -1009,6 +976,7 @@ static int nfs23_parse_monolithic(struct fs_context *f=
c,
 =09=09else
 =09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
 =09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+
 =09=09/*
 =09=09 * The legacy version 6 binary mount data from userspace has a
 =09=09 * field used only to transport selinux information into the
@@ -1073,12 +1041,6 @@ static int nfs23_parse_monolithic(struct fs_context =
*fc,
 }
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
-static void nfs4_validate_mount_flags(struct nfs_fs_context *ctx)
-{
-=09ctx->flags &=3D ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
-=09=09=09 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
-}
-
 /*
  * Validate NFSv4 mount options
  */
@@ -1251,20 +1213,22 @@ static int nfs_fs_context_validate(struct fs_contex=
t *fc)
 =09=09goto out_no_address;
=20
 =09if (ctx->version =3D=3D 4) {
-#if IS_ENABLED(CONFIG_NFS_V4)
-=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
-=09=09=09port =3D NFS_RDMA_PORT;
-=09=09else
-=09=09=09port =3D NFS_PORT;
-=09=09max_namelen =3D NFS4_MAXNAMLEN;
-=09=09max_pathlen =3D NFS4_MAXPATHLEN;
-=09=09nfs_validate_transport_protocol(ctx);
-=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
-=09=09=09goto out_invalid_transport_udp;
-=09=09nfs4_validate_mount_flags(ctx);
-#else
-=09=09goto out_v4_not_compiled;
-#endif /* CONFIG_NFS_V4 */
+=09=09if (IS_ENABLED(CONFIG_NFS_V4)) {
+=09=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
+=09=09=09=09port =3D NFS_RDMA_PORT;
+=09=09=09else
+=09=09=09=09port =3D NFS_PORT;
+=09=09=09max_namelen =3D NFS4_MAXNAMLEN;
+=09=09=09max_pathlen =3D NFS4_MAXPATHLEN;
+=09=09=09nfs_validate_transport_protocol(ctx);
+=09=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
+=09=09=09=09goto out_invalid_transport_udp;
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_NONLM | NFS_MOUNT_NOACL |
+=09=09=09=09=09NFS_MOUNT_VER3 | NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09} else {
+=09=09=09goto out_v4_not_compiled;
+=09=09}
 =09} else {
 =09=09nfs_set_mount_transport_protocol(ctx);
 =09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
@@ -1273,33 +1237,30 @@ static int nfs_fs_context_validate(struct fs_contex=
t *fc)
=20
 =09nfs_set_port(sap, &ctx->nfs_server.port, port);
=20
-=09ret =3D nfs_parse_devname(ctx, fc->source, max_namelen, max_pathlen);
+=09ret =3D nfs_parse_source(fc, max_namelen, max_pathlen);
 =09if (ret < 0)
 =09=09return ret;
=20
 =09/* Load the NFS protocol module if we haven't done so yet */
-=09if (!ctx->mount_info.nfs_mod) {
+=09if (!ctx->nfs_mod) {
 =09=09nfs_mod =3D get_nfs_version(ctx->version);
 =09=09if (IS_ERR(nfs_mod)) {
 =09=09=09ret =3D PTR_ERR(nfs_mod);
 =09=09=09goto out_version_unavailable;
 =09=09}
-=09=09ctx->mount_info.nfs_mod =3D nfs_mod;
+=09=09ctx->nfs_mod =3D nfs_mod;
 =09}
 =09return 0;
=20
 out_no_device_name:
 =09dfprintk(MOUNT, "NFS: Device name not specified\n");
 =09return -EINVAL;
-#if !IS_ENABLED(CONFIG_NFS_V4)
 out_v4_not_compiled:
 =09dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
 =09return -EPROTONOSUPPORT;
-#else
 out_invalid_transport_udp:
 =09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 =09return -EINVAL;
-#endif /* !CONFIG_NFS_V4 */
 out_no_address:
 =09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
 =09return -EINVAL;
@@ -1332,7 +1293,7 @@ static int nfs_get_tree(struct fs_context *fc)
 =09if (err)
 =09=09return err;
 =09if (!ctx->internal)
-=09=09return ctx->mount_info.nfs_mod->rpc_ops->try_get_tree(fc);
+=09=09return ctx->nfs_mod->rpc_ops->try_get_tree(fc);
 =09else
 =09=09return nfs_get_tree_common(fc);
 }
@@ -1351,20 +1312,19 @@ static int nfs_fs_context_dup(struct fs_context *fc=
, struct fs_context *src_fc)
 =09if (!ctx)
 =09=09return -ENOMEM;
=20
-=09ctx->mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (!ctx->mount_info.mntfh) {
+=09ctx->mntfh =3D nfs_alloc_fhandle();
+=09if (!ctx->mntfh) {
 =09=09kfree(ctx);
 =09=09return -ENOMEM;
 =09}
-=09nfs_copy_fh(ctx->mount_info.mntfh, src->mount_info.mntfh);
+=09nfs_copy_fh(ctx->mntfh, src->mntfh);
=20
-=09__module_get(ctx->mount_info.nfs_mod->owner);
+=09__module_get(ctx->nfs_mod->owner);
 =09ctx->client_address=09=09=3D NULL;
 =09ctx->mount_server.hostname=09=3D NULL;
 =09ctx->nfs_server.export_path=09=3D NULL;
 =09ctx->nfs_server.hostname=09=3D NULL;
 =09ctx->fscache_uniq=09=09=3D NULL;
-=09ctx->clone_data.addr=09=09=3D NULL;
 =09ctx->clone_data.fattr=09=09=3D NULL;
 =09fc->fs_private =3D ctx;
 =09return 0;
@@ -1375,17 +1335,16 @@ static void nfs_fs_context_free(struct fs_context *=
fc)
 =09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
=20
 =09if (ctx) {
-=09=09if (ctx->mount_info.server)
-=09=09=09nfs_free_server(ctx->mount_info.server);
-=09=09if (ctx->mount_info.nfs_mod)
-=09=09=09put_nfs_version(ctx->mount_info.nfs_mod);
+=09=09if (ctx->server)
+=09=09=09nfs_free_server(ctx->server);
+=09=09if (ctx->nfs_mod)
+=09=09=09put_nfs_version(ctx->nfs_mod);
 =09=09kfree(ctx->client_address);
 =09=09kfree(ctx->mount_server.hostname);
 =09=09kfree(ctx->nfs_server.export_path);
 =09=09kfree(ctx->nfs_server.hostname);
 =09=09kfree(ctx->fscache_uniq);
-=09=09nfs_free_fhandle(ctx->mount_info.mntfh);
-=09=09kfree(ctx->clone_data.addr);
+=09=09nfs_free_fhandle(ctx->mntfh);
 =09=09nfs_free_fattr(ctx->clone_data.fattr);
 =09=09kfree(ctx);
 =09}
@@ -1413,9 +1372,8 @@ static int nfs_init_fs_context(struct fs_context *fc)
 =09if (unlikely(!ctx))
 =09=09return -ENOMEM;
=20
-=09ctx->mount_info.ctx =3D ctx;
-=09ctx->mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (unlikely(!ctx->mount_info.mntfh)) {
+=09ctx->mntfh =3D nfs_alloc_fhandle();
+=09if (unlikely(!ctx->mntfh)) {
 =09=09kfree(ctx);
 =09=09return -ENOMEM;
 =09}
@@ -1452,8 +1410,8 @@ static int nfs_init_fs_context(struct fs_context *fc)
 =09=09=09fc->net_ns =3D get_net(net);
 =09=09}
=20
-=09=09ctx->mount_info.nfs_mod =3D nfss->nfs_client->cl_nfs_mod;
-=09=09__module_get(ctx->mount_info.nfs_mod->owner);
+=09=09ctx->nfs_mod =3D nfss->nfs_client->cl_nfs_mod;
+=09=09__module_get(ctx->nfs_mod->owner);
 =09} else {
 =09=09/* defaults */
 =09=09ctx->timeo=09=09=3D NFS_UNSPEC_TIMEO;
@@ -1468,7 +1426,6 @@ static int nfs_init_fs_context(struct fs_context *fc)
 =09=09ctx->minorversion=09=3D 0;
 =09=09ctx->need_mount=09=09=3D true;
 =09}
-=09ctx->net =3D fc->net_ns;
 =09fc->fs_private =3D ctx;
 =09fc->ops =3D &nfs_fs_context_ops;
 =09return 0;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 3800ab6f08fa..4a8df8c30a03 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -128,7 +128,7 @@ void nfs_fscache_get_super_cookie(struct super_block *s=
b, const char *uniq, int
 =09=09return;
=20
 =09key->nfs_client =3D nfss->nfs_client;
-=09key->key.super.s_flags =3D sb->s_flags & NFS_MS_MASK;
+=09key->key.super.s_flags =3D sb->s_flags & NFS_SB_MASK;
 =09key->key.nfs_server.flags =3D nfss->flags;
 =09key->key.nfs_server.rsize =3D nfss->rsize;
 =09key->key.nfs_server.wsize =3D nfss->wsize;
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 878c4c5982d9..ab45496d23a6 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -64,66 +64,68 @@ static int nfs_superblock_set_dummy_root(struct super_b=
lock *sb, struct inode *i
 /*
  * get an NFS2/NFS3 root dentry from the root filehandle
  */
-struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh,
-=09=09=09    const char *devname)
+int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
-=09struct nfs_server *server =3D NFS_SB(sb);
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
+=09struct nfs_server *server =3D NFS_SB(s);
 =09struct nfs_fsinfo fsinfo;
-=09struct dentry *ret;
+=09struct dentry *root;
 =09struct inode *inode;
-=09void *name =3D kstrdup(devname, GFP_KERNEL);
-=09int error;
+=09char *name;
+=09int error =3D -ENOMEM;
=20
+=09name =3D kstrdup(fc->source, GFP_KERNEL);
 =09if (!name)
-=09=09return ERR_PTR(-ENOMEM);
+=09=09goto out;
=20
 =09/* get the actual root for this mount */
 =09fsinfo.fattr =3D nfs_alloc_fattr();
-=09if (fsinfo.fattr =3D=3D NULL) {
-=09=09kfree(name);
-=09=09return ERR_PTR(-ENOMEM);
-=09}
+=09if (fsinfo.fattr =3D=3D NULL)
+=09=09goto out_name;
=20
-=09error =3D server->nfs_client->rpc_ops->getroot(server, mntfh, &fsinfo);
+=09error =3D server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsi=
nfo);
 =09if (error < 0) {
 =09=09dprintk("nfs_get_root: getattr error =3D %d\n", -error);
-=09=09ret =3D ERR_PTR(error);
-=09=09goto out;
+=09=09goto out_fattr;
 =09}
=20
-=09inode =3D nfs_fhget(sb, mntfh, fsinfo.fattr, NULL);
+=09inode =3D nfs_fhget(s, ctx->mntfh, fsinfo.fattr, NULL);
 =09if (IS_ERR(inode)) {
 =09=09dprintk("nfs_get_root: get root inode failed\n");
-=09=09ret =3D ERR_CAST(inode);
-=09=09goto out;
+=09=09error =3D PTR_ERR(inode);
+=09=09goto out_fattr;
 =09}
=20
-=09error =3D nfs_superblock_set_dummy_root(sb, inode);
-=09if (error !=3D 0) {
-=09=09ret =3D ERR_PTR(error);
-=09=09goto out;
-=09}
+=09error =3D nfs_superblock_set_dummy_root(s, inode);
+=09if (error !=3D 0)
+=09=09goto out_fattr;
=20
 =09/* root dentries normally start off anonymous and get spliced in later
 =09 * if the dentry tree reaches them; however if the dentry already
 =09 * exists, we'll pick it up at this point and use it as the root
 =09 */
-=09ret =3D d_obtain_root(inode);
-=09if (IS_ERR(ret)) {
+=09root =3D d_obtain_root(inode);
+=09if (IS_ERR(root)) {
 =09=09dprintk("nfs_get_root: get root dentry failed\n");
-=09=09goto out;
+=09=09error =3D PTR_ERR(root);
+=09=09goto out_fattr;
 =09}
=20
-=09security_d_instantiate(ret, inode);
-=09spin_lock(&ret->d_lock);
-=09if (IS_ROOT(ret) && !ret->d_fsdata &&
-=09    !(ret->d_flags & DCACHE_NFSFS_RENAMED)) {
-=09=09ret->d_fsdata =3D name;
+=09security_d_instantiate(root, inode);
+=09spin_lock(&root->d_lock);
+=09if (IS_ROOT(root) && !root->d_fsdata &&
+=09    !(root->d_flags & DCACHE_NFSFS_RENAMED)) {
+=09=09root->d_fsdata =3D name;
 =09=09name =3D NULL;
 =09}
-=09spin_unlock(&ret->d_lock);
-out:
-=09kfree(name);
+=09spin_unlock(&root->d_lock);
+=09fc->root =3D root;
+=09error =3D 0;
+
+out_fattr:
 =09nfs_free_fattr(fsinfo.fattr);
-=09return ret;
+out_name:
+=09kfree(name);
+out:
+=09return error;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1cd09df9e0b5..a1fd4c3ebc4e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -11,7 +11,7 @@
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
=20
-#define NFS_MS_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS=
)
+#define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS=
)
=20
 extern const struct export_operations nfs_export_ops;
=20
@@ -33,17 +33,6 @@ static inline int nfs_attr_use_mounted_on_fileid(struct =
nfs_fattr *fattr)
 =09return 1;
 }
=20
-struct nfs_clone_mount {
-=09const struct super_block *sb;
-=09struct dentry *dentry;
-=09char *hostname;
-=09char *mnt_path;
-=09struct sockaddr *addr;
-=09size_t addrlen;
-=09rpc_authflavor_t authflavor;
-=09struct nfs_fattr *fattr;
-};
-
 /*
  * Note: RFC 1813 doesn't limit the number of auth flavors that
  * a server can return, so make something up.
@@ -80,15 +69,6 @@ struct nfs_client_initdata {
 =09const struct cred *cred;
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
 /*
  * In-kernel mount arguments
  */
@@ -140,13 +120,17 @@ struct nfs_fs_context {
 =09=09unsigned short=09=09export_path_len;
 =09} nfs_server;
=20
-=09void=09=09=09*lsm_opts;
-=09struct net=09=09*net;
-
-=09char=09=09=09buf[32];=09/* Parse buffer */
-
-=09struct nfs_mount_info=09mount_info;
-=09struct nfs_clone_mount=09clone_data;
+=09struct nfs_fh=09=09*mntfh;
+=09struct nfs_server=09*server;
+=09struct nfs_subversion=09*nfs_mod;
+
+=09/* Information for a cloned mount. */
+=09struct nfs_clone_mount {
+=09=09struct super_block=09*sb;
+=09=09struct dentry=09=09*dentry;
+=09=09struct nfs_fattr=09*fattr;
+=09=09unsigned int=09=09inherited_bsize;
+=09} clone_data;
 };
=20
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_contex=
t *fc)
@@ -194,10 +178,9 @@ extern struct nfs_client *nfs4_find_client_ident(struc=
t net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 =09=09=09=09struct nfs4_sessionid *, u32);
-extern struct nfs_server *nfs_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_server(struct nfs_mount_info *);
-extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mou=
nt *,
-=09=09=09=09=09=09      struct nfs_fh *);
+extern struct nfs_server *nfs_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_server(struct fs_context *);
+extern struct nfs_server *nfs4_create_referral_server(struct fs_context *)=
;
 extern int nfs4_update_server(struct nfs_server *server, const char *hostn=
ame,
 =09=09=09=09=09struct sockaddr *sap, size_t salen,
 =09=09=09=09=09struct net *net);
@@ -444,12 +427,8 @@ int nfs_submount(struct fs_context *, struct nfs_serve=
r *);
 int nfs_do_submount(struct fs_context *);
=20
 /* getroot.c */
-extern struct dentry *nfs_get_root(struct super_block *, struct nfs_fh *,
-=09=09=09=09   const char *);
+extern int nfs_get_root(struct super_block *s, struct fs_context *fc);
 #if IS_ENABLED(CONFIG_NFS_V4)
-extern struct dentry *nfs4_get_root(struct super_block *, struct nfs_fh *,
-=09=09=09=09    const char *);
-
 extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh=
, bool);
 #endif
=20
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9b344fcd23b0..d537350c1fb7 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -176,8 +176,8 @@ struct vfsmount *nfs_d_automount(struct path *path)
=20
 =09ctx->version=09=09=3D client->rpc_ops->version;
 =09ctx->minorversion=09=3D client->cl_minorversion;
-=09ctx->mount_info.nfs_mod=09=3D client->cl_nfs_mod;
-=09__module_get(ctx->mount_info.nfs_mod->owner);
+=09ctx->nfs_mod=09=09=3D client->cl_nfs_mod;
+=09__module_get(ctx->nfs_mod->owner);
=20
 =09ret =3D client->rpc_ops->submount(fc, server);
 =09if (ret < 0) {
@@ -262,22 +262,22 @@ int nfs_do_submount(struct fs_context *fc)
 =09int ret;
=20
 =09/* create a new volume representation */
-=09server =3D ctx->mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(ctx->c=
lone_data.sb),
-=09=09=09=09=09=09     ctx->mount_info.mntfh,
+=09server =3D ctx->nfs_mod->rpc_ops->clone_server(NFS_SB(ctx->clone_data.s=
b),
+=09=09=09=09=09=09     ctx->mntfh,
 =09=09=09=09=09=09     ctx->clone_data.fattr,
 =09=09=09=09=09=09     ctx->selected_flavor);
=20
 =09if (IS_ERR(server))
 =09=09return PTR_ERR(server);
=20
-=09ctx->mount_info.server =3D server;
+=09ctx->server =3D server;
=20
 =09buffer =3D kmalloc(4096, GFP_USER);
 =09if (!buffer)
 =09=09return -ENOMEM;
=20
 =09ctx->internal=09=09=3D true;
-=09ctx->mount_info.inherited_bsize =3D ctx->clone_data.sb->s_blocksize_bit=
s;
+=09ctx->clone_data.inherited_bsize =3D ctx->clone_data.sb->s_blocksize_bit=
s;
=20
 =09p =3D nfs_devname(dentry, buffer, 4096);
 =09if (IS_ERR(p)) {
@@ -302,7 +302,7 @@ int nfs_submount(struct fs_context *fc, struct nfs_serv=
er *server)
=20
 =09/* Look it up again to get its attributes */
 =09err =3D server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d=
_name,
-=09=09=09=09=09=09  ctx->mount_info.mntfh, ctx->clone_data.fattr,
+=09=09=09=09=09=09  ctx->mntfh, ctx->clone_data.fattr,
 =09=09=09=09=09=09  NULL);
 =09dput(parent);
 =09if (err !=3D 0)
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index 09602dc1889f..1b950b66b3bb 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -27,7 +27,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, =
struct posix_acl *acl,
 #endif /* CONFIG_NFS_V3_ACL */
=20
 /* nfs3client.c */
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *);
+struct nfs_server *nfs3_create_server(struct fs_context *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 =09=09=09=09     struct nfs_fattr *, rpc_authflavor_t);
=20
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 54727d3d3042..5601e47360c2 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -46,9 +46,10 @@ static inline void nfs_init_server_aclclient(struct nfs_=
server *server)
 }
 #endif
=20
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs3_create_server(struct fs_context *fc)
 {
-=09struct nfs_server *server =3D nfs_create_server(mount_info);
+=09struct nfs_server *server =3D nfs_create_server(fc);
+
 =09/* Create a client RPC handle for the NFS v3 ACL management interface *=
/
 =09if (!IS_ERR(server))
 =09=09nfs_init_server_aclclient(server);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 2216d166768b..0cd767e5c977 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1055,9 +1055,9 @@ static int nfs4_server_common_setup(struct nfs_server=
 *server,
 /*
  * Create a version 4 volume record
  */
-static int nfs4_init_server(struct nfs_server *server,
-=09=09=09    struct nfs_fs_context *ctx)
+static int nfs4_init_server(struct nfs_server *server, struct fs_context *=
fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct rpc_timeout timeparms;
 =09int error;
=20
@@ -1079,15 +1079,15 @@ static int nfs4_init_server(struct nfs_server *serv=
er,
=20
 =09/* Get a client record */
 =09error =3D nfs4_set_client(server,
-=09=09=09ctx->nfs_server.hostname,
-=09=09=09(const struct sockaddr *)&ctx->nfs_server.address,
-=09=09=09ctx->nfs_server.addrlen,
-=09=09=09ctx->client_address,
-=09=09=09ctx->nfs_server.protocol,
-=09=09=09&timeparms,
-=09=09=09ctx->minorversion,
-=09=09=09ctx->nfs_server.nconnect,
-=09=09=09ctx->net);
+=09=09=09=09ctx->nfs_server.hostname,
+=09=09=09=09&ctx->nfs_server.address,
+=09=09=09=09ctx->nfs_server.addrlen,
+=09=09=09=09ctx->client_address,
+=09=09=09=09ctx->nfs_server.protocol,
+=09=09=09=09&timeparms,
+=09=09=09=09ctx->minorversion,
+=09=09=09=09ctx->nfs_server.nconnect,
+=09=09=09=09fc->net_ns);
 =09if (error < 0)
 =09=09return error;
=20
@@ -1110,10 +1110,9 @@ static int nfs4_init_server(struct nfs_server *serve=
r,
  * Create a version 4 volume record
  * - keyed on server and FSID
  */
-/*struct nfs_server *nfs4_create_server(const struct nfs_fs_context *data,
-=09=09=09=09      struct nfs_fh *mntfh)*/
-struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
+struct nfs_server *nfs4_create_server(struct fs_context *fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct nfs_server *server;
 =09bool auth_probe;
 =09int error;
@@ -1124,14 +1123,14 @@ struct nfs_server *nfs4_create_server(struct nfs_mo=
unt_info *mount_info)
=20
 =09server->cred =3D get_cred(current_cred());
=20
-=09auth_probe =3D mount_info->ctx->auth_info.flavor_len < 1;
+=09auth_probe =3D ctx->auth_info.flavor_len < 1;
=20
 =09/* set up the general RPC client */
-=09error =3D nfs4_init_server(server, mount_info->ctx);
+=09error =3D nfs4_init_server(server, fc);
 =09if (error < 0)
 =09=09goto error;
=20
-=09error =3D nfs4_server_common_setup(server, mount_info->mntfh, auth_prob=
e);
+=09error =3D nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 =09if (error < 0)
 =09=09goto error;
=20
@@ -1145,9 +1144,9 @@ struct nfs_server *nfs4_create_server(struct nfs_moun=
t_info *mount_info)
 /*
  * Create an NFS4 referral server record
  */
-struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *dat=
a,
-=09=09=09=09=09       struct nfs_fh *mntfh)
+struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct nfs_client *parent_client;
 =09struct nfs_server *server, *parent_server;
 =09bool auth_probe;
@@ -1157,7 +1156,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 nfs_clone_mount *data,
 =09if (!server)
 =09=09return ERR_PTR(-ENOMEM);
=20
-=09parent_server =3D NFS_SB(data->sb);
+=09parent_server =3D NFS_SB(ctx->clone_data.sb);
 =09parent_client =3D parent_server->nfs_client;
=20
 =09server->cred =3D get_cred(parent_server->cred);
@@ -1167,10 +1166,11 @@ struct nfs_server *nfs4_create_referral_server(stru=
ct nfs_clone_mount *data,
=20
 =09/* Get a client representation */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-=09rpc_set_port(data->addr, NFS_RDMA_PORT);
-=09error =3D nfs4_set_client(server, data->hostname,
-=09=09=09=09data->addr,
-=09=09=09=09data->addrlen,
+=09rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+=09error =3D nfs4_set_client(server,
+=09=09=09=09ctx->nfs_server.hostname,
+=09=09=09=09&ctx->nfs_server.address,
+=09=09=09=09ctx->nfs_server.addrlen,
 =09=09=09=09parent_client->cl_ipaddr,
 =09=09=09=09XPRT_TRANSPORT_RDMA,
 =09=09=09=09parent_server->client->cl_timeout,
@@ -1181,10 +1181,11 @@ struct nfs_server *nfs4_create_referral_server(stru=
ct nfs_clone_mount *data,
 =09=09goto init_server;
 #endif=09/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
=20
-=09rpc_set_port(data->addr, NFS_PORT);
-=09error =3D nfs4_set_client(server, data->hostname,
-=09=09=09=09data->addr,
-=09=09=09=09data->addrlen,
+=09rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
+=09error =3D nfs4_set_client(server,
+=09=09=09=09ctx->nfs_server.hostname,
+=09=09=09=09&ctx->nfs_server.address,
+=09=09=09=09ctx->nfs_server.addrlen,
 =09=09=09=09parent_client->cl_ipaddr,
 =09=09=09=09XPRT_TRANSPORT_TCP,
 =09=09=09=09parent_server->client->cl_timeout,
@@ -1197,13 +1198,14 @@ struct nfs_server *nfs4_create_referral_server(stru=
ct nfs_clone_mount *data,
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 init_server:
 #endif
-=09error =3D nfs_init_server_rpcclient(server, parent_server->client->cl_t=
imeout, data->authflavor);
+=09error =3D nfs_init_server_rpcclient(server, parent_server->client->cl_t=
imeout,
+=09=09=09=09=09  ctx->selected_flavor);
 =09if (error < 0)
 =09=09goto error;
=20
 =09auth_probe =3D parent_server->auth_info.flavor_len < 1;
=20
-=09error =3D nfs4_server_common_setup(server, mntfh, auth_probe);
+=09error =3D nfs4_server_common_setup(server, ctx->mntfh, auth_probe);
 =09if (error < 0)
 =09=09goto error;
=20
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index a1a0c4c53ce1..10e9e1887841 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -130,9 +130,10 @@ static int nfs4_validate_fspath(struct dentry *dentry,
 =09=09=09=09const struct nfs4_fs_locations *locations,
 =09=09=09=09struct nfs_fs_context *ctx)
 {
-=09const char *path, *fs_path;
-=09char *buf;
+=09const char *path;
+=09char *fs_path;
 =09unsigned short len;
+=09char *buf;
 =09int n;
=20
 =09buf =3D kmalloc(4096, GFP_KERNEL);
@@ -278,7 +279,6 @@ nfs4_negotiate_security(struct rpc_clnt *clnt, struct i=
node *inode,
 static int try_location(struct fs_context *fc,
 =09=09=09const struct nfs4_fs_location *location)
 {
-=09const size_t addr_bufsize =3D sizeof(struct sockaddr_storage);
 =09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09unsigned int len, s;
 =09char *export_path, *source, *p;
@@ -314,29 +314,24 @@ static int try_location(struct fs_context *fc,
=20
 =09kfree(fc->source);
 =09fc->source =3D source;
-
-=09ctx->clone_data.addr =3D kmalloc(addr_bufsize, GFP_KERNEL);
-=09if (ctx->clone_data.addr =3D=3D NULL)
-=09=09return -ENOMEM;
 =09for (s =3D 0; s < location->nservers; s++) {
 =09=09const struct nfs4_string *buf =3D &location->servers[s];
=20
 =09=09if (memchr(buf->data, IPV6_SCOPE_DELIMITER, buf->len))
 =09=09=09continue;
=20
-=09=09ctx->clone_data.addrlen =3D
+=09=09ctx->nfs_server.addrlen =3D
 =09=09=09nfs_parse_server_name(buf->data, buf->len,
-=09=09=09=09=09      ctx->clone_data.addr,
-=09=09=09=09=09      addr_bufsize,
+=09=09=09=09=09      &ctx->nfs_server.address,
+=09=09=09=09=09      sizeof(ctx->nfs_server._address),
 =09=09=09=09=09      fc->net_ns);
-=09=09if (ctx->clone_data.addrlen =3D=3D 0)
+=09=09if (ctx->nfs_server.addrlen =3D=3D 0)
 =09=09=09continue;
=20
-=09=09rpc_set_port(ctx->clone_data.addr, NFS_PORT);
+=09=09rpc_set_port(&ctx->nfs_server.address, NFS_PORT);
=20
 =09=09memcpy(ctx->nfs_server.hostname, buf->data, buf->len);
 =09=09ctx->nfs_server.hostname[buf->len] =3D '\0';
-=09=09ctx->clone_data.hostname =3D ctx->nfs_server.hostname;
=20
 =09=09p =3D source;
 =09=09memcpy(p, buf->data, buf->len);
@@ -449,7 +444,7 @@ int nfs4_submount(struct fs_context *fc, struct nfs_ser=
ver *server)
 =09int ret;
=20
 =09/* Look it up again to get its attributes and sec flavor */
-=09client =3D nfs4_proc_lookup_mountpoint(dir, name, ctx->mount_info.mntfh=
,
+=09client =3D nfs4_proc_lookup_mountpoint(dir, name, ctx->mntfh,
 =09=09=09=09=09     ctx->clone_data.fattr);
 =09dput(parent);
 =09if (IS_ERR(client))
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 469726410c5c..7d5ed37633d8 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -35,12 +35,12 @@ static const struct super_operations nfs4_sops =3D {
 };
=20
 struct nfs_subversion nfs_v4 =3D {
-=09.owner =3D THIS_MODULE,
-=09.nfs_fs   =3D &nfs4_fs_type,
-=09.rpc_vers =3D &nfs_version4,
-=09.rpc_ops  =3D &nfs_v4_clientops,
-=09.sops     =3D &nfs4_sops,
-=09.xattr    =3D nfs4_xattr_handlers,
+=09.owner=09=09=3D THIS_MODULE,
+=09.nfs_fs=09=09=3D &nfs4_fs_type,
+=09.rpc_vers=09=3D &nfs_version4,
+=09.rpc_ops=09=3D &nfs_v4_clientops,
+=09.sops=09=09=3D &nfs4_sops,
+=09.xattr=09=09=3D nfs4_xattr_handlers,
 };
=20
 static int nfs4_write_inode(struct inode *inode, struct writeback_control =
*wbc)
@@ -168,7 +168,7 @@ static int do_nfs4_mount(struct nfs_server *server,
=20
 =09root_ctx =3D nfs_fc2context(root_fc);
 =09root_ctx->internal =3D true;
-=09root_ctx->mount_info.server =3D server;
+=09root_ctx->server =3D server;
 =09/* We leave export_path unset as it's not used to find the root. */
=20
 =09len =3D strlen(hostname) + 5;
@@ -221,7 +221,7 @@ int nfs4_try_get_tree(struct fs_context *fc)
 =09/* We create a mount for the server's root, walk to the requested
 =09 * location and then create another mount for that.
 =09 */
-=09err=3D do_nfs4_mount(nfs4_create_server(&ctx->mount_info),
+=09err=3D do_nfs4_mount(nfs4_create_server(fc),
 =09=09=09   fc, ctx->nfs_server.hostname,
 =09=09=09   ctx->nfs_server.export_path);
 =09if (err) {
@@ -243,7 +243,7 @@ int nfs4_get_referral_tree(struct fs_context *fc)
 =09dprintk("--> nfs4_referral_mount()\n");
=20
 =09/* create a new volume representation */
-=09err =3D do_nfs4_mount(nfs4_create_referral_server(&ctx->clone_data, ctx=
->mount_info.mntfh),
+=09err =3D do_nfs4_mount(nfs4_create_referral_server(fc),
 =09=09=09    fc, ctx->nfs_server.hostname,
 =09=09=09    ctx->nfs_server.export_path);
 =09if (err) {
@@ -254,7 +254,6 @@ int nfs4_get_referral_tree(struct fs_context *fc)
 =09return err;
 }
=20
-
 static int __init init_nfs_v4(void)
 {
 =09int err;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6ff99da978a8..ed0290d5ebf3 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -745,11 +745,12 @@ static int nfs_verify_authflavors(struct nfs_fs_conte=
xt *ctx,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_fs_context *ctx,
+static int nfs_request_mount(struct fs_context *fc,
 =09=09=09     struct nfs_fh *root_fh,
 =09=09=09     rpc_authflavor_t *server_authlist,
 =09=09=09     unsigned int *server_authlist_len)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct nfs_mount_request request =3D {
 =09=09.sap=09=09=3D (struct sockaddr *)
 =09=09=09=09=09=09&ctx->mount_server.address,
@@ -759,7 +760,7 @@ static int nfs_request_mount(struct nfs_fs_context *ctx=
,
 =09=09.noresvport=09=3D ctx->flags & NFS_MOUNT_NORESVPORT,
 =09=09.auth_flav_len=09=3D server_authlist_len,
 =09=09.auth_flavs=09=3D server_authlist,
-=09=09.net=09=09=3D ctx->net,
+=09=09.net=09=09=3D fc->net_ns,
 =09};
 =09int status;
=20
@@ -804,20 +805,18 @@ static int nfs_request_mount(struct nfs_fs_context *c=
tx,
 =09return 0;
 }
=20
-static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mou=
nt_info)
+static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 {
+=09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09int status;
 =09unsigned int i;
 =09bool tried_auth_unix =3D false;
 =09bool auth_null_in_list =3D false;
 =09struct nfs_server *server =3D ERR_PTR(-EACCES);
-=09struct nfs_fs_context *ctx =3D mount_info->ctx;
 =09rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 =09unsigned int authlist_len =3D ARRAY_SIZE(authlist);
-=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
=20
-=09status =3D nfs_request_mount(ctx, mount_info->mntfh, authlist,
-=09=09=09=09=09&authlist_len);
+=09status =3D nfs_request_mount(fc, ctx->mntfh, authlist, &authlist_len);
 =09if (status)
 =09=09return ERR_PTR(status);
=20
@@ -831,7 +830,7 @@ static struct nfs_server *nfs_try_mount_request(struct =
nfs_mount_info *mount_inf
 =09=09=09 ctx->selected_flavor);
 =09=09if (status)
 =09=09=09return ERR_PTR(status);
-=09=09return nfs_mod->rpc_ops->create_server(mount_info);
+=09=09return ctx->nfs_mod->rpc_ops->create_server(fc);
 =09}
=20
 =09/*
@@ -858,7 +857,7 @@ static struct nfs_server *nfs_try_mount_request(struct =
nfs_mount_info *mount_inf
 =09=09}
 =09=09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 =09=09ctx->selected_flavor =3D flavor;
-=09=09server =3D nfs_mod->rpc_ops->create_server(mount_info);
+=09=09server =3D ctx->nfs_mod->rpc_ops->create_server(fc);
 =09=09if (!IS_ERR(server))
 =09=09=09return server;
 =09}
@@ -874,7 +873,7 @@ static struct nfs_server *nfs_try_mount_request(struct =
nfs_mount_info *mount_inf
 =09/* Last chance! Try AUTH_UNIX */
 =09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNI=
X);
 =09ctx->selected_flavor =3D RPC_AUTH_UNIX;
-=09return nfs_mod->rpc_ops->create_server(mount_info);
+=09return ctx->nfs_mod->rpc_ops->create_server(fc);
 }
=20
 int nfs_try_get_tree(struct fs_context *fc)
@@ -882,9 +881,9 @@ int nfs_try_get_tree(struct fs_context *fc)
 =09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
=20
 =09if (ctx->need_mount)
-=09=09ctx->mount_info.server =3D nfs_try_mount_request(&ctx->mount_info);
+=09=09ctx->server =3D nfs_try_mount_request(fc);
 =09else
-=09=09ctx->mount_info.server =3D ctx->mount_info.nfs_mod->rpc_ops->create_=
server(&ctx->mount_info);
+=09=09ctx->server =3D ctx->nfs_mod->rpc_ops->create_server(fc);
=20
 =09return nfs_get_tree_common(fc);
 }
@@ -966,9 +965,8 @@ EXPORT_SYMBOL_GPL(nfs_reconfigure);
 /*
  * Finish setting up an NFS superblock
  */
-static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *=
mount_info)
+static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *=
ctx)
 {
-=09struct nfs_fs_context *ctx =3D mount_info->ctx;
 =09struct nfs_server *server =3D NFS_SB(sb);
=20
 =09sb->s_blocksize_bits =3D 0;
@@ -1009,13 +1007,14 @@ static void nfs_fill_super(struct super_block *sb, =
struct nfs_mount_info *mount_
 =09nfs_super_set_maxbytes(sb, server->maxfilesize);
 }
=20
-static int nfs_compare_mount_options(const struct super_block *s, const st=
ruct nfs_server *b, int flags)
+static int nfs_compare_mount_options(const struct super_block *s, const st=
ruct nfs_server *b,
+=09=09=09=09     const struct fs_context *fc)
 {
 =09const struct nfs_server *a =3D s->s_fs_info;
 =09const struct rpc_clnt *clnt_a =3D a->client;
 =09const struct rpc_clnt *clnt_b =3D b->client;
=20
-=09if ((s->s_flags & NFS_MS_MASK) !=3D (flags & NFS_MS_MASK))
+=09if ((s->s_flags & NFS_SB_MASK) !=3D (fc->sb_flags & NFS_SB_MASK))
 =09=09goto Ebusy;
 =09if (a->nfs_client !=3D b->nfs_client)
 =09=09goto Ebusy;
@@ -1122,7 +1121,7 @@ static int nfs_compare_super(struct super_block *sb, =
struct fs_context *fc)
 =09=09return 0;
 =09if (!nfs_compare_userns(old, server))
 =09=09return 0;
-=09return nfs_compare_mount_options(sb, server, fc->sb_flags);
+=09return nfs_compare_mount_options(sb, server, fc);
 }
=20
 #ifdef CONFIG_NFS_FSCACHE
@@ -1177,13 +1176,12 @@ int nfs_get_tree_common(struct fs_context *fc)
 {
 =09struct nfs_fs_context *ctx =3D nfs_fc2context(fc);
 =09struct super_block *s;
-=09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
 =09int (*compare_super)(struct super_block *, struct fs_context *) =3D nfs=
_compare_super;
-=09struct nfs_server *server =3D ctx->mount_info.server;
+=09struct nfs_server *server =3D ctx->server;
 =09unsigned long kflags =3D 0, kflags_out =3D 0;
 =09int error;
=20
-=09ctx->mount_info.server =3D NULL;
+=09ctx->server =3D NULL;
 =09if (IS_ERR(server))
 =09=09return PTR_ERR(server);
=20
@@ -1224,9 +1222,9 @@ int nfs_get_tree_common(struct fs_context *fc)
 =09}
=20
 =09if (!s->s_root) {
-=09=09unsigned bsize =3D ctx->mount_info.inherited_bsize;
+=09=09unsigned bsize =3D ctx->clone_data.inherited_bsize;
 =09=09/* initial superblock/root creation */
-=09=09nfs_fill_super(s, &ctx->mount_info);
+=09=09nfs_fill_super(s, ctx);
 =09=09if (bsize) {
 =09=09=09s->s_blocksize_bits =3D bsize;
 =09=09=09s->s_blocksize =3D 1U << bsize;
@@ -1234,13 +1232,11 @@ int nfs_get_tree_common(struct fs_context *fc)
 =09=09nfs_get_cache_cookie(s, ctx);
 =09}
=20
-=09mntroot =3D nfs_get_root(s, ctx->mount_info.mntfh, fc->source);
-=09if (IS_ERR(mntroot)) {
-=09=09error =3D PTR_ERR(mntroot);
+=09error =3D nfs_get_root(s, fc);
+=09if (error < 0) {
 =09=09dfprintk(MOUNT, "NFS: Couldn't get root dentry\n");
 =09=09goto error_splat_super;
 =09}
-=09fc->root =3D mntroot;
=20
 =09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
 =09=09kflags |=3D SECURITY_LSM_NATIVE_LABELS;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 574741d5418d..0a36c6f62b58 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1722,7 +1722,7 @@ struct nfs_rpc_ops {
 =09struct nfs_client *(*init_client) (struct nfs_client *,
 =09=09=09=09const struct nfs_client_initdata *);
 =09void=09(*free_client) (struct nfs_client *);
-=09struct nfs_server *(*create_server)(struct nfs_mount_info *);
+=09struct nfs_server *(*create_server)(struct fs_context *);
 =09struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *=
,
 =09=09=09=09=09   struct nfs_fattr *, rpc_authflavor_t);
 };
--=20
2.17.2

