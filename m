Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB748ABD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 02:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHMAJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 20:09:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18115 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfHMAJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:09:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d51ffa10000>; Mon, 12 Aug 2019 17:09:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 17:09:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 17:09:03 -0700
Received: from [10.2.165.207] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 13 Aug
 2019 00:09:02 +0000
Subject: Re: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
 <20190812015044.26176-3-jhubbard@nvidia.com>
 <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <38d2ff2f-4a69-e8bd-8f7c-41f1dbd80fae@nvidia.com>
Date:   Mon, 12 Aug 2019 17:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812234950.GA6455@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565654945; bh=/wUWIK2KCWN+EdOxtD3Lx3ieNzAYWw6oiQTfkMzs1z4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fabDrYOKwUNPuchzbriK5AMZnZocxegfpaGb1YYxCqXZ4wtcHIpx96Odw5k4ICzzT
         iZpl3veS/CAV9dLRwYMRBkNIHfdxLkUfpXyqIoX7MnrHx9s6pT4udv1r1a/a5c/3h5
         tZHPEp/ZLWCUEqqdJKpiANdAJLbkVzkBAV3TndttzDMnleK2AIW2H4b2DkINQlezTT
         BY2P2+pn0RTBJfIR0Wmogyu9RLO4dLaugR7l4KAw9fjioVlORt5yAHDM2QgWHJyzK5
         1JQeOscC3TwaeYqzJdN7IzLWb1tfFJadyhCYQA7OwMUGp3YXh4J32EZuea9IBQ1jgA
         GWeSN2C/h30cw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/19 4:49 PM, Ira Weiny wrote:
> On Sun, Aug 11, 2019 at 06:50:44PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
...
>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
>> index 53085896d718..fdff034a8a30 100644
>> --- a/drivers/infiniband/core/umem_odp.c
>> +++ b/drivers/infiniband/core/umem_odp.c
>> @@ -534,7 +534,7 @@ static int ib_umem_odp_map_dma_single_page(
>>   	}
>>   
>>   out:
>> -	put_user_page(page);
>> +	vaddr_unpin_pages(&page, 1, &umem_odp->umem.vaddr_pin);
>>   
>>   	if (remove_existing_mapping) {
>>   		ib_umem_notifier_start_account(umem_odp);
>> @@ -635,9 +635,10 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>>   		 * complex (and doesn't gain us much performance in most use
>>   		 * cases).
>>   		 */
>> -		npages = get_user_pages_remote(owning_process, owning_mm,
>> +		npages = vaddr_pin_pages_remote(owning_process, owning_mm,
>>   				user_virt, gup_num_pages,
>> -				flags, local_page_list, NULL, NULL);
>> +				flags, local_page_list, NULL, NULL,
>> +				&umem_odp->umem.vaddr_pin);
> 
> Thinking about this part of the patch... is this pin really necessary?  This
> code is not doing a long term pin.  The page just needs a reference while we
> map it into the devices page tables.  Once that is done we should get notifiers
> if anything changes and we can adjust.  right?
> 

OK, now it's a little interesting: the FOLL_PIN is necessary, but maybe not
FOLL_LONGTERM. Illustrating once again that it's actually necessary to allow
these flags to vary independently.

And that leads to another API refinement idea: let's set FOLL_PIN within the
vaddr_pin_pages*() wrappers, and set FOLL_LONGTER in the *callers* of those
wrappers, yes?

thanks,
-- 
John Hubbard
NVIDIA
