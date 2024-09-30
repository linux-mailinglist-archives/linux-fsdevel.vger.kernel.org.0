Return-Path: <linux-fsdevel+bounces-30324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A254989950
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 04:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B6CB21EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 02:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849B22331;
	Mon, 30 Sep 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bNATaWJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698923BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664783; cv=none; b=oDIzVEG3DTW7bE/3nYtkk2PiEAA/5WyMQrBvFlj26f2aE8TXehs+GTCB9r3jmeO2anukC+wb/nEmoToPSxXdBJXlDY7WlrX57cgpzah7oBiKquGGuohyQ86lzIx4kowK1zdd3u0vLzPqoQ/SjYQUqq/hDtOheu/pbitlyFTn3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664783; c=relaxed/simple;
	bh=6nO08luvWYEleo1ROMxL/fKfa/DtZuM8OdyLtWZ6jjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLWZa5xRXZjQRKk1tQt48MIUeB/ks6t23mymwHq60wXMiITbGhog50x3yEYJfH6/muKmYZuSYbgBUSspf7N0FIv4oJ0zaq6ONrD6ut13yVDkpiRUI6D8RtvPW2e0bK39iT5ikxGZgPLhFg8rxMaOzrvkrpIxhfJ7ioJsPni/r4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bNATaWJf; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727664772; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y9VI0Nw9VCS+z9O7n29X5Uf2tFeLAF5xMAQ7jImge6o=;
	b=bNATaWJfKUhA8p98B1O63YXpNh8aHU8upbhoQbMwd4Tw/Ho4EmxMFzXN11q8l5/hpNH8rAxoX54TewN1N4mgEfvYorPzdUpPFadNLXyN5qfXVA3jFeFEvZ/cYwXCvkWOJqUcdvx9lD9Y2dhelN7xMnKAbx4fUeTvrwy8jAZjIbc=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFxTQpD_1727664770)
          by smtp.aliyun-inc.com;
          Mon, 30 Sep 2024 10:52:51 +0800
Message-ID: <314f1320-43fd-45d5-a80c-b8ea90ae4b1b@linux.alibaba.com>
Date: Mon, 30 Sep 2024 10:52:49 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8c5d01b2-f070-4395-aa72-5ad56d6423e5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/30 10:30, Kefeng Wang wrote:
> 
> 
> On 2024/9/30 10:02, Baolin Wang wrote:
>>
>>
>> On 2024/9/26 21:52, Matthew Wilcox wrote:
>>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
>>>>> So this is why I don't use mapping_set_folio_order_range() here, but
>>>>> correct me if I am wrong.
>>>>
>>>> Yeah, the inode is active here as the max folio size is decided 
>>>> based on
>>>> the write size, so probably mapping_set_folio_order_range() will not be
>>>> a safe option.
>>>
>>> You really are all making too much of this.  Here's the patch I think we
>>> need:
>>>
>>> +++ b/mm/shmem.c
>>> @@ -2831,7 +2831,8 @@ static struct inode *__shmem_get_inode(struct 
>>> mnt_idmap *idmap,
>>>          cache_no_acl(inode);
>>>          if (sbinfo->noswap)
>>>                  mapping_set_unevictable(inode->i_mapping);
>>> -       mapping_set_large_folios(inode->i_mapping);
>>> +       if (sbinfo->huge)
>>> +               mapping_set_large_folios(inode->i_mapping);
>>>
>>>          switch (mode & S_IFMT) {
>>>          default:
>>
>> IMHO, we no longer need the the 'sbinfo->huge' validation after adding 
>> support for large folios in the tmpfs write and fallocate paths [1].
>>
>> Kefeng, can you try if the following RFC patch [1] can solve your 
>> problem? Thanks.
>> (PS: I will revise the patch according to Matthew's suggestion)
> 
> Sure, will try once I come back, but [1] won't solve the issue when set

Cool. Thanks.

> force/deny at runtime, eg, mount with always/within_size, but set deny 
> when runtime, we still fault in large chunks, but we can't allocate 
> large folio, the performance of write will be degradation.

Yes, but as Hugh mentioned before, the options 'force' and 'deny' are 
rather testing artifacts from the old ages. So I suspect if the 'deny' 
option will be set in the real products, that means do we really need 
consider this case too much?

