Return-Path: <linux-fsdevel+bounces-44107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD42A62838
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 08:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A471895EA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7B1DF73D;
	Sat, 15 Mar 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBYFx7UW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B75185B5F;
	Sat, 15 Mar 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742024630; cv=none; b=ZMUs4+ALzwKXq0HP33A2tOEyQRo/K9RM3nLpf16T5P6HCE0H4UQsFXdhugsdqDXWkzl7zW7utDxRUceQt1ktAd2GTkfuOmGKmGs6peZyA/vYuv9vtakDw9uHhAhb9lT42TDKvBDd1clA7q/v3c2SD/0Q4LYejlucSf1oO9yvgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742024630; c=relaxed/simple;
	bh=pfYeHVsEDWveeuBl815DiEVWXdhQWhFp9D7h/1Tzfcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhHuv+sy73mPT9FMGBKDg3nd8vqdBJJ+wYzkZ+1Vy8fh3RMLUSG2UBbQgQzgSucq6jjIosFT3aSfDOd0KJy2HCcwBhDJvVQEyBY1sYmjgMQOtmzIlo86nmW677Ge0V9r/gHrkwcpMuRHqQSv3HnalawxbrPfiDFxGz5cfhek8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBYFx7UW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22113560c57so56499785ad.2;
        Sat, 15 Mar 2025 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742024628; x=1742629428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAmL+5CR2z6jEwd9cSjJDC4ozmAh9Z7pTmFVoqfcygM=;
        b=cBYFx7UWnqQjhbq34R8lQfwcEUo9Oak6MvSVUwIwtBWikUu3iMRtpSHs0Rz0+qOwao
         h6b3hbpW5fVMLybOiQrB72iVH+w44kWdHdlm8+0yEwUFkmQLo+AloWEcZZXcZfqXnqCj
         ermO4X3MkdhFfS9ks5+gyKhSGTFCjcvA4+g+kdXUzHPWS7WjjIp8NhV09yEQN7h6uu74
         +nl5VMnkXWgGe774/BtGyciMc33WX37W38PXsHHeJdK8AjlmID5NsfiAiUp7bJaZkPIr
         X2+KI24LsPkD9e5uC2FCfP4y61Le6UhlNhv4Wc1VR5JknBVJ+Nc7q7pMl+R/33WvgFvr
         Z7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742024628; x=1742629428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAmL+5CR2z6jEwd9cSjJDC4ozmAh9Z7pTmFVoqfcygM=;
        b=cLfzQMEj65Ln14ebSMDqUn9PBz+ett5hyDcMXw+6B8UdP7BTeez+mTcV3NfCrjGbb/
         tQpZEfQJ9539mY0zYHCZ/UM2EYHXpRWVPLLuf/JEuRQuUjUfeu/sVGZRnC0X5RIt21Qz
         BuB1ZwP5rOUO9EMFS8J05LQjYdeUnCRxg/cNgZ0IKo8DupcV6c+LKNxdPKtfGCyP6JVU
         zZqyuY3LX5a39kvI8N7W2im5hWYeFaIdNgSwRHXN/1rfdb7LBwjqWy5DMxLCfR0sYBky
         ky1iylIZOy6vq11jsM8rcSMHbb7NIc+VZh1FRP7AWXS/X2VKkibvgixwb3Ly3t0I43S8
         xhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMcYsyYhTKE1iLZH+dvvb6J4e3EBEv5/RE7KmoYYt2mXcWe6zdyHFVT298TJTtd4wehpY=@vger.kernel.org, AJvYcCVV0NV7ZWvBkKYDSS2IM71lSnS4o03eLPFCbGdamalbLXkgHSwxJtNzNJJWEC0km1bS5oypvRCl7ncquXVhD3XwQw==@vger.kernel.org, AJvYcCVb3/T+14g4BnknxAQBcdxqoRaIl+n7cMnbu5owrvtDrKiubvpec7XghkoE9n2f2MZWa2genBjthMioT4eB@vger.kernel.org, AJvYcCX+N1esY5roDlEXfku7dly2R/ddsliQUX0FIUblscXgAsm9vwmr31K6IVaT4PGsnIUpOTiKVZnOUdkwFtj51w==@vger.kernel.org
X-Gm-Message-State: AOJu0YygHq1oCbXzeyuSc/On2UyfeG5ZOkkq0gk8/4GXM/QT0iSo+OlU
	bHuXfHrWiJ8opdsausJJtp4VyW16w3jKeDruPr6qY4BurEj430TQ
