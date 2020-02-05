Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0B153BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 00:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBEXNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 18:13:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1635 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:13:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b4c000000>; Wed, 05 Feb 2020 15:13:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 15:13:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 15:13:28 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb
 2020 23:13:28 +0000
Subject: Re: [PATCH v4 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
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
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-11-jhubbard@nvidia.com>
 <20200205093733.GB28058@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <09b49b0d-85cc-87b8-9176-0963f6c8c735@nvidia.com>
Date:   Wed, 5 Feb 2020 15:13:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205093733.GB28058@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580944384; bh=QZo2rYgRggJLhdhuOglfdT26CygAzcQcsm1mvo4G27A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rET6ClPJ1i9ucTvvRWF/1/c462K2mCH6nZx8WiCBRBOHIYQjg+sBdCGrPEtzpJsKC
         oKyCPZwjz3pxDIMTZQ64WUhXMxGUcmo2sbbCBiqNCUtVm8IDqmSKyYGkw81oZa918B
         N0ScNcSKXjJywqnA2ZRAnUbR9x/eLSSwDq662e/d+ttmimG7GT1j+2mJRKDHI6zZbH
         86HZzVIKep/0LUPMJQsvDeV54HT0Y46r7c6qo8I9SUAiapmADqg+pUsaOz9YoF0uW1
         Jn2PUL4F9EQ2HxmAkHcoSFDySLMhNHZs2ZqJAAvZxFMlEtNxpUbGKwxFOdO35tSUdu
         Cvzd7Xz67EEww==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/20 1:37 AM, Jan Kara wrote:
> ...
> 
>> @@ -104,6 +106,9 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>>  		if (hpage_pincount_available(page))
>>  			hpage_pincount_add(page, refs);
>>  
>> +		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
>> +				    orig_refs);
>> +
>>  		return page;
>>  	}
>>  
> 
> It seems to me you miss mod_node_page_state() in put_compound_head(), don't
> you?


Yes, that was definitely missing. I've added this for the next version:


diff --git a/mm/gup.c b/mm/gup.c
index 7c543849181b..ae503c51bc7f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2268,6 +2268,8 @@ static int record_subpages(struct page *page, unsigned long addr,
 
 static void put_compound_head(struct page *page, int refs, unsigned int flags)
 {
+       int orig_refs = refs;
+
        if (flags & FOLL_PIN) {
                if (hpage_pincount_available(page))
                        hpage_pincount_sub(page, refs);
@@ -2283,6 +2285,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
        if (refs > 1)
                page_ref_sub(page, refs - 1);
        put_page(page);
+
+       mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, orig_refs);
 }
 
 #ifdef CONFIG_ARCH_HAS_HUGEPD



> 
> Otherwise I like the new stat names better :).
> 
> 								Honza
> 

Glad to hear that! :)

thanks,
-- 
John Hubbard
NVIDIA
