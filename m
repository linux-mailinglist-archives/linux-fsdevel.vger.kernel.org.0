Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4778D18F717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 15:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCWOkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 10:40:02 -0400
Received: from foss.arm.com ([217.140.110.172]:50308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCWOkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:40:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74305FEC;
        Mon, 23 Mar 2020 07:40:01 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8773F52E;
        Mon, 23 Mar 2020 07:39:57 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:39:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200323143954.GC4892@mbp>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
 <20200323132412.GD4948@sirena.org.uk>
 <20200323135722.GA3959@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323135722.GA3959@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:57:22PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 01:24:12PM +0000, Mark Brown wrote:
> > On Mon, Mar 23, 2020 at 12:21:44PM +0000, Catalin Marinas wrote:
> > > On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:
> > 
> > > +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> > > +                        bool has_interp, bool is_interp)
> > > +{
> > > +       if (is_interp != has_interp)
> > > +               return prot;
> > > +
> > > +       if (!(state->flags & ARM64_ELF_BTI))
> > > +               return prot;
> > > +
> > > +       if (prot & PROT_EXEC)
> > > +               prot |= PROT_BTI;
> > > +
> > > +       return prot;
> > > +}
> > 
> > > At a quick look, for dynamic binaries we have has_interp == true and
> > > is_interp == false. I don't know why but, either way, the above code
> > > needs a comment with some justification.
> > 
> > I don't really know for certain either, I inherited this code as is with
> > the understanding that this was all agreed with the toolchain and libc
> > people - the actual discussion that lead to the decisions being made
> > happened before I was involved.  My understanding is that the idea was
> > that the dynamic linker would be responsible for mapping everything in
> > dynamic applications other than itself but other than consistency I
> > don't know why.  I guess it defers more decision making to userspace but
> > I'm having a hard time thinking of sensible cases where one might wish
> > to make a decision other than enabling PROT_BTI.
> 
> My understanding was this had been agreed with the toolchain folk a
> while back -- anything static loaded by the kernel (i.e. a static
> executable or the dynamic linker) would get GP set. In other cases the
> linker will mess with the permissions on the pages anyhow, and needs to
> be aware of BTI in order to do the right thing, so it was better to
> leave it to userspace consistently (e.g. as that had the least risk of
> subtle changes in behaviour leading to ABI difficulties).

So this means that the interpreter will have to mprotect(PROT_BTI) the
text section of the primary executable. For subsequent libraries, it
calls mmap() explicitly anyway but not for the main executable (IIUC).

> > I'd be perfectly happy to drop the check if that makes more sense to
> > people, otherwise I can send a patch adding a comment explaining the
> > situation.
> 
> I think it would be best to document the current behaviour, as it's a
> simple ABI that we can guarantee, and the dynamic linker will have to be
> aware of BTI in order to do the right thing anyhow.

That's a valid point. If we have an old dynamic linker and the kernel
enabled BTI automatically for the main executable, could things go wrong
(e.g. does the PLT need to be BTI-aware)?

-- 
Catalin
