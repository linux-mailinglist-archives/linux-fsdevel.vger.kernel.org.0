Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5C2B8A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 04:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKSDW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 22:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKSDW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:22:59 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CDC0613D4;
        Wed, 18 Nov 2020 19:22:59 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so5819753ejy.6;
        Wed, 18 Nov 2020 19:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGYqkz2620X8GZAdIDOxczX1xWOdLJhpiDQQCuelz7w=;
        b=SCQSB5/sDj83Of/xiZUcgOuXiaNdGvKZS1Tt/tRnswAgVVPPKIOQffkX+MNUIpUyqc
         kfh/hTDUnT7gUA8FiXOpAaXiWWfmqhf4MzIPdgmOBXfhCbxyjz0uHtJsw93QHXPCht2r
         pMFK2bQwOSQp+4FX7IqisN9upKC6FLJrJ+dP4KkMyjPvTdcET88eN2oq+2S7r636YR9d
         ohKtUMyvCbETUiHujGZibG7a8UIoecqJOGFsWZq7LtthlsUgx/JlsalTVeed2HEHbXVS
         Z+4APMxwjXGzwO9nr47A8OnLgXicNVzcxeArVHZkUfJRGR5ubT6gwaBhad/OKXNBsxEz
         ARNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGYqkz2620X8GZAdIDOxczX1xWOdLJhpiDQQCuelz7w=;
        b=sJHkvGBliKZX/7wxIE6HrI1bLEi302ogehT9S2GI7Xm50aZNcdr76v6+qp/NFg4dTH
         wZ6pDaoLrMe2Z2o4ZaFoA+HsTIte7uUC7BAKHHrZsFmYt0McMP6jhHDkBxBwpii/RQWK
         cJ84vQV3ovao1cPRhiLvM62whce+UoeRVdButJd1d/qrTti1stEuGGHirvUaUTdfb8c5
         Y8qOjYR4wt+MqJxPOzLgwk7Wu5huf2x/vRCQ1Uz66ggdOMnDKW9COkFBZZB0WUafq9N4
         cusRzGO6Zbs26PAh1F+cM1+ZEh+rUPAqxXtLp7s38Mdggj72nEOueVTObr/WvZH2L/dB
         3Ihw==
X-Gm-Message-State: AOAM533vZpT7+LKHnmyKk+S0ykvzDYB6bjmZpQ5mK08zCKj35pQod0uR
        YSOE3rGlNR9v8o1CYzCd8N6gIUjVF5w7m2EtZEs=
X-Google-Smtp-Source: ABdhPJxfaInlHp0nzNYL0LQnI3sdTtNKYY6FsmVLGfMokOKDyv6jtRzPoj02F7vWpa/XHk08jH0rY/jLEC95/HGvZBY=
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr25537354ejn.464.1605756177893;
 Wed, 18 Nov 2020 19:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <CA+FuTSdFTDFwOVyws19CaAP_6+c5gTrvA0ybvDo3LJ-VhPz1eQ@mail.gmail.com>
 <CAK8P3a09jUv8YiuZAi5Q-SW4k20Pw0mXdHj9DVznbQ=Kxm2gig@mail.gmail.com>
In-Reply-To: <CAK8P3a09jUv8YiuZAi5Q-SW4k20Pw0mXdHj9DVznbQ=Kxm2gig@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 18 Nov 2020 22:22:20 -0500
Message-ID: <CAF=yD-+aKAo2qxVUxhPQ4orDEhMGpks=h6ZhEXgkYB2xo+iScw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:50 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Nov 18, 2020 at 5:21 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > > index 109e6681b8fa..9a4e8ec207fc 100644
> > > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > > @@ -447,3 +447,4 @@
> > >  440    i386    process_madvise         sys_process_madvise
> > >  441    i386    watch_mount             sys_watch_mount
> > >  442    i386    memfd_secret            sys_memfd_secret
> > > +443    i386    epoll_pwait2            sys_epoll_pwait2                compat_sys_epoll_pwait2
> >
> > I should have caught this sooner, but this does not work as intended.
> >
> > x86 will still call epoll_pwait2 with old_timespec32.
> >
> > One approach is a separate epoll_pwait2_time64 syscall, similar to
> > ppoll_time64. But that was added to work around legacy 32-bit ppoll.
> > Not needed for a new API.
> >
> > In libc, ppoll_time64 is declared with type struct __timespec64. That
> > type is not defined in Linux uapi. Will need to look at this some
> > more.
>
> The libc __timespec64 corresponds to the __kernel_timespec64
> structure in uapi. It is defined to only have 'long' nanoseconds
> member because that's what c99 and posix require, but the bits
> are in the position that matches the lower 32 bits of the 64-bit
> tv_nsec in the kernel, and get_timespec64() performs the
> necessary conversion to either check or zero the upper bits.
>
> I think all you need in user space is to pass the timeout as a
> __timespec64 structure and add a conversion in the exported
> library interface.

Indeed, that resolves it, thanks.

I'll define that struct in the selftest and update the definition of
sys_epoll_pwait2 there.
