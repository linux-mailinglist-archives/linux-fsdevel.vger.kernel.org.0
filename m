Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7891D103E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfKTP3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:29:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730248AbfKTP2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GxY2Ar7TWuY7OAQoFyZIjUdOhCoVfa4043j/2cHkjc=;
        b=cizkA6ZfbGMdEyHPysWjx1WJYv03Ikv0i13UMZ1USKp9bmij2lrTYu76JB8Jm0OTzZMeMl
        qm2gvQCHbg5OV+2pSHOT7JQTn5O4sEjfVJRZSGHDZPhvmVWz0NZx+kqe018mD2tGkmw8yM
        fcHMCjeGGQQuHEVsW2TsBC7yRWE0D/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-5-iorxItN32viRxlrYE4vw-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BBAE801E7E;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEC95C1D4;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 801BE20A14; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 18/27] NFS: Rename struct nfs_parsed_mount_data to struct nfs_fs_context
Date:   Wed, 20 Nov 2019 10:27:41 -0500
Message-Id: <20191120152750.6880-19-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5-iorxItN32viRxlrYE4vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Rename struct nfs_parsed_mount_data to struct nfs_fs_context and rename
pointers to it to "ctx".  At some point this will be pointed to by an
fs_context struct's fs_private pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/client.c     |  66 +++----
 fs/nfs/fs_context.c | 446 ++++++++++++++++++++++----------------------
 fs/nfs/internal.h   |  14 +-
 fs/nfs/nfs4client.c |  60 +++---
 fs/nfs/nfs4super.c  |   6 +-
 fs/nfs/super.c      | 194 +++++++++----------
 6 files changed, 393 insertions(+), 393 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 130c065141b3..1afd796a3706 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -648,27 +648,27 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-=09=09=09   const struct nfs_parsed_mount_data *data,
