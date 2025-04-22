Return-Path: <linux-fsdevel+bounces-46996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDCA973A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE43400F69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A91B3950;
	Tue, 22 Apr 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a0HK+wnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86E1AF4C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343227; cv=none; b=encDsQmuV3wgvmLDdyY1jumXTC6cAH7TOumSrThCH8LRzTu63b4C+vCbgT2j3js7OwoapYjP6Qq08O6vyj1G+d6Hrklf9yrttSwUPDYGyfyjFQWiuLYkHUKONreNoRZ+5q/WZxExIwDYhzsQ2hPnvIMbXB/qnnCmaFBq9TRGyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343227; c=relaxed/simple;
	bh=dSAcZbTWg2mRj31XtfxzRba5O5nw0iZOo2bmf99Ch34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOiQIYBo70b4u69taDpOHTON9GI2Lna3mUgnQJtp0kZeX0wQsOzPhH3O57nRmg1ImYrX70f8kqI6fN/NWa/gYjtoXSRQH5NAahaS1LkHKFI/zbxVUyGwIHv5Lg6ewdhF9AqzBq0StXBfiqnLl3XnzKVNorNGqvKL5OlWtc+azpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a0HK+wnK; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso80820639f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745343223; x=1745948023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ScI1SXFOzSb57R/DfhDhjRTVd9dkpAdipPrsoDQFnA=;
        b=a0HK+wnKDsWgUSGS5EgSMmrqpWhtllbXKV/XcpXEnajR68ndtFhDYP/whp/4Fz3cz+
         ZB0mqhA5pMWjDo6L3wzcdIkIGq92zsIx4HpSa4BRGJoN/z9BiMfWc+LgmxQfoWhCy4Al
         ffsP2l3J1YJNSScXt5C3WdP/z7Az2GYaJd3fzbx5ubxjcalj6KSUmluvpokXzNZKEUTN
         lLDLI78GXrvZ+1pzLuhlWe5VQJyWjbAhuYwkz5TEEzlcCCkAWGYgplAom0C0Uk1K7CxG
         DkVPYNk7PDVA/OgMUji+ljSPMBRsAbnBbcZJJXByfGMk/xujsUZbSE9SRqLw/cuhrhEj
         mxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343223; x=1745948023;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ScI1SXFOzSb57R/DfhDhjRTVd9dkpAdipPrsoDQFnA=;
        b=iGLg4x+QvnLmGKZIyECXkPH7nE2bAyOHkUnGFvervXlTcQok/2A9i54f8tTYS4DA4o
         58vhdQmM97IwsmkCzSPXzW+9SUqZipQhJp2Q2Jev+gkewatBvFc2a/qWC6Cj7S0MDFHd
         yETfEQp7IFBsvDiatUiL5XkJm+SXRIq492JOAnsd5gHFNjRKIoVytqNu28/A9ZQkdIJR
         DwLb4sTqhKpLejTt5OeT8FsKSERRJVScqpFEfToZcSXr/6iL2FUklm0S/T/U6UWaiSuI
         K+mUxvWeQBtwBN90y5GK1oqIs7/5gKyFjFDBMSUefhevM6+E//aVsmEONZkFL3mdnHt8
         GcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWipfp/N+geBtuAmLwE3I7KKLBUfYHvAani4xmdNiA69b8GosSzRbuW11sHhipGfpe2Yly06jBDhWn0Mfyg@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkw0zAr/EY8ol783mS+PNU0bblxcOr5GH6lBgNXmCINj2UESa
	a96Lm8Zjuj4CLjkeezRpPE7cDFgB41ohZgqAKrOLociMk+YbYU2+LGtEXDnQb80=
X-Gm-Gg: ASbGnctgSADtSh9zoDm8Qd/pTKBwIiOslgQdbaAI1qxtPCnzQYRUji4YGjw79SQAqf5
	yCrW3Msq4hXAbdQb5CKReobhcM4rqXxW9b9YGxXETTjhx3SQ1MXzocUR6NauTCJvoY9K+iy9B4f
	oQfxueiIR+4m8dHK11canK+mrLu0xTSlFc5Cw6JqjnmcE3N5iEpOIGfhbA/p3ZOBtnBzg/Cf4Qi
	hd224Gk0CneSALnwSuJIHGaXhKGbJHNuQ3ei4AyVG1QMjocauY/hZeieR+0j5oGS/Qsy5CtepMZ
	JC16upyELIUrx0kh8XEdwSmIBJ9C1ec9LI0i3A==
X-Google-Smtp-Source: AGHT+IG8uGVTpBjrvsiqLLauHBgN8q79Pyq/8FjC5UurY/AC+NdKVjMzlDN4p2eRnVLt9F3CH6lp+g==
X-Received: by 2002:a05:6602:3789:b0:85b:3885:159e with SMTP id ca18e2360f4ac-861dbdc71e1mr1900443339f.3.1745343223260;
        Tue, 22 Apr 2025 10:33:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a380664dsm2413104173.47.2025.04.22.10.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 10:33:42 -0700 (PDT)
