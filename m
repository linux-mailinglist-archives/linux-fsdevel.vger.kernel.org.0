Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAC28A3FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbgJJWzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:32 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17153 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732305AbgJJWaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:30:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602339880; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nb9mhlTiw69Fy4d7eHGPtKA+3wMCTA9NnWOi3IJ/ZhH1jcN+oubMelcHvdAgKdXj6GuSicH2bUGeVGR+KG0EjGyqkVbXaMYM2hZ7p6GL5WSF99oyeCy0xIaTyH+evQnNzlPMv8eAguI4TzfayowZLv55zJpYJooCpMwex1Yewqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602339880; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0FT7nwLZI8QnaSOqMzrZbIUlOkAi+raEELEwS8KSQ7U=; 
        b=j7OPGJtucreIP9cgmN+oE6L1EgIuQKR6+NIUeYN0eFxTmURtIwC0/hq0X28WTCfT1bOcMUOwug4PVcT970Vcdv4kibdTVlJ8xWGVJBEIu3RwYHQgnzWSTAs02TxL0vQWNviguDRM1dV1qKBArNIvucaxSasrTuorXIV0qhoHrPk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602339880;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=0FT7nwLZI8QnaSOqMzrZbIUlOkAi+raEELEwS8KSQ7U=;
        b=Fu13R3fWIjklyz1z0MyC/QHF5/o4jmsTUzBwovAE/D1NOxIXQn3dC6VlVTUiqyq7
        gEk3UE5MO5GpjvrtmZn3SPTfE0N+5dRwYSjXd9qMCOuKx9xE2o3oHQoTSdUSiPKbVVH
        1cEYN6XsWxEIg8JWvRXVEFhVcdTlaE/g2XVXBYwk=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602339878667624.5808504247093; Sat, 10 Oct 2020 22:24:38 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010142355.741645-5-cgxu519@mykernel.net>
Subject: [RFC PATCH 4/5] ovl: monitor marking dirty activity of underlying upper inode
Date:   Sat, 10 Oct 2020 22:23:54 +0800
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

Monitor marking dirty activity of underlying upper inode
so that we have chance to mark overlayfs' own inode dirty.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c     |  4 +++-
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/super.c     | 11 +++++++++++
 fs/overlayfs/util.c      | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca..e75c7ec 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -632,8 +632,10 @@ void ovl_inode_init(struct inode *inode, struct ovl_in=
ode_params *oip,
 {
 =09struct inode *realinode;
=20
-=09if (oip->upperdentry)
+=09if (oip->upperdentry) {
 =09=09OVL_I(inode)->__upperdentry =3D oip->upperdentry;
+=09=09ovl_register_mark_dirty_notify(OVL_I(inode));
+=09}
 =09if (oip->lowerpath && oip->lowerpath->dentry)
 =09=09OVL_I(inode)->lower =3D igrab(d_inode(oip->lowerpath->dentry));
 =09if (oip->lowerdata)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7bce246..04ef778 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -247,6 +247,8 @@ static inline bool ovl_open_flags_need_copy_up(int flag=
s)
 }
=20
 /* util.c */
+void ovl_register_mark_dirty_notify(struct ovl_inode *oi);
+void ovl_unregister_mark_dirty_notify(struct ovl_inode *oi);
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094..fce5314 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -129,6 +129,8 @@ struct ovl_inode {
=20
 =09/* synchronize copy up and more */
 =09struct mutex lock;
+=09/* moniter marking dirty behavior of upper inode */
+=09struct notifier_block mark_dirty_nb;
 };
=20
 static inline struct ovl_inode *OVL_I(struct inode *inode)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index dc22725..6d8f9da 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -390,11 +390,22 @@ static int ovl_remount(struct super_block *sb, int *f=
lags, char *data)
 =09return ret;
 }
=20
+void ovl_evict_inode(struct inode *inode)
+{
+=09struct inode *upper;
+
+=09upper =3D ovl_inode_upper(inode);
+=09if (upper)
+=09=09ovl_unregister_mark_dirty_notify(OVL_I(inode));
+=09clear_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
+=09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f4756..bdcfe55 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -417,6 +417,7 @@ void ovl_inode_update(struct inode *inode, struct dentr=
y *upperdentry)
 =09=09inode->i_private =3D upperinode;
 =09=09__insert_inode_hash(inode, (unsigned long) upperinode);
 =09}
+=09ovl_register_mark_dirty_notify(OVL_I(inode));
 }
=20
 static void ovl_dentry_version_inc(struct dentry *dentry, bool impurity)
@@ -950,3 +951,36 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struc=
t dentry *dentry,
 =09kfree(buf);
 =09return ERR_PTR(res);
 }
+
+int ovl_inode_dirty_notify(struct notifier_block *nb,
+=09=09=09   unsigned long dummy, void *param)
+{
+=09struct ovl_inode *oi =3D container_of(nb, struct ovl_inode, mark_dirty_=
nb);
+=09int *flags =3D (int *)param;
+
+=09// add later
+=09//__mark_inode_dirty(&oi->vfs_inode, *flags);
+=09return NOTIFY_OK;
+}
+
+void ovl_register_mark_dirty_notify(struct ovl_inode *oi)
+{
+=09struct inode *upper;
+
+=09upper =3D oi->__upperdentry->d_inode;
+=09oi->mark_dirty_nb.notifier_call =3D ovl_inode_dirty_notify;
+
+=09blocking_notifier_chain_register(
+=09=09&upper->notifier_lists[MARK_INODE_DIRTY_NOTIFIER],
+=09=09&oi->mark_dirty_nb);
+}
+
+void ovl_unregister_mark_dirty_notify(struct ovl_inode *oi)
+{
+=09struct inode *upper;
+
+=09upper =3D oi->__upperdentry->d_inode;
+=09blocking_notifier_chain_unregister(
+=09=09&upper->notifier_lists[MARK_INODE_DIRTY_NOTIFIER],
+=09=09&oi->mark_dirty_nb);
+}
--=20
1.8.3.1


