Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72716103EA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfKTP36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:29:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730177AbfKTP17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3o25btD/Me6swLhMEPGgL7Myh0lfgdzCdx5NhPd0Xk=;
        b=L1yiRt/fZePh56PGE4aQLcx7N88QsbBI72N1u2nDF8xTHOYi00rg8kmOc+jt0o0emo9fGH
        Giup4X3aons5NWxNu7eK5fKHAJi3vdLpRZ0IFx3T35xm1XXxoJsHqz8YHJMruUziVvExjR
        EeDroNzprQHB8Q/JWEkLB/bMAFtQrvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-435xiKmEMV6a6p5qLAIQJA-1; Wed, 20 Nov 2019 10:27:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D438024C9;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 822D460BAD;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 92E6020AA2; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 22/27] NFS: Do some tidying of the parsing code
Date:   Wed, 20 Nov 2019 10:27:45 -0500
Message-Id: <20191120152750.6880-23-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 435xiKmEMV6a6p5qLAIQJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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
 fs/nfs/fs_context.c | 128 +++++++++++++++++++-------------------------
 fs/nfs/internal.h   |  16 ++++--
 fs/nfs/super.c      |   2 +-
 3 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ad502b37a3f3..96720cfd1065 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -343,8 +343,9 @@ static void nfs_set_mount_transport_protocol(struct nfs=
_fs_context *ctx)
  * Add 'flavor' to 'auth_info' if not already present.
  * Returns true if 'flavor' ends up in the list, false otherwise
  */
-static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
-=09=09=09      rpc_authflavor_t flavor)
+static int nfs_auth_info_add(struct nfs_fs_context *ctx,
+=09=09=09     struct nfs_auth_info *auth_info,
+=09=09=09     rpc_authflavor_t flavor)
 {
 =09unsigned int i;
 =09unsigned int max_flavor_len =3D ARRAY_SIZE(auth_info->flavors);
@@ -352,26 +353,27 @@ static bool nfs_auth_info_add(struct nfs_auth_info *a=
uth_info,
 =09/* make sure this flavor isn't already in the list */
 =09for (i =3D 0; i < auth_info->flavor_len; i++) {
 =09=09if (flavor =3D=3D auth_info->flavors[i])
-=09=09=09return true;
+=09=09=09return 0;
 =09}
=20
 =09if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
 =09=09dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
-=09=09return false;
+=09=09return -EINVAL;
 =09}
=20
 =09auth_info->flavors[auth_info->flavor_len++] =3D flavor;
-=09return true;
+=09return 0;
 }
=20
 /*
  * Parse the value of the 'sec=3D' option.
  */
-static int nfs_parse_security_flavors(char *value, struct nfs_fs_context *=
ctx)
+static int nfs_parse_security_flavors(struct nfs_fs_context *ctx, char *va=
lue)
 {
 =09substring_t args[MAX_OPT_ARGS];
 =09rpc_authflavor_t pseudoflavor;
 =09char *p;
+=09int ret;
=20
 =09dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
=20
@@ -413,19 +415,20 @@ static int nfs_parse_security_flavors(char *value, st=
ruct nfs_fs_context *ctx)
 =09=09default:
 =09=09=09dfprintk(MOUNT,
 =09=09=09=09 "NFS: sec=3D option '%s' not recognized\n", p);
-=09=09=09return 0;
+=09=09=09return -EINVAL;
 =09=09}
=20
-=09=09if (!nfs_auth_info_add(&ctx->auth_info, pseudoflavor))
-=09=09=09return 0;
+=09=09ret =3D nfs_auth_info_add(ctx, &ctx->auth_info, pseudoflavor);
+=09=09if (ret < 0)
+=09=09=09return ret;
 =09}
=20
-=09return 1;
+=09return 0;
 }
