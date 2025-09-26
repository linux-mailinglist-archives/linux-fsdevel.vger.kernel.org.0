Return-Path: <linux-fsdevel+bounces-62872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6356BA3840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB71BC3E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63E279359;
	Fri, 26 Sep 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jmF5Jn87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736F158DAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887006; cv=none; b=VVWd3vljIiT94cWwYiMv/B5aEgxd/hF3qoSThN8HoNjm2GQdWWSXXC5cXzbGRN6KPs/V/wIf9QnCfY9cpft1AFd5RVQGHN20J9e0PIURgXq+ZSvy8J+kAyf4NcilvMiNPxQq9DvMupwvrywDzv6DSJw3blDxHHyaMH8TvxAHm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887006; c=relaxed/simple;
	bh=fqpzpvlAwhX9vB6+GgYQcq3AeD1lm7c5vEilT1YtHt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h50QP5XmqPV03+KGTSkmur8IlCZiBY0/3L3IhWp7Mf6x5f+8xxo4Y6PXkWnZD0v6h8EX1KgOgFp0pv6CIjOhr4Cj5j7B/uDjHwpLPb2EnX/+M4TuYaiOk5BW+C2IycCTQ9JVWHwHugGXwBkaxXMWiQsF/W70Xau/xEyL3VDRDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jmF5Jn87; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7800ff158d5so1402860b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758887004; x=1759491804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ThV86u1wTTvY9fFs1wUCpa9aBdTWAnLVlViDjz/hTU=;
        b=jmF5Jn87XQSduhyBi0bQdWy6nLV1qwLyYzQVg37ZfWZx7N80iImjM+ADOJ8qDLK4jg
         LONag9bJBoHCtb+LGbnY1GvZy9t9sfHmYfzKcmjo8SM1MoeibTfrJb3W1bx3TJirbyFp
         tlGGSRMAZosIYbR0J4mDT4ReAyBiyV1J6yZ326TRmA1zsxSdUoASVrvZ0xETc7tdH07u
         nwFjtTpRHSdy7S0orp4GUgqIw8DOlHAsMH6FAHE8O5UbxzjjlZ+faC0zG2C1J6/beFe/
         m2KbgffuGAaEXXmLYir6KSeERJfTAipYflaHVqDX++ZLCXaWf4+Uwn2q6VCfHe/BWPir
         m/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887004; x=1759491804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ThV86u1wTTvY9fFs1wUCpa9aBdTWAnLVlViDjz/hTU=;
        b=WX3OBERz9bKkvv0mYjvqkYJg7pUPTTUkRm7X33SC0Bs7nIre+zzmnqKFqGnNx8MMOR
         nbzFMuUuYRL7JgUj4FUnP4VXO9w3m5ED3HhvpuAQeZxIxQhQqzruZ0X/seg9tpuje+4y
         Q6w2eWQLcfMMQ7RgTvs/Eo3qjd9zuR3GuhjO54oOSaq/wGr4LEUzJcUCWw20JZKq1Otd
         OL87aLox3qI69PLJ3ghaVzbefBwG/Ghx53V9THOb5Aiex/JtRch9B1JvcN/34o3zaawE
         uZt/eQGoLBpbO6WhO4CqUwayH/m74xdqka80ujZw0JVH7Smbj98auNudnMSZX3O2kEwB
         LOUQ==
X-Gm-Message-State: AOJu0YytYex79104bHSleGqrqeSdn5RGcO75UhHih7yO5oO9XO6KFGpx
	G/AiiGe4f0feXCvnnCm2kJ+jANi3MdzFQWmWVjAiJ49UZkLCnId9NVJdgLnofFSqkxI=
X-Gm-Gg: ASbGncuVUTLUhiRMOGrNgaevTGy5GgAVSUh9PemVEf0BqnN8zHWlQLspyu8tSn4+Fno
	hEWNbK7PMtNUsmrnFUZiAlmurmp2h4qgK2TR4HU3VQTiv1+DNX2KRUjHO3MTHC7hnJqpEoJpkp8
	jo4u00S7liKK8J9+M2npLLgxQJOj6lKE7+bNntNb2Aom9jjxxTESyfKwqQaGMwo+vZOjrNc3Z1R
	XHyOdwKGsBE3pMDBZ+tennyZcVMDoOFVQOtxWujBSzu9qHOwZxuGwJy/aAt4c5qfIQLUS5dlHNi
	OiOco6pnix9ttxqX6F80Glj7j4gD6dcM+gFstOg5NwZVZl9cYF9cum8dktmxYZjHMVndazK51hz
	pWY/t+0nTRO4SnAzVCpSYGMbMpOjq9haLaC76AhqqhDZK+0KHMxTbLtGmLZUdi7OrNORq2ScHNw
	==
X-Google-Smtp-Source: AGHT+IFY2vE8trEMhxLO0GjvCmZRQYBWDffyhSBAoOaNZBpJez0WqxbGHnYf/09OBli9hzVUIT6HIQ==
X-Received: by 2002:a05:6a00:986:b0:77f:4399:83a4 with SMTP id d2e1a72fcca58-780fceef715mr7042445b3a.27.1758887003625;
        Fri, 26 Sep 2025 04:43:23 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023e5f41sm4239153b3a.42.2025.09.26.04.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:43:23 -0700 (PDT)
Message-ID: <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com>
Date: Fri, 26 Sep 2025 19:43:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, akpm@linux-foundation.org,
 Lance Yang <lance.yang@linux.dev>
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
 <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> On Fri, Sep 26, 2025 at 4:26 AM Julian Sun <sunjunchao@bytedance.com> wrote:
