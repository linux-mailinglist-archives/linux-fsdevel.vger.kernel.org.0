Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B03D2928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhGVQBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhGVQBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:01:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE7C061199
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 09:41:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t3so8127759ljc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZqCJYRkNM5yR1EJryo+jWRubBojTYiU4BrPgUsJfiQ=;
        b=hM73AoZY3fTiGxt/QQldnNKcJyurVG5o4Oy7mU6pEKqRE8iaHaK8x/slm44FSONk6H
         kynWxssa3JA7122YNE55tR7ZevPBXEooG+kmi6Se/C2Q+4GI37ZL82aADBwhzgGYFYj9
         YSrZQs6/WQkG3IwtaSOc6TDJQJJRhV6Izs+3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZqCJYRkNM5yR1EJryo+jWRubBojTYiU4BrPgUsJfiQ=;
        b=HyLopx03aKGD1vawlddEiKGLBtVsFv+A/ILtWPTbSoy0wF/smFnMPeMuMPRUQLC4Ig
         kjfQtAuoarQ0qakn8z9IM/iVLEEzL9MQ/sIUX8Pg+FlYxjsovNzBGG/3neneeBe9BYPj
         /E+80pXsEbT6WjZCCVvzf4/vyB+kxWeUq1cdXi28cqteCT7QVtJ3vz2q+h7JdK0eWqVy
         CgfOkmA3hWCXHOFFxsAcdtDYCX21dIHVu/X/MZl8wKzUE5LpyeB+zC8RhrLcbTAXm1cY
         2BQISt1aGwWhGkB4QEGD6HKisSjja3vtKKLejrZpqyJnX/IcnFhRd0uIVfAPxBYfiIuM
         +eqQ==
X-Gm-Message-State: AOAM533cdBXmIzi033AB+DcUIPstF9dRkIGHykUkIfWSVYaL5g7tqzqF
        YR1by0iZBPKYwr0JYU6vc/lWlD1/RfUwsIsvp0E=
X-Google-Smtp-Source: ABdhPJyYIxetjzJ2DcU3GRkV34Kmc1gDRLp1E8vq9puD5Kd47Xu4ehGX4pcdA/h3YU9mte89kNvkkQ==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr580659ljk.431.1626972060125;
        Thu, 22 Jul 2021 09:41:00 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l21sm2689590ljc.94.2021.07.22.09.40.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 09:40:59 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id t3so8127659ljc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 09:40:59 -0700 (PDT)
X-Received: by 2002:a2e:3212:: with SMTP id y18mr635693ljy.220.1626972059178;
 Thu, 22 Jul 2021 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com> <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
 <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com> <eef30b51-c69f-0e70-11a8-c35f90aeca67@gmail.com>
In-Reply-To: <eef30b51-c69f-0e70-11a8-c35f90aeca67@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Jul 2021 09:40:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
Message-ID: <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 4:28 AM Nikolay Borisov
<n.borisov.lkml@gmail.com> wrote:
>
> This one also works, tested only on x86-64. Looking at the perf diff:
>
>     30.44%    -28.66%  [kernel.vmlinux]         [k] memcmp

Ok.

So the one that doesn't even bother to align is

    30.44%    -29.38%  [kernel.vmlinux]         [k] memcmp

and the one that aligns the first one is

    30.44%    -28.66%  [kernel.vmlinux]         [k] memcmp

and the difference between the two is basically in the noise:

     1.05%     +0.72%  [kernel.vmlinux]     [k] memcmp

but the first one does seem to be slightly better.

> Now on a more practical note, IIUC your 2nd version makes sense if the
> cost of doing a one unaligned access in the loop body is offset by the
> fact we are doing a native word-sized comparison, right?

So honestly, the reason the first one seems to beat the second one is
that the cost of unaligned accesses on modern x86 is basically
epsilon.

For all normal unaligned accesses there simply is no cost at all.
There is a _tiny_ cost when the unaligned access crosses a cacheline
access boundary (which on older CPU's is every 32 bytes, on modern
ones it's 64 bytes). And then there is another slightly bigger cost
when the unaligned access actually crosses a page boundary.

But even those non-zero cost cases are basically in the noise, because
under most circumstances they will be hidden by any out-of-order
engine, and completely dwarfed by the _real_ costs which are branch
mispredicts and cache misses.

So on the whole, unaligned accesses are basically no cost at all. You
almost have to have unusual code sequences for them to be even
measurable.

So that second patch that aligns one of the sources is basically only
extra overhead for no real advantage. The cost of it is probably one
more branch mispredict, and possibly a cycle or two for the extra
instructions.

Which is why the first one wins: it's simpler, and the extra work the
second one does is basically not worth it on x86. Plus I suspect your
test-case was all aligned anyway to begin with, so the extra work is
_doubly_ pointless.

I suspect the second patch would be worthwhile if

 (a) there really were a lot of strings that weren't aligned (likelihood: low)

 (b) other microarchitectures that do worse on unaligned accesses -
some microarchitectures spend extra cycles on _any_ unaligned accesses
even if they don't cross cache access boundaries etc.

and I can see (b) happening quite easily. You just won't see it on a
modern x86-64 setup.

I suspect we should start with the first version. It's not only better
on x86, but it's simpler, and it's guarded by that

    #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

so it's fundamentally "safer" on architectures that are just horrible
about unaligned accesses.

Now, admittedly I don't personally even care about such architectures,
and because we use "get_unaligned()", the compiler should always
generate code that doesn't absolutely suck for bad architectures, but
considering how long we've gone with the completely brainlessly simple
"byte at a time" version without anybody even noticing, I think a
minimal change is a better change.

That said, I'm not convinced I want to apply even that minimal first
patch outside of the merge window.

So would you mind reminding me about this patch the next merge window?
Unless there was some big extrernal reason why the performance of
memcmp() mattered to you so much (ie some user that actually noticed
and complained) and we really want to prioritize this..

              Linus
