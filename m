Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741932766B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 04:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCAD3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 22:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhCAD3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 22:29:05 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BCC06174A;
        Sun, 28 Feb 2021 19:28:24 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o9so1293196iow.6;
        Sun, 28 Feb 2021 19:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wjuVE9rkoB4BCxQ+/SSuF8tCgj5rnrmcP3wnrRsJ4uQ=;
        b=SeLcm9CVqj7/XDy75fsb8yRw8TrGRRMKi8yM4QG5LwP6FRYt02MawJlXFMMVSSxDz3
         pHryoVN0yMw8BFil36PLbNf0vnqLm+/ks88Hqh/1yPYrPCXxNFsdu85KSmjRrdeLpQCO
         gJdLNmuah426Dkp6ma37gFspWBXPZQsN+Ljm3gR/6ND3sLsmprD9pJgkLAhy2dC6rxHz
         7ghJNuQUawIbI9BWOPGlDwcBzectzXYr9f0i4knh3TEaa/iP56d/LAIZn32NJzj1BRVH
         V2P97tvNt/ey0Iq9CWvn7yLLasOs5I9bYTBkb7ol3WvzmWv61ZXmN5WNVF4OnrxoAFX2
         1GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wjuVE9rkoB4BCxQ+/SSuF8tCgj5rnrmcP3wnrRsJ4uQ=;
        b=spC9IcgvR810xoyvqsCE/Yz0PvfELL2hq463/pPTbWaG0kJ9Yj4nT8CLMCPh+0FGmy
         jdhRvn+pWyV3kiM/BCcby03VoH/ZJvWJAXNiXiiCEq9yNf8jd37EluFsVuawKxdI3V4+
         C78K6tZs7e7XuvU5Ai6CdQRnASVMbIQ3Ez7lgjE44508tmwxpwdBRn35HPOD6kVs4AG2
         lUcQ5mJOwhYzKtqLXxy+X1RYYitefJqwQH8sQ/+v4KoHNI9afPs0NsjMQXqCA5I0ihNm
         0pf6IWwLBv9uRi7jMvOWzatNoqAXUD6CP98mlENn4e6ZJ7sCQkFpQ5ds08K/pepJQXwF
         fWDw==
X-Gm-Message-State: AOAM531QTYZjC32QbGMpIZc8z14y7JfxbkGSiSeP4UDco/7BMpinZj+o
        Bu1vTfin6nRtKu1ibrJd9YOZwAs1iMIms9+RyXA=
X-Google-Smtp-Source: ABdhPJwwVYncl53K6oH0HvaIuOWdAPwe3n7uOtB4J+XOFfIU04ucS0ACv4wY5ItLL2QO7T0bGonABwHRqeufo+y+8uk=
X-Received: by 2002:a02:9645:: with SMTP id c63mr3328914jai.84.1614569304182;
 Sun, 28 Feb 2021 19:28:24 -0800 (PST)
MIME-Version: 1.0
From:   Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Date:   Sun, 28 Feb 2021 19:28:13 -0800
Message-ID: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
Subject: exec error: BUG: Bad rss-counter
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric, All,

The following error appears when running Linux 5.10.18 on an embedded
MIPS mt7621 target:
[    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1

Being a very generic error, I started digging and added a stack dump
before the BUG:
Call Trace:
[<80008094>] show_stack+0x30/0x100
[<8033b238>] dump_stack+0xac/0xe8
[<800285e8>] __mmdrop+0x98/0x1d0
[<801a6de8>] free_bprm+0x44/0x118
[<801a86a8>] kernel_execve+0x160/0x1d8
[<800420f4>] call_usermodehelper_exec_async+0x114/0x194
[<80003198>] ret_from_kernel_thread+0x14/0x1c

So that's how I got to looking at fs/exec.c and noticed quite a few
changes last year. Turns out this message only occurs once very early
at boot during the very first call to kernel_execve. current->mm is
NULL at this stage, so acct_arg_size() is effectively a no-op.

More digging, and I traced the RSS counter increment to:
[<8015adb4>] add_mm_counter_fast+0xb4/0xc0
[<80160d58>] handle_mm_fault+0x6e4/0xea0
[<80158aa4>] __get_user_pages.part.78+0x190/0x37c
[<8015992c>] __get_user_pages_remote+0x128/0x360
[<801a6d9c>] get_arg_page+0x34/0xa0
[<801a7394>] copy_string_kernel+0x194/0x2a4
[<801a880c>] kernel_execve+0x11c/0x298
[<800420f4>] call_usermodehelper_exec_async+0x114/0x194
[<80003198>] ret_from_kernel_thread+0x14/0x1c

In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.

How is fs/exec.c supposed to handle implied RSS increments that happen
due to page faults when discarding the bprm structure? In this case,
the bug-generating kernel_execve call never succeeded, it returned -2,
but I didn't trace exactly what failed.

Interestingly, this "BUG:" message is timing-dependent. If I wait a
bit before calling free_bprm after bprm_execve the message seems to go
away (there are 3 other cores running and calling into kernel_execve
at the same time, so there is that). The error also only ever happens
once (probably because no more page faults happen?).

I don't know enough to propose a proper fix here. Is it decrementing
the bprm->mm RSS counter to account for that page fault? Or is
current->mm being NULL a bigger problem?

Apologies in advance, but I have looked hard and do not see a clear
resolution for this even in the latest kernel code.

- Ilya
