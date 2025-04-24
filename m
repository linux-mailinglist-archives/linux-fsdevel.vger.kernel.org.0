Return-Path: <linux-fsdevel+bounces-47289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C5A9B695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 20:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3570D3AC704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B128368A;
	Thu, 24 Apr 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HwahfeUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BA28A1DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520063; cv=none; b=iiINK3IYAxxON8e/WkipitZw+PHq0J6SpHNIMa6Ha8ljRj6GPB0h/e1sVCUx8ZMmTr0MiRm5KHoLp4p5n0rwuyBWJybQwoqDTuT/5cZ1/Ltp4+KjwLEkWMCwxWx7q/yognaATo+jo/Tw5MgWk8gA9hs/OqkYZYTSEYr2rGIJcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520063; c=relaxed/simple;
	bh=8kOhXF5/ConIEvYw1HSa8rrXe9IOg5aC4q90kwLeOA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbge9pL+FXaLI5zCYfDk/Px6tsP4zxjIpxwBytoeFocvSeH/VI49+d0hOVVqCrKSTFBi63GvRyyBchOL/BzmPpBW3CC0YiJjAPHBcz7yAut6wvATiaUuqH/uwRc7ISRtDdcJcwOInT/ZvAWKdi/9oRV3YsZX+88VTCwEEhHORJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HwahfeUu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d4436ba324so12386545ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745520058; x=1746124858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zca/YBBDYkSw2gk6AJKZkA9LqeHxyFJXLmXocX2vY3Y=;
        b=HwahfeUuT830hH1Yko0w93BiEBbTVoWC2WabVpIQslCNEWKjAT7iOf1HAadDvBzP7a
         PnMRQr/Yiy3sbuMm7H6MUzg3B+x5RWSyBXUKdXq7OoQAvT7LFItpf6mwokcvs1NZgVOH
         zpq2BfLwi2djVpJFk4SgeuiDgBLi7lVvaloFqPqq3c7cQcElRvlWKxDUco8ZaVgAOWkZ
         lPIJ3wEa5qXFWC5ooNv0Y6d2i/GpCHldsmnv35u4fwIouJ5enx7milrWcyH2mRE/VVQL
         Vytf0UpCTCAqzryavtzEvSulYaGsH0y7gFf2yuZ9jv8j3cxTtBX+eSCvohetV0nthRQT
         dgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520058; x=1746124858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zca/YBBDYkSw2gk6AJKZkA9LqeHxyFJXLmXocX2vY3Y=;
        b=a8/PQDdUdymvZF9Q+rO7izc528YLgHwVJSi3GhxmCqncfiTgObpoqlR6AoVIE8osTU
         jagiP4Ax8piBa6fT+in924Uw5GZna679ane+ZpKYaaHKo3nk/4x9WFlhfHYItk/CSdww
         98XHJ8z9W3tXfUQ+HKWxSyuFh/mVZkU3qZ6N8e5N7ZyXelg9ljHMqzTUYEjYXUjs6X33
         KPYtIEDIXUZt880l0qvzJAULV9rIMKIVmhUTMxLS1toARs5pm1Kh5nwyphDEb1QdtEsI
         BKu1FOXq5N7plOoVOd6gmAhvOGDiGFaMr0i+uKdLoAreILjo/V4fMCAmMIJy+pwbKc/R
         MKPw==
X-Forwarded-Encrypted: i=1; AJvYcCX/HSJ2cr2CWHPY+5yB3yF1cMgf+57dtgsnaqMG4nSwNhqLgIgTXiFfz1BeD+zKg6PHYX7P6vQaExZBDeds@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/7e7QCwigA2qyPH0AaXFej8YNfNn9Ydd24EpNqCsmpefMG4i
	Bn4aDNgL2GL0qxiJF0BGno53B1Nsg8O8PQiGEjM1ROEJOn5X3N+0AzyKKCV9RhLOqk/LTXKHkl4
	g
X-Gm-Gg: ASbGnctONUn0X47hFiVsud26NjXDu97Dz7pB4ntADj4aVmalFFeKCNKHLsWFNMRkOrF
	Mvj0b3/7WhYf5oEA/bsdpw4FgqSozutZQy/kw9cbSFNEQ1zcoKJmf7BkvV3+NWaKGG7indSv3O2
	JlO8cNSjGXdpPq3IBXqg4mtua+gUvInhetBsVXkXmDgyCjbROc/OgSOC1xI9vIhrGOAXNWuxXiX
	kjzwygtc9/279ZhYdu9dQyg15zorLIYPJIQNcy5S/6Ga5e3vGjVwDQ/gSpJpCmyFKKKZtZTV1Ih
	ysMTpFbSovdl+LlGuRN+H/25DBM/BCYiXmBe
