Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0074C1D4731
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEOHhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:41 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21141 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgEOHhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527301; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cOnPC6fo2pU/14DZwyXaDeYoiRUQrAxx2ja8b9431JEwsOUmKIEB5cjhUWGkN0hcrHPZ74+61N8TtRORNiJdRowI4cOTHZnElFaGR5xrGhuMSTGGgZ8vWucPL2Typg819PV3r2FTKaREPPnnMuFRXH0EQ+oeHp5F/U+SsaeOVfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527301; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=N1RZID6HG/6fot9+I2ZQQxKOoFGvRFyHHKntpnHYIUc=; 
        b=UiQLdbjsx7YGkV7qZpSk+5G7g+eMmR6L5at7jgAIsL3RRBy8t2fOGWYM++0gIw4fiOZuvyCiV3qrmwvCtg8okR+aQk3Kt8iWKJ2S1kGNWkezgzli/MpR99sPXc4qqyXvjl3A9sWJ4KkIZdCIooDgQgradw/N1j0GUmbBWvr0+MY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527301;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=N1RZID6HG/6fot9+I2ZQQxKOoFGvRFyHHKntpnHYIUc=;
        b=LVIrd5Z3Svfc1a42JPnvPQ6UpAxzM6ogujl6Hz3NoUx/hPROVhEbAwGcpnADjCcv
        RKxIi6z1E32txH18EZOc5P9E+DOKMxGO+eJSqF8AGZIJo5nbDBrwsmKI08VezUT/qys
        u8/KZTDujliEjX0Wj3/urkZEoKNbe0eIsOZeJKEU=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527298900169.1720668233885; Fri, 15 May 2020 15:21:38 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-3-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 2/9] ovl: Suppress negative dentry in lookup
Date:   Fri, 15 May 2020 15:20:40 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515072047.31454-1-cgxu519@mykernel.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to reduce useless negative dentries in upper/lower
layers, specify LOOKUP_DONTCACHE_NEGATIVE flag in lookup
so that we can drop negative dentries which generated in
slow path of lookup.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/namei.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 0db23baf98e7..a400a7d126bd 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -200,7 +200,8 @@ static int ovl_lookup_single(struct dentry *base, struc=
t ovl_lookup_data *d,
 =09int err;
 =09bool last_element =3D !post[0];
=20
-=09this =3D lookup_positive_unlocked(name, base, namelen);
+=09this =3D lookup_positive_unlocked(name, base, namelen,
+=09=09=09=09=09LOOKUP_DONTCACHE_NEGATIVE);
 =09if (IS_ERR(this)) {
 =09=09err =3D PTR_ERR(this);
 =09=09this =3D NULL;
@@ -657,7 +658,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, str=
uct ovl_fh *fh)
 =09if (err)
 =09=09return ERR_PTR(err);
=20
-=09index =3D lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+=09index =3D lookup_positive_unlocked(name.name, ofs->indexdir, name.len, =
0);
 =09kfree(name.name);
 =09if (IS_ERR(index)) {
 =09=09if (PTR_ERR(index) =3D=3D -ENOENT)
@@ -689,7 +690,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, str=
uct dentry *upper,
 =09if (err)
 =09=09return ERR_PTR(err);
=20
-=09index =3D lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+=09index =3D lookup_positive_unlocked(name.name, ofs->indexdir, name.len, =
0);
 =09if (IS_ERR(index)) {
 =09=09err =3D PTR_ERR(index);
 =09=09if (err =3D=3D -ENOENT) {
@@ -1137,7 +1138,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 =09=09struct dentry *lowerdir =3D poe->lowerstack[i].dentry;
=20
 =09=09this =3D lookup_positive_unlocked(name->name, lowerdir,
-=09=09=09=09=09       name->len);
+=09=09=09=09=09       name->len, 0);
 =09=09if (IS_ERR(this)) {
 =09=09=09switch (PTR_ERR(this)) {
 =09=09=09case -ENOENT:
--=20
2.20.1


