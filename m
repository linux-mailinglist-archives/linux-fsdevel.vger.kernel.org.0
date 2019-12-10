Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E242118859
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLJMc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:32:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727436AbfLJMbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D25Ozj0ALmNADVKeQRJ1+nc3ACJQ8kWT2CuWkURI0eU=;
        b=FshWJ8piQWfdeTX7IxbiIkAJ6/eHZIV4LZswSnY53R/y7cCEi8RrSjIzZ3uhgsS38RcWve
        OtUiw+V284OZZlUIILkYa1rCRAp4F0+m0sanF8o7SeD7uWRGXoD+02jd3LMOfHRnc3oU1C
        8eLH9Y3f64cXl32tX5RWjL1mR4JzN8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Ogqxv0upOeub1VAJt1w6oA-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0810D189DF40;
        Tue, 10 Dec 2019 12:31:18 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC4A35DA2C;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 1F15820C5A; Tue, 10 Dec 2019 07:31:16 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 27/27] NFS: Attach supplementary error information to fs_context.
Date:   Tue, 10 Dec 2019 07:31:15 -0500
Message-Id: <20191210123115.1655-28-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ogqxv0upOeub1VAJt1w6oA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out from commit "NFS: Add fs_context support."

Add wrappers nfs_errorf(), nfs_invalf(), and nfs_warnf() which log error
information to the fs_context.  Convert some printk's to use these new
wrappers instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 105 +++++++++++++++-----------------------------
 fs/nfs/getroot.c    |   3 ++
 fs/nfs/internal.h   |   4 ++
 fs/nfs/namespace.c  |   2 +-
 fs/nfs/nfs4super.c  |   2 +
 fs/nfs/super.c      |   4 +-
 6 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e472334b978d..429315c011ae 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -318,10 +318,8 @@ static int nfs_auth_info_add(struct fs_context *fc,
 =09=09=09return 0;
 =09}
=20
-=09if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
-=09=09dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
-=09=09return -EINVAL;
-=09}
+=09if (auth_info->flavor_len + 1 >=3D max_flavor_len)
+=09=09return nfs_invalf(fc, "NFS: too many sec=3D flavors");
=20
 =09auth_info->flavors[auth_info->flavor_len++] =3D flavor;
 =09return 0;
@@ -378,9 +376,7 @@ static int nfs_parse_security_flavors(struct fs_context=
 *fc,
 =09=09=09pseudoflavor =3D RPC_AUTH_GSS_SPKMP;
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT,
-=09=09=09=09 "NFS: sec=3D option '%s' not recognized\n", p);
-=09=09=09return -EINVAL;
+=09=09=09return nfs_invalf(fc, "NFS: sec=3D%s option not recognized", p);
 =09=09}
=20
 =09=09ret =3D nfs_auth_info_add(fc, &ctx->auth_info, pseudoflavor);
@@ -425,8 +421,7 @@ static int nfs_parse_version_string(struct fs_context *=
fc,
 =09=09ctx->minorversion =3D 2;
 =09=09break;
 =09default:
-=09=09dfprintk(MOUNT, "NFS:   Unsupported NFS version\n");
-=09=09return -EINVAL;
+=09=09return nfs_invalf(fc, "NFS: Unsupported NFS version");
 =09}
 =09return 0;
 }
