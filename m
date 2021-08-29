Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE43FAC35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhH2O0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 10:26:31 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:37668 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhH2O0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:26:30 -0400
Date:   Sun, 29 Aug 2021 14:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630247135;
        bh=YG8R2lj7hNDf9dFC05ixiyKNpU3QOqRKAT/LdALOKyk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=oPF+xMi+YduXw1Es3a0QYiaJU8i0PSpzEbGcxSuPjtShb6s5guKryiFWdyC1knTUX
         rG/zzBf/rueySmtzMKeqqUTPmegG+n5IHhNOtoaLMg9yIAUtfqc7/HN9+C2U5fovI5
         iuu5RQvA8Cr9/0ifIX3ddQvbT54JBcZRlDmeLdME=
To:     hirofumi@mail.parknet.co.jp
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [PATCH 1/3] fat: define functions and data structures for a formatted name cache
Message-ID: <20210829142459.56081-2-calebdsb@protonmail.com>
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

Define the functions and data structures to use as a name formatting
cache for msdos, using the generic Linux hashtable.

Signed-off-by: Caleb D.S. Brzezinski <calebdsb@protonmail.com>
---
 fs/fat/namei_msdos.c | 96 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index efba301d6..7561674b1 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -9,12 +9,108 @@
=20
 #include <linux/module.h>
 #include <linux/iversion.h>
+#include <linux/types.h>
+#include <linux/hashtable.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
 #include "fat.h"
=20
 /* Characters that are undesirable in an MS-DOS file name */
 static unsigned char bad_chars[] =3D "*?<>|\"";
 static unsigned char bad_if_strict[] =3D "+=3D,; ";
=20
+
+/**
+ * struct msdos_name_node - A formatted filename cache node
+ * @fname: the formatted filename
+ * @gc: a use counter for removing non-frequently used names
+ * @hash: the key for the item in the hash table
+ * @h_list: the list to the next set of values in this node's bucket
+ */
+struct msdos_name_node {
+=09u16 gc;
+=09char fname[9];
+=09u64 hash;
+=09struct hlist_node h_list;
+};
+
+DEFINE_HASHTABLE(msdos_ncache, 6);
+DEFINE_MUTEX(msdos_ncache_mutex); /* protect the name cache */
+
+/**
+ * msdos_fname_hash() - quickly "hash" an msdos filename
+ * @name: the name to hash, assumed to be a maximum of eight characters
+ *
+ * Bitwise-or the characters in an msdos filename into a simple "hash" tha=
t can
+ * be used as a fast hash for an msdos filename.
+ */
+static u64 msdos_fname_hash(const unsigned char *name)
+{
+=09u64 res =3D 0;
+=09short i;
+
+=09for (i =3D 0; i < 8 && name[i] !=3D '\0'; i++)
+=09=09res |=3D (u64)(name[i] << (8 * i));
+
+=09return res;
+}
+
+/**
+ * find_fname_in_cache() - retrieve a filename from the cache given a hash
+ * @out: the result buffer for the filename
+ * @ihash: the hash to check for
+ */
+static bool find_fname_in_cache(char *out, u64 ihash)
+{
+=09struct msdos_name_node *node;
+=09bool found =3D false;
+
+=09mutex_lock(&msdos_ncache_mutex);
+=09hash_for_each_possible(msdos_ncache, node, h_list, ihash) {
+=09=09if (node->hash =3D=3D ihash) {
+=09=09=09strscpy(out, node->fname, 9);
+=09=09=09found =3D true;
+=09=09=09node->gc++;
+=09=09=09goto out;
+=09=09}
+=09}
+
+out:
+=09mutex_unlock(&msdos_ncache_mutex);
+=09return found;
+}
+
+/**
+ * drop_fname_from_cache() - delete and free a filename from the hash entr=
y
+ * @ihash: the hash to remove from the cache
+ */
+static void drop_fname_from_cache(u64 ihash)
+{
+=09struct msdos_name_node *node, *gc;
+
+=09gc =3D NULL;
+
+=09mutex_lock(&msdos_ncache_mutex);
+=09hash_for_each_possible(msdos_ncache, node, h_list, ihash) {
+=09=09if (unlikely(gc)) {
+=09=09=09hash_del(&gc->h_list);
+=09=09=09kfree(gc);
+=09=09=09gc =3D NULL;
+=09=09}
+=09=09if (node->hash =3D=3D ihash) {
+=09=09=09hash_del(&node->h_list);
+=09=09=09kfree(node);
+=09=09=09goto out;
+=09=09}
+=09=09/* if we don't find it, collect unused nodes until we do */
+=09=09if (node->gc < 4)
+=09=09=09gc =3D node;
+=09}
+
+out:
+=09mutex_unlock(&msdos_ncache_mutex);
+}
+
 /***** Formats an MS-DOS file name. Rejects invalid names. */
 static int msdos_format_name(const unsigned char *name, int len,
 =09=09=09     unsigned char *res, struct fat_mount_options *opts)

base-commit: 85a90500f9a1717c4e142ce92e6c1cb1a339ec78
--=20
2.32.0


