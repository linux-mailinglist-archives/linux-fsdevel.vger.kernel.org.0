Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71B7AC42C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIWRtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 13:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjIWRtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:49:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477FB136
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso65559101fa.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695491351; x=1696096151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKJoZzk5+TuDNioAs1hxZJOGkwfd9HbCqvFh7/jI5HQ=;
        b=ah+tIVo4GWOwuIaQWDrdH1iv16AqZMMppB7+4Ljk46kbqgwYo8e7NIC1ICldB9l+l/
         /D0T3Tj4SuCCQENGqZ4O9RzVAFN5VpOFNOYlrIctl8/oK04WonJLgARDFcJvDV8N0rmH
         6V3dsnQLq5oYsmvvsYy/fbLS5KtW2Zo+ndMkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695491351; x=1696096151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKJoZzk5+TuDNioAs1hxZJOGkwfd9HbCqvFh7/jI5HQ=;
        b=Vr2QSjeO8ADIsYq/ZvQGPHz7U2RZQ5vpWHcRy8cdsT0fpEm6twdaaYBdC5/9c8icGr
         HAEC7cc+78PSPXsVsJbRhXoUAv8YFqiWmHsJMvG6xVHRClFhmVxyDUMRBApvbT+l4xXH
         0RNpL5JqgvKQt5o9C7O+TWxTdk5r1eaepYfnrQNd+9h/wuNsZxgt4c6IVw+vjDBYPQBr
         j3bJfauX9z7OY+GriHwKtWY+A9VlzjP5jMJpUp1XehyUhorztfGVk9KdE4zrK4riQgBH
         ZEIDyFfp38I2Tvh9o26u7JUPopc9wH+f/8Umh9zhsimXPgpQWmSMGx967yGulkAI3wy/
         9wuA==
X-Gm-Message-State: AOJu0YypjRJosy94+rdb68tmb95U58GaX+CZR0fsO+GrAkp9B5/+90vR
        Sc7QluNY9mOVfpGjqgL2rKvbBTbRt39P709FOhzTPROL
X-Google-Smtp-Source: AGHT+IHedahLvVVBIADSFTAcdkMV+qAIA+NWnjHrqveDpKe9yFIoV8pDs7D8Pgem3V3TPnnKncJPOw==
X-Received: by 2002:a2e:808c:0:b0:2bc:d38e:b500 with SMTP id i12-20020a2e808c000000b002bcd38eb500mr2249418ljg.42.1695491351134;
        Sat, 23 Sep 2023 10:49:11 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y2-20020a2eb002000000b002bcbc62dc22sm1430560ljk.86.2023.09.23.10.49.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 10:49:09 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-503397ee920so6168392e87.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3090:b0:501:ba04:f34b with SMTP id
 z16-20020a056512309000b00501ba04f34bmr2848652lfd.44.1695491348654; Sat, 23
 Sep 2023 10:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com> <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 10:48:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
Message-ID: <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Sept 2023 at 23:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Apparently, they are willing to handle the "year 2486" issue ;)

Well, we could certainly do the same at the VFS layer.

But I suspect 10ns resolution is entirely overkill, since on a lot of
platforms you don't even have timers with that resolution.

I feel like 100ns is a much more reasonable resolution, and is quite
close to a single system call (think "one thousand cycles at 10GHz").

> But the resolution change is counter to the purpose of multigrain
> timestamps - if two syscalls updated the same or two different inodes
> within a 100ns tick, apparently, there are some workloads that
> care to know about it and fs needs to store this information persistently.

Those workloads are broken garbage, and we should *not* use that kind
of sh*t to decide on VFS internals.

Honestly, if the main reason for the multigrain resolution is
something like that, I think we should forget about MG *entirely*.
Somebody needs to be told to get their act together.

We have *never* guaranteed nanosecond resolution on timestamps, and I
think we should put our foot down and say that we never will.

Partly because we have platforms where that kind of timer resolution
just does not exist.

Partly because it's stupid to expect that kind of resolution anyway.

And partly because any load that assumes that kind of resolution is
already broken.

End result: we should ABSOLUTELY NOT have as a target to support some
insane resolution.

100ns resolution for file access times is - and I'll happily go down
in history for saying this - enough for anybody.

If you need finer resolution than that, you'd better do it yourself in
user space.

And no, this is not a "but some day we'll have terahertz CPU's and
100ns is an eternity". Moore's law is dead, we're not going to see
terahertz CPUs, and people who say "but quantum" have bought into a
technological fairytale.

100ns is plenty, and has the advantage of having a very safe range.

That said, we don't have to do powers-of-ten. In fact, in many ways,
it would probably be a good idea to think of the fractional seconds in
powers of two. That tends to make it cheaper to do conversions,
without having to do a full 64-bit divide (a constant divide turns
into a fancy multiply, but it's still painful on 32-bit
architectures).

So, for example, we could easily make the format be a fixed-point
format with "sign bit, 38 bit seconds, 25 bit fractional seconds",
which gives us about 30ns resolution, and a range of almost 9000
years. Which is nice, in how it covers all of written history and all
four-digit years (we'd keep the 1970 base).

And 30ns resolution really *is* pretty much the limit of a single
system call. I could *wish* we had system calls that fast, or CPU's
that fast. Not the case right now, and sadly doesn't seem to be the
case in the forseeable future - if ever - either. It would be a really
good problem to have.

And the nice thing about that would be that conversion to timespec64
would be fairly straightforward:

   struct timespec64 to_timespec(fstime_t fstime)
   {
        struct timespec64 res;
        unsigned int frac;

        frac = fstime & 0x1ffffffu;
        res.tv_sec = fstime >> 25;
        res.tv_nsec = frac * 1000000000ull >> 25;
        return res;
   }

   fstime_t to_fstime(struct timespec64 a)
   {
        fstime_t sec = (fstime_t) a.tv_sec << 25;
        unsigned frac = a.tv_nsec;

        frac = ((unsigned long long) a.tv_nsec << 25) / 1000000000ull;
        return sec | frac;
   }

and both of those generate good code (that large divide by a constant
in to_fstime() is not great, but the compiler can turn it into a
multiply).

The above could be improved upon (nicer rounding and overflow
handling, and a few modifications to generate even nicer code), but
it's not horrendous as-is. On x86-64, to_timespec becomes a very
reasonable

        movq    %rdi, %rax
        andl    $33554431, %edi
        imulq   $1000000000, %rdi, %rdx
        sarq    $25, %rax
        shrq    $25, %rdx

and to some degree that's the critical function (that code would show
up in 'stat()').

Of course, I might have screwed up the above conversion functions,
they are untested garbage, but they look close enough to being in the
right ballpark.

Anyway, we really need to push back at any crazies who say "I want
nanosecond resolution, because I'm special and my mother said so".

                Linus
