Return-Path: <linux-fsdevel+bounces-27271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719E95FF42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AD8B2198E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29575175AB;
	Tue, 27 Aug 2024 02:44:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCC10A3E;
	Tue, 27 Aug 2024 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726647; cv=none; b=Naxj1QOXKXMzdxNTnM3HNoHHPFl/xQRBVN1iLvZRUWroYqisuF++JG04m4O6peCJke8q7tOyD0jsf3ePtcjHN6ta8VF6EWy+rh5q8aFFPBb3Q5bLTF3ICKBf1JiHfM4vkcQdFfsAcfHYuS1MfZ1Mu4+dx6E20HJPIXWxt+ytnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726647; c=relaxed/simple;
	bh=56PvTSzz2bsQsKrOscUBkrq0mjnUZ7Tact5/NAj6MEY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Tvz29OadMypV3qQiU3ZI/lfIgEZ/dahDymzWGb/A8xXEvb4kMgVG4lkq0SlYYzp///bi4jubS2+TUo/uiZI+tS6bKtcBIMvVISzy6TkOWE8RRcwFxkeC3Gs50l4YeY9Eo/+5KWh6edrMi3qkFF1iNADN2kY0jxGo8FAr3zIemEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtBdf07S4zfbYx;
	Tue, 27 Aug 2024 10:41:58 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FBA3180AE7;
	Tue, 27 Aug 2024 10:44:01 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 10:43:58 +0800
Subject: Re: [PATCH -next 07/15] security: min_addr: move sysctl into its own
 file
To: Paul Moore <paul@paul-moore.com>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240826120449.1666461-8-yukaixiong@huawei.com>
 <CAHC9VhS=5k3zZyuuon2c6Lsf5GixAra6+d3A4bG2FVytv33n_w@mail.gmail.com>
 <aeb685e9-3a2d-13b4-4ec8-0752ded06d61@huawei.com>
 <CAHC9VhS4TKvTyUB+H6cQNjRFbssGRM-U6S-X7011bSv7bHiQqg@mail.gmail.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <j.granados@samsung.com>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <3f2bf67a-e37b-f6aa-b0de-3c05d19a5f02@huawei.com>
Date: Tue, 27 Aug 2024 10:43:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS4TKvTyUB+H6cQNjRFbssGRM-U6S-X7011bSv7bHiQqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500026.china.huawei.com (7.185.36.106) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/8/27 9:56, Paul Moore wrote:
> On Mon, Aug 26, 2024 at 9:38 PM yukaixiong <yukaixiong@huawei.com> wrote:
>> On 2024/8/27 6:49, Paul Moore wrote:
>>> On Mon, Aug 26, 2024 at 8:05 AM Kaixiong Yu <yukaixiong@huawei.com> wrote:
>>>> The dac_mmap_min_addr belongs to min_addr.c, move it into
>>>> its own file from /kernel/sysctl.c. In the previous Linux kernel
>>>> boot process, sysctl_init_bases needs to be executed before
>>>> init_mmap_min_addr, So, register_sysctl_init should be executed
>>>> before update_mmap_min_addr in init_mmap_min_addr.
>>>>
>>>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>>>> ---
>>>>    kernel/sysctl.c     |  9 ---------
>>>>    security/min_addr.c | 11 +++++++++++
>>>>    2 files changed, 11 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>>> index 41d4afc978e6..0c0bab3dad7d 100644
>>>> --- a/kernel/sysctl.c
>>>> +++ b/kernel/sysctl.c
>>>> @@ -2059,15 +2059,6 @@ static struct ctl_table vm_table[] = {
>>>>                   .proc_handler   = proc_dointvec_minmax,
>>>>                   .extra1         = SYSCTL_ZERO,
>>>>           },
>>>> -#ifdef CONFIG_MMU
>>>> -       {
>>>> -               .procname       = "mmap_min_addr",
>>>> -               .data           = &dac_mmap_min_addr,
>>>> -               .maxlen         = sizeof(unsigned long),
>>>> -               .mode           = 0644,
>>>> -               .proc_handler   = mmap_min_addr_handler,
>>>> -       },
>>>> -#endif
>>>>    #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
>>>>       (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
>>>>           {
>>>> diff --git a/security/min_addr.c b/security/min_addr.c
>>>> index 0ce267c041ab..b2f61649e110 100644
>>>> --- a/security/min_addr.c
>>>> +++ b/security/min_addr.c
>>>> @@ -44,8 +44,19 @@ int mmap_min_addr_handler(const struct ctl_table *table, int write,
>>>>           return ret;
>>>>    }
>>>>
>>>> +static struct ctl_table min_addr_sysctl_table[] = {
>>>> +       {
>>>> +               .procname       = "mmap_min_addr",
>>>> +               .data           = &dac_mmap_min_addr,
>>>> +               .maxlen         = sizeof(unsigned long),
>>>> +               .mode           = 0644,
>>>> +               .proc_handler   = mmap_min_addr_handler,
>>>> +       },
>>>> +};
>>> I haven't chased all of the Kconfig deps to see if there is a problem,
>>> but please provide a quick explanation in the commit description about
>>> why it is okay to drop the CONFIG_MMU check.
>> According to the compilation condition in security/Makefile:
>>
>>                 obj-$(CONFIG_MMU)            += min_addr.o
>>
>> if CONFIG_MMU is not defined, min_addr.c would not be included in the
>> compilation process.
>> So，it is okay to drop the CONFIG_MMU check.
> Great, please add some text about that in the commit description as it
> is an important difference in the code changes that isn't currently
> documented in the patch.
ok, I will add the related text in this patch series v2.


