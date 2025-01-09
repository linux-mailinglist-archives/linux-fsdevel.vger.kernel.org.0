Return-Path: <linux-fsdevel+bounces-38690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A033A06AD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B335F18865A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153E5BAF0;
	Thu,  9 Jan 2025 02:20:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8005BE5E;
	Thu,  9 Jan 2025 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389226; cv=none; b=Nyj2ptLlLYxApwyFchThgmSaSZTXzMKyp+p5EjXcTDhETs1nkAUMTMYBZh+HzchV63v2PoK6FDEZxNtuIuhM3V9cK44OKSnsGwlzN+pi+8Y44pp8Os1BMawPNpd7Sr8EjuUuSPLCrzVxJb3FuImzlV0ucppkneCnWGZWz0cszOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389226; c=relaxed/simple;
	bh=/sQEQ5TutOnrYYS0lFylL2fbNiVpAWSQGdovRBLQkiA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MGAsQpnPMVnRuW5n/WgQKYKCOPygWrmGqUmWv0pVRp59POPgTMa+INXreK+IpxWc8Lw/Axc3VYD4Dp8dhahikKUR3ddl+kLwAjIfIwAVwAORicn8PWh3podW+uj6lT9pHUkkByMyncti4XruKJnB2k+dBz2hkgE6zYtOet8YKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YT7h55PQ3zjY89;
	Thu,  9 Jan 2025 10:16:37 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A0DFE1800D1;
	Thu,  9 Jan 2025 10:20:20 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:20:17 +0800
Subject: Re: [PATCH v4 -next 06/15] mm: mmap: move sysctl to mm/mmap.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <20241223141550.638616-7-yukaixiong@huawei.com>
 <ef1d602b-23cb-4a95-b83e-c506958dc90c@lucifer.local>
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
Message-ID: <66d64c25-5c82-1388-e09d-f49765efcfba@huawei.com>
Date: Thu, 9 Jan 2025 10:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ef1d602b-23cb-4a95-b83e-c506958dc90c@lucifer.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/2 22:08, Lorenzo Stoakes wrote:
> On Mon, Dec 23, 2024 at 10:15:25PM +0800, Kaixiong Yu wrote:
>> This moves all mmap related sysctls to mm/mmap.c, as part of the
>> kernel/sysctl.c cleaning, also move the variable declaration from
>> kernel/sysctl.c into mm/mmap.c.
>>
>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>> Reviewed-by: Kees Cook <kees@kernel.org>
> Looks good to me, thanks!
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks for your review!