X-Google-Smtp-Source: AGHT+IE77Kj47u2HKPRmer53ECkMXKGp2Gh6X8q1PSU9k0JEXmCnzBBiH99bMrpM305Bdo9LagOPWA==
X-Received: by 2002:a05:6e02:1606:b0:3d4:244b:db20 with SMTP id e9e14a558f8ab-3d938efbd73mr8024795ab.16.1745520057792;
        Thu, 24 Apr 2025 11:40:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9314b04d4sm3578735ab.14.2025.04.24.11.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 11:40:57 -0700 (PDT)
Message-ID: <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>
Date: Thu, 24 Apr 2025 12:40:56 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
To: Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org> <aAqCXfPirHqWMlb4@x1.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aAqCXfPirHqWMlb4@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 12:26 PM, Peter Xu wrote:
> On Thu, Apr 24, 2025 at 10:03:44AM -0400, Johannes Weiner wrote:
>> On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
>>> userfaultfd may use interruptible sleeps to wait on userspace filling
>>> a page fault, which works fine if the task can be reliably put to
>>> sleeping waiting for that. However, if the task has a normal (ie
>>> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
>>> cause schedule() to be a no-op.
>>>
>>> For a task that registers a page with userfaultfd and then proceeds
>>> to do a write from it, if that task also has a signal pending then
>>> it'll essentially busy loop from do_page_fault() -> handle_userfault()
>>> until that fault has been filled. Normally it'd be expected that the
>>> task would sleep until that happens. Here's a trace from an application
>>> doing just that:
>>>
>>> handle_userfault+0x4b8/0xa00 (P)
>>> hugetlb_fault+0xe24/0x1060
>>> handle_mm_fault+0x2bc/0x318
>>> do_page_fault+0x1e8/0x6f0
>>
>> Makes sense. There is a fault_signal_pending() check before retrying:
>>
>> static inline bool fault_signal_pending(vm_fault_t fault_flags,
>>                                         struct pt_regs *regs)
>> {
>>         return unlikely((fault_flags & VM_FAULT_RETRY) &&
>>                         (fatal_signal_pending(current) ||
>>                          (user_mode(regs) && signal_pending(current))));
>> }
>>
>> Since it's an in-kernel fault, and the signal is non-fatal, it won't
>> stop looping until the fault is handled.
>>
>> This in itself seems a bit sketchy. You have to hope there is no
>> dependency between handling the signal -> handling the fault inside
>> the userspace components.
> 
> True. So far, my understanding is e.g. in an userfaultfd context the signal
> handler is responsible for not touching any possible trapped pages, or the
> sighandler needs fixing on its own.
> 
>>
>>> do_translation_fault+0x9c/0xd0
>>> do_mem_abort+0x44/0xa0
>>> el1_abort+0x3c/0x68
>>> el1h_64_sync_handler+0xd4/0x100
>>> el1h_64_sync+0x6c/0x70
>>> fault_in_readable+0x74/0x108 (P)
>>> iomap_file_buffered_write+0x14c/0x438
>>> blkdev_write_iter+0x1a8/0x340
>>> vfs_write+0x20c/0x348
>>> ksys_write+0x64/0x108
>>> __arm64_sys_write+0x1c/0x38
>>>
>>> where the task is looping with 100% CPU time in the above mentioned
>>> fault path.
>>>
>>> Since it's impossible to handle signals, or other conditions like
>>> TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
>>> fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
>>> modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
>>> signals will still be handled by the caller, and the timeout is short
>>> enough to hopefully not cause any issues. If this is the first invocation
>>> of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
>>> is used.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
>>
>> When this patch was first introduced, VM_FAULT_RETRY would work only
>> once. The second try would have FAULT_FLAG_ALLOW_RETRY cleared,
>> causing handle_userfault() to return VM_SIGBUS, which would bubble
>> through the fixup table (kernel fault), -EFAULT from
>> iomap_file_buffered_write() and unwind the kernel stack this way.
> 
> AFAIU we can't rely on the exception fixups because when reaching there it
> means the user access is going to get a -EFAULT, but here the right
> behavior is we keep waiting, aka, UNINTERRUPTIBLE wait until it's done.
> 
>>
>> So I'm thinking this is the more likely commit for Fixes: and stable:
>>
>> commit 4064b982706375025628094e51d11cf1a958a5d3
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Wed Apr 1 21:08:45 2020 -0700
>>
>>     mm: allow VM_FAULT_RETRY for multiple times
> 
> IMHO the multiple attempts are still fine, instead it's problematic if we
> wait in INTERRUPTIBLE mode even in !user mode..  so maybe it's slightly
> more suitable to use this as Fixes:
> 
> commit c270a7eedcf278304e05ebd2c96807487c97db61
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Apr 1 21:08:41 2020 -0700
> 
>     mm: introduce FAULT_FLAG_INTERRUPTIBLE
> 
> The important change there is:
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 888272621f38..c076d3295958 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -462,9 +462,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>         uwq.ctx = ctx;
>         uwq.waken = false;
>  
> -       return_to_userland =
> -               (vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
> -               (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);
> +       return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
>         blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
>                          TASK_KILLABLE;
> 
> I think we still need to avoid checking FAULT_FLAG_USER, because e.g. in
> some other use cases like GUP we'd still want the threads (KVM does GUP and
> it's a heavy user of userfaultfd) to respond to non-fatals.
> 
> However maybe we shouldn't really set INTERRUPTIBLE at all if it's non-GUP
> and if it's non-user either.
> 
> So in general, some trivial concerns here on the patch..
> 
> Firstly, waiting UNINTERRUPTIBLE (even if with a small timeout) if
> FAULT_FLAG_INTERRUPTIBLE is set is a slight ABI violation to me - after
> all, FAULT_FLAG_INTERRUPTIBLE says "please respond to non-fatal signals
> too!".

First of all, it won't respond to signals _right now_ if waiting on
userfaultd, so that ABI violation already exists. The UNINTERRUPTIBLE
doesn't really change that at all.

> Secondly, userfaultfd is indeed the only consumer of
> FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
> this patch resolves it for userfaultfd, it might get caught again later if
> something else in the kernel starts to respects the _INTERRUPTIBLE flag
> request.  For example, __folio_lock_or_retry() ignores that flag so far,
> but logically it should obey too (with a folio_wait_locked_interruptible)..
> 
> I also think it's not as elegant to have the magic HZ/10, and it's also
> destined even the loop is less frequent that's a waste of time (as if the
> user page access comes from kernel context, we must wait... until the page
> fault is resolved..).

Yeah I don't love the magic either, but the actual value of it isn't
important - it's just to prevent a CPU spin for these cases.

> Is it possible we simply unset the request from the top?  As discussed
> above, I think we still need to make sure GUP at least works for
> non-fatals, however I think it might be more reasonable we never set
> _INTERRUPTIBLE for !gup, then this problem might go away too with all above
> concerns addressed.
> 
> A not-even-compiled patch just to clarify what I meant (and it won't work
> unless it makes sense to both of you and we'll need to touch all archs when
> changing the default flags):
> 
> ===8<===
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 296d294142c8..fa721525d93a 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
>          * We set FAULT_FLAG_USER based on the register state, not
>          * based on X86_PF_USER. User space accesses that cause
>          * system page faults are still user accesses.
> +        *
> +        * When we're in user mode, allow fast response on non-fatal
> +        * signals.  Do not set this in kernel mode faults because normally
> +        * a kernel fault means the fault must be resolved anyway before
> +        * going back to userspace.
>          */
>         if (user_mode(regs))
> -               flags |= FAULT_FLAG_USER;
> +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
>  
>  #ifdef CONFIG_X86_64
>         /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9b701cfbef22..a80f3f609b37 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
>   * arch-specific page fault handlers.
>   */
>  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
> -                            FAULT_FLAG_KILLABLE | \
> -                            FAULT_FLAG_INTERRUPTIBLE)
> +                            FAULT_FLAG_KILLABLE)
> ===8<===
> 
> That also kind of matches with what we do with fault_signal_pending().
> Would it make sense?

I don't think doing a non-bounded non-interruptible sleep for a
condition that may never resolve (eg userfaultfd never fills the fault)
is a good idea. What happens if the condition never becomes true? You
can't even kill the task at that point... Generally UNINTERRUPTIBLE
sleep should only be used if it's a bounded wait.

For example, if I ran my previous write(2) reproducer here and the task
got killed or exited before the userfaultfd fills the fault, then you'd
have the task stuck in 'D' forever. Can't be killed, can't get
reclaimed.

In other words, this won't work.

-- 
Jens Axboe

