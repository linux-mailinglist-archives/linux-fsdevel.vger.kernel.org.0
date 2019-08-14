Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168908C549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 02:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfHNAvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 20:51:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11202 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfHNAvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:51:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d535afb0000>; Tue, 13 Aug 2019 17:51:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Aug 2019 17:51:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Aug 2019 17:51:05 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 00:51:04 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
Date:   Tue, 13 Aug 2019 17:51:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565743867; bh=IF2KEhhP6zk3NQWmA0ULQJTJjwAVYOpzkUJKOo6LvPA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X8t2NG/HwtOOxsv+PWLwZkXzQBmV3g9W1+CETIuHbEBOZqmWs/Z3QVPwCCfOuE4j7
         FAn37D4tAKs1iNzSLF4sU0q27j/J0kreTxBk5EdDnjmcpFdnLvZyh09QNj0fQQ5ecR
         278+NRy3q2LNMUyzey3JI17g+2dxO7OHNRIiYFqP0ia2OHH2ybZLRUoqabxfgHq/Z3
         ks8jh0dZk8GygCbxKcSvTjii+QRcI9jD1DMaD3HTLtWgz0BnD/daEzr0fvhFYT7YHx
         QOmzN2wd9yyy2Y4xgeDMBIi54hhjzHn+OrDeFgWObH0ukNC3M1B5U5XS9zob1i11FC
         2WF0RE/WJZkDg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/19 2:08 PM, Ira Weiny wrote:
> On Mon, Aug 12, 2019 at 05:07:32PM -0700, John Hubbard wrote:
>> On 8/12/19 4:49 PM, Ira Weiny wrote:
>>> On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
>>>> From: John Hubbard <jhubbard@nvidia.com>
>> ...
>>> Thinking about this part of the patch... is this pin really necessary?  This
>>> code is not doing a long term pin.  The page just needs a reference while we
>>> map it into the devices page tables.  Once that is done we should get notifiers
>>> if anything changes and we can adjust.  right?
>>>
>>
>> OK, now it's a little interesting: the FOLL_PIN is necessary, but maybe not
>> FOLL_LONGTERM. Illustrating once again that it's actually necessary to allow
>> these flags to vary independently.
> 
> Why is PIN necessary?  I think we do want all drivers to use the new
> user_uaddr_vaddr_pin_user_pages() call...  :-P  But in this case I think a
> simple "get" reference is enough to reference the page while we are using it.
> If it changes after the "put/unpin" we get a fault which should handle the
> change right?
> 

FOLL_PIN is necessary because the caller is clearly in the use case that 
requires it--however briefly they might be there. As Jan described it,

"Anything that gets page reference and then touches page data (e.g. direct IO)
needs the new kind of tracking so that filesystem knows someone is messing with
the page data." [1]

> The other issue I have with FOLL_PIN is what does it mean to call "...pin...()"
> without FOLL_PIN?
> 
> This is another confusion of get_user_pages()...  you can actually call it
> without FOLL_GET...  :-/  And you just don't get pages back.  I've never really
> dug into how (or if) you "put" them later...
>

Yes, you are talking to someone who has been suffering through that. The
problem here is that gup() has evolved into a do-everything tool. I think we're
getting closer to teasing it apart into more specific interfaces that do
more limited things.

Anyway, I want FOLL_PIN as a way to help clarify this...

 
>>
>> And that leads to another API refinement idea: let's set FOLL_PIN within the
>> vaddr_pin_pages*() wrappers, and set FOLL_LONGTER in the *callers* of those
>> wrappers, yes?
> 
> I've thought about this before and I think any default flags should simply
> define what we want follow_pages to do.

Hmm, so don't forget that we need to know what gup_fast() should do, too.

Anyway, I'm not worried about which combination of wrapper calls set which flags,
I'm open to suggestion there. But it does still seem to me that we should have
independent FOLL_LONGTERM and FOLL_PIN flags, once the API churn settles. 


> 
> Also, the addition of vaddr_pin information creates an implicit flag which if
> not there disallows any file pages from being pinned.  It becomes our new
> "longterm" flag.  FOLL_PIN _could_ be what we should use "internally".  But we
> could also just use this implicit vaddr_pin flag and not add a new flag.

I'd like to have FOLL_PIN internally, in order to solve the problems that
you just raised, above! Namely, that it's too hard to figure out all the
cases that gup() is handling.

With FOLL_PIN, we know that we should be taking the new pin refcount, and
releasing it via the (currently named) put_user_page*(), ultimately.

> 
> Finally, I struggle with converting everyone to a new call.  It is more
> overhead to use vaddr_pin in the call above because now the GUP code is going
> to associate a file pin object with that file when in ODP we don't need that
> because the pages can move around.

What if the pages in ODP are file-backed? 

> 
> This overhead may be fine, not sure in this case, but I don't see everyone
> wanting it.

I think most callers don't have much choice, otherwise they'll be broken with
file-backed memory.

thanks,
-- 
John Hubbard
NVIDIA
