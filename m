Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9421228A401
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgJJWze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:34 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17116 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732388AbgJJWbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:31:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602339882; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=rqONLFljqQog/aZv+2cAXbL432GO/ehy6rQX+YJX+w56RErDHwUq+aTCaXIiXKqmwzpNRbN/ELATD8NwkusF6nmAkXxYNpc7f7ReIYUXjp5/LHBQvqmKuamN3+nEuZTyAM01o57cfUYPT5xfx+lLxQZ6IySPgSk+dDA3GIDKq5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602339882; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=l7QI5z5nxcZnZk2o8vib20dSzdU3zy5H03EE9Nt4BAQ=; 
        b=o32OchT2p/Mw5TAv86uNkTKMoLPnywrKVnNRUuIlkFzPGI+zUWUoU3qqN0OXEMGfYGW5OJx0G8L+i/BeoBt266Vv7DWWCrNFx1GheZmR2DpMS8rNFliUUQKDce3anzasrFk13PEipA3lcmc/w3lnLcBxRCcmnHmMVlVYhhOy7d4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602339882;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=l7QI5z5nxcZnZk2o8vib20dSzdU3zy5H03EE9Nt4BAQ=;
        b=cIYzXt2jWLy2zuEyg4Pomamo/r9sHlg6seJrtAY2hoe4LZoxls7Nm4UUa1+i/RAZ
        UggoNSciGXoXKAmF9clYrLZIaDWvFVj0Fz5lgkv8mjGZxKYMIDOHCBgplxbjsRqEn4y
        I3mgnyQzblaqumaYFGzr+X5iIiPhsCwWAZAs4IP4=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602339880238770.8554970291059; Sat, 10 Oct 2020 22:24:40 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010142355.741645-6-cgxu519@mykernel.net>
Subject: [RFC PATCH 5/5] ovl: impement containerized syncfs for overlayfs
Date:   Sat, 10 Oct 2020 22:23:55 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010142355.741645-1-cgxu519@mykernel.net>
References: <20201010142355.741645-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark overlayfs' inode dirty when underlying upper inode becomes dirty,
then only sync overlayfs' dirty inodes while syncfs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c | 24 ++++++++++++++++++++++++
 fs/overlayfs/super.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++-=
---
 fs/overlayfs/util.c  |  3 +--
 3 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e75c7ec..c709aed 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
=20
@@ -516,7 +517,30 @@ static int ovl_fiemap(struct inode *inode, struct fiem=
ap_extent_info *fieinfo,
 =09.update_time=09=3D ovl_update_time,
 };
=20
+static int ovl_writepages(struct address_space *mapping, struct writeback_=
control *wbc)
+{
+=09struct inode *inode =3D mapping->host;
+=09struct inode *upper_inode =3D ovl_inode_upper(inode);
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct writeback_control upper_wbc =3D {
+=09=09.nr_to_write=09=09=3D LONG_MAX,
+=09=09.sync_mode=09=09=3D WB_SYNC_ALL,
+=09=09.for_kupdate=09=09=3D wbc->for_kupdate,
+=09=09.for_background=09=09=3D wbc->for_background,
+=09=09.for_sync=09=09=3D 0,
+=09=09.range_cyclic=09=09=3D wbc->range_cyclic,
+=09=09.range_start=09=09=3D 0,
+=09=09.range_end=09=09=3D LLONG_MAX,
+=09};
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+
+=09return writeback_single_inode(upper_inode, &upper_wbc);
+}
+
 static const struct address_space_operations ovl_aops =3D {
+=09.writepages             =3D ovl_writepages,
 =09/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
 =09.direct_IO=09=09=3D noop_direct_IO,
 };
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 6d8f9da..da1b65a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,9 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/notifier.h>
+#include <linux/writeback.h>
+#include <linux/blkdev.h>
 #include "overlayfs.h"
=20
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -279,9 +282,13 @@ static int ovl_sync_fs(struct super_block *sb, int wai=
t)
=20
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
=20
-=09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
-=09up_read(&upper_sb->s_umount);
+=09if (upper_sb->s_op->sync_fs) {
+=09=09down_read(&upper_sb->s_umount);
+=09=09ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
+=09=09if (!ret)
+=09=09=09ret =3D sync_blockdev(upper_sb->s_bdev);
+=09=09up_read(&upper_sb->s_umount);
+=09}
=20
 =09return ret;
 }
@@ -400,11 +407,47 @@ void ovl_evict_inode(struct inode *inode)
 =09clear_inode(inode);
 }
=20
+int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct super_block *upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
+=09struct inode *upper_inode =3D ovl_inode_upper(inode);
+=09struct writeback_control upper_wbc =3D {
+=09=09.nr_to_write=09=09=3D LONG_MAX,
+=09=09.sync_mode              =3D WB_SYNC_ALL,
+=09=09.tagged_writepages=09=3D wbc->tagged_writepages,
+=09=09.for_kupdate=09=09=3D wbc->for_kupdate,
+=09=09.for_background=09=09=3D wbc->for_background,
+=09=09.for_sync=09=09=3D 0,
+=09=09.range_cyclic=09=09=3D wbc->range_cyclic,
+=09=09.range_start=09=09=3D wbc->range_start,
+=09=09.range_end=09=09=3D wbc->range_end,
+=09};
+
+=09if (!upper_sb->s_op->write_inode || !upper_inode)
+=09=09return 0;
+=09return upper_sb->s_op->write_inode(upper_inode, &upper_wbc);
+}
+
+int ovl_drop_inode(struct inode *inode)
+{
+=09struct inode *upper_inode;
+
+=09upper_inode =3D ovl_inode_upper(inode);
+=09if (!upper_inode)
+=09=09return 1;
+=09if (!(upper_inode->i_state & I_DIRTY_ALL))
+=09=09return 1;
+
+=09return generic_drop_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
-=09.drop_inode=09=3D generic_delete_inode,
+=09.drop_inode=09=3D ovl_drop_inode,
+=09.write_inode=09=3D ovl_write_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index bdcfe55..93d0493 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -958,8 +958,7 @@ int ovl_inode_dirty_notify(struct notifier_block *nb,
 =09struct ovl_inode *oi =3D container_of(nb, struct ovl_inode, mark_dirty_=
nb);
 =09int *flags =3D (int *)param;
=20
-=09// add later
-=09//__mark_inode_dirty(&oi->vfs_inode, *flags);
+=09__mark_inode_dirty(&oi->vfs_inode, *flags);
 =09return NOTIFY_OK;
 }
=20
--=20
1.8.3.1


