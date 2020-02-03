Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F015118E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCVEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:04:08 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17380 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgBCVEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:04:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e388a8d0000>; Mon, 03 Feb 2020 13:03:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:04:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 13:04:05 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:04:05 +0000
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
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0425e1e6-f172-91df-2251-7583fcfed3e6@nvidia.com>
Date:   Mon, 3 Feb 2020 13:04:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203135320.edujsfjwt5nvtiit@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580763789; bh=K74JIULAV9jDDbOHvD7IjQfIlHU2/m1BQ91Azceol7A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Wqbcknnj7oAtmh73fo2VQ0NDJ+zAthDxtXPnOmCBFCoZPRLTAW7imGYD/urYyPwaz
         2ztWWsGn6nw/Y6oDBwXodXKscgYq+llAl1H7bqWkxq2eU7qp/69riC7C25Rgv7XuyY
         Zn2wc1VbyVD8FYxuRyLlGjLQ1nEVNwRFc4kBB0JTfcK9c51Nlksq2/6HtEadolM2jr
         CCYfp9hwdIr/n5o5SPw+wqDamiFb4HbDqav2xbmaa5yTkHTsR9Ltp8JK4JrF+Kx/1C
         TZd6jawWVWilyP26+Lrkjkpacp4gJ4n0GzDAbmRksj4FPkDrF5sNskOcvFULMCmS/v
         gxWaezPseCV4w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:53 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 31, 2020 at 07:40:27PM -0800, John Hubbard wrote:
>> diff --git a/mm/gup.c b/mm/gup.c
>> index c10d0d051c5b..9fe61d15fc0e 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -29,6 +29,19 @@ struct follow_page_context {
>>  	unsigned int page_mask;
>>  };
>>  
>> +#ifdef CONFIG_DEBUG_VM
> 
> Why under CONFIG_DEBUG_VM? There's nothing about this in the cover letter.
> 

Early on, gup_benchmark showed a really significant slowdown from using these 
counters. And I don't doubt that it's still the case.

I'll re-measure and add a short summary and a few numbers to the patch commit
description, and to the v4 cover letter.


thanks,
-- 
John Hubbard
NVIDIA

>> +static inline void __update_proc_vmstat(struct page *page,
>> +					enum node_stat_item item, int count)
>> +{
>> +	mod_node_page_state(page_pgdat(page), item, count);
>> +}
>> +#else
>> +static inline void __update_proc_vmstat(struct page *page,
>> +					enum node_stat_item item, int count)
>> +{
>> +}
>> +#endif
>> +
>>  static void hpage_pincount_add(struct page *page, int refs)
>>  {
>>  	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
