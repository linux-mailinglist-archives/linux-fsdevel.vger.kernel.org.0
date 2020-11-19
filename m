Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CF2B96C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKSPpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 10:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgKSPpv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:45:51 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4970F246AD;
        Thu, 19 Nov 2020 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605800750;
        bh=pJn4IPtBzcC0PoTvJz5inMhFnGIlxkSlgptmvq4eeFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GvH8o+ewl+PMp+xXrkpa+YGKJn8LFJrCsIP/yhaax1nbBfYyaUSLq+MhVFpdBnGWg
         oZnVVV7d1ya4DmlJixZpxzd6ydd+WsCTdma5F850PPEmdRPT2MP15FZv1RORDhC0Nb
         8csYitO2bkFXz6DyZRhs5AaKucx7JOAUfw1Bl+vU=
Received: by mail-oi1-f175.google.com with SMTP id k26so6810844oiw.0;
        Thu, 19 Nov 2020 07:45:50 -0800 (PST)
X-Gm-Message-State: AOAM532Oh2yArcOJ2BmiKWjGKJgCV+xG6edPwHAB6E4HNCc8H9h0FVU/
        hhBJfxBCdzFMb+9lp9ZZP5ma/iwtp/KofqdjC0Q=
X-Google-Smtp-Source: ABdhPJz307GfHISOKSn+FrcyivBqEXL3i2fl7zuiWat1rV8weM6cnPBmgCqgC2mwI9OPhajO8TpWqd0wV4t5ATXSwqo=
X-Received: by 2002:aca:3c54:: with SMTP id j81mr3305353oia.11.1605800749476;
 Thu, 19 Nov 2020 07:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org>
In-Reply-To: <20201119143131.GG29991@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 19 Nov 2020 16:45:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
Message-ID: <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:31 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 19, 2020 at 09:19:35AM -0500, Willem de Bruijn wrote:
> > But for epoll, this is inefficient: in ep_set_mstimeout it calls
> > ktime_get_ts64 to convert timeout to an offset from current time, only
> > to pass it to select_estimate_accuracy to then perform another
> > ktime_get_ts64 and subtract this to get back to (approx.) the original
> > timeout.

Right, it would be good to avoid the second ktime_get_ts64(), as reading
the clocksource itself can be expensive.

> > How about a separate patch that adds epoll_estimate_accuracy with
> > the same rules (wrt rt_task, current->timer_slack, nice and upper bound)
> > but taking an s64 timeout.
> >
> > One variation, since it is approximate, I suppose we could even replace
> > division by a right shift?

The right shift would work indeed, but it's also a bit ugly unless
__estimate_accuracy() is changed to always use the same shift.

I see that on 32-bit ARM, select_estimate_accuracy() calls
the external __aeabi_idiv() function to do the 32-bit division, so
changing it to a shift would speed up select as well.

Changing select_estimate_accuracy() to take the relative timeout
as an argument to avoid the extra ktime_get_ts64() should
have a larger impact.

> > After that, using s64 everywhere is indeed much simpler. And with that
> > I will revise the new epoll_pwait2 interface to take a long long
> > instead of struct timespec.
>
> I think the userspace interface should take a struct timespec
> for consistency with ppoll and pselect.  And epoll should use
> poll_select_set_timeout() to convert the relative timeout to an absolute
> endtime.  Make epoll more consistent with select/poll, not less ...

I don't see a problem with an s64 timeout if that makes the interface
simpler by avoiding differences between the 32-bit and 64-bit ABIs.

More importantly, I think it should differ from poll/select by calculating
and writing back the remaining timeout.

I don't know what the latest view on absolute timeouts at the syscall
ABI is, it would probably simplify the implementation, but make it
less consistent with the others. Futex uses absolute timeouts, but
is itself inconsistent about that.

     Arnd
