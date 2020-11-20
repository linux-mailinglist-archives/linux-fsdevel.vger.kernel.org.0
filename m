Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A992BA469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKTINw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgKTINw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:13:52 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67172222F;
        Fri, 20 Nov 2020 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605860031;
        bh=fYVCqYT+pvTgmgC+g6F2JxaaXTLvd83g03R+dDCeewQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+Y2k40uIRYFfl7XNYrhYBuM2/7Gm1ktO0VIyRYuZOGmqF/QL/a/ZNM/b0m36SnWJ
         V4plLyoTNCwP+tttCokERu2JDz6ngv5hyELW6KlNRcFOOrZ24xCwd0dDGmTP3qpUnl
         yG0imc8YTuu32N1Ey4/8T8U/VYZb2lEnydY2guC8=
Received: by mail-oi1-f171.google.com with SMTP id v202so6396976oia.9;
        Fri, 20 Nov 2020 00:13:50 -0800 (PST)
X-Gm-Message-State: AOAM531SQE9bf6+jKi0aoI14c7g00Ii/n+ArRQkQ0wMEUfoxg2aSmlCD
        BRvjqDO2zsxyHWTratZSPKPe1cPEHwT4SiulcqY=
X-Google-Smtp-Source: ABdhPJwHa2aaIhyC88xa7YMJTuBU5FRuzX2cmwEV6Q0ASIwylQKaqxZSkhzRnWtIYhFofQWhxCBTw+lSTIMtqUkVrv4=
X-Received: by 2002:aca:180a:: with SMTP id h10mr5433010oih.4.1605860029111;
 Fri, 20 Nov 2020 00:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
In-Reply-To: <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 20 Nov 2020 09:13:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
Message-ID: <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Thu, Nov 19, 2020 at 9:13 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Thu, Nov 19, 2020 at 10:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Thu, Nov 19, 2020 at 3:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> > The right shift would work indeed, but it's also a bit ugly unless
> > __estimate_accuracy() is changed to always use the same shift.
> >
> > I see that on 32-bit ARM, select_estimate_accuracy() calls
> > the external __aeabi_idiv() function to do the 32-bit division, so
> > changing it to a shift would speed up select as well.
> >
> > Changing select_estimate_accuracy() to take the relative timeout
> > as an argument to avoid the extra ktime_get_ts64() should
> > have a larger impact.
>
> It could be done by having poll_select_set_timeout take an extra u64*
> slack, call select_estimate_accuracy before adding in the current time
> and then pass the slack down to do_select and do_sys_poll, also
> through core_sys_select and compat_core_sys_select.
>
> It could be a patch independent from this new syscall. Since it changes
> poll_select_set_timeout it clearly has a conflict with the planned next
> revision of this. I can include it in the next patchset to decide whether
> it's worth it.

Yes, that sounds good, not sure how much rework this would require.

It would be easier to do if we first merged the native and compat
native versions of select/pselect/ppoll by moving the
in_compat_syscall() check into combined get_sigset()
and get_fd_set() helpers. I would assume you have enough
on your plate already and don't want to add that to it.

> > I don't see a problem with an s64 timeout if that makes the interface
> > simpler by avoiding differences between the 32-bit and 64-bit ABIs.
> >
> > More importantly, I think it should differ from poll/select by calculating
> > and writing back the remaining timeout.
> >
> > I don't know what the latest view on absolute timeouts at the syscall
> > ABI is, it would probably simplify the implementation, but make it
> > less consistent with the others. Futex uses absolute timeouts, but
> > is itself inconsistent about that.
>
> If the implementation internally uses poll_select_set_timeout and
> passes around timespec64 *, it won't matter much in terms of
> performance or implementation. Then there seems to be no downside to
> following the consistency argument.

Ok. So to clarify, you would stay with relative __kernel_timespec
pointers and not copy back the remaining time, correct?

       ARnd
