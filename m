Return-Path: <linux-fsdevel+bounces-46986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A14A972B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0EF4037CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE2296157;
	Tue, 22 Apr 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BvlEaxhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36979290BAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339060; cv=none; b=QHpYAuFJjKUZT6k1ijwy1y+lNlpiS25Tw2Mb53q36aMOm9gb5ps+AusUWqozGys6PwwdCfUPhwiOAZTMiND7hC95HuOlrbNiZGvSmlYcud6xRemHC2TKoi6zHn/57bPqK7ZWcnQxlWHPrevAtuSRQu3T0k5DsNJwnPKMBSHe/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339060; c=relaxed/simple;
	bh=tTPyvvktfcqDPnRBx86/RWSrX9I6vskownhbBGOPXww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAx13B3EM2JsuQs1z3/zbLYzpG++WCkIgExEHSEpxi6Z6MSeVzE/2euSHZSyUMDwe+l2ric9nFiFtWArBpZ+KqgkRCenPXv46FZEQK4ZmiJXoG29MsFWseIcmoMeLm6mbr/fMMcfAIZLzRsqEB7/Whdimr9RfxotUBbl4h2clQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BvlEaxhl; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8613f456960so144877539f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745339056; x=1745943856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3O/04KOewEqYkmyH962BGKGCen1FWcqj/+4ibHpaNw=;
        b=BvlEaxhlQwMx4A2Gt0wqcpzMRbPARqjN8ny5hYgapd5ZlVVv2dt/PgTr1iRlQrd0uI
         H7cq7ITTo/v/ktrK/MKx7e33MpvUkx4uCk4heiMCVEY53L6N7H/3z9n/tgSiISjnk3kz
         waTsZ/Cpk36xHwHtChFpkd6FrllgTuEfLoRoHYmXvk51o42rfZz4OfJvTDjr3gctyrpw
         PhitvvHstStda4i/FTIxvcR7XEMWTF+gzve168eK5Uc+6oj9z2B5KEFzgyIVdAKxMXfh
         VpoFJ6BjcUy/b3ZbShZM9/C0x2YYQTlNDkB9qpMkrbT9WLVwu1/CRPC1j7ZfiM7cATwL
         ObJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339056; x=1745943856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3O/04KOewEqYkmyH962BGKGCen1FWcqj/+4ibHpaNw=;
        b=V77NcgjkzlcqXo63PRFag9w7QVwmbsW67T3VS6Joft+gKRgHyoaU+D5xWk9QTBr3N3
         tVTZ6yawh6Hkdi0SCrGrB5FvQHulRoZ3z2NIO+R56ewtj4fgY0NyBx2baVaMMtyJHZfd
         VTc1FgILQXnPeECQyokrB0nUSgc0hXX/X7J+exT3z/GVhb12A1M9JaCIXGmATlcSNnOx
         CjXQuzzlpQelC4FlKXwXgbETo+LxJ051p7NF4li+N0qNe2svmi0vH67vKCv8cxzevbLV
         0zwgTX2SziHLHfAR4Y5HWc8/CMECVR3oEAo9MkVvqqpgQB6EvPvwkA1u1SDZuWPi3Bh+
         aMzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtbTqNjvFwjysNf6muxzZfrfTtLDKrhH8yFrA2hTnX8ke2gYJdqHRcoeS83ktyW+0FbYSrAw61EfUD7qsv@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdkDg5XbXY9mF4TF740QcHXJQx/bkIXouCc96Redn7oGBHdK7
	LiVm+rQENjlJtRkXBK8R0flhDyu/+EGqYCTKLzuQEjfi12iMEKRKtLSE+Db8X+8q5mj3Sn34Wsr
	q
