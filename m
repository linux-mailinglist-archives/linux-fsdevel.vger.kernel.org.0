Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04024269EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIOGwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 02:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOGwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:52:51 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B84C06174A;
        Mon, 14 Sep 2020 23:52:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BrDSX3Y4hz9sTt;
        Tue, 15 Sep 2020 16:52:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1600152767;
        bh=oLv+gefylOKl1hPgdzpxeNDPXUSuR6jVuzzmhrFKEl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VZ6hXCC6fqJsSifUUlm1wdZm5D+TANsdS43Y4x0sOJc9pCp2UATae5y9/MK+Mb0sC
         dLmx+kT8wZyLmDy4qgz1b6y0QI1QrpAewmxBPwRSKQ2bU2HISfFUE5FvDjN8nf8zeC
         uIjxmtMBu//QkaJ1OIGACUA/tT8ZqS/4vaVuDiVFdz5oE/kNWSjYwmVNce1hJLqexp
         acCpHqMs4bYtdNDdRZKM7W3/bCGJa3nCyqFBFQJ5MKp8ZBD5RmPXMMFdxAXznxum18
         /BPCp/IHbhKE2/eGoDCjGhRP9vxi+Q9aI6n6O9vxyVApwdcm/UGG/fHkztre4qfpmq
         QzIYSef1TkgnA==
Date:   Tue, 15 Sep 2020 16:52:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        gandalf@winds.org, Qian Cai <cai@lca.pw>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: RIP:
 0010:shmem_getpage_gfp.isra.0+0x470/0x750
Message-ID: <20200915165243.58379eb7@canb.auug.org.au>
In-Reply-To: <20200914115559.GN6583@casper.infradead.org>
References: <CA+G9fYvmut-pJT-HsFRCxiEzOnkOjC8UcksX4v8jUvyLYeXTkQ@mail.gmail.com>
        <20200914115559.GN6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+f/cr_6nZV9WkBfA5oKpYEw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/+f/cr_6nZV9WkBfA5oKpYEw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 14 Sep 2020 12:55:59 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Sep 14, 2020 at 03:49:43PM +0530, Naresh Kamboju wrote:
> > While running LTP fs on qemu x86 and qemu_i386 these kernel BUGs notice=
d. =20
>=20
> I actually sent the fix for this a couple of days ago [1], but I think An=
drew
> overlooked it while constructing the -mm tree.  Here's a fix you can
> apply to the -mm tree:
>=20
> [1] https://lore.kernel.org/linux-mm/20200912032042.GA6583@casper.infrade=
ad.org/
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d2a46ef7df43..58bc9e326d0d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1793,7 +1793,7 @@ static int shmem_getpage_gfp(struct inode *inode, p=
goff_t index,
>  	struct mm_struct *charge_mm;
>  	struct page *page;
>  	enum sgp_type sgp_huge =3D sgp;
> -	pgoff_t hindex;
> +	pgoff_t hindex =3D index;
>  	int error;
>  	int once =3D 0;
>  	int alloced =3D 0;
> @@ -1822,6 +1822,8 @@ static int shmem_getpage_gfp(struct inode *inode, p=
goff_t index,
>  		return error;
>  	}
> =20
> +	if (page)
> +		hindex =3D page->index;
>  	if (page && sgp =3D=3D SGP_WRITE)
>  		mark_page_accessed(page);
> =20
> @@ -1832,6 +1834,7 @@ static int shmem_getpage_gfp(struct inode *inode, p=
goff_t index,
>  		unlock_page(page);
>  		put_page(page);
>  		page =3D NULL;
> +		hindex =3D index;
>  	}
>  	if (page || sgp =3D=3D SGP_READ)
>  		goto out;
> @@ -1982,7 +1985,7 @@ static int shmem_getpage_gfp(struct inode *inode, p=
goff_t index,
>  		goto unlock;
>  	}
>  out:
> -	*pagep =3D page + index - page->index;
> +	*pagep =3D page + index - hindex;
>  	return 0;
> =20
>  	/*

I have applied that to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+f/cr_6nZV9WkBfA5oKpYEw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9gZLsACgkQAVBC80lX
0Gz77AgAoAY+prsaroOSKRIkjh3sWJTHc7MQPNpYmYiPMNGzLSHmD36a6PTYgLp2
0NdVGWSG1fLLBeJ5AspWTpkWW3iNNK1i9lkrB0Pz+cQUOqDALueOZguP2hvqTsOY
cZZO7NWdKg6Ro8+vhRB871x6hyf6+ZyX09XttP+xFjrCe6NMm5+L97qkdB0FroIU
RhecVktBv7stSu9NVMm/Vp2HcG1o5ZfL92tJFRJOWeA5hIbccxNvmfCflOJP/MSV
UBxlb+d4uuV/IlwgDJCGwFmL5vkCETlvt1P2f3SKjSxSslRLQFAyC4gSmJDASsNQ
N4ArBRL4ZWZqTs8F/4j0ouw7I1SoPA==
=bre5
-----END PGP SIGNATURE-----

--Sig_/+f/cr_6nZV9WkBfA5oKpYEw--