+=09=09=09   const struct nfs_fs_context *cfg,
 =09=09=09   struct nfs_subversion *nfs_mod)
 {
 =09struct rpc_timeout timeparms;
 =09struct nfs_client_initdata cl_init =3D {
-=09=09.hostname =3D data->nfs_server.hostname,
-=09=09.addr =3D (const struct sockaddr *)&data->nfs_server.address,
-=09=09.addrlen =3D data->nfs_server.addrlen,
+=09=09.hostname =3D cfg->nfs_server.hostname,
+=09=09.addr =3D (const struct sockaddr *)&cfg->nfs_server.address,
+=09=09.addrlen =3D cfg->nfs_server.addrlen,
 =09=09.nfs_mod =3D nfs_mod,
-=09=09.proto =3D data->nfs_server.protocol,
-=09=09.net =3D data->net,
+=09=09.proto =3D cfg->nfs_server.protocol,
+=09=09.net =3D cfg->net,
 =09=09.timeparms =3D &timeparms,
 =09=09.cred =3D server->cred,
-=09=09.nconnect =3D data->nfs_server.nconnect,
+=09=09.nconnect =3D cfg->nfs_server.nconnect,
 =09};
 =09struct nfs_client *clp;
 =09int error;
=20
-=09nfs_init_timeout_values(&timeparms, data->nfs_server.protocol,
-=09=09=09data->timeo, data->retrans);
-=09if (data->flags & NFS_MOUNT_NORESVPORT)
+=09nfs_init_timeout_values(&timeparms, cfg->nfs_server.protocol,
+=09=09=09=09cfg->timeo, cfg->retrans);
+=09if (cfg->flags & NFS_MOUNT_NORESVPORT)
 =09=09set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
=20
 =09/* Allocate or find a client reference we can use */
@@ -679,46 +679,46 @@ static int nfs_init_server(struct nfs_server *server,
 =09server->nfs_client =3D clp;
=20
 =09/* Initialise the client representation from the mount data */
-=09server->flags =3D data->flags;
-=09server->options =3D data->options;
+=09server->flags =3D cfg->flags;
+=09server->options =3D cfg->options;
 =09server->caps |=3D NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
 =09=09NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
 =09=09NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
=20
-=09if (data->rsize)
-=09=09server->rsize =3D nfs_block_size(data->rsize, NULL);
-=09if (data->wsize)
-=09=09server->wsize =3D nfs_block_size(data->wsize, NULL);
+=09if (cfg->rsize)
+=09=09server->rsize =3D nfs_block_size(cfg->rsize, NULL);
+=09if (cfg->wsize)
+=09=09server->wsize =3D nfs_block_size(cfg->wsize, NULL);
=20
-=09server->acregmin =3D data->acregmin * HZ;
-=09server->acregmax =3D data->acregmax * HZ;
-=09server->acdirmin =3D data->acdirmin * HZ;
-=09server->acdirmax =3D data->acdirmax * HZ;
+=09server->acregmin =3D cfg->acregmin * HZ;
+=09server->acregmax =3D cfg->acregmax * HZ;
+=09server->acdirmin =3D cfg->acdirmin * HZ;
+=09server->acdirmax =3D cfg->acdirmax * HZ;
=20
 =09/* Start lockd here, before we might error out */
 =09error =3D nfs_start_lockd(server);
 =09if (error < 0)
 =09=09goto error;
=20
-=09server->port =3D data->nfs_server.port;
-=09server->auth_info =3D data->auth_info;
+=09server->port =3D cfg->nfs_server.port;
+=09server->auth_info =3D cfg->auth_info;
=20
 =09error =3D nfs_init_server_rpcclient(server, &timeparms,
-=09=09=09=09=09  data->selected_flavor);
+=09=09=09=09=09  cfg->selected_flavor);
 =09if (error < 0)
 =09=09goto error;
=20
 =09/* Preserve the values of mount_server-related mount options */
-=09if (data->mount_server.addrlen) {
-=09=09memcpy(&server->mountd_address, &data->mount_server.address,
-=09=09=09data->mount_server.addrlen);
-=09=09server->mountd_addrlen =3D data->mount_server.addrlen;
+=09if (cfg->mount_server.addrlen) {
+=09=09memcpy(&server->mountd_address, &cfg->mount_server.address,
+=09=09=09cfg->mount_server.addrlen);
+=09=09server->mountd_addrlen =3D cfg->mount_server.addrlen;
 =09}
-=09server->mountd_version =3D data->mount_server.version;
-=09server->mountd_port =3D data->mount_server.port;
-=09server->mountd_protocol =3D data->mount_server.protocol;
+=09server->mountd_version =3D cfg->mount_server.version;
+=09server->mountd_port =3D cfg->mount_server.port;
+=09server->mountd_protocol =3D cfg->mount_server.protocol;
=20
-=09server->namelen  =3D data->namlen;
+=09server->namelen  =3D cfg->namlen;
 =09return 0;
=20
 error:
@@ -959,7 +959,7 @@ struct nfs_server *nfs_create_server(struct nfs_mount_i=
nfo *mount_info)
 =09=09goto error;
=20
 =09/* Get a client representation */
-=09error =3D nfs_init_server(server, mount_info->parsed, nfs_mod);
+=09error =3D nfs_init_server(server, mount_info->ctx, nfs_mod);
 =09if (error < 0)
 =09=09goto error;
=20
@@ -970,7 +970,7 @@ struct nfs_server *nfs_create_server(struct nfs_mount_i=
nfo *mount_info)
 =09if (server->nfs_client->rpc_ops->version =3D=3D 3) {
 =09=09if (server->namelen =3D=3D 0 || server->namelen > NFS3_MAXNAMLEN)
 =09=09=09server->namelen =3D NFS3_MAXNAMLEN;
-=09=09if (!(mount_info->parsed->flags & NFS_MOUNT_NORDIRPLUS))
+=09=09if (!(mount_info->ctx->flags & NFS_MOUNT_NORDIRPLUS))
 =09=09=09server->caps |=3D NFS_CAP_READDIRPLUS;
 =09} else {
 =09=09if (server->namelen =3D=3D 0 || server->namelen > NFS2_MAXNAMLEN)
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index de852177eca4..63aa5faed9da 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -242,40 +242,40 @@ static const match_table_t nfs_vers_tokens =3D {
 =09{ Opt_vers_err, NULL }
 };
=20
-struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void)
+struct nfs_fs_context *nfs_alloc_parsed_mount_data(void)
 {
-=09struct nfs_parsed_mount_data *data;
-
-=09data =3D kzalloc(sizeof(*data), GFP_KERNEL);
-=09if (data) {
-=09=09data->timeo=09=09=3D NFS_UNSPEC_TIMEO;
-=09=09data->retrans=09=09=3D NFS_UNSPEC_RETRANS;
-=09=09data->acregmin=09=09=3D NFS_DEF_ACREGMIN;
-=09=09data->acregmax=09=09=3D NFS_DEF_ACREGMAX;
-=09=09data->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
-=09=09data->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
-=09=09data->mount_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09data->nfs_server.port=09=3D NFS_UNSPEC_PORT;
-=09=09data->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
-=09=09data->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
-=09=09data->minorversion=09=3D 0;
-=09=09data->need_mount=09=3D true;
-=09=09data->net=09=09=3D current->nsproxy->net_ns;
-=09=09data->lsm_opts=09=09=3D NULL;
+=09struct nfs_fs_context *ctx;
+
+=09ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
+=09if (ctx) {
+=09=09ctx->timeo=09=09=3D NFS_UNSPEC_TIMEO;
+=09=09ctx->retrans=09=09=3D NFS_UNSPEC_RETRANS;
+=09=09ctx->acregmin=09=09=3D NFS_DEF_ACREGMIN;
+=09=09ctx->acregmax=09=09=3D NFS_DEF_ACREGMAX;
+=09=09ctx->acdirmin=09=09=3D NFS_DEF_ACDIRMIN;
+=09=09ctx->acdirmax=09=09=3D NFS_DEF_ACDIRMAX;
+=09=09ctx->mount_server.port=09=3D NFS_UNSPEC_PORT;
+=09=09ctx->nfs_server.port=09=3D NFS_UNSPEC_PORT;
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09ctx->selected_flavor=09=3D RPC_AUTH_MAXFLAVOR;
+=09=09ctx->minorversion=09=3D 0;
+=09=09ctx->need_mount=09=3D true;
+=09=09ctx->net=09=09=3D current->nsproxy->net_ns;
+=09=09ctx->lsm_opts =3D NULL;
 =09}
-=09return data;
+=09return ctx;
 }
=20
-void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)
+void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx)
 {
-=09if (data) {
-=09=09kfree(data->client_address);
-=09=09kfree(data->mount_server.hostname);
-=09=09kfree(data->nfs_server.export_path);
-=09=09kfree(data->nfs_server.hostname);
-=09=09kfree(data->fscache_uniq);
-=09=09security_free_mnt_opts(&data->lsm_opts);
-=09=09kfree(data);
+=09if (ctx) {
+=09=09kfree(ctx->client_address);
+=09=09kfree(ctx->mount_server.hostname);
+=09=09kfree(ctx->nfs_server.export_path);
+=09=09kfree(ctx->nfs_server.hostname);
+=09=09kfree(ctx->fscache_uniq);
+=09=09security_free_mnt_opts(&ctx->lsm_opts);
+=09=09kfree(ctx);
 =09}
 }
=20
@@ -306,15 +306,15 @@ static int nfs_verify_server_address(struct sockaddr =
*addr)
  * Sanity check the NFS transport protocol.
  *
  */
-static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *=
mnt)
+static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
 {
-=09switch (mnt->nfs_server.protocol) {
+=09switch (ctx->nfs_server.protocol) {
 =09case XPRT_TRANSPORT_UDP:
 =09case XPRT_TRANSPORT_TCP:
 =09case XPRT_TRANSPORT_RDMA:
 =09=09break;
 =09default:
-=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09}
 }
=20
@@ -322,20 +322,20 @@ static void nfs_validate_transport_protocol(struct nf=
s_parsed_mount_data *mnt)
  * For text based NFSv2/v3 mounts, the mount protocol transport default
  * settings should depend upon the specified NFS transport.
  */
-static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data =
*mnt)
+static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 {
-=09nfs_validate_transport_protocol(mnt);
+=09nfs_validate_transport_protocol(ctx);
=20
-=09if (mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
-=09    mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
+=09if (ctx->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
+=09    ctx->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
 =09=09=09return;
-=09switch (mnt->nfs_server.protocol) {
+=09switch (ctx->nfs_server.protocol) {
 =09case XPRT_TRANSPORT_UDP:
-=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09break;
 =09case XPRT_TRANSPORT_TCP:
 =09case XPRT_TRANSPORT_RDMA:
-=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09}
 }
=20
@@ -367,8 +367,7 @@ static bool nfs_auth_info_add(struct nfs_auth_info *aut=
h_info,
 /*
  * Parse the value of the 'sec=3D' option.
  */
-static int nfs_parse_security_flavors(char *value,
-=09=09=09=09      struct nfs_parsed_mount_data *mnt)
+static int nfs_parse_security_flavors(char *value, struct nfs_fs_context *=
ctx)
 {
 =09substring_t args[MAX_OPT_ARGS];
 =09rpc_authflavor_t pseudoflavor;
@@ -417,7 +416,7 @@ static int nfs_parse_security_flavors(char *value,
 =09=09=09return 0;
 =09=09}
=20
-=09=09if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
+=09=09if (!nfs_auth_info_add(&ctx->auth_info, pseudoflavor))
 =09=09=09return 0;
 =09}
=20
@@ -425,36 +424,36 @@ static int nfs_parse_security_flavors(char *value,
 }
=20
 static int nfs_parse_version_string(char *string,
-=09=09struct nfs_parsed_mount_data *mnt,
+=09=09struct nfs_fs_context *ctx,
 =09=09substring_t *args)
 {
-=09mnt->flags &=3D ~NFS_MOUNT_VER3;
+=09ctx->flags &=3D ~NFS_MOUNT_VER3;
 =09switch (match_token(string, nfs_vers_tokens, args)) {
 =09case Opt_vers_2:
-=09=09mnt->version =3D 2;
+=09=09ctx->version =3D 2;
 =09=09break;
 =09case Opt_vers_3:
-=09=09mnt->flags |=3D NFS_MOUNT_VER3;
-=09=09mnt->version =3D 3;
+=09=09ctx->flags |=3D NFS_MOUNT_VER3;
+=09=09ctx->version =3D 3;
 =09=09break;
 =09case Opt_vers_4:
 =09=09/* Backward compatibility option. In future,
 =09=09 * the mount program should always supply
 =09=09 * a NFSv4 minor version number.
 =09=09 */
-=09=09mnt->version =3D 4;
+=09=09ctx->version =3D 4;
 =09=09break;
 =09case Opt_vers_4_0:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 0;
+=09=09ctx->version =3D 4;
+=09=09ctx->minorversion =3D 0;
 =09=09break;
 =09case Opt_vers_4_1:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 1;
+=09=09ctx->version =3D 4;
+=09=09ctx->minorversion =3D 1;
 =09=09break;
 =09case Opt_vers_4_2:
-=09=09mnt->version =3D 4;
-=09=09mnt->minorversion =3D 2;
+=09=09ctx->version =3D 4;
+=09=09ctx->minorversion =3D 2;
 =09=09break;
 =09default:
 =09=09return 0;
@@ -502,7 +501,7 @@ static int nfs_get_option_ul_bound(substring_t args[], =
unsigned long *option,
  * skipped as they are encountered.  If there were no errors, return 1;
  * otherwise return 0 (zero).
  */
-int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data *mnt)
+int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx)
 {
 =09char *p, *string;
 =09int rc, sloppy =3D 0, invalid_option =3D 0;
@@ -515,7 +514,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parse=
d_mount_data *mnt)
 =09}
 =09dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
=20
-=09rc =3D security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
+=09rc =3D security_sb_eat_lsm_opts(raw, &ctx->lsm_opts);
 =09if (rc)
 =09=09goto out_security_failure;
=20
@@ -536,96 +535,96 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09 * boolean options:  foo/nofoo
 =09=09 */
 =09=09case Opt_soft:
-=09=09=09mnt->flags |=3D NFS_MOUNT_SOFT;
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFTERR;
+=09=09=09ctx->flags |=3D NFS_MOUNT_SOFT;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_SOFTERR;
 =09=09=09break;
 =09=09case Opt_softerr:
-=09=09=09mnt->flags |=3D NFS_MOUNT_SOFTERR;
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_SOFT;
+=09=09=09ctx->flags |=3D NFS_MOUNT_SOFTERR;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_SOFT;
 =09=09=09break;
 =09=09case Opt_hard:
-=09=09=09mnt->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
 =09=09=09break;
 =09=09case Opt_posix:
-=09=09=09mnt->flags |=3D NFS_MOUNT_POSIX;
+=09=09=09ctx->flags |=3D NFS_MOUNT_POSIX;
 =09=09=09break;
 =09=09case Opt_noposix:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_POSIX;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_POSIX;
 =09=09=09break;
 =09=09case Opt_cto:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOCTO;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOCTO;
 =09=09=09break;
 =09=09case Opt_nocto:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOCTO;
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOCTO;
 =09=09=09break;
 =09=09case Opt_ac:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOAC;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOAC;
 =09=09=09break;
 =09=09case Opt_noac:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOAC;
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOAC;
 =09=09=09break;
 =09=09case Opt_lock:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NONLM;
-=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
 =09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
 =09=09case Opt_nolock:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NONLM;
-=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09ctx->flags |=3D NFS_MOUNT_NONLM;
+=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
 =09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
 =09=09case Opt_udp:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09break;
 =09=09case Opt_tcp:
-=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09break;
 =09=09case Opt_rdma:
-=09=09=09mnt->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
-=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09=09ctx->flags |=3D NFS_MOUNT_TCP; /* for side protocols */
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
 =09=09=09xprt_load_transport(p);
 =09=09=09break;
 =09=09case Opt_acl:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NOACL;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NOACL;
 =09=09=09break;
 =09=09case Opt_noacl:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NOACL;
+=09=09=09ctx->flags |=3D NFS_MOUNT_NOACL;
 =09=09=09break;
 =09=09case Opt_rdirplus:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
 =09=09=09break;
 =09=09case Opt_nordirplus:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NORDIRPLUS;
+=09=09=09ctx->flags |=3D NFS_MOUNT_NORDIRPLUS;
 =09=09=09break;
 =09=09case Opt_sharecache:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_UNSHARED;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_UNSHARED;
 =09=09=09break;
 =09=09case Opt_nosharecache:
-=09=09=09mnt->flags |=3D NFS_MOUNT_UNSHARED;
+=09=09=09ctx->flags |=3D NFS_MOUNT_UNSHARED;
 =09=09=09break;
 =09=09case Opt_resvport:
-=09=09=09mnt->flags &=3D ~NFS_MOUNT_NORESVPORT;
+=09=09=09ctx->flags &=3D ~NFS_MOUNT_NORESVPORT;
 =09=09=09break;
 =09=09case Opt_noresvport:
-=09=09=09mnt->flags |=3D NFS_MOUNT_NORESVPORT;
+=09=09=09ctx->flags |=3D NFS_MOUNT_NORESVPORT;
 =09=09=09break;
 =09=09case Opt_fscache:
-=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
-=09=09=09kfree(mnt->fscache_uniq);
-=09=09=09mnt->fscache_uniq =3D NULL;
+=09=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
+=09=09=09kfree(ctx->fscache_uniq);
+=09=09=09ctx->fscache_uniq =3D NULL;
 =09=09=09break;
 =09=09case Opt_nofscache:
-=09=09=09mnt->options &=3D ~NFS_OPTION_FSCACHE;
-=09=09=09kfree(mnt->fscache_uniq);
-=09=09=09mnt->fscache_uniq =3D NULL;
+=09=09=09ctx->options &=3D ~NFS_OPTION_FSCACHE;
+=09=09=09kfree(ctx->fscache_uniq);
+=09=09=09ctx->fscache_uniq =3D NULL;
 =09=09=09break;
 =09=09case Opt_migration:
-=09=09=09mnt->options |=3D NFS_OPTION_MIGRATION;
+=09=09=09ctx->options |=3D NFS_OPTION_MIGRATION;
 =09=09=09break;
 =09=09case Opt_nomigration:
-=09=09=09mnt->options &=3D ~NFS_OPTION_MIGRATION;
+=09=09=09ctx->options &=3D ~NFS_OPTION_MIGRATION;
 =09=09=09break;
=20
 =09=09/*
@@ -635,83 +634,83 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09if (nfs_get_option_ul(args, &option) ||
 =09=09=09    option > USHRT_MAX)
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->nfs_server.port =3D option;
+=09=09=09ctx->nfs_server.port =3D option;
 =09=09=09break;
 =09=09case Opt_rsize:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->rsize =3D option;
+=09=09=09ctx->rsize =3D option;
 =09=09=09break;
 =09=09case Opt_wsize:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->wsize =3D option;
+=09=09=09ctx->wsize =3D option;
 =09=09=09break;
 =09=09case Opt_bsize:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->bsize =3D option;
+=09=09=09ctx->bsize =3D option;
 =09=09=09break;
 =09=09case Opt_timeo:
 =09=09=09if (nfs_get_option_ul_bound(args, &option, 1, INT_MAX))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->timeo =3D option;
+=09=09=09ctx->timeo =3D option;
 =09=09=09break;
 =09=09case Opt_retrans:
 =09=09=09if (nfs_get_option_ul_bound(args, &option, 0, INT_MAX))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->retrans =3D option;
+=09=09=09ctx->retrans =3D option;
 =09=09=09break;
 =09=09case Opt_acregmin:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmin =3D option;
+=09=09=09ctx->acregmin =3D option;
 =09=09=09break;
 =09=09case Opt_acregmax:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmax =3D option;
+=09=09=09ctx->acregmax =3D option;
 =09=09=09break;
 =09=09case Opt_acdirmin:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acdirmin =3D option;
+=09=09=09ctx->acdirmin =3D option;
 =09=09=09break;
 =09=09case Opt_acdirmax:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acdirmax =3D option;
+=09=09=09ctx->acdirmax =3D option;
 =09=09=09break;
 =09=09case Opt_actimeo:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->acregmin =3D mnt->acregmax =3D
-=09=09=09mnt->acdirmin =3D mnt->acdirmax =3D option;
+=09=09=09ctx->acregmin =3D ctx->acregmax =3D
+=09=09=09ctx->acdirmin =3D ctx->acdirmax =3D option;
 =09=09=09break;
 =09=09case Opt_namelen:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->namlen =3D option;
+=09=09=09ctx->namlen =3D option;
 =09=09=09break;
 =09=09case Opt_mountport:
 =09=09=09if (nfs_get_option_ul(args, &option) ||
 =09=09=09    option > USHRT_MAX)
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->mount_server.port =3D option;
+=09=09=09ctx->mount_server.port =3D option;
 =09=09=09break;
 =09=09case Opt_mountvers:
 =09=09=09if (nfs_get_option_ul(args, &option) ||
 =09=09=09    option < NFS_MNT_VERSION ||
 =09=09=09    option > NFS_MNT3_VERSION)
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->mount_server.version =3D option;
+=09=09=09ctx->mount_server.version =3D option;
 =09=09=09break;
 =09=09case Opt_minorversion:
 =09=09=09if (nfs_get_option_ul(args, &option))
 =09=09=09=09goto out_invalid_value;
 =09=09=09if (option > NFS4_MAX_MINOR_VERSION)
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->minorversion =3D option;
+=09=09=09ctx->minorversion =3D option;
 =09=09=09break;
=20
 =09=09/*
@@ -721,7 +720,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parse=
d_mount_data *mnt)
 =09=09=09string =3D match_strdup(args);
 =09=09=09if (string =3D=3D NULL)
 =09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_version_string(string, mnt, args);
+=09=09=09rc =3D nfs_parse_version_string(string, ctx, args);
 =09=09=09kfree(string);
 =09=09=09if (!rc)
 =09=09=09=09goto out_invalid_value;
@@ -730,7 +729,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parse=
d_mount_data *mnt)
 =09=09=09string =3D match_strdup(args);
 =09=09=09if (string =3D=3D NULL)
 =09=09=09=09goto out_nomem;
-=09=09=09rc =3D nfs_parse_security_flavors(string, mnt);
+=09=09=09rc =3D nfs_parse_security_flavors(string, ctx);
 =09=09=09kfree(string);
 =09=09=09if (!rc) {
 =09=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
@@ -751,23 +750,23 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09=09protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_udp:
-=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
+=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_tcp6:
 =09=09=09=09protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_tcp:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_rdma6:
 =09=09=09=09protofamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_rdma:
 =09=09=09=09/* vector side protocols to TCP */
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_TCP;
-=09=09=09=09mnt->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
+=09=09=09=09ctx->flags |=3D NFS_MOUNT_TCP;
+=09=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_RDMA;
 =09=09=09=09xprt_load_transport(string);
 =09=09=09=09break;
 =09=09=09default:
@@ -792,13 +791,13 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09=09mountfamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_udp:
-=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_tcp6:
 =09=09=09=09mountfamily =3D AF_INET6;
 =09=09=09=09/* fall through */
 =09=09=09case Opt_xprt_tcp:
-=09=09=09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
+=09=09=09=09ctx->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
 =09=09=09=09break;
 =09=09=09case Opt_xprt_rdma: /* not used for side protocols */
 =09=09=09default:
@@ -811,41 +810,41 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09string =3D match_strdup(args);
 =09=09=09if (string =3D=3D NULL)
 =09=09=09=09goto out_nomem;
-=09=09=09mnt->nfs_server.addrlen =3D
-=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
+=09=09=09ctx->nfs_server.addrlen =3D
+=09=09=09=09rpc_pton(ctx->net, string, strlen(string),
 =09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&mnt->nfs_server.address,
-=09=09=09=09=09sizeof(mnt->nfs_server.address));
+=09=09=09=09=09&ctx->nfs_server.address,
+=09=09=09=09=09sizeof(ctx->nfs_server.address));
 =09=09=09kfree(string);
-=09=09=09if (mnt->nfs_server.addrlen =3D=3D 0)
+=09=09=09if (ctx->nfs_server.addrlen =3D=3D 0)
 =09=09=09=09goto out_invalid_address;
 =09=09=09break;
 =09=09case Opt_clientaddr:
-=09=09=09if (nfs_get_option_str(args, &mnt->client_address))
+=09=09=09if (nfs_get_option_str(args, &ctx->client_address))
 =09=09=09=09goto out_nomem;
 =09=09=09break;
 =09=09case Opt_mounthost:
 =09=09=09if (nfs_get_option_str(args,
-=09=09=09=09=09       &mnt->mount_server.hostname))
+=09=09=09=09=09       &ctx->mount_server.hostname))
 =09=09=09=09goto out_nomem;
 =09=09=09break;
 =09=09case Opt_mountaddr:
 =09=09=09string =3D match_strdup(args);
 =09=09=09if (string =3D=3D NULL)
 =09=09=09=09goto out_nomem;
-=09=09=09mnt->mount_server.addrlen =3D
-=09=09=09=09rpc_pton(mnt->net, string, strlen(string),
+=09=09=09ctx->mount_server.addrlen =3D
+=09=09=09=09rpc_pton(ctx->net, string, strlen(string),
 =09=09=09=09=09(struct sockaddr *)
-=09=09=09=09=09&mnt->mount_server.address,
-=09=09=09=09=09sizeof(mnt->mount_server.address));
+=09=09=09=09=09&ctx->mount_server.address,
+=09=09=09=09=09sizeof(ctx->mount_server.address));
 =09=09=09kfree(string);
-=09=09=09if (mnt->mount_server.addrlen =3D=3D 0)
+=09=09=09if (ctx->mount_server.addrlen =3D=3D 0)
 =09=09=09=09goto out_invalid_address;
 =09=09=09break;
 =09=09case Opt_nconnect:
 =09=09=09if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS=
))
 =09=09=09=09goto out_invalid_value;
