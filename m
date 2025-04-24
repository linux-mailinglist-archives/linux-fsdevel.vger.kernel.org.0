Return-Path: <linux-fsdevel+bounces-47262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949AA9B18E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E489252FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6519F11E;
	Thu, 24 Apr 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W7BeCbY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5127456
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506484; cv=none; b=ujYLAE4VgIMclhghoh+0tUkP0Dn75gdB962mc35FAiwW+3Gab54Ka4M7cbE7ALk6FD9b0Nq4m4c/HrojVGrR6Upb7ot3gjUkAquZ39g8O588Ahxamr6J9NFxk85hBYkqaNqQN6rig+x40mXEZpl/oeDJ5Wi/xqLBZPcoEKDGFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506484; c=relaxed/simple;
	bh=RRBSX0BimGnYGO22iZoYihaeeEackA3lfVwNIFPCGl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr1GWx1NVWa2TLNtZW5bE3xCfutVj2LYFn5pwuF2AwnFl0W9bpM5eOSFa34xyKIj0UAWYPIkyRg+lNZaLCUVcaxTayq01MRq3frQeOYEboGA6BB2sfkmnBss1LdDQOZG6vT/Qe8oN0P2XG9B5nQAPKpPK00X6JIGCkF5Tvzm3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W7BeCbY3; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85ea482e3adso66740039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745506481; x=1746111281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtwm22V0E9YgKk14Iu2N3ZRqCyrswQ3Mf9l5CjPwuFo=;
        b=W7BeCbY3K2hrFmMZQM3KpK5VZsAO1AS4uOI0H/MXyUKysxie2Pzul8uBHCYZzuCDxG
         zfb6Cl2a8OXizffnPrmdquYTpwgDCgVrlm0SdffOhX31YO3PBEG3Suww1NOvU1IIf2CL
         isvniW6bKCm6IoQgynllvQpCDuUZQvLmwfH1+iXNsiVV6lJM2pfIrG0Lqm9BS3yqZ1jd
         1BJn//S8AjQSvjUF/o596cPgq0xQtLW5sfsfMv0HkQJfDFyI9wAYK6pPuf5raVkYq/dA
         hqaQLMoqWwGHeYinmSwk9q96cHn+f8iWS1rWAI01oGMm+ojgCkNLMrebM6hsdDKi/rAF
         ji5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745506481; x=1746111281;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtwm22V0E9YgKk14Iu2N3ZRqCyrswQ3Mf9l5CjPwuFo=;
        b=PMHpKKqaezNtuOsRzCjtvZ4QNx1I2NAmYMscbzOKbh+LOXs17UfJRnF6q0SV+MYrjK
         jhmsNeK10xiyuJMu8Hi1yhvybU6GWs5/YdX7KIpVpME68gX7RT1f9CKptCAbwCqOXvBn
         6PQKB4DAi7LUmB8WoCwQ4BD0eZJbJLnTjJm3TTpbSYs+fb8mhpW9TcEmj2fjsEwyfhZk
         yCOu3FgTNeiYO1jUJenOcQG4Ce+98e64yV1cccLymXEIhUrxAY0CUI2tWuKp0Eyj7lQR
         5qCWLC184DE/36aBPXWaKCIUSQbxrEZv4wWrNdblVNbAvktH+XqNRpNLde3RBu3f4uj5
         YX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9YLEmocVtGXwkq0qq52I6YmoBoHVf4cIk28K4uq/sPqKRiozaD0uD00JfhElZaOoMgmUG36yHajYBsw9O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pthtaTk8bftV2YofhjwTbR3J45WATxIT4JFuez6PKs9rQGsm
	MMfX1guwqRyUilYQqzyZ2GKUxhWCX/LY+S40bMjTMjKKedmum59anyGjHhsPx4w=
X-Gm-Gg: ASbGncsyovsoBSmHkuwvJxzTQeYTUJCeEYs2dp/9gy0N5PfUVLsW/qw3EDCSLFkhPyF
	agqh7j+0VZp18cYdMcPttMQgTLTJQ05/zGdcqY+zVpLqdOOZcRc5vBMiXI4bNeaJ290VOOug0Ha
	4z0bCPaDFm2Cav7LY0aTSgkKt0reMWeZEZv4ipKNxW4izJgy5BLQ/aQeDFpfQkUDjw3c9VJx+Qu
	JqcYJx26Aibj92kMwvHccR1gJrgJIjYUsEEGW/z74Mhe5Z30JmsPFUtOMSc9RIRZnGvqAqFmYBz
	h5dGGuRHWY8ieZcxIO9fXC8a32lSYNuoM2ev
