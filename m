Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB73E05F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhHDQbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhHDQbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:31:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F842C061798
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 09:31:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x8so5493042lfe.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mbke9nvjw7+ZeekiQRXLpz0LVFhUcu96Nb3OTfXE7BU=;
        b=PZ1SUNe5srVpzwzOaifNxeDnFelZQ09VVBF0S+czoEleI8H7NaXtf6BgmLYsKuLNiC
         LTcU8OYPWLuF/4NphS6i+l1ci/XnoMb+i+upOTt69bQAT3JgDhcod/J5a5/zqAWUQ5CE
         n8TsxAIOFru99StbsoS1slJejG91rgTWWoOlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mbke9nvjw7+ZeekiQRXLpz0LVFhUcu96Nb3OTfXE7BU=;
        b=rg54PlVZDA8o9GvvnnS/aL8cAu0agmTvBao6Eym2IAWKZZ7BB2TAthYqD+bwoEvUSJ
         +g1Kqco+aGsc0Gsp4QqSCQg3O02myfnR8tBqOnCK413hMttPLzgJmhiCKDu5azJI9uVw
         x5aYbZs3rvIq1V1l++6/IEooaG4Khw/o/acrstjjBV0bYs7DgieXfI+vqjg5gg+KhhUk
         AitpR/m6dqnncrhhrF48Xee6p3yVUAdxsSaSN1UdEEkV5EFful6+TgReZ/zgcNZrIuLp
         qqB/Z6KgIX2eMlw50rXS8ENv38KOPpFWT3hy0sROhmnthM7SDYSwJ8HAswlKrmlt1/bl
         8oXw==
X-Gm-Message-State: AOAM530Cy2n4TIPRFI5kHr3pM72mCOjzHIvDi4tmLimO0GYnLqRhBty1
        10GaqmY+CONZ1LrysrAdw1Evdk7yPM43o7lv
X-Google-Smtp-Source: ABdhPJwJmjIDmb+UACZlHZ8UL4ggn4ykFTAa64fIBBIMZERRtl/7BWtfpM0eg3yE2p+2tuPxxEmNJw==
X-Received: by 2002:a19:c10c:: with SMTP id r12mr88528lff.522.1628094685394;
        Wed, 04 Aug 2021 09:31:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z13sm197737ljk.39.2021.08.04.09.31.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:31:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b6so5416182lff.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 09:31:18 -0700 (PDT)
X-Received: by 2002:a19:fc06:: with SMTP id a6mr62531lfi.377.1628094677755;
 Wed, 04 Aug 2021 09:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <1628086770.5rn8p04n6j.none.ref@localhost> <1628086770.5rn8p04n6j.none@localhost>
In-Reply-To: <1628086770.5rn8p04n6j.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Aug 2021 09:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
Message-ID: <CAHk-=wiLr55zHUWNzmp3DeoO0DUaYp7vAzQB5KUCni5FpwC7Uw@mail.gmail.com>
Subject: Re: [REGRESSION?] Simultaneous writes to a reader-less, non-full pipe
 can hang
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, acrichton@mozilla.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Your program is buggy.

On Wed, Aug 4, 2021 at 8:37 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
>     pipe(pipefd);
>     printf("init buffer: %d\n", fcntl(pipefd[1], F_GETPIPE_SZ));
>     printf("new buffer:  %d\n", fcntl(pipefd[1], F_SETPIPE_SZ, 0));

Yeah, what did you expect this to do? You said you want a minimal
buffer, you get a really small buffer.

Then you try to write multiple messages to the pipe that you just said
should have a minimum size.

Don't do that then.

> /proc/x/stack shows that the remaining thread is hanging at pipe.c:560.
> It looks like not only there needs to be space in the pipe, but also
> slots.

Correct. The fullness of a pipe is not about whether it has the
possibility of merging more bytes into an existing not-full slot, but
about whether it has empty slots left.

Part of that is simply the POSIX pipe guarantees - a write of size
PIPE_BUF or less is guaranteed to be atomic, so it mustn't be split
among buffers.

So a pipe must not be "writable" unless it has space for at least that
much (think select/poll, which don't know the size of the write).

The fact that we might be able to reuse a partially filled buffer for
smaller writes is simply not relevant to that issue.

And yes, we could have different measures of "could write" for
different writes, but we just don't have or want that complexity.

Please don't mess with F_SETPIPE_SZ unless you have a really good
reason to do so, and actually understand what you are doing.

Doing a F_SETPIPE_SZ, 0 basically means "I want the mimimum pipe size
possible". And that one accepts exactly one write at a time.

Of course, the exact semantics are much more complicated than that
"exactly one write". The pipe write code will optimistically merge
writes into a previous buffer, which means that depending on the
pattern of your writes, the exact number of bytes you can write will
be very different.

But that "merge writes into a previous buffer" only appends to the
buffer - not _reuse_ it - so when each buffer is one page in size,
what happens is that you can merge up to 4096 bytes worth of writes,
but then after that the pipe write will want a new buffer - even if
the old buffer is now empty because of old reads.

That's why your test program won't block immediately: both writers
will actually start out happily doing writes into that one buffer that
is allocated, but at some point that buffer ends, and it wants to
allocate a new buffer.

But you told it not to allocate more buffers, and the old buffer is
never completely empty because your readers never read _everythign_,
so it will hang, waiting for you to empty the one minimal buffer it
allocated. And that will never happen.

There's a very real reason why we do *not* by default say "pipes can
only ever use only one buffer".

I don't think this is a regression, but if you have an actual
application - not a test program - that does crazy things like this
and used to work (I'm not sure it has ever worked, though), we can
look into making it work again.

That said, I suspect the way to make it work is to just say "the
minimum pipe size is two slots" rather than change the "we want at
least one empty slot". Exactly because of that whole "look, we must
not consider a pipe that doesn't have a slot writable".

Because clearly people don't understand how subtle F_SETPIPE_SZ is.
It's not really a "byte count", even though that is how it's
expressed.

                   Linus
