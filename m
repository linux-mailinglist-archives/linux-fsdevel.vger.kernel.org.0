Return-Path: <linux-fsdevel+bounces-64292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFFBE0384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3764FAAE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CB27FD4B;
	Wed, 15 Oct 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aMmTug2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189432549F
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553580; cv=none; b=dIRGf+mGi92D1oiZ8C43RgG4F4mYq4/iQSc1DJvIfvaDfV9YWHmtc2TKyIDPutQjZrTeBQh/rDRzxKkGKQ/zaGkQ9QvnAIdUmjRNra5TGdkSip0pnI0ExBiY9yViNrL+fxbWmTgUXM54RnGiBdiCs5jbEyM3N3gCkq59BQeRg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553580; c=relaxed/simple;
	bh=NrchFry08jimKHJTtjwMb7qvAV4BWdnIi0rWstHB3zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9IIJfpLeSD7Jg/PAepLpi3RzuLGmzoIor/iGLiXu6k1jPge2GuIIw7FkrOE21y2IHrL8Xt9wWynoQnDTezHg9K8wNDFuJL+k2NGJzUbf89uyJHODumK65YEjpmgEQRaWKXRSA7lhsuQTAnr+QiiFQ9ZxY7x2JnYKOxqJH6ZJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aMmTug2B; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760553568; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tTrc6f5yih50+cVkndbi4Wxrjf+M4PRkCTzWDvYXQnI=;
	b=aMmTug2Bi09cb9DgEwHj5rdqKBNX835iMyigrmRMsJh7UCIajdRlW7Zsu7OeWf/t3xi0JDkIoJZUslR+Gv95/Or2R+1vVO10G7hLPxwsPRGZcCmmKCcghGKhWCa1hyFlHL3UTej5x7TsSxVns6GCqqQGExkiTcqv949Dq+TnlMU=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqHLOQ2_1760553567 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 02:39:28 +0800
Message-ID: <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
Date: Thu, 16 Oct 2025 02:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
 djwong@kernel.org, bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 2025/10/16 02:21, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 11:06 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>>
>>> This is where I encountered it in erofs: [1] for the "WARNING in
>>> iomap_iter_advance" syz repro. (this syzbot report was generated in
>>> response to this patchset version [2]).
>>>
>>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
>>
>> I just ran the C repro locally with the upstream codebase (but I
>> didn't use the related Kconfig), and it doesn't show anything.
> 
> Which upstream commit are you running it on? It needs to be run on top
> of this patchset [1] but without this fix [2]. These changes are in
> Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> that branch has been published publicly yet so maybe just patching it
> in locally will work best.
> 
> When I reproed it last month, I used the syz executor (not the C
> repro, though that should probably work too?) directly with the
> kconfig they had.

I believe it's a regression somewhere since it's a valid
IOMAP_INLINE extent (since it's inlined, the length is not
block-aligned of course), you could add a print just before
erofs_iomap_begin() returns.

Also see my reply:
https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alibaba.com

I'm not sure if it caused user-visible regressions since
erofs images work properly with upstream code (unlike a
previous regression fixed by commit b26816b4e320 ("iomap:
fix inline data on buffered read")).

But a fixes tag is needed since it causes an unexpected
WARNING at least.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t
> [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
> [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> 
>>
>> I feel strange why pos is unaligned, does this warning show
>> without your patchset on your side?
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Joanne
>>>
>>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
>>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
>>>
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Joanne
>>>>>
>>>>>>
>>>>>> Otherwise looks good:
>>>>>>
>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>
>>


