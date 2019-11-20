Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27539103EAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfKTPaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:30:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729247AbfKTP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVB8ELh1KZA2XF7S7G8Wtj0tMqyYIAWHl9c5khjvsRA=;
        b=YcQbhyW7fMNtvvKNLCu5tkrGsb1iK2Ui2E+Z4R8VbsEg8pxIy+slvEuytpPijxFgYpr/VM
        nqhYBPLEPgkOeTdKrT7tzIcadjGhcYsbQdhhLVORnji9BIJ6edCgAKU0Ub5AV1U7rMjX+i
        UWHor2T56F1dhjZSVIHeVOiFw9slTwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-V2xv9O-XNvq3pziODcnKUw-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC10618B5F74;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74C121054FBF;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 48EDA20991; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/27] nfs: lift setting mount_info from nfs_xdev_mount()
Date:   Wed, 20 Nov 2019 10:27:30 -0500
Message-Id: <20191120152750.6880-8-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: V2xv9O-XNvq3pziODcnKUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Do it in nfs_do_submount() instead.  As a side benefit, nfs_clone_data
doesn't need ->fh and ->fattr anymore.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  3 +--
 fs/nfs/namespace.c | 35 +++++++++++++++++++++--------------
 fs/nfs/super.c     | 25 ++++---------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 89b3afa8b403..8eb79f104a7d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -34,8 +34,6 @@ static inline int nfs_attr_use_mounted_on_fileid(struct n=
fs_fattr *fattr)
 struct nfs_clone_mount {
 =09const struct super_block *sb;
 =09const struct dentry *dentry;
-=09struct nfs_fh *fh;
-=09struct nfs_fattr *fattr;
 =09char *hostname;
 =09char *mnt_path;
 =09struct sockaddr *addr;
@@ -405,6 +403,7 @@ struct dentry * nfs_xdev_mount_common(struct file_syste=
m_type *, int,
 =09=09const char *, struct nfs_mount_info *);
 void nfs_kill_super(struct super_block *);
 void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
+void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
=20
 extern struct rpc_stat nfs_rpcstat;
=20
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9287eb666322..7c78e6956639 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -19,6 +19,7 @@
 #include <linux/vfs.h>
 #include <linux/sunrpc/gss_api.h>
 #include "internal.h"
+#include "nfs.h"
=20
 #define NFSDBG_FACILITY=09=09NFSDBG_VFS
=20
@@ -210,16 +211,6 @@ void nfs_release_automount_timer(void)
 =09=09cancel_delayed_work(&nfs_automount_task);
 }
=20
-/*
- * Clone a mountpoint of the appropriate type
- */
-static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
-=09=09=09=09=09   const char *devname,
-=09=09=09=09=09   struct nfs_clone_mount *mountdata)
-{
-=09return vfs_submount(mountdata->dentry, &nfs_xdev_fs_type, devname, moun=
tdata);
-}
-
 /**
  * nfs_do_submount - set up mountpoint when crossing a filesystem boundary
  * @dentry: parent directory
@@ -231,13 +222,20 @@ static struct vfsmount *nfs_do_clone_mount(struct nfs=
_server *server,
 struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 =09=09=09=09 struct nfs_fattr *fattr, rpc_authflavor_t authflavor)
 {
+=09struct super_block *sb =3D dentry->d_sb;
 =09struct nfs_clone_mount mountdata =3D {
-=09=09.sb =3D dentry->d_sb,
+=09=09.sb =3D sb,
 =09=09.dentry =3D dentry,
-=09=09.fh =3D fh,
-=09=09.fattr =3D fattr,
 =09=09.authflavor =3D authflavor,
 =09};
+=09struct nfs_mount_info mount_info =3D {
+=09=09.fill_super =3D nfs_clone_super,
+=09=09.set_security =3D nfs_clone_sb_security,
+=09=09.cloned =3D &mountdata,
+=09=09.mntfh =3D fh,
+=09};
+=09struct nfs_subversion *nfs_mod =3D NFS_SB(sb)->nfs_client->cl_nfs_mod;
+=09struct nfs_server *server;
 =09struct vfsmount *mnt;
 =09char *page =3D (char *) __get_free_page(GFP_USER);
 =09char *devname;
@@ -245,12 +243,21 @@ struct vfsmount *nfs_do_submount(struct dentry *dentr=
y, struct nfs_fh *fh,
 =09if (page =3D=3D NULL)
 =09=09return ERR_PTR(-ENOMEM);
=20
+=09server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
+=09=09=09=09=09=09fattr, authflavor);
+=09if (IS_ERR(server))
+=09=09return ERR_CAST(server);
+
+=09mount_info.server =3D server;
+
 =09devname =3D nfs_devname(dentry, page, PAGE_SIZE);
 =09if (IS_ERR(devname))
 =09=09mnt =3D ERR_CAST(devname);
 =09else
-=09=09mnt =3D nfs_do_clone_mount(NFS_SB(dentry->d_sb), devname, &mountdata=
);
+=09=09mnt =3D vfs_submount(dentry, &nfs_xdev_fs_type, devname, &mount_info=
);
=20
+=09if (mount_info.server)
+=09=09nfs_free_server(mount_info.server);
 =09free_page((unsigned long)page);
 =09return mnt;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d57fc9983243..32d2ec237c57 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2395,7 +2395,7 @@ EXPORT_SYMBOL_GPL(nfs_fill_super);
 /*
  * Finish setting up a cloned NFS2/3/4 superblock
  */
-static void nfs_clone_super(struct super_block *sb,
+void nfs_clone_super(struct super_block *sb,
 =09=09=09    struct nfs_mount_info *mount_info)
 {
 =09const struct super_block *old_sb =3D mount_info->cloned->sb;
@@ -2796,27 +2796,10 @@ static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 =09=09const char *dev_name, void *raw_data)
 {
-=09struct nfs_clone_mount *data =3D raw_data;
-=09struct nfs_mount_info mount_info =3D {
-=09=09.fill_super =3D nfs_clone_super,
-=09=09.set_security =3D nfs_clone_sb_security,
-=09=09.cloned =3D data,
-=09};
-=09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
-=09struct nfs_subversion *nfs_mod =3D NFS_SB(data->sb)->nfs_client->cl_nfs=
_mod;
-
-=09dprintk("--> nfs_xdev_mount()\n");
+=09struct nfs_mount_info *info =3D raw_data;
+=09struct nfs_subversion *nfs_mod =3D NFS_SB(info->cloned->sb)->nfs_client=
->cl_nfs_mod;
=20
-=09mount_info.mntfh =3D mount_info.cloned->fh;
-
-=09/* create a new volume representation */
-=09mount_info.server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), =
data->fh, data->fattr, data->authflavor);
-
-=09mntroot =3D nfs_fs_mount_common(flags, dev_name, &mount_info, nfs_mod);
-
-=09dprintk("<-- nfs_xdev_mount() =3D %ld\n",
-=09=09=09IS_ERR(mntroot) ? PTR_ERR(mntroot) : 0L);
-=09return mntroot;
+=09return nfs_fs_mount_common(flags, dev_name, info, nfs_mod);
 }
=20
 #if IS_ENABLED(CONFIG_NFS_V4)
--=20
2.17.2

