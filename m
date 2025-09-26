Return-Path: <linux-fsdevel+bounces-62837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00387BA2356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C04C4A6E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96603259C98;
	Fri, 26 Sep 2025 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KApluC9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AA1388
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853603; cv=none; b=r9yttx2T6KkTlvJK8dzUMbGgYZTD00S/fWj+Px08mYnqjgUAbsbq+OppV4V85WN8z0qAB3TFXus8eVx+mxSFnsaJ0lOsEX0q6JD7sZ4oXFi/IapYS0XYC0C9T8nAhyOO0hUXMtYEZmchKbpuwYw7VzGQ//q7BHjyr8G7CG50qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853603; c=relaxed/simple;
	bh=jfnSzU3dZK3BO37TuzoBWFX44wM3mMtuQgcYXze0CnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwyBIQp28t4zJ7yJ/2T623McW8ve3IxvFug+vAE5VcV0RNdvKvJuEln7gTjhHPbb9m76IF5IwXCLVTdwdgaFcZN4uBwZQb7KytXH6JPKXpnuBa1oUP8VzkcIjZCeQMX9G3x0dVDdEcb0o5ElYw9cOSIoC4VWRgN2zUFz94D/Zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KApluC9Q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-780292fcf62so1336686b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758853600; x=1759458400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTpV4QZGIdxsr8ocAUHxkEKZk+k5fpbR8T9ErdIO/tE=;
        b=KApluC9QZSMlXJ1PIogkJrvEAk4KXRTa2BtI7iCXyGZv4EiBuesHA3pU3RIFsQriom
         sUHm3HUbNSfMx/gXX4I2ee5NUqalfh6L2CRC6xCCdgn2WJAIPrMyNl/nhlKFdOarnSWj
         tpNg9ruHj11Z+Sh6jFEcbx8077gwVqdZ34/6bGLIF+DM7IATfJhY0Ho1Mn5xguDhqmEg
         MOBe0/sE6u4SpRz6/RNVGUMobgkKpRJByB2K+bG2h8BneGtabu6oDyN3vbeFHrSzfjGz
         kfQUZ+acWNykuhBify3N/cCB6uIMUzR9LGlIUyCBsbDe0tXJY4e8oH7tQTkIqVSWmBzZ
         ISfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758853600; x=1759458400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oTpV4QZGIdxsr8ocAUHxkEKZk+k5fpbR8T9ErdIO/tE=;
        b=FPl2MlC7jYCZfEfQuo8kUhUNMy2s9xLfhm1AVh1NQDVVF4D+7nBT7S7bh/oBSq24Ry
         D7BHgsq0vid8u1mVgBH8zlDBhJvTBpxt6z2FIM/caiInzTn4iAAn1lPuN2th2Go1Uxk6
         t3qWYX3uTn7gIfBECDjuWKs0Q2QdsIRhKaiV8NLVI088GQcd0VvurUWJpDvHqqfSVoZA
         rthkwy8/zIWxhSFr3X2Db6jz/c7QyOrjPOM0KOAIkZivVFyHXc1CFOTQmkz16LK8Pjeo
         8Zl3veGMfX1LRCvenCC7og2XuL5hjgBrcXGjWNClVa5G0OK3s+4U0Q5p6REX7UHRRx/W
         CHWw==
X-Gm-Message-State: AOJu0Yy8w49i/ZA3rB+lko8EESrA2ydpGYlkMX+WXy+fnfOG80V+QYW2
	fLagHxle//LwXguGjYl/3IYcJ+RSVN0jwfetHibLlXzV+WIW0PUdjJGDJxNq1xpoOMmzHtHy1hI
	araRQ1KZlPQ==
X-Gm-Gg: ASbGncsGIPPADkmtS380CTtXGNNB65m2Ro6GhOvrYQenR59ClJm8+hhccb4qGz15Yq+
	h9sT6I0mHEwmGwqlGbG/qnxuL0y37pn3FHaLioVixPHQbDhW7Yg91dEKVhvZV53oBJFFrlnX7I6
	w1f7PWfMuHM5vB+0XGFxNZpvOMeFABTmdbdwEvUrjNzIFX0ivTRKuUQVkdjqZqRxpmDD7ZCalnt
	ZSmwGkVpZmmkdDFj2qeX1+x+IUbdTWxpC+ImBVpYJMZyn7IFqnkN3G896axHmyObUfB4JPJQEaC
	61rnE9a7DA/0BjvRG7EsXw8VVCRyfUiJV0cyC9o0CBsOsuhwZTIejok0W2MGhIHk+ziohqPmriJ
	isRDYl9LEWEHv+n+DUIw+piLWJYmJqB9cj3RUgt4my4ZD/Zhg5zKrxxwC7fxt2OkBjPDgyhxOZA
	==
