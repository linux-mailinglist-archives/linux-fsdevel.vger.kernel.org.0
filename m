Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44BA2215CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGOUKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGOUKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:10:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D70C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 13:10:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bm28so2635983edb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBZwz/iJDyturYfYwj1u5a/ly72Q32flNreT+u4AFMs=;
        b=oZxSTMfMImLKJUtIiMgUf5gj0cNhaT6bR7vnph9913MaReYlVEart7NBd42sLC0ROc
         KBhL/e4b6KJXNBPowk8KgMKzFPs37ZxVr9V7P2136toqRe8FJ3BrPPUVqJR2abR1Fj60
         ycFHshZU5Shfy9PmwmEgB16QqoRI0ZTGrJsdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBZwz/iJDyturYfYwj1u5a/ly72Q32flNreT+u4AFMs=;
        b=WuPSnW5adbBtliWhWbYEdLqv4wH41HYt9zzzA1wXjS6LIeock3AH19HrSDz2kVWloG
         L8eydo1HGktRNQLsSF6zGf8A7hQDJgNSYgctjbMqwi7ao/zyErbgMXmhX1pHdgoPg3YC
         Z65FqmWYerbBWQRhvivcQtUV0roJicL2dw+DY0EqY3A5fbhwMTCWZIQW9VLUQ9QNN52D
         43/w1eZj8/TLfsfdxXzbU631gFaIiUf+/SgS6iDiKO5NJicy43ndsvxCJ8uYY95b4Jmf
         UCxqliwmJFZblT4m+trtAEoM4x1sLfSqwAYUJvdpBLM2WhJvMZTHioRbT7zXYmSNm+xm
         AuQw==
X-Gm-Message-State: AOAM531Suuc8ZnejALJZu0EpE2H3ulKbJP83udtnaeZVtsyOoSpSh2CI
        fdYsIkJ4Fmc9UqHCDOKiWVca0djitif/OeOpjlBTmA==
X-Google-Smtp-Source: ABdhPJxmiwfGPdXuAL/Cm/iBN4GQDNpUgVqb1mhfqKEEu8zlIX3pRbGp59TjObNIRuwsiYpzoCYIpAxQXU0MuNuaGEM=
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr1329981edo.161.1594843805238;
 Wed, 15 Jul 2020 13:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net> <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
In-Reply-To: <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 22:09:54 +0200
Message-ID: <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
Subject: Re: strace of io_uring events?
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 9:43 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> To clear details for those who are not familiar with io_uring:
>
> io_uring has a pair of queues, submission (SQ) and completion queues (CQ),
> both shared between kernel and user spaces. The userspace submits requests
> by filling a chunk of memory in SQ. The kernel picks up SQ entries in
> (syscall io_uring_enter) or asynchronously by polling SQ.
>
> CQ entries are filled by the kernel completely asynchronously and
> in parallel. Some users just poll CQ to get them, but also have a way
> to wait for them.
>
> >>>
> >>> What do people think?
> >>>
> >>> From what I can tell, listing the submitted requests on
> >>> io_uring_enter() would not be hard.  Request completion is
> >>> asynchronous, however, and may not require  io_uring_enter() syscall.
> >>> Am I correct?
>
> Both, submission and completion sides may not require a syscall.

Okay.

> >>> Is there some existing tracing infrastructure that strace could use to
> >>> get async completion events?  Should we be introducing one?
>
> There are static trace points covering all needs.

This needs to be unprivileged, or its usefulness is again compromized.

>
> And if not used the whole thing have to be zero-overhead. Otherwise
> there is perf, which is zero-overhead, and this IMHO won't fly.

Obviously it needs to be zero overhead if not tracing.

What won't fly?

Thanks,
Miklos