X-Gm-Gg: ASbGncvO47hCXDiYaYEtycICDPHMEQqPkdaFYbcSCwhX9QTUOvu9VYpqvonfCi0ixYw
	/6dKLSOHpOCPCbuh+MxkZH1avDLdISxSlDv99TdwGMjU3unw/xBphF4oRX5cc3PqQPT2MgKAFRd
	/V2629mLi7AOlys0N2HTMQ/yQjuFagmrRfMQspu5i6vub0vaZF9rXaOlyL6BTK5XTb88A94lIE/
	Mr24/SDTQpyQGWAEzrUcXRmBjeoyDpF7qmZT68yhd9NdmVKO1M+IDtp5VHyZ8Ot8VhDAVmyEnOF
	q1yxEOt38ikZsnwbcX7nLYFdN4deocDGac31Cw==
X-Google-Smtp-Source: AGHT+IF+oA4Oa5RZl9BtxMoy39ZTJG2xZrFT/oMGu2VwciXmQf2r8GThv4QUlCvkUQXjdhpIKpVdcw==
X-Received: by 2002:a05:6602:7284:b0:85b:46b5:6fb5 with SMTP id ca18e2360f4ac-861dbeab8fcmr1637684939f.11.1745339056189;
        Tue, 22 Apr 2025 09:24:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3933d59sm2410172173.94.2025.04.22.09.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:24:15 -0700 (PDT)
Message-ID: <0a9dfa29-62c9-4e47-aa4a-db36b61df3d1@kernel.dk>
Date: Tue, 22 Apr 2025 10:24:14 -0600
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
 <da279d0f-d450-49ef-a64e-e3b551127ef5@kernel.dk>
 <b5a8dbda-8555-4b43-9a46-190d4f1c7519@kernel.dk>
 <CANHzP_u=a1U4pXtFoQ8Aw_OCUkxgfV9ZGaBr8kiuOReTGTY3=g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANHzP_u=a1U4pXtFoQ8Aw_OCUkxgfV9ZGaBr8kiuOReTGTY3=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 10:14 AM, ??? wrote:
