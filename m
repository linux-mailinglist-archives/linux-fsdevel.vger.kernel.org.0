Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0A302D16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAYTrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbhAYTpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:45:36 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9CC0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 11:44:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t8so9470498ljk.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WM7O3cFXlBvf9L+JSljulU1VqAKIV6MOBvv4sGCgAo=;
        b=bE4C3quK2HDDkj26kdNPWzzjWPJqC6vm0bloEDWUNyPFOUw/Hd2xJAzElEcs8nGEg0
         EjlC6Ers2ip8/6SQHU3BfPgXJM9zl4IGrcNx1WGwJze+7ej4FV4Lwr5QEsWkvkP0Ydpz
         1gHgEYj3p4d1BRXNyDsqZIkpi2texxN2333flJWGLuH/ZPiYmgXthyLOVooPEUUAkV9t
         3uMpIAsEfp6vEIj/zp0NgPom2Jfw2M36H8u0aNZ2jQStbcM6FMY2BdEFpuQOBw1TGqZS
         SB2KRxzk39vpuVtDPgtykyA7wthBxIlUvsP4/w6PDgG7PoD0Y+mqzDisdSv88bGGEL4h
         vFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WM7O3cFXlBvf9L+JSljulU1VqAKIV6MOBvv4sGCgAo=;
        b=cXu/YsNJ5BUA0ESRrpsw7/j8lQ6vGtgopW565wN/i95QOecHjTeRDxN6O70NLfpyFL
         5BInx4EEP/N2C+QwgnBVbhra9bKUzLnWO2rgzeAf4p/9ou+hMMsK9C5g/AgMd47cXwAS
         FUK4ewvrMKHpfVteqzkHEI9DGjBOCDCTYrkW85vlFli+Nblt7KeZhp0pdiHiVD6TKLvL
         E6NS/kgbYVe3AH6bSFrx6tZqM6kNn3FuZE5Jk/WREqWPoAmUWtK/rrEHUTt2YGrdzwFZ
         dHHr4gWXMhwoqLJBnzMlr9/NWD4/CB71Z5BCzpqzNgJGdg3u3vzYPCL/lu/rCuV44fe9
         hJZA==
X-Gm-Message-State: AOAM531Gm7nz/2c6CKMM2SO1v0xNu+NFDIL7XzUkH1ZrwTzWkYm2tiJo
        JIHrLiqbEqsPfwSAncLKs/aPZf+yP41drtLaiS7Sxg==
X-Google-Smtp-Source: ABdhPJyz7ezOW9tfl6zZZo+mvc87esNONMJ7E+44it5FYrCAKvXvoGtLXV+JdM1CXX8QLRo395Et0gTSFI2ObwYAtF0=
X-Received: by 2002:a2e:8005:: with SMTP id j5mr979607ljg.34.1611603893145;
 Mon, 25 Jan 2021 11:44:53 -0800 (PST)
MIME-Version: 1.0
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
In-Reply-To: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
From:   Ian Lance Taylor <iant@google.com>
Date:   Mon, 25 Jan 2021 11:44:39 -0800
Message-ID: <CAKOQZ8zDb8i+CetLbGEubWFs+C_4WOkKvNsS=g0OhSvk2tQuNg@mail.gmail.com>
Subject: Re: [BUG] copy_file_range with sysfs file as input
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the note.  I'm not a kernel developer, but to me this
sounds like a kernel bug.  It seems particularly unfortunate that
copy_file_range returns 0 in this case.  From the perspective of the
Go standard library, what we would need is some mechanism to detect
when the copy_file_range system call will not or did not work
correctly.  As the biggest hammer, we currently only call
copy_file_range on kernel versions 5.3 and newer.  We can bump that
requirement if necessary.

Please feel free to open a bug about this at https://golang.org/issue,
but we'll need guidance as to what we should do to avoid the problem.
Thanks.

Ian

On Sun, Jan 24, 2021 at 11:54 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Hi copy_file_range experts,
>
> We hit this interesting issue when upgrading Go compiler from 1.13 to
> 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> `/sys/kernel/debug/tracing/trace` to a temporary file.
>
> Under the hood, Go now uses `copy_file_range` syscall to optimize the
> copy operation. However, that fails to copy any content when the input
> file is from sysfs/tracefs, with an apparent size of 0 (but there is
> still content when you `cat` it, of course).
>
> A repro case is available in comment7 (adapted from the man page),
> also copied below [2].
>
> Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
> 5.10.3 (chromeos))
> $ ./copyfrom /sys/kernel/debug/tracing/trace x
> 0 bytes copied
> $ cat x
> $ cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>
> I can try to dig further, but thought you'd like to get a bug report
> as soon as possible.
>
> Thanks,
>
> Nicolas
>
> [1] http://issuetracker.google.com/issues/178332739
> [2]
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> int
> main(int argc, char **argv)
> {
>         int fd_in, fd_out;
>         loff_t ret;
>
>         if (argc != 3) {
>                 fprintf(stderr, "Usage: %s <source> <destination>\n", argv[0]);
>                 exit(EXIT_FAILURE);
>         }
>
>         fd_in = open(argv[1], O_RDONLY);
>         if (fd_in == -1) {
>                 perror("open (argv[1])");
>                 exit(EXIT_FAILURE);
>         }
>
>         fd_out = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
>         if (fd_out == -1) {
>                 perror("open (argv[2])");
>                 exit(EXIT_FAILURE);
>         }
>
>         ret = copy_file_range(fd_in, NULL, fd_out, NULL, 1024, 0);
>         if (ret == -1) {
>                 perror("copy_file_range");
>                 exit(EXIT_FAILURE);
>         }
>         printf("%d bytes copied\n", (int)ret);
>
>         close(fd_in);
>         close(fd_out);
>         exit(EXIT_SUCCESS);
> }
