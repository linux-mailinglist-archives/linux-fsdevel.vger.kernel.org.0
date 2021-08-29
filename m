Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2108A3FAC33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhH2O03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 10:26:29 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:53563 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhH2O02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:26:28 -0400
Date:   Sun, 29 Aug 2021 14:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630247133;
        bh=3jIk8vFnQvp8iFcc48aB3sbtDXdur4ozm8qwmJ5E3H4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rn/qSL4BH0Uwir6bVkqSPSsGNnlNswznMEc9fI1wqAffH+X0N3rlWFBZCr1GIRUo2
         ep7LaOmPlgJAwLPuPAdqHW74sAHSN4ID3kqQuO3N1GQJoV4FnFqYybK9J1Es/MiLDv
         w78vvAUhZsZlp9sjGuBhTkushumbc6Wz5y7ew28c=
To:     hirofumi@mail.parknet.co.jp
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [PATCH 2/3] fat: add the msdos_format_name() filename cache
Message-ID: <20210829142459.56081-3-calebdsb@protonmail.com>
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

Implement the main msdos_format_name() filename cache. If used as a
module, all memory allocated for the cache is freed when the module is
de-registered.

Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
---
 fs/fat/namei_msdos.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 7561674b1..f9d4f63c3 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -124,6 +124,16 @@ static int msdos_format_name(const unsigned char *name=
, int len,
 =09unsigned char *walk;
 =09unsigned char c;
 =09int space;
+=09u64 hash;
+=09struct msdos_name_node *node;
+
+=09/* check if the name is already in the cache */
+
+=09hash =3D msdos_fname_hash(name);
+=09if (find_fname_in_cache(res, hash))
+=09=09return 0;
+
+=09/* The node wasn't in the cache, so format it normally */
=20
 =09if (name[0] =3D=3D '.') {=09/* dotfile because . and .. already done */
 =09=09if (opts->dotsOK) {
@@ -208,6 +218,18 @@ static int msdos_format_name(const unsigned char *name=
, int len,
 =09while (walk - res < MSDOS_NAME)
 =09=09*walk++ =3D ' ';
=20
+=09/* allocate memory now */
+=09node =3D kmalloc(sizeof(*node), GFP_KERNEL);
+=09if (!node)
+=09=09return -ENOMEM;
+
+=09/* fill in the name cache */
+=09node->hash =3D hash;
+=09strscpy(node->fname, res, 9);
+=09mutex_lock(&msdos_ncache_mutex);
+=09hash_add(msdos_ncache, &node->h_list, node->hash);
+=09mutex_unlock(&msdos_ncache_mutex);
+
 =09return 0;
 }
=20
@@ -677,6 +699,7 @@ static int do_msdos_rename(struct inode *old_dir, unsig=
ned char *old_name,
 =09=09 * shouldn't be serious corruption.
 =09=09 */
 =09=09int err2 =3D fat_remove_entries(new_dir, &sinfo);
+
 =09=09if (corrupt)
 =09=09=09corrupt |=3D err2;
 =09=09sinfo.bh =3D NULL;
@@ -774,6 +797,18 @@ static int __init init_msdos_fs(void)
=20
 static void __exit exit_msdos_fs(void)
 {
+=09int bkt;
+=09struct msdos_name_node *c, *prev;
+
+=09prev =3D NULL;
+=09/* do this one behind to prevent bad memory access */
+=09hash_for_each(msdos_ncache, bkt, c, h_list) {
+=09=09kfree(prev);
+=09=09prev =3D c;
+=09}
+
+=09kfree(prev);
+
 =09unregister_filesystem(&msdos_fs_type);
 }
=20
--=20
2.32.0


