Return-Path: <linux-fsdevel+bounces-46975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B71A96EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D3E3BC6A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCC289356;
	Tue, 22 Apr 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L3nxsg7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879D2147F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332160; cv=none; b=Vbv3sQiygBe+lDBujGiLUnLPYzcixu1kZlBmej4s2MCVRCwI//W0t8MxWEnj2c7ugmFBHAIWz9lTgrnSx2fDz33WbsJYbSHinVAaRSMetqKDHl0JqJooL+b9RHl/lInNGF2KgTAycnKL06sNU+mO6pDNYZNkI5qgxJ8qmkGIaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332160; c=relaxed/simple;
	bh=iqAyjkTe8FJmSe36CfbeiEm/MnwVbc4LIHA3sVC2aYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKG3/Z1OcSJXI6mlqAxFHBbUnYItb6TfMX0BIfO5flgz5SkQ1g7CKUO2N5+OKDeazdGAPjz9zTo3mR8iTFsmKbm0sybNLHTI8ZOWDzK/xkdQUaU7CWRLZBLq/OW5OgUD6yZgyQU2WHvjEW6nWHpZKE2pwJqfaMrg36UU7Go+eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L3nxsg7G; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8613f456960so140785339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745332155; x=1745936955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZItchBs+om2xlqnvEPsN/ABV3TFl0Qstvr2y/+6RJl0=;
        b=L3nxsg7G2u8mYYbtyhF8ENYr6QoVO3fQ/+KE32sLtod79XeY5nCRwonkvClFzBckfN
         1tjV5cImzhpUbHbfaveYozjmXddvezVsKGQ0bwyUfU9i2Yw3OIuEeb+50ZCfgnUyrecw
         ZSCcznsMBs9WsJ7cmM9/Ykddu/IwSs8Ll9gqW0M3s6z7IIpXvUgDdlJ9jtHPldDTFjmi
         O0YpHssNY/25fLhLleu6k6/N9AgpY8WEzydWyEMulyRk75N+uPUtlbcL/aQVNFTcATL2
         UXvapfLhgRPLmvxnnf68IHxkAn5n4CCTlJecMYTf+0detV/igYkK8g/BJ021ksrD1tUX
         IDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745332155; x=1745936955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZItchBs+om2xlqnvEPsN/ABV3TFl0Qstvr2y/+6RJl0=;
        b=U8xi8ie3UM/mkAj7klZ2N59hi6YAfW/1Pf1edirImVC0UtvqCo0K8/teYDeh8bYcKO
         4j3zKSASrvySYgFapMEo4exJ3iLyjaoMwFmDKWRCiIzbM0TNipa6u4w67c0CepJMdb89
         gOTRK3S5cvXdox8eEwcd6K+rVsqk+7R22NmGR3HFDhe49TPtLxz9d2ICCzacL9xrAICP
         Q/iXdGkq0AuU+E4KoirRUDQPFpPLOdaIsd2YRS9dHla0pLOr1th2SICkpVaHYndGEwf7
         2/g+qB1ebJKqHGbmlSaepGARGLFf6KDfuOdyvtUvOjlKFP/X1/4QoKHNvwCOaxjKE1DM
         y3BA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ88C7SLvYxrGZqUpHI1/QTyM0moaM1EjG+1oA2uc8n2JKfph4dmyywI6GQiDF9CdbEpleV1qrqR2Y7J6R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GouGj4VtBe70Xntfi6JUGK9aajG/gl0ubR+5MJEkBLhezSv/
	YKVE8yuk+3x66Q9VvRquGlTNOXjAAhw/+IIHcxNMp0sIaEgoqDQKrd0UMClfyEs=
X-Gm-Gg: ASbGncs0bD6FhWKCCb5J6oBG+ig6rgNINob/fu4RbSLzvfgQ0JxO5ZJXEvKOwt/hcmr
	WOwvnUHRwm9FA/ULdXqDTVJBEPgn+63DysGn/8XpLaMi4XWyweEtt6morb0dUOAOa0aZd9RJts3
	g5DszB/Q93GwMGS1gpnvir+6MmetxzLENqZQ1sN7xqFEwj1t6ADiERoHd5ebb4iiIYPBK0bPS9F
	ye1rKOlY272ARIc2FNEWgm2qBUFhFZ1PyLMa1G2CflhfU49jdthgKOtM5zHV0hqrHoM6e0o8aLV
	YR1Y6QvVlcLpDx9klBDHNbd2scyMcOp3PshZpQ==
X-Google-Smtp-Source: AGHT+IFLV/+m8b6shyscF+FGI9c1u3BTJL9q26JyzZDFvicZ/3ujqlTuYIRRvE5h3xowrMyrH1jWVw==
X-Received: by 2002:a05:6602:360d:b0:85d:9e5d:efa9 with SMTP id ca18e2360f4ac-861dbeab815mr1478981639f.10.1745332154944;
        Tue, 22 Apr 2025 07:29:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a39554d1sm2320394173.111.2025.04.22.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 07:29:14 -0700 (PDT)