=20
-static int nfs_parse_version_string(char *string,
-=09=09struct nfs_fs_context *ctx,
-=09=09substring_t *args)
+static int nfs_parse_version_string(struct nfs_fs_context *ctx,
+=09=09=09=09    char *string,
+=09=09=09=09    substring_t *args)
 {
 =09ctx->flags &=3D ~NFS_MOUNT_VER3;
 =09switch (match_token(string, nfs_vers_tokens, args)) {
@@ -456,9 +459,10 @@ static int nfs_parse_version_string(char *string,
 =09=09ctx->minorversion =3D 2;
 =09=09break;
 =09default:
-=09=09return 0;
+=09=09dfprintk(MOUNT, "NFS:   Unsupported NFS version\n");
+=09=09return -EINVAL;
 =09}
-=09return 1;
+=09return 0;
 }
=20
 static int nfs_get_option_str(substring_t args[], char **option)
@@ -513,7 +517,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 {
 =09substring_t args[MAX_OPT_ARGS];
 =09char *string;
-=09int token, rc;
+=09int token, ret;
=20
 =09dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", p);
=20
@@ -553,13 +557,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09break;
 =09case Opt_lock:
 =09=09ctx->flags &=3D ~NFS_MOUNT_NONLM;
-=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
+=09=09ctx->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 =09=09break;
 =09case Opt_nolock:
 =09=09ctx->flags |=3D NFS_MOUNT_NONLM;
-=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
-=09=09=09       NFS_MOUNT_LOCAL_FCNTL);
+=09=09ctx->flags |=3D (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
 =09=09break;
 =09case Opt_udp:
 =09=09ctx->flags &=3D ~NFS_MOUNT_TCP;
@@ -692,29 +694,25 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09rc =3D nfs_parse_version_string(string, ctx, args);
+=09=09ret =3D nfs_parse_version_string(ctx, string, args);
 =09=09kfree(string);
-=09=09if (!rc)
-=09=09=09goto out_invalid_value;
+=09=09if (ret < 0)
+=09=09=09return ret;
 =09=09break;
 =09case Opt_sec:
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09rc =3D nfs_parse_security_flavors(string, ctx);
+=09=09ret =3D nfs_parse_security_flavors(ctx, string);
 =09=09kfree(string);
-=09=09if (!rc) {
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09 "security flavor\n");
-=09=09=09return -EINVAL;
-=09=09}
+=09=09if (ret < 0)
+=09=09=09return ret;
 =09=09break;
 =09case Opt_proto:
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09token =3D match_token(string,
-=09=09=09=09    nfs_xprt_protocol_tokens, args);
+=09=09token =3D match_token(string, nfs_xprt_protocol_tokens, args);
=20
 =09=09ctx->protofamily =3D AF_INET;
 =09=09switch (token) {
@@ -742,9 +740,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09xprt_load_transport(string);
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09 "transport protocol\n");
 =09=09=09kfree(string);
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 =09=09=09return -EINVAL;
 =09=09}
 =09=09kfree(string);
@@ -753,8 +750,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09token =3D match_token(string,
-=09=09=09=09    nfs_xprt_protocol_tokens, args);
+=09=09token =3D match_token(string, nfs_xprt_protocol_tokens, args);
 =09=09kfree(string);
=20
 =09=09ctx->mountfamily =3D AF_INET;
@@ -773,8 +769,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09break;
 =09=09case Opt_xprt_rdma: /* not used for side protocols */
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized "
-=09=09=09=09 "transport protocol\n");
+=09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
 =09=09=09return -EINVAL;
 =09=09}
 =09=09break;
@@ -784,9 +779,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09goto out_nomem;
 =09=09ctx->nfs_server.addrlen =3D
 =09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09 (struct sockaddr *)
 =09=09=09=09 &ctx->nfs_server.address,
-=09=09=09=09 sizeof(ctx->nfs_server.address));
+=09=09=09=09 sizeof(ctx->nfs_server._address));
 =09=09kfree(string);
 =09=09if (ctx->nfs_server.addrlen =3D=3D 0)
 =09=09=09goto out_invalid_address;
@@ -796,8 +790,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09goto out_nomem;
 =09=09break;
 =09case Opt_mounthost:
-=09=09if (nfs_get_option_str(args,
-=09=09=09=09       &ctx->mount_server.hostname))
+=09=09if (nfs_get_option_str(args, &ctx->mount_server.hostname))
 =09=09=09goto out_nomem;
 =09=09break;
 =09case Opt_mountaddr:
@@ -806,9 +799,8 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09goto out_nomem;
 =09=09ctx->mount_server.addrlen =3D
 =09=09=09rpc_pton(ctx->net, string, strlen(string),
-=09=09=09=09 (struct sockaddr *)
 =09=09=09=09 &ctx->mount_server.address,
-=09=09=09=09 sizeof(ctx->mount_server.address));
+=09=09=09=09 sizeof(ctx->mount_server._address));
 =09=09kfree(string);
 =09=09if (ctx->mount_server.addrlen =3D=3D 0)
 =09=09=09goto out_invalid_address;
