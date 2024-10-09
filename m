Return-Path: <linux-fsdevel+bounces-31466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C28997278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071F52835AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF413634C;
	Wed,  9 Oct 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fdvWnX5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579D8489;
	Wed,  9 Oct 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493054; cv=none; b=Rc2ZXWxJSWF38d7HN1QW2rOX1tB/OakE+iWxeWXhTDws7YAYGalf8gCPKhDvojnE1vpAfNbRiUDvYKpzo9mdBEmXkbBycPc2NvZcGhX3o5dx4ZNpxKqEuZbxOiOh/1CLjGmmJnufcUDohUvh5auckpcCHdKP8DONQwUK/zZjzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493054; c=relaxed/simple;
	bh=CI+DTnbZnnoVcpY8hInQcd9sONOPmjh87G32XJSeZMc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QgXzd4iIXOUjLMbymMgpy4fKsx7Uxpy22JMC+JXPqf9j+RFiDBy/5gsYz9gwqWvy/7BBk1YxqrQJ1NqRmadrC0/Pz9m0zFHpbCfoveAhkwbXQxCNMZY5BbkDyiTLLlVdFe2wl0S9gZKIKAzKJ7Bs1SaYqG810w3pyGWBkA/XicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fdvWnX5V; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728493048; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=ORzfNt9VkzdEGnE1FeMIA05Qm7yBuvqlTlcI1zkx72I=;
	b=fdvWnX5Vagobbu3rfComX6bHFwRus2IPeJzcivdhO40OM1tohes33Iw8ZPwwi2jO8eXWQp8YHmYxr8j/ZFnkZGpU3beGlrubik2wKR/VKvVbFQZ2OfCHb0mViFhG4OEs18tZwcVoxYyb8Av+DQ6jPzHauwSNiGeDDlsdw6OH7aM=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGjbNX._1728493046)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 00:57:27 +0800
Message-ID: <8ec1896f-93da-4eca-ab69-8ae9d1645181@linux.alibaba.com>
Date: Thu, 10 Oct 2024 00:57:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
 <ZwYxVcvyjJR_FM0U@infradead.org>
 <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
In-Reply-To: <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/9 15:37, Gao Xiang wrote:
> Hi Christoph,
> 

...

>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 666873f745da..b89836a8760d 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>>       if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>>           return get_tree_nodev(fc, erofs_fc_fill_super);
>>> -    ret = get_tree_bdev(fc, erofs_fc_fill_super);
>>> +    ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>>> +        IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>>> +            GET_TREE_BDEV_QUIET_LOOKUP : 0);
>>
>> Why not pass it unconditionally and provide your own more useful
>> error message at the end of the function if you could not find any
>> source?
> 
> My own (potential) concern is that if CONFIG_EROFS_FS_BACKED_BY_FILE
> is off, EROFS should just behave as other pure bdev fses since I'm
> not sure if some userspace program really relies on
> "Can't lookup blockdev" behavior.
> 
> .. Yet that is just my own potential worry anyway.

Many thanks all for the review... So I guess it sounds fine?



Hi Christian,

If they also look good to you, since it's a VFS change,
if possible, could you apply these two patches through
the VFS tree for this cycle?  There is a redundant blank
line removal in the first patch, I guess you could help
adjust or I need to submit another version?

I also have another related fix in erofs tree to address
a syzbot issue
https://lore.kernel.org/r/20240917130803.32418-1-hsiangkao@linux.alibaba.com

but it shouldn't cause any conflict with the second
patch though..

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 


