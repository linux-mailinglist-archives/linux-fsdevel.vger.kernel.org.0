Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB4151238
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBCWHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 17:07:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16172 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCWHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:07:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e38998e0000>; Mon, 03 Feb 2020 14:07:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 14:07:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 14:07:34 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 22:07:33 +0000
Subject: Re: [PATCH v3 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-12-jhubbard@nvidia.com>
 <20200203135845.ymfbghs7rf67awex@box>
 <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
 <20200203215553.q7zx6diprbby6ns5@box.shutemov.name>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1d89f126-91b8-bab9-0d6c-0a789581dbff@nvidia.com>
Date:   Mon, 3 Feb 2020 14:07:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203215553.q7zx6diprbby6ns5@box.shutemov.name>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580767631; bh=3g2jpP7PATIRShMbNa46mzIFlzlSWwEuhifQjWIA0qA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=U8QvK34EGwtcRxqHonJOikQVH8V81FSRLWwtw4MkUI7C9VjLfhrlxTzvE+w9oTS/W
         F7AjIKlrxbA1U7WdKDvnEvXvcA9Owttra/Fa+MULA7zHQI1QiAha21jaJEOyySC98d
         GCxJRpBcK5guEW+dpfpJriF80N83GetmAwP0rQEgK00+PAhzBSRnHMcTVhEjeQl0xH
         c6wWwTN28IokxkfYyzrX93PaQUwEcVKotdnO8uAXY3mp2UsqKU6D5l5lXbZ1aojfEI
         GP9AynFsKx9PKu+mi2bDIv1QFLzjxT8sgD7GSdTisaCXA3NaDhNIQoR+cmCerg3D/q
         y2gHb76zk0kGQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 1:55 PM, Kirill A. Shutemov wrote:
> On Mon, Feb 03, 2020 at 01:17:40PM -0800, John Hubbard wrote:
>> On 2/3/20 5:58 AM, Kirill A. Shutemov wrote:
>> ...
>>>> @@ -19,6 +21,48 @@ struct gup_benchmark {
>>>>  	__u64 expansion[10];	/* For future use */
>>>>  };
>>>>  
>>>> +static void put_back_pages(unsigned int cmd, struct page **pages,
>>>> +			   unsigned long nr_pages)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	switch (cmd) {
>>>> +	case GUP_FAST_BENCHMARK:
>>>> +	case GUP_LONGTERM_BENCHMARK:
>>>> +	case GUP_BENCHMARK:
>>>> +		for (i = 0; i < nr_pages; i++)
>>>
>>> 'i' is 'int' and 'nr_pages' is 'unsigned long'.
>>> There's space for trouble :P
>>>
>>
>> Yes, I've changed it to "unsigned int", thanks.
> 
> I'm confused. If nr_pages is more than UINT_MAX, this is endless loop.
> Hm?
> 

Oh, I've been afflicted with 64-bit tunnel vision. OK, make that 
"unsigned long" and "%ul". yikes. :)



thanks,
-- 
John Hubbard
NVIDIA