@@ -451,10 +446,8 @@ static int nfs_fs_context_parse_param(struct fs_contex=
t *fc,
=20
 =09switch (opt) {
 =09case Opt_source:
-=09=09if (fc->source) {
-=09=09=09dfprintk(MOUNT, "NFS: Multiple sources not supported\n");
-=09=09=09return -EINVAL;
-=09=09}
+=09=09if (fc->source)
+=09=09=09return nfs_invalf(fc, "NFS: Multiple sources not supported");
 =09=09fc->source =3D param->string;
 =09=09param->string =3D NULL;
 =09=09break;
@@ -664,8 +657,7 @@ static int nfs_fs_context_parse_param(struct fs_context=
 *fc,
 =09=09=09xprt_load_transport(param->string);
 =09=09=09break;
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-=09=09=09return -EINVAL;
+=09=09=09return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 =09=09}
=20
 =09=09ctx->protofamily =3D protofamily;
@@ -688,8 +680,7 @@ static int nfs_fs_context_parse_param(struct fs_context=
 *fc,
 =09=09=09break;
 =09=09case Opt_xprt_rdma: /* not used for side protocols */
 =09=09default:
-=09=09=09dfprintk(MOUNT, "NFS:   unrecognized transport protocol\n");
-=09=09=09return -EINVAL;
+=09=09=09return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
 =09=09}
 =09=09ctx->mountfamily =3D mountfamily;
 =09=09break;
@@ -774,13 +765,11 @@ static int nfs_fs_context_parse_param(struct fs_conte=
xt *fc,
 =09return 0;
=20
 out_invalid_value:
-=09printk(KERN_INFO "NFS: Bad mount option value specified\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Bad mount option value specified");
 out_invalid_address:
-=09printk(KERN_INFO "NFS: Bad IP address specified\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Bad IP address specified");
 out_of_bounds:
-=09printk(KERN_INFO "NFS: Value for '%s' out of range\n", param->key);
+=09nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
 =09return -ERANGE;
 }
=20
@@ -846,19 +835,15 @@ static int nfs_parse_source(struct fs_context *fc,
 =09return 0;
=20
 out_bad_devname:
-=09dfprintk(MOUNT, "NFS: device name not in host:path format\n");
-=09return -EINVAL;
-
+=09return nfs_invalf(fc, "NFS: device name not in host:path format");
 out_nomem:
-=09dfprintk(MOUNT, "NFS: not enough memory to parse device name\n");
+=09nfs_errorf(fc, "NFS: not enough memory to parse device name");
 =09return -ENOMEM;
-
 out_hostname:
-=09dfprintk(MOUNT, "NFS: server hostname too long\n");
+=09nfs_errorf(fc, "NFS: server hostname too long");
 =09return -ENAMETOOLONG;
-
 out_path:
-=09dfprintk(MOUNT, "NFS: export pathname too long\n");
+=09nfs_errorf(fc, "NFS: export pathname too long");
 =09return -ENAMETOOLONG;
 }
=20
@@ -1015,29 +1000,23 @@ static int nfs23_parse_monolithic(struct fs_context=
 *fc,
 =09=09ctx->skip_reconfig_option_check =3D true;
 =09=09return 0;
 =09}
-=09dfprintk(MOUNT, "NFS: mount program didn't pass any mount data\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: mount program didn't pass any mount data");
=20
 out_no_v3:
-=09dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support v3\n",
-=09=09 data->version);
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: nfs_mount_data version does not support v3"=
);
=20
 out_no_sec:
-=09dfprintk(MOUNT, "NFS: nfs_mount_data version supports only AUTH_SYS\n")=
;
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: nfs_mount_data version supports only AUTH_S=
YS");
=20
 out_nomem:
-=09dfprintk(MOUNT, "NFS: not enough memory to handle mount options\n");
+=09dfprintk(MOUNT, "NFS: not enough memory to handle mount options");
 =09return -ENOMEM;
=20
 out_no_address:
-=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
=20
 out_invalid_fh:
-=09dfprintk(MOUNT, "NFS: invalid root filehandle\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: invalid root filehandle");
 }
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
@@ -1132,21 +1111,17 @@ static int nfs4_parse_monolithic(struct fs_context =
*fc,
 =09=09ctx->skip_reconfig_option_check =3D true;
 =09=09return 0;
 =09}
-=09dfprintk(MOUNT, "NFS4: mount program didn't pass any mount data\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS4: mount program didn't pass any mount data")=
;
=20
 out_inval_auth:
-=09dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours %d\n",
-=09=09 data->auth_flavourlen);
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS4: Invalid number of RPC auth flavours %d",
+=09=09      data->auth_flavourlen);
=20
 out_no_address:
-=09dfprintk(MOUNT, "NFS4: mount program didn't pass remote address\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS4: mount program didn't pass remote address")=
;
=20
 out_invalid_transport_udp:
-=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 }
 #endif
=20
@@ -1164,8 +1139,7 @@ static int nfs_fs_context_parse_monolithic(struct fs_=
context *fc,
 =09=09return nfs4_parse_monolithic(fc, data);
 #endif
=20
-=09dfprintk(MOUNT, "NFS: Unsupported monolithic data version\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Unsupported monolithic data version");
 }