@@ -822,8 +814,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09token =3D match_token(string,
-=09=09=09=09    nfs_lookupcache_tokens, args);
+=09=09token =3D match_token(string, nfs_lookupcache_tokens, args);
 =09=09kfree(string);
 =09=09switch (token) {
 =09=09case Opt_lookupcache_all:
@@ -837,10 +828,9 @@ static int nfs_fs_context_parse_option(struct nfs_fs_c=
ontext *ctx, char *p)
 =09=09=09ctx->flags |=3D NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CAC=
HE_NONE;
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   invalid "
-=09=09=09=09 "lookupcache argument\n");
+=09=09=09dfprintk(MOUNT, "NFS:   invalid lookupcache argument\n");
 =09=09=09return -EINVAL;
-=09=09};
+=09=09}
 =09=09break;
 =09case Opt_fscache_uniq:
 =09=09if (nfs_get_option_str(args, &ctx->fscache_uniq))
@@ -851,8 +841,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09string =3D match_strdup(args);
 =09=09if (string =3D=3D NULL)
 =09=09=09goto out_nomem;
-=09=09token =3D match_token(string, nfs_local_lock_tokens,
-=09=09=09=09    args);
+=09=09token =3D match_token(string, nfs_local_lock_tokens, args);
 =09=09kfree(string);
 =09=09switch (token) {
 =09=09case Opt_local_lock_all:
@@ -870,8 +859,7 @@ static int nfs_fs_context_parse_option(struct nfs_fs_co=
ntext *ctx, char *p)
 =09=09=09=09=09NFS_MOUNT_LOCAL_FCNTL);
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09"
-=09=09=09=09 "local_lock argument\n");
+=09=09=09dfprintk(MOUNT, "NFS:=09invalid=09local_lock argument\n");
 =09=09=09return -EINVAL;
 =09=09};
 =09=09break;
@@ -885,13 +873,11 @@ static int nfs_fs_context_parse_option(struct nfs_fs_=
context *ctx, char *p)
 =09=09break;
 =09case Opt_userspace:
 =09case Opt_deprecated:
-=09=09dfprintk(MOUNT, "NFS:   ignoring mount option "
-=09=09=09 "'%s'\n", p);
+=09=09dfprintk(MOUNT, "NFS:   ignoring mount option '%s'\n", p);
 =09=09break;
=20
 =09default:
-=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option "
-=09=09=09 "'%s'\n", p);
+=09=09dfprintk(MOUNT, "NFS:   unrecognized mount option '%s'\n", p);
 =09=09return -EINVAL;
 =09}
=20
@@ -951,15 +937,15 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_=
context *ctx)
 =09 * families in the addr=3D/mountaddr=3D options.
 =09 */
 =09if (ctx->protofamily !=3D AF_UNSPEC &&
-=09    ctx->protofamily !=3D ctx->nfs_server.address.ss_family)
+=09    ctx->protofamily !=3D ctx->nfs_server.address.sa_family)
 =09=09goto out_proto_mismatch;
