Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFDD0CAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfJIKUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 06:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfJIKUF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:20:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89F993082135;
        Wed,  9 Oct 2019 10:20:04 +0000 (UTC)
Received: from [10.36.116.112] (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A0D460BF4;
        Wed,  9 Oct 2019 10:20:00 +0000 (UTC)
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Alexey Dobriyan <adobriyan@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
References: <20191009091205.11753-1-david@redhat.com>
 <20191009093756.GV6681@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <67aeaacc-d850-5c81-bd17-e95c7f7f75df@redhat.com>
Date:   Wed, 9 Oct 2019 12:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009093756.GV6681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 09 Oct 2019 10:20:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.10.19 11:37, Michal Hocko wrote:
> On Wed 09-10-19 11:12:04, David Hildenbrand wrote:
>> There are various places where we access uninitialized memmaps, namely:
>> - /proc/kpagecount
>> - /proc/kpageflags
>> - /proc/kpagecgroup
>> - memory_failure() - which reuses stable_page_flags() from fs/proc/page.c
>>
>> We have initialized memmaps either when the section is online or when
>> the page was initialized to the ZONE_DEVICE. Uninitialized memmaps contain
>> garbage and in the worst case trigger kernel BUGs, especially with
>> CONFIG_PAGE_POISONING.
>>
>> For example, not onlining a DIMM during boot and calling /proc/kpagecount
>> with CONFIG_PAGE_POISONING:
>> :/# cat /proc/kpagecount > tmp.test
>> [   95.600592] BUG: unable to handle page fault for address: fffffffffffffffe
>> [   95.601238] #PF: supervisor read access in kernel mode
>> [   95.601675] #PF: error_code(0x0000) - not-present page
>> [   95.602116] PGD 114616067 P4D 114616067 PUD 114618067 PMD 0
>> [   95.602596] Oops: 0000 [#1] SMP NOPTI
>> [   95.602920] CPU: 0 PID: 469 Comm: cat Not tainted 5.4.0-rc1-next-20191004+ #11
>> [   95.603547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
>> [   95.604521] RIP: 0010:kpagecount_read+0xce/0x1e0
>> [   95.604917] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 e7 48 c1 e7 06 48 03 3d ab 51 01 01 74 1d 48 8b 57 08 480
>> [   95.606450] RSP: 0018:ffffa14e409b7e78 EFLAGS: 00010202
>> [   95.606904] RAX: fffffffffffffffe RBX: 0000000000020000 RCX: 0000000000000000
>> [   95.607519] RDX: 0000000000000001 RSI: 00007f76b5595000 RDI: fffff35645000000
>> [   95.608128] RBP: 00007f76b5595000 R08: 0000000000000001 R09: 0000000000000000
>> [   95.608731] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
>> [   95.609327] R13: 0000000000020000 R14: 00007f76b5595000 R15: ffffa14e409b7f08
>> [   95.609924] FS:  00007f76b577d580(0000) GS:ffff8f41bd400000(0000) knlGS:0000000000000000
>> [   95.610599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   95.611083] CR2: fffffffffffffffe CR3: 0000000078960000 CR4: 00000000000006f0
>> [   95.611686] Call Trace:
>> [   95.611906]  proc_reg_read+0x3c/0x60
>> [   95.612228]  vfs_read+0xc5/0x180
>> [   95.612505]  ksys_read+0x68/0xe0
>> [   95.612785]  do_syscall_64+0x5c/0xa0
>> [   95.613092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Note that there are still two possible races as far as I can see:
>> - pfn_to_online_page() succeeding but the memory getting offlined and
>>   removed. get_online_mems() could help once we run into this.
>> - pfn_zone_device() succeeding but the memmap not being fully
>>   initialized yet. As the memmap is initialized outside of the memory
>>   hoptlug lock, get_online_mems() can't help.
>>
>> Let's keep the existing interfaces working with ZONE_DEVICE memory. We
>> can later come back and fix these rare races and eventually speed-up the
>> ZONE_DEVICE detection. This patch now also makes sure we don't dump data
>> about memory blocks that are already offline again.
> 
> As I've already expressed already I am not really happy to have explicit
> checks for zone device pages in pfn walkers. This is simply too fragile.
> 
> pfn_to_online_page makes sense because offline pages are not really in a
> defined state. This would be worth a patch of its own. I remember there

The issue is, once I check for pfn_to_online_page(), these functions
can't handle ZONE_DEVICE at all anymore. Especially in regards to
memory_failure() I don't think this is acceptable. So while I
(personally) only care about adding pfn_to_online_page() checks, the
in-this-sense-fragile-subsection ZONE_DEVICE implementation requires me
to introduce a temporary check for initialized memmaps.

> was a discussion about the uninitialized zone device memmaps. It would
> be really good to summarize this discussion in the changelog and
> conclude why the explicit check is really good and what were other
> alternatives considered.

Yeah, I also expressed my feelings and the issues to be solved by
ZONE_DEVICE people in https://lkml.org/lkml/2019/9/6/114. However, the
discussion stalled and nobody really proposed a solution or followed up.

I want to have this fixed now, as it is much easier to trigger with
"[PATCH v6 00/10] mm/memory_hotplug: Shrink zones before removing
memory" for !ZONE_DEVICE.

As we already do have a similar check (pfn_zone_device_reserved()) that
I merely convert for now, I will summarize and make it clearer that this
is something that should be reworked by ZONE_DEVICE people rather sooner
than later.

Thanks!

> 
> Thanks!
> 
>> Reported-by: Qian Cai <cai@lca.pw>
>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  fs/proc/page.c           | 12 ++++++------
>>  include/linux/memremap.h | 11 +++++++++--
>>  mm/memory-failure.c      | 22 ++++++++++++++++------
>>  mm/memremap.c            | 19 +++++++++++--------
>>  4 files changed, 42 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index decd3fe39674..76502af461e2 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -42,7 +42,8 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>  		return -EINVAL;
>>  
>>  	while (count > 0) {
>> -		if (pfn_valid(pfn))
>> +		if (pfn_valid(pfn) &&
>> +		    (pfn_to_online_page(pfn) || pfn_zone_device(pfn)))
>>  			ppage = pfn_to_page(pfn);
>>  		else
>>  			ppage = NULL;
>> @@ -97,9 +98,6 @@ u64 stable_page_flags(struct page *page)
>>  	if (!page)
>>  		return BIT_ULL(KPF_NOPAGE);
>>  
>> -	if (pfn_zone_device_reserved(page_to_pfn(page)))
>> -		return BIT_ULL(KPF_RESERVED);
>> -
>>  	k = page->flags;
>>  	u = 0;
>>  
>> @@ -218,7 +216,8 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
>>  		return -EINVAL;
>>  
>>  	while (count > 0) {
>> -		if (pfn_valid(pfn))
>> +		if (pfn_valid(pfn) &&
>> +		    (pfn_to_online_page(pfn) || pfn_zone_device(pfn)))
>>  			ppage = pfn_to_page(pfn);
>>  		else
>>  			ppage = NULL;
>> @@ -263,7 +262,8 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
>>  		return -EINVAL;
>>  
>>  	while (count > 0) {
>> -		if (pfn_valid(pfn))
>> +		if (pfn_valid(pfn) &&
>> +		    (pfn_to_online_page(pfn) || pfn_zone_device(pfn)))
>>  			ppage = pfn_to_page(pfn);
>>  		else
>>  			ppage = NULL;
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index c676e33205d3..c076bb163c2f 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -123,7 +123,8 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
>>  }
>>  
>>  #ifdef CONFIG_ZONE_DEVICE
>> -bool pfn_zone_device_reserved(unsigned long pfn);
>> +bool pfn_zone_device(unsigned long pfn);
>> +bool __pfn_zone_device(unsigned long pfn, struct dev_pagemap *pgmap);
>>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>>  void memunmap_pages(struct dev_pagemap *pgmap);
>>  void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>> @@ -134,7 +135,13 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
>>  void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
>>  #else
>> -static inline bool pfn_zone_device_reserved(unsigned long pfn)
>> +static inline bool pfn_zone_device(unsigned long pfn)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool __pfn_zone_device(unsigned long pfn,
>> +				     struct dev_pagemap *pgmap)
>>  {
>>  	return false;
>>  }
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7ef849da8278..2b4cc6b67720 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1161,6 +1161,14 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>  	loff_t start;
>>  	dax_entry_t cookie;
>>  
>> +	/* memmaps of driver reserved memory is not initialized */
>> +	if (!__pfn_zone_device(pfn, pgmap)) {
>> +		pr_err("Memory failure: %#lx: driver reserved memory\n",
>> +			pfn);
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>>  	/*
>>  	 * Prevent the inode from being freed while we are interrogating
>>  	 * the address_space, typically this would be handled by
>> @@ -1253,17 +1261,19 @@ int memory_failure(unsigned long pfn, int flags)
>>  	if (!sysctl_memory_failure_recovery)
>>  		panic("Memory failure on page %lx", pfn);
>>  
>> -	if (!pfn_valid(pfn)) {
>> +	p = pfn_to_online_page(pfn);
>> +	if (!p) {
>> +		if (pfn_valid(pfn)) {
>> +			pgmap = get_dev_pagemap(pfn, NULL);
>> +			if (pgmap)
>> +				return memory_failure_dev_pagemap(pfn, flags,
>> +								  pgmap);
>> +		}
>>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>>  			pfn);
>>  		return -ENXIO;
>>  	}
>>  
>> -	pgmap = get_dev_pagemap(pfn, NULL);
>> -	if (pgmap)
>> -		return memory_failure_dev_pagemap(pfn, flags, pgmap);
>> -
>> -	p = pfn_to_page(pfn);
>>  	if (PageHuge(p))
>>  		return memory_failure_hugetlb(pfn, flags);
>>  	if (TestSetPageHWPoison(p)) {
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 7fed8bd32a18..9f3bb223aec7 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -73,21 +73,24 @@ static unsigned long pfn_next(unsigned long pfn)
>>  	return pfn + 1;
>>  }
>>  
>> +bool __pfn_zone_device(unsigned long pfn, struct dev_pagemap *pgmap)
>> +{
>> +	return pfn >= pfn_first(pgmap) && pfn <= pfn_end(pgmap);
>> +}
>> +
>>  /*
>> - * This returns true if the page is reserved by ZONE_DEVICE driver.
>> + * Returns true if the page was initialized to the ZONE_DEVICE (especially,
>> + * is not reserved for driver usage).
>>   */
>> -bool pfn_zone_device_reserved(unsigned long pfn)
>> +bool pfn_zone_device(unsigned long pfn)
>>  {
>>  	struct dev_pagemap *pgmap;
>> -	struct vmem_altmap *altmap;
>> -	bool ret = false;
>> +	bool ret;
>>  
>>  	pgmap = get_dev_pagemap(pfn, NULL);
>>  	if (!pgmap)
>> -		return ret;
>> -	altmap = pgmap_altmap(pgmap);
>> -	if (altmap && pfn < (altmap->base_pfn + altmap->reserve))
>> -		ret = true;
>> +		return false;
>> +	ret = __pfn_zone_device(pfn, pgmap);
>>  	put_dev_pagemap(pgmap);
>>  
>>  	return ret;
>> -- 
>> 2.21.0
> 


-- 

Thanks,

David / dhildenb
