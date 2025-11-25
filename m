Return-Path: <linux-fsdevel+bounces-69758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF11C84665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A36A34CCA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306522EE617;
	Tue, 25 Nov 2025 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UNMXJKE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7662F0C49;
	Tue, 25 Nov 2025 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065626; cv=none; b=dHqir4tjuZvJboO2dbmIdpDG0Hy3Omnp5IgqW5tvzsmZYAD3nF1qNnjnR13NluVMVYXCP2AU6tth6CW9YE/dIrGVw7XN72ob/2g29cJ/G6NZ+lQKSJvayUyvPrUP91elMR9WGpf5h2eneY10sD04+skjXTP558AD0ItdOsEDSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065626; c=relaxed/simple;
	bh=s2XuAC5KC3E35qt2g9Uo0PrwWLAKZuxfMW1Ta6YzoWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bR0F7ch8GkRA37iGkK1mBBsnW14vZRcMTjVV/3EPTinx6GzDqltegEzsa03c3CUOQ95L86hVSXVyOETu0Vc8rjZVxfs2YzX6epvRgpo4Dg7OM9hoegH1dstDooJRQLg4PanUWEyCC7rm4YBYa+GXuz8mOdkBQrYtNdhxj/xgYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UNMXJKE/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764065619; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Cq9yC417RMtpG9jYNWXznPbgLjOjJKcodhThHSBGqMI=;
	b=UNMXJKE/uoVOgOaDyxYJpmDPEFsqdW5tTagdrtjx8+fIQwdrzJzYGa3wG/j+JQhfBIl9hSWEHVArjFsCFsnlO+qBklYlBEO/XkYvu5oOEZzOWwpOHgFF7QwaRQGetdKvVaPb/aDOr4LYLPFoWlc15L+HNspJx1Guy4svdD0gPtg=
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtNLdeW_1764065618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Nov 2025 18:13:38 +0800
Message-ID: <85b6c0a6-9643-450c-845e-49110ff1a9eb@linux.alibaba.com>
Date: Tue, 25 Nov 2025 18:13:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org> <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org> <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
 <aSV0sDZGDoS-tLlp@fedora>
 <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
In-Reply-To: <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/11/25 17:39, Gao Xiang wrote:
> Hi Ming,
> 
> On 2025/11/25 17:19, Ming Lei wrote:
>> On Tue, Nov 25, 2025 at 03:26:39PM +0800, Gao Xiang wrote:
>>> Hi Ming and Christoph,
>>>
>>> On 2025/11/25 11:00, Ming Lei wrote:
>>>> On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
>>>>> On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
>>>>>> On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
>>>>>>> FYI, with this series I'm seeing somewhat frequent stack overflows when
>>>>>>> using loop on top of XFS on top of stacked block devices.
>>>>>>
>>>>>> Can you share your setting?
>>>>>>
>>>>>> BTW, there are one followup fix:
>>>>>>
>>>>>> https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
>>>>>>
>>>>>> I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
>>>>>> not see stack overflow with the above fix against -next.
>>>>>
>>>>> This was with a development tree with lots of local code.  So the
>>>>> messages aren't applicable (and probably a hint I need to reduce my
>>>>> stack usage).  The observations is that we now stack through from block
>>>>> submission context into the file system write path, which is bad for a
>>>>> lot of reasons.  journal_info being the most obvious one.
>>>>>
>>>>>>> In other words:  I don't think issuing file system I/O from the
>>>>>>> submission thread in loop can work, and we should drop this again.
>>>>>>
>>>>>> I don't object to drop it one more time.
>>>>>>
>>>>>> However, can we confirm if it is really a stack overflow because of
>>>>>> calling into FS from ->queue_rq()?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> If yes, it could be dead end to improve loop in this way, then I can give up.
>>>>>
>>>>> I think calling directly into the lower file system without a context
>>>>> switch is very problematic, so IMHO yes, it is a dead end.
>>> I've already explained the details in
>>> https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com
>>>
>>> to zram folks why block devices act like this is very
>>> risky (in brief, because virtual block devices don't
>>> have any way (unlike the inner fs itself) to know enough
>>> about whether the inner fs already did something without
>>> context save (a.k.a side effect) so a new task context
>>> is absolutely necessary for virtual block devices to
>>> access backing fses for stacked usage.
>>>
>>> So whether a nested fs can success is intrinsic to
>>> specific fses (because either they assure no complex
>>> journal_info access or save all effected contexts before
>>> transiting to the block layer.  But that is not bdev can
>>> do since they need to do any block fs.
>>
>> IMO, task stack overflow could be the biggest trouble.
>>
>> block layer has current->blk_plug/current->bio_list, which are
>> dealt with in the following patches:
>>
>> https://lore.kernel.org/linux-block/20251120160722.3623884-4-ming.lei@redhat.com/
>> https://lore.kernel.org/linux-block/20251120160722.3623884-5-ming.lei@redhat.com/
> 
> I think it's the simplist thing for this because the
> context of "current->blk_plug/current->bio_list" is
> _owned_ by the block layer, so of course the block
> layer knows how to (and should) save and restore
> them.
> 
>>
>> I am curious why FS task context can't be saved/restored inside block
>> layer when calling into new FS IO? Given it is just per-task info.
> 
> The problem is a block driver don't know what the upper FS
> (sorry about the terminology) did before calling into block
> layer (the task_struct and journal_info side effect is just
> the obvious one), because all FSes (mainly the write path)
> doesn't assume the current context will be transited into
> another FS context, and it could introduce any fs-specific
> context before calling into the block layer.
> 
> So it's the fs's business to save / restore contexts since
> they change the context and it's none of the block layer
> business to save and restore because the block device knows
> nothing about the specific fs behavior, it should deal with
> all block FSes.
> 
> Let's put it into another way, thinking about generic
> calling convention[1], which includes caller-saved contexts
> and callee-saved contexts.  I think the problem is here
> overally similiar, for loop devices, you know none of lower
> or upper FS behaves (because it doesn't directly know either
> upper or lower FS contexts), so it should either expect the
> upper fs to save all the contexts, or to use a new kthread
> context (to emulate userspace requests to FS) for lower FS.

Either expect a) the upper fs to save all the changed
contexts (because only upper fs knows what it did) so the
current context can be reused, or b) to use a new kthread
context (just like forking a new process -- to emulate an
entirely clean userspace requests to FS) for lower FS
since that's what modern multi-task OSes' magic to isolate
all possible contexts using the task concept.

I'm not saying a) is impossible but it needs a formal
contract (a strict convention [e.g. save all changed contexts
before submit_bio()] or new save/restore hooks to call on
demand) to let all filesystems know they now need to deal
with nested fses, rather than just crossing the line to
save non-block contexts in the block driver itself, because
it cannot be exhaustive.

Just my opinion on this for reference.

Thanks,
Gao Xiang

> 
> [1] https://en.wikipedia.org/wiki/Calling_convention
> 
> 
> Thanks,
> Gao Xiang
> 
>>
>>
>> Thanks,
>> Ming
> 