X-Google-Smtp-Source: AGHT+IFlY6RNDCjYHuqZzxsvpc7at9t7XjV3+z6ZydlrNnyfCHFkRzw3zaVy0fy7L9HyCTpuDTpaxw==
X-Received: by 2002:a05:6e02:3a06:b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d93135f15emr30993625ab.0.1745506481269;
        Thu, 24 Apr 2025 07:54:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824ba0ec4sm305526173.113.2025.04.24.07.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:54:40 -0700 (PDT)
Message-ID: <c68882dd-067b-4d16-8fb8-28bfdd51e627@kernel.dk>
Date: Thu, 24 Apr 2025 08:54:40 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250424140344.GA840@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 8:03 AM, Johannes Weiner wrote:
> On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
>> userfaultfd may use interruptible sleeps to wait on userspace filling
>> a page fault, which works fine if the task can be reliably put to
>> sleeping waiting for that. However, if the task has a normal (ie
>> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
>> cause schedule() to be a no-op.
>>
>> For a task that registers a page with userfaultfd and then proceeds
>> to do a write from it, if that task also has a signal pending then
>> it'll essentially busy loop from do_page_fault() -> handle_userfault()
>> until that fault has been filled. Normally it'd be expected that the
>> task would sleep until that happens. Here's a trace from an application
>> doing just that:
>>
>> handle_userfault+0x4b8/0xa00 (P)
>> hugetlb_fault+0xe24/0x1060
>> handle_mm_fault+0x2bc/0x318
>> do_page_fault+0x1e8/0x6f0
> 
> Makes sense. There is a fault_signal_pending() check before retrying:
> 
> static inline bool fault_signal_pending(vm_fault_t fault_flags,
>                                         struct pt_regs *regs)
> {
>         return unlikely((fault_flags & VM_FAULT_RETRY) &&
>                         (fatal_signal_pending(current) ||
>                          (user_mode(regs) && signal_pending(current))));
> }
> 
> Since it's an in-kernel fault, and the signal is non-fatal, it won't
> stop looping until the fault is handled.
> 
> This in itself seems a bit sketchy. You have to hope there is no
> dependency between handling the signal -> handling the fault inside
> the userspace components.

Indeed... But that's generic userfaultfd sketchiness, not really related
to this patch.

> 
>> do_translation_fault+0x9c/0xd0
>> do_mem_abort+0x44/0xa0
>> el1_abort+0x3c/0x68
>> el1h_64_sync_handler+0xd4/0x100
>> el1h_64_sync+0x6c/0x70
>> fault_in_readable+0x74/0x108 (P)
>> iomap_file_buffered_write+0x14c/0x438
>> blkdev_write_iter+0x1a8/0x340
>> vfs_write+0x20c/0x348
>> ksys_write+0x64/0x108
>> __arm64_sys_write+0x1c/0x38
>>
>> where the task is looping with 100% CPU time in the above mentioned
>> fault path.
>>
>> Since it's impossible to handle signals, or other conditions like
>> TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
>> fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
>> modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
>> signals will still be handled by the caller, and the timeout is short
>> enough to hopefully not cause any issues. If this is the first invocation
>> of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
>> is used.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> 
> When this patch was first introduced, VM_FAULT_RETRY would work only
> once. The second try would have FAULT_FLAG_ALLOW_RETRY cleared,
> causing handle_userfault() to return VM_SIGBUS, which would bubble
> through the fixup table (kernel fault), -EFAULT from
> iomap_file_buffered_write() and unwind the kernel stack this way.
> 
> So I'm thinking this is the more likely commit for Fixes: and stable:
> 
> commit 4064b982706375025628094e51d11cf1a958a5d3
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Apr 1 21:08:45 2020 -0700
> 
>     mm: allow VM_FAULT_RETRY for multiple times

Thanks for checking that - yep that sounds fine to me, we can adjust the
fixes tag appropriately.

>> Reported-by: Zhiwei Jiang <qq282012236@gmail.com>
>> Link: https://lore.kernel.org/io-uring/20250422162913.1242057-1-qq282012236@gmail.com/
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

-- 
Jens Axboe

