Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD2159F03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 03:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBLCKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 21:10:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10912 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBLCKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:10:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e435e6b0000>; Tue, 11 Feb 2020 18:09:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 11 Feb 2020 18:10:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 11 Feb 2020 18:10:51 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 02:10:51 +0000
Subject: Re: [PATCH v6 12/12] mm: dump_page(): additional diagnostics for huge
 pinned pages
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
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-13-jhubbard@nvidia.com>
 <20200211132159.pii2x5pssifemgaz@box>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <909f4ad5-128f-b4bd-e4cb-787885167a97@nvidia.com>
Date:   Tue, 11 Feb 2020 18:10:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211132159.pii2x5pssifemgaz@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581473388; bh=zCZhatfwPo+VLNp+cEurTVm8c4ASNzi1xPIVnn9hsG4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KPfg4MObEIiKHoeHFaJJrWQ8njdIGT3atUWt2b4jjTApxYejTmazQdE0YwMrBuFKU
         3i/G5o9jjd6ioP0Qi2W/rUjSr00msSRFXATO/5rNEQ7DmoOJMKI37ZOJVs8SZHCmVU
         blSLD+y8cV0ai0JTOpf3gRqP3613aMkN7Wiqb69HyX0DDCJPPKFj/TYL7jfNr87yWY
         q37kkzihJidOZqNjw1XmMcIbjHjswPB2bRGry8NZkq9bXL4NReTx1MJk/Z1MLjIDdG
         YKIMBb2eV93ApkPqaCI7R9IFDMlf3cKAs3qmM6FxY0PkH5G8/SVcHRa8M4LKHCtWB+
         EblOFHEBRSltw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/11/20 5:21 AM, Kirill A. Shutemov wrote:
...
>> diff --git a/mm/debug.c b/mm/debug.c
>> index f5ffb0784559..2189357f0987 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -85,11 +85,22 @@ void __dump_page(struct page *page, const char *reason)
>>  	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
>>  
>>  	if (compound)
>> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
>> -			"index:%#lx head:%px order:%u compound_mapcount:%d\n",
>> -			page, page_ref_count(head), mapcount,
>> -			mapping, page_to_pgoff(page), head,
>> -			compound_order(head), compound_mapcount(page));
>> +		if (hpage_pincount_available(page)) {
>> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
>> +				"index:%#lx head:%px order:%u "
>> +				"compound_mapcount:%d compound_pincount:%d\n",
>> +				page, page_ref_count(head), mapcount,
>> +				mapping, page_to_pgoff(page), head,
>> +				compound_order(head), compound_mapcount(page),
>> +				compound_pincount(page));
>> +		} else {
>> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%p "
>> +				"index:%#lx head:%px order:%u "
>> +				"compound_mapcount:%d\n",
>> +				page, page_ref_count(head), mapcount,
>> +				mapping, page_to_pgoff(page), head,
>> +				compound_order(head), compound_mapcount(page));
>> +		}
> 
> Have you considered using pr_cont() here. I guess it would be easier to
> read.

Yes, and it does have the advantage of removing some of the code duplication above. 
On the other hand, though, it leaves the end result (the long lines being printed) 
the same, and introduces a window in which the output can get garbled by another 
thread that is printk'-ing. And actually, what I'd really like is to shorten the
printed output lines, as I mentioned in [1].

So overall, given that this series has been fairly difficult to get finalized, 
and it's now in Andrew's tree at last, I'd *really* like to leave it as-is right 
now, and build on top of it. So I will submit a follow-on patch to formally propose
shortening the printed lines, and that can live or die independently of this series,
which is hopefully over now.

> 
> You can use my Ack anyway.


Thanks, and I appreciate all of your reviews and bug spotting and ideas for improvements 
on this series, it's been really helpful.


> 
> 
>>  	else
>>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
>>  			page, page_ref_count(page), mapcount,
>> -- 
>> 2.25.0
>>
> 


[1] https://lore.kernel.org/r/96e1f693-0e7b-2817-f13d-1946ff7654a1@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA
