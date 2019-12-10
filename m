Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE411883F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfLJMcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:32:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727550AbfLJMbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvgsBcRC4TVa6w24xm3w8RBJ94V6lOTy3XS+1K6EYBM=;
        b=gBfSEJHvE1P6VCUSSycMFpqlm2PYWkUX/NHQSHo0G3kJcS3J0aNo2wsvM5zKWDMwkuV+NZ
        EUCDmlYOiAXmkMZgsf6AvSwt2l00BdhXESjN8MN7jh2pA9mIGCydRat0RsifHWtsW6G6JK
        BEdaSFw/G1bFrTM6YDLk4NDU7foUc94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-0FHKC64VOV-ZpOKqjnlYaw-1; Tue, 10 Dec 2019 07:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90766800D5C;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5779760BE1;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id D5B2020C2A; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 15/27] nfs: get rid of ->set_security()
Date:   Tue, 10 Dec 2019 07:31:03 -0500
Message-Id: <20191210123115.1655-16-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0FHKC64VOV-ZpOKqjnlYaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's always either nfs_set_sb_security() or nfs_clone_sb_security(),
the choice being controlled by mount_info->cloned !=3D NULL.  No need
to add methods, especially when both instances live right next to
the caller and are never accessed anywhere else.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  3 --
 fs/nfs/namespace.c |  1 -
 fs/nfs/nfs4super.c |  3 --
 fs/nfs/super.c     | 69 ++++++++++++++--------------------------------
 4 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 65c8e353cb6b..a467e43fc682 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -137,7 +137,6 @@ struct nfs_mount_request {
=20
 struct nfs_mount_info {
 =09unsigned int inherited_bsize;
-=09int (*set_security)(struct super_block *, struct dentry *, struct nfs_m=
ount_info *);
 =09struct nfs_parsed_mount_data *parsed;
 =09struct nfs_clone_mount *cloned;
 =09struct nfs_server *server;
@@ -391,8 +390,6 @@ extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_=
mount_info *);
-int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nf=
s_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, =
void *);
 void nfs_kill_super(struct super_block *);
=20
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 30331558bd8e..bfe607374feb 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -233,7 +233,6 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
 struct nfs_fh *fh,
 =09};
 =09struct nfs_mount_info mount_info =3D {
 =09=09.inherited_bsize =3D sb->s_blocksize_bits,
-=09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D &mountdata,
 =09=09.mntfh =3D fh,
 =09=09.nfs_mod =3D NFS_SB(sb)->nfs_client->cl_nfs_mod,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 5020a43b31c9..f1c2d294073a 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -201,8 +201,6 @@ struct dentry *nfs4_try_mount(int flags, const char *de=
v_name,
 =09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
 =09struct dentry *res;
=20
-=09mount_info->set_security =3D nfs_set_sb_security;
-
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
 =09res =3D do_nfs4_mount(nfs4_create_server(mount_info),
@@ -224,7 +222,6 @@ static struct dentry *nfs4_referral_mount(struct file_s=
ystem_type *fs_type,
 {
 =09struct nfs_clone_mount *data =3D raw_data;
 =09struct nfs_mount_info mount_info =3D {
-=09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D data,
 =09=09.nfs_mod =3D &nfs_v4,
 =09};
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index bec6c341f72c..de00f89dbe6e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2550,52 +2550,6 @@ static void nfs_get_cache_cookie(struct super_block =
*sb,
 }
 #endif
=20
-int nfs_set_sb_security(struct super_block *s, struct dentry *mntroot,
-=09=09=09struct nfs_mount_info *mount_info)
-{
-=09int error;
-=09unsigned long kflags =3D 0, kflags_out =3D 0;
-=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
-=09=09kflags |=3D SECURITY_LSM_NATIVE_LABELS;
-
-=09error =3D security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
-=09=09=09=09=09=09kflags, &kflags_out);
-=09if (error)
-=09=09goto err;
-
-=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
-=09=09!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-=09=09NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
-err:
-=09return error;
-}
-EXPORT_SYMBOL_GPL(nfs_set_sb_security);
-
-int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
-=09=09=09  struct nfs_mount_info *mount_info)
-{
-=09int error;
-=09unsigned long kflags =3D 0, kflags_out =3D 0;
-
-=09/* clone any lsm security options from the parent to the new sb */
-=09if (d_inode(mntroot)->i_fop !=3D &nfs_dir_operations)
-=09=09return -ESTALE;
-
-=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
-=09=09kflags |=3D SECURITY_LSM_NATIVE_LABELS;
-
-=09error =3D security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
-=09=09=09&kflags_out);
-=09if (error)
-=09=09return error;
-
-=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
-=09=09!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-=09=09NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
-=09return 0;
-}
-EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
-
 static void nfs_set_readahead(struct backing_dev_info *bdi,
 =09=09=09      unsigned long iomax_pages)
 {
@@ -2610,6 +2564,7 @@ static struct dentry *nfs_fs_mount_common(int flags, =
const char *dev_name,
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
 =09int (*compare_super)(struct super_block *, void *) =3D nfs_compare_supe=
r;
 =09struct nfs_server *server =3D mount_info->server;
+=09unsigned long kflags =3D 0, kflags_out =3D 0;
 =09struct nfs_sb_mountdata sb_mntdata =3D {
 =09=09.mntflags =3D flags,
 =09=09.server =3D server,
@@ -2670,7 +2625,26 @@ static struct dentry *nfs_fs_mount_common(int flags,=
 const char *dev_name,
 =09if (IS_ERR(mntroot))
 =09=09goto error_splat_super;
=20
-=09error =3D mount_info->set_security(s, mntroot, mount_info);
+
+=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
+=09=09kflags |=3D SECURITY_LSM_NATIVE_LABELS;
+=09if (mount_info->cloned) {
+=09=09if (d_inode(mntroot)->i_fop !=3D &nfs_dir_operations) {
+=09=09=09error =3D -ESTALE;
+=09=09=09goto error_splat_root;
+=09=09}
+=09=09/* clone any lsm security options from the parent to the new sb */
+=09=09error =3D security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kfla=
gs,
+=09=09=09=09&kflags_out);
+=09} else {
+=09=09error =3D security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
+=09=09=09=09=09=09=09kflags, &kflags_out);
+=09}
+=09if (error)
+=09=09goto error_splat_root;
+=09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
+=09=09!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
+=09=09NFS_SB(s)->caps &=3D ~NFS_CAP_SECURITY_LABEL;
 =09if (error)
 =09=09goto error_splat_root;
=20
@@ -2695,7 +2669,6 @@ struct dentry *nfs_fs_mount(struct file_system_type *=
fs_type,
 =09int flags, const char *dev_name, void *raw_data)
 {
 =09struct nfs_mount_info mount_info =3D {
-=09=09.set_security =3D nfs_set_sb_security,
 =09};
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
 =09struct nfs_subversion *nfs_mod;
--=20
2.17.2