-=09=09=09mnt->nfs_server.nconnect =3D option;
+=09=09=09ctx->nfs_server.nconnect =3D option;
 =09=09=09break;
 =09=09case Opt_lookupcache:
 =09=09=09string =3D match_strdup(args);
@@ -856,14 +855,14 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09kfree(string);
 =09=09=09switch (token) {
 =09=09=09=09case Opt_lookupcache_all:
-=09=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LO=
OKUP_CACHE_NONE);
+=09=09=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LO=
OKUP_CACHE_NONE);
 =09=09=09=09=09break;
 =09=09=09=09case Opt_lookupcache_positive:
-=09=09=09=09=09mnt->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
-=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
+=09=09=09=09=09ctx->flags &=3D ~NFS_MOUNT_LOOKUP_CACHE_NONE;
+=09=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG;
 =09=09=09=09=09break;
 =09=09=09=09case Opt_lookupcache_none:
-=09=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOK=
UP_CACHE_NONE;
+=09=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOK=
UP_CACHE_NONE;
 =09=09=09=09=09break;
 =09=09=09=09default:
 =09=09=09=09=09dfprintk(MOUNT, "NFS:   invalid "
@@ -872,9 +871,9 @@ int nfs_parse_mount_options(char *raw, struct nfs_parse=
d_mount_data *mnt)
 =09=09=09};
 =09=09=09break;
 =09=09case Opt_fscache_uniq:
