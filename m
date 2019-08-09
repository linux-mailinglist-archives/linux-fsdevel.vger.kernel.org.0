Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF53874D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406078AbfHIJGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 05:06:54 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17031 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405974AbfHIJGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:06:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4d37aa0000>; Fri, 09 Aug 2019 02:06:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 02:06:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 02:06:48 -0700
Received: from [10.2.165.207] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 09:06:48 +0000
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
To:     Michal Hocko <mhocko@kernel.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
 <420a5039-a79c-3872-38ea-807cedca3b8a@suse.cz>
 <20190809082307.GL18351@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a83e4449-fc8d-7771-1b78-2fa645fa0772@nvidia.com>
Date:   Fri, 9 Aug 2019 02:05:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809082307.GL18351@dhcp22.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565341610; bh=xxX6/xlEYYSgAcMbE9OCsum5lhmSqdMBrVqwD/ALhJM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=j8hwcxSPSQQ7m/nGMO4zcZKB+HyGn4I5hyxPJMAtoSVYP+yUp53r2/hoxLKbOTaEA
         Kra5eQySWSmWNcs0Z5HiQTEC7Ds3vYcChlwLJIzcJlJmsU+mQaCJwBGj7s8TY7nU05
         eHg2mlZvXbM+TER2CGFyvQ4RFppWB3FLbMYL2SdsktQj253jD3tYmUeyqGT0P5X2FD
         RC9Zljztszfi+1P9PBSu30lEHW3IY0JKjLufsqIfLJH5GnPcxPwukZw4pzC/ezvHeU
         cADhbvuqEUZCiCTduaINR4cFLGL+WZT+0tDbUSmAou352rwonbnZs4qLfOFGzAp4LX
         IRkDPPV7ceQHw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 1:23 AM, Michal Hocko wrote:
> On Fri 09-08-19 10:12:48, Vlastimil Babka wrote:
>> On 8/9/19 12:59 AM, John Hubbard wrote:
>>>>> That's true. However, I'm not sure munlocking is where the
>>>>> put_user_page() machinery is intended to be used anyway? These are
>>>>> short-term pins for struct page manipulation, not e.g. dirtying of page
>>>>> contents. Reading commit fc1d8e7cca2d I don't think this case falls
>>>>> within the reasoning there. Perhaps not all GUP users should be
>>>>> converted to the planned separate GUP tracking, and instead we should
>>>>> have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
>>>>>   
>>>>
>>>> Interesting. So far, the approach has been to get all the gup callers to
>>>> release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
>>>> wrapper, then maybe we could leave some sites unconverted.
>>>>
>>>> However, in order to do so, we would have to change things so that we have
>>>> one set of APIs (gup) that do *not* increment a pin count, and another set
>>>> (vaddr_pin_pages) that do.
>>>>
>>>> Is that where we want to go...?
>>>>
>>
>> We already have a FOLL_LONGTERM flag, isn't that somehow related? And if
>> it's not exactly the same thing, perhaps a new gup flag to distinguish
>> which kind of pinning to use?
> 
> Agreed. This is a shiny example how forcing all existing gup users into
> the new scheme is subotimal at best. Not the mention the overal
> fragility mention elsewhere. I dislike the conversion even more now.
> 
> Sorry if this was already discussed already but why the new pinning is
> not bound to FOLL_LONGTERM (ideally hidden by an interface so that users
> do not have to care about the flag) only?
> 

Oh, it's been discussed alright, but given how some of the discussions have gone,
I certainly am not surprised that there are still questions and criticisms!
Especially since I may have misunderstood some of the points, along the way.
It's been quite a merry go round. :)

Anyway, what I'm hearing now is: for gup(FOLL_LONGTERM), apply the pinned tracking.
And therefore only do put_user_page() on pages that were pinned with
FOLL_LONGTERM. For short term pins, let the locking do what it will:
things can briefly block and all will be well.

Also, that may or may not come with a wrapper function, courtesy of Jan
and Ira.

Is that about right? It's late here, but I don't immediately recall any
problems with doing it that way...

thanks,
-- 
John Hubbard
NVIDIA