Best ...
>> ---
>> v4:
>>   - const qualify struct ctl_table mmap_table
>> v3:
>>   - change the title
>> v2:
>>   - fix sysctl_max_map_count undeclared issue in mm/nommu.c
>> ---
>> ---
>>   kernel/sysctl.c | 50 +--------------------------------------------
>>   mm/mmap.c       | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 55 insertions(+), 49 deletions(-)
>>
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index aea3482106e0..9c245898f535 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -127,12 +127,6 @@ enum sysctl_writes_mode {
>>
>>   static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
>>   #endif /* CONFIG_PROC_SYSCTL */
>> -
>> -#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> -    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>> -int sysctl_legacy_va_layout;
>> -#endif
>> -
>>   #endif /* CONFIG_SYSCTL */
>>
>>   /*
>> @@ -2037,16 +2031,7 @@ static struct ctl_table vm_table[] = {
>>   		.extra1		= SYSCTL_ONE,
>>   		.extra2		= SYSCTL_FOUR,
>>   	},
>> -#ifdef CONFIG_MMU
>> -	{
>> -		.procname	= "max_map_count",
>> -		.data		= &sysctl_max_map_count,
>> -		.maxlen		= sizeof(sysctl_max_map_count),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -	},
>> -#else
>> +#ifndef CONFIG_MMU
>>   	{
>>   		.procname	= "nr_trim_pages",
>>   		.data		= &sysctl_nr_trim_pages,
>> @@ -2064,17 +2049,6 @@ static struct ctl_table vm_table[] = {
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>>   	},
> Nitty, but  this bit belongs in mm/nommu.c?
>
>> -#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> -    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>> -	{
>> -		.procname	= "legacy_va_layout",
>> -		.data		= &sysctl_legacy_va_layout,
>> -		.maxlen		= sizeof(sysctl_legacy_va_layout),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= SYSCTL_ZERO,
>> -	},
>> -#endif
>>   #ifdef CONFIG_MMU
>>   	{
>>   		.procname	= "mmap_min_addr",
>> @@ -2100,28 +2074,6 @@ static struct ctl_table vm_table[] = {
>>   		.extra1		= SYSCTL_ZERO,
>>   	},
>>   #endif
>> -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
>> -	{
>> -		.procname	= "mmap_rnd_bits",
>> -		.data		= &mmap_rnd_bits,
>> -		.maxlen		= sizeof(mmap_rnd_bits),
>> -		.mode		= 0600,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= (void *)&mmap_rnd_bits_min,
>> -		.extra2		= (void *)&mmap_rnd_bits_max,
>> -	},
>> -#endif
>> -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
>> -	{
>> -		.procname	= "mmap_rnd_compat_bits",
>> -		.data		= &mmap_rnd_compat_bits,
>> -		.maxlen		= sizeof(mmap_rnd_compat_bits),
>> -		.mode		= 0600,
>> -		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= (void *)&mmap_rnd_compat_bits_min,
>> -		.extra2		= (void *)&mmap_rnd_compat_bits_max,
>> -	},
>> -#endif
>>   };
>>
>>   int __init sysctl_init_bases(void)
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index aef835984b1c..cc579aafd7ba 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1603,6 +1603,57 @@ struct vm_area_struct *_install_special_mapping(
>>   					&special_mapping_vmops);
>>   }
>>
>> +#ifdef CONFIG_SYSCTL
>> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> +		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>> +int sysctl_legacy_va_layout;
>> +#endif
>> +
>> +static const struct ctl_table mmap_table[] = {
>> +		{
>> +				.procname       = "max_map_count",
>> +				.data           = &sysctl_max_map_count,
>> +				.maxlen         = sizeof(sysctl_max_map_count),
>> +				.mode           = 0644,
>> +				.proc_handler   = proc_dointvec_minmax,
>> +				.extra1         = SYSCTL_ZERO,
>> +		},
>> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> +		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>> +		{
>> +				.procname       = "legacy_va_layout",
>> +				.data           = &sysctl_legacy_va_layout,
>> +				.maxlen         = sizeof(sysctl_legacy_va_layout),
>> +				.mode           = 0644,
>> +				.proc_handler   = proc_dointvec_minmax,
>> +				.extra1         = SYSCTL_ZERO,
>> +		},
>> +#endif
>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
>> +		{
>> +				.procname       = "mmap_rnd_bits",
>> +				.data           = &mmap_rnd_bits,
>> +				.maxlen         = sizeof(mmap_rnd_bits),
>> +				.mode           = 0600,
>> +				.proc_handler   = proc_dointvec_minmax,
>> +				.extra1         = (void *)&mmap_rnd_bits_min,
>> +				.extra2         = (void *)&mmap_rnd_bits_max,
>> +		},
>> +#endif
>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
>> +		{
>> +				.procname       = "mmap_rnd_compat_bits",
>> +				.data           = &mmap_rnd_compat_bits,
>> +				.maxlen         = sizeof(mmap_rnd_compat_bits),
>> +				.mode           = 0600,
>> +				.proc_handler   = proc_dointvec_minmax,
>> +				.extra1         = (void *)&mmap_rnd_compat_bits_min,
>> +				.extra2         = (void *)&mmap_rnd_compat_bits_max,
>> +		},
>> +#endif
>> +};
>> +#endif /* CONFIG_SYSCTL */
>> +
>>   /*
>>    * initialise the percpu counter for VM
>>    */
>> @@ -1612,6 +1663,9 @@ void __init mmap_init(void)
>>
>>   	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
>>   	VM_BUG_ON(ret);
>> +#ifdef CONFIG_SYSCTL
>> +	register_sysctl_init("vm", mmap_table);
>> +#endif
>>   }
>>
>>   /*
>> --
>> 2.34.1
>>
> .
>


