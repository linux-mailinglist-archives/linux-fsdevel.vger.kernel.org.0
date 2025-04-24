Return-Path: <linux-fsdevel+bounces-47291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7340A9B835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AE71BA0747
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A5291152;
	Thu, 24 Apr 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e9xTwFzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB32918C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522452; cv=none; b=cuPu0iB3LITN0e2o0BXEMjj0a9+8Ch9/JW9Hp8cuWJrNcJJcJQ+b9ljNb02UYyH7TJZwPB507FR/NZ0LwjSJaVbQ8nOhWC/JTQdZp0ORFRW0Lp61bwTGQBinFDOqc4TAjzd0eikqLvrlPG06x2ArsiJd+6VflM6XjUGvrUI0xoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522452; c=relaxed/simple;
	bh=tatoatZPbF+2WIMMhWu4nuxKfwriixngex/8IRbY6iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2K+0oGSghMDUbkEP7g0AXWgOBjhPj5VTur0dlap6MdncnPAydt/GS33O5drWK66a3HBBvC6KAjPkCjgEWnJ4+X9enBSi55NIOmNoQLtPhdB0IS9IYjjyZRAoCvQfEftAA9iQLHjxXlrqLN+109C/kOUib5JaiyDJrEExUkOL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e9xTwFzt; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso11584215ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745522448; x=1746127248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rD8PIgzSnv6Hr57RD+kfCsXuxQQBab077mkrI7EUcGc=;
        b=e9xTwFztBS96kCRLOpVE+FmjU/AhHHjzRusvhfhEvhqxOziEQ8abjpmEnAAXbQi0ob
         x4/QRkRdzc4nx0mSIpLD3d4pBOpLCRxplVq9WUOOAY/D/x52R4bx7ca0tllyUtttUQcR
         645DDsU20UWTUBt0SCjV/VsnZuevD/mDcHBxZd+/14qKKhNELiJ7dB6WpA/BdCVkEysi
         m9BUlSNjbywEOwmL2dIBeb/MRzeT5vzYMlR13pFRFi7RWzq4Txxx9xsB0S5u3YiPY1yB
         eRZIiE0tANs4Yfcu9nopPuv1TxW00wGcXRkdweOKB/mc4+zrba8OQ+27LTuRqMS4fXi6
         TS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522448; x=1746127248;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD8PIgzSnv6Hr57RD+kfCsXuxQQBab077mkrI7EUcGc=;
        b=eNNF23ppT4YswHYUhdavs2oiUDsNjv1PN5ZRw6ZnWSCgwkiHjxt/N9Z1jEecgcrdOt
         Q3TrteeYx8jcEoi/JyyS8PVRrvtIVR6cvvmpqVh20EpTDELtMuCfzUOgPkcPeN0kHreu
         eYgoVmYBu5Ppn2RvoXQiNIRIKkhfk0Qio389XPAHccvkLQKIPU/YkLj0b5DdEf/5VKFS
         FS1Y2MLBVdVDah6vIA32j4p7pKu9FokvQ+VQgffL6uvrEauSNcEvbY/UUbXBSSig4H5y
         c+Id514RQzUUPSjO9sMB0hXQAGoIP4fesmCIlrDq4xNMLVtGvDMJ0ppkjMQFmEKaMRnK
         ez2A==
X-Forwarded-Encrypted: i=1; AJvYcCVvVPhGD33q116hVaPKJI/mCQsOu8vi51DY7HJjf7WSYUr9Lspxfg6mtMEZ9I+1ZcDZMRgPJyg63uELdJ6h@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr41jwXMPZvnb+1maxu+MvO2+4wvolQbikhQIaCN15OdCXE3bd
	nFEpVfU4wJuT1qglJ5i+cvfOkDmiAxKsnAqtw8yQOCO9EA2RsdS+Hyz2MVd4WM94QU6AKH2/vlY
	F
X-Gm-Gg: ASbGncvdCdr0FusfA5lctv2ks7r3/bU7NDHJSFFeHQZKirNKUuZw9y04RrdOsOkZR1x
	E+QzEjUhgxAEqAVt3w2YqgINuKux1i2faE2dIg4UJD59tK9qcboiOxZGLojpoBHHFWxiBMg/hmC
	K5aNlr8IsnmPGGhi+MOd1gwKd4DDnfo+kfHGMTrthogXw48pDE9nqTY17wq6Rqk5CCVsgLvFsmD
	dxohC5xEd7ZO952OFvb9EFuR96VElqsCGEBqrBgPgVwaoaIwrrTriteJhxPUkN7gQCyl5tLHLr1
	2utidYIv8c+FDntcz6qr00u2wQWqrT1jpbiC
