Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850B1D4733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEOHhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:45 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21124 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgEOHhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527299; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=n1eBuVrwjc4BmFjdQ8ip9YJlxNNX8Mn8AwfRxi0ehJeOIRar5kM3BR5GKUIhyHwWcvN/GAungBOHZp9jGRFRplo3nApykVV/TJYs6EiWEWJDbxKtjtNRu1dG2B1xT7N7Dny5KeqcEFW890RXCSdzZc1SIwPj55NZE0hLfTOGHv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527299; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sq2MLgVY639o58c+VGRyEL7rhnnN3J1QbY59fuoMlZA=; 
        b=YrYdQfaoTcUw0fyiY6zdB1nlCY+gjwiRacmfBbzQOxovEqS6VC10ID5PhRohYRVPzGnEhsdNomu3DAfY7keX1t5+SowOkGSmP/Q1B+gNL8WTlylSkdBdv1ZNmDrXDsH4BXkBOejZs4gP6uejCDzEMbKCQ5RlYZI+7Cn5qAeNfPQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527299;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=sq2MLgVY639o58c+VGRyEL7rhnnN3J1QbY59fuoMlZA=;
        b=YWELHkijjMX4BMfx7qcLpquP2FvS+U+AT/iKrDMDZIJWLHvOS33/smHI+c1pH4/q
        EHUphyn0uR5TD3FZV7Ez7WA0IpH44zTnTkDTTYrSoJI5XbnkG6KrKGWa4EIxfrDvdBC
        Wj54stgAPxvPjVdgHfFuNWhiZ8TUtt8VdAS0S3gc=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527297143225.7718494253087; Fri, 15 May 2020 15:21:37 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-2-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 1/9] fs/dcache: Introduce a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
Date:   Fri, 15 May 2020 15:20:39 +0800
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

Introduce a new lookup flag LOOKUP_DONTCACHE_NEGATIVE to skip
caching negative dentry in lookup.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/namei.c            | 14 ++++++++++----
 include/linux/namei.h |  9 +++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..a258f0a1d5d6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1532,6 +1532,9 @@ static struct dentry *__lookup_slow(const struct qstr=
 *name,
 =09=09if (unlikely(old)) {
 =09=09=09dput(dentry);
 =09=09=09dentry =3D old;
+=09=09} else if ((flags & LOOKUP_DONTCACHE_NEGATIVE) &&
+=09=09=09   d_is_negative(dentry)) {
+=09=09=09d_drop(dentry);
 =09=09}
 =09}
 =09return dentry;
@@ -2554,6 +2557,7 @@ EXPORT_SYMBOL(lookup_one_len);
  * @name:=09pathname component to lookup
  * @base:=09base directory to lookup from
  * @len:=09maximum length @len should be interpreted to
+ * @flags:=09lookup flags
  *
  * Note that this routine is purely a helper for filesystem usage and shou=
ld
  * not be called by generic code.
@@ -2562,7 +2566,8 @@ EXPORT_SYMBOL(lookup_one_len);
  * i_mutex held, and will take the i_mutex itself if necessary.
  */
 struct dentry *lookup_one_len_unlocked(const char *name,
-=09=09=09=09       struct dentry *base, int len)
+=09=09=09=09       struct dentry *base, int len,
+=09=09=09=09       unsigned int flags)
 {
 =09struct qstr this;
 =09int err;
@@ -2574,7 +2579,7 @@ struct dentry *lookup_one_len_unlocked(const char *na=
me,
=20
 =09ret =3D lookup_dcache(&this, base, 0);
 =09if (!ret)
-=09=09ret =3D lookup_slow(&this, base, 0);
+=09=09ret =3D lookup_slow(&this, base, flags);
 =09return ret;
 }
 EXPORT_SYMBOL(lookup_one_len_unlocked);
@@ -2588,9 +2593,10 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
  * this one avoids such problems.
  */
 struct dentry *lookup_positive_unlocked(const char *name,
-=09=09=09=09       struct dentry *base, int len)
+=09=09=09=09       struct dentry *base, int len,
+=09=09=09=09       unsigned int flags)
 {
-=09struct dentry *ret =3D lookup_one_len_unlocked(name, base, len);
+=09struct dentry *ret =3D lookup_one_len_unlocked(name, base, len, flags);
 =09if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) =
{
 =09=09dput(ret);
 =09=09ret =3D ERR_PTR(-ENOENT);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..1d43fc481e47 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
=20
+/* Hint: don't cache negative. */
+#define LOOKUP_DONTCACHE_NEGATIVE=090x200000
+
 extern int path_pts(struct path *path);
=20
 extern int user_path_at_empty(int, const char __user *, unsigned, struct p=
ath *, int *empty);
@@ -68,8 +71,10 @@ extern struct dentry *kern_path_locked(const char *, str=
uct path *);
=20
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, in=
t);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry =
*, int);
-extern struct dentry *lookup_positive_unlocked(const char *, struct dentry=
 *, int);
+extern struct dentry *lookup_one_len_unlocked(const char *name,
+=09=09=09struct dentry *base, int len, unsigned int flags);
+extern struct dentry *lookup_positive_unlocked(const char *name,
+=09=09=09struct dentry *base, int len, unsigned int flags);
=20
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
--=20
2.20.1


