Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A618F278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHORlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 13:41:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8074 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfHORlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:41:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d55995d0000>; Thu, 15 Aug 2019 10:41:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 15 Aug 2019 10:41:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 15 Aug 2019 10:41:46 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Aug
 2019 17:41:46 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
To:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
 <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
 <20190813210857.GB12695@iweiny-DESK2.sc.intel.com>
 <a1044a0d-059c-f347-bd68-38be8478bf20@nvidia.com>
 <90e5cd11-fb34-6913-351b-a5cc6e24d85d@nvidia.com>
 <20190814234959.GA463@iweiny-DESK2.sc.intel.com>
 <2cbdf599-2226-99ae-b4d5-8909a0a1eadf@nvidia.com>
 <ac834ac6-39bd-6df9-fca4-70b9520b6c34@nvidia.com>
 <20190815132622.GG14313@quack2.suse.cz>
 <20190815133510.GA21302@quack2.suse.cz>
 <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b378a363-f523-518d-9864-e2f8e5bd0c34@nvidia.com>
Date:   Thu, 15 Aug 2019 10:41:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815173237.GA30924@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565890909; bh=6t4FiV8ZlmFrwJ34d+212gbUZqAzntteDNGGoJ3INfA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CxfUWl6Z2INpC2m03w2UoKnOg6ZKQH2HA5ushGjZOEU13Vw43HHrxeE87osanVaxN
         qdAm9uSPd9ZNfskJXQ/ghxfxM4pQu3bBkLIp4/SSrrEdcwZksbNBtY7eA7QobvU7L2
         ANDRiX60f+5+4TNxDEr8d4VIXjvhrNIb7lt2mFC/yIFgInLWA4QawJ9PsfSRW9K2g6
         +xX5DS1rirJwLRwYyT5/KnvT5SuPHdpVrbGSz2kVfwOaglAwvMnAnBX4Q6VyEwWsUF
         d5/yJ0G9ddLg2NEON0m8ZOoy3z1D849Fdf7OGd8/Hu+PRlOr6ERUr8qcjMgWa5N8QW
         +gXT8Jb48xO2Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/19 10:32 AM, Ira Weiny wrote:
> On Thu, Aug 15, 2019 at 03:35:10PM +0200, Jan Kara wrote:
>> On Thu 15-08-19 15:26:22, Jan Kara wrote:
>>> On Wed 14-08-19 20:01:07, John Hubbard wrote:
>>>> On 8/14/19 5:02 PM, John Hubbard wrote:
>>>>
>>>> Hold on, I *was* forgetting something: this was a two part thing, and
>>>> you're conflating the two points, but they need to remain separate and
>>>> distinct. There were:
>>>>
>>>> 1. FOLL_PIN is necessary because the caller is clearly in the use case that
>>>> requires it--however briefly they might be there. As Jan described it,
>>>>
>>>> "Anything that gets page reference and then touches page data (e.g.
>>>> direct IO) needs the new kind of tracking so that filesystem knows
>>>> someone is messing with the page data." [1]
>>>
>>> So when the GUP user uses MMU notifiers to stop writing to pages whenever
>>> they are writeprotected with page_mkclean(), they don't really need page
>>> pin - their access is then fully equivalent to any other mmap userspace
>>> access and filesystem knows how to deal with those. I forgot out this case
>>> when I wrote the above sentence.
>>>
>>> So to sum up there are three cases:
>>> 1) DIO case - GUP references to pages serving as DIO buffers are needed for
>>>    relatively short time, no special synchronization with page_mkclean() or
>>>    munmap() => needs FOLL_PIN
>>> 2) RDMA case - GUP references to pages serving as DMA buffers needed for a
>>>    long time, no special synchronization with page_mkclean() or munmap()
>>>    => needs FOLL_PIN | FOLL_LONGTERM
>>>    This case has also a special case when the pages are actually DAX. Then
>>>    the caller additionally needs file lease and additional file_pin
>>>    structure is used for tracking this usage.
>>> 3) ODP case - GUP references to pages serving as DMA buffers, MMU notifiers
>>>    used to synchronize with page_mkclean() and munmap() => normal page
>>>    references are fine.
>>

Thanks Jan, once again, for clarifying all of this!

>> I want to add that I'd like to convert users in cases 1) and 2) from using
>> GUP to using differently named function. Users in case 3) can stay as they
>> are for now although ultimately I'd like to denote such use cases in a
>> special way as well...
>>
> 
> Ok just to make this clear I threw up my current tree with your patches here:
> 
> https://github.com/weiny2/linux-kernel/commits/mmotm-rdmafsdax-b0-v4
> 
> I'm talking about dropping the final patch:
> 05fd2d3afa6b rdma/umem_odp: Use vaddr_pin_pages_remote() in ODP
> 
> The other 2 can stay.  I split out the *_remote() call.  We don't have a user
> but I'll keep it around for a bit.
> 
> This tree is still WIP as I work through all the comments.  So I've not changed
> names or variable types etc...  Just wanted to settle this.
> 

Right. And now that ODP is not a user, I'll take a quick look through my other
call site conversions and see if I can find an easy one, to include here as
the first user of vaddr_pin_pages_remote(). I'll send it your way if that
works out.


thanks,
-- 
John Hubbard
NVIDIA
