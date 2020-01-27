Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566F314A9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 19:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA0SR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 13:17:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2578 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0SRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2f291e0001>; Mon, 27 Jan 2020 10:17:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jan 2020 10:17:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Jan 2020 10:17:52 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 18:17:51 +0000
Subject: Re: [PATCH 1/3] mm/gup: track FOLL_PIN pages
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
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-2-jhubbard@nvidia.com>
 <20200127110624.GD19414@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <132c05dc-ee18-029e-4f04-4a7cf532dd9d@nvidia.com>
Date:   Mon, 27 Jan 2020 10:17:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200127110624.GD19414@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580149023; bh=+ILbFzTvgHtPE4pnBXrv89ml3yzlDaNRNlBvHEV4G8E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ue5YGSxpthjQIeIHGLLT2HWwsc8wRNTAjufHDuRYSh7VVqcfZCJ3FMadpdE5GJFZJ
         KiLMgqJSfFD9Yle+/KhQYJ4wvAb+tIeXiiy7HGfGB8sC/fzQ6jKdb2O/AQfY784HqD
         eRVMs6DOCfl8v4aWj4JoWOhPJCiRTbiFmEM/RNmEbWS5mJHsRkB/3MAMdlYe6U8cik
         Y96tFaP+I/BRxeiDdTh8WmsoDCpx1P3N434Bg8X1xcVgIbsn4R9HN5py5t6d/tr5AU
         bsFOIQTl5NN4QnPcfGzmdmlkn0FM6/pgzbVUoi/T45tEgm8tTtHrGnLTrWwn0dEmgS
         Y9+zWPMs/nWxg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/20 3:06 AM, Jan Kara wrote:
> On Fri 24-01-20 18:11:13, John Hubbard wrote:
>> +static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>> +							  int refs,
>> +							  unsigned int flags)
>> +{
>> +	if (flags & FOLL_GET)
>> +		return try_get_compound_head(page, refs);
>> +	else if (flags & FOLL_PIN) {
>> +		int orig_refs = refs;
>> +
>> +		/*
>> +		 * When pinning a compound page of order > 1 (which is what
>> +		 * hpage_pincount_available() checks for), use an exact count to
>> +		 * track it, via hpage_pincount_inc/_dec().
>> +		 *
>> +		 * However, be sure to *also* increment the normal page refcount
>> +		 * field at least once, so that the page really is pinned.
>> +		 */
>> +		if (!hpage_pincount_available(page))
>> +			refs *= GUP_PIN_COUNTING_BIAS;
>> +
>> +		page = try_get_compound_head(page, refs);
>> +		if (!page)
>> +			return NULL;
>> +
>> +		if (hpage_pincount_available(page))
>> +			hpage_pincount_inc(page);
> 
> Umm, adding just 1 to pincount looks dangerous to me as
> try_grab_compound_head() would not compose - you could not release
> references acquired by try_grab_compound_head() with refs==2 by two calls
> to put_compound_head() with refs==1. So I'd rather have here:
> hpage_pincount_add(page, refs) and similarly in put_compound_head().
> Otherwise the patch looks good to me from a quick look.
> 
> 								Honza

Yes, you are right. The hpage_pincount really should track refs. I'll fix it
up.

thanks,
-- 
John Hubbard
NVIDIA
 
