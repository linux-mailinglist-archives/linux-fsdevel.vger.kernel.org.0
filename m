Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BB1BB1EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 01:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgD0XPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 19:15:47 -0400
Received: from ozlabs.org ([203.11.71.1]:59497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD0XPq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:15:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49B0xq52hqz9sSM;
        Tue, 28 Apr 2020 09:15:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588029345;
        bh=QGS592o8TX+oMsFhlmZMFO1sk9/cx8P2I4E89RL9NPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RimoSeODjsZ4ZSlbPDlEORr7jLASPEC8PK8EKpkzN3VROWcBb1BuqivQ+PvMkk5Fx
         c2Zlx5IrxrkoSYHAkm29hIxrIF/utPIGwZRqwZLrplBDIVWXfQ30WMabA3asj9Kx/q
         cpEDa9g0oS+4xcZkOkxMFJNmnsbmIztG5JeGPQCHYr64IgtqulxedP4LjJUT0ZXqEW
         khLCPYuelviEn86o0jB+RI4XYJ2xI9kV89nCTa8YEmmeOMsb9D/BpM+O/XCzobIrCM
         mZYQu3eA0+OT12y6kCKYhKceFtdWLouHoSKNwABwk9E9bpVHCOXEK/m2YeeHZ/YwhF
         KcDfXPZmXsInQ==
Date:   Tue, 28 Apr 2020 09:15:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
Message-ID: <20200428091541.11a76842@canb.auug.org.au>
In-Reply-To: <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
        <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
        <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kEb1YgG2a_Z4lPw0OTAPKMs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/kEb1YgG2a_Z4lPw0OTAPKMs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 26 Apr 2020 15:48:35 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> I had to add 2 small patches to have clean madvise.c builds:
>=20
>=20
> ---
>  include/linux/syscalls.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --- mmotm-2020-0426-0015.orig/include/linux/syscalls.h
> +++ mmotm-2020-0426-0015/include/linux/syscalls.h
> @@ -876,9 +876,9 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>  				unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavio=
r);
> -
> -asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long =
start,
> -			size_t len, int behavior, unsigned long flags);
> +asmlinkage long sys_process_madvise(int which, pid_t upid,
> +		const struct iovec __user *vec, unsigned long vlen,
> +		int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long =
size,
>  			unsigned long prot, unsigned long pgoff,
>  			unsigned long flags);
>=20
> ---
> and
> ---
>  mm/madvise.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- mmotm-2020-0426-0015.orig/mm/madvise.c
> +++ mmotm-2020-0426-0015/mm/madvise.c
> @@ -23,12 +23,14 @@
>  #include <linux/file.h>
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
> +#include <linux/compat.h>
>  #include <linux/pagewalk.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/sched/mm.h>
> +#include <linux/uio.h>
> =20
>  #include <asm/tlb.h>
> =20

I added these to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kEb1YgG2a_Z4lPw0OTAPKMs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nZ50ACgkQAVBC80lX
0GzxRgf/cn1bQid+s9ZN47vRnVY54DRjmaT0XLrOgpkqI5+IWBMZLZh3StmgNuZ8
i6ejr6aFen3T8NKqIyVH1ptV+5T3ksYOUTRtB9NmcBLRD4xzHuqlpQT87QV0EekC
u7x8Xf1Zr9gDVdPY9xOaDz0wuoB6VTF0URwQR9AeUL8WkaohphFVpTgqJ0A8Dgiv
VpUz/TKxkhKMUYvJ+ww8GL7r6tytsz91ffOvHYOZLv5lr0bQoXCgKRbic4zZ8ei/
nqGjCQgWNMJ3sHsG/Gv96dRbYVRcYV30OafuEe5/TAzFRH0yJa6glNS9p2EDSqk7
KUlcFqqZk6rSViAbocXrmmUbdpo0/A==
=W3xj
-----END PGP SIGNATURE-----

--Sig_/kEb1YgG2a_Z4lPw0OTAPKMs--
