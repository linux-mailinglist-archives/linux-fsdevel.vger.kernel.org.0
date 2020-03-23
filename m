Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0C18F80E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCWPCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:02:17 -0400
Received: from foss.arm.com ([217.140.110.172]:50762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgCWPCQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:02:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35DAA1FB;
        Mon, 23 Mar 2020 08:02:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460B13F7C3;
        Mon, 23 Mar 2020 08:02:12 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:02:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20200323150209.GC3959@C02TD0UTHF1T.local>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
 <20200323132412.GD4948@sirena.org.uk>
 <20200323135722.GA3959@C02TD0UTHF1T.local>
 <20200323143954.GC4892@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323143954.GC4892@mbp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:39:55PM +0000, Catalin Marinas wrote:
> On Mon, Mar 23, 2020 at 01:57:22PM +0000, Mark Rutland wrote:
> > On Mon, Mar 23, 2020 at 01:24:12PM +0000, Mark Brown wrote:
> > > On Mon, Mar 23, 2020 at 12:21:44PM +0000, Catalin Marinas wrote:
> > > > On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:
> > > 
> > > > +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> > > > +                        bool has_interp, bool is_interp)
> > > > +{
> > > > +       if (is_interp != has_interp)
> > > > +               return prot;
> > > > +
> > > > +       if (!(state->flags & ARM64_ELF_BTI))
> > > > +               return prot;
> > > > +
> > > > +       if (prot & PROT_EXEC)
> > > > +               prot |= PROT_BTI;
> > > > +
> > > > +       return prot;
> > > > +}

> > I think it would be best to document the current behaviour, as it's a
> > simple ABI that we can guarantee, and the dynamic linker will have to be
> > aware of BTI in order to do the right thing anyhow.
> 
> That's a valid point. If we have an old dynamic linker and the kernel
> enabled BTI automatically for the main executable, could things go wrong
> (e.g. does the PLT need to be BTI-aware)?

Also worth noting that an old dynamic linker won't have ARM64_ELF_BTI
set, so the kernel will not enable BTI for this.

Mark.
