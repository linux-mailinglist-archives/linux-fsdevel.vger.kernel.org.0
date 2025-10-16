Return-Path: <linux-fsdevel+bounces-64332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FDBE135C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 03:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F3F406E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 01:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903461DE2D7;
	Thu, 16 Oct 2025 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uuJXl7ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4E17C91
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760579925; cv=none; b=CE9U1K457S0poUXelkfyIx1O2yCdBr5cg3cCHceGP06bJkVsh3Yqpfb8F0sygNzE/NdW/6bUy1FgZYdErTOMPX89MSzOkqhEawJyytO47uTdhnuRIDyAUER1IML1LYS/Bc9YNRRSZCNWpnxS6j8tL36adJdezu2prSVGHntF1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760579925; c=relaxed/simple;
	bh=tq8RmGo0GWuy1c8mfOzyoAnGYQzAOo96HihLTfySoyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9qcok6C922SnbtkRJbkcNr7KURdAVt7/MjDhciCbQNBqPsXWQRmFww0Mze3gQ9jrQLyk9BmrGdqtKjZYYtJtNEbw0NK7xwxR5rs3U6Wo87tgMw2L0FTnlWBXof29Lwh/hDHrpwZOXWNGrW7xupkTItiYIFn68e/zOR3igIiolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uuJXl7ed; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760579914; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ipnXpWddCfJUsTNm0eXVMV3NJoG22UhC+3DNrHotCcs=;
	b=uuJXl7edw75wd2TRnNfjxFZUUAshghIyMlAIDVKMVZOMPG+a3u1BLzO+PAJKXZpvjAFejRH2+x+4UCm8xINi4JL0Y1d9V/vtr1uUG8p+IJut9RbhlyzTYm0Io/I9A2Tl1WkC6IWj8/iEf6AbbqItAdtveyKSmaUE9TggjUG1eMs=
Received: from 30.221.131.73(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIOoLK_1760579912 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 09:58:33 +0800
Message-ID: <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com>
Date: Thu, 16 Oct 2025 09:58:32 +0800
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
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
 <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/16 09:27, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 5:36 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Wed, Oct 15, 2025 at 11:39 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>> Hi Joanne,
>>>
>>> On 2025/10/16 02:21, Joanne Koong wrote:
>>>> On Wed, Oct 15, 2025 at 11:06 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>> ...
>>>
>>>>>>
>>>>>> This is where I encountered it in erofs: [1] for the "WARNING in
>>>>>> iomap_iter_advance" syz repro. (this syzbot report was generated in
>>>>>> response to this patchset version [2]).
>>>>>>
>>>>>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
>>>>>
>>>>> I just ran the C repro locally with the upstream codebase (but I
>>>>> didn't use the related Kconfig), and it doesn't show anything.
>>>>
>>>> Which upstream commit are you running it on? It needs to be run on top
>>>> of this patchset [1] but without this fix [2]. These changes are in
>>>> Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
>>>> that branch has been published publicly yet so maybe just patching it
>>>> in locally will work best.
>>>>
>>>> When I reproed it last month, I used the syz executor (not the C
>>>> repro, though that should probably work too?) directly with the
>>>> kconfig they had.
>>>
>>> I believe it's a regression somewhere since it's a valid
>>> IOMAP_INLINE extent (since it's inlined, the length is not
>>> block-aligned of course), you could add a print just before
>>> erofs_iomap_begin() returns.
>>
>> Ok, so if erofs is strictly block-aligned except for tail inline data
>> (eg the IOMAP_INLINE extent), then I agree, there is a regression
>> somewhere as we shouldn't be running into the situation where erofs is
>> calling iomap_adjust_read_range() with a non-block-aligned position
>> and length. I'll track the offending commit down tomorrow.
>>
> 
> Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> iomap_iter advances") that changed this behavior for erofs such that
> the read iteration continues even after encountering an IOMAP_INLINE
> extent, whereas before, the iteration stopped after reading in the
> iomap inline extent. This leads erofs to end up in the situation where
> it calls into iomap_adjust_read_range() with a non-block-aligned
> position/length (on that subsequent iteration).
> 
> In particular, this change in commit bc264fea0f6f to iomap_iter():
> 
> -       if (ret > 0 && !iter->processed && !stale)
> +       if (ret > 0 && !advanced && !stale)
> 
> For iomap inline extents, iter->processed is 0, which stopped the
> iteration before. But now, advanced (which is iter->pos -
> iter->iter_start_pos) is used which will continue the iteration (since
> the iter is advanced after reading in the iomap inline extents).
> 
> Erofs is able to handle subsequent iterations after iomap_inline
> extents because erofs_iomap_begin() checks the block map and returns
> IOMAP_HOLE if it's not mapped
>          if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>                  iomap->type = IOMAP_HOLE;
>                  return 0;
>          }
> 
> but I think what probably would be better is a separate patch that
> reverts this back to the original behavior of stopping the iteration
> after IOMAP_INLINE extents are read in.

Thanks for your analysis, currently I don't have enough time to look
into that (working on other stuffs), but according to your analysis,
it seems EROFS don't have a user-visible regression in the Linus'
upstream.

> 
> So I don't think this patch should have a fixes: tag for that commit.
> It seems to me like no one was hitting this path before with a
> non-block-aligned position and offset. Though now there will be a use
> case for it, which is fuse.

To make it simplified, the issue is that:
  - Previously, before your fuse iomap read patchset (assuming Christian
    is already applied), there was no WARNING out of there;

  - A new WARNING should be considered as a kernel regression.

I'm not sure if Christian's iomap branch allows to be rebased, so in
principle, either:

  - You insert this patch before the WARNING patch in the fuse patchset
    goes in, so no Fixes tag is needed because the WARNING doesn't
    exist anymore,

Or

  - Add the Fixes tag to point to the commit which causes the WARNING
one.

Why it's important? because each upstream commit can be (back)ported
to stable or downstream kernels, a WARNING should be considered as
a new regression and needs a fix commit to be ported together, even
those patches will be merged into upstream together.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
> 
>>
>> Thanks,
>> Joanne
>>
>>>
>>> Also see my reply:
>>> https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alibaba.com
>>>
>>> I'm not sure if it caused user-visible regressions since
>>> erofs images work properly with upstream code (unlike a
>>> previous regression fixed by commit b26816b4e320 ("iomap:
>>> fix inline data on buffered read")).
>>>
>>> But a fixes tag is needed since it causes an unexpected
>>> WARNING at least.
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>> Joanne
>>>>
>>>> [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t
>>>> [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
>>>> [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
>>>>
>>>>>
>>>>> I feel strange why pos is unaligned, does this warning show
>>>>> without your patchset on your side?
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Joanne
>>>>>>
>>>>>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
>>>>>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Gao Xiang
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Joanne
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Otherwise looks good:
>>>>>>>>>
>>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>>>>
>>>>>
>>>


