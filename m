Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09F103E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfKTP3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:29:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730143AbfKTP17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NKDORaFJZOjunwHZj4mQllnEEEUqsIoDoi7fpfjCQI=;
        b=gXJMnz7Q1IGmeb4eh2LCeMyG5IQWY/y2USUFv8aDDlGPssQ8PPZLScO40IxnqB8rkCffTS
        moqY2Ro7xEVuaH95NA9Ueba7cfKs20LluM1M0HokDq5uy0G/HPQ35/iGyUkgIRflX19qIX
        3CZsMrd7fgIo+d3U/zc0Tu8Ml0UcfGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-LtquWJKXNSWILl9NRPBgEg-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F5F5801E6A;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAD6B60BAD;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 616D5209A8; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/27] nfs: don't pass nfs_subversion to ->create_server()
Date:   Wed, 20 Nov 2019 10:27:35 -0500
Message-Id: <20191120152750.6880-13-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LtquWJKXNSWILl9NRPBgEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

pick it from mount_info

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/client.c         |  4 ++--
 fs/nfs/internal.h       |  7 ++-----
 fs/nfs/nfs3_fs.h        |  2 +-
 fs/nfs/nfs3client.c     |  5 ++---
 fs/nfs/nfs4client.c     |  3 +--
 fs/nfs/nfs4super.c      |  2 +-
 fs/nfs/super.c          | 14 +++++++-------
 include/linux/nfs_xdr.h |  2 +-
 8 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 30838304a0bf..130c065141b3 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -940,10 +940,10 @@ EXPORT_SYMBOL_GPL(nfs_free_server);
  * Create a version 2 or 3 volume record
  * - keyed on server and FSID
  */
-struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info,
-=09=09=09=09     struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs_create_server(struct nfs_mount_info *mount_info)
 {
 =09struct nfs_server *server;
+=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
 =09struct nfs_fattr *fattr;
 =09int error;
=20
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index dc896602d588..e4f8a4734a2e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -170,11 +170,8 @@ extern struct nfs_client *nfs4_find_client_ident(struc=
t net *, int);
 extern struct nfs_client *
 nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 =09=09=09=09struct nfs4_sessionid *, u32);
-extern struct nfs_server *nfs_create_server(struct nfs_mount_info *,
-=09=09=09=09=09struct nfs_subversion *);
-extern struct nfs_server *nfs4_create_server(
-=09=09=09=09=09struct nfs_mount_info *,
-=09=09=09=09=09struct nfs_subversion *);
+extern struct nfs_server *nfs_create_server(struct nfs_mount_info *);
+extern struct nfs_server *nfs4_create_server(struct nfs_mount_info *);
 extern struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mou=
nt *,
 =09=09=09=09=09=09      struct nfs_fh *);
 extern int nfs4_update_server(struct nfs_server *server, const char *hostn=
ame,
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index f82e11c4cb56..09602dc1889f 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -27,7 +27,7 @@ static inline int nfs3_proc_setacls(struct inode *inode, =
struct posix_acl *acl,
 #endif /* CONFIG_NFS_V3_ACL */
=20
 /* nfs3client.c */
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *, struct nfs_=
subversion *);
+struct nfs_server *nfs3_create_server(struct nfs_mount_info *);
 struct nfs_server *nfs3_clone_server(struct nfs_server *, struct nfs_fh *,
 =09=09=09=09     struct nfs_fattr *, rpc_authflavor_t);
=20
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 148ceb74d27c..a340b5d0e1a3 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -46,10 +46,9 @@ static inline void nfs_init_server_aclclient(struct nfs_=
server *server)
 }
 #endif
