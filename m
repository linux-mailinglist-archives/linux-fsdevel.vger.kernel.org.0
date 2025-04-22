Return-Path: <linux-fsdevel+bounces-46983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65737A97196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135BE17F647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA228FFF3;
	Tue, 22 Apr 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YspOb0Vy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08028F954
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337003; cv=none; b=hZh3RHMvDf2XH7xivrFngBJUpKERqlFcl/hYDrc09qTCC+GGwr5W81MzThjcM13YjXjZfEY7q1HauVz6fqqN+LZzBS444XE3vqteTaCa6StgWUFpWo1ABDqMN3p3rdpKXWiuw6fqOid/9uxAEBq84Z1Q5L4kiJTwKpoYGkEGXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337003; c=relaxed/simple;
	bh=VR2wSZLLUzPL+4k8PCQs4hb25e/cLPSyEI4SSh424OQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZpJBwQCdbsJHq8UBhgON9PJE+0Z5yC3bj1tGSji6qhTn+rgrareAznMghXY5d/WE5yIl1nhMbL/1V0JnwCHSrkXYm/YGSs8q211dPfA0uy6X89HJ1oci8/bIstisJOosj5jkjM36zwbhp3eje/XkD3ZLWsMCF//V5nssCeDth7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YspOb0Vy; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d91b55bd39so7300335ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745337000; x=1745941800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWtCOErAPdviJAPXqAg1WYEhucNuXZisNIO11WL+WKM=;
        b=YspOb0VyuVey+MJy+Spdgbf7qfo+NGvaUjU/P3hTqoa2DGUucfQ68atqUg9DaaGKlB
         Xu8VWxouAIHPjdBUoGdeQWZBepuaF5KT6rMgpxBAqYRsXH0PubDj3gsfclg2SmEHozg9
         mmbV2wl8AKiau1eUSDpTLEGjYNz/l92dIXbl8sH7uE9ALKKFyIFLgvEKSk/hwh9XGr0X
         3EoX+QoWwk7vTkPhTfPJlDBCLKJXA2OqB5RmqTSIkWzDHnFOOBl1Ynu9EdUPzSLcI8v6
         4Wvhv7A7gybW3cWOCRrhUnpLfyDKnScegKOtqSipIp7J1DbtCI62YTP6RPoxsNrzQHmY
         tARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337000; x=1745941800;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWtCOErAPdviJAPXqAg1WYEhucNuXZisNIO11WL+WKM=;
        b=CQ1n/bDd55V7wYwaAaEKVCLd5U4LC3EQKOQwp/w2+264583dXSiLyXRUbnzMRmyUU/
         wlKXejp3RbY6MNBA1DjQiN/vplyIq/WcFu/TMoJH3PBJgH+e95sIVWdrISDVTMVZUI+N
         wmNmPsxuV3nfcpiFGKgzAiUQwsXDKsmtU4fyW0qXi8r3XOp5M+o/BPcxv1/fErzO1jlS
         GRfR5hjUH761Q9fo6OXiXJeak6Ufu89ArJ9027ztO5GXsfVp2WhjjFEdXGEXArrr3ch/
         LFkxcApVyutL7I3HUkRtv6fVnAXqyfcz/txygH++juIGKTYHPvpVmlKQ4SVclyBzd9Of
         ERag==
X-Forwarded-Encrypted: i=1; AJvYcCVHeYQCRAS9Bbs0qCG6kb7KIngPKt8u/DL2JfQN+71dh27Jl7HfSlHPIfynSdxA1aoYQ0VCajXhSqH/l5i0@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSc+YHMrJN3HMCdNRBJPJb3935IaiA4Nzv/U7Lj8p4y/R7kXu
	fG8rXOOkjqjNxCzsl4sr7VG3GDM3CIHppMZx1xvpsZnLW69yW8bnQj9mIjfIdaQ=
X-Gm-Gg: ASbGncuLnqcb9dwqyxckYsvkYh8BW5ZAdPWI7q6ihKH5nTqZ5RTKTVhvElebkL/YsWp
	YPcGKKxK7JIS1KXSqyOHA+uEO4h9pZiJtwEv4UH4dAveJtEKuON7+qzFHeRJuvwAo8vSKj21Gwm
	urFbiW1uVNDTDhIzytEyKBLcfLVC/s6nJaz3OkDw0/2/c0FANGxTcfnzGbDGp8arIdzBRKKP/bp
	cxeH6qFOJMm3aECB/bIYRWsP8o2ghxOJyRcBziYm2Mw/aeawG37SDQtY8jlgj1ezjMwovRrUvCg
	Ag/oVPJXk9uSbJUQfeDMHTD2xyCa9KWw3zfs8A==
X-Google-Smtp-Source: AGHT+IGAwwrMjNk9FpLKU7sspnSpBBOnFfhAwVWOfWP0g5H8a8AXj4k2N3R/0L2Z+lNpCM0/XNeMOw==
X-Received: by 2002:a05:6e02:338f:b0:3d8:1e50:1d55 with SMTP id e9e14a558f8ab-3d88eda9aebmr146286335ab.11.1745336999867;
        Tue, 22 Apr 2025 08:49:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821ec204dsm23495105ab.53.2025.04.22.08.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 08:49:59 -0700 (PDT)
