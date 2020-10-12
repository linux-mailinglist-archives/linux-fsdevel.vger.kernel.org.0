Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C028BFE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgJLSjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgJLSjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:39:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445BC0613D0;
        Mon, 12 Oct 2020 11:39:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so2139037oie.12;
        Mon, 12 Oct 2020 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=R/gYxTsYJFdTQ38CkcW02MIpSzR9RPkG/h3hLnnndhY=;
        b=pZ8PPJfuk9F6Z1AKgc8pHbhiSMcYsSZFtzvTxccLwnMkYgT3/OEcNLvSKlFdJqD7P5
         HvTGWQXCYXJmqywSL6OdTP40wSp2fg8haeRIYlHlkJF2qHpYqBgFyJ2bjioLHqrQHtC1
         lhk78vwaSUg3NbnWnHZGwExASL/Rl1mIGG0qCEqJ5o48Je/qTAm8ZudczYHpCKN5QuPz
         TsLnz4nhcn4n245TZNoPHIoSHw9oZbQehh2IxWpl8MiM4U6I3nAZCU03O7i0Fm3DYFCu
         7mDq7v6Le2xMdp+42Vqjs292LnRFZBw+jOyDm4EyTligEGUh/unuN8aisX+z8VrNANP/
         nCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=R/gYxTsYJFdTQ38CkcW02MIpSzR9RPkG/h3hLnnndhY=;
        b=VelKh3AWxaFgt7GvZSSIGWAdTw+heIavlHTnURKKqHgSrST0NFZL/QXpFuE8XffEAa
         8vEWq35+HZEJZhRi2g5GK9aOZP04EqVI4FZkBSQmszSnbc4Iz/J1EOFXWLLLvsy4VUjQ
         VxEyZr9cQeuC8b3aEWptPhojRcLvO2ZbDkyf1lKYVUj+XCBPdEyMYTBwFfUH8NStRqz6
         REft5UJ70br3YpPjcFZxQyqOcJMzpLPh2gnzaSeahmnWw4QW1ggKVZ9x1B7RzlHuCka/
         ZPHLFbZnbH0CLy0xvKSGQjmGAkDsyS8LCQk4IGiY+X7g2ZosRGDU9H1WY16fL+zHzVZK
         l0hg==
X-Gm-Message-State: AOAM5308R80TIR4XIO+Z2RFFkiG/k7Yup0Gq81+KsAzayi/pHJJAvin0
        0+gOoTN2NwxKmJckkTDQKZPqH9GtvzgDZFtzX3Q=
X-Google-Smtp-Source: ABdhPJwcgUjAfcfxHqh9sGGJ577o7E+3OEBbUISmWiKBjAZPTlwZTf4GfCDmGknHmZg5F7JwQQD8LqB/iRBP7WbQJcA=
X-Received: by 2002:aca:bb41:: with SMTP id l62mr9681768oif.148.1602527994142;
 Mon, 12 Oct 2020 11:39:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 12 Oct 2020 20:39:41 +0200
Message-ID: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
Subject: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Linus,

Between Linux 5.4 and 5.5 a regression was introduced in the operation
of the epoll EPOLLET flag. From some manual bisecting, the regression
appears to have been introduced in

         commit 1b6b26ae7053e4914181eedf70f2d92c12abda8a
         Author: Linus Torvalds <torvalds@linux-foundation.org>
         Date:   Sat Dec 7 12:14:28 2019 -0800

             pipe: fix and clarify pipe write wakeup logic

(I also built a kernel from the  immediate preceding commit, and did
not observe the regression.)

The aim of ET (edge-triggered) notification is that epoll_wait() will
tell us a file descriptor is ready only if there has been new activity
on the FD since we were last informed about the FD. So, in the
following scenario where the read end of a pipe is being monitored
with EPOLLET, we see:

[Write a byte to write end of pipe]
1. Call epoll_wait() ==> tells us pipe read end is ready
2. Call epoll_wait() [again] ==> does not tell us that the read end of
pipe is ready

    (By contrast, in step 2, level-triggered notification would tell
    us the read end of the pipe is read.)

