Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D02A085F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgJ3Osk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3600 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgJ3Osj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:48:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c27cc0000>; Fri, 30 Oct 2020 07:48:44 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 14:48:38 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/19] mm: Use multi-index entries in the page cache
Date:   Fri, 30 Oct 2020 10:48:35 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <A43CC16F-E024-4849-9CC8-8816309C8F38@nvidia.com>
In-Reply-To: <20201029215438.GE27442@casper.infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-3-willy@infradead.org>
 <4D931CDD-2CB1-4129-974C-12255156154E@nvidia.com>
 <20201029215438.GE27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_1F612E02-091B-42FF-91EA-44D3B2D18433_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604069324; bh=48V7nYT0QLfo3VabQMorNmQ5kBM9aZcsghGlq9TwCD8=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=PuMpaIbiSCh9WFOwcfQUxIhpoEGOlbTLaxmqJIntYuUh380yEMRdBkWUBhokU/3/a
         Whyj8Hf1rAUsmypQ7beAhQZUInKf3iW5q02cxUKaamshFHXFoyVBuZnDTp2Go8KPR1
         +tTFRSPTv4gvnVJ3ipreOr+hWyAj8CGNuBqGEqI0E/rrwnOX7wLBRZ0Iy2s1fVGCmz
         qhIbFHzPwb0YunUggRAvm9XuDWtLaq9fsgs8u403tNBDzjlaDvgN2zEv5zV6zYNKQy
         oZbn2XJm0IFNYjS7ZiAzD9jjRhLfv659zEGIO+wZUnjcPTg14s1vs1AIfHZUm7Ini1
         EkJNHAm/0dm4g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_1F612E02-091B-42FF-91EA-44D3B2D18433_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2020, at 17:54, Matthew Wilcox wrote:

> On Thu, Oct 29, 2020 at 04:49:39PM -0400, Zi Yan wrote:
>> On 29 Oct 2020, at 15:33, Matthew Wilcox (Oracle) wrote:
>>
>>> We currently store order-N THPs as 2^N consecutive entries.  While th=
is
>>> consumes rather more memory than necessary, it also turns out to be b=
uggy.
>>> A writeback operation which starts in the middle of a dirty THP will =
not
>>> notice as the dirty bit is only set on the head index.  With multi-in=
dex
>>> entries, the dirty bit will be found no matter where in the THP the
>>> iteration starts.
>>
>> A multi-index entry can point to a THP with any size and the code reli=
es
>> on thp_last_tail() to check whether it has finished processing the pag=
e
>> pointed by the entry. Is it how this change works?
>
> Maybe I need to do a better explanation here.  Let me try again ...
>
> Consider an order-2 page (at address p) at index 4.  Before this change=
,
> the node in the XArray contains:
>
> 4: p
> 5: p
> 6: p
> 7: p
>
> After this change, it contains:
>
> 4: p
> 5: sibling(4)
> 6: sibling(4)
> 7: sibling(4)
>
> When we mark page p as dirty, we set a bit on entry 4, since that's the=

> head page.  Now we try to fsync pages 5-19, we start the lookup at inde=
x 5.
> Before this patch, the pagecache knows that p is a head page, but the
> XArray doesn't.  So when it looks at entry 5, it sees a normal pointer
> and no mark on it -- the XArray doesn't get to interpret the contents
> of the pointers stored in it.  After this patch, we tell the XArray tha=
t
> indices 4-7 are a single entry, so the marked iteration actually loads
> the entry at 5, sees it's a sibling of 4, sees that 4 is marked dirty
> and returns p.

Got it. Thanks for the explanation. Could you include this in the commit
message?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_1F612E02-091B-42FF-91EA-44D3B2D18433_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cJ8MPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKpdkP/1egnu7H6snkKQJeswwxoyHivDdPBFUYGZTK
d6Cuf0cExVUMW56eG8gW7JEnWzbciQsfnsp2WQtjGFaLL6TluEmTQ0huK/07SxKa
RsSwOgMuzLQiBfKNikv43Qa4BzZov3Moe795n51fTQ0c1+y7DYdqhicKjjchb6ml
Y6/kIjdRICKRIhQr6aMrwTPM7Zkr9qz12rovK1WFskeCFH/LH1zqp/ZxFFHIOi4A
WatMEjNVIvYfzjp2vVV2pLK2LRIBPQnWCck/dsTRf0UwUCEQx6szFeX7VAbNnuig
2ygETYGiSWV92/9Ca9AsBSK3FPVQ+RnnRSCQphMnwHtp2YyXijGLaBY/9+x+5DHy
lNsjR52ORTWglKhLwQtPD0N/c512qAZ/FUxaHRVg4BNHZw+ZHGt0bn9r1nJxkzd4
mfJP7pEihU0qeVzUV1DPMZ1baUesjJW5flNlghaUY5oao6v7HSqV2i0GWUUwpQwe
wtr3PGnjn441Fky0wLrNJPMs0PPqBsCEv6eHej4BoFJNU62XRkhWYZdBALIrflHc
Wb/msNDTYKZ3adm9CziLzb9sH1r69428YzsfBBNuEOCsGrwcNqPDNDU8LWqkwGZb
+JBFnJwfgKkkzL605JiMInHbOcR6nqSBtAPMpJLFMnqSU/C65PcQbQwPmBU8oIK4
VGYKe+U5
=5wYO
-----END PGP SIGNATURE-----

--=_MailMate_1F612E02-091B-42FF-91EA-44D3B2D18433_=--