=20
 =09if (ctx->mountfamily !=3D AF_UNSPEC) {
 =09=09if (ctx->mount_server.addrlen) {
-=09=09=09if (ctx->mountfamily !=3D ctx->mount_server.address.ss_family)
+=09=09=09if (ctx->mountfamily !=3D ctx->mount_server.address.sa_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09} else {
-=09=09=09if (ctx->mountfamily !=3D ctx->nfs_server.address.ss_family)
+=09=09=09if (ctx->mountfamily !=3D ctx->nfs_server.address.sa_family)
 =09=09=09=09goto out_mountproto_mismatch;
 =09=09}
 =09}
@@ -995,9 +981,9 @@ int nfs_parse_mount_options(char *raw, struct nfs_fs_co=
ntext *ctx)
  *
  * Note: caller frees hostname and export path, even on error.
  */
-static int nfs_parse_devname(const char *dev_name,
-=09=09=09     char **hostname, size_t maxnamlen,
-=09=09=09     char **export_path, size_t maxpathlen)
+static int nfs_parse_devname(struct nfs_fs_context *ctx,
+=09=09=09     const char *dev_name,
+=09=09=09     size_t maxnamlen, size_t maxpathlen)
 {
 =09size_t len;
 =09char *end;
@@ -1033,17 +1019,17 @@ static int nfs_parse_devname(const char *dev_name,
 =09=09goto out_hostname;
=20
 =09/* N.B. caller will free nfs_server.hostname in all cases */
-=09*hostname =3D kstrndup(dev_name, len, GFP_KERNEL);
-=09if (*hostname =3D=3D NULL)
+=09ctx->nfs_server.hostname =3D kmemdup_nul(dev_name, len, GFP_KERNEL);
+=09if (!ctx->nfs_server.hostname)
 =09=09goto out_nomem;
 =09len =3D strlen(++end);
 =09if (len > maxpathlen)
 =09=09goto out_path;
-=09*export_path =3D kstrndup(end, len, GFP_KERNEL);
-=09if (!*export_path)
+=09ctx->nfs_server.export_path =3D kmemdup_nul(end, len, GFP_KERNEL);
+=09if (!ctx->nfs_server.export_path)
 =09=09goto out_nomem;
=20
-=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
+=09dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", ctx->nfs_server.export_path);
 =09return 0;
=20
 out_bad_devname:
@@ -1064,7 +1050,7 @@ static int nfs_parse_devname(const char *dev_name,
 }
=20
 /*
- * Validate the NFS2/NFS3 mount data
+ * Parse monolithic NFS2/NFS3 mount data
  * - fills in the mount root filehandle
  *
  * For option strings, user space handles the following behaviors:
@@ -1393,11 +1379,7 @@ int nfs_validate_text_mount_data(void *options,
=20
 =09nfs_set_port(sap, &ctx->nfs_server.port, port);
=20
-=09return nfs_parse_devname(dev_name,
-=09=09=09=09   &ctx->nfs_server.hostname,
-=09=09=09=09   max_namelen,
-=09=09=09=09   &ctx->nfs_server.export_path,
-=09=09=09=09   max_pathlen);
+=09return nfs_parse_devname(ctx, dev_name, max_namelen, max_pathlen);
=20
 #if !IS_ENABLED(CONFIG_NFS_V4)
 out_v4_not_compiled:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7afc9dd009fc..06aae88a8fa1 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -82,11 +82,11 @@ struct nfs_client_initdata {
  * In-kernel mount arguments
  */
 struct nfs_fs_context {
-=09int=09=09=09flags;
+=09unsigned int=09=09flags;=09=09/* NFS{,4}_MOUNT_* flags */
 =09unsigned int=09=09rsize, wsize;
 =09unsigned int=09=09timeo, retrans;
-=09unsigned int=09=09acregmin, acregmax,
-=09=09=09=09acdirmin, acdirmax;
+=09unsigned int=09=09acregmin, acregmax;
+=09unsigned int=09=09acdirmin, acdirmax;
 =09unsigned int=09=09namlen;
 =09unsigned int=09=09options;
 =09unsigned int=09=09bsize;
@@ -102,7 +102,10 @@ struct nfs_fs_context {
 =09bool=09=09=09sloppy;
=20
 =09struct {
-=09=09struct sockaddr_storage=09address;
+=09=09union {
+=09=09=09struct sockaddr=09address;
+=09=09=09struct sockaddr_storage=09_address;
+=09=09};
 =09=09size_t=09=09=09addrlen;
 =09=09char=09=09=09*hostname;
 =09=09u32=09=09=09version;
@@ -111,7 +114,10 @@ struct nfs_fs_context {
 =09} mount_server;
=20
 =09struct {
-=09=09struct sockaddr_storage=09address;
+=09=09union {
+=09=09=09struct sockaddr=09address;
+=09=09=09struct sockaddr_storage=09_address;
+=09=09};
 =09=09size_t=09=09=09addrlen;
 =09=09char=09=09=09*hostname;
 =09=09char=09=09=09*export_path;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3ec46d804bf2..296079b7d439 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -816,7 +816,7 @@ static int nfs_request_mount(struct nfs_fs_context *cfg=
,
 =09/*
 =09 * Construct the mount server's address.
 =09 */
-=09if (cfg->mount_server.address.ss_family =3D=3D AF_UNSPEC) {
+=09if (cfg->mount_server.address.sa_family =3D=3D AF_UNSPEC) {
 =09=09memcpy(request.sap, &cfg->nfs_server.address,
 =09=09       cfg->nfs_server.addrlen);
 =09=09cfg->mount_server.addrlen =3D cfg->nfs_server.addrlen;
--=20
2.17.2