X-Google-Smtp-Source: AGHT+IFKoTqYLzKYzMSXCB6584955xfpSDmgTfD78tM5lhmwgiiY+LxiDmokP1F+c3a+mRaimu6yBA==
X-Received: by 2002:a05:6a00:2186:b0:77f:2899:d443 with SMTP id d2e1a72fcca58-780fce1d14fmr4907298b3a.10.1758853600013;
        Thu, 25 Sep 2025 19:26:40 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c203dsm3115356b3a.22.2025.09.25.19.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 19:26:39 -0700 (PDT)
Message-ID: <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
Date: Fri, 26 Sep 2025 10:26:34 +0800
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
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
>> Writing back a large number of pages can take a lots of time.
>> This issue is exacerbated when the underlying device is slow or
>> subject to block layer rate limiting, which in turn triggers
>> unexpected hung task warnings.
>>
>> We can trigger a wake-up once a chunk has been written back and the
>> waiting time for writeback exceeds half of
>> sysctl_hung_task_timeout_secs.
>> This action allows the hung task detector to be aware of the writeback
>> progress, thereby eliminating these unexpected hung task warnings.
>>
> 
> If I'm reading correctly this is also messing with stats how long the
> thread was stuck to begin with.

IMO, it will not mess up the time. Since it only updates the time when 
we can see progress (which is not a hang). If the task really hangs for 
a long time, then we can't perform the time update—so it will not mess 
up the time.

cc Lance and Andrew.
> 
> Perhaps it would be better to have a var in task_struct which would
> serve as an indicator of progress being made (e.g., last time stamp of
> said progress).
> 
> task_struct already has numerous holes so this would not have to grow it
> above what it is now.
> 
> 
>> This patch has passed the xfstests 'check -g quick' test based on ext4,
>> with no additional failures introduced.
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   fs/fs-writeback.c                | 13 +++++++++++--
>>   include/linux/backing-dev-defs.h |  1 +
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index a07b8cf73ae2..475d52abfb3e 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -14,6 +14,7 @@
>>    *		Additions for address_space-based writeback
>>    */
>>   
>> +#include <linux/sched/sysctl.h>
>>   #include <linux/kernel.h>
>>   #include <linux/export.h>
>>   #include <linux/spinlock.h>
>> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
>>   		kfree(work);
>>   	if (done) {
>>   		wait_queue_head_t *waitq = done->waitq;
>> +		/* Report progress to inform the hung task detector of the progress. */
>> +		bool force_wake = (jiffies - done->stamp) >
>> +				   sysctl_hung_task_timeout_secs * HZ / 2;
>>   
>>   		/* @done can't be accessed after the following dec */
>> -		if (atomic_dec_and_test(&done->cnt))
>> +		if (atomic_dec_and_test(&done->cnt) || force_wake)
>>   			wake_up_all(waitq);
>>   	}
>>   }
>> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>>   void wb_wait_for_completion(struct wb_completion *done)
>>   {
>>   	atomic_dec(&done->cnt);		/* put down the initial count */
>> -	wait_event(*done->waitq, !atomic_read(&done->cnt));
>> +	wait_event(*done->waitq, ({ done->stamp = jiffies; !atomic_read(&done->cnt); }));
>>   }
>>   
>>   #ifdef CONFIG_CGROUP_WRITEBACK
>> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_block *sb,
>>   		 */
>>   		__writeback_single_inode(inode, &wbc);
>>   
>> +		/* Report progress to inform the hung task detector of the progress. */
>> +		if (work->done && (jiffies - work->done->stamp) >
>> +		    HZ * sysctl_hung_task_timeout_secs / 2)
>> +			wake_up_all(work->done->waitq);
>> +
>>   		wbc_detach_inode(&wbc);
>>   		work->nr_pages -= write_chunk - wbc.nr_to_write;
>>   		wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;
>> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
>> index 2ad261082bba..c37c6bd5ef5c 100644
>> --- a/include/linux/backing-dev-defs.h
>> +++ b/include/linux/backing-dev-defs.h
>> @@ -63,6 +63,7 @@ enum wb_reason {
>>   struct wb_completion {
>>   	atomic_t		cnt;
>>   	wait_queue_head_t	*waitq;
>> +	unsigned long stamp;
>>   };
>>   
>>   #define __WB_COMPLETION_INIT(_waitq)	\
>> -- 
>> 2.39.5
>>

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

