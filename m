Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA5103E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfKTP17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:27:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729006AbfKTP15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqfdYpPgjwlAgHoNin402Ab2BCj8S4U3NjRO8OWvM4E=;
        b=ThgKhNOY3uulV+4z16AYX9ne5IE/BKidkVrwKiDLVRWMQQsdbafmkpKTTwpvqbPuLJ/RyF
        Y4DYYtYaBMy9dK+PBSwNt94eP5I9OcX52V6Z4mcfSdghTJmIaxNTF2qiEwKPKmQP/TSqoL
        u+7YwUjXbez0+jPglQ15rqHZ9RzI4dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-3Ggo02u1Ody_r0kMzeSAbg-1; Wed, 20 Nov 2019 10:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037B818B5F72;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3FAE46E76;
        Wed, 20 Nov 2019 15:27:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 223AB20634; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/27] saner calling conventions for nfs_fs_mount_common()
Date:   Wed, 20 Nov 2019 10:27:24 -0500
Message-Id: <20191120152750.6880-2-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3Ggo02u1Ody_r0kMzeSAbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Allow it to take ERR_PTR() for server and return ERR_CAST() of it in
such case.  All callers used to open-code that...

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 16 +---------------
 fs/nfs/super.c     | 11 ++++-------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 04c57066a11a..baece9857bcf 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -110,21 +110,12 @@ nfs4_remote_mount(struct file_system_type *fs_type, i=
nt flags,
 {
 =09struct nfs_mount_info *mount_info =3D info;
 =09struct nfs_server *server;
-=09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
=20
 =09mount_info->set_security =3D nfs_set_sb_security;
=20
 =09/* Get a volume representation */
 =09server =3D nfs4_create_server(mount_info, &nfs_v4);
-=09if (IS_ERR(server)) {
-=09=09mntroot =3D ERR_CAST(server);
-=09=09goto out;
-=09}
-
-=09mntroot =3D nfs_fs_mount_common(server, flags, dev_name, mount_info, &n=
fs_v4);
-
-out:
-=09return mntroot;
+=09return nfs_fs_mount_common(server, flags, dev_name, mount_info, &nfs_v4=
);
 }
=20
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type=
,
@@ -280,11 +271,6 @@ nfs4_remote_referral_mount(struct file_system_type *fs=
_type, int flags,
=20
 =09/* create a new volume representation */
 =09server =3D nfs4_create_referral_server(mount_info.cloned, mount_info.mn=
tfh);
-=09if (IS_ERR(server)) {
-=09=09mntroot =3D ERR_CAST(server);
-=09=09goto out;
-=09}
-
 =09mntroot =3D nfs_fs_mount_common(server, flags, dev_name, &mount_info, &=
nfs_v4);
 out:
 =09nfs_free_fhandle(mount_info.mntfh);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a84df7d63403..9d2f1d6a5b9a 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1903,9 +1903,6 @@ struct dentry *nfs_try_mount(int flags, const char *d=
ev_name,
 =09else
 =09=09server =3D nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
=20
-=09if (IS_ERR(server))
-=09=09return ERR_CAST(server);
-
 =09return nfs_fs_mount_common(server, flags, dev_name, mount_info, nfs_mod=
);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
@@ -2666,6 +2663,9 @@ struct dentry *nfs_fs_mount_common(struct nfs_server =
*server,
 =09};
 =09int error;
=20
+=09if (IS_ERR(server))
+=09=09return ERR_CAST(server);
+
 =09if (server->flags & NFS_MOUNT_UNSHARED)
 =09=09compare_super =3D NULL;
=20
@@ -2814,10 +2814,7 @@ nfs_xdev_mount(struct file_system_type *fs_type, int=
 flags,
 =09/* create a new volume representation */
 =09server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, d=
ata->fattr, data->authflavor);
=20
-=09if (IS_ERR(server))
-=09=09mntroot =3D ERR_CAST(server);
-=09else
-=09=09mntroot =3D nfs_fs_mount_common(server, flags,
+=09mntroot =3D nfs_fs_mount_common(server, flags,
 =09=09=09=09dev_name, &mount_info, nfs_mod);
=20
 =09dprintk("<-- nfs_xdev_mount() =3D %ld\n",
--=20
2.17.2

