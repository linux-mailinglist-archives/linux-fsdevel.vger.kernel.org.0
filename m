Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC859391E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 19:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhEZR4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhEZR4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 13:56:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8DC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 10:54:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k4so1691112ili.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ACtspkCT/fGXAK2XAfeoVeEU1qeByhAQDFj8vp7z1Kw=;
        b=d1FGpRxRysaEV+riouzevu+1R3rw1n0T3AJ+3iiM+0TJAZT5/eoQscxY6vIbmrGOC4
         yLD7Z7pbhiFgNKcwlv3Ecl27TrPcZndmuXiXU89xc17fy8oHwN6CykHAbCz8WTV2ouzk
         +MVA6GZKqWdz3RyZeZe0dJ/KzYkUvzjLmztlXZNJeAjZSpm8XppaK1uW8H25bmP+D6Vy
         0uFso1DZPuM28/bJ7TX1jt5XotMoU8OiruIojax6KqUCNrCLICfRxsvK4b+vCe72ba+v
         KN/1BSKivxhQAFapgQmpO5oBF5AzkEoUO3dggcgvWs8MiXdMZdSwLjgPUS70taZoaVDi
         s5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ACtspkCT/fGXAK2XAfeoVeEU1qeByhAQDFj8vp7z1Kw=;
        b=d9pRvGbkoop+pzaxz2zhpLrhuP3PYwAvdd7sQrTQ10xqii4ykJAohcAlMkHwol0SgQ
         KdNiX9eYcrnC7DgcJeYNnoTRACkdNPmQV6GG9fHIrIr/MLTDr7AI0VMDtBjQzBBpYQky
         SG+4B/PK3b4jpXAtH7xthUCXVi45ZL7zD9Px0cuMppWyx4bxCUj7s0sox9ZFzkf8jO4b
         dwkJ8JPb51TPeSDbJevHKDfp4aW8X8gu2ktmoHw+tUDzzkz/FWYv3oSmAa/iLceIYbsR
         7+/pzZoM2iIVX6y8hZexBpX3BAuuxvHdmvAwmCP7XqtUOBf4PCZCcxk/EfQzhX9Dnhst
         Lh+g==
X-Gm-Message-State: AOAM533VWd24jUmotkEBvY3hnpSk4px4YCOSSbzCxfs/dBKRAMrNeZ1u
        VNxYwdgFqVn8l6DbEezka5yn2w==
X-Google-Smtp-Source: ABdhPJybzwpznpNhH9BPdawI9/2rQI1ZannI33T0sQ0em8q+W0UoAy8iDp9ZoISdJbaKp0tEPuizQg==
X-Received: by 2002:a05:6e02:54d:: with SMTP id i13mr27905858ils.26.1622051681431;
        Wed, 26 May 2021 10:54:41 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b10sm12182ioz.35.2021.05.26.10.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 10:54:41 -0700 (PDT)
Subject: Re: [RFC PATCH 2/9] audit,io_uring,io-wq: add some basic audit
 support to io_uring
From:   Jens Axboe <axboe@kernel.dk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163379461.8379.9691291608621179559.stgit@sifl>
 <f07bd213-6656-7516-9099-c6ecf4174519@gmail.com>
 <CAHC9VhRjzWxweB8d8fypUx11CX6tRBnxSWbXH+5qM1virE509A@mail.gmail.com>
 <162219f9-7844-0c78-388f-9b5c06557d06@gmail.com>
 <CAHC9VhSJuddB+6GPS1+mgcuKahrR3UZA=1iO8obFzfRE7_E0gA@mail.gmail.com>
 <8943629d-3c69-3529-ca79-d7f8e2c60c16@kernel.dk>
 <CAHC9VhTYBsh4JHhqV0Uyz=H5cEYQw48xOo=CUdXV0gDvyifPOQ@mail.gmail.com>
 <9e69e4b6-2b87-a688-d604-c7f70be894f5@kernel.dk>
 <3bef7c8a-ee70-d91d-74db-367ad0137d00@kernel.dk>
