Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6DFC986
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 16:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNPJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 10:09:07 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46633 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:09:06 -0500
Received: by mail-il1-f194.google.com with SMTP id q1so5612280ile.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2j0EPjGobhr4xFurUZmwA56VdxnETyuqnOI12SDj02Y=;
        b=PYxId9bG0udRhCD33Keyp/6wzavyydcKAD4odnsunUI4Fe0odB+7kgAmLgTwkFF0QX
         H1LHt3EmQzkuMJDvoORsiY0mEhJZWcR5Vv3+BVxIcTnA24YYtNbNsylyiOZVjsKomRFN
         JtTSLAkjg4hl+6wsD/Q00O/6drDvXbI9tLUJOMdj7in4dg/hPNRu/X9937fU7IffRVe1
         edPLu7EzMx2Yg2qMP3G3r97CPT9dNQRIDFeB4GTn387erRiLUkBq0a9cgU6+fLJ8DL2f
         INqrvsQq5TNeELquwkNNFabl6DnDv5pBeBlTPDh+leQ4BuOT0VkVvc6CFU0KkjQ3/0e4
         TLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2j0EPjGobhr4xFurUZmwA56VdxnETyuqnOI12SDj02Y=;
        b=sGwKk4qL06soZGDyiBzWgfjSaXdPTUhWYOH0F6THaAQO5/+HCeMt8tEeXxee+vs+/C
         LasUvYa/CCqP6WIHeHAPavP2SdcwBvjMaK+SIPJbvXiyiSTK/wwPPt82mXp//auVC3Zg
         emCYqo/5uyLp3N4ldx2pst/vS1tgafuX1WnzcK+1FWI/r386CD/m/5+YTAxpQTGVEPiC
         G7BZpAhjkPkFmiB0xMBPgAvvy5Lrem6cEwHhGbwlSBoKV6qP+z6LpF8Rfi1+j11y64Fp
         Uvniey2XONdRKtVfiNcDglNl0BqVCD0L92F9XK3SxEuhYBgIb0Jll5afvNt+yJj0WqDF
         iefg==
X-Gm-Message-State: APjAAAU9qLXVFHDXC6O+Gimm6g1qulQMolrmhnbv4C8Mc8tM5pjRZih/
        c7cdoSeToBjxmZcIFA53fh7k+g==
X-Google-Smtp-Source: APXvYqyQCtMg9lvlrbwi26iaROC57zGLPnWt7r00eGmlTCiG/2fkHoEYNUpejHVgj6WsJxxnHbs1+A==
X-Received: by 2002:a92:9198:: with SMTP id e24mr10436679ill.184.1573744145554;
        Thu, 14 Nov 2019 07:09:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l63sm502363ioa.19.2019.11.14.07.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:09:04 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
 <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
Date:   Thu, 14 Nov 2019 08:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/19 7:12 AM, Rasmus Villemoes wrote:
> On 14/11/2019 14.46, Jann Horn wrote:
>> On Thu, Nov 14, 2019 at 10:20 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>> On 14/11/2019 05.49, Jens Axboe wrote:
>>>> On 11/13/19 9:31 PM, Jens Axboe wrote:
>>>>> This is a case of "I don't really know what I'm doing, but this works
>>>>> for me". Caveat emptor, but I'd love some input on this.
>>>>>
>>>>> I got a bug report that using the poll command with signalfd doesn't
>>>>> work for io_uring. The reporter also noted that it doesn't work with the
>>>>> aio poll implementation either. So I took a look at it.
>>>>>
>>>>> What happens is that the original task issues the poll request, we call
>>>>> ->poll() (which ends up with signalfd for this fd), and find that
>>>>> nothing is pending. Then we wait, and the poll is passed to async
>>>>> context. When the requested signal comes in, that worker is woken up,
>>>>> and proceeds to call ->poll() again, and signalfd unsurprisingly finds
>>>>> no signals pending, since it's the async worker calling it.
>>>>>
>>>>> That's obviously no good. The below allows you to pass in the task in
>>>>> the poll_table, and it does the right thing for me, signal is delivered
>>>>> and the correct mask is checked in signalfd_poll().
>>>>>
>>>>> Similar patch for aio would be trivial, of course.
>>>>
>>>>  From the probably-less-nasty category, Jann Horn helpfully pointed out
>>>> that it'd be easier if signalfd just looked at the task that originally
>>>> created the fd instead. That looks like the below, and works equally
>>>> well for the test case at hand.
>>>
>>> Eh, how should that work? If I create a signalfd() and fork(), the
>>> child's signalfd should only be concerned with signals sent to the
>>> child. Not to mention what happens after the parent dies and the child
>>> polls its fd.
>>>
>>> Or am I completely confused?
>>
>> I think the child should not be getting signals for the child when
>> it's reading from the parent's signalfd. read() and write() aren't
>> supposed to look at properties of `current`.
> 
> That may be, but this has always been the semantics of signalfd(), quite
> clearly documented in 'man signalfd'.
> 
>> Of course, if someone does rely on the current (silly) semantics, this
>> might break stuff.
> 
> That, and Jens' patch only seemed to change the poll callback, so the
> child (or whoever else got a hand on that signalfd) would wait for the
> parent to get a signal, but then a subsequent read would attempt to
> dequeue from the child itself.
> 
> So, I can't really think of anybody that might be relying on inheriting
> a signalfd instead of just setting it up in the child, but changing the
> semantics of it now seems rather dangerous. Also, I _can_ imagine
> threads in a process sharing a signalfd (initial thread sets it up and
> blocks the signals, all threads subsequently use that same fd), and for
> that case it would be wrong for one thread to dequeue signals directed
> at the initial thread. Plus the lifetime problems.

What if we just made it specific SFD_CLOEXEC? I don't want to break
existing applications, even if the use case is nonsensical, but it is
important to allow signalfd to be properly used with use cases that are
already in the kernel (aio with IOCB_CMD_POLL, io_uring with
IORING_OP_POLL_ADD). Alternatively, if need be, we could add a specific
SFD_ flag for this. Might also help with applications knowing if this
will work with io_uring/aio at all.

-- 
Jens Axboe

