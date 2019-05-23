Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA02228A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfEWTPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:15:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18171 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388854AbfEWTPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:15:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce6f1330000>; Thu, 23 May 2019 12:14:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 12:14:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 12:14:58 -0700
Received: from [10.2.169.219] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 19:14:55 +0000
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
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
 <fa6d7d7c-13a3-0586-6384-768ebb7f0561@nvidia.com>
 <20190523190423.GA19578@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0bd9859f-8eb0-9148-6209-08ae42665626@nvidia.com>
Date:   Thu, 23 May 2019 12:13:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523190423.GA19578@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558638899; bh=UY9XbZfKozlXpv9o2aoFRaWDQi9QopjyohU9JWXzpVU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UlCyETzzaQ69ETX9skUfRlp0Ws2f09G7a7Bo59JXjJY1SksQCN3vi04EoWKN1tvVl
         PAfg85V2edI4mXiPrL8gXtNMDIGUxlnfsB/Y5Gt1KIPk93HEXlTyxEe74zL6C83bay
         lKplan6XSz4t9SXkpPiusZV0sHa3T3DIyhLKSsi+X1N7GPOxl6CA9cinVOQIc/Jjgi
         va00dxw7OuhfxA3TRaC8QAT0LuO8Ar1NeyHIkLL9V+4EjyelkCa6anmoR+UnQKynzv
         qVyaad9/48fczyD2gljFaUj7ZPCfUErO+gd5Rzw+pEJKWjJRMSotrrnRsb9C0s497M
         FCPLVt3uXeQUQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/19 12:04 PM, Ira Weiny wrote:
> On Thu, May 23, 2019 at 10:46:38AM -0700, John Hubbard wrote:
>> On 5/23/19 10:32 AM, Jason Gunthorpe wrote:
>>> On Thu, May 23, 2019 at 10:28:52AM -0700, Ira Weiny wrote:
>>>>> @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>>>>>    			 * ib_umem_odp_map_dma_single_page().
>>>>>    			 */
>>>>>    			if (npages - (j + 1) > 0)
>>>>> -				release_pages(&local_page_list[j+1],
>>>>> -					      npages - (j + 1));
>>>>> +				put_user_pages(&local_page_list[j+1],
>>>>> +					       npages - (j + 1));
>>>>
>>>> I don't know if we discussed this before but it looks like the use of
>>>> release_pages() was not entirely correct (or at least not necessary) here.  So
>>>> I think this is ok.
>>>
>>> Oh? John switched it from a put_pages loop to release_pages() here:
>>>
>>> commit 75a3e6a3c129cddcc683538d8702c6ef998ec589
>>> Author: John Hubbard <jhubbard@nvidia.com>
>>> Date:   Mon Mar 4 11:46:45 2019 -0800
>>>
>>>       RDMA/umem: minor bug fix in error handling path
>>>       1. Bug fix: fix an off by one error in the code that cleans up if it fails
>>>          to dma-map a page, after having done a get_user_pages_remote() on a
>>>          range of pages.
>>>       2. Refinement: for that same cleanup code, release_pages() is better than
>>>          put_page() in a loop.
>>>
>>> And now we are going to back something called put_pages() that
>>> implements the same for loop the above removed?
>>>
>>> Seems like we are going in circles?? John?
>>>
>>
>> put_user_pages() is meant to be a drop-in replacement for release_pages(),
>> so I made the above change as an interim step in moving the callsite from
>> a loop, to a single call.
>>
>> And at some point, it may be possible to find a way to optimize put_user_pages()
>> in a similar way to the batching that release_pages() does, that was part
>> of the plan for this.
>>
>> But I do see what you mean: in the interim, maybe put_user_pages() should
>> just be calling release_pages(), how does that change sound?
> 
> I'm certainly not the expert here but FWICT release_pages() was originally
> designed to work with the page cache.
> 
> aabfb57296e3  mm: memcontrol: do not kill uncharge batching in free_pages_and_swap_cache
> 
> But at some point it was changed to be more general?
> 
> ea1754a08476 mm, fs: remove remaining PAGE_CACHE_* and page_cache_{get,release} usage
> 
> ... and it is exported and used outside of the swapping code... and used at
> lease 1 place to directly "put" pages gotten from get_user_pages_fast()
> [arch/x86/kvm/svm.c]
> 
>  From that it seems like it is safe.
> 
> But I don't see where release_page() actually calls put_page() anywhere?  What
> am I missing?
> 

For that question, I recall having to look closely at this function, as well:

void release_pages(struct page **pages, int nr)
{
	int i;
	LIST_HEAD(pages_to_free);
	struct pglist_data *locked_pgdat = NULL;
	struct lruvec *lruvec;
	unsigned long uninitialized_var(flags);
	unsigned int uninitialized_var(lock_batch);

	for (i = 0; i < nr; i++) {
		struct page *page = pages[i];

		/*
		 * Make sure the IRQ-safe lock-holding time does not get
		 * excessive with a continuous string of pages from the
		 * same pgdat. The lock is held only if pgdat != NULL.
		 */
		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
			spin_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
			locked_pgdat = NULL;
		}

		if (is_huge_zero_page(page))
			continue;

		/* Device public page can not be huge page */
		if (is_device_public_page(page)) {
			if (locked_pgdat) {
				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
						       flags);
				locked_pgdat = NULL;
			}
			put_devmap_managed_page(page);
			continue;
		}

		page = compound_head(page);
		if (!put_page_testzero(page))

		     ^here is where it does the put_page() call, is that what
			you were looking for?



thanks,
-- 
John Hubbard
NVIDIA
