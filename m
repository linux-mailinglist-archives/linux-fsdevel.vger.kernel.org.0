Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32322118827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLJMbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:31:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727642AbfLJMba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU+4LwkPRscyhiRbRAsu/HXHsq6UQAUpC67Uy/n/iWQ=;
        b=WKSQ6t9JTRldGSYKvyfSDtLjvqX5o8SicrU3mIunksqAct9MrYe8Ta/Ra6o6xl1culisXW
        kNY4LHnvTyhkT5jlH2OUlbAZ8JzkGGrE19b0Rj5vFcjIbxNRiBgj7z758swZwNIjg828cn
        RyB/AZGJ9qp8OQIlTx8/buB8rNBXw48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-DePN9eeTOmS6sNTFiAs26w-1; Tue, 10 Dec 2019 07:31:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2D6800D53;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90C4419C6A;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 0B1B320C41; Tue, 10 Dec 2019 07:31:16 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 23/27] NFS: rename nfs_fs_context pointer arg in a few functions
Date:   Tue, 10 Dec 2019 07:31:11 -0500
Message-Id: <20191210123115.1655-24-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DePN9eeTOmS6sNTFiAs26w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Rename cfg to ctx in nfs_init_server(), nfs_verify_authflavors(),
and nfs_request_mount().  No functional changes.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/client.c | 62 ++++++++++++++++++++++++-------------------------
 fs/nfs/super.c  | 54 +++++++++++++++++++++---------------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 0a00df8e71bb..69c0708b2acc 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -658,28 +658,28 @@ EXPORT_SYMBOL_GPL(nfs_init_client);
  * Create a version 2 or 3 client
  */
 static int nfs_init_server(struct nfs_server *server,
-=09=09=09   const struct nfs_fs_context *cfg,
+=09=09=09   const struct nfs_fs_context *ctx,
 =09=09=09   struct nfs_subversion *nfs_mod)
 {
 =09struct rpc_timeout timeparms;
 =09struct nfs_client_initdata cl_init =3D {
-=09=09.hostname =3D cfg->nfs_server.hostname,
-=09=09.addr =3D (const struct sockaddr *)&cfg->nfs_server.address,
-=09=09.addrlen =3D cfg->nfs_server.addrlen,
+=09=09.hostname =3D ctx->nfs_server.hostname,
+=09=09.addr =3D (const struct sockaddr *)&ctx->nfs_server.address,
+=09=09.addrlen =3D ctx->nfs_server.addrlen,
 =09=09.nfs_mod =3D nfs_mod,
-=09=09.proto =3D cfg->nfs_server.protocol,
-=09=09.net =3D cfg->net,
+=09=09.proto =3D ctx->nfs_server.protocol,
+=09=09.net =3D ctx->net,
 =09=09.timeparms =3D &timeparms,
 =09=09.cred =3D server->cred,
-=09=09.nconnect =3D cfg->nfs_server.nconnect,
+=09=09.nconnect =3D ctx->nfs_server.nconnect,
 =09=09.init_flags =3D (1UL << NFS_CS_REUSEPORT),
 =09};
 =09struct nfs_client *clp;
 =09int error;
=20
-=09nfs_init_timeout_values(&timeparms, cfg->nfs_server.protocol,
-=09=09=09=09cfg->timeo, cfg->retrans);
-=09if (cfg->flags & NFS_MOUNT_NORESVPORT)
+=09nfs_init_timeout_values(&timeparms, ctx->nfs_server.protocol,
+=09=09=09=09ctx->timeo, ctx->retrans);
+=09if (ctx->flags & NFS_MOUNT_NORESVPORT)
 =09=09set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
=20
 =09/* Allocate or find a client reference we can use */
@@ -690,46 +690,46 @@ static int nfs_init_server(struct nfs_server *server,
 =09server->nfs_client =3D clp;
=20
 =09/* Initialise the client representation from the mount data */
-=09server->flags =3D cfg->flags;
-=09server->options =3D cfg->options;
+=09server->flags =3D ctx->flags;
+=09server->options =3D ctx->options;
 =09server->caps |=3D NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
 =09=09NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
 =09=09NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
=20
-=09if (cfg->rsize)
-=09=09server->rsize =3D nfs_block_size(cfg->rsize, NULL);
-=09if (cfg->wsize)
-=09=09server->wsize =3D nfs_block_size(cfg->wsize, NULL);
+=09if (ctx->rsize)
+=09=09server->rsize =3D nfs_block_size(ctx->rsize, NULL);
+=09if (ctx->wsize)
+=09=09server->wsize =3D nfs_block_size(ctx->wsize, NULL);
=20
-=09server->acregmin =3D cfg->acregmin * HZ;
-=09server->acregmax =3D cfg->acregmax * HZ;
-=09server->acdirmin =3D cfg->acdirmin * HZ;
-=09server->acdirmax =3D cfg->acdirmax * HZ;
+=09server->acregmin =3D ctx->acregmin * HZ;
+=09server->acregmax =3D ctx->acregmax * HZ;
+=09server->acdirmin =3D ctx->acdirmin * HZ;
+=09server->acdirmax =3D ctx->acdirmax * HZ;
=20
 =09/* Start lockd here, before we might error out */
 =09error =3D nfs_start_lockd(server);
 =09if (error < 0)
 =09=09goto error;
=20
-=09server->port =3D cfg->nfs_server.port;
-=09server->auth_info =3D cfg->auth_info;
+=09server->port =3D ctx->nfs_server.port;
+=09server->auth_info =3D ctx->auth_info;
=20
 =09error =3D nfs_init_server_rpcclient(server, &timeparms,
-=09=09=09=09=09  cfg->selected_flavor);
+=09=09=09=09=09  ctx->selected_flavor);
 =09if (error < 0)
 =09=09goto error;
=20
 =09/* Preserve the values of mount_server-related mount options */
-=09if (cfg->mount_server.addrlen) {
-=09=09memcpy(&server->mountd_address, &cfg->mount_server.address,
-=09=09=09cfg->mount_server.addrlen);
-=09=09server->mountd_addrlen =3D cfg->mount_server.addrlen;
+=09if (ctx->mount_server.addrlen) {
+=09=09memcpy(&server->mountd_address, &ctx->mount_server.address,
+=09=09=09ctx->mount_server.addrlen);
+=09=09server->mountd_addrlen =3D ctx->mount_server.addrlen;
 =09}
-=09server->mountd_version =3D cfg->mount_server.version;
-=09server->mountd_port =3D cfg->mount_server.port;
-=09server->mountd_protocol =3D cfg->mount_server.protocol;
+=09server->mountd_version =3D ctx->mount_server.version;
+=09server->mountd_port =3D ctx->mount_server.port;
+=09server->mountd_protocol =3D ctx->mount_server.protocol;
=20
-=09server->namelen  =3D cfg->namlen;
+=09server->namelen  =3D ctx->namlen;
 =09return 0;
=20
 error:
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 59962bc0118f..6c9573a32a69 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -726,11 +726,11 @@ bool nfs_auth_info_match(const struct nfs_auth_info *=
auth_info,
 EXPORT_SYMBOL_GPL(nfs_auth_info_match);
=20
 /*
- * Ensure that a specified authtype in cfg->auth_info is supported by
- * the server. Returns 0 and sets cfg->selected_flavor if it's ok, and
+ * Ensure that a specified authtype in ctx->auth_info is supported by
+ * the server. Returns 0 and sets ctx->selected_flavor if it's ok, and
  * -EACCES if not.
  */
-static int nfs_verify_authflavors(struct nfs_fs_context *cfg,
+static int nfs_verify_authflavors(struct nfs_fs_context *ctx,
 =09=09=09=09  rpc_authflavor_t *server_authlist,
 =09=09=09=09  unsigned int count)
 {
@@ -753,7 +753,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context=
 *cfg,
 =09for (i =3D 0; i < count; i++) {
 =09=09flavor =3D server_authlist[i];
=20
-=09=09if (nfs_auth_info_match(&cfg->auth_info, flavor))
+=09=09if (nfs_auth_info_match(&ctx->auth_info, flavor))
 =09=09=09goto out;
=20
 =09=09if (flavor =3D=3D RPC_AUTH_NULL)
@@ -761,7 +761,7 @@ static int nfs_verify_authflavors(struct nfs_fs_context=
 *cfg,
 =09}
=20
 =09if (found_auth_null) {
-=09=09flavor =3D cfg->auth_info.flavors[0];
+=09=09flavor =3D ctx->auth_info.flavors[0];
 =09=09goto out;
 =09}
=20
@@ -770,8 +770,8 @@ static int nfs_verify_authflavors(struct nfs_fs_context=
 *cfg,
 =09return -EACCES;
=20
 out:
-=09cfg->selected_flavor =3D flavor;
-=09dfprintk(MOUNT, "NFS: using auth flavor %u\n", cfg->selected_flavor);
+=09ctx->selected_flavor =3D flavor;
+=09dfprintk(MOUNT, "NFS: using auth flavor %u\n", ctx->selected_flavor);
 =09return 0;
 }
=20
@@ -779,50 +779,50 @@ static int nfs_verify_authflavors(struct nfs_fs_conte=
xt *cfg,
  * Use the remote server's MOUNT service to request the NFS file handle
  * corresponding to the provided path.
  */
-static int nfs_request_mount(struct nfs_fs_context *cfg,
+static int nfs_request_mount(struct nfs_fs_context *ctx,
 =09=09=09     struct nfs_fh *root_fh,
 =09=09=09     rpc_authflavor_t *server_authlist,
 =09=09=09     unsigned int *server_authlist_len)
 {
 =09struct nfs_mount_request request =3D {
 =09=09.sap=09=09=3D (struct sockaddr *)
-=09=09=09=09=09=09&cfg->mount_server.address,
-=09=09.dirpath=09=3D cfg->nfs_server.export_path,
-=09=09.protocol=09=3D cfg->mount_server.protocol,
+=09=09=09=09=09=09&ctx->mount_server.address,
+=09=09.dirpath=09=3D ctx->nfs_server.export_path,
+=09=09.protocol=09=3D ctx->mount_server.protocol,
 =09=09.fh=09=09=3D root_fh,
-=09=09.noresvport=09=3D cfg->flags & NFS_MOUNT_NORESVPORT,
+=09=09.noresvport=09=3D ctx->flags & NFS_MOUNT_NORESVPORT,
 =09=09.auth_flav_len=09=3D server_authlist_len,
 =09=09.auth_flavs=09=3D server_authlist,
-=09=09.net=09=09=3D cfg->net,
+=09=09.net=09=09=3D ctx->net,
 =09};
 =09int status;
=20
-=09if (cfg->mount_server.version =3D=3D 0) {
-=09=09switch (cfg->version) {
+=09if (ctx->mount_server.version =3D=3D 0) {
+=09=09switch (ctx->version) {
 =09=09=09default:
-=09=09=09=09cfg->mount_server.version =3D NFS_MNT3_VERSION;
+=09=09=09=09ctx->mount_server.version =3D NFS_MNT3_VERSION;
 =09=09=09=09break;
 =09=09=09case 2:
-=09=09=09=09cfg->mount_server.version =3D NFS_MNT_VERSION;
+=09=09=09=09ctx->mount_server.version =3D NFS_MNT_VERSION;
 =09=09}
 =09}
-=09request.version =3D cfg->mount_server.version;
+=09request.version =3D ctx->mount_server.version;
=20
-=09if (cfg->mount_server.hostname)
-=09=09request.hostname =3D cfg->mount_server.hostname;
+=09if (ctx->mount_server.hostname)
+=09=09request.hostname =3D ctx->mount_server.hostname;
 =09else
-=09=09request.hostname =3D cfg->nfs_server.hostname;
+=09=09request.hostname =3D ctx->nfs_server.hostname;
=20
 =09/*
 =09 * Construct the mount server's address.
 =09 */
-=09if (cfg->mount_server.address.sa_family =3D=3D AF_UNSPEC) {
-=09=09memcpy(request.sap, &cfg->nfs_server.address,
-=09=09       cfg->nfs_server.addrlen);
-=09=09cfg->mount_server.addrlen =3D cfg->nfs_server.addrlen;
+=09if (ctx->mount_server.address.sa_family =3D=3D AF_UNSPEC) {
+=09=09memcpy(request.sap, &ctx->nfs_server.address,
+=09=09       ctx->nfs_server.addrlen);
+=09=09ctx->mount_server.addrlen =3D ctx->nfs_server.addrlen;
 =09}
-=09request.salen =3D cfg->mount_server.addrlen;
-=09nfs_set_port(request.sap, &cfg->mount_server.port, 0);
+=09request.salen =3D ctx->mount_server.addrlen;
+=09nfs_set_port(request.sap, &ctx->mount_server.port, 0);
=20
 =09/*
 =09 * Now ask the mount server to map our export path
--=20
2.17.2

