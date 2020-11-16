Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688D52B5565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 00:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgKPXvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 18:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgKPXvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:51:55 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E6C0613CF;
        Mon, 16 Nov 2020 15:51:54 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id a15so20580022edy.1;
        Mon, 16 Nov 2020 15:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l35Fp/NoyrjrpcxM04CYLD1c4g2zMDwnAd4FtQOuoEw=;
        b=arNLsBPleBUAJwg+AQszd/ytpsK7EVx1O9iFSfZx7MOizrFaARqpLaxvRiQAxA1qDp
         O90I0mk5qAjRcqh9BHqwZS0X00qj4hPAMdPRCgxLRxEhyZSsSN7XBmz8jiJWtE4aNoCO
         fQeXycLMsdf+U9rKjLzDvHzXm9qbg2+Wkx1S3JUVwCeuEZf/qUgbgEcPZr34/vUwGSEB
         lJU8my3DDuAiTRiwMAbhPhigHa+lLa2bumcmdwUcdtBpq/yXg7ytOGhNDH0xF/NOR9yu
         GxnlbQJpPpjfDoAEvkB6hcoQu95Qo6c6676t+qneID8/NL6sOO8HYhlncDdj+JauTky7
         417w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l35Fp/NoyrjrpcxM04CYLD1c4g2zMDwnAd4FtQOuoEw=;
        b=GN3nSgkjvn6ttXYhrMK7qTQDcBrEm3S1J2x7cvLjNrB/Y5gRF6lQw2bIxzAnNb4yCx
         SNFz7AUgu1OShPbc8BQyJXJucYXYm1xTrhkDkOMbrqWaEna4EF9Ca4CNI55tFWeMW1K+
         aOLWAq34RJ4fUUMXqZl4lfO1ObZsGg5anRXhF6NIDfaBBz2GTxB0UzmS6BScrc9fC5/J
         ChJYBN7KHNDfPrwe23p/1DmVyS7odeuo45O202Gfgvd3E1IZ25rlSblC+ObYpipRtpWq
         hR42bQJl7qDrAG+/k5aQ9hv1xWyCdplILtfX3mgE20v7Zui9lPPxoq8TRIVoRiWvYfZP
         QxnQ==
X-Gm-Message-State: AOAM532E9CmS7+D8r49Ga35XncIxbramEY2RXz0eYsiJClQOGzkx6U5i
        qJXFNm7rbj+CA5U+oDwaNW8lnCFj9QoaGEB9jxE=
X-Google-Smtp-Source: ABdhPJzHMAVjJNXlSF6IHT9YPY9qHlghF5y2n2hRG9+Wfbf1PKDelBXbd+shhnBW56d+b+blI74YjrCLrxtQc5DPR+E=
X-Received: by 2002:aa7:d34e:: with SMTP id m14mr17544278edr.42.1605570713432;
 Mon, 16 Nov 2020 15:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
 <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org> <CAF=yD-JJtAwse5keH5MxxtA1EY3nxV=Ormizzvd2FHOjWROk4A@mail.gmail.com>
In-Reply-To: <CAF=yD-JJtAwse5keH5MxxtA1EY3nxV=Ormizzvd2FHOjWROk4A@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Nov 2020 18:51:16 -0500
Message-ID: <CAF=yD-JFjoYEiqNLMqM-mTFQ1qYsw7Py5oggyVesHo7burwumA@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:36 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Nov 16, 2020 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 16 Nov 2020 11:10:01 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> > > interpretation of argument timeout in epoll_wait from msec to nsec.
> > >
> > > Use cases such as datacenter networking operate on timescales well
> > > below milliseconds. Shorter timeouts bounds their tail latency.
> > > The underlying hrtimer is already programmed with nsec resolution.
> >
> > hm, maybe.  It's not very nice to be using one syscall to alter the
> > interpretation of another syscall's argument in this fashion.  For
> > example, one wonders how strace(1) is to properly interpret & display
> > this argument?
> >
> > Did you consider adding epoll_wait2()/epoll_pwait2() syscalls which
> > take a nsec timeout?  Seems simpler.
>
> I took a first stab. The patch does become quite a bit more complex.

Not complex in terms of timeout logic. Just a bigger patch, taking as
example the recent commit ecb8ac8b1f14 that added process_madvise.

> I was not aware of how uncommon syscall argument interpretation
> contingent on internal object state really is. Yes, that can
> complicate inspection with strace, seccomp, ... This particular case
> seems benign to me. But perhaps it sets a precedent.
>
> A new nsec resolution epoll syscall would be analogous to pselect and
> ppoll, both of which switched to nsec resolution timespec.
>
> Since creating new syscalls is rare, add a flags argument at the same time?
>
> Then I would split the change in two: (1) add the new syscall with
> extra flags argument, (2) define flag EPOLL_WAIT_NSTIMEO to explicitly
> change the time scale of the timeout argument. To avoid easy mistakes
> by callers in absence of stronger typing.

Come to think of it, better to convert to timespec to both have actual
typing and consistency with ppoll/pselect.

> epoll_wait is missing from include/uapi/asm-generic/unistd.h as it is
> superseded by epoll_pwait. Following the same rationale, add
> epoll_pwait2 (only).