> On Tue, Apr 22, 2025 at 11:50?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/22/25 8:29 AM, Jens Axboe wrote:
>>> On 4/22/25 8:18 AM, ??? wrote:
>>>> On Tue, Apr 22, 2025 at 10:13?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 4/22/25 8:10 AM, ??? wrote:
>>>>>> On Tue, Apr 22, 2025 at 9:35?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>
>>>>>>> On 4/22/25 4:45 AM, Zhiwei Jiang wrote:
>>>>>>>> In the Firecracker VM scenario, sporadically encountered threads with
>>>>>>>> the UN state in the following call stack:
>>>>>>>> [<0>] io_wq_put_and_exit+0xa1/0x210
>>>>>>>> [<0>] io_uring_clean_tctx+0x8e/0xd0
>>>>>>>> [<0>] io_uring_cancel_generic+0x19f/0x370
>>>>>>>> [<0>] __io_uring_cancel+0x14/0x20
>>>>>>>> [<0>] do_exit+0x17f/0x510
>>>>>>>> [<0>] do_group_exit+0x35/0x90
>>>>>>>> [<0>] get_signal+0x963/0x970
>>>>>>>> [<0>] arch_do_signal_or_restart+0x39/0x120
>>>>>>>> [<0>] syscall_exit_to_user_mode+0x206/0x260
>>>>>>>> [<0>] do_syscall_64+0x8d/0x170
>>>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80
>>>>>>>> The cause is a large number of IOU kernel threads saturating the CPU
>>>>>>>> and not exiting. When the issue occurs, CPU usage 100% and can only
>>>>>>>> be resolved by rebooting. Each thread's appears as follows:
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork_asm
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] ret_from_fork
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_worker_handle_work
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_submit_work
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_issue_sqe
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_write
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] blkdev_write_iter
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_file_buffered_write
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_write_iter
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_iov_iter_readable
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_readable
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] asm_exc_page_fault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] exc_page_fault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] do_user_addr_fault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_mm_fault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_fault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_no_page
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_handle_userfault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] handle_userfault
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] schedule
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __schedule
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] __raw_spin_unlock_irq
>>>>>>>> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker_sleeping
>>>>>>>>
>>>>>>>> I tracked the address that triggered the fault and the related function
>>>>>>>> graph, as well as the wake-up side of the user fault, and discovered this
>>>>>>>> : In the IOU worker, when fault in a user space page, this space is
>>>>>>>> associated with a userfault but does not sleep. This is because during
>>>>>>>> scheduling, the judgment in the IOU worker context leads to early return.
>>>>>>>> Meanwhile, the listener on the userfaultfd user side never performs a COPY
>>>>>>>> to respond, causing the page table entry to remain empty. However, due to
>>>>>>>> the early return, it does not sleep and wait to be awakened as in a normal
>>>>>>>> user fault, thus continuously faulting at the same address,so CPU loop.
>>>>>>>> Therefore, I believe it is necessary to specifically handle user faults by
>>>>>>>> setting a new flag to allow schedule function to continue in such cases,
>>>>>>>> make sure the thread to sleep.
>>>>>>>>
>>>>>>>> Patch 1  io_uring: Add new functions to handle user fault scenarios
>>>>>>>> Patch 2  userfaultfd: Set the corresponding flag in IOU worker context
>>>>>>>>
>>>>>>>>  fs/userfaultfd.c |  7 ++++++
>>>>>>>>  io_uring/io-wq.c | 57 +++++++++++++++---------------------------------
>>>>>>>>  io_uring/io-wq.h | 45 ++++++++++++++++++++++++++++++++++++--
>>>>>>>>  3 files changed, 68 insertions(+), 41 deletions(-)
>>>>>>>
>>>>>>> Do you have a test case for this? I don't think the proposed solution is
>>>>>>> very elegant, userfaultfd should not need to know about thread workers.
>>>>>>> I'll ponder this a bit...
>>>>>>>
>>>>>>> --
>>>>>>> Jens Axboe
>>>>>> Sorry,The issue occurs very infrequently, and I can't manually
>>>>>> reproduce it. It's not very elegant, but for corner cases, it seems
>>>>>> necessary to make some compromises.
>>>>>
>>>>> I'm going to see if I can create one. Not sure I fully understand the
>>>>> issue yet, but I'd be surprised if there isn't a more appropriate and
>>>>> elegant solution rather than exposing the io-wq guts and having
>>>>> userfaultfd manipulate them. That really should not be necessary.
>>>>>
>>>>> --
>>>>> Jens Axboe
>>>> Thanks.I'm looking forward to your good news.
>>>
>>> Well, let's hope there is! In any case, your patches could be
>>> considerably improved if you did:
>>>
>>> void set_userfault_flag_for_ioworker(void)
>>> {
>>>       struct io_worker *worker;
>>>       if (!(current->flags & PF_IO_WORKER))
>>>               return;
>>>       worker = current->worker_private;
>>>       set_bit(IO_WORKER_F_FAULT, &worker->flags);
>>> }
>>>
>>> void clear_userfault_flag_for_ioworker(void)
>>> {
>>>       struct io_worker *worker;
>>>       if (!(current->flags & PF_IO_WORKER))
>>>               return;
>>>       worker = current->worker_private;
>>>       clear_bit(IO_WORKER_F_FAULT, &worker->flags);
>>> }
>>>
>>> and then userfaultfd would not need any odd checking, or needing io-wq
>>> related structures public. That'd drastically cut down on the size of
>>> them, and make it a bit more palatable.
>>
>> Forgot to ask, what kernel are you running on?
>>
>> --
>> Jens Axboe
> Thanks Jens It is linux-image-6.8.0-1026-gcp

OK, that's ancient and unsupported in that no stable release is
happening for that kernel. Does it happen on newer kernels too?

FWIW, I haven't been able to reproduce anything odd so far. The io_uring
writes going via io-wq and hitting the userfaultfd path end up sleeping
in the schedule() in handle_userfault() - which is what I'd expect.

Do you know how many pending writes there are? I have a hard time
understanding your description of the problem, but it sounds like a ton
of workers are being created. But it's still not clear to me why that
would be, workers would only get created if there's more work to do, and
the current worker is going to sleep.

Puzzled...

-- 
Jens Axboe

