Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB395415F9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbhIWNZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:44 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17225 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241297AbhIWNZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402519; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=VWzAN0jCnhLrGy3jC0Mm6+b57VyrtubCVelrCQzI/wQYYxLtp2F5NU7qy7lI0lwEB/vG4P6sFbZjETH8pxEpavBORH+jhjb4BM9YIFkU5wIpGAsRxM+IVSy10nbRz9bH4Jj87dBvps6K/QsNZxR1GwsUL49aQcbXDMVfB39ecq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402519; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=w/gDJAniEk07y4xvkybDn7HV+NGUOUDW0TeqbBoxuiE=; 
        b=V2yeYqrC4dXlA9juc5hRIxPCQsUJxAgGsTLEAC6bglrrN+I2Czgc9E5Fu5RL5k2m4kBKjabUONufQ5difqwiL2ttlJzmrjWak8WrqXc50I7dh13rNtN9r37h9+xE1gEIzV80oTQbJZh6EgvnQ3Y1XeYf+YO3auxuWHRMjk67RJ4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402519;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=w/gDJAniEk07y4xvkybDn7HV+NGUOUDW0TeqbBoxuiE=;
        b=QZMMaqGR5LywkBwNIGIgNW2QNHMHcxmweQfOG5wgRqe1XwZpwsJ9F3RbNy+oNB1R
        ZsbBg6hQFf795E4yGcVKudkL4z182w6dZOIuJb9zBPSPvjp0rybADzD7HkiC3sm6JeN
        Ql7TZ5CqCbpiSoLzbDYh+kcc4+hMxPea3JJVc4cA=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 163240251872378.04107038429561; Thu, 23 Sep 2021 21:08:38 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-5-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 04/10] ovl: mark overlayfs' inode dirty on modification
Date:   Thu, 23 Sep 2021 21:08:08 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark overlayfs' inode dirty on modification so that
we can recognize and collect target inodes for syncfs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c     |  1 +
 fs/overlayfs/overlayfs.h |  4 ++++
 fs/overlayfs/util.c      | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d854e59a3710..4a03aceaeedc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -478,6 +478,7 @@ int ovl_update_time(struct inode *inode, struct timespe=
c64 *ts, int flags)
 =09=09if (upperpath.dentry) {
 =09=09=09touch_atime(&upperpath);
 =09=09=09inode->i_atime =3D d_inode(upperpath.dentry)->i_atime;
+=09=09=09ovl_mark_inode_dirty(inode);
 =09=09}
 =09}
 =09return 0;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 3894f3347955..5a016baa06dd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -276,6 +276,7 @@ static inline bool ovl_allow_offline_changes(struct ovl=
_fs *ofs)
=20
=20
 /* util.c */
+void ovl_mark_inode_dirty(struct inode *inode);
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
@@ -529,6 +530,9 @@ static inline void ovl_copyattr(struct inode *from, str=
uct inode *to)
 =09to->i_mtime =3D from->i_mtime;
 =09to->i_ctime =3D from->i_ctime;
 =09i_size_write(to, i_size_read(from));
+
+=09if (ovl_inode_upper(to) && from->i_state & I_DIRTY_ALL)
+=09=09ovl_mark_inode_dirty(to);
 }
=20
 /* vfs inode flags copied from real to ovl inode */
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f48284a2a896..5441eae2e345 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -25,7 +25,14 @@ int ovl_want_write(struct dentry *dentry)
 void ovl_drop_write(struct dentry *dentry)
 {
 =09struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
+=09struct dentry *upper;
+
 =09mnt_drop_write(ovl_upper_mnt(ofs));
+=09if (d_inode(dentry)) {
+=09=09upper =3D ovl_dentry_upper(dentry);
+=09=09if (upper && d_inode(upper) && d_inode(upper)->i_state & I_DIRTY_ALL=
)
+=09=09=09ovl_mark_inode_dirty(d_inode(dentry));
+=09}
 }
=20
 struct dentry *ovl_workdir(struct dentry *dentry)
@@ -1060,3 +1067,17 @@ int ovl_sync_status(struct ovl_fs *ofs)
=20
 =09return errseq_check(&mnt->mnt_sb->s_wb_err, ofs->errseq);
 }
+
+/*
+ * We intentionally add I_DIRTY_SYNC flag regardless dirty flag
+ * of upper inode so that we have chance to invoke ->write_inode
+ * to re-dirty overlayfs' inode during writeback process.
+ */
+void ovl_mark_inode_dirty(struct inode *inode)
+{
+=09struct inode *upper =3D ovl_inode_upper(inode);
+=09unsigned long iflag =3D I_DIRTY_SYNC;
+
+=09iflag |=3D upper->i_state & I_DIRTY_ALL;
+=09__mark_inode_dirty(inode, iflag);
+}
--=20
2.27.0


