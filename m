Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB771511B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCVRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:17:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12229 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCVRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:17:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e388dde0000>; Mon, 03 Feb 2020 13:17:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:17:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 13:17:41 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:17:41 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b554db44-7315-b99f-1151-ba2a1b2445ce@nvidia.com>
Date:   Mon, 3 Feb 2020 13:17:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203135845.ymfbghs7rf67awex@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580764639; bh=2IB1FDGpBsDLtY2DmO1HxSdFOfS/ze4NUeLdmKESN3o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VA7dHTuJqfoBaZISH3ys3eVXPTLDIYenBIFXfe5Gpxpr9UcxwE2/bI3Sh1G/Imcmy
         024824qdOtSpR3aQovCzV8b2+dU2ioTH20o5wLjZdiS9HbXUnJoTUS7ljrcz16hgSr
         JOMEZ2EPl0r/SIkKsZT8Tz/Cb8aatw1oTjr9w1xRGY/BiKsakgTDubFWSE2ZROKHj2
         sVVgIGYqXYvDRyWNR7iSRSLUPGv61HWYWFhLQmTi4YZjlRKCQDfY53sV2RFLspz840
         8rEVpzEfC+yV6JKNLc66tAtJZl+42xdfklcghWejs8ZqrqrMPYc0KONH39P5vPLePe
         JZqZFv3XYqG/Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:58 AM, Kirill A. Shutemov wrote:
...
>> @@ -19,6 +21,48 @@ struct gup_benchmark {
>>  	__u64 expansion[10];	/* For future use */
>>  };
>>  
>> +static void put_back_pages(unsigned int cmd, struct page **pages,
>> +			   unsigned long nr_pages)
>> +{
>> +	int i;
>> +
>> +	switch (cmd) {
>> +	case GUP_FAST_BENCHMARK:
>> +	case GUP_LONGTERM_BENCHMARK:
>> +	case GUP_BENCHMARK:
>> +		for (i = 0; i < nr_pages; i++)
> 
> 'i' is 'int' and 'nr_pages' is 'unsigned long'.
> There's space for trouble :P
> 

Yes, I've changed it to "unsigned int", thanks.

>> +			put_page(pages[i]);
>> +		break;
>> +
>> +	case PIN_FAST_BENCHMARK:
>> +	case PIN_BENCHMARK:
>> +		unpin_user_pages(pages, nr_pages);
>> +		break;
>> +	}
>> +}
>> +
>> +static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>> +			      unsigned long nr_pages)
>> +{
>> +	int i;
>> +	struct page *page;
>> +
>> +	switch (cmd) {
>> +	case PIN_FAST_BENCHMARK:
>> +	case PIN_BENCHMARK:
>> +		for (i = 0; i < nr_pages; i++) {
> 
> Ditto.
> 

Fixed here also.


>> +			page = pages[i];
>> +			if (WARN(!page_maybe_dma_pinned(page),
>> +				 "pages[%d] is NOT dma-pinned\n", i)) {

...and changed to "pages[%u]", to match.


thanks,
-- 
John Hubbard
NVIDIA


>> +
>> +				dump_page(page, "gup_benchmark failure");
>> +				break;
>> +			}
>> +		}
>> +		break;
>> +	}
>> +}
>> +
>>  static int __gup_benchmark_ioctl(unsigned int cmd,
>>  		struct gup_benchmark *gup)
>>  {
> 
