Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CB2C6C91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgK0Uav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 15:30:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbgK0U3w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:29:52 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA122223D;
        Fri, 27 Nov 2020 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606508990;
        bh=8WXGibjYZ0t9GgILIvSSUtbCg5S7JG3534IJyVMr0Tw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NlqPW5nkcLlvI6BSWKG0DmJ2SIyCAg1uWcB8lnHKk8DMLiQMuFPBafd3Sk1MOzpwf
         zvkHVRZXFPKGrxQ4iaqPZ7+arxvPb69X1Q1m2aJ7QSYrdXzr3Swtw2wf2PogPFCpAm
         aH4CRw9iCRgUr5fjSVPnb0gr4dnyWEkqO8g8G80c=
Received: by mail-ot1-f52.google.com with SMTP id o3so5690749ota.8;
        Fri, 27 Nov 2020 12:29:49 -0800 (PST)
X-Gm-Message-State: AOAM5317KTd4Lzfu0pirNf5UGoSWjo488fOdVtm+pRRNrkFoYXx19AdX
        RSQKWiET0GWYUGjw5Rt1DXyGqGC1zEySmSNIWRM=
X-Google-Smtp-Source: ABdhPJwWtUnNmzAaL6g5cEdD0neWf5eC/bn+E7dJx8QwCcQLQVTmp0k8NS+iUWrTm0kjrnb1F6M6iBbuPmksPMiqam0=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr7261780otc.305.1606508989093;
 Fri, 27 Nov 2020 12:29:49 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org>
 <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
 <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
 <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org> <877dqap76p.fsf@x220.int.ebiederm.org>
In-Reply-To: <877dqap76p.fsf@x220.int.ebiederm.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 27 Nov 2020 21:29:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
Message-ID: <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 2:16 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > On 11/24/20 12:14 PM, Arnd Bergmann wrote:
> >
> > There are still PS3-Linux users out there.  They use 'Homebrew' firmware
> > released through 'Hacker' forums that allow them to run Linux on
> > non-supported systems.  They are generally hobbies who don't post to
> > Linux kernel mailing lists.  I get direct inquiries regularly asking
> > about how to update to a recent kernel.  One of the things that attract
> > them to the PS3 is the Cell processor and either using or programming
> > the SPUs.
> >
> > It is difficult to judge how much use the SPU core dump support gets,
> > but if it is not a cause of major problems I feel we should consider
> > keeping it.
>
> I just took a quick look to get a sense how much tool support there is.
>
> In the gdb tree I found this 2019 commit abf516c6931a ("Remove Cell
> Broadband Engine debugging support").  Which basically removes the code
> in gdb that made sense of the spu coredumps.

Ah, I had not realized this was gone already. The code in gdb for
seamlessly debugging programs across CPU and SPU was clearly
more complex than the kernel portion for the coredump, so it makes
sense this was removed eventually.

> I would not say the coredump support is a source major problems, but it
> is a challenge to understand.  One of the pieces of code in there that
> is necessary to make the coredump support work reliable, a call to
> unshare_files, Oleg whole essentially maintains the ptrace and coredump
> support did not know why it was there, and it was not at all obvious
> when I looked at the code.
>
> So we are certainly in maintainers loosing hours of time figuring out
> what is going on and spending time fixing fuzzer bugs related to the
> code.

I also spent some amount of time on this code earlier this year Christoph
did some refactoring, and we could both have used that time better.

> At the minimum I will add a few more comments so people reading the code
> can realize why it is there.   Perhaps putting the relevant code behind
> a Kconfig so it is only built into the kernel when spufs is present.
>
> I think we are at a point we we can start planning on removing the
> coredump support.  The tools to read it are going away.  None of what is
> there is bad, but it is definitely a special case, and it definitely has
> a maintenance cost.

How about adding a comment in the coredump code so it can get
removed the next time someone comes across it during refactoring,
or when they find a bug that can't easily be worked around?

That way there is still a chance of using it where needed, but
hopefully it won't waste anyone's time when it gets in the way.

If there are no objections, I can also send a patch to remove
CONFIG_PPC_CELL_NATIVE, PPC_IBM_CELL_BLADE and
everything that depends on those symbols, leaving only the
bits needed by ps3 in the arch/powerpc/platforms/cell directory.

      Arnd
