Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEAB103EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfKTPah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:30:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729154AbfKTP14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bimceprUZXtgJwJ3r+uNah68s5oKbHDn9kJlulQ0RL0=;
        b=Jo/WE6nlzM694NvvdlswpADBOveVI5fxqZyyUkcmmkt0ocH5kimQkbuZr5oBArR6faHkMc
        595UNuf7SacWev7/8ggsCsF4OeUCTgDN/kowrY99cbmPTJCOWxsexlRbU8AIpw/HWCdd3X
        y6IDsjSMZM6OBMy2p9D5WDArAh+vhls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-0lhVNJB-Na6Zu_SXt0PRAQ-1; Wed, 20 Nov 2019 10:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15515DBAA;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4E425E271;
        Wed, 20 Nov 2019 15:27:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 343142093D; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/27] nfs: fold nfs4_remote_fs_type and nfs4_remote_referral_fs_type
Date:   Wed, 20 Nov 2019 10:27:27 -0500
Message-Id: <20191120152750.6880-5-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0lhVNJB-Na6Zu_SXt0PRAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

They are identical now.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 773c347df3ab..d0237d8ffa2b 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -22,8 +22,6 @@ static struct dentry *nfs4_remote_mount(struct file_syste=
m_type *fs_type,
 =09int flags, const char *dev_name, void *raw_data);
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type=
,
 =09int flags, const char *dev_name, void *raw_data);
-static struct dentry *nfs4_remote_referral_mount(struct file_system_type *=
fs_type,
-=09int flags, const char *dev_name, void *raw_data);
=20
 static struct file_system_type nfs4_remote_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
@@ -33,14 +31,6 @@ static struct file_system_type nfs4_remote_fs_type =3D {
 =09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
=20
-static struct file_system_type nfs4_remote_referral_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "nfs4",
-=09.mount=09=09=3D nfs4_remote_referral_mount,
-=09.kill_sb=09=3D nfs_kill_super,
-=09.fs_flags=09=3D FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-
 struct file_system_type nfs4_referral_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "nfs4",
@@ -111,8 +101,7 @@ nfs4_remote_mount(struct file_system_type *fs_type, int=
 flags,
 =09return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
=20
-static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type=
,
-=09=09=09=09=09  struct nfs_server *server, int flags,
+static struct vfsmount *nfs_do_root_mount(struct nfs_server *server, int f=
lags,
 =09=09=09=09=09  struct nfs_mount_info *info,
 =09=09=09=09=09  const char *hostname)
 {
@@ -135,7 +124,7 @@ static struct vfsmount *nfs_do_root_mount(struct file_s=
ystem_type *fs_type,
 =09else
 =09=09snprintf(root_devname, len, "%s:/", hostname);
 =09info->server =3D server;
-=09root_mnt =3D vfs_kern_mount(fs_type, flags, root_devname, info);
+=09root_mnt =3D vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, =
info);
 =09if (info->server)
 =09=09nfs_free_server(info->server);
 =09info->server =3D NULL;
@@ -245,7 +234,7 @@ struct dentry *nfs4_try_mount(int flags, const char *de=
v_name,
=20
 =09export_path =3D data->nfs_server.export_path;
 =09data->nfs_server.export_path =3D "/";
-=09root_mnt =3D nfs_do_root_mount(&nfs4_remote_fs_type,
+=09root_mnt =3D nfs_do_root_mount(
 =09=09=09nfs4_create_server(mount_info, &nfs_v4),
 =09=09=09flags, mount_info,
 =09=09=09data->nfs_server.hostname);
@@ -259,13 +248,6 @@ struct dentry *nfs4_try_mount(int flags, const char *d=
ev_name,
 =09return res;
 }
=20
-static struct dentry *
-nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
-=09=09=09   const char *dev_name, void *raw_data)
-{
-=09return nfs_fs_mount_common(flags, dev_name, raw_data, &nfs_v4);
-}
-
 /*
  * Create an NFS4 server record on referral traversal
  */
@@ -290,7 +272,7 @@ static struct dentry *nfs4_referral_mount(struct file_s=
ystem_type *fs_type,
=20
 =09export_path =3D data->mnt_path;
 =09data->mnt_path =3D "/";
-=09root_mnt =3D nfs_do_root_mount(&nfs4_remote_referral_fs_type,
+=09root_mnt =3D nfs_do_root_mount(
 =09=09=09nfs4_create_referral_server(mount_info.cloned,
 =09=09=09=09=09=09    mount_info.mntfh),
 =09=09=09flags, &mount_info, data->hostname);
--=20
2.17.2

