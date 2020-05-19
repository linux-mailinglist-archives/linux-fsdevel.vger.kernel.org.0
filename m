Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB21D9A57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgESOrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 10:47:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 10:47:47 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jb3Wj-0007aE-1m; Tue, 19 May 2020 14:47:29 +0000
Date:   Tue, 19 May 2020 16:47:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Message-ID: <20200519144727.lgj2wc7srrix7gyd@wittgenstein>
References: <20200518055457.12302-1-keescook@chromium.org>
 <20200518055457.12302-2-keescook@chromium.org>
 <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
 <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
 <20200518144627.sv5nesysvtgxwkp7@wittgenstein>
 <87blmk3ig4.fsf@x220.int.ebiederm.org>
 <87mu64uxq1.fsf@igel.home>
 <87sgfwuoi3.fsf@x220.int.ebiederm.org>
 <20200519131341.qiysndpmj75zfjtz@wittgenstein>
 <CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 04:32:38PM +0200, Geert Uytterhoeven wrote:
> Hi Christian,
> 
> On Tue, May 19, 2020 at 3:15 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Tue, May 19, 2020 at 06:56:36AM -0500, Eric W. Biederman wrote:
> > > Andreas Schwab <schwab@linux-m68k.org> writes:
> > > > On Mai 18 2020, Eric W. Biederman wrote:
> > > >> If it was only libc4 and libc5 that used the uselib system call then it
> > > >> can probably be removed after enough time.
> > > >
> > > > Only libc4 used it, libc5 was already ELF.
> > >
> > > binfmt_elf.c supports uselib.  In a very a.out ish way.  Do you know if
> > > that support was ever used?
> > >
> > > If we are truly talking a.out only we should be able to make uselib
> > > conditional on a.out support in the kernel which is strongly mostly
> > > disabled at this point.
> >
> > The only ones that even allow setting AOUT:
> >
> > arch/alpha/Kconfig:     select HAVE_AOUT
> > arch/m68k/Kconfig:      select HAVE_AOUT if MMU
> >
> > and x86 deprecated it March 2019:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eac616557050737a8d6ef6fe0322d0980ff0ffde
> 
> Quoting myself (for the second time this month):
>    "I think it's safe to assume no one still runs a.out binaries on m68k."
>     http://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com

Well, it's just a great thing to hear. :)

Fyi, I once tried to give a demo with a Slackware version in a container
which pre-dated ELF on a x86 kernel with AOUT. It didn't go well...

Christian
