Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E1A4168B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 02:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhIXALF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbhIXAKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:10:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D827C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 17:09:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y28so32704751lfb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKLY+5bNGiRz/82Uo56vZTCvhpy0d8iLAjs0wXOjirI=;
        b=mUy622lhBZq+g0q8n8qp89eDCX0F3ZmAh9k8+h1cvy9OOaSFtSqZx5Pm0HpvXRBus3
         giGmm+7B/oMrd5DwIEKod0yQEp6P/PGQQ1SGrWukFVzEYM0Me61+vtpSs6i5AgBHTgTD
         A0KyE4hPKZG9xLoJlL6pZ514TiFsvc5HFis8pBgS7feNiuu68UG/ol+od1N5Rxseeqcb
         iC6WG5ktgT7N1Me/OfNZJVOo/ECgo9cpknLc1JDYQdXmvU3gCnUd56slp2gr+FihxTtK
         DsAT+G6pMjgb8ZRPoOkIwR3AnP9SoQOPHffnYHBffhrLGfNhZsKcgpJEsfqcpkU+xH2Q
         eIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKLY+5bNGiRz/82Uo56vZTCvhpy0d8iLAjs0wXOjirI=;
        b=xratT2HVZ8QeklqQ/zAjULx4Im4ODYlRxysiV4Ur0hXtyeVYjIURlGraaScJ3Wtv0y
         hdwgmbG6KcwM00upeDaGAy7lnMSpwMpgJkQ8179CJN0lWLzgZg5En5BVO/2XeBbRDHyX
         p6p9cZeaIuhSlOMLcbmGEvexTOUil/Co9K65kdRUyccDh5VLvpL2msvWtZGTLOpFy+WX
         MeDC8zOOgBsoedTVqAyAIZVGZAFFyDTCoXEKWNI3RefmQ5vhMd9LXbwfi0xYoz7/rnWN
         ++4yAqHUP7MQY186JCA6zCPPzw8XR5H/LmmAKTG7rSguB5JeoS2NBWf8Gu0H6qegJtWj
         UHpA==
X-Gm-Message-State: AOAM533iUM+PVlYvknes+7Vqgtn1jZE+Cheikky9dYviw+4/zXzj5jnq
        TsQ/2bHwg6Y67S7noyR0kwsk9hmBxRe0NNcXytHbWg==
X-Google-Smtp-Source: ABdhPJwosSyOPNtotuvTyCohiFYik6xHgNTRClACdGfEGxs7B+l9q3IC83lvVTpLCKZ56Zey5vbe6UTuNrtNUUc8S/o=
X-Received: by 2002:a05:651c:101:: with SMTP id a1mr8322528ljb.459.1632442151367;
 Thu, 23 Sep 2021 17:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210923233105.4045080-1-keescook@chromium.org> <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
In-Reply-To: <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Sep 2021 02:08:45 +0200
Message-ID: <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 1:59 AM Vito Caputo <vcaputo@pengaru.com> wrote:
> On Thu, Sep 23, 2021 at 04:31:05PM -0700, Kees Cook wrote:
> > The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> > years now[1]. As this remains a potential leak of either kernel
> > addresses (when symbolization fails) or limited observation of kernel
> > function progress, just remove the contents for good.
> >
> > Unconditionally set the contents to "0" and also mark the wchan
> > field in /proc/$pid/stat with 0.
> >
> > This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> > again, since this was broken for 4 years, was this profiling logic
> > actually doing anything useful?
> >
> > [1] https://lore.kernel.org/lkml/20210922001537.4ktg3r2ky3b3r6yp@treble/
> >
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Vito Caputo <vcaputo@pengaru.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> <snip>
>
>
> Please don't deliberately break WCHANs wholesale.  This is a very
> useful tool for sysadmins to get a vague sense of where processes are
> spending time in the kernel on production systems without affecting
> performance or having to restart things under instrumentation.

Wouldn't /proc/$pid/stack be more useful for that anyway? As long as
you have root privileges, you can read that to get the entire stack,
not just a single method name.

(By the way, I guess that might be an alternative to ripping wchan out
completely - require CAP_SYS_ADMIN like for /proc/$pid/stack?)