Message-ID: <b61ac651-fafe-449a-82ed-7239123844e1@kernel.dk>
Date: Tue, 22 Apr 2025 11:33:41 -0600
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
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CANHzP_uW4+-M1yTg-GPdPzYWAmvqP5vh6+s1uBhrMZ3eBusLug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 11:04 AM, ??? wrote:
> On Wed, Apr 23, 2025 at 12:32?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/22/25 10:29 AM, Zhiwei Jiang wrote:
>>> diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
>>> index d4fb2940e435..8567a9c819db 100644
>>> --- a/io_uring/io-wq.h
>>> +++ b/io_uring/io-wq.h
>>> @@ -70,8 +70,10 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
>>>                                       void *data, bool cancel_all);
>>>
>>>  #if defined(CONFIG_IO_WQ)
>>> -extern void io_wq_worker_sleeping(struct task_struct *);
>>> -extern void io_wq_worker_running(struct task_struct *);
>>> +extern void io_wq_worker_sleeping(struct task_struct *tsk);
>>> +extern void io_wq_worker_running(struct task_struct *tsk);
>>> +extern void set_userfault_flag_for_ioworker(void);
>>> +extern void clear_userfault_flag_for_ioworker(void);
>>>  #else
>>>  static inline void io_wq_worker_sleeping(struct task_struct *tsk)
>>>  {
>>> @@ -79,6 +81,12 @@ static inline void io_wq_worker_sleeping(struct task_struct *tsk)
>>>  static inline void io_wq_worker_running(struct task_struct *tsk)
>>>  {
>>>  }
>>> +static inline void set_userfault_flag_for_ioworker(void)
>>> +{
>>> +}
>>> +static inline void clear_userfault_flag_for_ioworker(void)
>>> +{
>>> +}
>>>  #endif
>>>
>>>  static inline bool io_wq_current_is_worker(void)
>>
>> This should go in include/linux/io_uring.h and then userfaultfd would
>> not have to include io_uring private headers.
>>
>> But that's beside the point, like I said we still need to get to the
>> bottom of what is going on here first, rather than try and paper around
>> it. So please don't post more versions of this before we have that
>> understanding.
>>
>> See previous emails on 6.8 and other kernel versions.
>>
>> --
>> Jens Axboe
> The issue did not involve creating new worker processes. Instead, the
> existing IOU worker kernel threads (about a dozen) associated with the VM
> process were fully utilizing CPU without writing data, caused by a fault
> while reading user data pages in the fault_in_iov_iter_readable function
> when pulling user memory into kernel space.

OK that makes more sense, I can certainly reproduce a loop in this path:

iou-wrk-726     729    36.910071:       9737 cycles:P: 
        ffff800080456c44 handle_userfault+0x47c
        ffff800080381fc0 hugetlb_fault+0xb68
        ffff80008031fee4 handle_mm_fault+0x2fc
        ffff8000812ada6c do_page_fault+0x1e4
        ffff8000812ae024 do_translation_fault+0x9c
        ffff800080049a9c do_mem_abort+0x44
        ffff80008129bd78 el1_abort+0x38
        ffff80008129ceb4 el1h_64_sync_handler+0xd4
        ffff8000800112b4 el1h_64_sync+0x6c
        ffff80008030984c fault_in_readable+0x74
        ffff800080476f3c iomap_file_buffered_write+0x14c
        ffff8000809b1230 blkdev_write_iter+0x1a8
        ffff800080a1f378 io_write+0x188
        ffff800080a14f30 io_issue_sqe+0x68
        ffff800080a155d0 io_wq_submit_work+0xa8
        ffff800080a32afc io_worker_handle_work+0x1f4
        ffff800080a332b8 io_wq_worker+0x110
        ffff80008002dd38 ret_from_fork+0x10

which seems to be expected, we'd continually try and fault in the
ranges, if the userfaultfd handler isn't filling them.

I guess this is where I'm still confused, because I don't see how this
is different from if you have a normal write(2) syscall doing the same
thing - you'd get the same looping.

??

> This issue occurs like during VM snapshot loading (which uses
> userfaultfd for on-demand memory loading), while the task in the guest is
> writing data to disk.
> 
> Normally, the VM first triggers a user fault to fill the page table.
> So in the IOU worker thread, the page tables are already filled,
> fault no chance happens when faulting in memory pages
> in fault_in_iov_iter_readable.
> 
> I suspect that during snapshot loading, a memory access in the
> VM triggers an async page fault handled by the kernel thread,
> while the IOU worker's async kernel thread is also running.
> Maybe If the IOU worker's thread is scheduled first.
> I?m going to bed now.

Ah ok, so what you're saying is that because we end up not sleeping
(because a signal is pending, it seems), then the fault will never get
filled and hence progress not made? And the signal is pending because
someone tried to create a net worker, and this work is not getting
processed.

-- 
Jens Axboe

