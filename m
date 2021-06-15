Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46D3A8A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFOUoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOUoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:44:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498BC061574;
        Tue, 15 Jun 2021 13:42:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n7so71072wri.3;
        Tue, 15 Jun 2021 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAu3ozR84KQRdo/U/w7tof5X6RiMkqtDwsPFH++lu/M=;
        b=Pk3lmwL9+Rep0jwZPCRTzXT+0Ge2r/rjSgIHiPMluvWtM/50PEx/sHD0y4zXHUJCP4
         SDK+KHNRbQ03+JWJguZWyfOIpwXcsSy5tUpAsTuk+jOU8wZcl2EAGoT4RJZ+806lIBbS
         MuA48saiiqenbo3xRtYa+tg/wGhDglCXwZTHdabaZbdYIy5e7yOQKCWAzoKDcyViMg8/
         RbBN82jV8Qi3ljtjQumfAGHqxmwemFPQZiRZQod9T5s2kYy39NQFDnT61uLoopcHVl7E
         0dGNoSjRbJFdtmaIaGTcF1Uwo/DA9UqF1hftl/cbLSyq+NHw97YEu4eSd6menSyqpGJb
         Hefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAu3ozR84KQRdo/U/w7tof5X6RiMkqtDwsPFH++lu/M=;
        b=AI2wxWCryey1JD0wzllyY7x9C99zzjBi4mb5sBazaSxeHH7FwjM7JZsTfKr2xFS7Na
         DYmVNQ6pSvHvfxrnlmbmS9q3vBO88CUCNlm2m18Fpx8q3V0jKGizHMzxVzo5IEajc5mG
         h/32R3w0W8ac/WdUWnNZlRML5FARSCWDXdqzk63efbZNW4Xh5W4tZy52mp8b88oDuXTM
         cve+tKO+T4el464V95r0eoFtO09tbVK2nS7Ht/JTHDTZuQzsDfUowUHZjy4T8CvVj42J
         TrFmht9xiqS+kWkAR05Gvp8hj6ujlI5Chd26Az3WD/qtJHOx3lxgBt1ID+V/sgK+ccT1
         poog==
X-Gm-Message-State: AOAM532OhXwGkHDROLOCHk0fMhUJ+n1/bbonuxYFfRR55yWZCfUrv5h1
        Ye3vxf1Q+8NpqSHtOFGD2HuyKSN/V5PqUCA/9+8=
X-Google-Smtp-Source: ABdhPJz5SzqRUkv2m2I5CHcW1PqsieUOQmTTKErdLg27dMIK8eZ6FlZa95S8hLk/zO5EEwJQNGIpIHnJ2Q6JQeTmQnM=
X-Received: by 2002:adf:ef06:: with SMTP id e6mr1072930wro.393.1623789758704;
 Tue, 15 Jun 2021 13:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210615154952.2744-1-justin.he@arm.com>
In-Reply-To: <20210615154952.2744-1-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Jun 2021 23:42:22 +0300
Message-ID: <CAHp75Vc+QkpuCAXba=Q2Nbv4zKmk_YqW1qTiLVd80BHM_uTV=Q@mail.gmail.com>
Subject: Re: [PATCH RFCv4 0/4] make '%pD' print full path for file
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 6:54 PM Jia He <justin.he@arm.com> wrote:
>
> Background
> ==========
> Linus suggested printing full path for file instead of printing

the full
the file

> the components as '%pd'.
>
> Typically, there is no need for printk specifiers to take any real locks
> (ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
> which is similar to d_path except it doesn't take any seqlock/spinlock.
>
> This series is based on Al Viro's d_path cleanup patches [1] which
> lifted the inner lockless loop into a new helper.
>
> [1] https://lkml.org/lkml/2021/5/18/1260
>
> Test
> ====
> The cases I tested:
> 1. print '%pD' with full path of ext4 file
> 2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
>    with '%pD'
> 3. all test_print selftests, including the new '%14pD' '%-14pD'
> 4. kasnprintf

kasprintf()

After commenting on patch 1, I suggest you to always build with `make W=1 ...`

> Changelog
> =========
> v4:
> - don't support spec.precision anymore for '%pD'
> - add Rasmus's patch into this series
>
> v3:
> - implement new d_path_unsafe to use [buf, end] instead of stack space for
>   filling bytes (by Matthew)
> - add new test cases for '%pD'
> - drop patch "hmcdrv: remove the redundant directory path" before removing rfc.
>
> v2:
> - implement new d_path_fast based on Al Viro's patches
> - add check_pointer check (by Petr)
> - change the max full path size to 256 in stack space
> v1: https://lkml.org/lkml/2021/5/8/122
>
> Jia He (4):
>   fs: introduce helper d_path_unsafe()
>   lib/vsprintf.c: make '%pD' print full path for file
>   lib/test_printf.c: split write-beyond-buffer check in two
>   lib/test_printf.c: add test cases for '%pD'
>
>  Documentation/core-api/printk-formats.rst |  5 +-
>  fs/d_path.c                               | 83 ++++++++++++++++++++++-
>  include/linux/dcache.h                    |  1 +
>  lib/test_printf.c                         | 31 ++++++++-
>  lib/vsprintf.c                            | 37 ++++++++--
>  5 files changed, 148 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
