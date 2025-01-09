Return-Path: <linux-fsdevel+bounces-38694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18954A06B92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DAC16496A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778F13C80C;
	Thu,  9 Jan 2025 02:40:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68E25948C;
	Thu,  9 Jan 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390444; cv=none; b=Ys8XrtbvGB2IwrIUSxdLOn/FX5KPwJ7yquym4wJQ5nYvVyQgQ7+sEt04Fy5b7LZqYhrsdz0SxXVfGCTn/HETylB/c7h8eqQbqSHuds9WjdA0HRMX8taUnFnGf70dT6vgiAmYw+t15EHOz84S7a6KgRea5ZNGKtbrcSooLI9ufYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390444; c=relaxed/simple;
	bh=dbca4VV1EEduRUV1ChwJPIsPHgsjzmIBBwwKSHeKMeY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=daoKIExHj349vzL7vXbbLpirB2pqtqYSbWeN2/Yd9VMm5lOGVX3Bt8SyoCpmfxVwtgYqTYk+AcZ9clkevhPo9jmarJqfZ0eQxzuITAyeVVMV4rRd1lIKO/GyaBxDSYBIeMrLb2HvrZIFW2h5rIoGHZRJ3OMxIx83PyEPPaSbrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YT88J4ZTjz1ky2Y;
	Thu,  9 Jan 2025 10:37:36 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A27F4140159;
	Thu,  9 Jan 2025 10:40:38 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:40:35 +0800
Subject: Re: [PATCH v4 -next 14/15] sh: vdso: move the sysctl to
 arch/sh/kernel/vsyscall/vsyscall.c
To: Joel Granados <joel.granados@kernel.org>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-15-yukaixiong@huawei.com>
 <eiskmyz22ckjfmsxztt7a6m7e4sktp226j4hjktuggyqb4jirc@2rqxvgoq4v55>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <ca38cfef-2b60-b917-afa1-4cc44403df8f@huawei.com>
Date: Thu, 9 Jan 2025 10:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eiskmyz22ckjfmsxztt7a6m7e4sktp226j4hjktuggyqb4jirc@2rqxvgoq4v55>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/6 19:59, Joel Granados wrote:
> On Sat, Dec 28, 2024 at 10:57:45PM +0800, Kaixiong Yu wrote:
>> When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
>> vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
>> So, move it into its own file. After this patch is applied,
>> all sysctls of vm_table would be moved. So, delete vm_table.
>>
>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> ---
>> v4:
>>   - const qualify struct ctl_table vdso_table
>> v3:
>>   - change the title
>> ---
>> ---
>>   arch/sh/kernel/vsyscall/vsyscall.c | 14 ++++++++++++++
>>   kernel/sysctl.c                    | 14 --------------
>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/vsyscall.c
>> index add35c51e017..898132f34e6a 100644
>> --- a/arch/sh/kernel/vsyscall/vsyscall.c
>> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/module.h>
>>   #include <linux/elf.h>
>>   #include <linux/sched.h>
>> +#include <linux/sysctl.h>
>>   #include <linux/err.h>
>>   
>>   /*
>> @@ -30,6 +31,17 @@ static int __init vdso_setup(char *s)
>>   }
>>   __setup("vdso=", vdso_setup);
>>   
>> +static const struct ctl_table vdso_table[] = {
>> +	{
>> +		.procname	= "vdso_enabled",
>> +		.data		= &vdso_enabled,
>> +		.maxlen		= sizeof(vdso_enabled),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec,
>> +		.extra1		= SYSCTL_ZERO,
>> +	},
>> +};
>> +
>>   /*
>>    * These symbols are defined by vsyscall.o to mark the bounds
>>    * of the ELF DSO images included therein.
>> @@ -55,6 +67,8 @@ int __init vsyscall_init(void)
>>   	       &vsyscall_trapa_start,
>>   	       &vsyscall_trapa_end - &vsyscall_trapa_start);
>>   
>> +	register_sysctl_init("vm", vdso_table);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 7ff07b7560b4..cebd0ef5d19d 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2012,23 +2012,9 @@ static struct ctl_table kern_table[] = {
>>   #endif
>>   };
>>   
> As you mentioned in the commit message, this patch has two objectives.
> 1. It moves the vdso_enabled table and 2. It removes the vm_table.
> Please separate these two in such a way that the second (removal of
> vm_table) can be done at the end and is not related to any particular
> table under vm_table. I prefer it that way so that the removal of
> vm_table does not block the upstreaming of a move that is already
> reviewed and ready.
>
Thank you for your advice ! I will modify it in series patches v5.
>> -static struct ctl_table vm_table[] = {
>> -#if defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL)
>> -	{
>> -		.procname	= "vdso_enabled",
>> -		.data		= &vdso_enabled,
>> -		.maxlen		= sizeof(vdso_enabled),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> -		.extra1		= SYSCTL_ZERO,
>> -	},
>> -#endif
>> -};
>> -
>>   int __init sysctl_init_bases(void)
>>   {
>>   	register_sysctl_init("kernel", kern_table);
>> -	register_sysctl_init("vm", vm_table);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>