X-Gm-Gg: ASbGncsqGhHGe5LTcHKFUzEjAjBNKnhWzz7A2Uq6j6QTEjeKCxfUG5mJfDnXdPN8dxc
	3tGcyh6wspS7/5QfxhpVOdTNuQ9OSAw0kY9uyfFO7TDZsVn8pEMtyfXGqLSWHtNrxNjVYmPxdWP
	J7M/luhzlz2In52fzXY073ktx1yOzbvZgGBxd1/dFhhGA4tIycwg9fRlqOFJDRcHEDC7OW5sDY2
	NrtxMzX+Nxl/Y6pnc0i2RWztLSLK3g9+SxOQc2KJ5NJBP58K+0L4UUxv5Ir7MyGxQVDm4ZecgD0
	M4imqDYPWQJN2nY5wc6cCRgdzbyW+FRPDM1AUl5Xoxtj
X-Google-Smtp-Source: AGHT+IFNXmsiLHb1JHv7bDZUdBco+pV3oLLy0KNHvrNch7t31ViRO39JDS2byJdpYxvminRgrzVx7w==
X-Received: by 2002:a05:6a00:2382:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-7372233ae33mr6017160b3a.9.1742024627617;
        Sat, 15 Mar 2025 00:43:47 -0700 (PDT)
Received: from [192.168.0.164] ([50.35.39.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df97sm3965668b3a.114.2025.03.15.00.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 00:43:47 -0700 (PDT)
Message-ID: <a73ea646-0a24-474a-9e14-d59ea5eaa662@gmail.com>
Date: Sat, 15 Mar 2025 00:43:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Dynamically allocate memory to store task's full
 name
To: Kees Cook <kees@kernel.org>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
References: <20250314052715.610377-1-bhupesh@igalia.com>
 <202503141420.37D605B2@keescook>
Content-Language: en-US
From: Andres Rodriguez <andresx7@gmail.com>
In-Reply-To: <202503141420.37D605B2@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/25 14:25, Kees Cook wrote:
> On Fri, Mar 14, 2025 at 10:57:13AM +0530, Bhupesh wrote:
>> While working with user-space debugging tools which work especially
>> on linux gaming platforms, I found that the task name is truncated due
>> to the limitation of TASK_COMM_LEN.
>>
>> For example, currently running 'ps', the task->comm value of a long
>> task name is truncated due to the limitation of TASK_COMM_LEN.
>>      create_very_lon
>>
>> This leads to the names passed from userland via pthread_setname_np()
>> being truncated.
> 
> So there have been long discussions about "comm", and it mainly boils
> down to "leave it alone". For the /proc-scraping tools like "ps" and
> "top", they check both "comm" and "cmdline", depending on mode. The more
> useful (and already untruncated) stuff is in "cmdline", so I suspect it
> may make more sense to have pthread_setname_np() interact with that
> instead. Also TASK_COMM_LEN is basically considered userspace ABI at
> this point and we can't sanely change its length without breaking the
> world.
> 

Completely agree that comm is best left untouched. TASK_COMM_LEN is 
embedded into the kernel and the pthread ABI changes here should be avoided.

> Best to use /proc/$pid/task/$tid/cmdline IMO...

Your recommendation works great for programs like ps and top, which are
the examples proposed in the cover letter. However, I think the opening 
email didn't point out use cases where the name is modified at runtime. 
In those cases cmdline would be an unsuitable solution as it should 
remain immutable across the process lifetime. An example of this use 
case would be to set a thread's name for debugging purposes and then 
trying to query it via gdb or perf.

I wrote a quick and dirty example to illustrate what I mean:
https://github.com/lostgoat/tasknames

I think an alternative approach could be to have a separate entry in 
procfs to store a tasks debug name (and leave comm completely 
untouched), e.g. /proc/$pid/task/$tid/debug_name. This would allow 
userspace apps to be updated with the following logic:

get_task_debug_name() {
     if ( !is_empty( debug_name ) )
         return debug_name;
     return comm;
}

"Legacy" userspace apps would remain ABI compatible as they would just 
fall back to comm. And apps that want to opt in to the new behaviour can 
be updated one at a time. Which would be work intensive, but even just 
updating gdb and perf would be super helpful.

-Andres

> 
> -Kees
> 
>> will be shown in 'ps'. For example:
>>      create_very_long_name_user_space_script.sh
>>
>> Bhupesh (2):
>>    exec: Dynamically allocate memory to store task's full name
>>    fs/proc: Pass 'task->full_name' via 'proc_task_name()'
>>
>>   fs/exec.c             | 21 ++++++++++++++++++---
>>   fs/proc/array.c       |  2 +-
>>   include/linux/sched.h |  9 +++++++++
>>   3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.38.1
>>
> 


