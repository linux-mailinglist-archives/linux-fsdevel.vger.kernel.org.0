Return-Path: <linux-fsdevel+bounces-38256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A975A9FE21B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 03:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B71881DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C914B088;
	Mon, 30 Dec 2024 02:58:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535612594B3;
	Mon, 30 Dec 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735527528; cv=none; b=UYFYgEHZ1uAMeiMjgZFJrVKLTHX9OafOwmXn30G7GWvr98jwVtE1V3JlYiMaEdeD9y/c9voZn+qZmhFoyNXScnBOPuHIg1wRePsnrdTz/bNIIhIx9V5ZsZl9aCOLA+8JpGFXxkzqy0+l2ddMvwVjGrQs8myT2JQQVCmdIVTZM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735527528; c=relaxed/simple;
	bh=kj/0H5vJp1LGqZ/tbkCMHL6aXH/9wWYigBdRvXc7D4k=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VnPfT4vmFsP7vLK2n7wR7+fy3RHuCKTHvkys4UnYI/WbSN8aWEbNDnMAJZJL/cBJ7t3zKhE7A2SpqL8f8w0cgC1gnftsD6Tuz/7UEISmN9oiuaQAsDTjBcgHypCPJZZhyC4wgG78QR2+X8O9LgA1jXNn9z5wjDEZDnGWUsvuyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YM12k43FDzRkY9;
	Mon, 30 Dec 2024 10:56:30 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id BCED3180A9E;
	Mon, 30 Dec 2024 10:58:35 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Dec 2024 10:58:32 +0800
Subject: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: Jeff Layton <jlayton@kernel.org>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
 <f020095744b07958be5b66242d6cbd1826c885f5.camel@kernel.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <neilb@suse.de>, <okorniev@redhat.com>,
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
Message-ID: <e345a0a3-5044-c58a-e93c-8e221122e781@huawei.com>
Date: Mon, 30 Dec 2024 10:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f020095744b07958be5b66242d6cbd1826c885f5.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml100007.china.huawei.com (7.185.36.28) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/12/28 23:11, Jeff Layton wrote:
> On Sat, 2024-12-28 at 22:57 +0800, Kaixiong Yu wrote:
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
>>   - change all "static struct ctl_table" type into
>>     "static const struct ctl_table" type in patch1~10,12,13,14
>>   - simplify result of rpcauth_cache_shrink_count() in patch11
>>
>> Changes in v3:
>>   - change patch1~10, patch14 title suggested by Joel Granados
>>   - change sysctl_stat_interval to static type in patch1
>>   - add acked-by from Paul Moore in patch7
>>   - change dirtytime_expire_interval to static type in patch9
>>   - add acked-by from Anna Schumaker in patch11
>>
>> Changes in v2:
>>   - fix sysctl_max_map_count undeclared issue in mm/nommu.c for patch6
>>   - update changelog for patch7/12, suggested by Kees/Paul
>>   - fix patch8, sorry for wrong changes and forget to built with NOMMU
>>   - add reviewed-by from Kees except patch8 since patch8 is wrong in v1
>>   - add reviewed-by from Jan Kara, Christian Brauner in patch12
>>
>> Kaixiong Yu (15):
>>    mm: vmstat: move sysctls to mm/vmstat.c
>>    mm: filemap: move sysctl to mm/filemap.c
>>    mm: swap: move sysctl to mm/swap.c
>>    mm: vmscan: move vmscan sysctls to mm/vmscan.c
>>    mm: util: move sysctls to mm/util.c
>>    mm: mmap: move sysctl to mm/mmap.c
>>    security: min_addr: move sysctl to security/min_addr.c
>>    mm: nommu: move sysctl to mm/nommu.c
>>    fs: fs-writeback: move sysctl to fs/fs-writeback.c
>>    fs: drop_caches: move sysctl to fs/drop_caches.c
>>    sunrpc: simplify rpcauth_cache_shrink_count()
>>    fs: dcache: move the sysctl to fs/dcache.c
>>    x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
>>    sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
>>    sysctl: remove unneeded include
>>
>>   arch/sh/kernel/vsyscall/vsyscall.c |  14 ++
>>   arch/x86/entry/vdso/vdso32-setup.c |  16 ++-
>>   fs/dcache.c                        |  21 ++-
>>   fs/drop_caches.c                   |  23 ++-
>>   fs/fs-writeback.c                  |  30 ++--
>>   include/linux/dcache.h             |   7 +-
>>   include/linux/mm.h                 |  23 ---
>>   include/linux/mman.h               |   2 -
>>   include/linux/swap.h               |   9 --
>>   include/linux/vmstat.h             |  11 --
>>   include/linux/writeback.h          |   4 -
>>   kernel/sysctl.c                    | 221 -----------------------------
>>   mm/filemap.c                       |  18 ++-
>>   mm/internal.h                      |  10 ++
>>   mm/mmap.c                          |  54 +++++++
>>   mm/nommu.c                         |  15 +-
>>   mm/swap.c                          |  16 ++-
>>   mm/swap.h                          |   1 +
>>   mm/util.c                          |  67 +++++++--
>>   mm/vmscan.c                        |  23 +++
>>   mm/vmstat.c                        |  44 +++++-
>>   net/sunrpc/auth.c                  |   2 +-
>>   security/min_addr.c                |  11 ++
>>   23 files changed, 330 insertions(+), 312 deletions(-)
>>
> Nice cleanup.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> .
Thanks for your review.

Best.


