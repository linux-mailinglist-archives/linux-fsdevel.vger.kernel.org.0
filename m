Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3564702EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbhLJOkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 09:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242209AbhLJOkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639147000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jWKu+fTBFJcT/HgMEzu6APh752fKYh1kEvLz4HhKOI=;
        b=Ax+CITMDqhXxSP8rt6ISjbe1SwiLOpvLny2d6DLHsMLo6YcIgawTRUSDNYT/X8CIDXDoED
        eHN+bIH4EygEb95Ij6dMVkwM5b6VnLec/w2ecdp2CffWTmZDOUFjO3Dr2SauFFgNoYi0nO
        1pb2iI1aCoeSMG0mgeY+5nX5ScT0daM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-bJd98xMGPKSZIQ3ttcegtA-1; Fri, 10 Dec 2021 09:36:35 -0500
X-MC-Unique: bJd98xMGPKSZIQ3ttcegtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B04874993;
        Fri, 10 Dec 2021 14:36:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6223F10016F7;
        Fri, 10 Dec 2021 14:36:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com>
References: <CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com> <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk> <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk> <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com> <159180.1639087053@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <288129.1639146959.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 10 Dec 2021 14:35:59 +0000
Message-ID: <288130.1639146959@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > What I'm trying to get at is that the hash needs to be consistent, no =
matter
> > the endianness of the cpu, for any particular input blob.
> =

> Yeah, if that's the case, then you should probably make that "unsigned
> int *data" argument probably just be "void *" and then:
> =

> >                 a =3D *data++;   <<<<<<<
> >                 HASH_MIX(x, y, a);
> >         }
> >         return fold_hash(x, y);
> > }
> >
> > The marked line should probably use something like le/be32_to_cpu().
> =

> Yes, it should be using a '__le32 *' inside that function and you
> should use l32_to_cpu(). Obviously, BE would work too, but cause
> unnecessary work on common hardware.

Okay, how about I make the attached change to make the hashing stable?  Th=
is
will make fscache_hash() take an opaque buffer and a length (the length mu=
st
be a multiple of four).

David
---
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index e287952292c5..65cf2ae22a70 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -269,22 +269,23 @@ EXPORT_SYMBOL(fscache_caching_failed);
 static int fscache_set_key(struct fscache_cookie *cookie,
 			   const void *index_key, size_t index_key_len)
 {
-	u32 *buf;
-	int bufs;
+	void *buf;
+	size_t buf_size;
 =

-	bufs =3D DIV_ROUND_UP(index_key_len, sizeof(*buf));
+	buf_size =3D round_up(index_key_len, sizeof(__le32));
 =

 	if (index_key_len > sizeof(cookie->inline_key)) {
-		buf =3D kcalloc(bufs, sizeof(*buf), GFP_KERNEL);
+		buf =3D kzalloc(buf_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 		cookie->key =3D buf;
 	} else {
-		buf =3D (u32 *)cookie->inline_key;
+		buf =3D cookie->inline_key;
 	}
 =

 	memcpy(buf, index_key, index_key_len);
-	cookie->key_hash =3D fscache_hash(cookie->volume->key_hash, buf, bufs);
+	cookie->key_hash =3D fscache_hash(cookie->volume->key_hash,
+					buf, buf_size);
 	return 0;
 }
 =

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 87884f4b34fb..f121c21590dc 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -86,7 +86,7 @@ static inline void fscache_end_operation(struct netfs_ca=
che_resources *cres)
  */
 extern unsigned fscache_debug;
 =

-extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, u=
nsigned int n);
+extern unsigned int fscache_hash(unsigned int salt, const void *data, siz=
e_t len);
 =

 /*
  * proc.c
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 01d57433702c..dad85fd84f6f 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -53,15 +53,16 @@ static inline unsigned int fold_hash(unsigned long x, =
unsigned long y)
 /*
  * Generate a hash.  This is derived from full_name_hash(), but we want t=
o be
  * sure it is arch independent and that it doesn't change as bits of the
- * computed hash value might appear on disk.  The caller also guarantees =
that
- * the hashed data will be a series of aligned 32-bit words.
+ * computed hash value might appear on disk.  The caller must guarantee t=
hat
+ * the source data is a multiple of four bytes in size.
  */
-unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned=
 int n)
+unsigned int fscache_hash(unsigned int salt, const void *data, size_t len=
)
 {
-	unsigned int a, x =3D 0, y =3D salt;
+	const __le32 *p =3D data;
+	unsigned int a, x =3D 0, y =3D salt, n =3D len / sizeof(__le32);
 =

 	for (; n; n--) {
-		a =3D *data++;
+		a =3D le32_to_cpu(*p++);
 		HASH_MIX(x, y, a);
 	}
 	return fold_hash(x, y);
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index edd3c245010e..26a6b8f315e1 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -131,7 +131,7 @@ static long fscache_compare_volume(const struct fscach=
e_volume *a,
 	if (a->key[0] !=3D b->key[0])
 		return (long)a->key[0]   - (long)b->key[0];
 =

-	klen =3D round_up(a->key[0] + 1, sizeof(unsigned int));
+	klen =3D round_up(a->key[0] + 1, sizeof(__le32));
 	return memcmp(a->key, b->key, klen);
 }
 =

@@ -225,7 +225,7 @@ static struct fscache_volume *fscache_alloc_volume(con=
st char *volume_key,
 	 * hashing easier.
 	 */
 	klen =3D strlen(volume_key);
-	hlen =3D round_up(1 + klen + 1, sizeof(unsigned int));
+	hlen =3D round_up(1 + klen + 1, sizeof(__le32));
 	key =3D kzalloc(hlen, GFP_KERNEL);
 	if (!key)
 		goto err_vol;
@@ -233,8 +233,7 @@ static struct fscache_volume *fscache_alloc_volume(con=
st char *volume_key,
 	memcpy(key + 1, volume_key, klen);
 =

 	volume->key =3D key;
-	volume->key_hash =3D fscache_hash(0, (unsigned int *)key,
-					hlen / sizeof(unsigned int));
+	volume->key_hash =3D fscache_hash(0, key, hlen);
 =

 	volume->debug_id =3D atomic_inc_return(&fscache_volume_debug_id);
 	down_write(&fscache_addremove_sem);

