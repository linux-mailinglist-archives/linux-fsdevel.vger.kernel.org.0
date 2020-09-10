Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BE264EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgIJTZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:25:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:46900 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbgIJPsf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08AFiOpg001653;
        Thu, 10 Sep 2020 10:44:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 08AFiO8E001652;
        Thu, 10 Sep 2020 10:44:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 10 Sep 2020 10:44:24 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: remove the last set_fs() in common code, and remove it for x86 and powerpc v3
Message-ID: <20200910154423.GK28786@gate.crashing.org>
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk> <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com> <20200909184001.GB28786@gate.crashing.org> <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:33:36PM -0700, Linus Torvalds wrote:
> On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > It will not work like this in GCC, no.  The LLVM people know about that.
> > I do not know why they insist on pushing this, being incompatible and
> > everything.
> 
> Umm. Since they'd be the ones supporting this, *gcc* would be the
> incompatible one, not clang.

This breaks the basic requirements of asm goto.

> So I'd phrase it differently. If gcc is planning on doing some
> different model for asm goto with outputs, that would be the
> incompatible case.

If we will do asm goto with outputs, the asm will still be a jump
instruction!  (It is not in LLVM!)

We probably *can* make asm goto have outputs (jump instructions can have
outputs just fine!  Just output reloads on jump instructions are hard,
because not always they are *possible*; but for asm goto it should be
fine).

Doing as LLVM does, and making the asm a "trapping" instruction, makes
it not a jump insn, and opens up whole new cans of worms (including
inferior code quality).  Since it has very different semantics, and we
might want to keep the semantics of asm goto as well anyway, this should
be called something different ("asm break" or "asm __anything" for
example).

It would be nice if they talked to us about it, too.  LLVM claims it
implements the GCC inline asm extension.  It already only is compatible
for the simplest of cases, but this would be much worse still :-(

> and honestly, (b) is actually inferior for the error cases, even if to
> a compiler person it might feel like the "RightThing(tm)" to do.
> Because when an exception happens, the outputs simply won't be
> initialized.

Sure, that is fine, and quite possible useful, but it is not the same as
asm goto.  asm goto is not some exception handling construct: it is a
jump instruction.

> Anyway, for either of those cases, the kernel won't care either way.
> We'll have to support the non-goto case for many years even if
> everybody were to magically implement it today, so it's not like this
> is a "you have to do it" thing.

Yes.

I'm just annoyed because of all the extra work created by people not
communicating.


Segher
