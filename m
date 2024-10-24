Return-Path: <linux-fsdevel+bounces-32701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15E9ADE76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151A41C2170E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7381AF0DA;
	Thu, 24 Oct 2024 08:07:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D819F104;
	Thu, 24 Oct 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757242; cv=none; b=lXBx968ig4F+2uTpSjEKET9iVZ0Yfc1FZ2htkZNNNMzTF+yOFD4OavpGFkBemlmbvHXsypc8ZDtFvtPQH8go6A/Hrut5bCA545nrWtwD7tNdPsz5Skv3Pqce65CwfEcC3IkPdKvebRruX5kMBru9RrccwzVaqGw6ko8phiCByEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757242; c=relaxed/simple;
	bh=KBY3Xq32mH8OhQWVjBV/Bq8SdNGCd36z6O+Nh0qKmDQ=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ehn7treRhPiyNJlmiSIwgNY/U9Ipmih4TKg45PfBUMHDQOQVHU+OpEoz9TBIVht/X8JJ8Zynu0aJd/03LXAE+z3ScDJNd06v3LUrwhsnl/ZCqWyzBzapn6m30dMSojcIqvqEVZ/9UxujjbXVhzFT6Xpd69BL31AK1iN3q88wIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYz193blfz1HLRk;
	Thu, 24 Oct 2024 16:02:53 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 603111A016C;
	Thu, 24 Oct 2024 16:07:15 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 16:07:11 +0800
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: Joel Granados <j.granados@samsung.com>
References: <CGME20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd@eucas1p1.samsung.com>
 <20241010152215.3025842-1-yukaixiong@huawei.com>
 <ngknhtecptqk56gtiikvb5mdujhtxdyngzndiaz7ifslzrki7q@4wcykosdnsna>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <kees@kernel.org>,
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <79b33640-fc81-b4c1-4967-30189d9a4b23@huawei.com>
Date: Thu, 24 Oct 2024 16:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ngknhtecptqk56gtiikvb5mdujhtxdyngzndiaz7ifslzrki7q@4wcykosdnsna>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500026.china.huawei.com (7.185.36.106) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/10/21 15:22, Joel Granados wrote:
> On Thu, Oct 10, 2024 at 11:22:00PM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
>>
>> All the modifications of this patch series base on
>> linux-next(tags/next-20241010). To test this patch series, the code was
>> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
>> x86_64 architectures. After this patch series is applied, all files
>> under /proc/sys/vm can be read or written normally.
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
>>    sunrpc: use vfs_pressure_ratio() helper
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
>> -- 
>> 2.34.1
>>
> General comment for the patchset in general. I would consider making the
> new sysctl tables const. There is an effort for doing this and it has
> already lanted in linux-next. So if you base your patch from a recent
> next release, then it should just work. If you *do* decide to add a
> const qualifier, then note that you will create a dependency with the
> sysctl patchset currently in next and that will have to go in before.
>
> Best
>

Sorry,  I don't understand what is the meaning of "create a dependency 
with the sysctl patchset".

Do you just want me to change all "static struct ctl_table" type table 
into "static const struct ctl_table" type in my patchset?


