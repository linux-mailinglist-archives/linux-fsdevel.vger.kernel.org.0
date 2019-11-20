Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A93103EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfKTPaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:30:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729252AbfKTP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TqPCPDaHSnUMC6Pod9TArA1MI/jhzoyoWGg70QhSRk=;
        b=LCQgyluY4XiW2TFC0O1aXyEjzNuWe00QQV+GBdlhEu6fGSfCOT0WZ3Utxj9kasZhnbDOvC
        FVjQRu/ItMGtuSgarGvgUb31/xpWMJVaxdoK9PArlnMYDRvpCPFJPpq8LDX08+4mkHED9Z
        +8cI66FxxTF5rd+Rn2grlf8DqKUwT+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-QTCN_AgVOVOSpX1x5DmtyQ-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 404C0100551A;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D52D51054FBF;
        Wed, 20 Nov 2019 15:27:51 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 66776209AF; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/27] nfs: get rid of mount_info ->fill_super()
Date:   Wed, 20 Nov 2019 10:27:36 -0500
Message-Id: <20191120152750.6880-14-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QTCN_AgVOVOSpX1x5DmtyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The only possible values are nfs_fill_super and nfs_clone_super.  The
latter is used only when crossing into a submount and it is almost
identical to the former; the only differences are
=09* ->s_time_gran unconditionally set to 1 (even for v2 mounts).
Regression dating back to 2012, actually.
=09* ->s_blocksize/->s_blocksize_bits set to that of parent.

Rather than messing with the method, stash ->s_blocksize_bits in
mount_info in submount case and after the (now unconditional)
call of nfs_fill_super() override ->s_blocksize/->s_blocksize_bits
if that has been set.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  4 +--
 fs/nfs/namespace.c |  2 +-
 fs/nfs/nfs4super.c |  1 -
 fs/nfs/super.c     | 75 ++++++++++------------------------------------
 4 files changed, 18 insertions(+), 64 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e4f8a4734a2e..f64337a6d229 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -136,7 +136,7 @@ struct nfs_mount_request {
 };
