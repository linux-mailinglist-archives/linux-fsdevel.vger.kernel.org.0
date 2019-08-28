Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E247A0668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfH1Pdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 11:33:36 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:44790 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfH1Pdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:33:36 -0400
Received: by mail-lf1-f42.google.com with SMTP id v16so2521396lfg.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2019 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fd+KTN0L+cF/fqV/5SbUQseAraIc6oxedxZ1b1p2O4A=;
        b=BHcU93EcORnUyq8KZXVzcEQTJgm+tywX5ONdvRnEN86yU+yKHERKKK8b/88wmxMMiJ
         4SBjXtGk9o1CRAVCNv0Tm4E6jB6Cz2tfieqeViqRxEQidQlaqIDPImOeLdqAFxCVkdyr
         8ZAvprhbJrYArKirn3GakMwe6nGsb3HRTvyzQKknFYo1kHoutSWH4REsq+0sxdA66c90
         6YUuqVbsXTl+V2SiiKA/drwrbyTtqLQsUYw4aVyWTd5dxYwj6E7WfPFILhANpBH8u1qs
         ozF6cR0zfp4w20rKpzveNJ5sgTdDXSQ7SccWsQf71w1JSQ7e9XoV/Fvlfjlc+9NW/KZy
         kf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fd+KTN0L+cF/fqV/5SbUQseAraIc6oxedxZ1b1p2O4A=;
        b=mISyz1uPp0joXxp79RJHgs6MrPlvgpcejKibwfhks0Hnz8qBjnxfDL4HEn3gb8EhHc
         cqbFMvM69BYuX5niufzuZO/4b+3+cl5FY1NzTDn7ossJjY3mwedS7f81ylndH8vVvUZM
         3ZqvTLhDpHw8tMST1K1zKJO44R4buUIphg2zuxTpL4hWN06x3WT12TkEZqO6+hdO8RNp
         ibsW3hp509QtdqbRwxZaoY5WjRWypd/hZf21EMS1kF+Vtf3yijO5zRQkCgn5ZyN9jxcn
         wtK/61rT7BGFrHho8RKZPERa7YklhYty3lQGUgYvpOwa+qoiuj9fCcBct75SJd7MYCIq
         9eqQ==
X-Gm-Message-State: APjAAAUYjDW7hJtPNUM7agL4iWi6pM/mKADUHaKOQ+Rytjyaxc+XfTn5
        hx/gsW6+qOmUtaYoQya8AOo4+tLlOuR8dzTgsI+uhw==
X-Google-Smtp-Source: APXvYqwJtR3sXBgBHjegpofPXjgg4bIwvBfh61XDj6K+96wGTa/hhMZhc2OJjv7L/IdBRg8zUTBfvwfiDVb0PJSUas0=
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr3230264lfl.66.1567006413387;
 Wed, 28 Aug 2019 08:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
 <20190826062229.pjvumg4ag3qwhji6@whir>
In-Reply-To: <20190826062229.pjvumg4ag3qwhji6@whir>
From:   Heiher <r@hev.cc>
Date:   Wed, 28 Aug 2019 23:33:21 +0800
Message-ID: <CAHirt9jqJadEswetd06xdYQhc20vLr7QVz2zqORyoQUBBi3m-Q@mail.gmail.com>
Subject: Re: Why the edge-triggered mode doesn't work for epoll file descriptor?
To:     Eric Wong <e@80x24.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Thank you reply.

