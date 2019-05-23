Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6C28542
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfEWRrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:47:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13478 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbfEWRrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:47:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce6dcb50001>; Thu, 23 May 2019 10:47:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 10:47:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 10:47:38 -0700
Received: from [10.2.169.219] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 17:47:34 +0000
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
To:     Jason Gunthorpe <jgg@mellanox.com>, Ira Weiny <ira.weiny@intel.com>
CC:     "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Jan Kara" <jack@suse.cz>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
 <20190523173222.GH12145@mellanox.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
Date:   Thu, 23 May 2019 10:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523173222.GH12145@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558633653; bh=cJu+WJeaivnLRPXuXP9NC7KepKeSbgIbtxawo6JxqHQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FfbPZT6QVH6VAlR1feLRskrMhm5Y90TbypPeesLGrfGfd7gw4yml32K5pWQRTfTer
         D4rsycEUWb1uIuGiI+4NyFotZpYk072iAv6M8985uVUZB5YnFvYcHUzwdOgwYBYvk7
         Oie7zgGrFj5klPYmfYYnJLwI+Mge3sPjjJ59YitQTd/QDOLRYLZpNkZ9gYH2Sva3tp
         kd7kFGqP9BgfExZaQ8g6ePlt9zkuiWwkJurGW+wpfiR6jXlQTPjLzyq2/ZAvuAl/Gj
         VgraXs1B91kLLWDN9ZQ5eNpaxgFv9Xv1QqMz+EDdPjAXr0uclLOfBp+7vD31LhjHgI
         35gTwnCDBIXBQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/19 10:32 AM, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 10:28:52AM -0700, Ira Weiny wrote:
>>>   
>>> @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>>>   			 * ib_umem_odp_map_dma_single_page().
>>>   			 */
>>>   			if (npages - (j + 1) > 0)
>>> -				release_pages(&local_page_list[j+1],
>>> -					      npages - (j + 1));
>>> +				put_user_pages(&local_page_list[j+1],
>>> +					       npages - (j + 1));
>>
>> I don't know if we discussed this before but it looks like the use of
>> release_pages() was not entirely correct (or at least not necessary) here.  So
>> I think this is ok.
> 
> Oh? John switched it from a put_pages loop to release_pages() here:
> 
> commit 75a3e6a3c129cddcc683538d8702c6ef998ec589
> Author: John Hubbard <jhubbard@nvidia.com>
> Date:   Mon Mar 4 11:46:45 2019 -0800
> 
>      RDMA/umem: minor bug fix in error handling path
>      
>      1. Bug fix: fix an off by one error in the code that cleans up if it fails
>         to dma-map a page, after having done a get_user_pages_remote() on a
>         range of pages.
>      
>      2. Refinement: for that same cleanup code, release_pages() is better than
>         put_page() in a loop.
>      
> 
> And now we are going to back something called put_pages() that
> implements the same for loop the above removed?
> 
> Seems like we are going in circles?? John?
> 

put_user_pages() is meant to be a drop-in replacement for release_pages(),
so I made the above change as an interim step in moving the callsite from
a loop, to a single call.

And at some point, it may be possible to find a way to optimize put_user_pages()
in a similar way to the batching that release_pages() does, that was part
of the plan for this.

But I do see what you mean: in the interim, maybe put_user_pages() should
just be calling release_pages(), how does that change sound?


thanks,
-- 
John Hubbard
NVIDIA
