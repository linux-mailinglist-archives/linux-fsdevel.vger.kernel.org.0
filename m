Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D571510BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBCUDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:03:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9932 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCUDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:03:51 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e387c980000>; Mon, 03 Feb 2020 12:03:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 12:03:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 12:03:50 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 20:03:50 +0000
Subject: Re: [PATCH v3 04/12] mm: introduce page_ref_sub_return()
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
 <20200201034029.4063170-5-jhubbard@nvidia.com>
 <20200203132329.oj32h4ryna4gmkwh@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c9f4bb05-457d-a7ea-f449-dfb399facb3c@nvidia.com>
Date:   Mon, 3 Feb 2020 12:03:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203132329.oj32h4ryna4gmkwh@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580760216; bh=slWoAOjCgnvUbCzYd3p0ud2KsXbx4UbZ3i/D9mUZD1g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oVZNVkNOYc+kjHjL1ubbfOHYXpU03ACYQb+0iGYED3N00qAA3rTqLUI6W/FLL+/94
         /0KeKWTUWnMIexwZe5JmSqXp+kb8hJtQy0qeXMnTlnzW+b9F2iWiGnPnnt9cE9x8i/
         5STz78HwfzxwIVZPLujhbB4GRDXG5qsYqBngJ+h0QUog4ruNYP7jhqKRoTVJibYTtb
         a5Zzlj4qk7geaex9f3KLWk/NEEPuHZInTpHE7rcDuc1a+AITXTK3Kr/YvNFR/r+NMN
         W/eQjpACACV53Umd/t7HWidJT6UkHnNwf4WNStZTM+x7tku5YdYyA+1ka/W79nkeIP
         FYwSgB6uujrlg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:23 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 31, 2020 at 07:40:21PM -0800, John Hubbard wrote:
>> An upcoming patch requires subtracting a large chunk of refcounts from
>> a page, and checking what the resulting refcount is. This is a little
>> different than the usual "check for zero refcount" that many of the
>> page ref functions already do. However, it is similar to a few other
>> routines that (like this one) are generally useful for things such as
>> 1-based refcounting.
>>
>> Add page_ref_sub_return(), that subtracts a chunk of refcounts
>> atomically, and returns an atomic snapshot of the result.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  include/linux/page_ref.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
>> index 14d14beb1f7f..b9cbe553d1e7 100644
>> --- a/include/linux/page_ref.h
>> +++ b/include/linux/page_ref.h
>> @@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int nr)
>>  		__page_ref_mod(page, -nr);
>>  }
>>  
>> +static inline int page_ref_sub_return(struct page *page, int nr)
>> +{
>> +	int ret = atomic_sub_return(nr, &page->_refcount);
>> +
>> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
>> +		__page_ref_mod(page, -nr);
> 
> Shouldn't it be __page_ref_mod_and_return() and relevant tracepoint?


Why yes, it should. I didn't even notice that that more precise function existed,
thanks for catching that. I've changed it to this for the next version of the
patchset:

static inline int page_ref_sub_return(struct page *page, int nr)
{
	int ret = atomic_sub_return(nr, &page->_refcount);

	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
		__page_ref_mod_and_return(page, -nr, ret);
	return ret;
}



thanks,
-- 
John Hubbard
NVIDIA

> 
>> +
>> +	return ret;
>> +}
>> +
>>  static inline void page_ref_inc(struct page *page)
>>  {
>>  	atomic_inc(&page->_refcount);
>> -- 
>> 2.25.0
>>
> 
