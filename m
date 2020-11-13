Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8B2B15E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKMGjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:39:11 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9516 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKMGjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:39:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fae2a120000>; Thu, 12 Nov 2020 22:39:14 -0800
Received: from [10.2.88.49] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 06:39:10 +0000
Subject: Re: Are THPs the right model for the pagecache?
To:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20201113044652.GD17076@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1c1fa264-41d8-49a4-e5ff-2a5bf03e711e@nvidia.com>
Date:   Thu, 12 Nov 2020 22:39:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201113044652.GD17076@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605249554; bh=+1vV61r7aJj+On/1WUVh0pXSx4Oswbb+NFAZtUFkoBE=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=LQdZl2eFaox5PQyMRMTZgGaXiEf1gUoev0CGO+NElMFQgz8hdeAi+wH9/f+zdLgxp
         uXIs3boyp3RSESOB5Q6WDaVrGBQam7aKbTI5hpEKihINCg9NxGIVWRmQ14HjD6WdB3
         vKLKDrm83uOGWy57cVPlGzZMR14jrrR9qPuFctCpETtGTM5LaDxLgcencYww/rJLfs
         FNd20+OxZmirH6JbFiA72pszP2ZQC4ExwBcgd2FL1Fs6Epe0RXEcrkPlc9kiXbm24O
         qXOOoYW8+npPsys/vTVH21sfLfzhJAiaHqiUoYQDqIaAny9I9CnDg6Rc9SdGjsUm5N
         O/e5Xo06Khk5Q==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/20 8:46 PM, Matthew Wilcox wrote:
> When I started working on using larger pages in the page cache, I was
> thinking about calling them large pages or lpages.  As I worked my way
> through the code, I switched to simply adopting the transparent huge
> page terminology that is used by anonymous and shmem.  I just changed
> the definition so that a thp is a page of arbitrary order.
> 
> But now I'm wondering if that expediency has brought me to the right
> place.  To enable THP, you have to select CONFIG_TRANSPARENT_HUGEPAGE,
> which is only available on architectures which support using larger TLB
> entries to map PMD-sized pages.  Fair enough, since that was the original
> definition, but the point of suppoting larger page sizes in the page
> cache is to reduce software overhead.  Why shouldn't Alpha or m68k use
> large pages in the page cache, even if they can't use them in their TLBs?
> 
> I'm also thinking about the number of asserts about
> PageHead/PageTail/PageCompound and the repeated invocations of
> compound_head().  If we had a different type for large pages, we could use
> the compiler to assert these things instead of putting in runtime asserts.

This seems like a really good idea to me, anyway. Even in the fairly
small area of gup.c, some type safety (normal pages vs. large pages)
would have helped keep things straight when I was fooling around with
pinning pages.


> 
> IOWs, something like this:
> 
> struct lpage {
> 	struct page subpages[4];
> };
> 
> static inline struct lpage *page_lpage(struct page *page)
> {
> 	unsigned long head = READ_ONCE(page->compound_head);
> 
> 	if (unlikely(head & 1))
> 		return (struct lpage *)(head - 1);
> 	return (struct lpage *)page;
> }

This is really a "get_head_page()" function, not a "get_large_page()"
function. But even renaming it doesn't seem quite right, because
wouldn't it be better to avoid discarding that tail bit information? In
other words, you might be looking at 3 cases, one of which is *not*
involving large pages at all:

     The page is a single, non-compound page.
     The page is a head page of a compound page
     The page is a tail page of a compound page

...but this function returns a type of "large page", even for the first
case. That's misleading, isn't it?

Given that you've said we could get compile time asserts, I guess you're
not envisioning writing any code that could get the first case at
runtime?

thanks,
-- 
John Hubbard
NVIDIA
