Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F3B41AD0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhI1Kh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 06:37:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240161AbhI1Kh3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0306B6D;
        Tue, 28 Sep 2021 03:35:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5377D3F7B4;
        Tue, 28 Sep 2021 03:35:47 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:35:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210928103543.GF1924@C02TD0UTHF1T.local>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:19:23PM +0200, Dmitry Vyukov wrote:
>  On Mon, 27 Sept 2021 at 19:18, Mark Rutland <mark.rutland@arm.com> wrote:
> > What's happened here is that __d_lookup() (via a few layers of inlining) called
> > load_unaligned_zeropad(). The `LDR` at the start of the asm faulted (I suspect
> > due to a tag check fault), and so the exception handler replaced the PC with
> > the (anonymous) fixup function. This is akin to a tail or sibling call, and so
> > the fixup function entirely replaces __d_lookup() in the trace.
> >
> > The fixup function itself has an `LDR` which faulted (because it's
> > designed to fixup page alignment problems, not tag check faults), and
> > that is what's reported here.
> >
> > As the fixup function is anonymous, and the nearest prior symbol in .text is
> > __entry_tramp_text_end, it gets symbolized as an offset from that.
> >
> > We can make the unwinds a bit nicer by adding some markers (e.g. patch
> > below), but actually fixing this case will require some more thought.
> >
> > Thanks,
> > Mark.
> >
> > ---->8----
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 709d2c433c5e..127096a0faea 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -111,6 +111,11 @@ jiffies = jiffies_64;
> >  #define TRAMP_TEXT
> >  #endif
> >
> > +#define FIXUP_TEXT                                     \
> > +       __fixup_text_start = .;                         \
> > +       *(.fixup);                                      \
> > +       __fixup_text_end = .;
> > +
> >  /*
> >   * The size of the PE/COFF section that covers the kernel image, which
> >   * runs from _stext to _edata, must be a round multiple of the PE/COFF
> > @@ -161,7 +166,7 @@ SECTIONS
> >                         IDMAP_TEXT
> >                         HIBERNATE_TEXT
> >                         TRAMP_TEXT
> > -                       *(.fixup)
> > +                       FIXUP_TEXT
> >                         *(.gnu.warning)
> >                 . = ALIGN(16);
> >                 *(.got)                 /* Global offset table          */
> 
> 
> Oh, good it's very local to the .fixup thing rather than a common
> issue that affects all unwinds.

Yes, though the other issue I mentioned *does* exist, and can occur
separately, even if we're getting lucky and not hitting it often enough
to notice.

> In the other x86 thread Josh Poimboeuf suggested to use asm goto to a
> cold part of the function instead of .fixup:
> https://lore.kernel.org/lkml/20210927234543.6waods7rraxseind@treble/
> This sounds like a more reliable solution that will cause less
> maintenance burden. Would it work for arm64 as well?

Maybe we can use that when CC_HAS_ASM_GOTO_OUTPUT is avaiable, but in
general we can't rely on asm goto supporting output arguments (and IIRC
GCC doesn't support that at all), so we'd still have to support the
current fixup scheme.

Thanks,
Mark.
