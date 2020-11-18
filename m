Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68D2B80AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKRPh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgKRPh5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:37:57 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A2024789;
        Wed, 18 Nov 2020 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605713876;
        bh=UGVJOfZ14mLGsxcq39Gp7kwnfZ1K1WKhEYTJNoHGnlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+I4DBKA43q3z5h1gpDuLMq5eM4QCVt/EH/+MesEVCGTSe7wJFDRVfXKRzlEdAY0C
         07NlDaVYOYK6Pfge4Xz4v7rb1NuuVZbEn2q4OGbi4zuiAZQtNp/Gpd0a14/u1bepO3
         ZEI0BCm4IuB09He0hf69+Ct0zCLvQbf+3WOyJaeg=
Received: by mail-oi1-f178.google.com with SMTP id o25so2628605oie.5;
        Wed, 18 Nov 2020 07:37:56 -0800 (PST)
X-Gm-Message-State: AOAM532zttSqtLp9fdYuvabAKbuAeHQ/3SPgsgE0qKaAivosai5v1imX
        e8IB4VL1MjWzq3l3SR1sHwC4vBT26ARoU5fl8WI=
X-Google-Smtp-Source: ABdhPJw49F5eVt72usPrt335IBS23KcOceM0C5Ck8bvtp2CLmZWf2zjr7GY8+GkQD7jyqTKK0IVtQT/QJoBqS9TQ2qU=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr431657oib.67.1605713875694;
 Wed, 18 Nov 2020 07:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
In-Reply-To: <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 18 Nov 2020 16:37:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
Message-ID: <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
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

On Wed, Nov 18, 2020 at 4:10 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Wed, Nov 18, 2020 at 10:00 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Nov 18, 2020 at 09:46:15AM -0500, Willem de Bruijn wrote:
> > > -static inline struct timespec64 ep_set_mstimeout(long ms)
> > > +static inline struct timespec64 ep_set_nstimeout(s64 timeout)
> > >  {
> > > -     struct timespec64 now, ts = {
> > > -             .tv_sec = ms / MSEC_PER_SEC,
> > > -             .tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> > > -     };
> > > +     struct timespec64 now, ts;
> > >
> > > +     ts = ns_to_timespec64(timeout);
> > >       ktime_get_ts64(&now);
> > >       return timespec64_add_safe(now, ts);
> > >  }
> >
> > Why do you pass around an s64 for timeout, converting it to and from
> > a timespec64 instead of passing around a timespec64?
>
> I implemented both approaches. The alternative was no simpler.
> Conversion in existing epoll_wait, epoll_pwait and epoll_pwait
> (compat) becomes a bit more complex and adds a stack variable there if
> passing the timespec64 by reference. And in ep_poll the ternary
> timeout test > 0, 0, < 0 now requires checking both tv_secs and
> tv_nsecs. Based on that, I found this simpler. But no strong
> preference.

The 64-bit division can be fairly expensive on 32-bit architectures,
at least when it doesn't get optimized into a multiply+shift.

     Arnd
