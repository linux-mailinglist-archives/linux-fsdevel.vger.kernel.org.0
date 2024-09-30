Return-Path: <linux-fsdevel+bounces-30327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D5989ADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 08:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222012810ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EFC5A7AA;
	Mon, 30 Sep 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WCKZ8mKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CB23BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678941; cv=none; b=QmbbX1qwmZo5qtM6KwTdTtFIg7EMU7oxNSsi38vg+Yq0cHH/TAIlGAeM2zuQg7ycUmXR1MiEd0Cw4+nb4nUbQX3hlu+RRUwyVQ3sqkbs0NMjJKSwbQCz+AE4PftIHhsEwTKyCQwlb8Q1bqo6xqNMgWBYuD4Z454pls5vkbq59tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678941; c=relaxed/simple;
	bh=dfJcwKsUIYSB4IxG/rN9f1rFJa8u6J+vtZde+VoB2UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3iSEAvke8NLfKbs6pCgu9QY5cgPZEimSY7v6BSGSaIWnbBIyVS4cQEcLcD4O6q+pBVY5AOwgIcihTM5rU/+VsXRx+cbbcqO58LJZIFPaB6DU7WIRu/JKiCjhZWC+/0FCkBfWQJT9NfCTP+A2GxF79wI/sbqII9+Le6/QgZJQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WCKZ8mKt; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727678930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5Ik9T3maKQjieQebIpIXmvBXAB1bVuJfMCqq6dJICpU=;
	b=WCKZ8mKt2YMEKoJSLzH6sF3UxqxN03WS6iywfDZiscSGkwjp3xs3NCKIdJgyWm28XOGiQwR62x1nc/lDx0BT5MX8lzPHF3FLXFNNCzYHeztQ035vq4pL00aCIDGrEbFoYdrENkKrZouMDq8oEtEWUA4cHFgujLTrv47ERMrPjo0=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFz-QbS_1727678927)
          by smtp.aliyun-inc.com;
          Mon, 30 Sep 2024 14:48:48 +0800
Message-ID: <72170ff2-f23d-4246-abe8-15270ad1bb39@linux.alibaba.com>
Date: Mon, 30 Sep 2024 14:48:46 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2769e603-d35e-4f3e-83cf-509127b1797e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/30 11:15, Kefeng Wang wrote:
> 
> 
> On 2024/9/30 10:52, Baolin Wang wrote:
>>
>>
>> On 2024/9/30 10:30, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/9/30 10:02, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/9/26 21:52, Matthew Wilcox wrote:
>>>>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) 
>>>>> wrote:
>>>>>>> So this is why I don't use mapping_set_folio_order_range() here, but
>>>>>>> correct me if I am wrong.
>>>>>>
>>>>>> Yeah, the inode is active here as the max folio size is decided 
>>>>>> based on
>>>>>> the write size, so probably mapping_set_folio_order_range() will 
>>>>>> not be
>>>>>> a safe option.
>>>>>
>>>>> You really are all making too much of this.  Here's the patch I 
>>>>> think we
>>>>> need:
>>>>>
>>>>> +++ b/mm/shmem.c
>>>>> @@ -2831,7 +2831,8 @@ static struct inode *__shmem_get_inode(struct 
>>>>> mnt_idmap *idmap,
>>>>>          cache_no_acl(inode);
>>>>>          if (sbinfo->noswap)
>>>>>                  mapping_set_unevictable(inode->i_mapping);
>>>>> -       mapping_set_large_folios(inode->i_mapping);
>>>>> +       if (sbinfo->huge)
>>>>> +               mapping_set_large_folios(inode->i_mapping);
>>>>>
>>>>>          switch (mode & S_IFMT) {
>>>>>          default:
>>>>
>>>> IMHO, we no longer need the the 'sbinfo->huge' validation after 
>>>> adding support for large folios in the tmpfs write and fallocate 
>>>> paths [1].
> 
> Forget to mention, we still need to check sbinfo->huge, if mount with
> huge=never, but we fault in large chunk, write is slower than without
> 9aac777aaf94, the above changes or my patch could fix it.

My patch will allow allocating large folios in the tmpfs write and 
fallocate paths though the 'huge' option is 'never'.

My initial thought for supporting large folio is that, if the 'huge' 
option is enabled, to maintain backward compatibility, we only allow 2M 
PMD-sized order allocations. If the 'huge' option is 
disabled(huge=never), we still allow large folio allocations based on 
the write length.

Another choice is to allow the different sized large folio allocation 
based on the write length when the 'huge' option is enabled, rather than 
just the 2M PMD sized. But will force the huge orders off if 'huge' 
option is disabled.

Still need some discussions to determine which method is preferable.

