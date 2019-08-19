Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285D491A8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHSA6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 20:58:19 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43638 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHSA6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:58:19 -0400
Received: by mail-lj1-f170.google.com with SMTP id h15so132256ljg.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Aug 2019 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAWLA6RndFaNzG8rdPLbOXymqdUVzWZhT6YCM9vqWCY=;
        b=df9ezSH6JtFuameOXtvnUSlJUImajdAavNOPHNXMzUM/qXtlU48707BWIBLOKeH93F
         kLbZIMi33jMeuWVUcqpfoSwjmaMWvDx9VVXg2qv0Bv6R3GdDXXME+otkbkLosPILaA6u
         GKNcwX9zGUSCDENvH8v92rMU9Ekj2PxQCRkQuQUHZ9b/45Aca4eWEG8+NuKI8BeXR0vB
         basnKSN6+IZXibOE5VNU9I5lSyI3C2Aa+TYZMNULZs46MIlbfBzfM8v/NzfL9btl2i/Y
         Y1PdcmiDD9UmgI/4Kx8mNUNChU2WNAfci3X0WDieWW3EiIy0itzkgplovT2ZCpjDfRh5
         2RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAWLA6RndFaNzG8rdPLbOXymqdUVzWZhT6YCM9vqWCY=;
        b=nJmikdPGp59Ku0hq/s2vdtK7mhCj7p7lzxn+d0YAGa2UZWddgQXBrbiZLE00Cay0O5
         BeG+ZsmY+qlxmQasxHpVXivEZIO0q6fUtQ3fCVBZLsvCiJBCy7O4GL+oPSPMaIvOsJ1Y
         u/I2ssXvJMJkTbvqttST4BFachbLoLqwEEgoK6SPRZQwdUTfg08IUCUuaXxaCc6ih9Bj
         skCg0t/ZY28lh748wXLHtb2agT3+GFHlaJe/4BwoRjJW6P4+asdEuBz4ts8mycGBIzeH
         nZfqiOzMGF2ZD8HYkXdXMvwi1eHOSIh+bCCnRFNcepVUl9SF6t8yk7UWUw4PV6mJER1P
         7BNw==
X-Gm-Message-State: APjAAAX3812UoBJe6B6meHeTk8Fufv99lvTEjmxPrfO+p1t9s6UiBemf
        ThAHzRxUA/gp6CxYo6W89xAZBBrYrmXXbxXkNdRHhQ==
X-Google-Smtp-Source: APXvYqx2BS0WUUTEE3Z0Uus3hGRJind//UzqEc3IEWlMUjgggQOHwAdYJHApM88G3FoZ2eW3O+JcsbvbD0NDOiZUl9A=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr11245217ljm.5.1566176296975;
 Sun, 18 Aug 2019 17:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
In-Reply-To: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
From:   Heiher <r@hev.cc>
Date:   Mon, 19 Aug 2019 08:58:04 +0800
Message-ID: <CAHirt9jvRPjg=PPJEso-gKhXBto3=MPu_+50D+L=6O35M0BzBw@mail.gmail.com>
Subject: Re: Why the edge-triggered mode doesn't work for epoll file descriptor?
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 12:36 AM Heiher <r@hev.cc> wrote:
>
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
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/epoll.h>
>
> int
> main (int argc, char *argv[])
> {
>     int efd[2];
>     struct epoll_event e;
>
>     efd[0] = epoll_create (1);
>     if (efd[0] < 0)
>         return -1;
>
>     efd[1] = epoll_create (1);
>     if (efd[1] < 0)
>         return -2;
>
>     e.events = EPOLLIN | EPOLLET;
>     e.data.u64 = 1;
>     if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>         return -3;
>
>     e.events = EPOLLOUT | EPOLLET;
>     e.data.u64 = 2;
>     if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
>         return -4;
>
>     for (;;) {
>         struct epoll_event events[16];
>         int nfds;
>
>         nfds = epoll_wait (efd[0], events, 16, -1);
>         printf ("nfds: %d\n", nfds);
>     }
>
>     close (efd[1]);
>     close (efd[0]);
>
>     return 0;
> }
>
> --
> Best regards!
> Hev
> https://hev.cc

Is this behavior correct? any help?

-- 
Best regards!
Hev
https://hev.cc
