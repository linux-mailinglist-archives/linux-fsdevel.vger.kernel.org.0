Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAB14E77E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 04:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgAaDTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 22:19:34 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6618 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgAaDTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:19:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e339c8e0000>; Thu, 30 Jan 2020 19:18:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 19:19:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 19:19:31 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 03:19:31 +0000
Subject: Re: [PATCH v2 4/8] mm/gup: track FOLL_PIN pages
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
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-5-jhubbard@nvidia.com>
 <20200129135153.knie7ptvsxcgube6@box>
 <0be743df-e9af-6da9-c593-9e25ab194acf@nvidia.com>
 <20200130113126.5ftq4gd5k7o7tipj@box>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1037b514-30e7-c128-38c1-9c98488be337@nvidia.com>
Date:   Thu, 30 Jan 2020 19:19:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200130113126.5ftq4gd5k7o7tipj@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580440719; bh=9n3GVRH7rJT8PUMEqe1BMiXjCWR5u2839yBFWtobbC8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DyboAuvvbnzLHMEIag1fx4ad2eQQcY8Jsk0DPogA1Xd5f6sbkghXewV7YQM2/iusj
         B4T31MmPGDxl8HYQEgTzwTjtC7aXYSsBqhReBchu4rQ3x2Tg9oKG30YhyaXyxX1zNJ
         mQXxsLzBUV1RQ6IAEVYKzDedk9H7zC8YcXryZqWQmOBJN6TCbJzzlnCBXNPqKb3tHz
         gb7xzJ5ZNfj8tLSN3LebvHbUjchA/wB6wHtGy1YqbyoHTg/Hy4dFqQ3WNC6LGHaugE
         phaII7jurRZGdzUGIVeJaTPP7ZEu9NHyZD6tjX5kAaACjvJbQ8wCOySgAH5vXtg5+O
         50R/K9o+IjDKA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/30/20 3:31 AM, Kirill A. Shutemov wrote:
...
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 0a55dec68925..b1079aaa6f24 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>>>>   	 */
>>>>   	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
>>>> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>>>> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
>>>> +			 (FOLL_PIN | FOLL_GET)))
>>>
>>> Too many parentheses.
>>
>>
>> OK, I'll remove at least one. :)
> 
> I see two.

ah, correction: actually, the original statement has exactly the right number of parentheses.
The relevant C precedence order is:
	==
	&
	|

...which means that both "&" and "|" operations need parentheses protection from the higher
precedence "==" operation.

(There are other places in the kernel that have this exact pattern, too, with the same
pattern of parentheses that I'm using, of course.)

thanks,
-- 
John Hubbard
NVIDIA
 
