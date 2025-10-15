Return-Path: <linux-fsdevel+bounces-64260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2578BE0001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6266F4FD68E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954C301468;
	Wed, 15 Oct 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EUn+rQJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4B303A09
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551612; cv=none; b=qEikq8oodKpUT0ckxWyP9DRynOsJ7mhGZAZf1BDQrU4VP3ue3Lj9u3V5MRZ8cZEb4J6lz9l7R+1Sc7vgXBtfBR0NGmCnqkYwxaHtRvnSqVQ8cCvrrs2n9+LTFdm5lDySXT7SHc9oNv9rAG/TvanX+T6Y8ifsLqLAhHPGFV6cAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551612; c=relaxed/simple;
	bh=tDVe3iFhTAVy1iZGzP2GeW8y71iLQ/oV5JBMOMbA+/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgGwJUHCiY4lJwOl0wjU6wbpeyozHnKCa6ZJ5efWEjZcOMKYfpOVayJeE7s69Jb5+j0vc0EWLfoVYJjcGk2ucp86+BC4k2YFC4nGQ6flS0lhC2Rj1r2AlqSIoUl4ntOy9X4VfpzRN5FKRaXWEkxUO1miLzN9sMMghMlSRxAih2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EUn+rQJy; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760551605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3WOBBeJ5CNwrbT4c+afSWSFhVu+ImcZobVwd+jhY2eA=;
	b=EUn+rQJydcF9hMO9UjulKcJpbRqrtCOmOltyJvxPzUl0k4CfOspjC3eJO6NNxRIXxhx/UbiAL1QIf5cfjsV0FQWJJjD6Agc5ZaVmYuG37eeIv4YwmfoNQEZ7eKF2LFzB3xP+du7NmDhp++GX9Zc0pkz16M6kw+IyZ5fV6vpBkHA=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqHNtUF_1760551604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 02:06:45 +0800
Message-ID: <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
Date: Thu, 16 Oct 2025 02:06:43 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/16 01:49, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 10:40 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/10/16 01:34, Joanne Koong wrote:
>>> On Sun, Oct 12, 2025 at 8:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>>
>>>> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
>>>>> The end position to start truncating from may be at an offset into a
>>>>> block, which under the current logic would result in overtruncation.
>>>>>
>>>>> Adjust the calculation to account for unaligned end offsets.
>>>>
>>>> Should this get a fixes tag?
>>>
>>> I don't think this needs a fixes tag because when it was originally
>>> written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
>>> buffered I/O without buffer heads") in 2018), it was only used by xfs.
>>> think it was when erofs started using iomap that iomap mappings could
>>> represent non-block-aligned data.
>>
>> What non-block-aligned data exactly? erofs is a strictly block-aligned
>> filesystem except for tail inline data.
>>
>> Is it inline data? gfs2 also uses the similar inline data logic.
> 
> This is where I encountered it in erofs: [1] for the "WARNING in
> iomap_iter_advance" syz repro. (this syzbot report was generated in
> response to this patchset version [2]).
> 
> When I ran that syz program locally, I remember seeing pos=116 and length=3980.

I just ran the C repro locally with the upstream codebase (but I
didn't use the related Kconfig), and it doesn't show anything.

I feel strange why pos is unaligned, does this warning show
without your patchset on your side?

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
> 
> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>>
>>> Thanks,
>>> Joanne
>>>
>>>>
>>>> Otherwise looks good:
>>>>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>


