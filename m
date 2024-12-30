Return-Path: <linux-fsdevel+bounces-38257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566B9FE225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 04:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356AB3A1CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F716152E02;
	Mon, 30 Dec 2024 03:02:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440740BF5;
	Mon, 30 Dec 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735527775; cv=none; b=ImsRIlGbnT7B4VJmceOQiRYmvyZAXd1chymjTgY1sVB9UDPbTWFLvPiFtka+Tz6VaWFQ9kFxFjVu9bz+E4LjPD8fEU6ny7w+r+SCaQz1GW4I4YgKv6qN2JyA+h7rYrcymqlsf9PTWdpNMan8y1XQxoOKlDQUx5+oUTW3uZWQ5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735527775; c=relaxed/simple;
	bh=QaXejW6rcRxfG31NAo512yz4AQGMHU0p3awoME3GMQI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qBQRde+05o5RjnVP3i00IQ5zLnWw+Jnisc++wptWexzxgb7oolLidvvmTM+CjTGoV8f20BTB8uDlTPKcTJV4fiPrjbfBF6tZy8unI/2VXdLnIxKCqIt3Ei07/Gh1Cy7XNIo2pSk8Rj85Ld69+vkPY4jsqali1Bx2APhD/kRpL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YM15r5LzBz11NZQ;
	Mon, 30 Dec 2024 10:59:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id BDF2714022E;
	Mon, 30 Dec 2024 11:02:42 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Dec 2024 11:02:38 +0800
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
Message-ID: <5b7530d9-a593-4365-718f-afdd46bdcb31@huawei.com>
Date: Mon, 30 Dec 2024 11:02:38 +0800
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
X-ClientProxiedBy: dggpeml100007.china.huawei.com (7.185.36.28) To
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
I will take your advice.

Thanks.
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
I will take your advice.

Thanks.
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
>


