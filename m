Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE211886E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLJMdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:33:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbfLJMbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQwIZMcGzuOn/JhZAZLftLZA++CzVfTyt+Gg9lZgtHU=;
        b=IhOR3tIo7PmXGZDKFui5vDJq1ybbMEAc9KJb2819NfjP9q8InvfF6c1B0V6RENiMxdnhMe
        Bti/pF0ytJNBrBYBshHqh1s0Xt0TOuT9cKHEYQdP9fMl/PjJD5Gv9EnSTPnbaIIHk3H/mh
        f4KsMu6JJOedvecqMEgyJuDIjvgEzA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-nqbMR5EHPxiJsra6h4E8-g-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD74107ACE3;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CF9E1001925;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id B865820C1B; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 09/27] nfs: don't bother passing nfs_subversion to ->try_mount() and nfs_fs_mount_common()
Date:   Tue, 10 Dec 2019 07:30:57 -0500
Message-Id: <20191210123115.1655-10-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nqbMR5EHPxiJsra6h4E8-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h       |  6 ++----
 fs/nfs/nfs4_fs.h        |  2 +-
 fs/nfs/nfs4super.c      |  5 ++---
 fs/nfs/super.c          | 19 ++++++++-----------
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9888e9c7abe2..4a0ba66bc3aa 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -393,12 +393,10 @@ extern struct file_system_type nfs_xdev_fs_type;
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *,
-=09=09=09struct nfs_subversion *);
+struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_=
mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nf=
s_mount_info *);
-struct dentry *nfs_fs_mount_common(int, const char *,
-=09=09=09=09   struct nfs_mount_info *, struct nfs_subversion *);
+struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_inf=
o *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, =
void *);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 =09=09const char *, struct nfs_mount_info *);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index a7a73b1d1fec..5d539dce9cef 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -526,7 +526,7 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *, =
struct nfs_subversion *);
+struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 6e5417027021..2b34d8e124cd 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -98,7 +98,7 @@ static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 =09=09  const char *dev_name, void *info)
 {
-=09return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
+=09return nfs_fs_mount_common(flags, dev_name, info);
 }
=20
 struct nfs_referral_count {
@@ -216,8 +216,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *=
server, int flags,
 }
=20
 struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-=09=09=09      struct nfs_mount_info *mount_info,
-=09=09=09      struct nfs_subversion *nfs_mod)
+=09=09=09      struct nfs_mount_info *mount_info)
 {
 =09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
 =09struct dentry *res;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6189f768aa59..cb0ead628842 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1893,15 +1893,15 @@ static struct nfs_server *nfs_try_mount_request(str=
uct nfs_mount_info *mount_inf
 }
=20
 struct dentry *nfs_try_mount(int flags, const char *dev_name,
-=09=09=09     struct nfs_mount_info *mount_info,
-=09=09=09     struct nfs_subversion *nfs_mod)
+=09=09=09     struct nfs_mount_info *mount_info)
 {
+=09struct nfs_subversion *nfs_mod =3D mount_info->nfs_mod;
 =09if (mount_info->parsed->need_mount)
 =09=09mount_info->server =3D nfs_try_mount_request(mount_info, nfs_mod);
 =09else
 =09=09mount_info->server =3D nfs_mod->rpc_ops->create_server(mount_info, n=
fs_mod);
=20
-=09return nfs_fs_mount_common(flags, dev_name, mount_info, nfs_mod);
+=09return nfs_fs_mount_common(flags, dev_name, mount_info);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
=20
@@ -2648,8 +2648,7 @@ static void nfs_set_readahead(struct backing_dev_info=
 *bdi,
 }
=20
 struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-=09=09=09=09   struct nfs_mount_info *mount_info,
-=09=09=09=09   struct nfs_subversion *nfs_mod)
+=09=09=09=09   struct nfs_mount_info *mount_info)
 {
 =09struct super_block *s;
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
@@ -2677,7 +2676,8 @@ struct dentry *nfs_fs_mount_common(int flags, const c=
har *dev_name,
 =09=09=09sb_mntdata.mntflags |=3D SB_SYNCHRONOUS;
=20
 =09/* Get a superblock - note that we may end up sharing one that already =
exists */
-=09s =3D sget(nfs_mod->nfs_fs, compare_super, nfs_set_super, flags, &sb_mn=
tdata);
+=09s =3D sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
+=09=09 flags, &sb_mntdata);
 =09if (IS_ERR(s)) {
 =09=09mntroot =3D ERR_CAST(s);
 =09=09goto out_err_nosb;
@@ -2763,7 +2763,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *=
fs_type,
 =09}
 =09mount_info.nfs_mod =3D nfs_mod;
=20
-=09mntroot =3D nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, n=
fs_mod);
+=09mntroot =3D nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
=20
 =09put_nfs_version(nfs_mod);
 out:
@@ -2797,10 +2797,7 @@ static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 =09=09const char *dev_name, void *raw_data)
 {
-=09struct nfs_mount_info *info =3D raw_data;
-=09struct nfs_subversion *nfs_mod =3D NFS_SB(info->cloned->sb)->nfs_client=
->cl_nfs_mod;
-
-=09return nfs_fs_mount_common(flags, dev_name, info, nfs_mod);
+=09return nfs_fs_mount_common(flags, dev_name, raw_data);
 }
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 72d5695c1b47..3ee2ad642cbc 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1655,8 +1655,7 @@ struct nfs_rpc_ops {
 =09=09=09    struct nfs_fsinfo *);
 =09struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
 =09=09=09=09      struct nfs_fh *, struct nfs_fattr *);
-=09struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *=
,
-=09=09=09=09     struct nfs_subversion *);
+=09struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *=
);
 =09int=09(*getattr) (struct nfs_server *, struct nfs_fh *,
 =09=09=09    struct nfs_fattr *, struct nfs4_label *,
 =09=09=09    struct inode *);
--=20
2.17.2

