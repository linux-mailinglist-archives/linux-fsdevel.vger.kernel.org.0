Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4282B264929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgIJPyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 11:54:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:45384 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbgIJPws (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:52:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08AFGK0M032611;
        Thu, 10 Sep 2020 10:16:20 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 08AFGJBX032610;
        Thu, 10 Sep 2020 10:16:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 10 Sep 2020 10:16:19 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Christophe Leroy'" <christophe.leroy@csgroup.eu>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86 and powerpc v3
Message-ID: <20200910151619.GI28786@gate.crashing.org>
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk> <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com> <20200909184001.GB28786@gate.crashing.org> <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com> <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com> <186a62fc-042c-d6ab-e7dc-e61b18945498@csgroup.eu> <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 09:26:28AM +0000, David Laight wrote:
> From: Christophe Leroy
> > Sent: 10 September 2020 09:14
> > 
> > Le 10/09/2020 à 10:04, David Laight a écrit :
> > > From: Linus Torvalds
> > >> Sent: 09 September 2020 22:34
> > >> On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
> > >> <segher@kernel.crashing.org> wrote:
> > >>>
> > >>> It will not work like this in GCC, no.  The LLVM people know about that.
> > >>> I do not know why they insist on pushing this, being incompatible and
> > >>> everything.
> > >>
> > >> Umm. Since they'd be the ones supporting this, *gcc* would be the
> > >> incompatible one, not clang.
> > >
> > > I had an 'interesting' idea.
> > >
> > > Can you use a local asm register variable as an input and output to
> > > an 'asm volatile goto' statement?
> > >
> > > Well you can - but is it guaranteed to work :-)
> > >
> > 
> > With gcc at least it should work according to
> > https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html
> > 
> > They even explicitely tell: "The only supported use for this feature is
> > to specify registers for input and output operands when calling Extended
> > asm "
> 
> A quick test isn't good....
> 
> int bar(char *z)
> {
>         __label__ label;
>         register int eax asm ("eax") = 6;
>         asm volatile goto (" mov $1, %%eax" ::: "eax" : label);
> 
> label:
>         return eax;
> }

It is neither input nor output operand here!  Only *then* is a local
register asm guaranteed to be in the given reg: as input or output to an
inline asm.


Segher