=20
 /*
@@ -1253,32 +1227,25 @@ static int nfs_fs_context_validate(struct fs_contex=
t *fc)
 =09return 0;
=20
 out_no_device_name:
-=09dfprintk(MOUNT, "NFS: Device name not specified\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Device name not specified");
 out_v4_not_compiled:
-=09dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
+=09nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
 =09return -EPROTONOSUPPORT;
 out_invalid_transport_udp:
-=09dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFSv4: Unsupported transport protocol udp");
 out_no_address:
-=09dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
 out_mountproto_mismatch:
-=09dfprintk(MOUNT, "NFS: Mount server address does not match mountproto=3D=
 option\n");
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Mount server address does not match mountpr=
oto=3D option");
 out_proto_mismatch:
-=09dfprintk(MOUNT, "NFS: Server address does not match proto=3D option\n")=
;
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: Server address does not match proto=3D opti=
on");
 out_minorversion_mismatch:
-=09dfprintk(MOUNT, "NFS: Mount option vers=3D%u does not support minorvers=
ion=3D%u\n",
+=09return nfs_invalf(fc, "NFS: Mount option vers=3D%u does not support min=
orversion=3D%u",
 =09=09=09  ctx->version, ctx->minorversion);
-=09return -EINVAL;
 out_migration_misuse:
-=09dfprintk(MOUNT, "NFS: 'Migration' not supported for this NFS version\n"=
);
-=09return -EINVAL;
+=09return nfs_invalf(fc, "NFS: 'Migration' not supported for this NFS vers=
ion");
 out_version_unavailable:
-=09dfprintk(MOUNT, "NFS: Version unavailable\n");
+=09nfs_errorf(fc, "NFS: Version unavailable");
 =09return ret;
 }
=20
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index ab45496d23a6..b012c2668a1f 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -86,6 +86,7 @@ int nfs_get_root(struct super_block *s, struct fs_context=
 *fc)
 =09error =3D server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsi=
nfo);
 =09if (error < 0) {
 =09=09dprintk("nfs_get_root: getattr error =3D %d\n", -error);
+=09=09nfs_errorf(fc, "NFS: Couldn't getattr on root");
 =09=09goto out_fattr;
 =09}
=20
@@ -93,6 +94,7 @@ int nfs_get_root(struct super_block *s, struct fs_context=
 *fc)
 =09if (IS_ERR(inode)) {
 =09=09dprintk("nfs_get_root: get root inode failed\n");
 =09=09error =3D PTR_ERR(inode);
+=09=09nfs_errorf(fc, "NFS: Couldn't get root inode");
 =09=09goto out_fattr;
 =09}
=20
@@ -108,6 +110,7 @@ int nfs_get_root(struct super_block *s, struct fs_conte=
xt *fc)
 =09if (IS_ERR(root)) {
 =09=09dprintk("nfs_get_root: get root dentry failed\n");
 =09=09error =3D PTR_ERR(root);
+=09=09nfs_errorf(fc, "NFS: Couldn't get root dentry");
 =09=09goto out_fattr;
 =09}
=20
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a1fd4c3ebc4e..c0257411e158 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -133,6 +133,10 @@ struct nfs_fs_context {
 =09} clone_data;
 };
=20
+#define nfs_errorf(fc, fmt, ...) errorf(fc, fmt, ## __VA_ARGS__)
+#define nfs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
+#define nfs_warnf(fc, fmt, ...) warnf(fc, fmt, ## __VA_ARGS__)
+
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_contex=
t *fc)
 {
 =09return fc->fs_private;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index d537350c1fb7..4fd22c0d730c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -281,7 +281,7 @@ int nfs_do_submount(struct fs_context *fc)
=20
 =09p =3D nfs_devname(dentry, buffer, 4096);
 =09if (IS_ERR(p)) {
-=09=09dprintk("NFS: Couldn't determine submount pathname\n");
+=09=09nfs_errorf(fc, "NFS: Couldn't determine submount pathname");
 =09=09ret =3D PTR_ERR(p);
 =09} else {
 =09=09ret =3D vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 7d5ed37633d8..1475f932d7da 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -225,6 +225,7 @@ int nfs4_try_get_tree(struct fs_context *fc)
 =09=09=09   fc, ctx->nfs_server.hostname,
 =09=09=09   ctx->nfs_server.export_path);
 =09if (err) {
+=09=09nfs_errorf(fc, "NFS4: Couldn't follow remote path");
 =09=09dfprintk(MOUNT, "<-- nfs4_try_get_tree() =3D %d [error]\n", err);
 =09} else {
 =09=09dfprintk(MOUNT, "<-- nfs4_try_get_tree() =3D 0\n");
@@ -247,6 +248,7 @@ int nfs4_get_referral_tree(struct fs_context *fc)
 =09=09=09    fc, ctx->nfs_server.hostname,
 =09=09=09    ctx->nfs_server.export_path);
 =09if (err) {
+=09=09nfs_errorf(fc, "NFS4: Couldn't follow remote path");
 =09=09dfprintk(MOUNT, "<-- nfs4_get_referral_tree() =3D %d [error]\n", err=
);
 =09} else {
 =09=09dfprintk(MOUNT, "<-- nfs4_get_referral_tree() =3D 0\n");
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ed0290d5ebf3..76e0198adcfa 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1205,7 +1205,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 =09fc->s_fs_info =3D NULL;
 =09if (IS_ERR(s)) {
 =09=09error =3D PTR_ERR(s);
-=09=09dfprintk(MOUNT, "NFS: Couldn't get superblock\n");
+=09=09nfs_errorf(fc, "NFS: Couldn't get superblock");
 =09=09goto out_err_nosb;
 =09}
=20
@@ -1234,7 +1234,7 @@ int nfs_get_tree_common(struct fs_context *fc)
=20
 =09error =3D nfs_get_root(s, fc);
 =09if (error < 0) {
-=09=09dfprintk(MOUNT, "NFS: Couldn't get root dentry\n");
+=09=09nfs_errorf(fc, "NFS: Couldn't get root dentry");
 =09=09goto error_splat_super;
 =09}
=20
--=20
2.17.2

