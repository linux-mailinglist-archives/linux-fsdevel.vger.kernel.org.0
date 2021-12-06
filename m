Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E624346A5AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 20:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbhLFTcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 14:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348418AbhLFTcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:32:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25113C061746
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 11:28:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so47165985eda.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Dec 2021 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9ZiLxDRvox/7+7uT5B6r8fj/Ckn8ePdbtP5hmNbGJY=;
        b=HJjTDHc3UjaUNTPIVOOVnUbpGgCogNDQooWwZ9O/V57A+tP75Hab+RYDHGRpjPTuXn
         hajCT1NJYhzXYGt78yI9LAiXfGE2dXqqjXIsBJ/vkyvWYhzi218EJ0XKmLXc/5UzttOx
         eWqFDZgPYDpwRoqIwBy8A+mpsZeMMbhzxrCBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9ZiLxDRvox/7+7uT5B6r8fj/Ckn8ePdbtP5hmNbGJY=;
        b=vQ9Xyq1IJN/goVBue0Jm8UQHoEc37N4MuwPfBaeNqPJQllYbxfGMiHmuPzTV/VkzDf
         uaeuxC9Mx+lIRAsyhMPyiHG7asocOly4h3phIOIuIxaGbeY7JR+9kDJIDYgm+jd5kCeK
         yxrHPjMZWHAXjC603C6JXVsqvqgToto2X01iMOI1JPwKeMTMiJwyMJGrKbtkMW3oe+3A
         90lBWxmSPYsSC5BwIK2Iopf5c3qQQ/ydsMfwHwKfHPqCdTTqenbXdTkuCWd5wnWweuYR
         tAmTkWLSasZgj4AI2houql8/uL59/Th5MqXQRnCTPa5oAO9G6WeO64gSkFS0EMDS74NX
         KZhA==
X-Gm-Message-State: AOAM530AKcxAw8boWUUIuAIAl8pdiFkcyoKUbWLXIJ000CJYBgtX8dJi
        UdAF+/LoPO/1aX3xqOQ2BhnCEb19+kMFQXoh
X-Google-Smtp-Source: ABdhPJxN5B4qoRz1En4i3DPvoVbsjOyTWwvmkWztO+wP2DB0MS9qjsFTjsuqRcBJZB47Kca9lXvWag==
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr48696743ejc.388.1638818912072;
        Mon, 06 Dec 2021 11:28:32 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id co10sm8466577edb.83.2021.12.06.11.28.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:28:30 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 133so9048262wme.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Dec 2021 11:28:30 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr730190wmq.26.1638818909838;
 Mon, 06 Dec 2021 11:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20211204002301.116139-1-ebiggers@kernel.org> <20211204002301.116139-3-ebiggers@kernel.org>
In-Reply-To: <20211204002301.116139-3-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Dec 2021 11:28:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJ+6qgbB+WCDosxOgDp34ybncUwPJ5Evo8gcXptfzF+Q@mail.gmail.com>
Message-ID: <CAHk-=wgJ+6qgbB+WCDosxOgDp34ybncUwPJ5Evo8gcXptfzF+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] aio: fix use-after-free due to missing POLLFREE handling
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 4:23 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> require another solution.  This solution is for the queue to be cleared
> before it is freed, using 'wake_up_poll(wq, EPOLLHUP | POLLFREE);'.

Ugh.

I hate POLLFREE, and the more I look at this, the more I think it's broken.

And that

        wake_up_poll(wq, EPOLLHUP | POLLFREE);

in particular looks broken - the intent is that it should remove all
the wait queue entries (because the wait queue head is going away),
but wake_up_poll() iself actually does

        __wake_up(x, TASK_NORMAL, 1, poll_to_key(m))

where that '1' is the number of exclusive entries it will wake up.

So if there are two exclusive waiters, wake_up_poll() will simply stop
waking things up after the first one.

Which defeats the whole POLLFREE thing too.

Maybe I'm missing something, but POLLFREE really is broken.

I'd argue that all of epoll() is broken, but I guess we're stuck with it.

Now, it's very possible that nobody actually uses exclusive waits for
those wait queues, and my "nr_exclusive" argument is about something
that isn't actually a bug in reality. But I think it's a sign of
confusion, and it's just another issue with POLLFREE.

I really wish we could have some way to not have epoll and aio mess
with the wait-queue lists and cache the wait queue head pointers that
they don't own.

In the meantime, I don't think these patches make things worse, and
they may fix things. But see above about "nr_exclusive" and how I
think wait queue entries might end up avoiding POLLFREE handling..

                  Linus
