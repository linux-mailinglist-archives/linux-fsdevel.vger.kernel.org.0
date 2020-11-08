Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD62AAB3B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgKHOED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:03 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17108 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbgKHOEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844207; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=mZEqx/zDvG0qVkObe2bk5Y4KJBaSChWrsMoAA7o7mae+dOqPpo/DnAcVOCzcITrI/xTMeUlpluxMioiaCt9mIeZC+K8r7YgDZukFtb/Hq+B8LUKMe8hJtlJh979sZW2THuswWAjHXwyejbotrQRevzcexWfpYoRHdpo2U1tXy84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844207; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xaT5YckiSr6leqc619hQ04I9/4r/88vz4xBhhTiT864=; 
        b=MaokpMJMSPeoMKwOYxDvhNOPPXN74W5/RpxRvacm1y9DVyMkt9tepzBOWcnDvZuimcawKFv2Fnxti5gf4byPyM8TejuVc4YIdiVFt35KAk6ZAw5QzIcz5Oxt13Z4A8Gr7NyU80T0b2CyIx1hZ7vM2Wo5jfb1l6rCdHZbNwVJ8rM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844207;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=xaT5YckiSr6leqc619hQ04I9/4r/88vz4xBhhTiT864=;
        b=DbDJWwoQ1iUZdYVbGGBFqIQURxcypr2B+7dlwWAs3q78Ie1q8QOcJ8slr2cMMOcD
        XGub2VrFG6YfYWjQx4aOPT7T8RP0HmF4Z7VbIru4TWQMXe5JWtC2TLfUz7IcZV2W8HB
        4zmS615xh6nwmNo4k8SY+LDa2TH4UB0//QMlz5TQ=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844205015120.49605682451715; Sun, 8 Nov 2020 22:03:25 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-6-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 05/10] ovl: mark overlayfs' inode dirty on modification
Date:   Sun,  8 Nov 2020 22:03:02 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108140307.1385745-1-cgxu519@mykernel.net>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark overlayfs' inode dirty on modification so that
we can recognize target inodes during syncfs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c     |  1 +
 fs/overlayfs/overlayfs.h |  4 ++++
 fs/overlayfs/util.c      | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 1f5cbbc60b28..faa5c345f0cf 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -468,6 +468,7 @@ int ovl_update_time(struct inode *inode, struct timespe=
c64 *ts, int flags)
 =09=09if (upperpath.dentry) {
 =09=09=09touch_atime(&upperpath);
 =09=09=09inode->i_atime =3D d_inode(upperpath.dentry)->i_atime;
+=09=09=09ovl_mark_inode_dirty(inode);
 =09=09}
 =09}
 =09return 0;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..eaf1d5b05d8e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -247,6 +247,7 @@ static inline bool ovl_open_flags_need_copy_up(int flag=
s)
 }
=20
 /* util.c */
+void ovl_mark_inode_dirty(struct inode *inode);
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
@@ -472,6 +473,9 @@ static inline void ovl_copyattr(struct inode *from, str=
uct inode *to)
 =09to->i_mtime =3D from->i_mtime;
 =09to->i_ctime =3D from->i_ctime;
 =09i_size_write(to, i_size_read(from));
+
+=09if (ovl_inode_upper(to) && from->i_state & I_DIRTY_ALL)
+=09=09ovl_mark_inode_dirty(to);
 }
=20
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..a6f59df744ae 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -950,3 +950,17 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struc=
t dentry *dentry,
 =09kfree(buf);
 =09return ERR_PTR(res);
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
2.26.2


