Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C303D15C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhGURUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhGURUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:20:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E76C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u13so4414741lfs.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPa37eNvC3uDqntcxwWWKIYs96FW2IfN+zBOwLvLWyk=;
        b=c+qRkAs1DwxE9hRy95PZsZTyPTKGRmiVDdYPr/bRhqbhIDs7uWTM2Wsf1S7FMeFGe1
         FNgM0RY06bExtz9ZsFKG5uZQ1/OxFtWR3RXfJPOwfj+9JRRXgAw7yBN4moMgoQd9D6PA
         XBUgrH2V+hAGFnQQ1Pvz1igLS1r2cK9mRXng4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPa37eNvC3uDqntcxwWWKIYs96FW2IfN+zBOwLvLWyk=;
        b=Up2ytcPlNsgzh18AlGUNJ1D1iNelyhy44DhmM3j5agNqL7F4/4YMBmTx3BYyBrvYuU
         t7xUfEy7fEAl9I4XcjPnf/EuVl5KWvJc2TjW2rQq3WMMcmvHCqEmwc1d+gnXeQeyBy4s
         pRIyygVMCvwomYyK8/L20b2dPM3pGazHzR8hZuqcR9488x9sZddVh2ChigzZA8vLXEeK
         3Mczv0qhsn221M2rqQx+LT8EuMcqvOWzyB8b4iYIDi7j4leeyI999bskrjpYKC2iLDwQ
         +DNzVAyHNB1pksVXWPXYWAXgQj7ukSHgNEG1lvBRWQw7P3irXR2QfGRsVZimCsjHjE9p
         wOlQ==
X-Gm-Message-State: AOAM5331njPTYxcFEdyasG6TSQ0EiaRsfWec2aOnxHZDMbfymkQb8EID
        nUaEWvxOMZXM65Jpw1BX/3hm2sY+Yik0sE9x
X-Google-Smtp-Source: ABdhPJxM9mmAoYn7y5EoynCYh/yCvU3JGXw1BtHeWKHrENGhpJIqsRMkvAoP4teXIXCNjFrm0TRvxQ==
X-Received: by 2002:a05:6512:2345:: with SMTP id p5mr26788979lfu.71.1626890476872;
        Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m12sm1517174lfo.227.2021.07.21.11.01.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 8so4428890lfp.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:01:16 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr26027265lfl.41.1626890475459;
 Wed, 21 Jul 2021 11:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com>
In-Reply-To: <20210721135926.602840-1-nborisov@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 11:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
Message-ID: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 6:59 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> This is glibc's memcmp version. The upside is that for architectures
> which don't have an optimized version the kernel can provide some
> solace in the form of a generic, word-sized optimized memcmp. I tested
> this with a heavy IOCTL_FIDEDUPERANGE(2) workload and here are the
> results I got:

Hmm. I suspect the usual kernel use of memcmp() is _very_ skewed to
very small memcmp calls, and I don't think I've ever seen that
(horribly bad) byte-wise default memcmp in most profiles.

I suspect that FIDEDUPERANGE thing is most likely a very special case.

So I don't think you're wrong to look at this, but I think you've gone
from our old "spend no effort at all" to "look at one special case".

And I think the glibc implementation is horrible and doesn't know
about machines where unaligned loads are cheap - which is all
reasonable ones.

That MERGE() macro is disgusting, and memcmp_not_common_alignment()
should not exist on any sane architecture. It's literally doing extra
work to make for slower accesses, when the hardware does it better
natively.

So honestly, I'd much rather see a much saner and simpler
implementation that works well on the architectures that matter, and
that don't want that "align things by hand".

Aligning one of the sources by hand is fine and makes sense - so that
_if_ the two strings end up being mutually aligned, all subsequent
accesses are aligned.

 But then trying to do shift-and-masking for the possibly remaining
unaligned source is crazy and garbage. Don't do it.

And you never saw that, because your special FIDEDUPERANGE testcase
will never have anything but mutually aligned cases.

Which just shows that going from "don't care at all' to "care about
one special case" is not the way to go.

So I'd much rather see a simple default function that works well for
the sane architectures, than go with the default code from glibc - and
bad for the common modern architectures.

Then architectures could choose that one with some

        select GENERIC_MEMCMP

the same way we have

        select GENERIC_STRNCPY_FROM_USER

for the (sane, for normal architectures) common optimized case for a
special string instruction that matters a lot for the kernel.

                     Linus
