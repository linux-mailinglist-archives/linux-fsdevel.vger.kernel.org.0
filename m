Return-Path: <linux-fsdevel+bounces-38695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64037A06B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A401188852D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094B13A26D;
	Thu,  9 Jan 2025 02:43:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D0B677;
	Thu,  9 Jan 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390604; cv=none; b=hy2QIyfCT0ut6T4BcGeP4vXrHYRhlbGAXSmLEguHtL1/1I8ajioIAqwRQ7seRtelwhl+bKuYRCByoJoEZbAlkVoPSOVOYG7QKJV64NHbvEactxeC1fLmc+rsw9O69IAzs3Zru4V1k2tiLG871ZlAzvlrsZQlh/sqtG1fYFj0M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390604; c=relaxed/simple;
	bh=NlxSqcUikixh2kR4c2Ao02+aXdZC1USqv3CuF38dExI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dG/DRb7mqucsAXyR1ssphCPbp3AKC784hEBr+cC7+37z0ESBdgcKJcz54scTUVDvCOadOVTk4nyItNLkos6RRFMg7IEt0g0Bo2MepWe7CzPkd5OdeQKd3ObE9Fmr0YLFYMdzBTyZ0U4L03fpm6eW1KCTRuBmwvInYALrm6YrGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YT8BR2PSXz1W3ml;
	Thu,  9 Jan 2025 10:39:27 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id EF0DD180101;
	Thu,  9 Jan 2025 10:43:09 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:43:06 +0800
Subject: Re: [PATCH v4 -next 13/15] x86: vdso: move the sysctl to
 arch/x86/entry/vdso/vdso32-setup.c
To: Joel Granados <joel.granados@kernel.org>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <20241228145746.2783627-14-yukaixiong@huawei.com>
 <CAMzpN2hf-CFpO6x58aDK_FX_6C2MBKh1g7PdV4Y=ypaeUNVfRw@mail.gmail.com>
 <3ed73b8d-1080-941b-ce6a-2d742b078193@huawei.com>
 <ka6zci6bvgvyvlxf5u5g7ecefpqlrlqxwzdviukonmvtzeed54@fkseedf6ilms>
CC: Brian Gerst <brgerst@gmail.com>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
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
Message-ID: <1bfce3e2-bd83-e183-f188-5d9d6d4ac023@huawei.com>
Date: Thu, 9 Jan 2025 10:43:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ka6zci6bvgvyvlxf5u5g7ecefpqlrlqxwzdviukonmvtzeed54@fkseedf6ilms>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/6 20:14, Joel Granados wrote:
> On Mon, Dec 30, 2024 at 02:43:12PM +0800, yukaixiong wrote:
>>
>> On 2024/12/30 7:05, Brian Gerst wrote:
>>> On Sat, Dec 28, 2024 at 10:17 AM Kaixiong Yu <yukaixiong@huawei.com> wrote:
> ...
>>>>           return 0;
>>>>    }
>>>>    __initcall(ia32_binfmt_init);
>>>>    #endif /* CONFIG_SYSCTL */
>>>>
>>>> -#endif /* CONFIG_X86_64 */
>>> Brian Gerst
>>> .
>> Hello all；
>>
>> I want to confirm that I should send a new patch series, such as "PATCH
>> v5 -next"， or just modify this patch by
>> "git send-email -in-reply-to xxxxx"，or the maintainer will fix this issue ?
> There are still some outstanding comments (besides this one) to the
> series that you must address. This is what I propose:
>
> 1. Address the outstanding feedback in the series
> 2. Wait a couple of more days to see if you get more feedback
> 3. For your next versions, please include the tags from previous
>     reviews; I see that you have not added Lorenzo's reviewed by for
>     "[PATCH v4 -next 06/15] mm: mmap: move sysctl to mm/mmap.c" and
>     "[PATCH v4 -next 08/15] mm: nommu: move sysctl to mm/nommu.c"
> 4. Once you have addresses all the issues, Send a V5. If there are still
>     issues with this version, then we can cherry-pick the patches that
>     are already reviewed into upstream and continue working on the ones
>     with issues.
>
> Best
Thanks again! Now, I plan to send a V5!

Best ...



