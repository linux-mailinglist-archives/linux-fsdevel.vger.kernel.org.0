Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F011649041
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLJSw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 13:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLJSwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:52:23 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BF18395
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:52:12 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id cg5so6053461qtb.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ux000uRhIvBzcJmT+I5Zn16s8FTwiB+xIoLfos10Ds=;
        b=OTXThifSNhozRXE9B96yw+UechhX40Wpc34GA3QOHFgDx/enYs+4y17hm8s474Wgg9
         YsJ+Yv0fdwelTo83br+SVHt0MgMXVOH4Wqjhi9QDHpt4cCnhVDQwY4FkVoi1Pyiybh8V
         au+Ec0cROCq/OGjq8DWg6Rc4qNjaot/8Apysw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ux000uRhIvBzcJmT+I5Zn16s8FTwiB+xIoLfos10Ds=;
        b=WuNC330gCrJKNfEOUY/qH4qG0Umz9TiXrx8ZMLuiGwGjhhlKotgvjuK97Z3QxXKFWJ
         29ZYmlsSZH04BlaODNBKBtjKXcGYI63RUTt9rd2pGJZ6ezxcz+Z1M9QE2OReJIQJTrSh
         ql2s0VhOVV8zkbAtB4hlMaxwFpd3eLuIMHyQ9Fxe2OguCnEH4lMmCYM3ksOhWptDo3mE
         fbU5AigWSHDbRb3Gbfy+GmvVXdZCXK5Ryx+JmFhYrN/uvo4sYl6yf1crp95YHCAEkEft
         rAKgbKycee7zcKJeJjpetaFnAJH7y76eUyKzlh++jW8+3yg310llbyp+OjnVZFrusKLV
         PsAg==
X-Gm-Message-State: ANoB5pkWJbyjDVBR/z+kEbL6hHG1MPB0tAxI+8wVZJuvnF1myR124ajL
        Hvn4/rOHxcAAYsNZ6V3udKQ+X0obi5K03uZa
X-Google-Smtp-Source: AA0mqf5+VAwfxhnc4w8jA9Qe+4rLsK+rL1BwD9jZtSq2/dU5LWbv3wRiBhv1Ypk45CuE4/ubXMr6jA==
X-Received: by 2002:a05:622a:5913:b0:3a7:f84f:3c80 with SMTP id ga19-20020a05622a591300b003a7f84f3c80mr12760950qtb.51.1670698330897;
        Sat, 10 Dec 2022 10:52:10 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id j9-20020ac86649000000b003a6a19ee4f0sm3166065qtp.33.2022.12.10.10.52.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:52:10 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id s9so5791178qtx.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:52:10 -0800 (PST)
X-Received: by 2002:ac8:688:0:b0:3a5:122:fb79 with SMTP id f8-20020ac80688000000b003a50122fb79mr76081601qth.452.1670698330099;
 Sat, 10 Dec 2022 10:52:10 -0800 (PST)
MIME-Version: 1.0
References: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk>
In-Reply-To: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 10:51:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgzBzTR5t6Dc6gZ_XS1q=UrqeiBf62op_fahbwns+xvQ@mail.gmail.com>
Message-ID: <CAHk-=whgzBzTR5t6Dc6gZ_XS1q=UrqeiBf62op_fahbwns+xvQ@mail.gmail.com>
Subject: Re: [GIT PULL] Add support for epoll min wait time
To:     Jens Axboe <axboe@kernel.dk>
Cc:     netdev <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> This adds an epoll_ctl method for setting the minimum wait time for
> retrieving events.

So this is something very close to what the TTY layer has had forever,
and is useful (well... *was* useful) for pretty much the same reason.

However, let's learn from successful past interfaces: the tty layer
doesn't have just VTIME, it has VMIN too.

And I think they very much go hand in hand: you want for at least VMIN
events or for at most VTIME after the last event.

Yes, yes, you have that 'maxevents' thing, but that's not at all the
same as VMIN. That's just the buffer size.

Also note that the tty layer VTIME is *different* from what I think
your "minimum wait time" is. VTIME is a "inter event timer", not a
"minimum total time". If new events keep on coming, the timer resets -
until either things time out, or you hit VMIN events.

I get the feeling that the tty layer did this right, and this epoll
series did not. The tty model certainly feels more flexible, and does
have decades of experience. tty traffic *used* to be just about the
lowest-latency traffic machines handled back when, so I think it might
be worth looking at as a model.

So I get the feeling that if you are adding some new "timeout for
multiple events" model to epoll, you should look at previous users.

And btw, the tty layer most definitely doesn't handle every possible case.

There are at least three different valid timeouts:

 (a) the "final timeout" that epoll already has (ie "in no case wait
more than this, even if there are no events")

 (b) the "max time we wait if we have at least one event" (your new "min_wait")

 (c) the "inter-event timeout" (tty layer VTIME)

and in addition to the timers, there's that whole "if I have gotten X
events, I have enough, so stop timing out" (tty layer VMIN).

And again, that "at least X events" should not be "this is my buffer
size". You may well want to have a *big* buffer for when there are
events queued up or the machine is just under very heavy load, but may
well feel like "if I got N events, I have enough to deal with, and
don't want to time out for any more".

Now, maybe there is some reason why the tty like VMIN/VTIME just isn't
relevant, but I do think that people have successfully used VMIN/VTIME
for long enough that it should be at least given some thought.

Terminal traffic may not be very relevant any more as a hard load to
deal with well. But it really used to be very much an area that had to
balance both throughput and latency concerns and had exactly the kinds
of issues you describe (ie "returning after one single character is
*much* too inefficient").

Hmm?

              Linus
