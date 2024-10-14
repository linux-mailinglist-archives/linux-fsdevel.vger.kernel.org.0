Return-Path: <linux-fsdevel+bounces-31826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C999BD59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 03:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B1F1C214E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 01:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333429422;
	Mon, 14 Oct 2024 01:33:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260B25763;
	Mon, 14 Oct 2024 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869606; cv=none; b=b5m7vFXMiq3wKyNwBHN4CV+103Qiu+ps/2lzHs6IihWH2gBgRa0t5jNzoXP+XRnljPoue5DAhm8581226JToswJA6TJ5N+QQxh+1nI30V46TBDnmuOtnOnAkTsXph20u6FkVOMtbiYQj7FVPmHa0sRVFwmT28xfQKhsZ79/OfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869606; c=relaxed/simple;
	bh=1KoyUr7OUAAKJE72JEhYBQIws427NExhvIEoCRtqtvw=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P1167R9S+Vnq/ALPoAfSm9bNF+NyXbmm7RShkPC/lNOhnclMi8bQs6q2Pk0w+5ZbpfwnReQnwfB+fse5XtjyMHhb6AwzIIeBaLD6ye857Yt4ZDlTKi90wqiguIQGEZketmtoKVOdsRTM6XJXS7CmEvHVJwhKrue9hRkY4vUszmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XRfqP4pDzzQrfD;
	Mon, 14 Oct 2024 09:32:33 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 675AF140137;
	Mon, 14 Oct 2024 09:33:15 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 09:33:11 +0800
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
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
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
 <ykseykkxta6fk747pejzpatstsf3vzx63rk4gayfrh5hsru7nq@duruino6qmys>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <3ce4d2b1-02bb-f5ac-dbb9-729fe3d10f62@huawei.com>
Date: Mon, 14 Oct 2024 09:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ykseykkxta6fk747pejzpatstsf3vzx63rk4gayfrh5hsru7nq@duruino6qmys>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500010.china.huawei.com (7.185.36.155) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/10/11 21:04, Liam R. Howlett wrote:
> * Kaixiong Yu <yukaixiong@huawei.com> [241010 10:11]:
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
> This change set moves nommu code out of the common code into the nommu.c
> file (which is nice), but the above text implies that no testing was
> performed on that code.  Could we have some basic compile/boot testing
> for nommu?
this patch series has been compiled with CONFIG_MMU=n on arm，and produce
nommu.o without error and warning. But I don't have machine to do test 
for nommu.
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
> .
>


