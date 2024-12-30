Return-Path: <linux-fsdevel+bounces-38262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997659FE2FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 07:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501DC161CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7119EEBD;
	Mon, 30 Dec 2024 06:43:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CAD530;
	Mon, 30 Dec 2024 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735541009; cv=none; b=QSrf1gzgEn5HxVpIjVrnr3JzcB+eSZJXFFYZyGD+6TZZqyWvVTda7CdzklCsJAAB7VWjkSkXwGnHEz7v6GdfkU/xRsuzL+KaobfqJkghnuaSKiYcfDCT0g+OSuQ3110vrU/mozizVwU3EAoZY6xtucKSLTuoa9QlVoKiGzp3rKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735541009; c=relaxed/simple;
	bh=hgtYLPXFw9jFNSs9BsfEAhODWPHNf7RSkc7FIyqxQfQ=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QsnHQEWNB6gG5fo6VylF9HHJxj5hxbam521Vrnvi/3D/CHrRhHXXD9snLmWYkxV+S5NfYFIXFIsQwaAr0JPBo5HMH+Zj2gjA9cBBU5xiGF+YRfTtRwLMTB4slVi0iv36tre6I9rPGPTOO8XYOUsN82W8AlfNXXccdHmBBhck1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YM60M4PbVz1W3F6;
	Mon, 30 Dec 2024 14:39:47 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F47D140382;
	Mon, 30 Dec 2024 14:43:17 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Dec 2024 14:43:13 +0800
Subject: Re: [PATCH v4 -next 13/15] x86: vdso: move the sysctl to
 arch/x86/entry/vdso/vdso32-setup.c
To: Brian Gerst <brgerst@gmail.com>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-14-yukaixiong@huawei.com>
 <CAMzpN2hf-CFpO6x58aDK_FX_6C2MBKh1g7PdV4Y=ypaeUNVfRw@mail.gmail.com>
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
Message-ID: <3ed73b8d-1080-941b-ce6a-2d742b078193@huawei.com>
Date: Mon, 30 Dec 2024 14:43:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMzpN2hf-CFpO6x58aDK_FX_6C2MBKh1g7PdV4Y=ypaeUNVfRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100003.china.huawei.com (7.185.36.120) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/12/30 7:05, Brian Gerst wrote:
> On Sat, Dec 28, 2024 at 10:17 AM Kaixiong Yu <yukaixiong@huawei.com> wrote:
>> When CONFIG_X86_32 is defined and CONFIG_UML is not defined,
>> vdso_enabled belongs to arch/x86/entry/vdso/vdso32-setup.c.
>> So, move it into its own file.
>>
>> Before this patch, vdso_enabled was allowed to be set to
>> a value exceeding 1 on x86_32 architecture. After this patch is
>> applied, vdso_enabled is not permitted to set the value more than 1.
>> It does not matter, because according to the function load_vdso32(),
>> only vdso_enabled is set to 1, VDSO would be enabled. Other values
>> all mean "disabled". The same limitation could be seen in the
>> function vdso32_setup().
>>
>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> ---
>> v4:
>>   - const qualify struct ctl_table vdso_table
>> ---
>> ---
>>   arch/x86/entry/vdso/vdso32-setup.c | 16 +++++++++++-----
>>   kernel/sysctl.c                    |  8 +-------
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
>> index 76e4e74f35b5..f71625f99bf9 100644
>> --- a/arch/x86/entry/vdso/vdso32-setup.c
>> +++ b/arch/x86/entry/vdso/vdso32-setup.c
>> @@ -51,15 +51,17 @@ __setup("vdso32=", vdso32_setup);
>>   __setup_param("vdso=", vdso_setup, vdso32_setup, 0);
>>   #endif
>>
>> -#ifdef CONFIG_X86_64
>>
>>   #ifdef CONFIG_SYSCTL
>> -/* Register vsyscall32 into the ABI table */
>>   #include <linux/sysctl.h>
>>
>> -static struct ctl_table abi_table2[] = {
>> +static const struct ctl_table vdso_table[] = {
>>          {
>> +#ifdef CONFIG_X86_64
>>                  .procname       = "vsyscall32",
>> +#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))
> vdso32-setup,.c is not used when building UML, so this can be reduced
> to "#else".
>
>> +               .procname       = "vdso_enabled",
>> +#endif
>>                  .data           = &vdso32_enabled,
>>                  .maxlen         = sizeof(int),
>>                  .mode           = 0644,
>> @@ -71,10 +73,14 @@ static struct ctl_table abi_table2[] = {
>>
>>   static __init int ia32_binfmt_init(void)
>>   {
>> -       register_sysctl("abi", abi_table2);
>> +#ifdef CONFIG_X86_64
>> +       /* Register vsyscall32 into the ABI table */
>> +       register_sysctl("abi", vdso_table);
>> +#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))
> Same as above.
>
>
>
>> +       register_sysctl_init("vm", vdso_table);
>> +#endif
>>          return 0;
>>   }
>>   __initcall(ia32_binfmt_init);
>>   #endif /* CONFIG_SYSCTL */
>>
>> -#endif /* CONFIG_X86_64 */
>
> Brian Gerst
> .
Hello all；

I want to confirm that I should send a new patch series, such as "PATCH 
v5 -next"， or just modify this patch by
"git send-email -in-reply-to xxxxx"，or the maintainer will fix this issue ?