Message-ID: <fa7bf4a5-5975-3e8c-99b4-c8d54c57da10@kernel.dk>
Date:   Wed, 26 May 2021 11:54:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3bef7c8a-ee70-d91d-74db-367ad0137d00@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/21 11:31 AM, Jens Axboe wrote:
> On 5/26/21 11:15 AM, Jens Axboe wrote:
>> On 5/25/21 8:04 PM, Paul Moore wrote:
>>> On Tue, May 25, 2021 at 9:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 5/24/21 1:59 PM, Paul Moore wrote:
>>>>> That said, audit is not for everyone, and we have build time and
>>>>> runtime options to help make life easier.  Beyond simply disabling
>>>>> audit at compile time a number of Linux distributions effectively
>>>>> shortcut audit at runtime by adding a "never" rule to the audit
>>>>> filter, for example:
>>>>>
>>>>>  % auditctl -a task,never
>>>>
>>>> As has been brought up, the issue we're facing is that distros have
>>>> CONFIG_AUDIT=y and hence the above is the best real world case outside
>>>> of people doing custom kernels. My question would then be how much
>>>> overhead the above will add, considering it's an entry/exit call per op.
>>>> If auditctl is turned off, what is the expectation in turns of overhead?
>>>
>>> I commented on that case in my last email to Pavel, but I'll try to go
>>> over it again in a little more detail.
>>>
>>> As we discussed earlier in this thread, we can skip the req->opcode
>>> check before both the _entry and _exit calls, so we are left with just
>>> the bare audit calls in the io_uring code.  As the _entry and _exit
>>> functions are small, I've copied them and their supporting functions
>>> below and I'll try to explain what would happen in CONFIG_AUDIT=y,
>>> "task,never" case.
>>>
>>> +  static inline struct audit_context *audit_context(void)
>>> +  {
>>> +    return current->audit_context;
>>> +  }
>>>
>>> +  static inline bool audit_dummy_context(void)
>>> +  {
>>> +    void *p = audit_context();
>>> +    return !p || *(int *)p;
>>> +  }
>>>
>>> +  static inline void audit_uring_entry(u8 op)
>>> +  {
>>> +    if (unlikely(audit_enabled && audit_context()))
>>> +      __audit_uring_entry(op);
>>> +  }
>>>
>>> We have one if statement where the conditional checks on two
>>> individual conditions.  The first (audit_enabled) is simply a check to
>>> see if anyone has "turned on" auditing at runtime; historically this
>>> worked rather well, and still does in a number of places, but ever
>>> since systemd has taken to forcing audit on regardless of the admin's
>>> audit configuration it is less useful.  The second (audit_context())
>>> is a check to see if an audit_context has been allocated for the
>>> current task.  In the case of "task,never" current->audit_context will
>>> be NULL (see audit_alloc()) and the __audit_uring_entry() slowpath
>>> will never be called.
>>>
>>> Worst case here is checking the value of audit_enabled and
>>> current->audit_context.  Depending on which you think is more likely
>>> we can change the order of the check so that the
>>> current->audit_context check is first if you feel that is more likely
>>> to be NULL than audit_enabled is to be false (it may be that way now).
>>>
>>> +  static inline void audit_uring_exit(int success, long code)
>>> +  {
>>> +    if (unlikely(!audit_dummy_context()))
>>> +      __audit_uring_exit(success, code);
>>> +  }
>>>
>>> The exit call is very similar to the entry call, but in the
>>> "task,never" case it is very simple as the first check to be performed
>>> is the current->audit_context check which we know to be NULL.  The
>>> __audit_uring_exit() slowpath will never be called.
>>
>> I actually ran some numbers this morning. The test base is 5.13+, and
>> CONFIG_AUDIT=y and CONFIG_AUDITSYSCALL=y is set for both the baseline
>> test and the test with this series applied. I used your git branch as of
>> this morning.
>>
>> The test case is my usual peak perf test, which is random reads at
>> QD=128 and using polled IO. It's a single core test, not threaded. I ran
>> two different tests - one was having a thread just do the IO, the other
>> is using SQPOLL to do the IO for us. The device is capable than more
>> IOPS than a single core can deliver, so we're CPU limited in this test.
>> Hence it's a good test case as it does actual work, and shows software
>> overhead quite nicely. Runs are very stable (less than 0.5% difference
>> between runs on the same base), yet I did average 4 runs.
>>
>> Kernel		SQPOLL		IOPS		Perf diff
>> ---------------------------------------------------------
>> 5.13		0		3029872		0.0%
>> 5.13		1		3031056		0.0%
>> 5.13 + audit	0		2894160		-4.5%
>> 5.13 + audit	1		2886168		-4.8%
>>
>> That's an immediate drop in perf of almost 5%. Looking at a quick
>> profile of it (nothing fancy, just checking for 'audit' in the profile)
>> shows this:
>>
>> +    2.17%  io_uring  [kernel.vmlinux]  [k] __audit_uring_entry
>> +    0.71%  io_uring  [kernel.vmlinux]  [k] __audit_uring_exit
>>      0.07%  io_uring  [kernel.vmlinux]  [k] __audit_syscall_entry
>>      0.02%  io_uring  [kernel.vmlinux]  [k] __audit_syscall_exit
>>
>> Note that this is with _no_ rules!
> 
> io_uring also supports a NOP command, which basically just measures
> reqs/sec through the interface. Ran that as well:
> 
> Kernel		SQPOLL		IOPS		Perf diff
> ---------------------------------------------------------
> 5.13		0		31.05M		0.0%
> 5.13 + audit	0		25.31M		-18.5%
> 
> and profile for the latter includes:
> 
> +    5.19%  io_uring  [kernel.vmlinux]  [k] __audit_uring_entry
> +    4.31%  io_uring  [kernel.vmlinux]  [k] __audit_uring_exit
>      0.26%  io_uring  [kernel.vmlinux]  [k] __audit_syscall_entry
>      0.08%  io_uring  [kernel.vmlinux]  [k] __audit_syscall_exit

As Pavel correctly pointed it, looks like auditing is enabled. And
indeed it was! Hence the above numbers is without having turned off
auditing. Running the NOPs after having turned off audit, we get 30.6M
IOPS, which is down about 1.5% from the baseline. The results for the
polled random read test above did _not_ change from this, they are still
down the same amount.

Note, and I should have included this in the first email, this is not
any kind of argument for or against audit logging. It's purely meant to
be a set of numbers that show how the current series impacts
performance.

-- 
Jens Axboe