=20
-struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info,
-=09=09=09=09      struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs3_create_server(struct nfs_mount_info *mount_info)
 {
-=09struct nfs_server *server =3D nfs_create_server(mount_info, nfs_mod);
+=09struct nfs_server *server =3D nfs_create_server(mount_info);
 =09/* Create a client RPC handle for the NFS v3 ACL management interface *=
/
 =09if (!IS_ERR(server))
 =09=09nfs_init_server_aclclient(server);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index da6204025a2d..16fba83b5c4b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1109,8 +1109,7 @@ static int nfs4_init_server(struct nfs_server *server=
,
  */
 /*struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data=
 *data,
 =09=09=09=09      struct nfs_fh *mntfh)*/
-struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info,
-=09=09=09=09      struct nfs_subversion *nfs_mod)
+struct nfs_server *nfs4_create_server(struct nfs_mount_info *mount_info)
 {
 =09struct nfs_server *server;
 =09bool auth_probe;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 5bca30f704e4..b6cf62125380 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -205,7 +205,7 @@ struct dentry *nfs4_try_mount(int flags, const char *de=
v_name,
=20
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
-=09res =3D do_nfs4_mount(nfs4_create_server(mount_info, &nfs_v4),
+=09res =3D do_nfs4_mount(nfs4_create_server(mount_info),
 =09=09=09    flags, mount_info,
 =09=09=09    data->nfs_server.hostname,
 =09=09=09    data->nfs_server.export_path);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 1587c505cc23..691cd93c8a2f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1820,8 +1820,7 @@ static int nfs_request_mount(struct nfs_parsed_mount_=
data *args,
 =09return 0;
 }
=20
-static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mou=
nt_info,
-=09=09=09=09=09struct nfs_subversion *nfs_mod)
+static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mou=
nt_info)
 {
 =09int status;
 =09unsigned int i;
@@ -1831,6 +1830,7 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09struct nfs_parsed_mount_data *args =3D mount_info->parsed;
 =09rpc_authflavor_t authlist[NFS_MAX_SECFLAVORS];
 =09unsigned int authlist_len =3D ARRAY_SIZE(authlist);
+=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
=20
 =09status =3D nfs_request_mount(args, mount_info->mntfh, authlist,
 =09=09=09=09=09&authlist_len);
@@ -1847,7 +1847,7 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09=09=09 args->selected_flavor);
 =09=09if (status)
 =09=09=09return ERR_PTR(status);
-=09=09return nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+=09=09return nfs_mod->rpc_ops->create_server(mount_info);
 =09}
=20
 =09/*
@@ -1874,7 +1874,7 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09=09}
 =09=09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 =09=09args->selected_flavor =3D flavor;
-=09=09server =3D nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+=09=09server =3D nfs_mod->rpc_ops->create_server(mount_info);
 =09=09if (!IS_ERR(server))
 =09=09=09return server;
 =09}
@@ -1890,7 +1890,7 @@ static struct nfs_server *nfs_try_mount_request(struc=
t nfs_mount_info *mount_inf
 =09/* Last chance! Try AUTH_UNIX */
 =09dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNI=
X);
 =09args->selected_flavor =3D RPC_AUTH_UNIX;
-=09return nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+=09return nfs_mod->rpc_ops->create_server(mount_info);
 }
=20
 static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mo=
unt_info *);
@@ -1900,9 +1900,9 @@ struct dentry *nfs_try_mount(int flags, const char *d=
ev_name,
 {
 =09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
 =09if (mount_info->parsed->need_mount)
-=09=09mount_info->server =3D nfs_try_mount_request(mount_info, nfs_mod);
+=09=09mount_info->server =3D nfs_try_mount_request(mount_info);
 =09else
-=09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info, n=
fs_mod);
+=09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info);
=20
 =09return nfs_fs_mount_common(flags, dev_name, mount_info);
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 4fdf4a523185..82bdb91da2ae 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1705,7 +1705,7 @@ struct nfs_rpc_ops {
 =09struct nfs_client *(*init_client) (struct nfs_client *,
 =09=09=09=09const struct nfs_client_initdata *);
 =09void=09(*free_client) (struct nfs_client *);
-=09struct nfs_server *(*create_server)(struct nfs_mount_info *, struct nfs=
_subversion *);
+=09struct nfs_server *(*create_server)(struct nfs_mount_info *);
 =09struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *=
,
 =09=09=09=09=09   struct nfs_fattr *, rpc_authflavor_t);
 };
--=20
2.17.2

