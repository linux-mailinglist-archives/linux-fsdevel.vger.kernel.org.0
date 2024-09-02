Return-Path: <linux-fsdevel+bounces-28231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C396855F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE371F22E56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3F183CA5;
	Mon,  2 Sep 2024 10:55:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A7347B;
	Mon,  2 Sep 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274535; cv=none; b=bbN/cHXsqBk4MBKDaEYfyDnQsPxuZZ7L8rfu0Dsdbv++4/A4aQGMBEi+UQXjfQk4B+3QmQa00E93JtEvFpdtfeJTwvxdlX0VZVbgkzhvPezSqxEZGkW1WdCWdZCDBgd/ko3/DCbVURvy3m60cPPJEG/kRP49Z0zMUkrLd1CJO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274535; c=relaxed/simple;
	bh=/ZnDWgOWryVILcL4vVPJWm3z55PNypoxLjeVJcXAz5Y=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qo77AkXr3gQQFpoHq0HpoAs54egzlJovKrd+ARLC4gKQWwSqD2eCTRu0McFkXcuascQLpiETmnBs+FKHINK0ECvNDkVo1lZOFAOnq1ocpCMf1s8DMjAxC2y95Sgd8TpM7mfEMMlY2YtgM3DkxrRQAL7AEVvH5OMmurE32sEqzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wy5Bd2g8rz69Qt;
	Mon,  2 Sep 2024 18:50:33 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A2AB51800A7;
	Mon,  2 Sep 2024 18:55:28 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 18:55:25 +0800
Subject: Re: [PATCH -next 00/15] sysctl: move sysctls from vm_table into its
 own files
To: Joel Granados <j.granados@samsung.com>
References: <CGME20240826120559eucas1p1a1517b9f4dbeeae893fd2fa770b47232@eucas1p1.samsung.com>
 <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240902071752.5ieq3khrnpjqq6qv@joelS2.panther.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <willy@infradead.org>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <003ce112-d895-5f1d-d034-b61b7f68cebd@huawei.com>
Date: Mon, 2 Sep 2024 18:55:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240902071752.5ieq3khrnpjqq6qv@joelS2.panther.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500014.china.huawei.com (7.185.36.63) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/9/2 15:17, Joel Granados wrote:
> On Mon, Aug 26, 2024 at 08:04:34PM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
>>
>> All the modifications of this patch series base on
>> linux-next(tags/next-20240823). To test this patch series, the code was
>> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
>> x86_64 architectures. After this patch series is applied, all files
>> under /proc/sys/vm can be read or written normally.
>>
>> Kaixiong Yu (15):
>>    mm: vmstat: move sysctls to its own files
>>    mm: filemap: move sysctl to its own file
>>    mm: swap: move sysctl to its own file
>>    mm: vmscan: move vmscan sysctls to its own file
>>    mm: util: move sysctls into it own files
>>    mm: mmap: move sysctl into its own file
>>    security: min_addr: move sysctl into its own file
>>    mm: nommu: move sysctl to its own file
>>    fs: fs-writeback: move sysctl to its own file
>>    fs: drop_caches: move sysctl to its own file
>>    sunrpc: use vfs_pressure_ratio() helper
>>    fs: dcache: move the sysctl into its own file
>>    x86: vdso: move the sysctl into its own file
>>    sh: vdso: move the sysctl into its own file
>>    sysctl: remove unneeded include
>>
> Thx for this.
>
> I passed this through 0-day testing and it return some errors. Please
> address those build errors/regrssions before you send V2.
>
> Best

ok，I will fix those  errors/warnings in v2


