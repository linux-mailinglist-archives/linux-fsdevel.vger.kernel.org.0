Return-Path: <linux-fsdevel+bounces-31829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A81F99BDC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397922811CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6C3F9C5;
	Mon, 14 Oct 2024 02:36:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDF2D047
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873405; cv=none; b=VnRch0oZgcachJpJe5DTx5nA5xPQSj09/SNLjh/udTR6uFi3g6FFkIuQCNSIa35W0WIGw4ZsAnOWpaLntnrXO5xo5gCuGKsyLDZeEsji2Vk9+S4rKvFrjDSP8WuYzyyS74cWMhtTXZiBMX/d+O3qn97sdZlnoei9oFaeOaO4xUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873405; c=relaxed/simple;
	bh=hk6KlSBnLXc+d8aU4RxXSv15ZEIo0HRkESyjHJhS7C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kI2NcegYNQGZqyXGa8JwZUkeTBP7jB1R+QI9pScL2NXvWwyPmumyaDklMDQoFMBpsd1dPASDDVccg5IURf0TbjWz+xCNeCdclbC4KW1WjUHfC7XrFmO/yMyJjvm2UuhnHEPS06htc7544B0kpAlj/yt+1SR2XaU22xNXv6DKMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XRh8W5jTbz1HHLn;
	Mon, 14 Oct 2024 10:32:27 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 94D571A016C;
	Mon, 14 Oct 2024 10:36:38 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 10:36:38 +0800
Message-ID: <d77f439d-4f1f-4e23-986a-5eb35b143216@huawei.com>
Date: Mon, 14 Oct 2024 10:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tmpfs: don't enable large folios if not supported
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton
	<akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>
References: <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <20241011065919.2086827-1-wangkefeng.wang@huawei.com>
 <f29f5635-ed4d-49a6-957b-868c9d07e577@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <f29f5635-ed4d-49a6-957b-868c9d07e577@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/12 11:59, Baolin Wang wrote:
> 
> 
> On 2024/10/11 14:59, Kefeng Wang wrote:
>> The tmpfs could support large folio, but there is some configurable
>> options(mount options and runtime deny/force) to enable/disable large
>> folio allocation, so there is a performance issue when perform write
>> without large folio, the issue is similar to commit 4e527d5841e2
>> ("iomap: fault in smaller chunks for non-large folio mappings").
>>
>> Don't call mapping_set_large_folios() in __shmem_get_inode() when
>> large folio is disabled to fix it.
>>
>> Fixes: 9aac777aaf94 ("filemap: Convert generic_perform_write() to 
>> support large folios")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>
>> v3:
>> - don't enable large folio suppport in __shmem_get_inode() if disabled,
>>    suggested by Matthew.
>>
>> v2:
>> - Don't use IOCB flags
>>
>>   mm/shmem.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 0a2f78c2b919..2b859ac4ddc5 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2850,7 +2850,10 @@ static struct inode *__shmem_get_inode(struct 
>> mnt_idmap *idmap,
>>       cache_no_acl(inode);
>>       if (sbinfo->noswap)
>>           mapping_set_unevictable(inode->i_mapping);
>> -    mapping_set_large_folios(inode->i_mapping);
>> +
>> +    if ((sbinfo->huge && shmem_huge != SHMEM_HUGE_DENY) ||
>> +        shmem_huge == SHMEM_HUGE_FORCE)
>> +        mapping_set_large_folios(inode->i_mapping);
> 
> IMHO, I'm still a little concerned about the 'shmem_huge' validation. 
> Since the 'shmem_huge' can be set at runtime, that means file mapping 
> with 'huge=always' option might miss the opportunity to allocate large 
> folios if the 'shmem_huge' is changed from 'deny' from 'always' at runtime.
> 
> So I'd like to drop the 'shmem_huge' validation and add some comments to 
> indicate 'deny' and 'force' options are only for testing purpose and 
> performence issue should not be a problem in the real production 
> environments.

No strange opinion, the previous version could cover the runtime deny/
force, but it is a little complicated as Matthew pointed, if no other
comments, I will drop the shmem_huge check.

> 
> That's just my 2 cents:)