X-Google-Smtp-Source: AGHT+IHVl4amRel6YSSwPx/KPht2X/bb6Vi1Bxk4v4wCQkjiFLbqAu4usChLz8EaH9vw3O8F+FnQFQ==
X-Received: by 2002:a05:6e02:1d9c:b0:3d8:1d34:4edf with SMTP id e9e14a558f8ab-3d93041e568mr45684925ab.15.1745522447914;
        Thu, 24 Apr 2025 12:20:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824bca172sm397570173.143.2025.04.24.12.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 12:20:47 -0700 (PDT)
Message-ID: <26a0a28c-197f-4d0b-ad58-c003d72b1700@kernel.dk>
Date: Thu, 24 Apr 2025 13:20:46 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
To: Peter Xu <peterx@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org> <aAqCXfPirHqWMlb4@x1.local>
 <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk> <aAqNYsMvU-7I-nu1@x1.local>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aAqNYsMvU-7I-nu1@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 1:13 PM, Peter Xu wrote:

(skipping to this bit as I think we're mostly in agreement on the above)

>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index 296d294142c8..fa721525d93a 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>          * We set FAULT_FLAG_USER based on the register state, not
>>>          * based on X86_PF_USER. User space accesses that cause
>>>          * system page faults are still user accesses.
>>> +        *
>>> +        * When we're in user mode, allow fast response on non-fatal
>>> +        * signals.  Do not set this in kernel mode faults because normally
>>> +        * a kernel fault means the fault must be resolved anyway before
>>> +        * going back to userspace.
>>>          */
>>>         if (user_mode(regs))
>>> -               flags |= FAULT_FLAG_USER;
>>> +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
>>>  
>>>  #ifdef CONFIG_X86_64
>>>         /*
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 9b701cfbef22..a80f3f609b37 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
>>>   * arch-specific page fault handlers.
>>>   */
>>>  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
>>> -                            FAULT_FLAG_KILLABLE | \
>>> -                            FAULT_FLAG_INTERRUPTIBLE)
>>> +                            FAULT_FLAG_KILLABLE)
>>> ===8<===
>>>
>>> That also kind of matches with what we do with fault_signal_pending().
>>> Would it make sense?
>>
>> I don't think doing a non-bounded non-interruptible sleep for a
>> condition that may never resolve (eg userfaultfd never fills the fault)
>> is a good idea. What happens if the condition never becomes true? You
> 
> If page fault is never going to be resolved, normally we sigkill the
> program as it can't move any further with no way to resolve the page fault.
> 
> But yeah that's based on the fact sigkill will work first..

Yep

>> can't even kill the task at that point... Generally UNINTERRUPTIBLE
>> sleep should only be used if it's a bounded wait.
>>
>> For example, if I ran my previous write(2) reproducer here and the task
>> got killed or exited before the userfaultfd fills the fault, then you'd
>> have the task stuck in 'D' forever. Can't be killed, can't get
>> reclaimed.
>>
>> In other words, this won't work.
> 
> .. Would you help explain why it didn't work even for SIGKILL?  Above will
> still set FAULT_FLAG_KILLABLE, hence I thought SIGKILL would always work
> regardless.
> 
> For such kernel user page access, IIUC it should respond to SIGKILL in
> handle_userfault(), then fault_signal_pending() would trap the SIGKILL this
> time -> going kernel fixups. Then the upper stack should get -EFAULT in the
> exception fixup path.
> 
> I could have missed something..

It won't work because sending the signal will not wake the process in
question as it's sleeping uninterruptibly, forever. My looping approach
still works for fatal signals as we abort the loop every now and then,
hence we know it won't be stuck forever. But if you don't have a timeout
on that uninterruptible sleep, it's not waking from being sent a signal
alone.

Example:

axboe@m2max-kvm ~> sudo ./tufd 
got buf 0xffff89800000
child will write
Page fault
flags = 0; address = ffff89800000
wait on child
fish: Job 1, 'sudo ./tufd' terminated by signal SIGKILL (Forced quit)

meanwhile in ps:

root         837     837  0.0    2  0.0  14628  1220 ?        Dl   12:37   0:00 ./tufd
root         837     838  0.0    2  0.0  14628  1220 ?        Sl   12:37   0:00 ./tufd

-- 
Jens Axboe

