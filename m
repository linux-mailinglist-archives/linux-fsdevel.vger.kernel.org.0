Return-Path: <linux-fsdevel+bounces-47269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0617A9B202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DA14C065C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB41A8F9A;
	Thu, 24 Apr 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1n7AUn25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93C1A9B5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508085; cv=none; b=PU2loPKhTdresBJQLY1iKRFgY/yh6x3HUs5SX0r8KFls/y76uxtqIYS6pqIsotUvxmDWyDnikaBAgpg//LTZG7uar8t/M4Y/AWW23OkU8wCXOA7GOmmgJuNW/HzBWsTl1lXJRPTWFSCZt9NMucBR6mVjlMXrJDmkCu+YBM7RTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508085; c=relaxed/simple;
	bh=waua1ye1L5Xh8421D5bOXrk3HK1ZzjcPRq1GkKUhXD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1EqZCGiThNiJ0VegvB+mon3zVdkoQ0tHrE/sSX8qXKzSP+Tg4eKVMyjv6r/RTIyLMC5MEQbnn7v0amzr0BeeiH3ZNQaifOMWmiHSc6Kn+GCIENuBOnqZJd17T+XfRHsV+rSRKSsNSBzDgYrA+tl+RtnTo0QXDLLnxoaa3ki0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1n7AUn25; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e15dc801aso97244939f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745508081; x=1746112881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49tEuZJbApWmoJu7HSg51xfF3TH4o2He6H3h4M5pJC0=;
        b=1n7AUn25onzJxQvuWin9uv0J/LVBXswlNeKaq9PA/15fSPZT7DE2kn9p8TM+Bfsm9L
         WktCp0IMO3355SLtH4oriNCc5JOJgfkERXjDYs/9N1KnvjMtClb6u5EwJViXv1JARj9w
         g+jlocR/yN8hrhLquu89UiM5MS+ZzxN5OEnc/tJ1qiZYmvmvsjZCrnjxuYfNq63Lnsvo
         Px8RfFTEgL3ZeEVEe5PbLk0Mzx6+03OaU1r6Oe8GQKkrlBzU/CpVRRC3GT2ZGM+ABetg
         NIu5TToyFWHcj/w08EkfxE4IRbIoJHoA+gtyEEIfiB1zW7bmxLTuI4jXBRLebuAg7/RB
         lOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508081; x=1746112881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49tEuZJbApWmoJu7HSg51xfF3TH4o2He6H3h4M5pJC0=;
        b=SEbGTINgBwt8hEmKuKFaeCMLyRQIFjoPrUtdU+4cju6/dLxMsvYv5wPqLk6o6jRNPD
         mSI6KnsVDuB8ryyLwgrHpKQr7M0d7AWCd0x+meqwEWJdC5GH6VUdU1lSrOekfdjDty6j
         hMNazEHuQx/1eQkjVIl0HuXU3HRzbqK++PIfpPfdkIhUCgIDFJEm1Ixs4kTtrtJil6nw
         +fUr30I2oN/gBEqOijZ0OqIY0iIjUKKSDVDrclSYfsXWOnq9a/SZkjNOU0GFv+L+hvwr
         VoTwOsaO5q/z8lYmf6NRv/vbkp+w/0Mu+ja/CPzbbNB4NodwnJ308Wlmx74cQQ7yMS0p
         cjaA==
X-Forwarded-Encrypted: i=1; AJvYcCUMoONO3EvAH47G8+sltcJd1EaytTSqq31NCpTDp3bQx6mdfJhyIm7TLGJV91wonZ9EpxBMp+wh13EA3ljq@vger.kernel.org
X-Gm-Message-State: AOJu0YwntptLUyy/ICOUZqz5RggOuBE2Bnt2sXASyVuddbosRGU1Az4d
	NbmeC6Od17/uGO3uByMMWHD58xrWuzFq4xnFB/jagm/2D3jQU/xKAoy7ppG6o6s=
