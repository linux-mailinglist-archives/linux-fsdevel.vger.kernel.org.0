Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6F9C95B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfHZGWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 02:22:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52088 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfHZGWa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:22:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D53A21F461;
        Mon, 26 Aug 2019 06:22:29 +0000 (UTC)
Date:   Mon, 26 Aug 2019 06:22:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Heiher <r@hev.cc>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Why the edge-triggered mode doesn't work for epoll file
 descriptor?
Message-ID: <20190826062229.pjvumg4ag3qwhji6@whir>
References: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Heiher <r@hev.cc> wrote:
> Hello,
> 
> I've added a pipe file descriptor (fd1) to an epoll (fd3) with
> EPOLLOUT in edge-triggered mode, and then added the fd3 to another
> epoll (fd4) with EPOLLIN in edge-triggered too.
> 
> Next, waiting for fd4 without timeout. When fd1 to be writable, i
> think epoll_wait(fd4, ...)  only return once, because all file
> descriptors are added in edge-triggered mode.
> 
> But, the actual result is returns many and many times until do once
> eopll_wait(fd3, ...).

It looks like you can trigger a wakeup loop with printf writing
to the terminal (not a pipe), and that write to the terminal
triggering the EPOLLOUT wakeup over and over again.

I don't know TTY stuff at all, but I assume it's intended
for terminals.

You refer to "pipe file descriptor (fd1)", but I can't reproduce
the error when running your code piped to "tee" and using
strace to check epoll_wait returns.

"strace ./foo | tee /dev/null" only shows one epoll_wait returning.

>     e.events = EPOLLIN | EPOLLET;
>     e.data.u64 = 1;
>     if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>         return -3;
> 
>     e.events = EPOLLOUT | EPOLLET;
>     e.data.u64 = 2;
>     if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
>         return -4;

Since epfd[1] is waiting for stdout...

>     for (;;) {
>         struct epoll_event events[16];
>         int nfds;
> 
>         nfds = epoll_wait (efd[0], events, 16, -1);
>         printf ("nfds: %d\n", nfds);

Try outputting your message to stderr instead of stdout:

        fprintf(stderr, "nfds: %d\n", nfds);

And then run your program so stdout and stderr point to
different files:

	./foo | tee /dev/null

(so stdout becomes a pipe, and stderr remains your terminal)