If we go further:

[Write another byte to write end of pipe]
3. Call epoll_wait() ==> tells us pipe read end is ready

The above was true until the regression. Now, step 3 does not tell us
that the pipe read end is ready, even though there is NEW input
available on the pipe. (In the analogous situation for sockets and
terminals, step 3 does (still) correctly tell us that the FD is
ready.)

I've appended a test program below. The following are the results on
kernel 5.4.0:

        $ ./pipe_epollet_test
        Writing a byte to pipe()
            1: OK:   ret = 1, events = [ EPOLLIN ]
            2: OK:   ret = 0
        Writing a byte to pipe()
            3: OK:   ret = 1, events = [ EPOLLIN ]
        Closing write end of pipe()
            4: OK:   ret = 1, events = [ EPOLLIN EPOLLHUP ]

On current kernels, the results are as follows:

        $ ./pipe_epollet_test
        Writing a byte to pipe()
            1: OK:   ret = 1, events = [ EPOLLIN ]
            2: OK:   ret = 0
        Writing a byte to pipe()
            3: FAIL: ret = 0; EXPECTED: ret = 1, events = [ EPOLLIN ]
        Closing write end of pipe()
            4: OK:   ret = 1, events = [ EPOLLIN EPOLLHUP ]

Thanks,

Michael

=====

/* pipe_epollet_test.c

   Copyright (c) 2020, Michael Kerrisk <mtk.manpages@gmail.com>

   Licensed under GNU GPLv2 or later.
*/
#include <sys/epoll.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

static void
printMask(int events)
{
    printf(" [ %s%s]",
                (events & EPOLLIN)  ? "EPOLLIN "  : "",
                (events & EPOLLHUP) ? "EPOLLHUP " : "");
}

static void
doEpollWait(int epfd, int timeout, int expectedRetval, int expectedEvents)
{
    struct epoll_event ev;
    static int callNum = 0;

    int retval = epoll_wait(epfd, &ev, 1, timeout);
    if (retval == -1) {
        perror("epoll_wait");
        return;
    }

    /* The test succeeded if (1) we got the expected return value and
       (2) when the return value was 1, we got the expected events mask */

    bool succeeded = retval == expectedRetval &&
            (expectedRetval == 0 || expectedEvents == ev.events);

    callNum++;
    printf("    %d: ", callNum);

    if (succeeded)
        printf("OK:   ");
    else
        printf("FAIL: ");

    printf("ret = %d", retval);

    if (retval == 1) {
        printf(", events =");
        printMask(ev.events);
    }

    if (!succeeded) {
        printf("; EXPECTED: ret = %d", expectedRetval);
        if (expectedRetval == 1) {
            printf(", events =");
            printMask(expectedEvents);
        }
    }
    printf("\n");
}

int
main(int argc, char *argv[])
{
    int epfd;
    int pfd[2];

    epfd = epoll_create(1);
    if (epfd == -1)
        errExit("epoll_create");

    /* Create a pipe and add read end to epoll interest list */

    if (pipe(pfd) == -1)
        errExit("pipe");

    struct epoll_event ev;
    ev.data.fd = pfd[0];
    ev.events = EPOLLIN | EPOLLET;
    if (epoll_ctl(epfd, EPOLL_CTL_ADD, pfd[0], &ev) == -1)
        errExit("epoll_ctl");

    /* Run some tests */

    printf("Writing a byte to pipe()\n");
    write(pfd[1], "a", 1);

    doEpollWait(epfd, 0, 1, EPOLLIN);
    doEpollWait(epfd, 0, 0, 0);

    printf("Writing a byte to pipe()\n");
    write(pfd[1], "a", 1);

    doEpollWait(epfd, 0, 1, EPOLLIN);

    printf("Closing write end of pipe()\n");
    close(pfd[1]);

    doEpollWait(epfd, 0, 1, EPOLLIN | EPOLLHUP);

    exit(EXIT_SUCCESS);
}


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