X-Gm-Gg: ASbGncu1bVoAr6VeopsPDUOzOBRG/dHnGR2CVwt6IVAA98pdq+Kbx5r35zC+6Y7WWdF
	uUlP1bS53lul/3F0sUEZr/bA2Yy+P4/ZVimMsfZjdKbuq23wKB29p/yUEosO15SdmVbFuz7vqCV
	zbtQBP4KsSG8b7S0O3R9rkps9NWMRcq8AyLGOUE81Soz8ft83wXgAT7FE76LmYAN1+5Ca1dBWLS
	8N/2hMroTZJCB5S6I7PBw6QMOVvCv2V5C4pVrZaQNyGou4UGhUB5QDed+/Cmt7+2G5Mo9r9Vv/h
	FJePQYr7gsRU0MREo0QP2bQPGjnhIG82RskhhrpeWk9/PR4=
X-Google-Smtp-Source: AGHT+IHQTmXyzHLQOzgo/eMfvMWKyYK0kJgCkK9vX/4gp7A9xRnuKW3wH9ylm4KUyuaAHW/QcXl6pw==
X-Received: by 2002:a05:6602:150b:b0:864:4812:ca54 with SMTP id ca18e2360f4ac-8644f993375mr399979539f.6.1745508080808;
        Thu, 24 Apr 2025 08:21:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864519f6330sm23332139f.46.2025.04.24.08.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 08:21:19 -0700 (PDT)
Message-ID: <fdcb66e3-e99a-49f9-8874-00110b06bb3d@kernel.dk>
Date: Thu, 24 Apr 2025 09:21:18 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] io_uring: Add new functions to handle user fault
 scenarios
To: =?UTF-8?B?5aec5pm65Lyf?= <qq282012236@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 akpm@linux-foundation.org, peterx@redhat.com, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250422162913.1242057-1-qq282012236@gmail.com>
 <20250422162913.1242057-2-qq282012236@gmail.com>
 <14195206-47b1-4483-996d-3315aa7c33aa@kernel.dk>
 <CANHzP_uW4+-M1yTg-GPdPzYWAmvqP5vh6+s1uBhrMZ3eBusLug@mail.gmail.com>
 <b61ac651-fafe-449a-82ed-7239123844e1@kernel.dk>
 <CANHzP_tLV29_uk2gcRAjT9sJNVPH3rMyVuQP07q+c_TWWgsfDg@mail.gmail.com>
 <7bea9c74-7551-4312-bece-86c4ad5c982f@kernel.dk>
 <52d55891-36e3-43e7-9726-a2cd113f5327@kernel.dk>
 <cac3a5c9-e798-47f2-81ff-3c6003c6d8bb@kernel.dk>
 <CANHzP_uJft1FPJ0W++0Zp5rUjayaULEdpAQRn1VuuqDVq3DmJA@mail.gmail.com>
 <5c20b5ca-ce41-43c4-870a-c50206ab058d@kernel.dk>
 <CANHzP_u2SA3uSoG-4LQ-e9BvW6t-Zo1wn8qnKM0xYGoekL74bA@mail.gmail.com>
 <1ed67bb5-5d3d-4af8-b5a7-4f644186708b@kernel.dk>
 <CANHzP_vi1SaC+jP_UZqsjFA=Gu=Q3ST0XR_ECm=4O-5G8Jmqqg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CANHzP_vi1SaC+jP_UZqsjFA=Gu=Q3ST0XR_ECm=4O-5G8Jmqqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 9:12 AM, ??? wrote:
