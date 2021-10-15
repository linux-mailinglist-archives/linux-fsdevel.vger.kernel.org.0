Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED3242EC3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhJOI2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhJOI2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:28:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465CC061780;
        Fri, 15 Oct 2021 01:25:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HVzpn3QD2z4xbY;
        Fri, 15 Oct 2021 19:25:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1634286306;
        bh=ozw+D1A4y7gQR95cCy5vM4UjVKHDo5E+WQ5xerze8M4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n7mqFg4AljvA4ZxLyaIAI4EUnIbKxPQ1Ly+mCdHR9rzeY33Pz0A0ZldcY20MGhHUo
         1Iy90NHvwxObULEeCX8xgPLdES7yJIeU3+WVKj0lmFyx/vpJ2nqBCuJiWWbhpfn3QR
         1Fh3iBmymRRGwNxb89Lo8OjLcFFjIjDSpUYuRu2EgEHCHk9xWIwfcf4gTLDSyckPlZ
         Nm7KwSNqzotO5ajA/6uLsQ5t96AmW3FJ07NL1MBfY/Jq0wAlgdlB/447iKNZSL45RR
         XX3LTxfctDWsoWFx2xykEntoelOCwLxS43yfnFy6Vt77P96is2wcTfupGfCz/tITfE
         24ncrNcsBg3FQ==
Date:   Fri, 15 Oct 2021 19:25:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, rdunlap@infradead.org,
        broonie@kernel.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: Include 'highmem.h' to fix a build
 failure
Message-ID: <20211015192503.023c189b@canb.auug.org.au>
In-Reply-To: <20211014110848.5204-1-sj@kernel.org>
References: <20211014110848.5204-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OB.PUmnGe.mA1FsdEHs9SKI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/OB.PUmnGe.mA1FsdEHs9SKI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 14 Oct 2021 11:08:48 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> Commit 0ff28922686c ("mm/damon/vaddr: separate commonly usable
> functions") in -mm tree[1] moves include of 'highmem.h' from 'vaddr.c'
> to 'prmtv-common.c', though the code for the header is still in
> 'vaddr.c'.  As a result, build with 'CONFIG_HIGHPTE' fails as below:
>=20
>     In file included from ../include/linux/mm.h:33:0,
>                       from ../include/linux/kallsyms.h:13,
>                       from ../include/linux/bpf.h:20,
>                       from ../include/linux/bpf-cgroup.h:5,
>                       from ../include/linux/cgroup-defs.h:22,
>                       from ../include/linux/cgroup.h:28,
>                       from ../include/linux/hugetlb.h:9,
>                       from ../mm/damon/vaddr.c:11:
>     ../mm/damon/vaddr.c: In function =E2=80=98damon_mkold_pmd_entry=E2=80=
=99:
>     ../include/linux/pgtable.h:97:12: error: implicit declaration of func=
tion =E2=80=98kmap_atomic=E2=80=99; did you mean =E2=80=98mcopy_atomic=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
>        ((pte_t *)kmap_atomic(pmd_page(*(dir))) +  \
>                  ^
>     ../include/linux/mm.h:2376:17: note: in expansion of macro =E2=80=98p=
te_offset_map=E2=80=99
>        pte_t *__pte =3D pte_offset_map(pmd, address); \
>                       ^~~~~~~~~~~~~~
>     ../mm/damon/vaddr.c:387:8: note: in expansion of macro =E2=80=98pte_o=
ffset_map_lock=E2=80=99
>        pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>              ^~~~~~~~~~~~~~~~~~~
>     ../include/linux/pgtable.h:99:24: error: implicit declaration of func=
tion =E2=80=98kunmap_atomic=E2=80=99; did you mean =E2=80=98in_atomic=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
>       #define pte_unmap(pte) kunmap_atomic((pte))
>                              ^
>     ../include/linux/mm.h:2384:2: note: in expansion of macro =E2=80=98pt=
e_unmap=E2=80=99
>        pte_unmap(pte);     \
>        ^~~~~~~~~
>     ../mm/damon/vaddr.c:392:2: note: in expansion of macro =E2=80=98pte_u=
nmap_unlock=E2=80=99
>        pte_unmap_unlock(pte, ptl);
>        ^~~~~~~~~~~~~~~~
>=20
> This commit fixes the issue by moving the include back to 'vaddr.c'.
>=20
> [1] https://github.com/hnaz/linux-mm/commit/0ff28922686c
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/prmtv-common.c | 1 -
>  mm/damon/vaddr.c        | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
> index 1768cbe1b9ff..7e62ee54fb54 100644
> --- a/mm/damon/prmtv-common.c
> +++ b/mm/damon/prmtv-common.c
> @@ -5,7 +5,6 @@
>   * Author: SeongJae Park <sj@kernel.org>
>   */
> =20
> -#include <linux/highmem.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
>  #include <linux/pagemap.h>
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index ce7e36ca1bff..758501b8d97d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt) "damon-va: " fmt
> =20
>  #include <asm-generic/mman-common.h>
> +#include <linux/highmem.h>
>  #include <linux/hugetlb.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
> --=20
> 2.17.1
>=20

Applied to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OB.PUmnGe.mA1FsdEHs9SKI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFpOt8ACgkQAVBC80lX
0GxBlAgAkbXUuju65ELwOZXSD/HE3V9/ljSnjWlDSbeZJHFJjJGT4Z6wxz9U7PiK
IDaMYR7OxnGZiShoJjWt5Wb3Pv2Y3R5MK+ofga+KbzOJjI16lGpdE4PdXqjPGuLS
5Di2Rtkwb9+7A4UPbN1V0yaGuiKze1mI9IhhGNXC9fohUDkYRV9s3hubLtfFFbvP
cXXdx150qZwzOYjtdXeFFF8xjvZk3SGvFjhEwmi25wD1r1iT1FBLaGBU334wdrvn
ZlksHLBwxcCgo/RmLOhgPepHXR8SOz3AQMr079vyXW0FtLOdZPqizzjCypeT05E7
2GrHJ6tByjD4PmLMng8kcjx7oIevbg==
=fpqB
-----END PGP SIGNATURE-----

--Sig_/OB.PUmnGe.mA1FsdEHs9SKI--