Message-ID: <da279d0f-d450-49ef-a64e-e3b551127ef5@kernel.dk>
Date: Tue, 22 Apr 2025 08:29:13 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix 100% CPU usage issue in IOU worker threads
To: =?UTF-8?B?5aec5pm65Lyf?= <qq282012236@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 akpm@linux-foundation.org, peterx@redhat.com, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250422104545.1199433-1-qq282012236@gmail.com>
 <bc68ea08-4add-4304-b66b-376ec488da63@kernel.dk>
 <CANHzP_tpNwcL45wQTb6yFwsTU7jUEnrERv8LSc677hm7RQkPuw@mail.gmail.com>
 <028b4791-b6fc-47e3-9220-907180967d3a@kernel.dk>
 <CANHzP_vD2a8O1TqTuVNVBOofnQs6ot+tDJCWQkeSifVF9pYxGg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANHzP_vD2a8O1TqTuVNVBOofnQs6ot+tDJCWQkeSifVF9pYxGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 8:18 AM, ??? wrote:
> On Tue, Apr 22, 2025 at 10:13?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/22/25 8:10 AM, ??? wrote:
>>> On Tue, Apr 22, 2025 at 9:35?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 4/22/25 4:45 AM, Zhiwei Jiang wrote:
>>>>> In the Firecracker VM scenario, sporadically encountered threads with
>>>>> the UN state in the following call stack:
>>>>> [<0>] io_wq_put_and_exit+0xa1/0x210
>>>>> [<0>] io_uring_clean_tctx+0x8e/0xd0
>>>>> [<0>] io_uring_cancel_generic+0x19f/0x370
>>>>> [<0>] __io_uring_cancel+0x14/0x20
>>>>> [<0>] do_exit+0x17f/0x510
>>>>> [<0>] do_group_exit+0x35/0x90
>>>>> [<0>] get_signal+0x963/0x970
>>>>> [<0>] arch_do_signal_or_restart+0x39/0x120
>>>>> [<0>] syscall_exit_to_user_mode+0x206/0x260
>>>>> [<0>] do_syscall_64+0x8d/0x170
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80
>>>>> The cause is a large number of IOU kernel threads saturating the CPU
>>>>> and not exiting. When the issue occurs, CPU usage 100% and can only
>>>>> be resolved by rebooting. Each thread's appears as follows:
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork_asm
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_worker_handle_work
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_submit_work
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_issue_sqe
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_write
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] blkdev_write_iter
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_file_buffered_write
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_write_iter
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_iov_iter_readable
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_readable
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] asm_exc_page_fault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] exc_page_fault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] do_user_addr_fault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_mm_fault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_fault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_no_page
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_handle_userfault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_userfault
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] schedule
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __schedule
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __raw_spin_unlock_irq
>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker_sleeping
>>>>>
>>>>> I tracked the address that triggered the fault and the related function
>>>>> graph, as well as the wake-up side of the user fault, and discovered this
>>>>> : In the IOU worker, when fault in a user space page, this space is
>>>>> associated with a userfault but does not sleep. This is because during
>>>>> scheduling, the judgment in the IOU worker context leads to early return.
>>>>> Meanwhile, the listener on the userfaultfd user side never performs a COPY
>>>>> to respond, causing the page table entry to remain empty. However, due to
>>>>> the early return, it does not sleep and wait to be awakened as in a normal
>>>>> user fault, thus continuously faulting at the same address,so CPU loop.
>>>>> Therefore, I believe it is necessary to specifically handle user faults by
>>>>> setting a new flag to allow schedule function to continue in such cases,
>>>>> make sure the thread to sleep.
>>>>>
>>>>> Patch 1  io_uring: Add new functions to handle user fault scenarios
>>>>> Patch 2  userfaultfd: Set the corresponding flag in IOU worker context
>>>>>
>>>>>  fs/userfaultfd.c |  7 ++++++
>>>>>  io_uring/io-wq.c | 57 +++++++++++++++---------------------------------
>>>>>  io_uring/io-wq.h | 45 ++++++++++++++++++++++++++++++++++++--
>>>>>  3 files changed, 68 insertions(+), 41 deletions(-)
>>>>
>>>> Do you have a test case for this? I don't think the proposed solution is
>>>> very elegant, userfaultfd should not need to know about thread workers.
>>>> I'll ponder this a bit...
>>>>
>>>> --
>>>> Jens Axboe
>>> Sorry,The issue occurs very infrequently, and I can't manually
>>> reproduce it. It's not very elegant, but for corner cases, it seems
>>> necessary to make some compromises.
>>
>> I'm going to see if I can create one. Not sure I fully understand the
>> issue yet, but I'd be surprised if there isn't a more appropriate and
>> elegant solution rather than exposing the io-wq guts and having
>> userfaultfd manipulate them. That really should not be necessary.
>>
>> --
>> Jens Axboe
> Thanks.I'm looking forward to your good news.

Well, let's hope there is! In any case, your patches could be
considerably improved if you did:

void set_userfault_flag_for_ioworker(void)
{
	struct io_worker *worker;
	if (!(current->flags & PF_IO_WORKER))
		return;
	worker = current->worker_private;
	set_bit(IO_WORKER_F_FAULT, &worker->flags);
}

void clear_userfault_flag_for_ioworker(void)
{
	struct io_worker *worker;
	if (!(current->flags & PF_IO_WORKER))
		return;
	worker = current->worker_private;
	clear_bit(IO_WORKER_F_FAULT, &worker->flags);
}

and then userfaultfd would not need any odd checking, or needing io-wq
related structures public. That'd drastically cut down on the size of
them, and make it a bit more palatable.

-- 
Jens Axboe

