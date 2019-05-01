Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACB10936
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEAOjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:39:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45074 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfEAOjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:39:09 -0400
Received: by mail-io1-f68.google.com with SMTP id e8so14938621ioe.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+YD+tuNUu91Iyn44JKrPk1BpBj3AFej76i6TR02JAo=;
        b=Mb5SfcdGZ7NwMGa+u2H81mJzlRgcWxVTgOQf2JfO2aYQw1zjEu1szFJVDjB87TGH4x
         pJfFKUOZGQj4oiId7YdGqExzikcv5VqeTqH2D1Ot/toybyEjspGC7ZI4H5q7eMNqKiBf
         x2XydqD+X32kO1ueEEPdp7WCV7FTQa6lOoIM1TPpgv+ysV9KF16cStjlxcB2Os62ZBk+
         qOVHpEBRx2jkn5iOhHiEa/Jlbz7+/0ZCwXdjTWV+13f2kLottlfRr1T103PdPC9zw/Rr
         oe1JgH8NrXcuLwcorL2wUSvFkG8GsHJLvU6t1xTI/7w7+qIEy0FiHb49n7F8X1P6CRLH
         aMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+YD+tuNUu91Iyn44JKrPk1BpBj3AFej76i6TR02JAo=;
        b=lj7MnlmPPk/8CgQbQFncFSsm5TvFwzkyKhlfzW3LdDZfPWj0GKueGEOO/ErJXkBdTE
         WS0sYSZSw4P37vI4oYKn/+VB87cpUwYTZ6VL6OQfvDVCbSbjp62YQw2mSP6GeC4WEcnL
         o5jAKYChR8e1BHjO5YMxjOGDjCmnE5NRLRHPi5lo+n9OC0gryYyuH/RdZm6LV942HZ09
         FmAzFrJEqZ+NP0yJjjlv5iVgRiK/rHVa0vtPmV+BkGZiR4CFAMCOxtKp06NU6QdVbA40
         B9P6ocxYRe2551ebeyNhW3N3DSf1rp5BeU2hyVV4cNcTMzBx5zTEyvYXY1y26l8MCINg
         bGEA==
X-Gm-Message-State: APjAAAW9+YPX9SdcmhT8UucSbA7KiHlrjx/7qXZCyCGLvR3f4aBmN46Y
        Z2lWXREKV4kXrJbvt6umXrmx2ONF24HgeA==
X-Google-Smtp-Source: APXvYqx6pDQDS4TCOe+Ri8MN90Jo7ttqTVw+2uGZv35CzzHRRIwMxW3ql1o0w0s72Ub9kKtFxIUENA==
X-Received: by 2002:a5e:920c:: with SMTP id y12mr23987279iop.65.1556721548131;
        Wed, 01 May 2019 07:39:08 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b8sm7629245ior.5.2019.05.01.07.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:39:07 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu
 instead of cpu_possible()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Shenghui Wang <shhuiw@foxmail.com>, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501072430.6674-1-shhuiw@foxmail.com>
 <x49wojaxuaa.fsf@segfault.boston.devel.redhat.com>
 <cd55b1e4-9395-a8b7-707e-ceed9d6c0c15@kernel.dk>
 <x49o94mxn1w.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bcf4aa58-ec09-3d73-89f8-fdfdc3ea2896@kernel.dk>
Date:   Wed, 1 May 2019 08:39:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <x49o94mxn1w.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 8:32 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 5/1/19 5:56 AM, Jeff Moyer wrote:
>>> Shenghui Wang <shhuiw@foxmail.com> writes:
>>>
>>>> This issue is found by running liburing/test/io_uring_setup test.
>>>>
>>>> When test run, the testcase "attempt to bind to invalid cpu" would not
>>>> pass with messages like:
>>>>    io_uring_setup(1, 0xbfc2f7c8), \
>>>> flags: IORING_SETUP_SQPOLL|IORING_SETUP_SQ_AFF, \
>>>> resv: 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000, \
>>>> sq_thread_cpu: 2
>>>>    expected -1, got 3
>>>>    FAIL
>>>>
>>>> On my system, there is:
>>>>    CPU(s) possible : 0-3
>>>>    CPU(s) online   : 0-1
>>>>    CPU(s) offline  : 2-3
>>>>    CPU(s) present  : 0-1
>>>>
>>>> The sq_thread_cpu 2 is offline on my system, so the bind should fail.
>>>> But cpu_possible() will pass the check. We shouldn't be able to bind
>>>> to an offline cpu. Use cpu_online() to do the check.
>>>>
>>>> After the change, the testcase run as expected: EINVAL will be returned
>>>> for cpu offlined.
>>>>
>>>> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
>>>> ---
>>>>  fs/io_uring.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 0e9fb2cb1984..aa3d39860a1c 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -2241,7 +2241,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>>>  	ctx->sqo_mm = current->mm;
>>>>  
>>>>  	ret = -EINVAL;
>>>> -	if (!cpu_possible(p->sq_thread_cpu))
>>>> +	if (!cpu_online(p->sq_thread_cpu))
>>>>  		goto err;
>>>>  
>>>>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
>>>> @@ -2258,7 +2258,7 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>>>>  
>>>>  			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
>>>>  			ret = -EINVAL;
>>>> -			if (!cpu_possible(p->sq_thread_cpu))
>>>> +			if (!cpu_online(p->sq_thread_cpu))
>>>>  				goto err;
>>>>  
>>>>  			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
>>>
>>> Hmm.  Why are we doing this check twice?  Oh... Jens, I think you
>>> braino'd commit 917257daa0fea.  Have a look.  You probably wanted to get
>>> rid of the first check for cpu_possible.
>>
>> Added a fixup patch the other day:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=362bf8670efccebca22efda1ee5a5ee831ec5efb
> 
> @@ -2333,13 +2329,14 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>  			ctx->sq_thread_idle = HZ;
>  
>  		if (p->flags & IORING_SETUP_SQ_AFF) {
> -			int cpu;
> +			int cpu = p->sq_thread_cpu;
>  
> -			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
>  			ret = -EINVAL;
> -			if (!cpu_possible(p->sq_thread_cpu))
> +			if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
>  				goto err;
>  
> +			cpu = array_index_nospec(cpu, nr_cpu_ids);
> +
> 
> Why do you do the array_index_nospec last?  Why wouldn't that be written
> as:
> 
> 	if (p->flags & IORING_SETUP_SQ_AFF) {
> 		int cpu = array_index_nospec(p->sq_thread_cpu, nr_cpu_ids);
> 
> 		ret = -EINVAL;
> 		if (!cpu_possible(cpu))
> 			goto err;
> 
> 		ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
> 						ctx, cpu,
> 						"io_uring-sq");
> 	} else {
> ...
> 
> That would take away some head-scratching for me.

Agree, I've cleaned it up, it was a bit of a mess.

-- 
Jens Axboe

