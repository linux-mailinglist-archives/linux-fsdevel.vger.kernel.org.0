Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B26302299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 08:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbhAYH4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 02:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbhAYHz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:55:56 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB2BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 23:54:43 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id f22so6701916vsk.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=shLCHFFMB4DAp0A0ILgc+eh2S2wXCYfyelqnf4KL6us=;
        b=Px9KUJsGwJ+VtNulQrpo/gNubEPUdjzL9axWZwpaxfB/oLoVrtc0t1GYJCMzKHcXDV
         9l6qQIgZcF4L1+IAccLk1ZVIAxm/s0IaiWoE+lC4RDtEB8AVaSimH+KNn/RfinTLPu3C
         fQeytqMsM3ShLU1d/TSI7rWDnJmmkSacvXy3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=shLCHFFMB4DAp0A0ILgc+eh2S2wXCYfyelqnf4KL6us=;
        b=Tqrm2UECUt3KOot04FMCi+8MPohnvkl0EwtdFN6IKoo4/W8Ygg9zE0RWFYxjOTyKay
         MEvs2etL8zeBg50aNEYdLFVzbMX0WowsUMKSWafz6euAwwi9rt+6JEuqMQzlmCzoj79g
         o+p8xYy7lYM/jlz8QC2UobuPVkRzScCQdsAfjdLkcxuA5XuIRD+kib7sZMSC2+vpBfnj
         DvHtFTu6OknFdFeNlID/DWHLtLJGb5mjTa2AH/uK8XncPmMOEYJtnNtQl8c0pg9aPt5s
         OoKvWM+vyBPQt1zYIWEnxEzKCkmCm0kAp7m9zDshOxdLpSZbHd36UOYWnpohnEGaojRK
         SAAg==
X-Gm-Message-State: AOAM531wanO7jUidFE61AbjNFgwDEw2pQFvJqmWcFmgkpft1P0+tQKA3
        T8DKAaELy7f329Dx5jqs3fG9Xi+nbbBIGjbuisd+cg==
X-Google-Smtp-Source: ABdhPJxq6uXHnDY4RVG3ffjbpATtyupiGISReVdidQGDUJdMst+TXrrJKK/Vy7bMu/1qDhBMrWXBpYi1MsH/3SjYMfE=
X-Received: by 2002:a67:6b46:: with SMTP id g67mr4296vsc.60.1611561282606;
 Sun, 24 Jan 2021 23:54:42 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 25 Jan 2021 15:54:31 +0800
Message-ID: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
Subject: [BUG] copy_file_range with sysfs file as input
To:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     Luis Lozano <llozano@chromium.org>, iant@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi copy_file_range experts,

We hit this interesting issue when upgrading Go compiler from 1.13 to
1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
`/sys/kernel/debug/tracing/trace` to a temporary file.

Under the hood, Go now uses `copy_file_range` syscall to optimize the
copy operation. However, that fails to copy any content when the input
file is from sysfs/tracefs, with an apparent size of 0 (but there is
still content when you `cat` it, of course).

A repro case is available in comment7 (adapted from the man page),
also copied below [2].

Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
5.10.3 (chromeos))
$ ./copyfrom /sys/kernel/debug/tracing/trace x
0 bytes copied
$ cat x
$ cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |

I can try to dig further, but thought you'd like to get a bug report
as soon as possible.

Thanks,

Nicolas

[1] http://issuetracker.google.com/issues/178332739
[2]
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>

int
main(int argc, char **argv)
{
        int fd_in, fd_out;
        loff_t ret;

        if (argc != 3) {
                fprintf(stderr, "Usage: %s <source> <destination>\n", argv[0]);
                exit(EXIT_FAILURE);
        }

        fd_in = open(argv[1], O_RDONLY);
        if (fd_in == -1) {
                perror("open (argv[1])");
                exit(EXIT_FAILURE);
        }

        fd_out = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0644);
        if (fd_out == -1) {
                perror("open (argv[2])");
                exit(EXIT_FAILURE);
        }

        ret = copy_file_range(fd_in, NULL, fd_out, NULL, 1024, 0);
        if (ret == -1) {
                perror("copy_file_range");
                exit(EXIT_FAILURE);
        }
        printf("%d bytes copied\n", (int)ret);

        close(fd_in);
        close(fd_out);
        exit(EXIT_SUCCESS);
}
