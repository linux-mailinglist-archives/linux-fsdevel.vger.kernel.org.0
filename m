Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6565C2B24D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMTou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 14:44:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12913 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMTot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:44:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faee2350000>; Fri, 13 Nov 2020 11:44:53 -0800
Received: from [10.2.88.49] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 19:44:42 +0000
Subject: Re: Are THPs the right model for the pagecache?
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20201113044652.GD17076@casper.infradead.org>
 <1c1fa264-41d8-49a4-e5ff-2a5bf03e711e@nvidia.com>
 <20201113123836.GE17076@casper.infradead.org>
 <20201113174409.GH17076@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a548e192-5977-2eef-b0b1-effdf744c35f@nvidia.com>
Date:   Fri, 13 Nov 2020 11:44:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201113174409.GH17076@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605296693; bh=JFgmU79FTdtVBVVQC7aaqHQgnrbx9oOyfd+bx1OA7pw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=W/YEs+X5iq/BHCGrdClOpDihff5YD9yJjf5i6rywoZJDTsCI8izD/+1gPjqcOdN4m
         H5Zh7HLqmDuiQE5YRtnOal8fP9dfvy9Pe9ocKsRf3kn08SgFTs++DaLFQ+Hz6ogUSi
         gIsbzIbYeuWRo8yryO37ux5Br7CA+g54EIbtzrb0ev5vQ0O29MWp1ucvL7kiXDy35L
         J5TKYmnN2msT1MjjiMcen5RnVnOKkbgGBAmE2PPkCdsoCQ0UXiQSISxmNQHd7kV3vU
         dGPv2hpEVuJy9jgeo0ivKKJ+yFuyVyG8PNAJKpOQhYhpGFUT/HsLliY7uPVuWoGK8n
         HlgHrp8POgoiw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/20 9:44 AM, Matthew Wilcox wrote:
> On Fri, Nov 13, 2020 at 12:38:36PM +0000, Matthew Wilcox wrote:
>> So what if we had:
>>
>> /* Cache memory */
>> struct cmem {
>> 	struct page pages[1];
>> };
> 
> OK, that's a terrible name.  I went with 'folio' for this demonstration.
> Other names suggested include album, sheaf and ream.

+1 for "folio", that's a good name! It stands out, as it should, given that
it's a different type. The others could work too, but this one is especially
nice because there are no pre-existing uses in the kernel, so no baggage.
And it's grep-able too.

Your demo diff looks good to me, and I think it noticeably improves things
and is worth doing. One tiny tweak first:

The struct member should be named .page, rather than .pages. That's because
pages in -mm usually refers to "struct page **", but here you've got a
struct page *.  Notice how the various odd things get better in the patch
if you change it to .page:

...
> +static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
>   {
> -	return &page[1].compound_mapcount;
> +	return &folio->pages[1].compound_mapcount;

See, this diff is changing from "page" to "pages", but we don't
especially desire that, *and* it's arguably even more readable like
this anyway:

	return &folio->page[1].compound_mapcount;

and...

...
> @@ -166,16 +167,16 @@ void __dump_page(struct page *page, const char *reason)
>   out_mapping:
>   	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>   
> -	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
> -		page_cma ? " CMA" : "");
> +	pr_warn("%sflags: %#lx(%pGp)%s\n", type, folio->pages->flags,
> +			&(folio->pages->flags), page_cma ? " CMA" : "");
>   
>   hex_only:
>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>   			sizeof(unsigned long), page,
>   			sizeof(struct page), false);
> -	if (head != page)
> +	if (folio->pages != page)

This one in particular gets a lot better:

	if (folio->page != page)

...is much more natural.

thanks,
-- 
John Hubbard
NVIDIA
