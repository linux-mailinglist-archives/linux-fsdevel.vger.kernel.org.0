Return-Path: <linux-fsdevel+bounces-47117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43354A9951F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CD85A7453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4227FD49;
	Wed, 23 Apr 2025 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LVrjJUUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FA57C9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425398; cv=none; b=jQhxxgRJH3JChnEdDxSfLwEeVqF3XNtmKu4p8EGcfp0XYd/dh69NqP7bVmWY7ypxzYdwLMggEqzr9cHAvsvBZ+3/JY4hCTk84LgSbOHHpV1FWmCxDvBD6XMpebVKFI0vgITH0oZ0QySW1zgyCQ8rZsRpMsZyu9zIGd4YbRvdm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425398; c=relaxed/simple;
	bh=shKmVGgvfgHgWNRKSnZX1dkD3RfPimNOXfffdFYgLjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSzh2wKFblYSAxIQBv14HqezZBRYwvfnGhEF4JwTFYPFefyxqsEO1sPu00UPX2pF6+HIy1DEHnyzgJSCCnVFz9+cSAvxhFDt/s3UI514FXIVPUA3yvSpsqNAP76nhSTR0c9vgHXEKhpusmQGz0zjW9SrWABO50vwvc/rTkR1xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LVrjJUUu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-861b1f04b99so4022639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745425394; x=1746030194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WgwtqZXRJEQM3pZXQxpD7hzXVzbdAqM+KQzabDh7EY=;
        b=LVrjJUUuqXwuml3zowXO4tjw603keuvkMjClgwmQW0tCev0d2POf9jz54S0mslLDSw
         wB2087rREdO+GW3K8KW4AcMvsCCTlxxhJmJXEASAz/r5jgEXezFaeVjS797lsuF8ZpCt
         422wIUW2aPPB3XJzdN6+5cukC/gp48idsfwP4pemQBq4EFmUYSCaFsQCMtU/vwfZOgkT
         EIJwVtLYoY775W7zDVkvB/x8b5kCo3E9PukE+5/fj8RkHe2uN0UPKH/W/1uV76+RYdjM
         BW7u734CzzOjlqEvFt5qriH9oQNHW3tdgNBqHcXt0tX87ZLkrArkAnXv8Kzd9mBkYSkl
         yuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425394; x=1746030194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WgwtqZXRJEQM3pZXQxpD7hzXVzbdAqM+KQzabDh7EY=;
        b=Z0AgZS2WGWal+ixZS9KgSn8yt4BcQWn91tHrLUs1MDCB5LCaUzaA+TQH55DTLUIanF
         DvLn1FoN1OpWI1bYZq0MCfk93W63xqVhVdxiclLI2FFkrzyBjJpHCvTwJqim5Grfu1TC
         CaCNGwQhPh8WCf5yOEhuRYsK8D8OLP2Hr27j+Pqx5n1kvnQizgX5sJ0DTrAYXtwL3SDv
         BQeRen/BNV+g17tHPJLTLi9NyMmr9d3qeo4NjVfQkJ1ERpNgGl49nLWyChAwycqJkEF0
         uLtTTDLkaHInIrTKYqI+U4XJT5buOOCupBWm8hEAGENpapSeIt61QRgHRmUZsIxnf41R
         kT6A==
X-Forwarded-Encrypted: i=1; AJvYcCUB+7+HYlT5bS5uj7LNb9c1l70rg1fOwVxCH1HtoClX+suGqI4aDVQVo0OBs1gl5mKd8aQ9l87IRt4+JjuK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1W4MmH5MhzMzy6kp+Yi4e7PGRenMMuT0QAaU3T1KQ3ln+HcIQ
	2bxeBhC6NjrJEO9d3joydB6xZUN2QgvN8FfFhP2A/3al2KsCBbDEOf9/80cMWhs=
X-Gm-Gg: ASbGncuu6iCwxqgNfa1RI494cDgIBsTj2yiMn4DGHQJf4sRbYW2bz3cgvtRDnDiVxFK
	eKlNqeseYJXcqVNiX8tWDpVfScmhUXpRLJARYLep6Ocby7Nb7uEK8PNJ2d0RDDNTV10wRpxrULY
	eFOtt7pNxa+3eG+X62dXBcqSaldf2AebN6TNDqnpZSyzRpsSVSMnSZ/9RLSZiP5HTD+mhpJyTQu
	gOQd2lL3fH+BhSnBqkaTr0DZ75pVr4VX9fb3vcJIsiK460m2WYgiHuHqrorQvHIugPcLIv9r6pj
	iyfpU9hUGANcUHEWRasnZhV6uW7SolsN6iHu
X-Google-Smtp-Source: AGHT+IF57jCcvc6iss1E50MTJGmLwy68aLSyNWDrvGVMv0IcOE+2tTptvX1cLdDwGLpgUH9kkYlOYg==
X-Received: by 2002:a5d:9f54:0:b0:862:fe54:df4e with SMTP id ca18e2360f4ac-862ff49043dmr1599069739f.7.1745425393949;
        Wed, 23 Apr 2025 09:23:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86444801669sm37130139f.29.2025.04.23.09.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 09:23:13 -0700 (PDT)
