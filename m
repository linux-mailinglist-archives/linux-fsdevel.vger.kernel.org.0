Return-Path: <linux-fsdevel+bounces-39221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B93A116E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05B03A340F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891322DF90;
	Wed, 15 Jan 2025 01:54:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220723243D;
	Wed, 15 Jan 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736906049; cv=none; b=sjhbpbGoh6QXlofHjjLsEEqfeIqvUzaStXFbr628yd6aLFkmf4WIDK1yE2OsNfrLRDanKzwS2Wfn4kLLojjpodXx6F+ZRQ9HvOZXEEVlK/XLqxgVb8gPcr4kjwUb31fm2meViGhuyqhB5Ilbu89091xlB16SDmfBVdJrbmUW5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736906049; c=relaxed/simple;
	bh=s5wf0PvE8iMPtIJdgC3i2u0xGI6W6jQCAYEtoonO+4w=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UXg3un3y/J+N9pCS0SSXJ3b0E7Sr39FzWXySCpw44ejg4/rtFba1abjrYBK7FoS13L5CznpCyZfulhJSoyvsffUyuEmL2utFGMbOgo8+OgCI8j+Wk/HgqSvmSu5KXSvAm1obiiVqGBco6IVuPUeMGhkc5vzOLecdeFaZcoMNXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YXppl4sWPz11PCY;
	Wed, 15 Jan 2025 09:50:07 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 48739180101;
	Wed, 15 Jan 2025 09:53:58 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jan 2025 09:53:54 +0800
Subject: Re: [PATCH v5 -next 00/16] sysctl: move sysctls from vm_table into
 its own files
To: Joel Granados <joel.granados@kernel.org>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>
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
Message-ID: <a3b4dcf9-7055-33f9-396c-c90b8cfa68d6@huawei.com>
Date: Wed, 15 Jan 2025 09:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500008.china.huawei.com (7.185.36.147) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/14 21:50, Joel Granados wrote:
> On Sat, Jan 11, 2025 at 03:07:35PM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
>>
>> All the modifications of this patch series base on
>> linux-next(tags/next-20250110). To test this patch series, the code was
>> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
>> x86_64 architectures. After this patch series is applied, all files
>> under /proc/sys/vm can be read or written normally.
> It is looking good! Here is how I think we should move it upstream:
>
> 1. These should queued in for 6.15 instead of the next merge window.
>     It is too late in the current cycle and if we put it in now, it will
>     not properly tested in linux-next.
>
> 2. I am putting this in sysctl-testing with the expectation of pushing this
>     up for the 6.15 merge window. Please tell me if you want this to go
>     through some other tree.
>
> Thx for the contribution
>
> Best

Thank you! I don't want this to go through some other tree.

Best ...
>> my test steps as below listed:
>>
>> Step 1: Set CONFIG_SYSCTL to 'n' and compile the Linux kernel on the
>> arm64 architecture. The kernel compiles successfully without any errors
>> or warnings.
>>
> ...
>>   mm/swap.c                          |  16 ++-
>>   mm/swap.h                          |   1 +
>>   mm/util.c                          |  67 +++++++--
>>   mm/vmscan.c                        |  23 +++
>>   mm/vmstat.c                        |  44 +++++-
>>   net/sunrpc/auth.c                  |   2 +-
>>   security/min_addr.c                |  11 ++
>>   23 files changed, 336 insertions(+), 312 deletions(-)
>>
>> -- 
>> 2.34.1
>>


