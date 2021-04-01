Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8693B352433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 01:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhDAX5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 19:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhDAX5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:57:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BCC0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 16:57:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w11so1776209ply.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy2/xTXVJKlkuX9BqfC2ojvTowyICVdT5fVdC2LqXu4=;
        b=rS2UYcUSrJaE3MfeEbSFYQGFNF/Wk4Jp/ZKQAosuUoSDAWVf+/zVgmo5BoMw6Mi4Tn
         XmuAtrLExkN6Vt+sBWwFHQ1JAv/NhHm1c9Qq4gXViyDp9g2gT2st+s6+K+y5YiPwBq9s
         L1UtID066TnWA+8TWsoUBADRz7xAUpcs2mRt7rtIIqWfeeIpoF/P8jUvkC+96fBbREOH
         iuqjMTMz38CUWepvVNQKTw0DhE1ONOKsmJh9q0jbV6q32poX8QgYXineYYP0RjVYnQuH
         FKu5gjHHUqPX+2b2lNixUjCwcnG+iF1Bh32UhvqQjcAyB0PC4iCluwqvkmrUuCNtmynb
         d81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy2/xTXVJKlkuX9BqfC2ojvTowyICVdT5fVdC2LqXu4=;
        b=LsDsQv1L1xDE1LPrZCS4xzYva7l3fhcBX/4cxhtn1PF5tdZRof2SJXhQTZOymYYRXe
         tpptSJUkCEtjH4ZgG/EV/xKcHSMhpjRvX5K+tXvFCdQju8sNAlwfNNpxJWm3mhvnEDoh
         0H/tue4LeMJvjNkOerYoe6fbvlJFQ5k/+SOBRI4OHWVvyalaGokz/3Lx8ilYKcPQBant
         glX3ZZteXymna/gmznx18gBzV7qaSPpFskLwzgNzJaBCtHWKNohfMogd6fT1lLHEYrPn
         OExuOmHAR84UGq1hJ0tGktoDe8z2yPV6zbpAprPgBtY4Pk45ivNovVbcVmNMgLEF9/aU
         DFsQ==
X-Gm-Message-State: AOAM533HOYTpCKlgjSAWjvtNRVS/UK8kLSdvjWy+/sBxksD5sxB8c2PB
        k8ssk+k7tVqr9WRnbZ6WY8q9rL/lBKmuRhnSgdjjjw==
X-Google-Smtp-Source: ABdhPJzR0ydavgUoTRVpydEa351dtEGQYJSRhhF2NtrovKyJnkwtyEvuIX79CGWFgZkyxplfWD2RkhTfjXBuMJh2PF0=
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr11244551pjv.23.1617321453020;
 Thu, 01 Apr 2021 16:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401021645.2609047-1-varmam@google.com> <YGUv5yIBTFbwuTxB@zeniv-ca.linux.org.uk>
In-Reply-To: <YGUv5yIBTFbwuTxB@zeniv-ca.linux.org.uk>
From:   Manish Varma <varmam@google.com>
Date:   Thu, 1 Apr 2021 16:57:22 -0700
Message-ID: <CAMyCerJeZ0R4W1CjCRQQ5c_NhEUTyyH_xWism3YBhnzOJJkgXQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Improve eventpoll logging to stop indicting timerfd
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Wed, Mar 31, 2021 at 7:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Mar 31, 2021 at 07:16:45PM -0700, Manish Varma wrote:
> > timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> > it names them after the underlying file descriptor, and since all
> > timerfd file descriptors are named "[timerfd]" (which saves memory on
> > systems like desktops with potentially many timerfd instances), all
> > wakesources created as a result of using the eventpoll-on-timerfd idiom
> > are called... "[timerfd]".
> >
> > However, it becomes impossible to tell which "[timerfd]" wakesource is
> > affliated with which process and hence troubleshooting is difficult.
> >
> > This change addresses this problem by changing the way eventpoll
> > wakesources are named:
> >
> > 1) the top-level per-process eventpoll wakesource is now named "epoll:P"
> > (instead of just "eventpoll"), where P, is the PID of the creating
> > process.
> > 2) individual per-underlying-filedescriptor eventpoll wakesources are
> > now named "epollitemN:P.F", where N is a unique ID token and P is PID
> > of the creating process and F is the name of the underlying file
> > descriptor.
> >
> > All together that should be splitted up into a change to eventpoll and
> > timerfd (or other file descriptors).
>
> FWIW, it smells like a variant of wakeup_source_register() that would
> take printf format + arguments would be a good idea.  I.e. something
> like
>
> > +             snprintf(buf, sizeof(buf), "epoll:%d", task_pid);
> > +             epi->ep->ws = wakeup_source_register(NULL, buf);
>
>                 ... = wakeup_source_register(NULL, "epoll:%d", task_pid);
>
> etc.

Noted. I will fix this in the v3 patch.

Thanks,
Manish
