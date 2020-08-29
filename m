Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C2256A82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 23:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgH2V6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 17:58:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7605 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH2V6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:58:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4acf880000>; Sat, 29 Aug 2020 14:58:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 14:58:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 29 Aug 2020 14:58:46 -0700
Received: from [10.2.61.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 21:58:45 +0000
Subject: Re: [PATCH v2 2/3] iov_iter: introduce iov_iter_pin_user_pages*()
 routines
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-3-jhubbard@nvidia.com>
 <20200829145849.GB12470@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <dc7e5dde-9dc0-7d56-48de-777a2e50bca5@nvidia.com>
Date:   Sat, 29 Aug 2020 14:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200829145849.GB12470@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598738312; bh=aSvyS+id93OVh4JwogVMxYI/9LBVJ/hSdCzKyqQGRuA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=azZ7LMHLvdHSTmMoqbkanG4zkj/fKCi5nRHMgQdWdLNBpfQXJPA3PTHAXkjjguSA0
         Jtyd6KgTRVlPtQd3wsuGRh6oqfyIyIZdStnwo784JRXEKPA/yM3T4UUOcl2j49RqX0
         jfwUGTlHk5Co4swuSNfb+N1BTkhM1GcmHli/Y0dPkshcYN+VHyDzGr1xP3fiPZ5L9D
         T7iDUrHR1wJP3mwHMOkTqo7hIFy3GPtCz6pNdc9p2oA/llNVMmyX7bTDWx4EFP4oWJ
         ULq6Cg0Vgo2l0lYIZYE/2Dpq3gmEEYx/wl0jgtnb5qc9u/Q4Dq+Yc4p4oKSWA03WRo
         etJu1FnSVCC/g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/29/20 7:58 AM, Christoph Hellwig wrote:
> On Sat, Aug 29, 2020 at 01:08:52AM -0700, John Hubbard wrote:
...
>> @@ -1280,7 +1281,11 @@ static inline ssize_t __pipe_get_pages(struct iov_iter *i,
>>   	maxsize = n;
>>   	n += *start;
>>   	while (n > 0) {
>> -		get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
>> +		if (use_pup)
>> +			pin_user_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
>> +		else
>> +			get_page(*pages++ = pipe->bufs[iter_head & p_mask].page);
> 
> Maybe this would become a little more readable with a local variable
> and a little more verbosity:
> 
> 		struct page *page = pipe->bufs[iter_head & p_mask].page;
> 
> 		if (use_pup)
> 			pin_user_page(page);
> 		else
> 			get_page(page);
> 
> 		*pages++ = page;
> 

Yes, that is cleaner, I'll change to that, thanks.

thanks,
-- 
John Hubbard
NVIDIA
