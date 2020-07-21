Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029B02283D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGUPb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgGUPb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:31:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E4C0619DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 08:31:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so16735033ilk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHBXXvobeCMI6ndgKtMZ3erxdMcJPIdl8aMUBZkOTPQ=;
        b=FjGoLNE3u7Lnj6Y4gzoT0kgYXHm5TPhi7odJEJ19IH/bXifIJkm9g9cRYI1n9gNuSu
         q8PssjRLHeidmWFf4uLpcuAYGmRmaf89V572BB2JHkU1x19AUKNTC+k2xOn6qyRI9n0C
         qmt5Am2rGnwheI/zqG93vJNWkUiYQqwIo0DFKcDPZrvGsrwwC0EEwGut5OC5+QkAoPOX
         BI6Zfk31k5IlcnMFpxsqIjhd1aDaR8T90B0zI79dBIwKvQX13ndd1DCNVRjdlGQj0Vd+
         vDdcbnaBPAIYK0k1jvm+zwdwTjBqn675UdeHBWGIZ+Ey9zJ+n2NfmxiGLL3ZMmSJdVeP
         K3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHBXXvobeCMI6ndgKtMZ3erxdMcJPIdl8aMUBZkOTPQ=;
        b=sP7lcN72Ep6zbVV0WfE9j20xZOkBjnIHSLNnDocnvgfaSfjl0iwaeTjBkSshOi0ghQ
         OAwvA9dOsPrQgs8NLB0rUmp3BmP3zp0X5pFlt/X8ismVMhmuLtTZIUvIweGj6oiCQAsN
         sxgq+ahjRTjHREWlSKA8ywQHOJYUGlrjKRNBD4gffIW/ZHmCVo7t3nL2xjvUj/0upthB
         BHI+0BD6sIJY+GiQy+eIrIXd/G0rQdFg1kqrDegFZTHQ63X43phr9/uTs4s84moGjkK/
         5FxApKg6hLTHxPkHe8n/8Oqz+OrWTRcvm2gltR4RKfi0LQjtRHKgWURfPvoI0yS+A/er
         QCig==
X-Gm-Message-State: AOAM530IxwsFYPGNX7BKq7hQ/nqYhO0fBnafAyqiHsGPmgDBRiZCqFGj
        HYu/OuHRVmF18JiuqU3wShWeOg==
X-Google-Smtp-Source: ABdhPJwAbVMoY1B6CkpkY+SnENst9lHtwiSu0YeTTONrlnZk8tl2yQygzkpN0KPaRXZ9cUJSYa4n6Q==
X-Received: by 2002:a05:6e02:e05:: with SMTP id a5mr26782990ilk.92.1595345517510;
        Tue, 21 Jul 2020 08:31:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c3sm10507002ilj.31.2020.07.21.08.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:31:56 -0700 (PDT)
Subject: Re: strace of io_uring events?
To:     Andy Lutomirski <luto@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook> <20200716131404.bnzsaarooumrp3kx@steredhat>
 <202007160751.ED56C55@keescook>
 <20200717080157.ezxapv7pscbqykhl@steredhat.lan>
 <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39a3378a-f8f3-6706-98c8-be7017e64ddb@kernel.dk>
Date:   Tue, 21 Jul 2020 09:31:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/20 9:27 AM, Andy Lutomirski wrote:
> On Fri, Jul 17, 2020 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Jul 16, 2020 at 08:12:35AM -0700, Kees Cook wrote:
>>> On Thu, Jul 16, 2020 at 03:14:04PM +0200, Stefano Garzarella wrote:
> 
>>> access (IIUC) is possible without actually calling any of the io_uring
>>> syscalls. Is that correct? A process would receive an fd (via SCM_RIGHTS,
>>> pidfd_getfd, or soon seccomp addfd), and then call mmap() on it to gain
>>> access to the SQ and CQ, and off it goes? (The only glitch I see is
>>> waking up the worker thread?)
>>
>> It is true only if the io_uring istance is created with SQPOLL flag (not the
>> default behaviour and it requires CAP_SYS_ADMIN). In this case the
>> kthread is created and you can also set an higher idle time for it, so
>> also the waking up syscall can be avoided.
> 
> I stared at the io_uring code for a while, and I'm wondering if we're
> approaching this the wrong way. It seems to me that most of the
> complications here come from the fact that io_uring SQEs don't clearly
> belong to any particular security principle.  (We have struct creds,
> but we don't really have a task or mm.)  But I'm also not convinced
> that io_uring actually supports cross-mm submission except by accident
> -- as it stands, unless a user is very careful to only submit SQEs
> that don't use user pointers, the results will be unpredictable.

How so? 

> Perhaps we can get away with this:
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 74bc4a04befa..92266f869174 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -7660,6 +7660,20 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int,
> fd, u32, to_submit,
>      if (!percpu_ref_tryget(&ctx->refs))
>          goto out_fput;
> 
> +    if (unlikely(current->mm != ctx->sqo_mm)) {
> +        /*
> +         * The mm used to process SQEs will be current->mm or
> +         * ctx->sqo_mm depending on which submission path is used.
> +         * It's also unclear who is responsible for an SQE submitted
> +         * out-of-process from a security and auditing perspective.
> +         *
> +         * Until a real usecase emerges and there are clear semantics
> +         * for out-of-process submission, disallow it.
> +         */
> +        ret = -EACCES;
> +        goto out;
> +    }
> +
>      /*
>       * For SQ polling, the thread will do all submissions and completions.
>       * Just return the requested submit count, and wake the thread if

That'll break postgres that already uses this, also see:

commit 73e08e711d9c1d79fae01daed4b0e1fee5f8a275
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sun Jan 26 09:53:12 2020 -0700

    Revert "io_uring: only allow submit from owning task"

So no, we can't do that.

-- 
Jens Axboe

