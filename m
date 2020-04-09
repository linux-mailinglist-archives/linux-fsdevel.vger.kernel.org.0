Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84031A2CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIAcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 20:32:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:55026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgDIAcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:32:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 018D5AC59;
        Thu,  9 Apr 2020 00:32:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 09 Apr 2020 10:32:26 +1000
Cc:     hch@lst.de, viro@zeniv.linux.org.uk,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
In-Reply-To: <20200109133045.382356-3-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com> <20200109133045.382356-3-cmaiolino@redhat.com>
Message-ID: <87tv1tv6qt.fsf@notabene.neil.brown.name>
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

On Thu, Jan 09 2020, Carlos Maiolino wrote:

> Replace the direct usage of ->bmap method by a bmap() call.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 44a3ce1e4ce4..1dc97f2d6201 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -396,7 +396,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retr=
ieval *op,
>  	struct cachefiles_object *object;
>  	struct cachefiles_cache *cache;
>  	struct inode *inode;
> -	sector_t block0, block;
> +	sector_t block;
>  	unsigned shift;
>  	int ret;
>=20=20
> @@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retr=
ieval *op,
>=20=20
>  	inode =3D d_backing_inode(object->backer);
>  	ASSERT(S_ISREG(inode->i_mode));
> -	ASSERT(inode->i_mapping->a_ops->bmap);
>  	ASSERT(inode->i_mapping->a_ops->readpages);
>=20=20
>  	/* calculate the shift required to use bmap */
> @@ -428,12 +427,14 @@ int cachefiles_read_or_alloc_page(struct fscache_re=
trieval *op,
>  	 *   enough for this as it doesn't indicate errors, but it's all we've
>  	 *   got for the moment
>  	 */
> -	block0 =3D page->index;
> -	block0 <<=3D shift;
> +	block =3D page->index;
> +	block <<=3D shift;
> +
> +	ret =3D bmap(inode, &block);
> +	ASSERT(ret < 0);
>=20=20
> -	block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
>  	_debug("%llx -> %llx",
> -	       (unsigned long long) block0,
> +	       (unsigned long long) (page->index << shift),
>  	       (unsigned long long) block);
>=20=20
>  	if (block) {
> @@ -711,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_ret=
rieval *op,
>=20=20
>  	inode =3D d_backing_inode(object->backer);
>  	ASSERT(S_ISREG(inode->i_mode));
> -	ASSERT(inode->i_mapping->a_ops->bmap);
>  	ASSERT(inode->i_mapping->a_ops->readpages);
>=20=20
>  	/* calculate the shift required to use bmap */
> @@ -728,7 +728,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_ret=
rieval *op,
>=20=20
>  	ret =3D space ? -ENODATA : -ENOBUFS;
>  	list_for_each_entry_safe(page, _n, pages, lru) {
> -		sector_t block0, block;
> +		sector_t block;
>=20=20
>  		/* we assume the absence or presence of the first block is a
>  		 * good enough indication for the page as a whole
> @@ -736,13 +736,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_r=
etrieval *op,
>  		 *   good enough for this as it doesn't indicate errors, but
>  		 *   it's all we've got for the moment
>  		 */
> -		block0 =3D page->index;
> -		block0 <<=3D shift;
> +		block =3D page->index;
> +		block <<=3D shift;
> +
> +		ret =3D bmap(inode, &block);
> +		ASSERT(!ret);

Hi,
 this change corrupts 'ret'.
 Some paths from here down change ret, but some paths to do not.
 So it is possible that this function would previously return -ENODATA
 or -ENOBUFS, but now it returns 0.

 This gets caught by a BUG_ON in __nfs_readpages_from_fscache().

 Maybe a new variable should be introduced?
 or maybe ASSERT(!bmap(..));
 Or maybe if (bmap() !=3D 0) ASSET(0);

??

https://bugzilla.opensuse.org/show_bug.cgi?id=3D1168841

NeilBrown


>=20=20
> -		block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping,
> -						      block0);
>  		_debug("%llx -> %llx",
> -		       (unsigned long long) block0,
> +		       (unsigned long long) (page->index << shift),
>  		       (unsigned long long) block);
>=20=20
>  		if (block) {
> --=20
> 2.23.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6ObRoACgkQOeye3VZi
gbm66A/7BxY82aENbHV4IuB1n741i12ZU0HDe13Oi+4qfiYq2KiB/s83gfijGzEB
i05DIh1vUeWjkhoau9Bdxc7zagI1z8ohg0pBrsT1rhOf/5bjsClorecUmzqTi0UH
IS41lp3TMwEYOpiiGlxhI2zpg2MWgb7KeXh9RY2ZQGX7L+qtnBaIBN8ZQU3Rk7fa
FObaj3taRVRugdwxvl2vTYFIMm6tiIs7dwfe53xNpoM87Yj+AmhSQYAxSKMw/Qoe
xc6BwB07DH8XUA4qVLOk4X2qKjg2aTk0VNF5M2K7QmNjmnXsWErLrvshuqN+Ueie
6unRDrz2wOCHxBkSfcdTSvyKBeC9WwUs4q6btJQn8mfUl+r72sMrtqImNGs0GvVU
zEiwy/fPh4+QJLGPEylUV1DStVXIc6LTnclZF3dwUXCFQUbPeotLJJDm1fLz+GU8
y5kB2NhYM+OzGm47REq3zkTS0daWtlCa+HSYNKj+MaODo2k0ZR2E2Bn9RKen9By5
K9jpKEWZ4JJ6tNsm4ClTCd3N1wNC/8upuAKlggGWPTtWRx09aCtuAooOnh8M2ZIp
lQG3Le2CiSr4oJGgirfB5H1LEm0fDxXOD3Emnne7p7neiU0Qfw5Igrek1dY1pXr5
dbz3WJcxtnhHoaealqSbfe7KwZ+60qyyzmZzCMYAS/thEFu0JVA=
=G5HJ
-----END PGP SIGNATURE-----
--=-=-=--
