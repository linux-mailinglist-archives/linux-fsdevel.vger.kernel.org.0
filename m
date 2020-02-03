Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3321511DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCVfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:35:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15529 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBCVe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:34:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3891f40000>; Mon, 03 Feb 2020 13:34:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:34:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 13:34:59 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:34:58 +0000
Subject: Re: [PATCH v3 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
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
 <20200201034029.4063170-11-jhubbard@nvidia.com>
 <20200203135320.edujsfjwt5nvtiit@box>
 <0425e1e6-f172-91df-2251-7583fcfed3e6@nvidia.com>
 <20200203213022.rltjlohvaswk32ln@box.shutemov.name>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0a81878a-1f7f-daec-0833-d5b91d197ddf@nvidia.com>
Date:   Mon, 3 Feb 2020 13:34:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203213022.rltjlohvaswk32ln@box.shutemov.name>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580765684; bh=kGDtNYXBy0zFUD4iLnz+tUqVaKJvqr8r2bUfyaZ94Dw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lil64nrusY2x09d9REkLc9RTXIIE+yyHnKjfdLHxccFpRZiiYsQeNWUqRp3Ub1/4s
         bd/LkFmhyJnXuYsE2GWCKaZUdA5vRG1GCoy6hIpxIFShc9Jucge2PdCO5n8odGUBV5
         OadbuemDOVCzRFeeb9c0o7Q9QNsn3O2sD4WBb0svV4CWVsKr+5k4EUzpLxlVkV+qWo
         fkSvdmSuXL2e2du7xqqB6MRTNYiEweYr1AaPqGJUl8Yl8f2Ekxsg429JjSTAVcmJGp
         GLRup3JAq6cMc2eIcAufmW8QQOWX7XNyyVztw3larEWoHW51cML0Qh1qdWCk0ZUG+n
         iMTXQTTIQDNYw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 1:30 PM, Kirill A. Shutemov wrote:
> On Mon, Feb 03, 2020 at 01:04:04PM -0800, John Hubbard wrote:
>> On 2/3/20 5:53 AM, Kirill A. Shutemov wrote:
>>> On Fri, Jan 31, 2020 at 07:40:27PM -0800, John Hubbard wrote:
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index c10d0d051c5b..9fe61d15fc0e 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -29,6 +29,19 @@ struct follow_page_context {
>>>>  	unsigned int page_mask;
>>>>  };
>>>>  
>>>> +#ifdef CONFIG_DEBUG_VM
>>>
>>> Why under CONFIG_DEBUG_VM? There's nothing about this in the cover letter.
>>>
>>
>> Early on, gup_benchmark showed a really significant slowdown from using these 
>> counters. And I don't doubt that it's still the case.
>>
>> I'll re-measure and add a short summary and a few numbers to the patch commit
>> description, and to the v4 cover letter.
> 
> Looks like you'll show zeros for these counters if debug is off. It can be
> confusing to the user. I think these counters should go away if you don't
> count them.
> 

OK, that's a good point. (And in fact, the counters==0 situation already led me
astray briefly while debugging with Leon R, even. heh.) I'll remove them entirely for
the !CONFIG_DEBUG_VM case.

thanks,
-- 
John Hubbard
NVIDIA
