Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A0228975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGUTsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbgGUTsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:48:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD0C0619DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 12:48:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d7so1937766plq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UUqZmjgdo9ykriUF/GuqAUCJ9QXVmG7xeNk5lX9ipg4=;
        b=1J19NgJz3/rK7I31B00sZF6r5LMVhqYTdmvj+8EWMAny8GgrJ287L3M+LIrXJe10br
         zZYRXpQeN2xdSgf0w8Xx98Eqgx8cbd4a5jwYw05Vuzo10ZdvinLnHNVHEsLbOrgRw5eg
         CasK1exaFIlzudv0MPxgjsw6e8Y+p7NynEltm0D8OVmDok2dDux2Bqm836QWWqdyqODE
         tWLjYmtpsynCPNdnecS0oJOUow8YMgzH/4xaStADsx1VFyUNXVEY51lueGtxr2jfOwLI
         eUeHAIbwF8ULOjMDnfQaPbQ251jSL9P0m9q4153z9qq18KIR18j3WPtCa0aeT0EEOTee
         /K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUqZmjgdo9ykriUF/GuqAUCJ9QXVmG7xeNk5lX9ipg4=;
        b=p6rHfYFFkG8eBxgWqLXo4gZJb1sX5w+SHYg0+RMwXmkRsSXF9l/t1RBscjI9lWphef
         TiPX0LD//YfIcWY2DHLgvMe5HrH0x8859LFYDFYJWI7eV1bQ5P9C0bucgiQ2xhprepzT
         7P5A0UCiSeF9G9e5FTHYAZGe2jtYGX5+fovUY0/RlQKofVQUm2vF4djN1oRWpFUu9NuO
         4ArgrFB5FxqiEuHeC0tVtTHePewvo7oOsda1sXDFMmLc7WYCZixHSQzrRTBX32EIcOT9
         /J/N7PkULcoXI/B8M+fQotEbvhaOyy+4XyAlVl+buTSWTb7rdodN7Bq6BKLjxDz+6AaI
         Nmng==
X-Gm-Message-State: AOAM532K00JZisS3tGx2jWIqK8m049yyWMRIUM9To/gFb4S4NmhN88qi
        Dse5qOyIWW+ehTwewz05vS80Mg==
X-Google-Smtp-Source: ABdhPJwlDQfd5cuBNL1ACBG1kwWp8gefHkeSzrDCn5tqmtohlMFcS+FN1TP/waCGpEMLoNU0HmSbYw==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr6699673pjb.224.1595360889144;
        Tue, 21 Jul 2020 12:48:09 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b21sm21601232pfp.172.2020.07.21.12.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:48:08 -0700 (PDT)
Subject: Re: strace of io_uring events?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andres Freund <andres@anarazel.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
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
 <39a3378a-f8f3-6706-98c8-be7017e64ddb@kernel.dk>
 <CALCETrXAxFzuRB5EJZR7bbgfrEcNc=9_E7wwhPaZ3YGJ1=DZ0w@mail.gmail.com>
 <ba989463-c627-8af7-9234-4dc8ac4eea0e@kernel.dk>
 <CALCETrUvOuKZWiQeZhf9DXyjS4OQdyW+s1YMh+vwe605jBS3LQ@mail.gmail.com>
 <65ad6c17-37d0-da30-4121-43554ad8f51f@kernel.dk>
 <CALCETrV_tOziNJOp8xanmCU0yJEHcGQk0TBxeiK4U7AVewkgAw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f0d61a4-f9c1-6978-5897-9e50a8f212f4@kernel.dk>