On Mon, Aug 26, 2019 at 2:22 PM Eric Wong <e@80x24.org> wrote:
>
> Heiher <r@hev.cc> wrote:
> > Hello,
> >
> > I've added a pipe file descriptor (fd1) to an epoll (fd3) with
> > EPOLLOUT in edge-triggered mode, and then added the fd3 to another
> > epoll (fd4) with EPOLLIN in edge-triggered too.
> >
> > Next, waiting for fd4 without timeout. When fd1 to be writable, i
> > think epoll_wait(fd4, ...)  only return once, because all file
> > descriptors are added in edge-triggered mode.
> >
> > But, the actual result is returns many and many times until do once
> > eopll_wait(fd3, ...).
>
> It looks like you can trigger a wakeup loop with printf writing
> to the terminal (not a pipe), and that write to the terminal
> triggering the EPOLLOUT wakeup over and over again.
>
> I don't know TTY stuff at all, but I assume it's intended
> for terminals.
>
> You refer to "pipe file descriptor (fd1)", but I can't reproduce
> the error when running your code piped to "tee" and using
> strace to check epoll_wait returns.
>
> "strace ./foo | tee /dev/null" only shows one epoll_wait returning.
>
> >     e.events = EPOLLIN | EPOLLET;
> >     e.data.u64 = 1;
> >     if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
> >         return -3;
> >
> >     e.events = EPOLLOUT | EPOLLET;
> >     e.data.u64 = 2;
> >     if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
> >         return -4;
>
> Since epfd[1] is waiting for stdout...
>
> >     for (;;) {
> >         struct epoll_event events[16];
> >         int nfds;
> >
> >         nfds = epoll_wait (efd[0], events, 16, -1);
> >         printf ("nfds: %d\n", nfds);
>
> Try outputting your message to stderr instead of stdout:
>
>         fprintf(stderr, "nfds: %d\n", nfds);
>
> And then run your program so stdout and stderr point to
> different files:
>
>         ./foo | tee /dev/null
>
> (so stdout becomes a pipe, and stderr remains your terminal)

OK, Let's use a set of test cases without external interference to
indicate the problem.

epoll1.c:
#include <stdio.h>
#include <unistd.h>
#include <sys/epoll.h>
#include <sys/socket.h>

int
main (int argc, char *argv[])
{
    int sfd[2];
    int efd[2];
    struct epoll_event e;

    if (socketpair (AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
        return -1;

    efd[0] = epoll_create (1);
    if (efd[0] < 0)
        return -2;

    efd[1] = epoll_create (1);
    if (efd[1] < 0)
        return -3;

    e.events = EPOLLIN | EPOLLET;
    e.data.u64 = 1;
    if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
        return -3;

    e.events = EPOLLIN;
    e.data.u64 = 2;
    if (epoll_ctl (efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
        return -4;

    /**
     * Current structure:
     *     efd[0]:
     *     {
     *         efd[1] (EPOLLIN | EPOLLET):
     *         {
     *             sfd[0] (EPOLLIN)
     *         }
     *     }
     */

    /* Make the sfd[0] is readable */
    if (write (sfd[1], "a", 1) != 1)
        return -5;

    for (;;) {
        struct epoll_event events[16];
        int nfds;

        /**
         * IIRC, the epoll_wait(efd[0]) returns while efd[1] events
changed only,
         *
         * so, the first call should be returned, because sfd[0] from
not readable
         * to readable.
         *
         * and then the calls should be blocked, because not any fd's event
         * changed in efd[1] pool, and efd[1] is working in edge-triggerd mode,
         * so, efd[1]'s event not changed.
         */
        nfds = epoll_wait (efd[0], events, 16, -1);
        printf ("nfds: %d\n", nfds);
    }

    close (efd[1]);
    close (efd[0]);
    close (sfd[0]);
    close (sfd[1]);

    return 0;
}

epoll2.c:
#include <stdio.h>
#include <unistd.h>
#include <sys/epoll.h>
#include <sys/socket.h>

int
main (int argc, char *argv[])
{
    int sfd[2];
    int efd;
    struct epoll_event e;

    if (socketpair (AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
        return -1;

    efd = epoll_create (1);
    if (efd < 0)
        return -2;

    e.events = EPOLLIN | EPOLLET;
    e.data.u64 = 1;
    if (epoll_ctl (efd, EPOLL_CTL_ADD, sfd[0], &e) < 0)
        return -3;

    /**
     * Current structure:
     *     efd:
     *     {
     *         sfd[0] (EPOLLIN | EPOLLET)
     *     }
     */

    /* Make the sfd[0] is readable */
    if (write (sfd[1], "a", 1) != 1)
        return -5;

    for (;;) {
        struct epoll_event events[16];
        int nfds;

        nfds = epoll_wait (efd, events, 16, -1);
        printf ("nfds: %d\n", nfds);
    }

    close (efd);
    close (sfd[0]);
    close (sfd[1]);

    return 0;
}

I don't know why the epoll1 prints many and many times, i think the
epoll2 is correctly behavior.

-- 
Best regards!
Hev
https://hev.cc
