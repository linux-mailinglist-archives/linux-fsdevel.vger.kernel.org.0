Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAC1E1920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 03:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgEZBhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 21:37:11 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17137 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387794AbgEZBhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 21:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590456977; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=kebxn3oeMU6m9o1J6r+1+15WCCAgG3YkxkL7wV2cdRZSn858nQxv/WcDvq9y/Jgi9k1pGZ1eDKYaQtOlPAG6tshkQQsreev480TgOGKRBXVkKcgBT3OqSeZxS+VzZc/yuHY49c21DT/x1KWpRPPcl/qyXi/AF8QU2waG4DCe7zA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1590456977; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=W+BQC2GaJHDT2mZ2pan3p02uuV3yAycUAHrs51y9XMU=; 
        b=e2yXPWJ6R9lt9OvLQNV41d+cxAUvOPJeMSruJJsW0fAwZI5sg54TUBEk9z708qnk4HMoPTvRhoujr1uFNI/0i0wzshc0PDs3YRJ0LcbgXJetcOt5nHFG0zARNvqZp6jV9DbQJM/Q/2y7+kr8+kBw3dSZHFXPUF30AqEbtAM4aV8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590456977;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=W+BQC2GaJHDT2mZ2pan3p02uuV3yAycUAHrs51y9XMU=;
        b=fOxuspGiZgH3Goq7eH+7aqR826RJAIbIcE40NdkhcbzXfio2+jF1GSU2Itk00Ddo
        a/k6WBT0yBiZzt2sXVORj9BbBFSKg7j0f8Kn7RMwocylPYyLHvHpS7SRxq+O4njtzMj
        293VilV65aOHdZ44zrHAsLLsA2oSl4TouY7cM7uE=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1590456975196819.058477717145; Tue, 26 May 2020 09:36:15 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, viro@zeniv.linux.org.uk
Cc:     raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200526013557.11121-1-cgxu519@mykernel.net>
Subject: [RFC PATCH v4] ovl: drop negative dentry in upper layer
Date:   Tue, 26 May 2020 09:35:57 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Negative dentries of upper layer are useless after construction
of overlayfs' own dentry and may keep in the memory long time even
after unmount of overlayfs instance. This patch tries to drop
unnecessary negative dentry of upper layer to effectively reclaim
memory.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Only drop negative dentry in slow path of lookup.

v2->v3:
- Drop negative dentry in vfs layer.
- Rebase on latest linus-tree(5.7.0-rc5).

v3->v4:
- Check negative dentry with dentry lock.
- Only drop negative dentry in upper layer.

 fs/overlayfs/namei.c | 45 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 723d17744758..47cc79ec8205 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -191,16 +191,46 @@ static bool ovl_is_opaquedir(struct dentry *dentry)
 =09return ovl_check_dir_xattr(dentry, OVL_XATTR_OPAQUE);
 }
=20
+static struct dentry *ovl_lookup_positive_unlocked(const char *name,
+=09=09=09=09=09struct dentry *base, int len)
+{
+=09struct dentry *dentry;
+=09bool drop =3D false;
+
+=09dentry =3D lookup_one_len_unlocked(name, base, len);
+=09if (!IS_ERR(dentry) && d_is_negative(dentry) &&
+=09    dentry->d_lockref.count =3D=3D 1) {
+=09=09spin_lock(&dentry->d_lock);
+=09=09/* Recheck condition under lock */
+=09=09if (d_is_negative(dentry) && dentry->d_lockref.count =3D=3D 1) {
+=09=09=09__d_drop(dentry);
+=09=09=09drop =3D true;
+=09=09}
+=09=09spin_unlock(&dentry->d_lock);
+
+=09=09if (drop) {
+=09=09=09dput(dentry);
+=09=09=09dentry =3D ERR_PTR(-ENOENT);
+=09=09}
+=09}
+
+=09return dentry;
+}
+
 static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *=
d,
 =09=09=09     const char *name, unsigned int namelen,
 =09=09=09     size_t prelen, const char *post,
-=09=09=09     struct dentry **ret)
+=09=09=09     struct dentry **ret, bool drop_negative)
 {
 =09struct dentry *this;
 =09int err;
 =09bool last_element =3D !post[0];
=20
-=09this =3D lookup_positive_unlocked(name, base, namelen);
+=09if (drop_negative)
+=09=09this =3D ovl_lookup_positive_unlocked(name, base, namelen);
+=09else
+=09=09this =3D lookup_positive_unlocked(name, base, namelen);
+
 =09if (IS_ERR(this)) {
 =09=09err =3D PTR_ERR(this);
 =09=09this =3D NULL;
@@ -276,7 +306,7 @@ static int ovl_lookup_single(struct dentry *base, struc=
t ovl_lookup_data *d,
 }
=20
 static int ovl_lookup_layer(struct dentry *base, struct ovl_lookup_data *d=
,
-=09=09=09    struct dentry **ret)
+=09=09=09    struct dentry **ret, bool drop_negative)
 {
 =09/* Counting down from the end, since the prefix can change */
 =09size_t rem =3D d->name.len - 1;
@@ -285,7 +315,7 @@ static int ovl_lookup_layer(struct dentry *base, struct=
 ovl_lookup_data *d,
=20
 =09if (d->name.name[0] !=3D '/')
 =09=09return ovl_lookup_single(base, d, d->name.name, d->name.len,
-=09=09=09=09=09 0, "", ret);
+=09=09=09=09=09 0, "", ret, drop_negative);
=20
 =09while (!IS_ERR_OR_NULL(base) && d_can_lookup(base)) {
 =09=09const char *s =3D d->name.name + d->name.len - rem;
@@ -298,7 +328,8 @@ static int ovl_lookup_layer(struct dentry *base, struct=
 ovl_lookup_data *d,
 =09=09=09return -EIO;
=20
 =09=09err =3D ovl_lookup_single(base, d, s, thislen,
-=09=09=09=09=09d->name.len - rem, next, &base);
+=09=09=09=09=09d->name.len - rem, next, &base,
+=09=09=09=09=09drop_negative);
 =09=09dput(dentry);
 =09=09if (err)
 =09=09=09return err;
@@ -830,7 +861,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct den=
try *dentry,
 =09old_cred =3D ovl_override_creds(dentry->d_sb);
 =09upperdir =3D ovl_dentry_upper(dentry->d_parent);
 =09if (upperdir) {
-=09=09err =3D ovl_lookup_layer(upperdir, &d, &upperdentry);
+=09=09err =3D ovl_lookup_layer(upperdir, &d, &upperdentry, true);
 =09=09if (err)
 =09=09=09goto out;
=20
@@ -888,7 +919,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct den=
try *dentry,
 =09=09else
 =09=09=09d.last =3D lower.layer->idx =3D=3D roe->numlower;
=20
-=09=09err =3D ovl_lookup_layer(lower.dentry, &d, &this);
+=09=09err =3D ovl_lookup_layer(lower.dentry, &d, &this, false);
 =09=09if (err)
 =09=09=09goto out_put;
=20
--=20
2.20.1


