Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B60256A8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgH2WIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 18:08:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7220 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH2WIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:08:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ad1610000>; Sat, 29 Aug 2020 15:06:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 15:08:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 29 Aug 2020 15:08:29 -0700
Received: from [10.2.61.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 22:08:28 +0000
Subject: Re: [PATCH v2 3/3] bio: convert get_user_pages_fast() -->
 pin_user_pages_fast()
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-4-jhubbard@nvidia.com>
 <20200829150223.GC12470@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <95880e98-f4d6-add1-db96-ae349064d3c6@nvidia.com>
Date:   Sat, 29 Aug 2020 15:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200829150223.GC12470@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598738785; bh=prw38Q2A3ZZ+rOHUhaGtFVP9FzXw/WOtwBNM0K0dXqc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cmCW/N36vGdG5BvU4mtxJvp2EBjq5feBrcE15+24CUg8gsHL7R9Ml6tvtSvVZDC3V
         C5cWuWNj9/fFSaSox6IK8bcBxmU6Ji72Nj1th3n+XsSgv6bPBsG7wPFosqgf7Mi636
         ULH/I8q6JRheOie5rqqyXQ8jzKdVvVkRKnIo1uOz50Ckb670Dq4FoVvxSYuJOu0e3X
         kRa9THr9jTPRON+e5X+v5Vbc8a9J9ISJbhLWH3MIKsI3hgIS9qYQbef8M11D7QkU2j
         KVZe2lHZrN42XOSVVGaXHO+rDdktsBOq5ORqg8QjDME0O60/AJvX9UG+fF8s6S6vKK
         0IO4i2sVBJlnA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/29/20 8:02 AM, Christoph Hellwig wrote:
>> -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
>> +	size = iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> 
> This is really a comment to the previous patch, but I only spotted it
> here:  I think the right name is iov_iter_pin_pages, as bvec, kvec and
> pipe aren't usually user pages.  Same as iov_iter_get_pages vs
> get_user_pages.  Same for the _alloc variant.
> 

Yes, it is clearly misnamed now! Will fix.

>> + * here on.  It will run one unpin_user_page() against each page
>> + * and will run one bio_put() against the BIO.
> 
> Nit: the ant and the will still fit on the previous line.
> 

Sorry about that, *usually* my text editor does the Right Thing for
those, I must have interfered with the natural flow of things. :)


thanks,
-- 
John Hubbard
NVIDIA