>>
>> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
>>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
>>>> Writing back a large number of pages can take a lots of time.
>>>> This issue is exacerbated when the underlying device is slow or
>>>> subject to block layer rate limiting, which in turn triggers
>>>> unexpected hung task warnings.
>>>>
>>>> We can trigger a wake-up once a chunk has been written back and the
>>>> waiting time for writeback exceeds half of
>>>> sysctl_hung_task_timeout_secs.
>>>> This action allows the hung task detector to be aware of the writeback
>>>> progress, thereby eliminating these unexpected hung task warnings.
>>>>
>>>
>>> If I'm reading correctly this is also messing with stats how long the
>>> thread was stuck to begin with.
>>
>> IMO, it will not mess up the time. Since it only updates the time when
>> we can see progress (which is not a hang). If the task really hangs for
>> a long time, then we can't perform the time update—so it will not mess
>> up the time.
>>
> 
> My point is that if you are stuck in the kernel for so long for the
> hung task detector to take notice, that's still something worth
> reporting in some way, even if you are making progress. I presume with
> the patch at hand this information is lost.
> 
> For example the detector could be extended to drop a one-liner about
> encountering a thread which was unable to leave the kernel for a long
> time, even though it is making progress. Bonus points if the message
> contained info this is i/o and for which device.

Let me understand: you want to print logs when writeback is making 
progress but is so slow that the task can't exit, correct?
I see this as a new requirement different from the existing hung task 
detector: needing to print info when writeback is slow.
Indeed, the existing detector prints warnings in two cases: 1) no 
writeback progress; 2) progress is made but writeback is so slow it will 
take too long.
This patch eliminates warnings for case 2, but only to make hung task 
warnings more accurate.
Case 2 is essentially a performance issue. Increasing 
sysctl_hung_task_timeout_secs may make case 2 warnings disappear, but 
not case 1.
So we should consider: do we need to print info when slow writeback 
keeps a task from exiting beyond a certain time?
This deserves a new patch: record a timestamp at writeback start, 
compare it with the initial timestamp after each chunk is written back, 
and decide whether to print. This should meet your needs.
If fs maintainers find this reasonable, I'm willing to contribute the 
code.>
>> cc Lance and Andrew.
>>>
>>> Perhaps it would be better to have a var in task_struct which would
>>> serve as an indicator of progress being made (e.g., last time stamp of
>>> said progress).
>>>
>>> task_struct already has numerous holes so this would not have to grow it
>>> above what it is now.
>>>
>>>
>>>> This patch has passed the xfstests 'check -g quick' test based on ext4,
>>>> with no additional failures introduced.
>>>>
>>>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>>> ---
>>>>    fs/fs-writeback.c                | 13 +++++++++++--
>>>>    include/linux/backing-dev-defs.h |  1 +
>>>>    2 files changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>>>> index a07b8cf73ae2..475d52abfb3e 100644
>>>> --- a/fs/fs-writeback.c
>>>> +++ b/fs/fs-writeback.c
>>>> @@ -14,6 +14,7 @@
>>>>     *         Additions for address_space-based writeback
>>>>     */
>>>>
>>>> +#include <linux/sched/sysctl.h>
>>>>    #include <linux/kernel.h>
>>>>    #include <linux/export.h>
>>>>    #include <linux/spinlock.h>
>>>> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>>>>               kfree(work);
>>>>       if (done) {
>>>>               wait_queue_head_t *waitq = done->waitq;
>>>> +            /* Report progress to inform the hung task detector of the progress. */
>>>> +            bool force_wake = (jiffies - done->stamp) >
>>>> +                               sysctl_hung_task_timeout_secs * HZ / 2;
>>>>
>>>>               /* @done can't be accessed after the following dec */
>>>> -            if (atomic_dec_and_test(&done->cnt))
>>>> +            if (atomic_dec_and_test(&done->cnt) || force_wake)
>>>>                       wake_up_all(waitq);
>>>>       }
>>>>    }
>>>> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>>>>    void wb_wait_for_completion(struct wb_completion *done)
>>>>    {
>>>>       atomic_dec(&done->cnt);         /* put down the initial count */
>>>> -    wait_event(*done->waitq, !atomic_read(&done->cnt));
>>>> +    wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>>>>    }
>>>>
>>>>    #ifdef CONFIG_CGROUP_WRITEBACK
>>>> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>>>>                */
>>>>               __writeback_single_inode(inode, &wbc);
>>>>
>>>> +            /* Report progress to inform the hung task detector of the progress. */
>>>> +            if (work->done && (jiffies - work->done->stamp) >
>>>> +                HZ * sysctl_hung_task_timeout_secs / 2)
>>>> +                    wake_up_all(work->done->waitq);
>>>> +
>>>>               wbc_detach_inode(&wbc);
>>>>               work->nr_pages -= write_chunk - wbc.nr_to_write;
>>>>               wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
>>>> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
>>>> index 2ad261082bba..c37c6bd5ef5c 100644
>>>> --- a/include/linux/backing-dev-defs.h
>>>> +++ b/include/linux/backing-dev-defs.h
>>>> @@ -63,6 +63,7 @@ enum wb_reason {
>>>>    struct wb_completion {
>>>>       atomic_t                cnt;
>>>>       wait_queue_head_t       *waitq;
>>>> +    unsigned long stamp;
>>>>    };
>>>>
>>>>    #define __WB_COMPLETION_INIT(_waitq)       \
>>>> --
>>>> 2.39.5
>>>>
>>
>> Thanks,
>> --
>> Julian Sun <sunjunchao@bytedance.com>

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

