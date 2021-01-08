Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDB2EF58D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 17:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbhAHQLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbhAHQLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:11:05 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E7C061381
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 08:10:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 14so9484257ilq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 08:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0QGPFasA/mlJ8O6Agjy43TljTX1e0tfJqweWTwBQCFU=;
        b=n9S3cb75C6AQyMA3YNYpDX2VpVNFC6yHQsWvikKFoDKLrApx61lf6wW7LIF2BUx3I6
         Rs059J9SohrXtAHaw5hh5XYS9f3qxdyHPKfYIDwS6Gj9pEzyntLiTWuGCX+fVjJ+OrfC
         /jZQW66aEXGJWXsD76p46GW2DD8X4jewww30FSG7RYD4SHc8gQtVLyKxpTTxhbCvK4GK
         jnZylauIPgRxAJVEVhZlwsS8lpocW7nQUJL47YyG1w+4B7Rcrt45l7ItLVYoU5R4nFUK
         GHrWSAbZru6d7oPHyOZCwCFrgn/g5nA2LU7hdmWUZD7ndB7FgKdlx+Df/zbfYFst7qIy
         iVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QGPFasA/mlJ8O6Agjy43TljTX1e0tfJqweWTwBQCFU=;
        b=VMfpiz27EFZH3kvzThI2+BAr3Q1kFCx8LcC6bdAikqbGtBRhsYegEYdLrv7FJHGVJN
         7yH9aZmyx2qvyjCLI4qeruJOz6PW2JXWM0Dqr591xJlzLncCxc04qX737kg39mKRDRMN
         mKX5wS5sGGnTInH8rLS51JkF7V3A6PoxE2QB3cucti24CevMBd8/WENAlAdxvstkCQK2
         x/s3c4RaFwG7g+d3Wr6Rnoh/M40QAvrWrijlin4qQNcY4T/pmP/6tsa/NvVZK19WB8l1
         29fWCv+vC2OvWDuS0mt5v1dh3n/r9Gc9aXup+RfzYFB+KW8Osj+JHA3UYGAYJbxIfxfr
         L3LA==
X-Gm-Message-State: AOAM530SDPN+xan2yKbWiCoAcqTQ5/6Yh1ziH5ogmCNMkb3lTOFcNI8M
        1isPfg3DjpTst5ty7rYfLf413w==
X-Google-Smtp-Source: ABdhPJxASBZFtWw19rWt+faqaOwMIaJNr1uVa5XJI4wu80lPXkgBxPOg236tQ7Bv5zcnoHLcv1VhKQ==
X-Received: by 2002:a92:4002:: with SMTP id n2mr4341557ila.293.1610122224353;
        Fri, 08 Jan 2021 08:10:24 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d5sm7419122ilf.33.2021.01.08.08.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 08:10:23 -0800 (PST)
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <20210108064639.GN3579531@ZenIV.linux.org.uk>
 <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
 <20210108155807.GQ3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41e33492-7b01-6801-cbb1-78ecef0c9fc0@kernel.dk>
Date:   Fri, 8 Jan 2021 09:10:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108155807.GQ3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/21 8:58 AM, Al Viro wrote:
> On Fri, Jan 08, 2021 at 08:13:25AM -0700, Jens Axboe wrote:
>>> Anyway, bedtime for me; right now it looks like at least for task ==
>>> current we always want TWA_SIGNAL.  I'll look into that more tomorrow
>>> when I get up, but so far it smells like switching everything to
>>> TWA_SIGNAL would be the right thing to do, if not going back to bool
>>> notify for task_work_add()...
>>
>> Before the change, the fact that we ran task_work off get_signal() and
>> thus processed even non-notify work in that path was a bit of a mess,
>> imho. If you have work that needs processing now, in the same manner as
>> signals, then you really should be using TWA_SIGNAL. For this pipe case,
>> and I'd need to setup and reproduce it again, the task must have a
>> signal pending and that would have previously caused the task_work to
>> run, and now it does not. TWA_RESUME technically didn't change its
>> behavior, it's still the same notification type, we just don't run
>> task_work unconditionally (regardless of notification type) from
>> get_signal().
> 
> It sure as hell did change behaviour.  Think of the effect of getting
> hit with SIGSTOP.  That's what that "bit of a mess" had been about.
> Work done now vs. possibly several days later when SIGCONT finally
> gets sent.
> 
>> I think the main question here is if we want to re-instate the behavior
>> of running task_work off get_signal(). I'm leaning towards not doing
>> that and ensuring that callers that DO need that are using TWA_SIGNAL.
> 
> Can you show the callers that DO NOT need it?

OK, so here's my suggestion:

1) For 5.11, we just re-instate the task_work run in get_signal(). This
   will make TWA_RESUME have the exact same behavior as before.

2) For 5.12, I'll prepare a patch that collapses TWA_RESUME and TWA_SIGNAL,
   turning it into a bool again (notify or no notify).

How does that sound?

-- 
Jens Axboe

