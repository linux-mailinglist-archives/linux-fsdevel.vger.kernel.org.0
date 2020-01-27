Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3217914ABAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgA0VcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 16:32:14 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3437 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0VcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:32:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2f56ce0000>; Mon, 27 Jan 2020 13:31:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jan 2020 13:32:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Jan 2020 13:32:13 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 21:32:12 +0000
Subject: Re: [PATCH 2/3] mm/gup_benchmark: support pin_user_pages() and
 related calls
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
        <clang-built-linux@googlegroups.com>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125021115.731629-3-jhubbard@nvidia.com>
 <20200127205247.GA578@Ryzen-7-3700X.localdomain>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f81fab20-5d01-e782-d45e-c65f3e51beec@nvidia.com>
Date:   Mon, 27 Jan 2020 13:32:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200127205247.GA578@Ryzen-7-3700X.localdomain>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580160719; bh=LhTJ1/tn6kZiofE+Kr6/Zk0ukPrusIeEJQXQNfI3D4E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jH/aWVkDdLxaqW2OoiDKS+BWcTzIf6yve3rYKFXwVO1AZhn0Nwy2JTWjicRhjZuY1
         Pi+hqOq3waR9VenG24erVlsmk7iQeYRgu1pP7ltts7/OQPMIA+rvbeeTUagL2saVaE
         FBnndluKMcXFzDAFQky/RxazS2q9KA3wBbIybB+Kfhz3tbRIuyfADdixquzqbS3/ht
         QZfl17htJL+rpegeOpiLipRXjnoNuHjgUP9Ca/X1nMjNXf3tSK7aH/iP6Rl7FoPiAu
         msS9jWktPmaSnhFZgoUJpbqgbu0+9u2hZHo9iNoF23i2ahh7AfJza6/gl7ruiMf2Y6
         U6eqDh1wCGNIQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/20 12:52 PM, Nathan Chancellor wrote:
...
>> --- a/mm/gup_benchmark.c
>> +++ b/mm/gup_benchmark.c
>> @@ -8,6 +8,8 @@
>>  #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
>>  #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
>>  #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
>> +#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
>> +#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
>>  
>>  struct gup_benchmark {
>>  	__u64 get_delta_usec;
>> @@ -19,6 +21,47 @@ struct gup_benchmark {
>>  	__u64 expansion[10];	/* For future use */
>>  };
>>  
>> +static void put_back_pages(int cmd, struct page **pages, unsigned long nr_pages)
> 
> We received a Clang build report on this patch because the use of
> PIN_FAST_BENCHMARK and PIN_BENCHMARK in the switch statement below will
> overflow int; this should be unsigned int to match the cmd parameter in
> the ioctls.


Thanks for the report! Yes, that should have been "unsigned int cmd", to match the
one in the ioctls, just as you said.

I'll apply this diff, for the next version of the series:

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 3d5fb765e4e6..7d5573083ab3 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -21,7 +21,8 @@ struct gup_benchmark {
        __u64 expansion[10];    /* For future use */
 };
 
-static void put_back_pages(int cmd, struct page **pages, unsigned long nr_pages)
+static void put_back_pages(unsigned int cmd, struct page **pages,
+                          unsigned long nr_pages)
 {
        int i;
 
@@ -40,7 +41,7 @@ static void put_back_pages(int cmd, struct page **pages, unsigned long nr_pages)
        }
 }
 
-static void verify_dma_pinned(int cmd, struct page **pages,
+static void verify_dma_pinned(unsigned int cmd, struct page **pages,
                              unsigned long nr_pages)
 {
        int i;



thanks,
-- 
John Hubbard
NVIDIA
