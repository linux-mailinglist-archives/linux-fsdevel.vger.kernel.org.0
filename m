Return-Path: <linux-fsdevel+bounces-31424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51923996446
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FAE1F22A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146518A6CD;
	Wed,  9 Oct 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fXRyQtZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB53BB48
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464299; cv=none; b=AG1w/83tgw1SuaKjNCjrwWdXKEbL5BUUyhnhhEd51tPOhx2MLeuC4dwOngVaxaVRVN93VV+2YXGfO2rZ11qb5yuLDEmvbIJV62kkUneLZrvxeHQElq6+U7MSEhILtwBfhagIQilyvmg5IYhYicG1HVElZmCVDTGYhV+N8aTdxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464299; c=relaxed/simple;
	bh=SBb8acI6KYMnMYcuqXqLhjjofos1kQ59jQxhn3YQUaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6zdGx/MzGX8VpnHhnYiMntkrppXMYDD+7I7OL/kwOKHO1SmfAB6J+G/n7akh0+vbtJsldAcyzf+bJ0yYG8xI+C6CsvIoIxjOwVAbwrL5/pxbZxCJ6W9MOlZHQh9NAVsbfC2CbRt0RExq5bpSSnWFoykQmC91lRjvdS34BaU4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fXRyQtZz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728464289; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6hlnktzgeoMJ3sSidIFua4WAgBDoiJZRoKn3xL20UPY=;
	b=fXRyQtZzGClgBYbPy7bBZ332XVrjRKQ0G1UUHpAK9P5NJ+XVsKQ9ze06hgNQ5T3fya0v206pLyol+0LLJVyENV7wlAzb8/oDpjrlLt+gJVW1CC+0EtwjWSjVRRvcOeHOzE1iGbTAzvrJpQwhad+/wgA/Mvpdvib2iQzigBxZUeQ=
Received: from 30.74.144.152(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGiFgA9_1728463969)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 16:52:50 +0800
Message-ID: <796d33c3-f97d-41ad-9ba7-99ade5dcfcee@linux.alibaba.com>
Date: Wed, 9 Oct 2024 16:52:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Anna Schumaker <Anna.Schumaker@netapp.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
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
 <7d76fe98-4f7f-4f3d-9e8e-79d836f945cb@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7d76fe98-4f7f-4f3d-9e8e-79d836f945cb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/9 15:09, Kefeng Wang wrote:
> 
> 
> On 2024/9/30 14:48, Baolin Wang wrote:
>>
>>
>> On 2024/9/30 11:15, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/9/30 10:52, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/9/30 10:30, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/9/30 10:02, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/9/26 21:52, Matthew Wilcox wrote:
>>>>>>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) 
>>>>>>> wrote:
>>>>>>>>> So this is why I don't use mapping_set_folio_order_range() 
>>>>>>>>> here, but
>>>>>>>>> correct me if I am wrong.
>>>>>>>>
>>>>>>>> Yeah, the inode is active here as the max folio size is decided 
>>>>>>>> based on
>>>>>>>> the write size, so probably mapping_set_folio_order_range() will 
>>>>>>>> not be
>>>>>>>> a safe option.
>>>>>>>
>>>>>>> You really are all making too much of this.  Here's the patch I 
>>>>>>> think we
>>>>>>> need:
>>>>>>>
>>>>>>> +++ b/mm/shmem.c
>>>>>>> @@ -2831,7 +2831,8 @@ static struct inode 
>>>>>>> *__shmem_get_inode(struct mnt_idmap *idmap,
>>>>>>>          cache_no_acl(inode);
>>>>>>>          if (sbinfo->noswap)
>>>>>>>                  mapping_set_unevictable(inode->i_mapping);
>>>>>>> -       mapping_set_large_folios(inode->i_mapping);
>>>>>>> +       if (sbinfo->huge)
>>>>>>> +               mapping_set_large_folios(inode->i_mapping);
>>>>>>>
>>>>>>>          switch (mode & S_IFMT) {
>>>>>>>          default:
>>>>>>
>>>>>> IMHO, we no longer need the the 'sbinfo->huge' validation after 
>>>>>> adding support for large folios in the tmpfs write and fallocate 
>>>>>> paths [1].
>>>
>>> Forget to mention, we still need to check sbinfo->huge, if mount with
>>> huge=never, but we fault in large chunk, write is slower than without
>>> 9aac777aaf94, the above changes or my patch could fix it.
>>
>> My patch will allow allocating large folios in the tmpfs write and 
>> fallocate paths though the 'huge' option is 'never'.
> 
> Yes, indeed after checking your patch,
> 
> The Writing intelligently from 'Bonnie -d /mnt/tmpfs/ -s 1024' based on 
> next-20241008,
> 
> 1) huge=never
>     the base:                                    2016438 K/Sec
>     my v1/v2 or Matthew's patch :                2874504 K/Sec
>     your patch with filemap_get_order() fix:     6330604 K/Sec
> 
> 2) huge=always
>     the write performance:                       7168917 K/Sec
> 
> Since large folios supported in the tmpfs write, we do have better 
> performance shown above, that's great.

Great. Thanks for testing.

>> My initial thought for supporting large folio is that, if the 'huge' 
>> option is enabled, to maintain backward compatibility, we only allow 
>> 2M PMD-sized order allocations. If the 'huge' option is 
>> disabled(huge=never), we still allow large folio allocations based on 
>> the write length.
>>
>> Another choice is to allow the different sized large folio allocation 
>> based on the write length when the 'huge' option is enabled, rather 
>> than just the 2M PMD sized. But will force the huge orders off if 
>> 'huge' option is disabled.
>>
> 
> "huge=never  Do not allocate huge pages. This is the default."
>  From the document, it's better not to allocate large folio, but we need
> some special handle for huge=never or runtime deny/force.

Yes. I'm thinking of adding a new option (something like 'huge=mTHP') to 
allocate large folios based on the write size.

I will resend the patchset, and we can discuss it there.

