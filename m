Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D631D151085
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCTvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 14:51:13 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9009 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:51:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3879a10000>; Mon, 03 Feb 2020 11:50:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 11:51:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 11:51:12 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 19:51:11 +0000
Subject: Re: [PATCH v3 01/12] mm: dump_page(): better diagnostics for compound
 pages
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
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-2-jhubbard@nvidia.com>
 <20200203131649.vptndo5emkzlaiew@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a7dac2ef-8bcd-8733-538b-aaf8fd78afd0@nvidia.com>
Date:   Mon, 3 Feb 2020 11:51:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203131649.vptndo5emkzlaiew@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580759458; bh=Om5ywZkbDxRtggdzaOXy9Ggbi/ijdQm1SzF2EbMQjvE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JZ+vJMdEOrhiJ6u+ixbDu+ykSCYgGe0zfRWhBa+YB16WJUMis+trY05H4GdDlg+X7
         IVcaOD/Hm6olIcNqlHGSt/klZCFNQZJ0vkDvije+8iTli+gA/iWIUzL68oq7b0Azgc
         kY8aza39yGcjUOMreZRuzLuUoqDterhy9Ls4Pp5KCFcPyCIecnv9U2Ul+x+SjlyFDX
         /jSyXFu0Da4rCeoY5CoHR3oKYl1ekQw0eTAC95imMO8NKW+XHbYotdcPEwZZVHsg/d
         jhfIGMZ5J+zgAgFDhfPoYt2D0JL6vSoanu1gNVdEVK1SqsZLfw6OKyenfQCvn/C27O
         J1p8xF2UtjsxA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:16 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 31, 2020 at 07:40:18PM -0800, John Hubbard wrote:
>> A compound page collects the refcount in the head page, while leaving
>> the refcount of each tail page at zero. Therefore, when debugging a
>> problem that involves compound pages, it's best to have diagnostics that
>> reflect that situation. However, dump_page() is oblivious to these
>> points.
>>
>> Change dump_page() as follows:
>>
>> 1) For tail pages, print relevant head page information: refcount, in
>>    particular. But only do this if the page is not corrupted so badly
>>    that the pointer to the head page is all wrong.
>>
>> 2) Do a separate check to catch any (rare) cases of the tail page's
>>    refcount being non-zero, and issue a separate, clear pr_warn() if
>>    that ever happens.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks for looking through all of these!

> 
> Few nit-picks below.
> 
>> ---
>>  mm/debug.c | 34 ++++++++++++++++++++++++++++------
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index ecccd9f17801..beb1c59d784b 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -42,6 +42,32 @@ const struct trace_print_flags vmaflag_names[] = {
>>  	{0, NULL}
>>  };
>>  
>> +static void __dump_tail_page(struct page *page, int mapcount)
>> +{
>> +	struct page *head = compound_head(page);
>> +
>> +	if ((page < head) || (page >= head + MAX_ORDER_NR_PAGES)) {
> 
> I'm not sure if we want to use compound_nr() here instead of
> MAX_ORDER_NR_PAGES. Do you have any reasonaing about it?


Yes: compound_nr(page) reads from the struct page, whereas MAX_ORDER_NR_PAGES
is an independent, immutable limit. When checking a struct page for corruption,
it's ideal to avoid relying on data within the struct page, as compound_nr()
would have to do.


> 
>> +		/*
>> +		 * Page is hopelessly corrupted, so limit any reporting to
>> +		 * information about the page itself. Do not attempt to look at
>> +		 * the head page.
>> +		 */
>> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
>> +			"index:%#lx (corrupted tail page case)\n",
>> +			page, page_ref_count(page), mapcount, page->mapping,
>> +			page_to_pgoff(page));
>> +	} else {
>> +		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
>> +			"index:%#lx compound_mapcount:%d\n",
>> +			page, page_ref_count(head), mapcount, head->mapping,
>> +			page_to_pgoff(head), compound_mapcount(page));
>> +	}
>> +
>> +	if (page_ref_count(page) != 0)
>> +		pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on this "
>> +			"tail page\n", page, page_ref_count(page));
> 
> Wrap into {}, please.


Fixed, thanks.


thanks,
-- 
John Hubbard
NVIDIA
