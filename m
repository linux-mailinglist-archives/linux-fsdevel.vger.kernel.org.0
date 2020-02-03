Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D915119D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 22:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCVJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 16:09:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13912 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCVJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:09:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e388c080000>; Mon, 03 Feb 2020 13:09:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 13:09:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Feb 2020 13:09:42 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 21:09:42 +0000
Subject: Re: [PATCH v3 02/12] mm/gup: split get_user_pages_remote() into two
 routines
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
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-3-jhubbard@nvidia.com>
 <20200203142006.GD18591@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <60244a5c-d9ce-3378-8b63-e375a8a826aa@nvidia.com>
Date:   Mon, 3 Feb 2020 13:09:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203142006.GD18591@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580764168; bh=kpWnZhJDLnwzJeCQh1dwd9e6bKzAJzhKv9o/97r5OI0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YH9V1pSt2yGSRfcnvkLj5tT6FBzhIwJQJ56FUgxRc8hYBKm7TxhXdfMeU2lgH68TE
         L288RKt6Lvjsk3MYx4/9ddBXeBvjPPiIwuTPerAMTh0E9xBfsQhQO5J4T0VabPLxjA
         y/VEM91iMYIRrfptXsdahVvFZ+cZ9j5Rsw6QG6S9p7D5DRqkCa/1rUKVsEtuiMdBcw
         E3U1uybj55n5poobVSezFD0PefdgdL00m4Yrq7M0h8IhdbLXakKlJulzehnzNs69pl
         VdwvdRFerroSQ7fkU+rts89SoqCVTCnppCuPc3MlebvcMtELddwIUM/57fXykEZvye
         CS78PTJYL5Pnw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 6:20 AM, Jan Kara wrote:
> On Fri 31-01-20 19:40:19, John Hubbard wrote:
>> An upcoming patch requires reusing the implementation of
>> get_user_pages_remote(). Split up get_user_pages_remote() into an outer
>> routine that checks flags, and an implementation routine that will be
>> reused. This makes subsequent changes much easier to understand.
>>
>> There should be no change in behavior due to this patch.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Thanks for reviewing this series (sort of again), Jan! 


thanks,
-- 
John Hubbard
NVIDIA
