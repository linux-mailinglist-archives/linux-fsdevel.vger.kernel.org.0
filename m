Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF712B55C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgKQAh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 19:37:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKQAh4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:37:56 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CFC2463D;
        Tue, 17 Nov 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605573475;
        bh=wk+WwoC6VnrSIsXOBifPoQffU2aM299BwJ0a+IY7U2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0ElmHFBUgX0HuyB23JYp8rUSo+R5t//mtsKa8oJ6La3L7hHybePhh8rktpHgrZdrH
         ZvOjV5+goIRWzeHg0fzWyD7iaj9T2a8Zdwaze6aSaDnRR0IHjL6VrKkeWegL+CmGRg
         PonWEtEjg4dngeeQYGmVxMVj8+WtEXBXD1qKASSk=
Date:   Mon, 16 Nov 2020 16:37:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
Message-Id: <20201116163754.ab6ff2ad8f797705db15cc1f@linux-foundation.org>
In-Reply-To: <CAF=yD-JFjoYEiqNLMqM-mTFQ1qYsw7Py5oggyVesHo7burwumA@mail.gmail.com>
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
        <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org>
        <CAF=yD-JJtAwse5keH5MxxtA1EY3nxV=Ormizzvd2FHOjWROk4A@mail.gmail.com>
        <CAF=yD-JFjoYEiqNLMqM-mTFQ1qYsw7Py5oggyVesHo7burwumA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Nov 2020 18:51:16 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> On Mon, Nov 16, 2020 at 6:36 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Mon, 16 Nov 2020 11:10:01 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> > > > interpretation of argument timeout in epoll_wait from msec to nsec.
> > > >
> > > > Use cases such as datacenter networking operate on timescales well
> > > > below milliseconds. Shorter timeouts bounds their tail latency.
> > > > The underlying hrtimer is already programmed with nsec resolution.
> > >
> > > hm, maybe.  It's not very nice to be using one syscall to alter the
> > > interpretation of another syscall's argument in this fashion.  For
> > > example, one wonders how strace(1) is to properly interpret & display
> > > this argument?
> > >
> > > Did you consider adding epoll_wait2()/epoll_pwait2() syscalls which
> > > take a nsec timeout?  Seems simpler.
> >
> > I took a first stab. The patch does become quite a bit more complex.
> 
> Not complex in terms of timeout logic. Just a bigger patch, taking as
> example the recent commit ecb8ac8b1f14 that added process_madvise.

That's OK - it's mainly syscall table patchery.  The fs/ changes are
what matters.  And the interface.

> > I was not aware of how uncommon syscall argument interpretation
> > contingent on internal object state really is. Yes, that can
> > complicate inspection with strace, seccomp, ... This particular case
> > seems benign to me. But perhaps it sets a precedent.
> >
> > A new nsec resolution epoll syscall would be analogous to pselect and
> > ppoll, both of which switched to nsec resolution timespec.
> >
> > Since creating new syscalls is rare, add a flags argument at the same time?

Adding a syscall is pretty cheap - it's just a table entry.

> >
> > Then I would split the change in two: (1) add the new syscall with
> > extra flags argument, (2) define flag EPOLL_WAIT_NSTIMEO to explicitly
> > change the time scale of the timeout argument. To avoid easy mistakes
> > by callers in absence of stronger typing.

I don't understand this.  You're proposing that the new epoll_pwait2() be
able to take either msec or nsec, based on the flags argument?  With a
longer-term plan to deprecate the old epoll_pwait()?

If so, that's not likely to be viable - how can we ever know that the
whole world stopped using the old syscall?

> Come to think of it, better to convert to timespec to both have actual
> typing and consistency with ppoll/pselect.

Sure.

> > epoll_wait is missing from include/uapi/asm-generic/unistd.h as it is
> > superseded by epoll_pwait. Following the same rationale, add
> > epoll_pwait2 (only).

Sure.

> A separate RFC patch against manpages/master sent at the same time?

That's the common approach - a followup saying "here's what I'll send
to the manpages people if this gets merged".

And something under tools/testing/sefltests/ would be nice, if only so
that the various arch maintainers can verify that their new syscall is
working correctly.  Perhaps by adding a please-use-epoll_pwait2 arg to
the existing
tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c, if that
looks like a suitable testcase.