-=09=09=09if (nfs_get_option_str(args, &mnt->fscache_uniq))
+=09=09=09if (nfs_get_option_str(args, &ctx->fscache_uniq))
 =09=09=09=09goto out_nomem;
-=09=09=09mnt->options |=3D NFS_OPTION_FSCACHE;
+=09=09=09ctx->options |=3D NFS_OPTION_FSCACHE;
 =09=09=09break;
 =09=09case Opt_local_lock:
 =09=09=09string =3D match_strdup(args);
@@ -885,17 +884,17 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09=09=09kfree(string);
 =09=09=09switch (token) {
 =09=09=09case Opt_local_lock_all:
-=09=09=09=09mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
 =09=09=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09=09break;
 =09=09=09case Opt_local_lock_flock:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
+=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
 =09=09=09=09break;
 =09=09=09case Opt_local_lock_posix:
-=09=09=09=09mnt->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
+=09=09=09=09ctx->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
 =09=09=09=09break;
 =09=09=09case Opt_local_lock_none:
-=09=09=09=09mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
+=09=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
 =09=09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09=09break;
 =09=09=09default:
@@ -928,11 +927,11 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09if (!sloppy && invalid_option)
 =09=09return 0;
=20
-=09if (mnt->minorversion && mnt->version !=3D 4)
+=09if (ctx->minorversion && ctx->version !=3D 4)
 =09=09goto out_minorversion_mismatch;
=20
-=09if (mnt->options & NFS_OPTION_MIGRATION &&
-=09    (mnt->version !=3D 4 || mnt->minorversion !=3D 0))
+=09if (ctx->options & NFS_OPTION_MIGRATION &&
+=09    (ctx->version !=3D 4 || ctx->minorversion !=3D 0))
 =09=09goto out_migration_misuse;
=20
 =09/*
@@ -940,15 +939,15 @@ int nfs_parse_mount_options(char *raw, struct nfs_par=
sed_mount_data *mnt)
 =09 * families in the addr=3D/mountaddr=3D options.
 =09 */
 =09if (protofamily !=3D AF_UNSPEC &&
-=09    protofamily !=3D mnt->nfs_server.address.ss_family)
+=09    protofamily !=3D ctx->nfs_server.address.ss_family)
 =09=09goto out_proto_mismatch;
