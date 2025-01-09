Return-Path: <linux-fsdevel+bounces-38696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B2A06BAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068DD166A85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E513A244;
	Thu,  9 Jan 2025 02:50:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798C847C;
	Thu,  9 Jan 2025 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391027; cv=none; b=euZ+DV8e442DUJz0e3DSdqy8cYHWYZ8et0NOEJeT4mY1aVwSv6rFuVXhljouwvDKOFblVFsLDeW68TLTeAsR93DNKQJtVrNjHq/Mbjh+UJZjQsyLEMjJX5bdLIc89GWjaEQsGjuX3IT3b4bPsRPaPIArSB4naeiwGVNVBE2Tkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391027; c=relaxed/simple;
	bh=kwYWjpWfNmL1d5hD26X0HlYhelzrjDrfHJjfWnrO1i0=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aG0TSzjGO1rar+lrvcWoRfso/ll4pjzFZ6sXrriTW0uCoJLyAVRcgdUSnQUtsSgyowrWnypWKUQsAHGwvxy35SdRFm6lWRuKsWeDqFuQFqFFqpj+kqRyfrxuyZRonWbq8qSa0EEhpy1DufUn9jWSCDytbosNYZ45B14/j6mOZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YT8Ll1PkJz1W3QY;
	Thu,  9 Jan 2025 10:46:39 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id CCEBC140135;
	Thu,  9 Jan 2025 10:50:21 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:50:18 +0800
Subject: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: Joel Granados <joel.granados@kernel.org>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <tgp2b7kbbdx4obapr4fgtmgjjo6zjbxbligucs32eewiasacko@f4h6uoamznry>
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
Message-ID: <5eeef365-6a33-ca76-2406-3102eb49f99f@huawei.com>
Date: Thu, 9 Jan 2025 10:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tgp2b7kbbdx4obapr4fgtmgjjo6zjbxbligucs32eewiasacko@f4h6uoamznry>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/6 20:15, Joel Granados wrote:
> On Sat, Dec 28, 2024 at 10:57:31PM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
>>
>> All the modifications of this patch series base on
>> linux-next(tags/next-20241219). To test this patch series, the code was
>> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
>> x86_64 architectures. After this patch series is applied, all files
>> under /proc/sys/vm can be read or written normally.
>>
>> Changes in v4:
>>   - due to my mistake, the previous version sent 15 patches twice.
>>     Please ignore that, as this version is the correct one.
> I would not ignore the reviewed-by tags that you got from Lorenzo.
> Please include those moving forward.
Good suggestion!
Thx !
>>   - change all "static struct ctl_table" type into
>>     "static const struct ctl_table" type in patch1~10,12,13,14
>>   - simplify result of rpcauth_cache_shrink_count() in patch11
> ...
>>   mm/vmscan.c                        |  23 +++
>>   mm/vmstat.c                        |  44 +++++-
>>   net/sunrpc/auth.c                  |   2 +-
>>   security/min_addr.c                |  11 ++
>>   23 files changed, 330 insertions(+), 312 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> best
>