=20
 struct nfs_mount_info {
-=09void (*fill_super)(struct super_block *, struct nfs_mount_info *);
+=09unsigned int inherited_bsize;
 =09int (*set_security)(struct super_block *, struct dentry *, struct nfs_m=
ount_info *);
 =09struct nfs_parsed_mount_data *parsed;
 =09struct nfs_clone_mount *cloned;
@@ -395,8 +395,6 @@ int nfs_set_sb_security(struct super_block *, struct de=
ntry *, struct nfs_mount_
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nf=
s_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, =
void *);
 void nfs_kill_super(struct super_block *);
-void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
-void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
=20
 extern struct rpc_stat nfs_rpcstat;
=20
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 970f92a860ed..7bc5b9b8f5ea 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -229,7 +229,7 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry,=
 struct nfs_fh *fh,
 =09=09.authflavor =3D authflavor,
 =09};
 =09struct nfs_mount_info mount_info =3D {
-=09=09.fill_super =3D nfs_clone_super,
+=09=09.inherited_bsize =3D sb->s_blocksize_bits,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D &mountdata,
 =09=09.mntfh =3D fh,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b6cf62125380..d387c3c3b600 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -224,7 +224,6 @@ static struct dentry *nfs4_referral_mount(struct file_s=
ystem_type *fs_type,
 {
 =09struct nfs_clone_mount *data =3D raw_data;
 =09struct nfs_mount_info mount_info =3D {
-=09=09.fill_super =3D nfs_fill_super,
 =09=09.set_security =3D nfs_clone_sb_security,
 =09=09.cloned =3D data,
 =09=09.nfs_mod =3D &nfs_v4,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 691cd93c8a2f..d8b53fcaa60e 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2339,29 +2339,9 @@ nfs_remount(struct super_block *sb, int *flags, char=
 *raw_data)
 EXPORT_SYMBOL_GPL(nfs_remount);
=20
 /*
- * Initialise the common bits of the superblock
+ * Finish setting up an NFS superblock
  */
-static void nfs_initialise_sb(struct super_block *sb)
-{
-=09struct nfs_server *server =3D NFS_SB(sb);
-
-=09sb->s_magic =3D NFS_SUPER_MAGIC;
-
-=09/* We probably want something more informative here */
-=09snprintf(sb->s_id, sizeof(sb->s_id),
-=09=09 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
-
-=09if (sb->s_blocksize =3D=3D 0)
-=09=09sb->s_blocksize =3D nfs_block_bits(server->wsize,
-=09=09=09=09=09=09 &sb->s_blocksize_bits);
-
-=09nfs_super_set_maxbytes(sb, server->maxfilesize);
-}
-
-/*
- * Finish setting up an NFS2/3 superblock
- */
-void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_i=
nfo)
+static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *=
mount_info)
 {
 =09struct nfs_parsed_mount_data *data =3D mount_info->parsed;
 =09struct nfs_server *server =3D NFS_SB(sb);
@@ -2391,44 +2371,17 @@ void nfs_fill_super(struct super_block *sb, struct =
nfs_mount_info *mount_info)
 =09=09sb->s_time_max =3D S64_MAX;
 =09}
=20
- =09nfs_initialise_sb(sb);
-}
-EXPORT_SYMBOL_GPL(nfs_fill_super);
-
-/*
- * Finish setting up a cloned NFS2/3/4 superblock
- */
-void nfs_clone_super(struct super_block *sb,
-=09=09=09    struct nfs_mount_info *mount_info)
-{
-=09const struct super_block *old_sb =3D mount_info->cloned->sb;
-=09struct nfs_server *server =3D NFS_SB(sb);
-
-=09sb->s_blocksize_bits =3D old_sb->s_blocksize_bits;
-=09sb->s_blocksize =3D old_sb->s_blocksize;
-=09sb->s_maxbytes =3D old_sb->s_maxbytes;
-=09sb->s_xattr =3D old_sb->s_xattr;
-=09sb->s_op =3D old_sb->s_op;
-=09sb->s_export_op =3D old_sb->s_export_op;
+=09sb->s_magic =3D NFS_SUPER_MAGIC;
=20
-=09if (server->nfs_client->rpc_ops->version !=3D 2) {
-=09=09/* The VFS shouldn't apply the umask to mode bits. We will do
-=09=09 * so ourselves when necessary.
-=09=09 */
-=09=09sb->s_flags |=3D SB_POSIXACL;
-=09=09sb->s_time_gran =3D 1;
-=09} else
-=09=09sb->s_time_gran =3D 1000;
+=09/* We probably want something more informative here */
+=09snprintf(sb->s_id, sizeof(sb->s_id),
+=09=09 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
=20
-=09if (server->nfs_client->rpc_ops->version !=3D 4) {
-=09=09sb->s_time_min =3D 0;
-=09=09sb->s_time_max =3D U32_MAX;
-=09} else {
-=09=09sb->s_time_min =3D S64_MIN;
-=09=09sb->s_time_max =3D S64_MAX;
-=09}
+=09if (sb->s_blocksize =3D=3D 0)
+=09=09sb->s_blocksize =3D nfs_block_bits(server->wsize,
+=09=09=09=09=09=09 &sb->s_blocksize_bits);
=20
- =09nfs_initialise_sb(sb);
+=09nfs_super_set_maxbytes(sb, server->maxfilesize);
 }
=20
 static int nfs_compare_mount_options(const struct super_block *s, const st=
ruct nfs_server *b, int flags)
@@ -2701,8 +2654,13 @@ static struct dentry *nfs_fs_mount_common(int flags,=
 const char *dev_name,
 =09}
=20
 =09if (!s->s_root) {
+=09=09unsigned bsize =3D mount_info->inherited_bsize;
 =09=09/* initial superblock/root creation */
-=09=09mount_info->fill_super(s, mount_info);
+=09=09nfs_fill_super(s, mount_info);
+=09=09if (bsize) {
+=09=09=09s->s_blocksize_bits =3D bsize;
+=09=09=09s->s_blocksize =3D 1U << bsize;
+=09=09}
 =09=09nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
 =09=09if (!(server->flags & NFS_MOUNT_UNSHARED))
 =09=09=09s->s_iflags |=3D SB_I_MULTIROOT;
@@ -2737,7 +2695,6 @@ struct dentry *nfs_fs_mount(struct file_system_type *=
fs_type,
 =09int flags, const char *dev_name, void *raw_data)
 {
 =09struct nfs_mount_info mount_info =3D {
-=09=09.fill_super =3D nfs_fill_super,
 =09=09.set_security =3D nfs_set_sb_security,
 =09};
 =09struct dentry *mntroot =3D ERR_PTR(-ENOMEM);
--=20
2.17.2