Message-ID: <b5a8dbda-8555-4b43-9a46-190d4f1c7519@kernel.dk>
Date: Tue, 22 Apr 2025 09:49:58 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix 100% CPU usage issue in IOU worker threads
From: Jens Axboe <axboe@kernel.dk>
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
 <da279d0f-d450-49ef-a64e-e3b551127ef5@kernel.dk>
Content-Language: en-US
In-Reply-To: <da279d0f-d450-49ef-a64e-e3b551127ef5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 8:29 AM, Jens Axboe wrote:
> On 4/22/25 8:18 AM, ??? wrote:
>> On Tue, Apr 22, 2025 at 10:13?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 4/22/25 8:10 AM, ??? wrote:
>>>> On Tue, Apr 22, 2025 at 9:35?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 4/22/25 4:45 AM, Zhiwei Jiang wrote:
>>>>>> In the Firecracker VM scenario, sporadically encountered threads with
>>>>>> the UN state in the following call stack:
>>>>>> [<0>] io_wq_put_and_exit+0xa1/0x210
>>>>>> [<0>] io_uring_clean_tctx+0x8e/0xd0
>>>>>> [<0>] io_uring_cancel_generic+0x19f/0x370
>>>>>> [<0>] __io_uring_cancel+0x14/0x20
>>>>>> [<0>] do_exit+0x17f/0x510
>>>>>> [<0>] do_group_exit+0x35/0x90
>>>>>> [<0>] get_signal+0x963/0x970
>>>>>> [<0>] arch_do_signal_or_restart+0x39/0x120
>>>>>> [<0>] syscall_exit_to_user_mode+0x206/0x260
>>>>>> [<0>] do_syscall_64+0x8d/0x170
>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80
>>>>>> The cause is a large number of IOU kernel threads saturating the CPU
>>>>>> and not exiting. When the issue occurs, CPU usage 100% and can only
>>>>>> be resolved by rebooting. Each thread's appears as follows:
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork_asm
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_worker_handle_work
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_submit_work
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_issue_sqe
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_write
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] blkdev_write_iter
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_file_buffered_write
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_write_iter
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_iov_iter_readable
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_readable
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] asm_exc_page_fault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] exc_page_fault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] do_user_addr_fault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_mm_fault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_fault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_no_page
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_handle_userfault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_userfault
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] schedule
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __schedule
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __raw_spin_unlock_irq
>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker_sleeping
>>>>>>
>>>>>> I tracked the address that triggered the fault and the related function
>>>>>> graph, as well as the wake-up side of the user fault, and discovered this
>>>>>> : In the IOU worker, when fault in a user space page, this space is
>>>>>> associated with a userfault but does not sleep. This is because during
>>>>>> scheduling, the judgment in the IOU worker context leads to early return.
>>>>>> Meanwhile, the listener on the userfaultfd user side never performs a COPY
>>>>>> to respond, causing the page table entry to remain empty. However, due to
>>>>>> the early return, it does not sleep and wait to be awakened as in a normal
>>>>>> user fault, thus continuously faulting at the same address,so CPU loop.
>>>>>> Therefore, I believe it is necessary to specifically handle user faults by
>>>>>> setting a new flag to allow schedule function to continue in such cases,
>>>>>> make sure the thread to sleep.
>>>>>>
>>>>>> Patch 1  io_uring: Add new functions to handle user fault scenarios
>>>>>> Patch 2  userfaultfd: Set the corresponding flag in IOU worker context
>>>>>>
>>>>>>  fs/userfaultfd.c |  7 ++++++
>>>>>>  io_uring/io-wq.c | 57 +++++++++++++++---------------------------------
>>>>>>  io_uring/io-wq.h | 45 ++++++++++++++++++++++++++++++++++++--
>>>>>>  3 files changed, 68 insertions(+), 41 deletions(-)
>>>>>
>>>>> Do you have a test case for this? I don't think the proposed solution is
>>>>> very elegant, userfaultfd should not need to know about thread workers.
>>>>> I'll ponder this a bit...
>>>>>
>>>>> --
>>>>> Jens Axboe
>>>> Sorry,The issue occurs very infrequently, and I can't manually
>>>> reproduce it. It's not very elegant, but for corner cases, it seems
>>>> necessary to make some compromises.
>>>
>>> I'm going to see if I can create one. Not sure I fully understand the
>>> issue yet, but I'd be surprised if there isn't a more appropriate and
>>> elegant solution rather than exposing the io-wq guts and having
>>> userfaultfd manipulate them. That really should not be necessary.
>>>
>>> --
>>> Jens Axboe
>> Thanks.I'm looking forward to your good news.
> 
> Well, let's hope there is! In any case, your patches could be
> considerably improved if you did:
> 
> void set_userfault_flag_for_ioworker(void)
> {
> 	struct io_worker *worker;
> 	if (!(current->flags & PF_IO_WORKER))
> 		return;
> 	worker = current->worker_private;
> 	set_bit(IO_WORKER_F_FAULT, &worker->flags);
> }
> 
> void clear_userfault_flag_for_ioworker(void)
> {
> 	struct io_worker *worker;
> 	if (!(current->flags & PF_IO_WORKER))
> 		return;
> 	worker = current->worker_private;
> 	clear_bit(IO_WORKER_F_FAULT, &worker->flags);
> }
> 
> and then userfaultfd would not need any odd checking, or needing io-wq
> related structures public. That'd drastically cut down on the size of
> them, and make it a bit more palatable.

Forgot to ask, what kernel are you running on?

-- 
Jens Axboe

