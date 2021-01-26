Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2674A3034F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbhAZFae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbhAZDvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:51:42 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF8C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 19:51:02 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id j67so3606298vkh.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 19:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERr5chMqnNNOJKWjJQq+7FvSss//dhrARZABMDducAA=;
        b=W/5lZiBQNy1JWJYiV5a6JWLJcRKAUyoKq3slnRqZSP4vOjPev+cn+lNyupPDziwn9w
         6+WUe48shBn7tR9tR/udXYSJT0Dww3knoEu2UWFmh1ZQQlAQst0b15RVbB0Hrl/7QD3D
         mRUVvAHou5iwmkNVsSVglunqWxGATL+TT9hgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERr5chMqnNNOJKWjJQq+7FvSss//dhrARZABMDducAA=;
        b=R3noRtMsR7mJ423ObBzCeuySyHeELVeG5htKJfHj5WZHDnFPKQZRIT7Yq7LHSwdkDR
         BV7D8taAxML+4hf2rm7sFLJXBime+vQxyn2DLfxySr8VCfJgoxRl6MOs28ZPfdnYJMYE
         7khLJwwI+Auim7yECjQXz0bLdSroPHqUxqInxjHOUB7CzSEWoRlNShEw8UyRHTS754Cf
         fZl1OK2QEf9+5xWL29rPTQ7suly+59hAiSFSRm8VZsnXgzM18d2DiVHa3xYVVeZKCghj
         4g+l1+Mscm5Lx/eCMGcamolLL1omW0ZYF+pu4sZusqyUVty2aaAQuQb72TCjUQbEjuQz
         3srA==
X-Gm-Message-State: AOAM531ixgJDmkPdNXzE/4O6CaYW1OdxpIFpnQvcRDinDDWF+AZDOOv7
        +WoA4hE11PQmzk82N39rArj9FYmsa8nB9uv+DxUysQ==
X-Google-Smtp-Source: ABdhPJz69r02bEWD3eKp0baSYASMm3Qknvcg9NadY9ZzXeYK9s/g659l+yUCcvs8dDhMVq9K3yZ9udvKzrJCk0SJcmw=
X-Received: by 2002:ac5:ce9b:: with SMTP id 27mr3045021vke.9.1611633061185;
 Mon, 25 Jan 2021 19:51:01 -0800 (PST)
MIME-Version: 1.0
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
 <20210126013414.GE4626@dread.disaster.area>
In-Reply-To: <20210126013414.GE4626@dread.disaster.area>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 26 Jan 2021 11:50:50 +0800
Message-ID: <CANMq1KAgD_98607w308h3QSGaiRTkyVThmWmUuExxqh3r+tZsA@mail.gmail.com>
Subject: Re: [BUG] copy_file_range with sysfs file as input
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>, iant@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> > Hi copy_file_range experts,
> >
> > We hit this interesting issue when upgrading Go compiler from 1.13 to
> > 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> > `/sys/kernel/debug/tracing/trace` to a temporary file.
> >
> > Under the hood, Go now uses `copy_file_range` syscall to optimize the
> > copy operation. However, that fails to copy any content when the input
> > file is from sysfs/tracefs, with an apparent size of 0 (but there is
> > still content when you `cat` it, of course).
> >
> > A repro case is available in comment7 (adapted from the man page),
> > also copied below [2].
> >
> > Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
> > 5.10.3 (chromeos))
> > $ ./copyfrom /sys/kernel/debug/tracing/trace x
> > 0 bytes copied
>
> That's basically telling you that copy_file_range() was unable to
> copy anything. The man page says:
>
> RETURN VALUE
>        Upon  successful  completion,  copy_file_range() will return
>        the number of bytes copied between files.  This could be less
>        than the length originally requested.  If the file offset
>        of fd_in is at or past the end of file, no bytes are copied,
>        and copy_file_range() returns zero.
>
> THe man page explains it perfectly.

I'm not that confident the explanation is perfect ,-)

How does one define "EOF"? The read manpage
(https://man7.org/linux/man-pages/man2/read.2.html) defines it as a
zero return value. I don't think using the inode file size is
standard. Seems like the kernel is not even trying to read from the
source file here.

In any case, I can fix this issue by dropping the count check here:
https://elixir.bootlin.com/linux/latest/source/fs/read_write.c#L1445 .
I'll send a patch so that we can discuss based on that.

> Look at the trace file you are
> trying to copy:
>
> $ ls -l /sys/kernel/debug/tracing/trace
> -rw-r--r-- 1 root root 0 Jan 19 12:17 /sys/kernel/debug/tracing/trace
> $ cat /sys/kernel/debug/tracing/trace
> tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>
> Yup, the sysfs file reports it's size as zero length, so the CFR
> syscall is saying "there's nothing to copy from this empty file" and
> so correctly is returning zero without even trying to copy anything
> because the file offset is at EOF...
>
> IOWs, there's no copy_file_range() bug here - it's behaving as
> documented.
>
> 'cat' "works" in this situation because it doesn't check the file
> size and just attempts to read unconditionally from the file. Hence
> it happily returns non-existent stale data from busted filesystem
> implementations that allow data to be read from beyond EOF...

`cp` also works, so does `dd` and basically any other file operation.

(and I wouldn't call procfs, sysfs, debugfs and friends "busted", they
are just... special)


>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
