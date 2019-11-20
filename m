Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9A103EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfKTP16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:27:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25466 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729088AbfKTP15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXyRYvfwK/kBenxMc4uS9ozCNJSMrMs8976Ao0xrGbo=;
        b=Y+JlLoFgbJg9r6yuXBboWWygUen9rFcleUvHEq3qOp1iZFRE9Ep+EVADIWuubHe1UI0U+a
        MDGGd5UHv8gR+j7f7VnrdlUMbNkoENCTvNXwMuZwQ/8PARX1y5Y5Sivkle8oOJJxsKGkkz
        VkisR122hvoQDpSVzt+pN6d1TujOvVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-nf2ln5XfNOymqlXJs0x0iA-1; Wed, 20 Nov 2019 10:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921CA802698;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7276A5C1D4;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 4DB3B2099A; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/27] nfs: stash nfs_subversion reference into nfs_mount_info
Date:   Wed, 20 Nov 2019 10:27:31 -0500
Message-Id: <20191120152750.6880-9-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nf2ln5XfNOymqlXJs0x0iA-1
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
index 8eb79f104a7d..e7fd747d11a2 100644
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
index 7c78e6956639..0d0587ed7d94 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -233,8 +233,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
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
@@ -243,8 +243,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
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
index 91ba1b6741dc..88d83cab8e9b 100644
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
index 32d2ec237c57..20de67933527 100644
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

