Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E856E103E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfKTP2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:28:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbfKTP2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHfecXiFV5kzHykh4k4Bvw5VyDSbWTh0WvvKEZ1nkuY=;
        b=MGcoJ4z4znzKEsoSmUipo3s5ROOJvcc/vliKOQ1qyV3Hl8kTGW1eWUYMswL67a1PDDbSok
        WRlONUAkXB4TWCNf1FEHJtrMz/ZkWa7XBMCiTtp01Ehv/3oYbgRAxwSEkgWlPF1E9EiQcJ
        +HqTmwa0Qytb08fsGRJxDP0uxLRJtR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-jhiEDPV9PWu0kmSOFRh2mw-1; Wed, 20 Nov 2019 10:27:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C50800A02;
        Wed, 20 Nov 2019 15:27:56 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 627732AA8A;
        Wed, 20 Nov 2019 15:27:56 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 57B15209A1; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/27] nfs: merge xdev and remote file_system_type
Date:   Wed, 20 Nov 2019 10:27:33 -0500
Message-Id: <20191120152750.6880-11-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jhiEDPV9PWu0kmSOFRh2mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

they are identical now...

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  2 +-
 fs/nfs/namespace.c |  2 +-
 fs/nfs/nfs4super.c | 22 +---------------------
 fs/nfs/super.c     | 14 ++++++++------
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6a8296b4ccbe..8f64f2fcc430 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -388,7 +388,7 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsign=
ed int mode);
 /* super.c */
 extern const struct super_operations nfs_sops;
 extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_xdev_fs_type;
+extern struct file_system_type nfs_prepared_fs_type;
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 0d0587ed7d94..970f92a860ed 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -254,7 +254,7 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
 struct nfs_fh *fh,
 =09if (IS_ERR(devname))
 =09=09mnt =3D ERR_CAST(devname);
 =09else
-=09=09mnt =3D vfs_submount(dentry, &nfs_xdev_fs_type, devname, &mount_info=
);
+=09=09mnt =3D vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_=
info);
=20
 =09if (mount_info.server)
 =09=09nfs_free_server(mount_info.server);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 83bca2ea566c..5bca30f704e4 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -18,19 +18,9 @@
=20
 static int nfs4_write_inode(struct inode *inode, struct writeback_control =
*wbc);
 static void nfs4_evict_inode(struct inode *inode);
-static struct dentry *nfs4_remote_mount(struct file_system_type *fs_type,
-=09int flags, const char *dev_name, void *raw_data);
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type=
,
 =09int flags, const char *dev_name, void *raw_data);
=20
-static struct file_system_type nfs4_remote_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs4",
-=09.mount=09=09=3D nfs4_remote_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-
 struct file_system_type nfs4_referral_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "nfs4",
@@ -91,16 +81,6 @@ static void nfs4_evict_inode(struct inode *inode)
 =09nfs_clear_inode(inode);
 }
=20
-/*
- * Get the superblock for the NFS4 root partition
- */
-static struct dentry *
-nfs4_remote_mount(struct file_system_type *fs_type, int flags,
-=09=09  const char *dev_name, void *info)
-{
-=09return nfs_fs_mount_common(flags, dev_name, info);
-}
-
 struct nfs_referral_count {
 =09struct list_head list;
 =09const struct task_struct *task;
@@ -194,7 +174,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *=
server, int flags,
 =09else
 =09=09snprintf(root_devname, len, "%s:/", hostname);
 =09info->server =3D server;
-=09root_mnt =3D vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, =
info);
+=09root_mnt =3D vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname,=
 info);
 =09if (info->server)
 =09=09nfs_free_server(info->server);
 =09info->server =3D NULL;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 5a21498da02e..6a27bd501f3f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -293,7 +293,7 @@ static match_table_t nfs_vers_tokens =3D {
 =09{ Opt_vers_err, NULL }
 };
=20
-static struct dentry *nfs_xdev_mount(struct file_system_type *fs_type,
+static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
 =09=09int flags, const char *dev_name, void *raw_data);
=20
 struct file_system_type nfs_fs_type =3D {
@@ -306,13 +306,14 @@ struct file_system_type nfs_fs_type =3D {
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
=20
-struct file_system_type nfs_xdev_fs_type =3D {
+struct file_system_type nfs_prepared_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "nfs",
-=09.mount=09=09=3D nfs_xdev_mount,
+=09.mount=09=09=3D nfs_prepared_mount,
 =09.kill_sb=09=3D nfs_kill_super,
 =09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
+EXPORT_SYMBOL_GPL(nfs_prepared_fs_type);
=20
 const struct super_operations nfs_sops =3D {
 =09.alloc_inode=09=3D nfs_alloc_inode,
@@ -2791,11 +2792,12 @@ void nfs_kill_super(struct super_block *s)
 EXPORT_SYMBOL_GPL(nfs_kill_super);
=20
 /*
- * Clone an NFS2/3/4 server record on xdev traversal (FSID-change)
+ * Internal use only: mount_info is already set up by caller.
+ * Used for mountpoint crossings and for nfs4 root.
  */
 static struct dentry *
-nfs_xdev_mount(struct file_system_type *fs_type, int flags,
-=09=09const char *dev_name, void *raw_data)
+nfs_prepared_mount(struct file_system_type *fs_type, int flags,
+=09=09   const char *dev_name, void *raw_data)
 {
 =09return nfs_fs_mount_common(flags, dev_name, raw_data);
 }
--=20
2.17.2

