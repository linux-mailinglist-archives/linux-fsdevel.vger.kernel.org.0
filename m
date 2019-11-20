Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7358F103EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfKTPaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:30:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37444 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729468AbfKTP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAJgKPgEmBoP7WXUdRUa3y6uYgp7qiGb+CIHRCyRLT8=;
        b=dO9DPCCIdzaU6zCV2cInxxYv6u3FitY3lDWhfOQ3josTg50H4GehBmO+knSrpEaqEzeqeT
        Vi/ReQi8VrlaKbKWLd5C0+vhDoxZaFlOP+cL5cMGYfhgOpLzDV6i8SgdJVFScswSG9kmIk
        h9TiXFy6ng7jegy4Cq82IqdJvhVuonQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-4BvWXGJyNGORtRy0o3WvvQ-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C4DB18B5F76;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6643160499;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 431F52095D; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/27] nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
Date:   Wed, 20 Nov 2019 10:27:29 -0500
Message-Id: <20191120152750.6880-7-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4BvWXGJyNGORtRy0o3WvvQ-1
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
 fs/nfs/nfs4super.c | 88 +++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index a0b66f98f6ba..91ba1b6741dc 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -101,37 +101,6 @@ nfs4_remote_mount(struct file_system_type *fs_type, in=
t flags,
 =09return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
=20
-static struct vfsmount *nfs_do_root_mount(struct nfs_server *server, int f=
lags,
-=09=09=09=09=09  struct nfs_mount_info *info,
-=09=09=09=09=09  const char *hostname)
-{
-=09struct vfsmount *root_mnt;
-=09char *root_devname;
-=09size_t len;
-
-=09if (IS_ERR(server))
-=09=09return ERR_CAST(server);
-
-=09len =3D strlen(hostname) + 5;
-=09root_devname =3D kmalloc(len, GFP_KERNEL);
-=09if (root_devname =3D=3D NULL) {
-=09=09nfs_free_server(server);
-=09=09return ERR_PTR(-ENOMEM);
-=09}
-=09/* Does hostname needs to be enclosed in brackets? */
-=09if (strchr(hostname, ':'))
-=09=09snprintf(root_devname, len, "[%s]:/", hostname);
-=09else
-=09=09snprintf(root_devname, len, "%s:/", hostname);
-=09info->server =3D server;
-=09root_mnt =3D vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, =
info);
-=09if (info->server)
-=09=09nfs_free_server(info->server);
-=09info->server =3D NULL;
-=09kfree(root_devname);
-=09return root_mnt;
-}
-
 struct nfs_referral_count {
 =09struct list_head list;
 =09const struct task_struct *task;
@@ -198,11 +167,38 @@ static void nfs_referral_loop_unprotect(void)
 =09kfree(p);
 }
=20
-static struct dentry *nfs_follow_remote_path(struct vfsmount *root_mnt,
-=09=09const char *export_path)
+static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
+=09=09=09=09    struct nfs_mount_info *info,
+=09=09=09=09    const char *hostname,
+=09=09=09=09    const char *export_path)
 {
+=09struct vfsmount *root_mnt;
 =09struct dentry *dentry;
+=09char *root_devname;
 =09int err;
+=09size_t len;
+
+=09if (IS_ERR(server))
+=09=09return ERR_CAST(server);
+
+=09len =3D strlen(hostname) + 5;
+=09root_devname =3D kmalloc(len, GFP_KERNEL);
+=09if (root_devname =3D=3D NULL) {
+=09=09nfs_free_server(server);
+=09=09return ERR_PTR(-ENOMEM);
+=09}
+
+=09/* Does hostname needs to be enclosed in brackets? */
+=09if (strchr(hostname, ':'))
+=09=09snprintf(root_devname, len, "[%s]:/", hostname);
+=09else
+=09=09snprintf(root_devname, len, "%s:/", hostname);
+=09info->server =3D server;
+=09root_mnt =3D vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, =
info);
+=09if (info->server)
+=09=09nfs_free_server(info->server);
+=09info->server =3D NULL;
+=09kfree(root_devname);
=20
 =09if (IS_ERR(root_mnt))
 =09=09return ERR_CAST(root_mnt);
@@ -223,22 +219,17 @@ struct dentry *nfs4_try_mount(int flags, const char *=
dev_name,
 =09=09=09      struct nfs_mount_info *mount_info,
 =09=09=09      struct nfs_subversion *nfs_mod)
 {
-=09char *export_path;
-=09struct vfsmount *root_mnt;
-=09struct dentry *res;
 =09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
+=09struct dentry *res;
=20
 =09mount_info->set_security =3D nfs_set_sb_security;
=20
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
-=09export_path =3D data->nfs_server.export_path;
-=09root_mnt =3D nfs_do_root_mount(
-=09=09=09nfs4_create_server(mount_info, &nfs_v4),
-=09=09=09flags, mount_info,
-=09=09=09data->nfs_server.hostname);
-
-=09res =3D nfs_follow_remote_path(root_mnt, export_path);
+=09res =3D do_nfs4_mount(nfs4_create_server(mount_info, &nfs_v4),
+=09=09=09    flags, mount_info,
+=09=09=09    data->nfs_server.hostname,
+=09=09=09    data->nfs_server.export_path);
=20
 =09dfprintk(MOUNT, "<-- nfs4_try_mount() =3D %d%s\n",
 =09=09 PTR_ERR_OR_ZERO(res),
@@ -258,8 +249,6 @@ static struct dentry *nfs4_referral_mount(struct file_s=
ystem_type *fs_type,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D data,
 =09};
-=09char *export_path;
-=09struct vfsmount *root_mnt;
 =09struct dentry *res;
=20
 =09dprintk("--> nfs4_referral_mount()\n");
@@ -268,13 +257,10 @@ static struct dentry *nfs4_referral_mount(struct file=
_system_type *fs_type,
 =09if (!mount_info.mntfh)
 =09=09return ERR_PTR(-ENOMEM);
=20
-=09export_path =3D data->mnt_path;
-=09root_mnt =3D nfs_do_root_mount(
-=09=09=09nfs4_create_referral_server(mount_info.cloned,
-=09=09=09=09=09=09    mount_info.mntfh),
-=09=09=09flags, &mount_info, data->hostname);
+=09res =3D do_nfs4_mount(nfs4_create_referral_server(mount_info.cloned,
+=09=09=09=09=09=09=09mount_info.mntfh),
+=09=09=09    flags, &mount_info, data->hostname, data->mnt_path);
=20
-=09res =3D nfs_follow_remote_path(root_mnt, export_path);
 =09dprintk("<-- nfs4_referral_mount() =3D %d%s\n",
 =09=09PTR_ERR_OR_ZERO(res),
 =09=09IS_ERR(res) ? " [error]" : "");
--=20
2.17.2

