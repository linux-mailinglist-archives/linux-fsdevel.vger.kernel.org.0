Return-Path: <linux-fsdevel+bounces-38691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A9A06AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E811886FC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB51422D4;
	Thu,  9 Jan 2025 02:27:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C113A26D;
	Thu,  9 Jan 2025 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389620; cv=none; b=PbxAsjR0jwImeehrqNuNvTpyHbT2x3p9mt14KXIV9b4+I3Mk2ZbfPeErJ3HpUA0/kA+o1hHr1jtdJImH6SPJEqzIJTejERUYOdL2fqzGMiajphKY9b5nUw6ADiS9vwAEAENsngENmmEIOZ94BTb52CRO+EyxcrMK/HWoLEBNLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389620; c=relaxed/simple;
	bh=Mz0ho6wNcmmRUFppI5RY+Mgz0y94H2qe68tpL2oT7vQ=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pn5tNXSSu8GF83iP8nmpomOtoTMwILZl91QK4yB9+eYfj9hB8qX1TFo+5QgZat1ecWoNj8O3vqa3dW8kNe6hnPMLsBdU5SQ0FYMer0PoP2op8A0tEgCp4COSa85cvA/ZRidAfPLZPODEclmLHgxyZ5Jn8w26Pv1Z6HOWJokrslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YT7qh6fqxzjYB7;
	Thu,  9 Jan 2025 10:23:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id C86EE140382;
	Thu,  9 Jan 2025 10:26:55 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:26:52 +0800
Subject: Re: [PATCH v4 -next 08/15] mm: nommu: move sysctl to mm/nommu.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <20241223141550.638616-9-yukaixiong@huawei.com>
 <93c2a55b-3f3b-488e-9156-0a7726f30be3@lucifer.local>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <1959b553-decd-7525-865e-425776841833@huawei.com>
Date: Thu, 9 Jan 2025 10:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <93c2a55b-3f3b-488e-9156-0a7726f30be3@lucifer.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/2 22:09, Lorenzo Stoakes wrote:
> On Mon, Dec 23, 2024 at 10:15:27PM +0800, Kaixiong Yu wrote:
>> The sysctl_nr_trim_pages belongs to nommu.c, move it to mm/nommu.c
>> from /kernel/sysctl.c. And remove the useless extern variable declaration
>> from include/linux/mm.h
>>
>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Looks good to me,
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Thanks for your review !

Best ...
>> ---
>> v4:
>>   - const qualify struct ctl_table nommu_table
>> v3:
>>   - change the title
>> v2:
>>   - fix the build error: expected ';' after top level declarator
>>   - fix the build error: call to undeclared function 'register_syscall_init',
>>     use 'register_sysctl_init' to replace it.
>> ---
>> ---
>>   include/linux/mm.h |  2 --
>>   kernel/sysctl.c    | 10 ----------
>>   mm/nommu.c         | 15 ++++++++++++++-
>>   3 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b3b87c1dc1e4..9813b5b9c093 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4080,8 +4080,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
>>   				      pgoff_t first_index, pgoff_t nr);
>>   #endif
>>
>> -extern int sysctl_nr_trim_pages;
>> -
>>   #ifdef CONFIG_PRINTK
>>   void mem_dump_obj(void *object);
>>   #else
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 62a58e417c40..97f9abffff0f 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2031,16 +2031,6 @@ static struct ctl_table vm_table[] = {
>>   		.extra1		= SYSCTL_ONE,
>>   		.extra2		= SYSCTL_FOUR,
>>   	},
>> -#ifndef CONFIG_MMU
>> -	{
>> -		.procname	= "nr_trim_pages",
>> -		.data		= &sysctl_nr_trim_pages,
>> -		.maxlen		= sizeof(sysctl_nr_trim_pages),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -	},
>> -#endif
> Of course later on in the series you do what I asked in a previous commit :P Nice.
>
>>   	{
>>   		.procname	= "vfs_cache_pressure",
>>   		.data		= &sysctl_vfs_cache_pressure,
>> diff --git a/mm/nommu.c b/mm/nommu.c
>> index baa79abdaf03..3c32f8b1eb54 100644
>> --- a/mm/nommu.c
>> +++ b/mm/nommu.c
>> @@ -48,7 +48,6 @@ struct page *mem_map;
>>   unsigned long max_mapnr;
>>   EXPORT_SYMBOL(max_mapnr);
>>   unsigned long highest_memmap_pfn;
>> -int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
>>   int heap_stack_gap = 0;
>>
>>   atomic_long_t mmap_pages_allocated;
>> @@ -392,6 +391,19 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>>   	return mm->brk = brk;
>>   }
>>
>> +static int sysctl_nr_trim_pages = CONFIG_NOMMU_INITIAL_TRIM_EXCESS;
>> +
>> +static const struct ctl_table nommu_table[] = {
>> +	{
>> +		.procname	= "nr_trim_pages",
>> +		.data		= &sysctl_nr_trim_pages,
>> +		.maxlen		= sizeof(sysctl_nr_trim_pages),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +	},
>> +};
>> +
>>   /*
>>    * initialise the percpu counter for VM and region record slabs
>>    */
>> @@ -402,6 +414,7 @@ void __init mmap_init(void)
>>   	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
>>   	VM_BUG_ON(ret);
>>   	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
>> +	register_sysctl_init("vm", nommu_table);
>>   }
>>
>>   /*
>> --
>> 2.34.1
>>
> .
>