=20
 =09if (mountfamily !=3D AF_UNSPEC) {
-=09=09if (mnt->mount_server.addrlen) {
-=09=09=09if (mountfamily !=3D mnt->mount_server.address.ss_family)
+=09=09if (ctx->mount_server.addrlen) {
+=09=09=09if (mountfamily !=3D ctx->mount_server.address.ss_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09} else {
-=09=09=09if (mountfamily !=3D mnt->nfs_server.address.ss_family)
+=09=09=09if (mountfamily !=3D ctx->nfs_server.address.ss_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09}
 =09}
@@ -970,7 +969,7 @@ int nfs_parse_mount_options(char *raw, struct nfs_parse=
d_mount_data *mnt)
 =09return 0;
 out_minorversion_mismatch:
 =09printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
-=09=09=09 "minorversion=3D%u\n", mnt->version, mnt->minorversion);
+=09=09=09 "minorversion=3D%u\n", ctx->version, ctx->minorversion);
 =09return 0;
 out_migration_misuse:
 =09printk(KERN_INFO
@@ -1078,18 +1077,18 @@ static int nfs_parse_devname(const char *dev_name,
  *   mountproto=3Dtcp after mountproto=3Dudp, and so on
  */
 static int nfs23_validate_mount_data(void *options,
-=09=09=09=09     struct nfs_parsed_mount_data *args,
+=09=09=09=09     struct nfs_fs_context *ctx,
 =09=09=09=09     struct nfs_fh *mntfh,
 =09=09=09=09     const char *dev_name)
 {
 =09struct nfs_mount_data *data =3D (struct nfs_mount_data *)options;
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+=09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
 =09int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
=20
 =09if (data =3D=3D NULL)
 =09=09goto out_no_data;
=20
-=09args->version =3D NFS_DEFAULT_VERSION;
+=09ctx->version =3D NFS_DEFAULT_VERSION;
 =09switch (data->version) {
 =09case 1:
 =09=09data->namlen =3D 0; /* fall through */
@@ -1115,10 +1114,10 @@ static int nfs23_validate_mount_data(void *options,
 =09=09=09if (data->root.size > NFS3_FHSIZE || data->root.size =3D=3D 0)
 =09=09=09=09goto out_invalid_fh;
 =09=09=09mntfh->size =3D data->root.size;
-=09=09=09args->version =3D 3;
+=09=09=09ctx->version =3D 3;
 =09=09} else {
 =09=09=09mntfh->size =3D NFS2_FHSIZE;
-=09=09=09args->version =3D 2;
+=09=09=09ctx->version =3D 2;
 =09=09}
=20
=20
@@ -1128,47 +1127,47 @@ static int nfs23_validate_mount_data(void *options,
 =09=09=09       sizeof(mntfh->data) - mntfh->size);
=20
 =09=09/*
-=09=09 * Translate to nfs_parsed_mount_data, which nfs_fill_super
+=09=09 * Translate to nfs_fs_context, which nfs_fill_super
 =09=09 * can deal with.
 =09=09 */
-=09=09args->flags=09=09=3D data->flags & NFS_MOUNT_FLAGMASK;
-=09=09args->flags=09=09|=3D extra_flags;
-=09=09args->rsize=09=09=3D data->rsize;
-=09=09args->wsize=09=09=3D data->wsize;
-=09=09args->timeo=09=09=3D data->timeo;
-=09=09args->retrans=09=09=3D data->retrans;
-=09=09args->acregmin=09=09=3D data->acregmin;
-=09=09args->acregmax=09=09=3D data->acregmax;
-=09=09args->acdirmin=09=09=3D data->acdirmin;
-=09=09args->acdirmax=09=09=3D data->acdirmax;
-=09=09args->need_mount=09=3D false;
+=09=09ctx->flags=09=3D data->flags & NFS_MOUNT_FLAGMASK;
+=09=09ctx->flags=09|=3D extra_flags;
+=09=09ctx->rsize=09=3D data->rsize;
+=09=09ctx->wsize=09=3D data->wsize;
+=09=09ctx->timeo=09=3D data->timeo;
+=09=09ctx->retrans=09=3D data->retrans;
+=09=09ctx->acregmin=09=3D data->acregmin;
+=09=09ctx->acregmax=09=3D data->acregmax;
+=09=09ctx->acdirmin=09=3D data->acdirmin;
+=09=09ctx->acdirmax=09=3D data->acdirmax;
+=09=09ctx->need_mount=09=3D false;
=20
 =09=09memcpy(sap, &data->addr, sizeof(data->addr));
-=09=09args->nfs_server.addrlen =3D sizeof(data->addr);
-=09=09args->nfs_server.port =3D ntohs(data->addr.sin_port);
+=09=09ctx->nfs_server.addrlen =3D sizeof(data->addr);
+=09=09ctx->nfs_server.port =3D ntohs(data->addr.sin_port);
 =09=09if (sap->sa_family !=3D AF_INET ||
 =09=09    !nfs_verify_server_address(sap))
 =09=09=09goto out_no_address;
=20
 =09=09if (!(data->flags & NFS_MOUNT_TCP))
-=09=09=09args->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
+=09=09=09ctx->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
 =09=09/* N.B. caller will free nfs_server.hostname in all cases */
-=09=09args->nfs_server.hostname =3D kstrdup(data->hostname, GFP_KERNEL);
-=09=09args->namlen=09=09=3D data->namlen;
-=09=09args->bsize=09=09=3D data->bsize;
+=09=09ctx->nfs_server.hostname =3D kstrdup(data->hostname, GFP_KERNEL);
+=09=09ctx->namlen=09=09=3D data->namlen;
+=09=09ctx->bsize=09=09=3D data->bsize;
=20
 =09=09if (data->flags & NFS_MOUNT_SECFLAVOUR)
-=09=09=09args->selected_flavor =3D data->pseudoflavor;
+=09=09=09ctx->selected_flavor =3D data->pseudoflavor;
 =09=09else
-=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
-=09=09if (!args->nfs_server.hostname)
+=09=09=09ctx->selected_flavor =3D RPC_AUTH_UNIX;
+=09=09if (!ctx->nfs_server.hostname)
 =09=09=09goto out_nomem;
=20
 =09=09if (!(data->flags & NFS_MOUNT_NONLM))
-=09=09=09args->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
+=09=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
 =09=09=09=09=09 NFS_MOUNT_LOCAL_FCNTL);
 =09=09else
-=09=09=09args->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
+=09=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
 =09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09/*
 =09=09 * The legacy version 6 binary mount data from userspace has a
@@ -1183,7 +1182,7 @@ static int nfs23_validate_mount_data(void *options,
 =09=09=09int rc;
 =09=09=09data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
 =09=09=09rc =3D security_add_mnt_opt("context", data->context,
-=09=09=09=09=09strlen(data->context), &args->lsm_opts);
+=09=09=09=09=09strlen(data->context), ctx->lsm_opts);
 =09=09=09if (rc)
 =09=09=09=09return rc;
 #else
@@ -1225,10 +1224,9 @@ static int nfs23_validate_mount_data(void *options,
 }
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
-
-static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data *args)
+static void nfs4_validate_mount_flags(struct nfs_fs_context *ctx)
 {
-=09args->flags &=3D ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
+=09ctx->flags &=3D ~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
 =09=09=09 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
 }
=20
@@ -1236,30 +1234,30 @@ static void nfs4_validate_mount_flags(struct nfs_pa=
rsed_mount_data *args)
  * Validate NFSv4 mount options
  */
 static int nfs4_validate_mount_data(void *options,
-=09=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09=09    struct nfs_fs_context *ctx,
 =09=09=09=09    const char *dev_name)
 {
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+=09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
 =09struct nfs4_mount_data *data =3D (struct nfs4_mount_data *)options;
 =09char *c;
=20
 =09if (data =3D=3D NULL)
 =09=09goto out_no_data;
=20
-=09args->version =3D 4;
+=09ctx->version =3D 4;
=20
 =09switch (data->version) {
 =09case 1:
-=09=09if (data->host_addrlen > sizeof(args->nfs_server.address))
+=09=09if (data->host_addrlen > sizeof(ctx->nfs_server.address))
 =09=09=09goto out_no_address;
 =09=09if (data->host_addrlen =3D=3D 0)
 =09=09=09goto out_no_address;
-=09=09args->nfs_server.addrlen =3D data->host_addrlen;
+=09=09ctx->nfs_server.addrlen =3D data->host_addrlen;
 =09=09if (copy_from_user(sap, data->host_addr, data->host_addrlen))
 =09=09=09return -EFAULT;
 =09=09if (!nfs_verify_server_address(sap))
 =09=09=09goto out_no_address;
-=09=09args->nfs_server.port =3D ntohs(((struct sockaddr_in *)sap)->sin_por=
t);
+=09=09ctx->nfs_server.port =3D ntohs(((struct sockaddr_in *)sap)->sin_port=
);
=20
 =09=09if (data->auth_flavourlen) {
 =09=09=09rpc_authflavor_t pseudoflavor;
@@ -1269,43 +1267,43 @@ static int nfs4_validate_mount_data(void *options,
 =09=09=09=09=09   data->auth_flavours,
 =09=09=09=09=09   sizeof(pseudoflavor)))
 =09=09=09=09return -EFAULT;
-=09=09=09args->selected_flavor =3D pseudoflavor;
+=09=09=09ctx->selected_flavor =3D pseudoflavor;
 =09=09} else
-=09=09=09args->selected_flavor =3D RPC_AUTH_UNIX;
+=09=09=09ctx->selected_flavor =3D RPC_AUTH_UNIX;
=20
 =09=09c =3D strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
 =09=09if (IS_ERR(c))
 =09=09=09return PTR_ERR(c);
-=09=09args->nfs_server.hostname =3D c;
+=09=09ctx->nfs_server.hostname =3D c;
=20
 =09=09c =3D strndup_user(data->mnt_path.data, NFS4_MAXPATHLEN);
 =09=09if (IS_ERR(c))
 =09=09=09return PTR_ERR(c);
-=09=09args->nfs_server.export_path =3D c;
+=09=09ctx->nfs_server.export_path =3D c;
 =09=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
=20
 =09=09c =3D strndup_user(data->client_addr.data, 16);
 =09=09if (IS_ERR(c))
 =09=09=09return PTR_ERR(c);
-=09=09args->client_address =3D c;
+=09=09ctx->client_address =3D c;
=20
 =09=09/*
-=09=09 * Translate to nfs_parsed_mount_data, which nfs4_fill_super
+=09=09 * Translate to nfs_fs_context, which nfs4_fill_super
 =09=09 * can deal with.
 =09=09 */
=20
-=09=09args->flags=09=3D data->flags & NFS4_MOUNT_FLAGMASK;
-=09=09args->rsize=09=3D data->rsize;
-=09=09args->wsize=09=3D data->wsize;
-=09=09args->timeo=09=3D data->timeo;
-=09=09args->retrans=09=3D data->retrans;
-=09=09args->acregmin=09=3D data->acregmin;
-=09=09args->acregmax=09=3D data->acregmax;
-=09=09args->acdirmin=09=3D data->acdirmin;
-=09=09args->acdirmax=09=3D data->acdirmax;
-=09=09args->nfs_server.protocol =3D data->proto;
-=09=09nfs_validate_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
+=09=09ctx->flags=09=3D data->flags & NFS4_MOUNT_FLAGMASK;
+=09=09ctx->rsize=09=3D data->rsize;
+=09=09ctx->wsize=09=3D data->wsize;
+=09=09ctx->timeo=09=3D data->timeo;
+=09=09ctx->retrans=09=3D data->retrans;
+=09=09ctx->acregmin=09=3D data->acregmin;
+=09=09ctx->acregmax=09=3D data->acregmax;
+=09=09ctx->acdirmin=09=3D data->acdirmin;
+=09=09ctx->acdirmax=09=3D data->acdirmax;
+=09=09ctx->nfs_server.protocol =3D data->proto;
+=09=09nfs_validate_transport_protocol(ctx);
+=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
 =09=09=09goto out_invalid_transport_udp;
=20
 =09=09break;
@@ -1335,67 +1333,67 @@ static int nfs4_validate_mount_data(void *options,
=20
 int nfs_validate_mount_data(struct file_system_type *fs_type,
 =09=09=09    void *options,
-=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09    struct nfs_fs_context *ctx,
 =09=09=09    struct nfs_fh *mntfh,
 =09=09=09    const char *dev_name)
 {
 =09if (fs_type =3D=3D &nfs_fs_type)
-=09=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
-=09return nfs4_validate_mount_data(options, args, dev_name);
+=09=09return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
+=09return nfs4_validate_mount_data(options, ctx, dev_name);
 }
 #else
 int nfs_validate_mount_data(struct file_system_type *fs_type,
 =09=09=09    void *options,
-=09=09=09    struct nfs_parsed_mount_data *args,
+=09=09=09    struct nfs_fs_context *ctx,
 =09=09=09    struct nfs_fh *mntfh,
 =09=09=09    const char *dev_name)
 {
-=09return nfs23_validate_mount_data(options, args, mntfh, dev_name);
+=09return nfs23_validate_mount_data(options, ctx, mntfh, dev_name);
 }
 #endif
=20
 int nfs_validate_text_mount_data(void *options,
-=09=09=09=09 struct nfs_parsed_mount_data *args,
+=09=09=09=09 struct nfs_fs_context *ctx,
 =09=09=09=09 const char *dev_name)
 {
 =09int port =3D 0;
 =09int max_namelen =3D PAGE_SIZE;
 =09int max_pathlen =3D NFS_MAXPATHLEN;
-=09struct sockaddr *sap =3D (struct sockaddr *)&args->nfs_server.address;
+=09struct sockaddr *sap =3D (struct sockaddr *)&ctx->nfs_server.address;
=20
-=09if (nfs_parse_mount_options((char *)options, args) =3D=3D 0)
+=09if (nfs_parse_mount_options((char *)options, ctx) =3D=3D 0)
 =09=09return -EINVAL;
=20
 =09if (!nfs_verify_server_address(sap))
 =09=09goto out_no_address;
=20
-=09if (args->version =3D=3D 4) {
+=09if (ctx->version =3D=3D 4) {
 #if IS_ENABLED(CONFIG_NFS_V4)
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
+=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
 =09=09=09port =3D NFS_RDMA_PORT;
 =09=09else
 =09=09=09port =3D NFS_PORT;
 =09=09max_namelen =3D NFS4_MAXNAMLEN;
 =09=09max_pathlen =3D NFS4_MAXPATHLEN;
-=09=09nfs_validate_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
+=09=09nfs_validate_transport_protocol(ctx);
+=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
 =09=09=09goto out_invalid_transport_udp;
-=09=09nfs4_validate_mount_flags(args);
+=09=09nfs4_validate_mount_flags(ctx);
 #else
 =09=09goto out_v4_not_compiled;
 #endif /* CONFIG_NFS_V4 */
 =09} else {
-=09=09nfs_set_mount_transport_protocol(args);
-=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
+=09=09nfs_set_mount_transport_protocol(ctx);
+=09=09if (ctx->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
 =09=09=09port =3D NFS_RDMA_PORT;
 =09}
=20
-=09nfs_set_port(sap, &args->nfs_server.port, port);
+=09nfs_set_port(sap, &ctx->nfs_server.port, port);
=20
 =09return nfs_parse_devname(dev_name,
-=09=09=09=09   &args->nfs_server.hostname,
+=09=09=09=09   &ctx->nfs_server.hostname,
 =09=09=09=09   max_namelen,
-=09=09=09=09   &args->nfs_server.export_path,
+=09=09=09=09   &ctx->nfs_server.export_path,
 =09=09=09=09   max_pathlen);
=20
 #if !IS_ENABLED(CONFIG_NFS_V4)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0818736efc57..a553b11aebe9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -81,7 +81,7 @@ struct nfs_client_initdata {
 /*
  * In-kernel mount arguments
  */
-struct nfs_parsed_mount_data {
+struct nfs_fs_context {
 =09int=09=09=09flags;
 =09unsigned int=09=09rsize, wsize;
 =09unsigned int=09=09timeo, retrans;
@@ -138,7 +138,7 @@ struct nfs_mount_request {
=20
 struct nfs_mount_info {
 =09unsigned int inherited_bsize;
-=09struct nfs_parsed_mount_data *parsed;
+=09struct nfs_fs_context *ctx;
 =09struct nfs_clone_mount *cloned;
 =09struct nfs_server *server;
 =09struct nfs_fh *mntfh;
@@ -229,16 +229,16 @@ struct nfs_pageio_descriptor;
 /* mount.c */
 #define NFS_TEXT_DATA=09=091
=20
-extern struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void);
-extern void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)=
;
-extern int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data=
 *mnt);
+extern struct nfs_fs_context *nfs_alloc_parsed_mount_data(void);
+extern void nfs_free_parsed_mount_data(struct nfs_fs_context *ctx);
+extern int nfs_parse_mount_options(char *raw, struct nfs_fs_context *ctx);
 extern int nfs_validate_mount_data(struct file_system_type *fs_type,
 =09=09=09=09   void *options,
-=09=09=09=09   struct nfs_parsed_mount_data *args,
+=09=09=09=09   struct nfs_fs_context *ctx,
 =09=09=09=09   struct nfs_fh *mntfh,
 =09=09=09=09   const char *dev_name);
 extern int nfs_validate_text_mount_data(void *options,
-=09=09=09=09=09struct nfs_parsed_mount_data *args,
+=09=09=09=09=09struct nfs_fs_context *ctx,
 =09=09=09=09=09const char *dev_name);
=20
 /* pagelist.c */
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 16fba83b5c4b..2ee2281ce404 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1053,61 +1053,61 @@ static int nfs4_server_common_setup(struct nfs_serv=
er *server,
  * Create a version 4 volume record
  */
 static int nfs4_init_server(struct nfs_server *server,
-=09=09struct nfs_parsed_mount_data *data)
+=09=09=09    struct nfs_fs_context *ctx)
 {
 =09struct rpc_timeout timeparms;
 =09int error;
=20
-=09nfs_init_timeout_values(&timeparms, data->nfs_server.protocol,
-=09=09=09data->timeo, data->retrans);
+=09nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
+=09=09=09=09ctx->timeo, ctx->retrans);
=20
 =09/* Initialise the client representation from the mount data */
-=09server->flags =3D data->flags;
-=09server->options =3D data->options;
-=09server->auth_info =3D data->auth_info;
+=09server->flags =3D ctx->flags;
+=09server->options =3D ctx->options;
+=09server->auth_info =3D ctx->auth_info;
=20
 =09/* Use the first specified auth flavor. If this flavor isn't
 =09 * allowed by the server, use the SECINFO path to try the
 =09 * other specified flavors */
-=09if (data->auth_info.flavor_len >=3D 1)
-=09=09data->selected_flavor =3D data->auth_info.flavors[0];
+=09if (ctx->auth_info.flavor_len >=3D 1)
+=09=09ctx->selected_flavor =3D ctx->auth_info.flavors[0];
 =09else
-=09=09data->selected_flavor =3D RPC_AUTH_UNIX;
+=09=09ctx->selected_flavor =3D RPC_AUTH_UNIX;
=20
 =09/* Get a client record */
 =09error =3D nfs4_set_client(server,
-=09=09=09data->nfs_server.hostname,
-=09=09=09(const struct sockaddr *)&data->nfs_server.address,
-=09=09=09data->nfs_server.addrlen,
-=09=09=09data->client_address,
-=09=09=09data->nfs_server.protocol,
+=09=09=09ctx->nfs_server.hostname,
+=09=09=09(const struct sockaddr *)&ctx->nfs_server.address,
+=09=09=09ctx->nfs_server.addrlen,
+=09=09=09ctx->client_address,
+=09=09=09ctx->nfs_server.protocol,
 =09=09=09&timeparms,
-=09=09=09data->minorversion,
-=09=09=09data->nfs_server.nconnect,
-=09=09=09data->net);
+=09=09=09ctx->minorversion,
+=09=09=09ctx->nfs_server.nconnect,
+=09=09=09ctx->net);
 =09if (error < 0)
 =09=09return error;
=20
-=09if (data->rsize)
-=09=09server->rsize =3D nfs_block_size(data->rsize, NULL);
-=09if (data->wsize)
-=09=09server->wsize =3D nfs_block_size(data->wsize, NULL);
+=09if (ctx->rsize)
+=09=09server->rsize =3D nfs_block_size(ctx->rsize, NULL);
+=09if (ctx->wsize)
+=09=09server->wsize =3D nfs_block_size(ctx->wsize, NULL);
=20
-=09server->acregmin =3D data->acregmin * HZ;
-=09server->acregmax =3D data->acregmax * HZ;
-=09server->acdirmin =3D data->acdirmin * HZ;
-=09server->acdirmax =3D data->acdirmax * HZ;
-=09server->port     =3D data->nfs_server.port;
+=09server->acregmin =3D ctx->acregmin * HZ;
+=09server->acregmax =3D ctx->acregmax * HZ;
+=09server->acdirmin =3D ctx->acdirmin * HZ;
+=09server->acdirmax =3D ctx->acdirmax * HZ;
+=09server->port     =3D ctx->nfs_server.port;
=20
 =09return nfs_init_server_rpcclient(server, &timeparms,
-=09=09=09=09=09 data->selected_flavor);
+=09=09=09=09=09 ctx->selected_flavor);
 }
=20
 /*
  * Create a version 4 volume record
  * - keyed on server and FSID
  */
-/*struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data=
 *data,
+/*struct nfs_server *nfs4_create_server(const struct nfs_fs_context *data,
 =09=09=09=09      struct nfs_fh *mntfh)*/
 struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 {
@@ -1121,10 +1121,10 @@ struct nfs_server *nfs4_create_server(struct nfs_mo=
unt_info *mount_info)
=20
 =09server->cred =3D get_cred(current_cred());
=20
-=09auth_probe =3D mount_info->parsed->auth_info.flavor_len < 1;
+=09auth_probe =3D mount_info->ctx->auth_info.flavor_len < 1;
=20
 =09/* set up the general RPC client */
-=09error =3D nfs4_init_server(server, mount_info->parsed);
+=09error =3D nfs4_init_server(server, mount_info->ctx);
 =09if (error < 0)
 =09=09goto error;
=20
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 38f2eec7e1ad..ca9740137cfe 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -198,15 +198,15 @@ static struct dentry *do_nfs4_mount(struct nfs_server=
 *server, int flags,
 struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 =09=09=09      struct nfs_mount_info *mount_info)
 {
-=09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
+=09struct nfs_fs_context *ctx =3D mount_info->ctx;
 =09struct dentry *res;
=20
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
 =09res =3D do_nfs4_mount(nfs4_create_server(mount_info),
 =09=09=09    flags, mount_info,
-=09=09=09    data->nfs_server.hostname,
-=09=09=09    data->nfs_server.export_path);
+=09=09=09    ctx->nfs_server.hostname,
+=09=09=09    ctx->nfs_server.export_path);
=20
 =09dfprintk(MOUNT, "<-- nfs4_try_mount() =3D %d%s\n",
 =09=09 PTR_ERR_OR_ZERO(res),
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index bfea31cf1c12..3ec46d804bf2 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -726,12 +726,13 @@ bool nfs_auth_info_match(const struct nfs_auth_info *=
auth_info,
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
=20
 /*
- * Ensure that a specified authtype in args->auth_info is supported by
- * the server. Returns 0 and sets args->selected_flavor if it's ok, and
+ * Ensure that a specified authtype in cfg->auth_info is supported by
+ * the server. Returns 0 and sets cfg->selected_flavor if it's ok, and
  * -EACCES if not.
  */
-static int nfs_verify_authflavors(struct nfs_parsed_mount_data *args,
-=09=09=09rpc_authflavor_t *server_authlist, unsigned int count)
+static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
+=09=09=09=09  rpc_authflavor_t *server_authlist,
+=09=09=09=09  unsigned int count)
 {
 =09rpc_authflavor_t flavor =3D RPC_AUTH_MAXFLAVOR;
 =09bool found_auth_null =3D false;
@@ -752,7 +753,7 @@ static int nfs_verify_authflavors(struct nfs_parsed_mou=
nt_data *args,
 =09for (i =3D 0; i < count; i++) {
 =09=09flavor =3D server_authlist[i];
=20
-=09=09if (nfs_auth_info_match(&args->auth_info, flavor))
+=09=09if (nfs_auth_info_match(&cfg->auth_info, flavor))
 =09=09=09goto out;
=20
 =09=09if (flavor =3D=3D RPC_AUTH_NULL)
@@ -760,7 +761,7 @@ static int nfs_verify_authflavors(struct nfs_parsed_mou=
nt_data *args,
 =09}
=20
 =09if (found_auth_null) {
-=09=09flavor =3D args->auth_info.flavors[0];
+=09=09flavor =3D cfg->auth_info.flavors[0];
 =09=09goto out;
 =09}
=20
@@ -769,8 +770,8 @@ static int nfs_verify_authflavors(struct nfs_parsed_mou=
nt_data *args,
 =09return -EACCES;
=20
 out:
-=09args->selected_flavor =3D flavor;
-=09dfprintk(MOUNT, "NFS: using auth flavor %u\n", args->selected_flavor);
+=09cfg->selected_flavor =3D flavor;
+=09dfprintk(MOUNT, "NFS: using auth flavor %u\n", cfg->selected_flavor);
 =09return 0;
 }
=20
@@ -778,50 +779,50 @@ static int nfs_verify_authflavors(struct nfs_parsed_m=
ount_data *args,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_parsed_mount_data *args,
+static int nfs_request_mount(struct nfs_fs_context *cfg,
 =09=09=09     struct nfs_fh *root_fh,
 =09=09=09     rpc_authflavor_t *server_authlist,
 =09=09=09     unsigned int *server_authlist_len)
 {
 =09struct nfs_mount_request request =3D {
 =09=09.sap=09=09=3D (struct sockaddr *)
-=09=09=09=09=09=09&args->mount_server.address,
-=09=09.dirpath=09=3D args->nfs_server.export_path,
-=09=09.protocol=09=3D args->mount_server.protocol,
+=09=09=09=09=09=09&cfg->mount_server.address,
+=09=09.dirpath=09=3D cfg->nfs_server.export_path,
+=09=09.protocol=09=3D cfg->mount_server.protocol,
 =09=09.fh=09=09=3D root_fh,
-=09=09.noresvport=09=3D args->flags & NFS_MOUNT_NORESVPORT,
+=09=09.noresvport=09=3D cfg->flags & NFS_MOUNT_NORESVPORT,
 =09=09.auth_flav_len=09=3D server_authlist_len,
 =09=09.auth_flavs=09=3D server_authlist,
-=09=09.net=09=09=3D args->net,
+=09=09.net=09=09=3D cfg->net,
 =09};
 =09int status;
=20
-=09if (args->mount_server.version =3D=3D 0) {
-=09=09switch (args->version) {
+=09if (cfg->mount_server.version =3D=3D 0) {
+=09=09switch (cfg->version) {
 =09=09=09default:
-=09=09=09=09args->mount_server.version =3D NFS_MNT3_VERSION;
+=09=09=09=09cfg->mount_server.version =3D NFS_MNT3_VERSION;
 =09=09=09=09break;
 =09=09=09case 2:
-=09=09=09=09args->mount_server.version =3D NFS_MNT_VERSION;
+=09=09=09=09cfg->mount_server.version =3D NFS_MNT_VERSION;
 =09=09}
 =09}
-=09request.version =3D args->mount_server.version;
+=09request.version =3D cfg->mount_server.version;
=20
-=09if (args->mount_server.hostname)
-=09=09request.hostname =3D args->mount_server.hostname;
+=09if (cfg->mount_server.hostname)
+=09=09request.hostname =3D cfg->mount_server.hostname;
 =09else
-=09=09request.hostname =3D args->nfs_server.hostname;
+=09=09request.hostname =3D cfg->nfs_server.hostname;
=20
 =09/*
 =09 * Construct the mount server's address.
 =09 */
-=09if (args->mount_server.address.ss_family =3D=3D AF_UNSPEC) {
-=09=09memcpy(request.sap, &args->nfs_server.address,
-=09=09       args->nfs_server.addrlen);
-=09=09args->mount_server.addrlen =3D args->nfs_server.addrlen;
+=09if (cfg->mount_server.address.ss_family =3D=3D AF_UNSPEC) {
+=09=09memcpy(request.sap, &cfg->nfs_server.address,
+=09=09       cfg->nfs_server.addrlen);
+=09=09cfg->mount_server.addrlen =3D cfg->nfs_server.addrlen;
 =09}
-=09request.salen =3D args->mount_server.addrlen;
-=09nfs_set_port(request.sap, &args->mount_server.port, 0);
+=09request.salen =3D cfg->mount_server.addrlen;
+=09nfs_set_port(request.sap, &cfg->mount_server.port, 0);
=20
 =09/*
 =09 * Now ask the mount server to map our export path
@@ -844,12 +845,12 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09bool tried_auth_unix =3D false;
 =09bool auth_null_in_list =3D false;
 =09struct nfs_server *server =3D ERR_PTR(-EACCES);
-=09struct nfs_parsed_mount_data *args =3D mount_info->parsed;
+=09struct nfs_fs_context *ctx =3D mount_info->ctx;
 =09rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 =09unsigned int authlist_len =3D ARRAY_SIZE(authlist);
 =09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
=20
-=09status =3D nfs_request_mount(args, mount_info->mntfh, authlist,
+=09status =3D nfs_request_mount(ctx, mount_info->mntfh, authlist,
 =09=09=09=09=09&authlist_len);
 =09if (status)
 =09=09return ERR_PTR(status);
@@ -858,10 +859,10 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09 * Was a sec=3D authflavor specified in the options? First, verify
 =09 * whether the server supports it, and then just try to use it if so.
 =09 */
-=09if (args->auth_info.flavor_len > 0) {
-=09=09status =3D nfs_verify_authflavors(args, authlist, authlist_len);
+=09if (ctx->auth_info.flavor_len > 0) {
+=09=09status =3D nfs_verify_authflavors(ctx, authlist, authlist_len);
 =09=09dfprintk(MOUNT, "NFS: using auth flavor %u\n",
-=09=09=09 args->selected_flavor);
+=09=09=09 ctx->selected_flavor);
 =09=09if (status)
 =09=09=09return ERR_PTR(status);
 =09=09return nfs_mod->rpc_ops->create_server(mount_info);
@@ -890,7 +891,7 @@ static struct nfs_server *nfs_try_mount_request(struct =
nfs_mount_info *mount_inf
 =09=09=09/* Fallthrough */
 =09=09}
 =09=09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
-=09=09args->selected_flavor =3D flavor;
+=09=09ctx->selected_flavor =3D flavor;
 =09=09server =3D nfs_mod->rpc_ops->create_server(mount_info);
 =09=09if (!IS_ERR(server))
 =09=09=09return server;
@@ -906,7 +907,7 @@ static struct nfs_server *nfs_try_mount_request(struct =
nfs_mount_info *mount_inf
=20
 =09/* Last chance! Try AUTH_UNIX */
 =09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNI=
X);
-=09args->selected_flavor =3D RPC_AUTH_UNIX;
+=09ctx->selected_flavor =3D RPC_AUTH_UNIX;
 =09return nfs_mod->rpc_ops->create_server(mount_info);
 }
=20
@@ -916,7 +917,7 @@ struct dentry *nfs_try_mount(int flags, const char *dev=
_name,
 =09=09=09     struct nfs_mount_info *mount_info)
 {
 =09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
-=09if (mount_info->parsed->need_mount)
+=09if (mount_info->ctx->need_mount)
 =09=09mount_info->server =3D nfs_try_mount_request(mount_info);
 =09else
 =09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info);
@@ -940,24 +941,24 @@ EXPORT_SYMBOL_GPL(nfs_try_mount);
=20
 static int
 nfs_compare_remount_data(struct nfs_server *nfss,
-=09=09=09 struct nfs_parsed_mount_data *data)
+=09=09=09 struct nfs_fs_context *ctx)
 {
-=09if ((data->flags ^ nfss->flags) & NFS_REMOUNT_CMP_FLAGMASK ||
-=09    data->rsize !=3D nfss->rsize ||
-=09    data->wsize !=3D nfss->wsize ||
-=09    data->version !=3D nfss->nfs_client->rpc_ops->version ||
-=09    data->minorversion !=3D nfss->nfs_client->cl_minorversion ||
-=09    data->retrans !=3D nfss->client->cl_timeout->to_retries ||
-=09    !nfs_auth_info_match(&data->auth_info, nfss->client->cl_auth->au_fl=
avor) ||
-=09    data->acregmin !=3D nfss->acregmin / HZ ||
-=09    data->acregmax !=3D nfss->acregmax / HZ ||
-=09    data->acdirmin !=3D nfss->acdirmin / HZ ||
-=09    data->acdirmax !=3D nfss->acdirmax / HZ ||
-=09    data->timeo !=3D (10U * nfss->client->cl_timeout->to_initval / HZ) =
||
-=09    (data->options & NFS_OPTION_FSCACHE) !=3D (nfss->options & NFS_OPTI=
ON_FSCACHE) ||
-=09    data->nfs_server.port !=3D nfss->port ||
-=09    data->nfs_server.addrlen !=3D nfss->nfs_client->cl_addrlen ||
-=09    !rpc_cmp_addr((struct sockaddr *)&data->nfs_server.address,
+=09if ((ctx->flags ^ nfss->flags) & NFS_REMOUNT_CMP_FLAGMASK ||
+=09    ctx->rsize !=3D nfss->rsize ||
+=09    ctx->wsize !=3D nfss->wsize ||
+=09    ctx->version !=3D nfss->nfs_client->rpc_ops->version ||
+=09    ctx->minorversion !=3D nfss->nfs_client->cl_minorversion ||
+=09    ctx->retrans !=3D nfss->client->cl_timeout->to_retries ||
+=09    !nfs_auth_info_match(&ctx->auth_info, nfss->client->cl_auth->au_fla=
vor) ||
+=09    ctx->acregmin !=3D nfss->acregmin / HZ ||
+=09    ctx->acregmax !=3D nfss->acregmax / HZ ||
+=09    ctx->acdirmin !=3D nfss->acdirmin / HZ ||
+=09    ctx->acdirmax !=3D nfss->acdirmax / HZ ||
+=09    ctx->timeo !=3D (10U * nfss->client->cl_timeout->to_initval / HZ) |=
|
+=09    (ctx->options & NFS_OPTION_FSCACHE) !=3D (nfss->options & NFS_OPTIO=
N_FSCACHE) ||
+=09    ctx->nfs_server.port !=3D nfss->port ||
+=09    ctx->nfs_server.addrlen !=3D nfss->nfs_client->cl_addrlen ||
+=09    !rpc_cmp_addr((struct sockaddr *)&ctx->nfs_server.address,
 =09=09=09  (struct sockaddr *)&nfss->nfs_client->cl_addr))
 =09=09return -EINVAL;
=20
@@ -969,7 +970,7 @@ nfs_remount(struct super_block *sb, int *flags, char *r=
aw_data)
 {
 =09int error;
 =09struct nfs_server *nfss =3D sb->s_fs_info;
-=09struct nfs_parsed_mount_data *data;
+=09struct nfs_fs_context *ctx;
 =09struct nfs_mount_data *options =3D (struct nfs_mount_data *)raw_data;
 =09struct nfs4_mount_data *options4 =3D (struct nfs4_mount_data *)raw_data=
;
 =09u32 nfsvers =3D nfss->nfs_client->rpc_ops->version;
@@ -987,32 +988,32 @@ nfs_remount(struct super_block *sb, int *flags, char =
*raw_data)
 =09=09=09=09=09   options->version <=3D 6))))
 =09=09return 0;
=20
-=09data =3D nfs_alloc_parsed_mount_data();
-=09if (data =3D=3D NULL)
+=09ctx =3D nfs_alloc_parsed_mount_data();
+=09if (ctx =3D=3D NULL)
 =09=09return -ENOMEM;
=20
 =09/* fill out struct with values from existing mount */
-=09data->flags =3D nfss->flags;
-=09data->rsize =3D nfss->rsize;
-=09data->wsize =3D nfss->wsize;
-=09data->retrans =3D nfss->client->cl_timeout->to_retries;
-=09data->selected_flavor =3D nfss->client->cl_auth->au_flavor;
-=09data->acregmin =3D nfss->acregmin / HZ;
-=09data->acregmax =3D nfss->acregmax / HZ;
-=09data->acdirmin =3D nfss->acdirmin / HZ;
-=09data->acdirmax =3D nfss->acdirmax / HZ;
-=09data->timeo =3D 10U * nfss->client->cl_timeout->to_initval / HZ;
-=09data->nfs_server.port =3D nfss->port;
-=09data->nfs_server.addrlen =3D nfss->nfs_client->cl_addrlen;
-=09data->version =3D nfsvers;
-=09data->minorversion =3D nfss->nfs_client->cl_minorversion;
-=09data->net =3D current->nsproxy->net_ns;
-=09memcpy(&data->nfs_server.address, &nfss->nfs_client->cl_addr,
-=09=09data->nfs_server.addrlen);
+=09ctx->flags =3D nfss->flags;
+=09ctx->rsize =3D nfss->rsize;
+=09ctx->wsize =3D nfss->wsize;
+=09ctx->retrans =3D nfss->client->cl_timeout->to_retries;
+=09ctx->selected_flavor =3D nfss->client->cl_auth->au_flavor;
+=09ctx->acregmin =3D nfss->acregmin / HZ;
+=09ctx->acregmax =3D nfss->acregmax / HZ;
+=09ctx->acdirmin =3D nfss->acdirmin / HZ;
+=09ctx->acdirmax =3D nfss->acdirmax / HZ;
+=09ctx->timeo =3D 10U * nfss->client->cl_timeout->to_initval / HZ;
+=09ctx->nfs_server.port =3D nfss->port;
+=09ctx->nfs_server.addrlen =3D nfss->nfs_client->cl_addrlen;
+=09ctx->version =3D nfsvers;
+=09ctx->minorversion =3D nfss->nfs_client->cl_minorversion;
+=09ctx->net =3D current->nsproxy->net_ns;
+=09memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
+=09=09ctx->nfs_server.addrlen);
=20
 =09/* overwrite those values with any that were specified */
 =09error =3D -EINVAL;
-=09if (!nfs_parse_mount_options((char *)options, data))
+=09if (!nfs_parse_mount_options((char *)options, ctx))
 =09=09goto out;
=20
 =09/*
@@ -1021,15 +1022,15 @@ nfs_remount(struct super_block *sb, int *flags, cha=
r *raw_data)
 =09 * will clear SB_SYNCHRONOUS if -o sync wasn't specified in the
 =09 * remount options, so we have to explicitly reset it.
 =09 */
-=09if (data->flags & NFS_MOUNT_NOAC)
+=09if (ctx->flags & NFS_MOUNT_NOAC)
 =09=09*flags |=3D SB_SYNCHRONOUS;
=20
 =09/* compare new mount options with old ones */
-=09error =3D nfs_compare_remount_data(nfss, data);
+=09error =3D nfs_compare_remount_data(nfss, ctx);
 =09if (!error)
-=09=09error =3D security_sb_remount(sb, data->lsm_opts);
+=09=09error =3D security_sb_remount(sb, ctx->lsm_opts);
 out:
-=09nfs_free_parsed_mount_data(data);
+=09nfs_free_parsed_mount_data(ctx);
 =09return error;
 }
 EXPORT_SYMBOL_GPL(nfs_remount);
@@ -1039,15 +1040,15 @@ EXPORT_SYMBOL_GPL(nfs_remount);
  */
 static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *=
mount_info)
 {
-=09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
+=09struct nfs_fs_context *ctx =3D mount_info->ctx;
 =09struct nfs_server *server =3D NFS_SB(sb);
=20
 =09sb->s_blocksize_bits =3D 0;
 =09sb->s_blocksize =3D 0;
 =09sb->s_xattr =3D server->nfs_client->cl_nfs_mod->xattr;
 =09sb->s_op =3D server->nfs_client->cl_nfs_mod->sops;
-=09if (data && data->bsize)
-=09=09sb->s_blocksize =3D nfs_block_size(data->bsize, &sb->s_blocksize_bit=
s);
+=09if (ctx && ctx->bsize)
+=09=09sb->s_blocksize =3D nfs_block_size(ctx->bsize, &sb->s_blocksize_bits=
);
=20
 =09if (server->nfs_client->rpc_ops->version !=3D 2) {
 =09=09/* The VFS shouldn't apply the umask to mode bits. We will do
@@ -1208,7 +1209,7 @@ static int nfs_compare_super(struct super_block *sb, =
void *data)
=20
 #ifdef CONFIG_NFS_FSCACHE
 static void nfs_get_cache_cookie(struct super_block *sb,
-=09=09=09=09 struct nfs_parsed_mount_data *parsed,
+=09=09=09=09 struct nfs_fs_context *ctx,
 =09=09=09=09 struct nfs_clone_mount *cloned)
 {
 =09struct nfs_server *nfss =3D NFS_SB(sb);
@@ -1218,12 +1219,12 @@ static void nfs_get_cache_cookie(struct super_block=
 *sb,
 =09nfss->fscache_key =3D NULL;
 =09nfss->fscache =3D NULL;
=20
-=09if (parsed) {
-=09=09if (!(parsed->options & NFS_OPTION_FSCACHE))
+=09if (ctx) {
+=09=09if (!(ctx->options & NFS_OPTION_FSCACHE))
 =09=09=09return;
-=09=09if (parsed->fscache_uniq) {
-=09=09=09uniq =3D parsed->fscache_uniq;
-=09=09=09ulen =3D strlen(parsed->fscache_uniq);
+=09=09if (ctx->fscache_uniq) {
+=09=09=09uniq =3D ctx->fscache_uniq;
+=09=09=09ulen =3D strlen(ctx->fscache_uniq);
 =09=09}
 =09} else if (cloned) {
 =09=09struct nfs_server *mnt_s =3D NFS_SB(cloned->sb);
@@ -1240,7 +1241,7 @@ static void nfs_get_cache_cookie(struct super_block *=
sb,
 }
 #else
 static void nfs_get_cache_cookie(struct super_block *sb,
-=09=09=09=09 struct nfs_parsed_mount_data *parsed,
+=09=09=09=09 struct nfs_fs_context *parsed,
 =09=09=09=09 struct nfs_clone_mount *cloned)
 {
 }
@@ -1312,7 +1313,7 @@ static struct dentry *nfs_fs_mount_common(int flags, =
const char *dev_name,
 =09=09=09s->s_blocksize_bits =3D bsize;
 =09=09=09s->s_blocksize =3D 1U << bsize;
 =09=09}
-=09=09nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
+=09=09nfs_get_cache_cookie(s, mount_info->ctx, mount_info->cloned);
 =09=09if (!(server->flags & NFS_MOUNT_UNSHARED))
 =09=09=09s->s_iflags |=3D SB_I_MULTIROOT;
 =09}
@@ -1333,7 +1334,7 @@ static struct dentry *nfs_fs_mount_common(int flags, =
const char *dev_name,
 =09=09error =3D security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kfla=
gs,
 =09=09=09=09&kflags_out);
 =09} else {
-=09=09error =3D security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
+=09=09error =3D security_sb_set_mnt_opts(s, mount_info->ctx->lsm_opts,
 =09=09=09=09=09=09=09kflags, &kflags_out);
 =09}
 =09if (error)
@@ -1370,21 +1371,22 @@ struct dentry *nfs_fs_mount(struct file_system_type=
 *fs_type,
 =09struct nfs_subversion *nfs_mod;
 =09int error;
=20
-=09mount_info.parsed =3D nfs_alloc_parsed_mount_data();
+=09mount_info.ctx =3D nfs_alloc_parsed_mount_data();
 =09mount_info.mntfh =3D nfs_alloc_fhandle();
-=09if (mount_info.parsed =3D=3D NULL || mount_info.mntfh =3D=3D NULL)
+=09if (mount_info.ctx =3D=3D NULL || mount_info.mntfh =3D=3D NULL)
 =09=09goto out;
=20
 =09/* Validate the mount data */
-=09error =3D nfs_validate_mount_data(fs_type, raw_data, mount_info.parsed,=
 mount_info.mntfh, dev_name);
+=09error =3D nfs_validate_mount_data(fs_type, raw_data, mount_info.ctx, mo=
unt_info.mntfh, dev_name);
 =09if (error =3D=3D NFS_TEXT_DATA)
-=09=09error =3D nfs_validate_text_mount_data(raw_data, mount_info.parsed, =
dev_name);
+=09=09error =3D nfs_validate_text_mount_data(raw_data,
+=09=09=09=09=09=09     mount_info.ctx, dev_name);
 =09if (error < 0) {
 =09=09mntroot =3D ERR_PTR(error);
 =09=09goto out;
 =09}
=20
-=09nfs_mod =3D get_nfs_version(mount_info.parsed->version);
+=09nfs_mod =3D get_nfs_version(mount_info.ctx->version);
 =09if (IS_ERR(nfs_mod)) {
 =09=09mntroot =3D ERR_CAST(nfs_mod);
 =09=09goto out;
@@ -1395,7 +1397,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *=
fs_type,
=20
 =09put_nfs_version(nfs_mod);
 out:
-=09nfs_free_parsed_mount_data(mount_info.parsed);
+=09nfs_free_parsed_mount_data(mount_info.ctx);
 =09nfs_free_fhandle(mount_info.mntfh);
 =09return mntroot;
 }
--=20
2.17.2

