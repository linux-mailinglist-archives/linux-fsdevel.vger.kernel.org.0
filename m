Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2E3FAC37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhH2O0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 10:26:40 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:64573 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhH2O0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:26:40 -0400
Date:   Sun, 29 Aug 2021 14:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630247146;
        bh=APsD8X3kkExun9PFwsfB27e7AdmJUHcLP5xsAMo5oNQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=b4gM+EXYbOD4CbyZeGMC9SfQgUzesac4YAVoIrNrqI4B4TKzuq0K9w2Ly9PPaBABL
         kGBFngYHPe1UbTy4jq0TOtQmMH6okKg9IZwkcVIkG54BZkAbq3b09J18FE4vh3OoT7
         ajZZ4GRndYUGmDj+dsoOoBi5qbGjaTfevt4PezWA=
To:     hirofumi@mail.parknet.co.jp
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [PATCH 3/3] fat: add hash machinery to relevant filesystem operations
Message-ID: <20210829142459.56081-4-calebdsb@protonmail.com>
In-Reply-To: <20210829142459.56081-1-calebdsb@protonmail.com>
References: <20210829142459.56081-1-calebdsb@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add hash freeing functionality to the following functions which remove
or rename files:

msdos_rmdir()
msdos_unlink()
do_msdos_rename()

Whenever these functions are called, the memory associated with the
old, now obsolete filename is freed and dropped from the cache.

Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
---
 fs/fat/namei_msdos.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index f9d4f63c3..40a7d6df0 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -430,9 +430,11 @@ static int msdos_rmdir(struct inode *dir, struct dentr=
y *dentry)
 =09struct super_block *sb =3D dir->i_sb;
 =09struct inode *inode =3D d_inode(dentry);
 =09struct fat_slot_info sinfo;
+=09u64 hash;
 =09int err;
=20
 =09mutex_lock(&MSDOS_SB(sb)->s_lock);
+=09hash =3D msdos_fname_hash(dentry->d_name.name);
 =09err =3D fat_dir_empty(inode);
 =09if (err)
 =09=09goto out;
@@ -448,6 +450,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry=
 *dentry)
 =09clear_nlink(inode);
 =09fat_truncate_time(inode, NULL, S_CTIME);
 =09fat_detach(inode);
+=09drop_fname_from_cache(hash);
 out:
 =09mutex_unlock(&MSDOS_SB(sb)->s_lock);
 =09if (!err)
@@ -522,10 +525,12 @@ static int msdos_unlink(struct inode *dir, struct den=
try *dentry)
 =09struct inode *inode =3D d_inode(dentry);
 =09struct super_block *sb =3D inode->i_sb;
 =09struct fat_slot_info sinfo;
+=09u64 hash;
 =09int err;
=20
 =09mutex_lock(&MSDOS_SB(sb)->s_lock);
 =09err =3D msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo=
);
+=09hash =3D msdos_fname_hash(dentry->d_name.name);
 =09if (err)
 =09=09goto out;
=20
@@ -535,6 +540,8 @@ static int msdos_unlink(struct inode *dir, struct dentr=
y *dentry)
 =09clear_nlink(inode);
 =09fat_truncate_time(inode, NULL, S_CTIME);
 =09fat_detach(inode);
+=09drop_fname_from_cache(hash);
+
 out:
 =09mutex_unlock(&MSDOS_SB(sb)->s_lock);
 =09if (!err)
@@ -670,6 +677,8 @@ static int do_msdos_rename(struct inode *old_dir, unsig=
ned char *old_name,
 =09=09=09drop_nlink(new_inode);
 =09=09fat_truncate_time(new_inode, &ts, S_CTIME);
 =09}
+=09drop_fname_from_cache(msdos_fname_hash(old_name));
+
 out:
 =09brelse(sinfo.bh);
 =09brelse(dotdot_bh);
--=20
2.32.0


