Return-Path: <linux-fsdevel+bounces-8350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23258332FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 07:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872D5284F4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8A20E8;
	Sat, 20 Jan 2024 06:47:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC6EC8;
	Sat, 20 Jan 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733240; cv=none; b=i3uJlEL7TWRkW8tuWBLDm5LrkVIsKhW1512aJIaSS+YbegLnS4aaCsoJjBKZM9AbVWyd6pJPYSoFGsHujwnSRhIsgw10ksm12U2jVspzOQp7+HwEn3MIDUYvjFACdfY9BCSMm1xRcK+ejB8m1xfCtMzigrZF+OzmPhebATjPrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733240; c=relaxed/simple;
	bh=kcUOYTD8ufocNe4coNgY28RVjnrpJ6rVmP82XCF6ono=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjhZiagLDt8/2Pd6rebsPUVdqmxEEaHsFcnFWRObrEbXANqqs+vQJpAi4FTLjjkSWi1i9wd2ScqB1BA7Kn0RIVtO+sEGG0Jz/oqlgkdprs+5NlvNF0HPCHTmyQ5+9gzAhn0oDg69Hg2RdtlMwbaop+OoonCG43w5ups5TOGO5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TH6T755BQz1xmRW;
	Sat, 20 Jan 2024 14:46:19 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id A238814011B;
	Sat, 20 Jan 2024 14:46:52 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Jan 2024 14:46:51 +0800
Message-ID: <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
Date: Sat, 20 Jan 2024 14:46:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] filemap: add mapping_mapped check in
 filemap_unaccount_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <akpm@linux-foundation.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <arjunroy@google.com>, <wangkefeng.wang@huawei.com>
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <Zap7t9GOLTM1yqjT@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/1/19 21:40, Matthew Wilcox wrote:

> On Fri, Jan 19, 2024 at 05:20:24PM +0800, Peng Zhang wrote:
>> Recently, we discovered a syzkaller issue that triggers
>> VM_BUG_ON_FOLIO in filemap_unaccount_folio() with CONFIG_DEBUG_VM
>> enabled, or bad page without CONFIG_DEBUG_VM.
>>
>> The specific scenarios are as follows:
>> (1) mmap: Use socket fd to create a TCP VMA.
>> (2) open(O_CREAT) + fallocate + sendfile: Read the ext4 file and create
>> the page cache. The mapping of the page cache is ext4 inode->i_mapping.
>> Send the ext4 page cache to the socket fd through sendfile.
>> (3) getsockopt TCP_ZEROCOPY_RECEIVE: Receive the ext4 page cache and use
>> vm_insert_pages() to insert the ext4 page cache to the TCP VMA. In this
>> case, mapcount changes from - 1 to 0. The page cache mapping is ext4
>> inode->i_mapping, but the VMA of the page cache is the TCP VMA and
>> folio->mapping->i_mmap is empty.
> I think this is the bug.  We shouldn't be incrementing the mapcount
> in this scenario.  Assuming we want to support doing this at all and
> we don't want to include something like ...
>
> 	if (folio->mapping) {
> 		if (folio->mapping != vma->vm_file->f_mapping)
> 			return -EINVAL;
> 		if (page_to_pgoff(page) != linear_page_index(vma, address))
> 			return -EINVAL;
> 	}
>
> But maybe there's a reason for networking needing to map pages in this
> scenario?

Agreed, and I'm also curious why.

>> (4) open(O_TRUNC): Deletes the ext4 page cache. In this case, the page
>> cache is still in the xarray tree of mapping->i_pages and these page
>> cache should also be deleted. However, folio->mapping->i_mmap is empty.
>> Therefore, truncate_cleanup_folio()->unmap_mapping_folio() can't unmap
>> i_mmap tree. In filemap_unaccount_folio(), the mapcount of the folio is
>> 0, causing BUG ON.
>>
>> Syz log that can be used to reproduce the issue:
>> r3 = socket$inet_tcp(0x2, 0x1, 0x0)
>> mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
>> r4 = socket$inet_tcp(0x2, 0x1, 0x0)
>> bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
>> connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
>> r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
>> 0x181e42, 0x0)
>> fallocate(r5, 0x0, 0x0, 0x85b8)
>> sendfile(r4, r5, 0x0, 0x8ba0)
>> getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
>> &(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0, 0x0,
>> 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x40)
>> r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
>> 0x181e42, 0x0)
>>
>> In the current TCP zerocopy scenario, folio will be released normally .
>> When the process exits, if the page cache is truncated before the
>> process exits, BUG ON or Bad page occurs, which does not meet the
>> expectation.
>> To fix this issue, the mapping_mapped() check is added to
>> filemap_unaccount_folio(). In addition, to reduce the impact on
>> performance, no lock is added when mapping_mapped() is checked.
> NAK this patch, you're just preventing the assertion from firing.
> I think there's a deeper problem here.

-- 
Best Regards,
Peng


