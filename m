Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F02CC17E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgLBP7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 10:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgLBP7b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:59:31 -0500
X-Gm-Message-State: AOAM532MYRvP8ekkEeilPMeSUP382FZXaliUjcLV43iIlo5MczoALi85
        L5FChdEb+WrUR6pG1i0nGcrz8fnWY1qH23l6XOc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606924730;
        bh=dTmVA5wGcd9geaQOgSpp+EqPMQTwTGZe/YFR11Pm1Ns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lmh9C2jNxM52u/fGCSSuET5qhSWU+FRDaSUnMl8441bzAdl8l4YQX4a+Uh7S5TZgL
         RPnHU2usM4VqySn5Vj8uhFx6qGyOizfaTCR8ozg/h/+An21NzQOSeoaqxvuwfVAkJG
         9KK7fgfPgMfOKMRj37n83GzVVhC+K/zCRUKc+JAM=
X-Google-Smtp-Source: ABdhPJxzr5uQOFjJjH+Lp+wY35+rlkH4YPN0OL5cJR20wfEmXALCBpoYFuL9MnuEo66bECQbMPnTTDbE80XPRS4QdM8=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr2384567oth.210.1606924729348;
 Wed, 02 Dec 2020 07:58:49 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com> <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
 <87im9vx08i.fsf@x220.int.ebiederm.org> <87pn42r0n7.fsf@x220.int.ebiederm.org>
 <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
 <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
 <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org> <87h7pdnlzv.fsf_-_@x220.int.ebiederm.org>
 <87sg8ock0n.fsf@x220.int.ebiederm.org>
In-Reply-To: <87sg8ock0n.fsf@x220.int.ebiederm.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 2 Dec 2020 16:58:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0iMjZOHm3pAR+V3Ctdfd6Xa0WiWHcVP3nX7dEuFFXd1Q@mail.gmail.com>
Message-ID: <CAK8P3a0iMjZOHm3pAR+V3Ctdfd6Xa0WiWHcVP3nX7dEuFFXd1Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] coredump: Document coredump code exclusively used by
 cell spufs
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

On Wed, Dec 2, 2020 at 4:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> ebiederm@xmission.com (Eric W. Biederman) writes:
>
> > Oleg Nesterov recently asked[1] why is there an unshare_files in
> > do_coredump.  After digging through all of the callers of lookup_fd it
> > turns out that it is
> > arch/powerpc/platforms/cell/spufs/coredump.c:coredump_next_context
> > that needs the unshare_files in do_coredump.
> >
> > Looking at the history[2] this code was also the only piece of coredump code
> > that required the unshare_files when the unshare_files was added.
> >
> > Looking at that code it turns out that cell is also the only
> > architecture that implements elf_coredump_extra_notes_size and
> > elf_coredump_extra_notes_write.
> >
> > I looked at the gdb repo[3] support for cell has been removed[4] in binutils
> > 2.34.  Geoff Levand reports he is still getting questions on how to
> > run modern kernels on the PS3, from people using 3rd party firmware so
> > this code is not dead.  According to Wikipedia the last PS3 shipped in
> > Japan sometime in 2017.  So it will probably be a little while before
> > everyone's hardware dies.
> >
> > Add some comments briefly documenting the coredump code that exists
> > only to support cell spufs to make it easier to understand the
> > coredump code.  Eventually the hardware will be dead, or their won't
> > be userspace tools, or the coredump code will be refactored and it
> > will be too difficult to update a dead architecture and these comments
> > make it easy to tell where to pull to remove cell spufs support.
> >
> > [1] https://lkml.kernel.org/r/20201123175052.GA20279@redhat.com
> > [2] 179e037fc137 ("do_coredump(): make sure that descriptor table isn't shared")
> > [3] git://sourceware.org/git/binutils-gdb.git
> > [4] abf516c6931a ("Remove Cell Broadband Engine debugging support").
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >
> > Does this change look good to people?  I think it captures this state of
> > things and makes things clearer without breaking anything or removing
> > functionality for anyone.
>
> I haven't heard anything except a general ack to the concept of
> comments.  So I am applying this.
>

Sorry I missed it when you originally sent it. Looks good ot me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
