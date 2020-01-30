Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D114D671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 07:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA3Gd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 01:33:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19859 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgA3Gd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:33:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3278c70000>; Wed, 29 Jan 2020 22:33:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 22:33:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jan 2020 22:33:57 -0800
Received: from [10.2.165.69] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 06:33:57 +0000
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
From:   John Hubbard <jhubbard@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-2-jhubbard@nvidia.com>
 <20200129112510.ulims6u36ofk2qwa@box>
 <b74e8aa9-fcfd-0340-594c-61f185a0ae65@nvidia.com>
 <20200129225957.GH6615@bombadil.infradead.org>
 <a0d66400-96a2-f94e-311d-a94f75e72d65@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <c9aea9a3-53b1-83f0-9f69-c294647e0925@nvidia.com>
Date:   Wed, 29 Jan 2020 22:30:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <a0d66400-96a2-f94e-311d-a94f75e72d65@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580366023; bh=iZY1/g2/MCQ3KPYqu+CkoD4OYyNxEEjqeo4JNbOECuM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=f4pKrMQlnQ5lVGDlW7PYL/KTudIQAYyxHJ7kADvSvQcMo7xwDlpmNiw7jRHH02XRu
         LUbhtnmhoFfoViXeCzyURJZ5ZT2tFv9w7Gk9BnbjxiHqqR68cmGGsL8OQpAUrTKwh+
         R+Oe2oriRiuX2tYa5Q/Y6J9XiamJIsg3qsDjvCKVjyu1CTO3AmyUYsyMOqgYJGoiKo
         sesGH5ZgSCJZQl6twIoECnFRiCw9hq7fox55hgonciXWj/8hqlGsB2QlJUJEzVCVGm
         qVSi0u7Haqg8rNwptdG7Ds19fKzYYVrSXNV3FYLO8hwx3z1RyYmwXoib0tTh2UpcP+
         0MLpWfq4Ga0vw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/20 10:23 PM, John Hubbard wrote:
> On 1/29/20 2:59 PM, Matthew Wilcox wrote:
> ...
>> I have a hunk in my current tree which looks like this:
>>
>> @@ -77,6 +77,11 @@ void __dump_page(struct page *page, const char *reaso=
n)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("page:%px refcount:%d mapcount:%d mapping:=
%px index:%#lx
>> \n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
ge, page_ref_count(page), mapcount,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
ge->mapping, page_to_pgoff(page));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageTail(page)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct page *head =3D compound_head(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_warn("head:%px mapping:%px index:%#lx\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head, head-=
>mapping, page_to_pgoff(head));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PageKsm(page))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &p=
age->flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (PageAnon(page)=
)
>>
>> I wonder if we can combine these two patches in some more useful way?
>>
>> I also think we probably want a sanity check that 'head' and 'page'
>> are within a sane range of each other (ie head < page and head +
>> MAX_ORDER_NR_PAGES > page) to protect against a struct page that contain=
s
>> complete garbage.
>>
>=20
> OK, here's a go at combining those. I like the observation, implicit in y=
our
> diffs, that PageTail rather than PageCompound is the key differentiator i=
n
> deciding what to print. How's this look:
>=20
> diff --git a/mm/debug.c b/mm/debug.c
> index a90da5337c14..944652843e7b 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -75,12 +75,31 @@ void __dump_page(struct page *page, const char *reaso=
n)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0 mapcount =3D PageSlab(page) ? 0 : page_mapcount=
(page);
>=20
> -=C2=A0=C2=A0=C2=A0 if (PageCompound(page))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("page:%px refcount:%d=
 mapcount:%d mapping:%px "
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "inde=
x:%#lx compound_mapcount: %d\n",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page,=
 page_ref_count(page), mapcount,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page-=
>mapping, page_to_pgoff(page),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compo=
und_mapcount(page));
> +=C2=A0=C2=A0=C2=A0 if (PageTail(page)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *head =3D compoun=
d_head(page);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((page < head) || (page >=
=3D head + MAX_ORDER_NR_PAGES)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Page is hopelessly corrupted, so limit any reporting
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * to information about the page itself. Do not attempt
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * to look at the head page.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_wa=
rn("page:%px refcount:%d mapcount:%d mapping:%px "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "index:%#lx (corrupted tail page case)\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page, page_ref_count(page), mapcount,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page->mapping, page_to_pgoff(page));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_wa=
rn("page:%px compound refcount:%d mapcount:%d "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "mapping:%px index:%#lx compound_mapcount:%d\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page, page_ref_count(head),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mapcount, head->mapping, page_to_pgoff(head),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compound_mapcount(page));
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p=
age_ref_count(page) !=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pr_warn("page:%px PROBLEM: non-zero refcount (=3D=3D%d) =
on "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "this tail page\n", page, page_r=
ef_count(page));

...ahem, I sorta botched the above statement, because that should
be outside (just below) the "else" statement--it can be done whether or
not the page fails the safety/bounds check. :)

thanks,
--=20
John Hubbard
NVIDIA