Date:   Tue, 21 Jul 2020 13:48:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV_tOziNJOp8xanmCU0yJEHcGQk0TBxeiK4U7AVewkgAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/20 1:44 PM, Andy Lutomirski wrote:
> On Tue, Jul 21, 2020 at 11:39 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/21/20 11:44 AM, Andy Lutomirski wrote:
>>> On Tue, Jul 21, 2020 at 10:30 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 7/21/20 11:23 AM, Andy Lutomirski wrote:
>>>>> On Tue, Jul 21, 2020 at 8:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 7/21/20 9:27 AM, Andy Lutomirski wrote:
>>>>>>> On Fri, Jul 17, 2020 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Thu, Jul 16, 2020 at 08:12:35AM -0700, Kees Cook wrote:
>>>>>>>>> On Thu, Jul 16, 2020 at 03:14:04PM +0200, Stefano Garzarella wrote:
>>>>>>>
>>>>>>>>> access (IIUC) is possible without actually calling any of the io_uring
>>>>>>>>> syscalls. Is that correct? A process would receive an fd (via SCM_RIGHTS,
>>>>>>>>> pidfd_getfd, or soon seccomp addfd), and then call mmap() on it to gain
>>>>>>>>> access to the SQ and CQ, and off it goes? (The only glitch I see is
>>>>>>>>> waking up the worker thread?)
>>>>>>>>
>>>>>>>> It is true only if the io_uring istance is created with SQPOLL flag (not the
>>>>>>>> default behaviour and it requires CAP_SYS_ADMIN). In this case the
>>>>>>>> kthread is created and you can also set an higher idle time for it, so
>>>>>>>> also the waking up syscall can be avoided.
>>>>>>>
>>>>>>> I stared at the io_uring code for a while, and I'm wondering if we're
>>>>>>> approaching this the wrong way. It seems to me that most of the
>>>>>>> complications here come from the fact that io_uring SQEs don't clearly
>>>>>>> belong to any particular security principle.  (We have struct creds,
>>>>>>> but we don't really have a task or mm.)  But I'm also not convinced
>>>>>>> that io_uring actually supports cross-mm submission except by accident
>>>>>>> -- as it stands, unless a user is very careful to only submit SQEs
>>>>>>> that don't use user pointers, the results will be unpredictable.
>>>>>>
>>>>>> How so?
>>>>>
>>>>> Unless I've missed something, either current->mm or sqo_mm will be
>>>>> used depending on which thread ends up doing the IO.  (And there might
>>>>> be similar issues with threads.)  Having the user memory references
>>>>> end up somewhere that is an implementation detail seems suboptimal.
>>>>
>>>> current->mm is always used from the entering task - obviously if done
>>>> synchronously, but also if it needs to go async. The only exception is a
>>>> setup with SQPOLL, in which case ctx->sqo_mm is the task that set up the
>>>> ring. SQPOLL requires root privileges to setup, and there's no task
>>>> entering the io_uring at all necessarily. It'll just submit sqes with
>>>> the credentials that are registered with the ring.
>>>
>>> Really?  I admit I haven't fully followed how the code works, but it
>>> looks like anything that goes through the io_queue_async_work() path
>>> will use sqo_mm, and can't most requests that end up blocking end up
>>> there?  It looks like, even if SQPOLL is not set, the mm used will
>>> depend on whether the request ends up blocking and thus getting queued
>>> for later completion.
>>>
>>> Or does some magic I missed make this a nonissue.
>>
>> No, you are wrong. The logic works as I described it.
> 
> Can you enlighten me?  I don't see any iov_iter_get_pages() calls or
> equivalents.  If an IO is punted, how does the data end up in the
> io_uring_enter() caller's mm?

If the SQE needs to be punted to an io-wq worker, then
io_prep_async_work() is ultimately called before it's queued with the
io-wq worker. That grabs anything we need to successfully process this
request, user access and all. io-wq then assumes the right "context" to
performn that request. As the async punt is always done on behalf of the
task that is submitting the IO (via io_uring_enter()), that is the
context that we grab and use for that particular request.

You keep looking at ctx->sqo_mm, and I've told you several times that
it's only related to the SQPOLL thread. If you don't use SQPOLL, no
request will ever use it.

-- 
Jens Axboe