Message-ID: <4ec65451-d183-453e-a873-97b4abb4f884@kernel.dk>
Date: Wed, 23 Apr 2025 10:23:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] io_uring: Add new functions to handle user fault
 scenarios
To: Pavel Begunkov <asml.silence@gmail.com>, =?UTF-8?B?5aec5pm65Lyf?=
 <qq282012236@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 akpm@linux-foundation.org, peterx@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250422162913.1242057-1-qq282012236@gmail.com>
 <20250422162913.1242057-2-qq282012236@gmail.com>
 <14195206-47b1-4483-996d-3315aa7c33aa@kernel.dk>
 <CANHzP_uW4+-M1yTg-GPdPzYWAmvqP5vh6+s1uBhrMZ3eBusLug@mail.gmail.com>
 <b61ac651-fafe-449a-82ed-7239123844e1@kernel.dk>
 <CANHzP_tLV29_uk2gcRAjT9sJNVPH3rMyVuQP07q+c_TWWgsfDg@mail.gmail.com>
 <7bea9c74-7551-4312-bece-86c4ad5c982f@kernel.dk>
 <52d55891-36e3-43e7-9726-a2cd113f5327@kernel.dk>
 <00c7d434-d923-4b91-8ad0-5f3c8e0c6465@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00c7d434-d923-4b91-8ad0-5f3c8e0c6465@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 10:17 AM, Pavel Begunkov wrote:
> On 4/23/25 16:55, Jens Axboe wrote:
>> Something like this, perhaps - it'll ensure that io-wq workers get a
>> chance to flush out pending work, which should prevent the looping. I've
>> attached a basic test case. It'll issue a write that will fault, and
>> then try and cancel that as a way to trigger the TIF_NOTIFY_SIGNAL based
>> looping.
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index d80f94346199..e18926dbf20a 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/swapops.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/uio.h>
>> +#include <linux/io_uring.h>
>>     static int sysctl_unprivileged_userfaultfd __read_mostly;
>>   @@ -376,6 +377,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>        */
>>       if (current->flags & (PF_EXITING|PF_DUMPCORE))
>>           goto out;
>> +    else if (current->flags & PF_IO_WORKER)
>> +        io_worker_fault();
>>         assert_fault_locked(vmf);
>>   diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
>> index 85fe4e6b275c..d93dd7402a28 100644
>> --- a/include/linux/io_uring.h
>> +++ b/include/linux/io_uring.h
>> @@ -28,6 +28,7 @@ static inline void io_uring_free(struct task_struct *tsk)
>>       if (tsk->io_uring)
>>           __io_uring_free(tsk);
>>   }
>> +void io_worker_fault(void);
>>   #else
>>   static inline void io_uring_task_cancel(void)
>>   {
>> @@ -46,6 +47,9 @@ static inline bool io_is_uring_fops(struct file *file)
>>   {
>>       return false;
>>   }
>> +static inline void io_worker_fault(void)
>> +{
>> +}
>>   #endif
>>     #endif
>> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
>> index d52069b1177b..f74bea028ec7 100644
>> --- a/io_uring/io-wq.c
>> +++ b/io_uring/io-wq.c
>> @@ -1438,3 +1438,13 @@ static __init int io_wq_init(void)
>>       return 0;
>>   }
>>   subsys_initcall(io_wq_init);
>> +
>> +void io_worker_fault(void)
>> +{
>> +    if (test_thread_flag(TIF_NOTIFY_SIGNAL))
>> +        clear_notify_signal();
>> +    if (test_thread_flag(TIF_NOTIFY_RESUME))
>> +        resume_user_mode_work(NULL);
>> +    if (task_work_pending(current))
>> +        task_work_run();
> 
> Looking at the stacktrace, that sounds dangerous
> 
> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_worker
> iou-wrk-44588  [kernel.kallsyms]  [k] io_worker_handle_work
> iou-wrk-44588  [kernel.kallsyms]  [k] io_wq_submit_work
> iou-wrk-44588  [kernel.kallsyms]  [k] io_issue_sqe
> iou-wrk-44588  [kernel.kallsyms]  [k] io_write
> iou-wrk-44588  [kernel.kallsyms]  [k] blkdev_write_iter
> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_file_buffered_write
> iou-wrk-44588  [kernel.kallsyms]  [k] iomap_write_iter
> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_iov_iter_readable
> iou-wrk-44588  [kernel.kallsyms]  [k] fault_in_readable
> iou-wrk-44588  [kernel.kallsyms]  [k] asm_exc_page_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] exc_page_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] do_user_addr_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] handle_mm_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_fault
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_no_page
> iou-wrk-44588  [kernel.kallsyms]  [k] hugetlb_handle_userfault
> iou-wrk-44588  [kernel.kallsyms]  [k] handle_userfault
> 
> It might be holding a good bunch of locks, and then it's trapped
> in a page fault handler. Do normal / non-PF_IO_WORKER tasks run
> task_work from handle_userfault?

Yeah, it's really just a test patch. Ideally we want this to do the
usual thing, which is fall back and let it retry, where we can handle
all of this too.

-- 
Jens Axboe

