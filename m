Return-Path: <linux-fsdevel+bounces-31416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB1996057
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184C11F23EBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06617B516;
	Wed,  9 Oct 2024 07:10:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A411362
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457803; cv=none; b=haLgcDB31bxqqnTU6CxPUH0ryROE9jKgUeU8zERCjtbSKeUQKsvYzAksDqQD7HkCAQNCICkJ6iiKHoiZ6OvDBZjj6LAWksniaEeq0DyJP6zs/KiNamdNdR072FF+hxUP6PY1k5aujD79+H9OONkWoKafPnzN2S/teqbsM1KbPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457803; c=relaxed/simple;
	bh=TIYQ388z6u2a397MPRIia5ZSprfuQ7d6xqGS7eGLuYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=t1fKgXSS2RPUC1lFGgVSHUg2ef0yN/R1rACyIZPf4iZmOHBHvIbKHzimTchAE+duQacCBZEZ6El+vdE1d9C/mYZgobObkW0PusrZXd+BymGnhb/UMe5K63TYp7FwMpxs3PL1snHHXDnD3s5dhb5DmJrjCEeRznJaX1cnbvGQ+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XNkVw1rxRzZhkX;
	Wed,  9 Oct 2024 15:08:08 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id A60291800A5;
	Wed,  9 Oct 2024 15:09:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 15:09:51 +0800
Message-ID: <7d76fe98-4f7f-4f3d-9e8e-79d836f945cb@huawei.com>
Date: Wed, 9 Oct 2024 15:09:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew Wilcox
	<willy@infradead.org>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
 <1e5357de-3356-4ae7-bc69-b50edca3852b@linux.alibaba.com>
 <8c5d01b2-f070-4395-aa72-5ad56d6423e5@huawei.com>
 <314f1320-43fd-45d5-a80c-b8ea90ae4b1b@linux.alibaba.com>
 <2769e603-d35e-4f3e-83cf-509127b1797e@huawei.com>
 <72170ff2-f23d-4246-abe8-15270ad1bb39@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <72170ff2-f23d-4246-abe8-15270ad1bb39@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/30 14:48, Baolin Wang wrote:
> 
> 
> On 2024/9/30 11:15, Kefeng Wang wrote:
>>
>>
>> On 2024/9/30 10:52, Baolin Wang wrote:
>>>
>>>
>>> On 2024/9/30 10:30, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2024/9/30 10:02, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/9/26 21:52, Matthew Wilcox wrote:
>>>>>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) 
>>>>>> wrote:
>>>>>>>> So this is why I don't use mapping_set_folio_order_range() here, 
>>>>>>>> but
>>>>>>>> correct me if I am wrong.
>>>>>>>
>>>>>>> Yeah, the inode is active here as the max folio size is decided 
>>>>>>> based on
>>>>>>> the write size, so probably mapping_set_folio_order_range() will 
>>>>>>> not be
>>>>>>> a safe option.
>>>>>>
>>>>>> You really are all making too much of this.  Here's the patch I 
>>>>>> think we
>>>>>> need:
>>>>>>
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -2831,7 +2831,8 @@ static struct inode 
>>>>>> *__shmem_get_inode(struct mnt_idmap *idmap,
>>>>>>          cache_no_acl(inode);
>>>>>>          if (sbinfo->noswap)
>>>>>>                  mapping_set_unevictable(inode->i_mapping);
>>>>>> -       mapping_set_large_folios(inode->i_mapping);
>>>>>> +       if (sbinfo->huge)
>>>>>> +               mapping_set_large_folios(inode->i_mapping);
>>>>>>
>>>>>>          switch (mode & S_IFMT) {
>>>>>>          default:
>>>>>
>>>>> IMHO, we no longer need the the 'sbinfo->huge' validation after 
>>>>> adding support for large folios in the tmpfs write and fallocate 
>>>>> paths [1].
>>
>> Forget to mention, we still need to check sbinfo->huge, if mount with
>> huge=never, but we fault in large chunk, write is slower than without
>> 9aac777aaf94, the above changes or my patch could fix it.
> 
> My patch will allow allocating large folios in the tmpfs write and 
> fallocate paths though the 'huge' option is 'never'.

Yes, indeed after checking your patch,

The Writing intelligently from 'Bonnie -d /mnt/tmpfs/ -s 1024' based on 
next-20241008,

1) huge=never
    the base:                                    2016438 K/Sec
    my v1/v2 or Matthew's patch :                2874504 K/Sec
    your patch with filemap_get_order() fix:     6330604 K/Sec

2) huge=always
    the write performance:                       7168917 K/Sec

Since large folios supported in the tmpfs write, we do have better 
performance shown above, that's great.

> 
> My initial thought for supporting large folio is that, if the 'huge' 
> option is enabled, to maintain backward compatibility, we only allow 2M 
> PMD-sized order allocations. If the 'huge' option is 
> disabled(huge=never), we still allow large folio allocations based on 
> the write length.
> 
> Another choice is to allow the different sized large folio allocation 
> based on the write length when the 'huge' option is enabled, rather than 
> just the 2M PMD sized. But will force the huge orders off if 'huge' 
> option is disabled.
> 

"huge=never  Do not allocate huge pages. This is the default."
 From the document, it's better not to allocate large folio, but we need
some special handle for huge=never or runtime deny/force.

> Still need some discussions to determine which method is preferable.

Personally. I like your current implementation, but it does not match 
document.



