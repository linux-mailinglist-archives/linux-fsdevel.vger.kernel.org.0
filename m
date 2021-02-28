Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE19327164
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhB1HJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 02:09:02 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50809 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhB1HJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 02:09:00 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11S786F3000515;
        Sun, 28 Feb 2021 16:08:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11S786F3000515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614496087;
        bh=ldg+O7sE55to+alrJE10yp3zvi7BbH+3v1wNoAJS4q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0VcDFnKJ9ZI1vl7gD1o63BMh27v5/xoqXdGImvPu9vZui8he0MXNPPjpWB3VH5h8
         654FJ/8jnrBo5STG+/dhi9ANpCEbDnnwjbd5y3G4dTTUQynxO8grRRui6E3F/8oQyh
         LVGCXb3weyzFn+tAxU2lGl/B6t88CGfK8MlFdkikbfr/LWyyTbZYpUX5HDGNbqKd/v
         0J81h/U6rkVmP7Z6SOzLA0CYTB8S0P2KiESCBYDf1jW2gkaVrbX7qEHgIU71bsJZ57
         XpgCdgTR4vuY6aBffaqXg5pBsk4wN4Anr1btjcelqzm78oqpfWaWnnl94figzXnxGZ
         JUHqBEMIi8z6A==
X-Nifty-SrcIP: [209.85.167.173]
Received: by mail-oi1-f173.google.com with SMTP id m25so1692836oie.12;
        Sat, 27 Feb 2021 23:08:07 -0800 (PST)
X-Gm-Message-State: AOAM530zU8zcvbJN7+aYQyrCZR2wmOiL6npiMFl1I9OXKxMHZk5yZYKc
        k6HjUbWu2YfJbhntAdKF6Hg8w4+b20VhdUVAwH4=
X-Google-Smtp-Source: ABdhPJxnVdF9Cvtz3QuQ9Z55mLc0nR7ZPvYqUNLa1UMZMC9CH1qH9+VqVFfmtGZF/+QiECQmAdbbtJL43yO3rdbPYM4=
X-Received: by 2002:a17:90a:dc08:: with SMTP id i8mr10797186pjv.153.1614496085241;
 Sat, 27 Feb 2021 23:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210227183910.221873-1-masahiroy@kernel.org> <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
 <20210228064936.zixrhxlthyy6fmid@24bbad8f3778> <20210228065254.GA30798@24bbad8f3778>
In-Reply-To: <20210228065254.GA30798@24bbad8f3778>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Feb 2021 16:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmHU48mg4uh2H0VZDuhg6-Fwz=uF0rKSHuCJK-soZbUQ@mail.gmail.com>
Message-ID: <CAK7LNATmHU48mg4uh2H0VZDuhg6-Fwz=uF0rKSHuCJK-soZbUQ@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jethro Beekman <jethro@fortanix.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 3:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Feb 27, 2021 at 11:49:36PM -0700, Nathan Chancellor wrote:
> > On Sun, Feb 28, 2021 at 12:15:16PM +0900, Masahiro Yamada wrote:
> > > On Sun, Feb 28, 2021 at 3:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
> > > > error if binutils too old").
> > > >
> > > > The help text in arch/x86/Kconfig says enabling the X32 ABI support
> > > > needs binutils 2.22 or later. This is met because the minimal binutils
> > > > version is 2.23 according to Documentation/process/changes.rst.
> > > >
> > > > I would not say I am not familiar with toolchain configuration, but
> > >
> > > I mean:
> > > I would not say I am familiar ...
> > > That is why I added RFC.
> > >
> > > I appreciate comments from people who are familiar
> > > with toolchains (binutils, llvm).
> > >
> > > If this change is not safe,
> > > we can move this check to Kconfig at least.
> >
> > Hi Masahiro,
> >
> > As Fangrui pointed out, there are two outstanding issues with x32 with
> > LLVM=1, both seemingly related to LLVM=1.
>                                     ^ llvm-objcopy
>
> Sigh, note to self, don't write emails while tired...
>

Fangrui, Nathan, thanks for your comments.

OK, then we still need to carry this toolchain check.


-- 
Best Regards
Masahiro Yamada
