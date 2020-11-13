Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461932B1E73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKMPUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 10:20:02 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10947 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:20:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faea41a0000>; Fri, 13 Nov 2020 07:19:54 -0800
Received: from [10.2.162.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 15:20:00 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: Are THPs the right model for the pagecache?
Date:   Fri, 13 Nov 2020 10:19:56 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <40BFC0F6-6099-4AFB-857F-7F908833F9C9@nvidia.com>
In-Reply-To: <20201113044652.GD17076@casper.infradead.org>
References: <20201113044652.GD17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_2BF5E816-9261-4E28-A0D5-42AC62C3A970_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605280794; bh=r/40XSvVpf+iVNHyw0mRUaeXV9B2xH2GWBUjgziZ14Q=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=L7+0bHr9XKfWo+tz9GdBE0/NAAt3hLJh8sUZ9VP53IWDOPbzNuEeNTCm7XCUM6Jpq
         /wlM1H19luDYnT+/vdkpkZ4KJIjdHXb8mNwLlENXoHC2EcGh6H0QOCRLOKQdW2LSXq
         BGWmXOXbHC5pjgp++0t64Jx0vNJ3X+5O9WQ4d59uE9Ow1dB2PZzG3Bdh95oY1wIN6a
         0KMfsI0TN/dGlMNdh8PG7qUxFF3crDA9AeotQF905mhDcSigL/wIC9WE7z+U6huVo1
         JTcu/Nt3s+7azPHm8kcqUtFCtlPkPAwRaDGjYZQTRNBAJztxYymKILg/feMXrhwZeI
         L9sLgv4wRkPAA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_2BF5E816-9261-4E28-A0D5-42AC62C3A970_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 Nov 2020, at 23:46, Matthew Wilcox wrote:

> When I started working on using larger pages in the page cache, I was
> thinking about calling them large pages or lpages.  As I worked my way
> through the code, I switched to simply adopting the transparent huge
> page terminology that is used by anonymous and shmem.  I just changed
> the definition so that a thp is a page of arbitrary order.
>
> But now I'm wondering if that expediency has brought me to the right
> place.  To enable THP, you have to select CONFIG_TRANSPARENT_HUGEPAGE,
> which is only available on architectures which support using larger TLB=

> entries to map PMD-sized pages.  Fair enough, since that was the origin=
al
> definition, but the point of suppoting larger page sizes in the page
> cache is to reduce software overhead.  Why shouldn't Alpha or m68k use
> large pages in the page cache, even if they can't use them in their TLB=
s?

I think the issue might come from the mixture of physical page sizes and
page table entry sizes. THP in fact has two parts: the ability of managin=
g
a group of pages using just PageHead and the support for larger than
PTE (the smallest virtual address range mapped by a page table entry) pag=
e
table entry mappings. The first part should be independent of the second
one, but the second part relies on the first one. Maybe it is possible
to pull out the code for managing physical pages from CONFIG_TRANSPARENT_=
HUGEPAGE
and enable it unconditionally, so any arch can take the advantage of
large pages.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2BF5E816-9261-4E28-A0D5-42AC62C3A970_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+upB0PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBgUQAI5HfUZYADX/CCxDx09+W71Q4CJ9+iVSJJCA
tNBN1TYGpl5AsQLWAYQ7UHPnfvZZg2nM9eq/tW0cDebkuID61qOBdux3fAicFcPg
J89JJB0o/FuNIbDUkN45kZ2qC4QtqI0pfIHxAuaietfaKG7zEH2m5FW/ifRJYjKA
Jg+w2cPEdWA4XHPDw/3iZmun3hjEeZ0YqEWgC63p8Z9xDGWO6Kb5zpwFWZd91Ceo
BDF9o+dXOji42ZkXwfv8tDXS3SlEwJHvXiX7RRok3x6EA/xIgdRusttvad6NFvTt
E1nwxJplXZXJlHfBm8Et2i48xlGKhCcvcgjAi7+f0dnZj94jJEivkUnBnBZA98+l
IRQFQX76UNoaOafF4xGSgjWYh7DEHmPgi++mWXYIEYfRagp9A5aWQRNKjmFB/mug
W95e5KQHYXZHn+mITaIC+vHKV/+okQFm+44+yeb/7yl9FQKaYA1dNOSIgOwbmc2v
fIvcn4fsQWrF2hI/lnNwTrt4T//4DdUdM/oCTzFoqKyhc27vubrUa8yFUo0R58F0
Y94/uEbHrS2/njhdraeTFiYew3xwb1cAnnajA0yUKdfIqc8Y69HPnXIll2392a8y
ve3Rw21wqvsMne8BiyS/1G5RKEzI3vUEt6XQf7nVMHxY6rSv0FqG9QI5NzGD/2DM
C5BY3A+c
=M25A
-----END PGP SIGNATURE-----

--=_MailMate_2BF5E816-9261-4E28-A0D5-42AC62C3A970_=--
