Return-Path: <linux-fsdevel+bounces-38692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7A1A06B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE573A7A94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E047F15C140;
	Thu,  9 Jan 2025 02:33:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75462A1BB;
	Thu,  9 Jan 2025 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390000; cv=none; b=Mbw9Un5mgX0XwS2zDYqG9mpWqx7HQenHOWki8hmzP1HwMrdpcH9BIlSOzsLItmwaw8T8FM/cAHkhCrYmuA2MS5S0O6tv0RkZ16Fk8DB+c4G+IxPsSZucgc6vylKJtYY1b1wV+CXM0T6DBOfXj2r9uRHYW86dRxTVrVBXidiQaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390000; c=relaxed/simple;
	bh=yyPw+bQMFCgtUYLoHPn9SRKam5YtAZgLVhJXTRBL824=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uGnAbV7+5rwBp6ktO85wAxuThd6C7oElhQ/xTcD9a57B9OAiSLsWkLaXTb2meDcEfhu9QngqS+cCAaN2icr0dwUgLPZI5bfvRGqdAJbhalpGXvehrm7ZkvcWpzGoPjjD4gTk09Qil/JaOacIumdjOe2xQYIvxhkaLfThcq0MvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YT7zd3TwDz2Dk2R;
	Thu,  9 Jan 2025 10:30:05 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id AA373140159;
	Thu,  9 Jan 2025 10:33:07 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:33:04 +0800
Subject: Re: [PATCH v4 -next 14/15] sh: vdso: move the sysctl to
 arch/sh/kernel/vsyscall/vsyscall.c
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-15-yukaixiong@huawei.com>
 <CAMuHMdVHD+AhMpcyxndTno-ocatS1tRP5uRrKNFL6Z=j3KX8og@mail.gmail.com>
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
Message-ID: <e8f12df8-3502-691a-a60d-645ac8fbdd65@huawei.com>
Date: Thu, 9 Jan 2025 10:33:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVHD+AhMpcyxndTno-ocatS1tRP5uRrKNFL6Z=j3KX8og@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/3 19:11, Geert Uytterhoeven wrote:
> Hi Kaixiong,
>
> On Sat, Dec 28, 2024 at 4:07 PM Kaixiong Yu <yukaixiong@huawei.com> wrote:
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
> Thanks for your patch!
>
> I gave this a try on landisk, and /proc/sys/vm/vdso_enabled
> disappeared.
>
>> --- a/arch/sh/kernel/vsyscall/vsyscall.c
>> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
>> @@ -55,6 +67,8 @@ int __init vsyscall_init(void)
>>                 &vsyscall_trapa_start,
>>                 &vsyscall_trapa_end - &vsyscall_trapa_start);
>>
>> +       register_sysctl_init("vm", vdso_table);
>      "failed when register_sysctl_sz vdso_table to vm"
>
> Adding some debug prints shows that kzalloc() in
> __register_sysctl_table() fails, presumably because it is called too
> early in the boot process.
>
>> +
>>          return 0;
>>   }
> Moving the call to register_sysctl_init() into its own fs_initcall(),
> like the gmail-whitespace-damaged patch below, fixes that.
>
> --- a/arch/sh/kernel/vsyscall/vsyscall.c
> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
> @@ -67,11 +67,17 @@ int __init vsyscall_init(void)
>                 &vsyscall_trapa_start,
>                 &vsyscall_trapa_end - &vsyscall_trapa_start);
>
> -       register_sysctl_init("vm", vdso_table);
> +       return 0;
> +}
>
> +static int __init vm_sysctl_init(void)
> +{
> +       register_sysctl_init("vm", vdso_table);
>          return 0;
>   }
>
> +fs_initcall(vm_sysctl_init);
> +
>   /* Setup a VMA at program startup for the vsyscall page */
>   int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>   {
>
> Gr{oetje,eeting}s,
>
>                          Geert

Thank you so much for your test and fix patch !

I will fix it in patches series v5.

Best ...



