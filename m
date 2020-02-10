Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5091580C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 18:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBJRKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 12:10:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17750 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgBJRKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e418e300000>; Mon, 10 Feb 2020 09:09:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 09:10:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 09:10:07 -0800
Received: from [10.2.168.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 17:10:07 +0000
Subject: Re: [PATCH v5 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
To:     Jan Kara <jack@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-11-jhubbard@nvidia.com>
 <20200210101629.GC12923@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7fcc15f4-e548-78bc-788d-f93293a1be74@nvidia.com>
Date:   Mon, 10 Feb 2020 09:07:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210101629.GC12923@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581354545; bh=GFFwsx57sCxj2sUkp7PeUAMx5ZDz2er8KdXyQLBksyc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mgiGuvh4a8/j5qP8rVJeI+8VQbHf2jVdOGqN8dzHXZ+aeb7PZyeJbMOhxY+1OUqQ5
         e12UVW9rEfOpg4y6UBRpdDTiOg0K2Lz6Jd2BtFewg+9KyFwPzPT7AP3Wzt6s+CkwmB
         rUuU0Q0ki0c9cXfzej3YnAfaBNDiecxV+Lx5Xmw8bNccE+px/ak0HTpJUmMOyZ0hgK
         9nmpeudR7hWQ2f8b5IKfN1LJlE+w/bvqIwHXLJmN2ZGvt0UHj2RPFjU2kgHWUG+2cM
         wTUjRMQp5P5znDTg5h0Rzk288BjQiK8Jkvj7oxWo3tMlHRD66hPcedX3dSQGyreutP
         p41fLIcZHUnWg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/20 2:16 AM, Jan Kara wrote:
> On Thu 06-02-20 19:37:33, John Hubbard wrote:
>> @@ -2258,6 +2268,8 @@ static int record_subpages(struct page *page, unsigned long addr,
>>   
>>   static void put_compound_head(struct page *page, int refs, unsigned int flags)
>>   {
>> +	int orig_refs = refs;
>> +
>>   	if (flags & FOLL_PIN) {
>>   		if (hpage_pincount_available(page))
>>   			hpage_pincount_sub(page, refs);
>> @@ -2273,6 +2285,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>>   	if (refs > 1)
>>   		page_ref_sub(page, refs - 1);
>>   	put_page(page);
>> +
>> +	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, orig_refs);
>>   }
> 
> Still not quite happy about this :) Now you update NR_FOLL_PIN_RELEASED
> even if 'flags' don't have FOLL_PIN set. You need to have the
> mod_node_page_state() inside the "if (flags & FOLL_PIN)" branch above...
> 
> 									Honza

Arggh, yes that's true. Thanks for catching that, will fix in v6.


thanks,
-- 
John Hubbard
NVIDIA
  
