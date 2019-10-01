Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B978C398C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfJAPwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 11:52:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35953 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389736AbfJAPwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:52:32 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so49206443iof.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aYzikBcGz30F8nxgz2XYTBSTQs7V2hCd/C6EA7NzpBk=;
        b=a6Su93qUP+aKyezqwC9e8cP4OQnwhhnemV2uK/QN4Ile1m1o0yOByD+BVJWzXTeIKS
         4jtRnMyN2qbrCqIAxTfsUCwFdf8K5lmSdlrmTVkRecw7gzRn+RApQZPWRB7yt0xYAVkc
         rhHSpEiJ4g+XxGJZgWmM8PYbb1ulOU68ftoamqHBQvRMEMvuIr02AfyLIVM8/+ytBVi+
         iG1SWMcdsNMRBl4FMysO3n7jDF7xX50TXDrY7VTp0aPJIaVM53eNV3HTO83dVOhWqtRx
         Z3WmAI7l1pgYHnlm5AxO++P0SJi7gVYXQcBADI50RBZp0PruiuGgrA52vcM46ZEAu7Or
         jPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYzikBcGz30F8nxgz2XYTBSTQs7V2hCd/C6EA7NzpBk=;
        b=eLy59Twf5vMVLjUrTWMICUJtz1gsmhnq5aD2fBk+6nKtj8xkJwq7qGbwsls25tY0Ga
         WRd0/082SSpf5T/9Yb1wGhVH3TxqWKh7zJeAQpx0Ao0hW528fC37yk6SstUP1EKv2U0T
         vTeLP/uHIpJDnUEtmFhvB2bkU9paTzl0aKaDMnBOwX2rk3BxAKsHxuLEkz8xWqPg2Hzz
         2caN+EV+1+7Nw19DeywyNtd1xg4Jrp5W5VQSlXVkgH5sTvTxO4s97bz9T30uX9ifnTLg
         30LHa00NNyJlQjTxQPM3E4ZyFw5RfXdESgV9CeRaMXRzCJ2kQot1NmcI3S7m8FFI5W37
         FnFg==
X-Gm-Message-State: APjAAAUVbMPyqNrICa9YDR1cSo3KQMIYNfVVccTsUkgHq3YBZ83u8Uuc
        firRthExyt12NsmVe1/+AhzsgA==
X-Google-Smtp-Source: APXvYqzkyMvVedyfH87M6gwxSqGv62VcC/XAQUXbYPhwOc1GlVZzp8RgT74MDCZTAAXmRssujm0OPQ==
X-Received: by 2002:a02:cc53:: with SMTP id i19mr25466044jaq.10.1569945149751;
        Tue, 01 Oct 2019 08:52:29 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z10sm6873815iog.41.2019.10.01.08.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:52:28 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190930202055.1748710-1-arnd@arndb.de>
 <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
 <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
 <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
Date:   Tue, 1 Oct 2019 09:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/19 9:49 AM, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/1/19 8:09 AM, Jens Axboe wrote:
>>> On 9/30/19 2:20 PM, Arnd Bergmann wrote:
>>>> All system calls use struct __kernel_timespec instead of the old struct
>>>> timespec, but this one was just added with the old-style ABI. Change it
>>>> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
>>>> the need for compat handlers on 32-bit architectures.
>>>>
>>>> Any user space caller will have to use __kernel_timespec now, but this
>>>> is unambiguous and works for any C library regardless of the time_t
>>>> definition. A nicer way to specify the timeout would have been a less
>>>> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
>>>> change that as this would impact both 32-bit and 64-bit users.
>>>
>>> Thanks for catching that, Arnd. Applied.
>>
>> On second thought - since there appears to be no good 64-bit timespec
>> available to userspace, the alternative here is including on in liburing.
> 
> What's wrong with using __kernel_timespec? Just the name?
> I suppose liburing could add a macro to give it a different name
> for its users.

Just that it seems I need to make it available through liburing on
systems that don't have it yet. Not a big deal, though.

>> That seems kinda crappy in terms of API, so why not just use a 64-bit nsec
>> value as you suggest? There's on released kernel with this feature yet, so
>> there's nothing stopping us from just changing the API to be based on
>> a single 64-bit nanosecond timeout.
> 
> Certainly fine with me.
> 
>> +       timeout = READ_ONCE(sqe->addr);
>>          hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>          req->timeout.timer.function = io_timeout_fn;
>> -       hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
>> +       hrtimer_start(&req->timeout.timer, ns_to_ktime(timeout),
> 
> It seems a little odd to use the 'addr' field as something that's not
> an address,
> and I'm not sure I understand the logic behind when you use a READ_ONCE()
> as opposed to simply accessing the sqe the way it is done a few lines
> earlier.
> 
> The time handling definitely looks good to me.

One thing that struck me about this approach - we then lose the ability to
differentiate between "don't want a timed timeout" with ts == NULL, vs
tv_sec and tv_nsec both being 0.

I think I'll stuck with that you had and just use __kernel_timespec in
liburing.

-- 
Jens Axboe

