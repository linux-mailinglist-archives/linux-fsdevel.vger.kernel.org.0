Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A97118883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLJMds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:33:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727380AbfLJMbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAmrXw649vI1rmvoCJ892uddiEcs7gVdp3XK2QIiBjM=;
        b=gxeqOYy9c7vrWdittvNKBwJYt7lcMHB9yLMMpmTpRhgF8AimRHsR7NDcxjqGchpgq3CHXK
        14ea+toSp5kbi7RmllZPPSU3BpFWIBmpdNfG9Z2KE984oxPnxxf9fB8uRWdehwgxEFv7YE
        dfPZqoSM3+y8fF2S4BMebcm2ZgMqkvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-XIXNLylDPJygxEa8-mb9Ww-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 305D166F;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CFBC19C69;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id B35FD20C09; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 08/27] nfs: stash nfs_subversion reference into nfs_mount_info
Date:   Tue, 10 Dec 2019 07:30:56 -0500
Message-Id: <20191210123115.1655-9-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XIXNLylDPJygxEa8-mb9Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

That will allow to get rid of passing those references around in
quite a few places.  Moreover, that will allow to merge xdev and
remote file_system_type.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  | 1 +
 fs/nfs/namespace.c | 6 +++---
 fs/nfs/nfs4super.c | 1 +
 fs/nfs/super.c     | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index b193dd626c0a..9888e9c7abe2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -142,6 +142,7 @@ struct nfs_mount_info {
 =09struct nfs_clone_mount *cloned;
 =09struct nfs_server *server;
 =09struct nfs_fh *mntfh;
+=09struct nfs_subversion *nfs_mod;
 };
=20
 extern int nfs_mount(struct nfs_mount_request *info);
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index a76aeb0c2923..a00936dd153b 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -236,8 +236,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
 struct nfs_fh *fh,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D &mountdata,
 =09=09.mntfh =3D fh,
+=09=09.nfs_mod =3D NFS_SB(sb)->nfs_client->cl_nfs_mod,
 =09};
-=09struct nfs_subversion *nfs_mod =3D NFS_SB(sb)->nfs_client->cl_nfs_mod;
 =09struct nfs_server *server;
 =09struct vfsmount *mnt;
 =09char *page =3D (char *) __get_free_page(GFP_USER);
@@ -246,8 +246,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
 struct nfs_fh *fh,
 =09if (page =3D=3D NULL)
 =09=09return ERR_PTR(-ENOMEM);
=20
-=09server =3D nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-=09=09=09=09=09=09fattr, authflavor);
+=09server =3D mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
+=09=09=09=09=09=09=09   fattr, authflavor);
 =09if (IS_ERR(server))
 =09=09return ERR_CAST(server);
=20
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index c489942b9069..6e5417027021 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -248,6 +248,7 @@ static struct dentry *nfs4_referral_mount(struct file_s=
ystem_type *fs_type,
 =09=09.fill_super =3D nfs_fill_super,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D data,
+=09=09.nfs_mod =3D &nfs_v4,
 =09};
 =09struct dentry *res;
=20
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 97dc544eb220..6189f768aa59 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2761,6 +2761,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *=
fs_type,
 =09=09mntroot =3D ERR_CAST(nfs_mod);
 =09=09goto out;
 =09}
+=09mount_info.nfs_mod =3D nfs_mod;
=20
 =09mntroot =3D nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, n=
fs_mod);
=20
--=20
2.17.2

