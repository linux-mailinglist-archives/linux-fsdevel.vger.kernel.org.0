Return-Path: <linux-fsdevel+bounces-69800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD57C85B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A8A3A364B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D51326D5C;
	Tue, 25 Nov 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fvsvhkbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518D2264D3;
	Tue, 25 Nov 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083792; cv=none; b=PwLKP+uUn/kEaTOmXK49QAaym+PMOWJYdrWnDUqK8Dwej9NJNZ3tQ2KQRy3cDcIGnzHB4fLoPe6G3D6QqBqfo+JbPFDWrNt7NXIz5ZSlv19Mh75OqBJLpJ7FwuzcoaBHax7V5GA3YcpaW86BN+XtHPqtC1ygHbkJVGo4PR4cNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083792; c=relaxed/simple;
	bh=+i1tYXUVB7TkpAzpyKckn8A/TrVqg2ix6QJyQjxRtLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVSnENp7ZkkrBitROQ/ZoM9UJ7khj2Q8G6yN/TAFfL5UbZVduuf9W5stm0X9uR++qVfzrREwfSHIDY7/y1YR0hWhnu9n8VsVT4ZOmNiHUwrBX3Ht8YzIukpyvreSnA8rsPpE1KU8FdDCGxKLedoOHpWB7NIvBMWsBUg7dRzc3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fvsvhkbr; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764083780; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BchfNn9yY1ycldSYtHGeuqhCdlZ37YDfrT56bbg4YGg=;
	b=fvsvhkbrolGlvI4pd6AihbseGnRCWmDbFLMJ8vzsQDQRdRkLMiefr/A0zVKUMGwmQKWHnl2pFetttC1sBAD0AxeGf3tPTzQg5Y0uUBbZlwjEKR7o6p1bzvVHWpYKgoOIK8EYhA2NvDkgIcBVbiEAETynsmpv+Xae2RCh8NIPayA=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtOT2S3_1764083778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Nov 2025 23:16:19 +0800
Message-ID: <b67d59aa-bcff-4547-8fc2-5f153e826ec7@linux.alibaba.com>
Date: Tue, 25 Nov 2025 23:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <aSQfC2rzoCZcMfTH@fedora> <aSQf6gMFzn-4ohrh@infradead.org>
 <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
 <aSV0sDZGDoS-tLlp@fedora>
 <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
 <aSWHx3ynP9Z_6DeY@fedora>
 <4a5ec383-540b-461d-9e53-15593a22a61a@linux.alibaba.com>
 <aSWXeIVjArYsAbyf@fedora>
 <dbff8d43-3313-459b-9c9f-d431fcae0249@linux.alibaba.com>
 <aSWeq4dN69WsH2EI@fedora>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aSWeq4dN69WsH2EI@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/25 20:18, Ming Lei wrote:
> On Tue, Nov 25, 2025 at 07:58:09PM +0800, Gao Xiang wrote:
>>
>>
>> On 2025/11/25 19:48, Ming Lei wrote:
>>> On Tue, Nov 25, 2025 at 06:57:15PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/11/25 18:41, Ming Lei wrote:
>>>>> On Tue, Nov 25, 2025 at 05:39:17PM +0800, Gao Xiang wrote:
>>>>>> Hi Ming,
>>>>>>
>>>>>> On 2025/11/25 17:19, Ming Lei wrote:
>>>>>>> On Tue, Nov 25, 2025 at 03:26:39PM +0800, Gao Xiang wrote:
>>>>>>>> Hi Ming and Christoph,
>>>>>>>>
>>>>>>>> On 2025/11/25 11:00, Ming Lei wrote:
>>>>>>>>> On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
>>>>>>>>>> On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
>>>>>>>>>>> On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
>>>>>>>>>>>> FYI, with this series I'm seeing somewhat frequent stack overflows when
>>>>>>>>>>>> using loop on top of XFS on top of stacked block devices.
>>>>>>>>>>>
>>>>>>>>>>> Can you share your setting?
>>>>>>>>>>>
>>>>>>>>>>> BTW, there are one followup fix:
>>>>>>>>>>>
>>>>>>>>>>> https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
>>>>>>>>>>>
>>>>>>>>>>> I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
>>>>>>>>>>> not see stack overflow with the above fix against -next.
>>>>>>>>>>
>>>>>>>>>> This was with a development tree with lots of local code.  So the
>>>>>>>>>> messages aren't applicable (and probably a hint I need to reduce my
>>>>>>>>>> stack usage).  The observations is that we now stack through from block
>>>>>>>>>> submission context into the file system write path, which is bad for a
>>>>>>>>>> lot of reasons.  journal_info being the most obvious one.
>>>>>>>>>>
>>>>>>>>>>>> In other words:  I don't think issuing file system I/O from the
>>>>>>>>>>>> submission thread in loop can work, and we should drop this again.
>>>>>>>>>>>
>>>>>>>>>>> I don't object to drop it one more time.
>>>>>>>>>>>
>>>>>>>>>>> However, can we confirm if it is really a stack overflow because of
>>>>>>>>>>> calling into FS from ->queue_rq()?
>>>>>>>>>>
>>>>>>>>>> Yes.
>>>>>>>>>>
>>>>>>>>>>> If yes, it could be dead end to improve loop in this way, then I can give up.
>>>>>>>>>>
>>>>>>>>>> I think calling directly into the lower file system without a context
>>>>>>>>>> switch is very problematic, so IMHO yes, it is a dead end.
>>>>>>>> I've already explained the details in
>>>>>>>> https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com
>>>>>>>>
>>>>>>>> to zram folks why block devices act like this is very
>>>>>>>> risky (in brief, because virtual block devices don't
>>>>>>>> have any way (unlike the inner fs itself) to know enough
>>>>>>>> about whether the inner fs already did something without
>>>>>>>> context save (a.k.a side effect) so a new task context
>>>>>>>> is absolutely necessary for virtual block devices to
>>>>>>>> access backing fses for stacked usage.
>>>>>>>>
>>>>>>>> So whether a nested fs can success is intrinsic to
>>>>>>>> specific fses (because either they assure no complex
>>>>>>>> journal_info access or save all effected contexts before
>>>>>>>> transiting to the block layer.  But that is not bdev can
>>>>>>>> do since they need to do any block fs.
>>>>>>>
>>>>>>> IMO, task stack overflow could be the biggest trouble.
>>>>>>>
>>>>>>> block layer has current->blk_plug/current->bio_list, which are
>>>>>>> dealt with in the following patches:
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-block/20251120160722.3623884-4-ming.lei@redhat.com/
>>>>>>> https://lore.kernel.org/linux-block/20251120160722.3623884-5-ming.lei@redhat.com/
>>>>>>
>>>>>> I think it's the simplist thing for this because the
>>>>>> context of "current->blk_plug/current->bio_list" is
>>>>>> _owned_ by the block layer, so of course the block
>>>>>> layer knows how to (and should) save and restore
>>>>>> them.
>>>>>
>>>>> Strictly speaking, all per-task context data is owned by task, instead
>>>>> of subsystems, otherwise, it needn't to be stored in `task_struct` except
>>>>> for some case just wants per-task storage.
>>>>>
>>>>> For example of current->blk_plug, it is used by many subsystems(io_uring, FS,
>>>>> mm, block layer, md/dm, drivers, ...).
>>>>>
>>>>>>
>>>>>>>
>>>>>>> I am curious why FS task context can't be saved/restored inside block
>>>>>>> layer when calling into new FS IO? Given it is just per-task info.
>>>>>>
>>>>>> The problem is a block driver don't know what the upper FS
>>>>>> (sorry about the terminology) did before calling into block
>>>>>> layer (the task_struct and journal_info side effect is just
>>>>>> the obvious one), because all FSes (mainly the write path)
>>>>>> doesn't assume the current context will be transited into
>>>>>> another FS context, and it could introduce any fs-specific
>>>>>> context before calling into the block layer.
>>>>>>
>>>>>> So it's the fs's business to save / restore contexts since
>>>>>> they change the context and it's none of the block layer
>>>>>> business to save and restore because the block device knows
>>>>>> nothing about the specific fs behavior, it should deal with
>>>>>> all block FSes.
>>>>>>
>>>>>> Let's put it into another way, thinking about generic
>>>>>> calling convention[1], which includes caller-saved contexts
>>>>>> and callee-saved contexts.  I think the problem is here
>>>>>> overally similiar, for loop devices, you know none of lower
>>>>>> or upper FS behaves (because it doesn't directly know either
>>>>>
>>>>> loop just need to know which data to save/restore.
>>>>
>>>> I've said there is no clear list of which data needs to be
>>>> saved/restored.
>>>>
>>>> FSes can do _anything_. Maybe something in `current` needs
>>>> to be saved, but anything that uses `current`/PID as
>>>> a mapping key also needs to be saved, e.g., arbitrary
>>>>
>>>> `hash_table[current]` or `context_table[current->pid]`.
>>>>
>>>> Again, because not all filesystems allow nesting by design:
>>>> Linux kernel doesn't need block filesystem to be nested.
>>>
>>> OK, got it, thanks for the sharing.
>>>
>>> BTW, block layer actually uses current->bio_list to avoid nested bio
>>> submission.
>>>
>>> The similar trick could be played on FS ->read_iter/->write_iter() over
>>> `kiocb` for avoiding nested FS IO too, but not sure if there is real
>>> big use case.
>>
>> I don't think it's much similar, `current->bio_list` just deals
>> with the single BIO concept, but what nested fses need to deal
> 
> No, it is not, it can be one tree of BIOs in case of dm/md.
> 
>> with is much complicated.
> 
> Care for sharing why/what the complicated is?
> 
> Anyway it is just one raw idea, and the devil is always in the details.

FS I/Os are more complicated, for example, you need do some metadata
I/Os in advance to get where to find the data, and then send data
I/Os, and data I/Os could also need to be {de,en}crypted,
(de)compressed and then pass to upper/lower fses.

All those behaviors can be in arbitary nested ways, a much
simplified coroutine-like current->bio_list is not enough
for such cases, anyway.  Also the programming model is
just different, I don't think it can be a practical way.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Ming


