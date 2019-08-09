Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D79882BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436733AbfHISi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 14:38:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15322 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407359AbfHISiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:38:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4dbd9b0000>; Fri, 09 Aug 2019 11:38:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 11:38:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 11:38:18 -0700
Received: from [10.2.165.207] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 18:38:17 +0000
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
To:     "Weiny, Ira" <ira.weiny@intel.com>,
        Michal Hocko <mhocko@kernel.org>, Jan Kara <jack@suse.cz>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
 <420a5039-a79c-3872-38ea-807cedca3b8a@suse.cz>
 <20190809082307.GL18351@dhcp22.suse.cz>
 <20190809135813.GF17568@quack2.suse.cz>
 <20190809175210.GR18351@dhcp22.suse.cz>
 <2807E5FD2F6FDA4886F6618EAC48510E79E7F3E7@CRSMSX101.amr.corp.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e2bad873-137a-0c35-0674-f5dea6c61f3a@nvidia.com>
Date:   Fri, 9 Aug 2019 11:36:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79E7F3E7@CRSMSX101.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565375900; bh=AWUDkVLqdIORGIbcTInm0lQJHtik3ucba+VqqEeNdtM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=piG3eQePf8V+mHT9Zce3BSUjqk9l6uDwFxA9H2EedRCzVUFYtqH1h4nXGte/KWFlN
         xZGLguGJGcQxYhB9IuSFjRUgaOPgTkpVIZwP5arOrYCiPtgtzTeltSOIXvrqdit/Tn
         QJB5ptzF8lyqgfmHRnDKP0NfUjUrgTHNEGsqbfkGedUbma1Pp7ya87wnpiMvF6edFa
         ZxlzE6K3WTkJs9WNAUxATkydOVAVg7+N+mvCq8IvQjUZS/BAOXY5nA51BLkM1THFHj
         ij+lLOsW/RZi/WiFtmvTVe6QCJM0XbxuH8T0lKRw7Q9uY/Oy3N9nHUIVaqJ7ZFxMCx
         2iVeFvON8EsvQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 11:14 AM, Weiny, Ira wrote:
>> On Fri 09-08-19 15:58:13, Jan Kara wrote:
>>> On Fri 09-08-19 10:23:07, Michal Hocko wrote:
>>>> On Fri 09-08-19 10:12:48, Vlastimil Babka wrote:
>>>>> On 8/9/19 12:59 AM, John Hubbard wrote:
...
>>> In principle, I'm not strongly opposed to a new FOLL flag to determine
>>> whether a pin or an ordinary page reference will be acquired at least
>>> as an internal implementation detail inside mm/gup.c. But I would
>>> really like to discourage new GUP users taking just page reference as
>>> the most clueless users (drivers) usually need a pin in the sense John
>>> implements. So in terms of API I'd strongly prefer to deprecate GUP as
>>> an API, provide
>>> vaddr_pin_pages() for drivers to get their buffer pages pinned and
>>> then for those few users who really know what they are doing (and who
>>> are not interested in page contents) we can have APIs like
>>> follow_page() to get a page reference from a virtual address.
>>
>> Yes, going with a dedicated API sounds much better to me. Whether a
>> dedicated FOLL flag is used internally is not that important. I am also for
>> making the underlying gup to be really internal to the core kernel.
> 
> +1
> 
> I think GUP is too confusing.  I've been working with the details for many months now and it continues to confuse me.  :-(
> 
> My patches should be posted soon (based on mmotm) and I'll have my flame suit on so we can debate the interface.
> 

OK, so: use FOLL_PIN as an internal gup flag. FOLL_PIN will get set by the
new vaddr_pin_pages*() wrapper calls. Then, put_user_page*() shall only be
invoked from call sites that use FOLL_PIN.

With that approach in mind, I can sweep through my callsite conversion
patchset and drop a few patches. There are actually quite a few patches that
just want to find the page, not really operate on its data.

And the conversion of the actual gup() calls can be done almost independently
of the put_user_page*() conversions, if necessary (and it sounds like with your
patchset, it is).

btw, as part of the conversion, to make merging and call site conversion
smoother, maybe it's OK to pass in FOLL_PIN to existing gup() calls, with
the intent to convert them to use vaddr_pin_pages.)

thanks,
-- 
John Hubbard
NVIDIA
  
