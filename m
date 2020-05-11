Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0D1CE836
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 00:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEKWiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 18:38:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgEKWiW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 18:38:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39062AD89;
        Mon, 11 May 2020 22:38:23 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Tue, 12 May 2020 08:38:10 +1000
Cc:     Lei Xue <carmark.dlut@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] cachefiles, nfs: Fixes
In-Reply-To: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
References: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
Message-ID: <87ftc6ayi5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, May 08 2020, David Howells wrote:

> Hi Linus, Trond, Anna,
>
> Can you pull these fixes for cachefiles and NFS's use of fscache?  Should
> they go through the NFS tree or directly upstream?  The things fixed are:

hi David,
thanks for these fscache fixes.  Here is another for your consideration.

NeilBrown


From: NeilBrown <neilb@suse.de>
Date: Tue, 12 May 2020 08:32:25 +1000
Subject: [PATCH] cachefiles: fix inverted ASSERTion.

bmap() returns a negative result precisely when a_ops->bmap is NULL.

A recent patch converted

       ASSERT(inode->i_mapping->a_ops->bmap);

to an assertion that bmap(inode, ...) returns a negative number.
This inverts the sense of the assertion.
So change it back : ASSERT(ret =3D=3D 0)

Fixes: 10d83e11a582 ("cachefiles: drop direct usage of ->bmap method.")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 1dc97f2d6201..a4573c96660c 100644
=2D-- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -431,7 +431,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrie=
val *op,
 	block <<=3D shift;
=20
 	ret =3D bmap(inode, &block);
=2D	ASSERT(ret < 0);
+	ASSERT(ret =3D=3D 0);
=20
 	_debug("%llx -> %llx",
 	       (unsigned long long) (page->index << shift),
=2D-=20
2.26.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6509IACgkQOeye3VZi
gbnDKQ/+MIO9eK9pP/A6zoofl4dfmmO2wUUM1+DX2Oh1H/8wxdkOM3q9WtX9xL7N
F3e7t1v3nGngJ0UqlXbO/Xu7j6dGCvj/m/nO1+1QlViPF5w0wYw+BJSr5fV/sXh+
ZOxnNEZTyoj8/xjc+5h76a8tuwV0XKbKfGvkZ+AVH8E3YqMhGuAj/5E+oGoA0ida
cCBs1rSWMXtYbcDAGcV6CoI4lHqMg62UPeX6fLush5nxDVu9wmQ3Gc0pSZ7lPNif
nA3e363xgE4BVpZOnc9NEKfnBa+dRKFed6Br+K+kGvaFhao7ntVePSaKW6R/S7gJ
H+yJpA5kAObGKsdF0KLHOFNeVZF+HfY4E/47Mwqboua5+1Y+REMnUa1TyYqK+TT3
c9jI4MpaJFOLWBsR8t+NVCcEpJSpoKoK2zp2UL+r9/LCwCuUOIjxV92D9BCnwPLT
QSG7pqfuHOnHkqugpjuQexljB+cYiklY+1KS6hxFNuktzL4i76EfISwj3wDRUHKd
PpIUmelidrqdo9YX9y/hxbhTFjxzJNhvVLRqDHjKTEaPTDdT68U3gqlJdbLl25NM
laUoAvufTQHsgNfTD1FKEVy2rsYkvJSOSRhP8OTykmLmGaAihgJhlnd4/O0uynqP
1OD3A8TD1oaCQOW2Y6uShEwcnd57Omhvj6Cvl26MwcIWXbx0KV4=
=shc0
-----END PGP SIGNATURE-----
--=-=-=--
