Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE71D99D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgESOcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 10:32:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46918 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 10:32:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id b3so4520765oib.13;
        Tue, 19 May 2020 07:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abHSSr+FE4mwVPeVCc+1hZ1CV3QH4VBasK3yRu00G8w=;
        b=oaGeqlKaZ8FujpIeSZRhUs2PoG3Asm4GAYsfjiPkX/1z0yAOmVTWfRupmy0oBAo+TX
         OW45xYUeqiu0lQKTSUrt6Zm0VGfDPCMiP9nsRoIWM035WlIhBs5Ej4PiCvhgRaNiwHPP
         A1eMWyliH2kOImfaUXGJ3PNH5zHKeCWeqjDi/VCJkDIDPeafVp6pbg0Lds0oJqNNpT49
         S+7wppebosENFswBh80N9hLcqi6yVKXsY1iSdu9uhQtnmLOyikSnNf2XPjn/HI6e0agK
         RpjIVpEbNsYyASpi1JsRB2YpIw8Fx/w9M6xlZl88oZOPUS2S3Ls8rcT2f+YnE154dPw/
         7LWA==
X-Gm-Message-State: AOAM533eCqVK6uiruvhbB1qoigSo+dmoUfm/W4e7rQNyZ94WFgtixhsP
        vk9hYblhSfKrL27X4DLKvcaXE53tA1EzYHwe0Cw=
X-Google-Smtp-Source: ABdhPJx5xpaNUb44KFms9IJ3GzKK63OnX4HawXvL1bIDgomSjsEfyzELox7IqozrkRT0A93QxuZvt9nAfcPrRCUr8bQ=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr3227937oig.148.1589898770045;
 Tue, 19 May 2020 07:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200518055457.12302-1-keescook@chromium.org> <20200518055457.12302-2-keescook@chromium.org>
 <20200518130251.zih2s32q2rxhxg6f@wittgenstein> <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
 <20200518144627.sv5nesysvtgxwkp7@wittgenstein> <87blmk3ig4.fsf@x220.int.ebiederm.org>
 <87mu64uxq1.fsf@igel.home> <87sgfwuoi3.fsf@x220.int.ebiederm.org> <20200519131341.qiysndpmj75zfjtz@wittgenstein>
In-Reply-To: <20200519131341.qiysndpmj75zfjtz@wittgenstein>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 May 2020 16:32:38 +0200
Message-ID: <CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Tue, May 19, 2020 at 3:15 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Tue, May 19, 2020 at 06:56:36AM -0500, Eric W. Biederman wrote:
> > Andreas Schwab <schwab@linux-m68k.org> writes:
> > > On Mai 18 2020, Eric W. Biederman wrote:
> > >> If it was only libc4 and libc5 that used the uselib system call then it
> > >> can probably be removed after enough time.
> > >
> > > Only libc4 used it, libc5 was already ELF.
> >
> > binfmt_elf.c supports uselib.  In a very a.out ish way.  Do you know if
> > that support was ever used?
> >
> > If we are truly talking a.out only we should be able to make uselib
> > conditional on a.out support in the kernel which is strongly mostly
> > disabled at this point.
>
> The only ones that even allow setting AOUT:
>
> arch/alpha/Kconfig:     select HAVE_AOUT
> arch/m68k/Kconfig:      select HAVE_AOUT if MMU
>
> and x86 deprecated it March 2019:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eac616557050737a8d6ef6fe0322d0980ff0ffde

Quoting myself (for the second time this month):
   "I think it's safe to assume no one still runs a.out binaries on m68k."
    http://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