> Jens Axboe <axboe@kernel.dk> ?2025?4?24??? 22:53???
>>
>> On 4/24/25 8:45 AM, ??? wrote:
>>> Jens Axboe <axboe@kernel.dk> ?2025?4?24??? 22:13???
>>>>
>>>> On 4/24/25 8:08 AM, ??? wrote:
>>>>> Jens Axboe <axboe@kernel.dk> ?2025?4?24??? 06:58???
>>>>>>
>>>>>> On 4/23/25 9:55 AM, Jens Axboe wrote:
>>>>>>> Something like this, perhaps - it'll ensure that io-wq workers get a
>>>>>>> chance to flush out pending work, which should prevent the looping. I've
>>>>>>> attached a basic test case. It'll issue a write that will fault, and
>>>>>>> then try and cancel that as a way to trigger the TIF_NOTIFY_SIGNAL based
>>>>>>> looping.
>>>>>>
>>>>>> Something that may actually work - use TASK_UNINTERRUPTIBLE IFF
>>>>>> signal_pending() is true AND the fault has already been tried once
>>>>>> before. If that's the case, rather than just call schedule() with
>>>>>> TASK_INTERRUPTIBLE, use TASK_UNINTERRUPTIBLE and schedule_timeout() with
>>>>>> a suitable timeout length that prevents the annoying parts busy looping.
>>>>>> I used HZ / 10.
>>>>>>
>>>>>> I don't see how to fix userfaultfd for this case, either using io_uring
>>>>>> or normal write(2). Normal syscalls can pass back -ERESTARTSYS and get
>>>>>> it retried, but there's no way to do that from inside fault handling. So
>>>>>> I think we just have to be nicer about it.
>>>>>>
>>>>>> Andrew, as the userfaultfd maintainer, what do you think?
>>>>>>
>>>>>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>>>>>> index d80f94346199..1016268c7b51 100644
>>>>>> --- a/fs/userfaultfd.c
>>>>>> +++ b/fs/userfaultfd.c
>>>>>> @@ -334,15 +334,29 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>>>>>>         return ret;
>>>>>>  }
>>>>>>
>>>>>> -static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
>>>>>> +struct userfault_wait {
>>>>>> +       unsigned int task_state;
>>>>>> +       bool timeout;
>>>>>> +};
>>>>>> +
>>>>>> +static struct userfault_wait userfaultfd_get_blocking_state(unsigned int flags)
>>>>>>  {
>>>>>> +       /*
>>>>>> +        * If the fault has already been tried AND there's a signal pending
>>>>>> +        * for this task, use TASK_UNINTERRUPTIBLE with a small timeout.
>>>>>> +        * This prevents busy looping where schedule() otherwise does nothing
>>>>>> +        * for TASK_INTERRUPTIBLE when the task has a signal pending.
>>>>>> +        */
>>>>>> +       if ((flags & FAULT_FLAG_TRIED) && signal_pending(current))
>>>>>> +               return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, true };
>>>>>> +
>>>>>>         if (flags & FAULT_FLAG_INTERRUPTIBLE)
>>>>>> -               return TASK_INTERRUPTIBLE;
>>>>>> +               return (struct userfault_wait) { TASK_INTERRUPTIBLE, false };
>>>>>>
>>>>>>         if (flags & FAULT_FLAG_KILLABLE)
>>>>>> -               return TASK_KILLABLE;
>>>>>> +               return (struct userfault_wait) { TASK_KILLABLE, false };
>>>>>>
>>>>>> -       return TASK_UNINTERRUPTIBLE;
>>>>>> +       return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, false };
>>>>>>  }
>>>>>>
>>>>>>  /*
>>>>>> @@ -368,7 +382,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>>>>         struct userfaultfd_wait_queue uwq;
>>>>>>         vm_fault_t ret = VM_FAULT_SIGBUS;
>>>>>>         bool must_wait;
>>>>>> -       unsigned int blocking_state;
>>>>>> +       struct userfault_wait wait_mode;
>>>>>>
>>>>>>         /*
>>>>>>          * We don't do userfault handling for the final child pid update
>>>>>> @@ -466,7 +480,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>>>>         uwq.ctx = ctx;
>>>>>>         uwq.waken = false;
>>>>>>
>>>>>> -       blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>>>>>> +       wait_mode = userfaultfd_get_blocking_state(vmf->flags);
>>>>>>
>>>>>>          /*
>>>>>>           * Take the vma lock now, in order to safely call
>>>>>> @@ -488,7 +502,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>>>>          * following the spin_unlock to happen before the list_add in
>>>>>>          * __add_wait_queue.
>>>>>>          */
>>>>>> -       set_current_state(blocking_state);
>>>>>> +       set_current_state(wait_mode.task_state);
>>>>>>         spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>>>>>>
>>>>>>         if (!is_vm_hugetlb_page(vma))
>>>>>> @@ -501,7 +515,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>>>>
>>>>>>         if (likely(must_wait && !READ_ONCE(ctx->released))) {
>>>>>>                 wake_up_poll(&ctx->fd_wqh, EPOLLIN);
>>>>>> -               schedule();
>>>>>> +               /* See comment in userfaultfd_get_blocking_state() */
>>>>>> +               if (!wait_mode.timeout)
>>>>>> +                       schedule();
>>>>>> +               else
>>>>>> +                       schedule_timeout(HZ / 10);
>>>>>>         }
>>>>>>
>>>>>>         __set_current_state(TASK_RUNNING);
>>>>>>
>>>>>> --
>>>>>> Jens Axboe
>>>>> I guess the previous io_work_fault patch might have already addressed
>>>>> the issue sufficiently. The later patch that adds a timeout for
>>>>> userfaultfd might
>>>>
>>>> That one isn't guaranteed to be safe, as it's not necessarily a safe
>>>> context to prune the conditions that lead to a busy loop rather than the
>>>> normal "schedule until the condition is resolved". Running task_work
>>>> should only be done at the outermost point in the kernel, where the task
>>>> state is known sane in terms of what locks etc are being held. For some
>>>> conditions the patch will work just fine, but it's not guaranteed to be
>>>> the case.
>>>>
>>>>> not be necessary  wouldn?t returning after a timeout just cause the
>>>>> same fault to repeat indefinitely again? Regardless of whether the
>>>>> thread is in UN or IN state, the expected behavior should be to wait
>>>>> until the page is filled or the uffd resource is released to be woken
>>>>> up, which seems like the correct logic.
>>>>
>>>> Right, it'll just sleep timeout for a bit as not to be a 100% busy loop.
>>>> That's unfortunately the best we can do for this case... The expected
>>>> behavior is indeed to schedule until we get woken, however that just
>>>> doesn't work if there are signals pending, or other conditions that lead
>>>> to TASK_INTERRUPTIBLE + schedule() being a no-op.
>>>>
>>>> --
>>>> Jens Axboe
>>> In my testing, clearing the NOTIFY flag in the original io_work_fault
>>> ensures that the next schedule correctly waits. However, adding a
>>
>> That's symptom fixing again - the NOTIFY flag is the thing that triggers
>> for io_uring, but any legitimate signal (or task_work added with
>> signaling) will cause the same issue.
>>
>>> timeout causes the issue to return to multiple faults again.
>>> Also, after clearing the NOTIFY flag in handle_userfault,
>>> it?s possible that some task work hasn?t been executed.
>>> But if task_work_run isn?t added back, tasks might get lost?
>>> It seems like there isn?t an appropriate place to add it back.
>>> So, do you suggest adjusting the fault frequency in userfaultfd
>>> to make it more rhythmic to alleviate the issue?
>>
>> The task_work is still there, you just removed the notification
>> mechanism that tells the kernel that there's task_work there. For this
>> particular case, you could re-set TIF_NOTIFY_SIGNAL at the end after
>> schedule(), but again it'd only fix that specific one case, not the
>> generic issue.
>>
>> What's the objection to the sleep approach? If the task is woken by the
>> fault being filled, it'll still wake on time, no delay. If not, then it
>> prevents a busy loop, which is counterproductive.
>>
>> --
>> Jens Axboe
> OK Thanks .and i?m curious about what exactly is meant by a
> 'specific one case 'and what qualifies as a 'generic issue' with re-set
> TIF_NOTIFY_SIGNAL.

I already outlined that in earlier replies, find the email that states
the various conditions that can lead to schedule() w/TASK_INTERRUPTIBLE
to return immediately rather than sleeping. TIF_NOTIFY_SIGNAL is _one_
such condition, it's not _all_ conditions.

> So, in your final opinion, do you think the code in io_uring is not
> suitable for modification, should focus on making adjustments in
> userfaultfd to mitigate the issue?

The problem isn't in io_uring in the first place, you just happened to
trip over it via that path. I even sent out a test case that
demonstrates how to trigger this without io_uring as well. I'm a bit
puzzled as to why all of this isn't clear already.

-- 
Jens Axboe

