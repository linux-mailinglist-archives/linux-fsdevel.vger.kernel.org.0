Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635171838D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLSmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 14:42:17 -0400
Received: from foss.arm.com ([217.140.110.172]:39884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCLSmR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:42:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75A7430E;
        Thu, 12 Mar 2020 11:42:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776B33F67D;
        Thu, 12 Mar 2020 11:42:13 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:42:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
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
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Message-ID: <20200312184211.GA3849205@arrakis.emea.arm.com>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
 <20200310124226.GC4106@sirena.org.uk>
 <20200311162858.GK3216816@arrakis.emea.arm.com>
 <20200311172556.GJ5411@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311172556.GJ5411@sirena.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:25:56PM +0000, Mark Brown wrote:
> On Wed, Mar 11, 2020 at 04:28:58PM +0000, Catalin Marinas wrote:
> > On Tue, Mar 10, 2020 at 12:42:26PM +0000, Mark Brown wrote:
> > > Sorry, I realized thanks to Amit's off-list prompting that I was testing
> > > that I was verifying with the wrong kernel binary here (user error since
> > > it took me a while to sort out uprobes) so this isn't quite right - you
> > > can probe the landing pads with or without this series.
> 
> > Can we not change aarch64_insn_is_nop() to actually return true only for
> > NOP and ignore everything else in the hint space? We tend to re-use the
> > hint instructions for new things in the architecture, so I'd rather
> > white-list what we know we can safely probe than black-listing only some
> > of the hint instructions.
[...]
> > I haven't assessed the effort of doing the above (probably not a lot)
> > but as a short-term workaround we could add the BTI and PAC hint
> > instructions to the aarch64_insn_is_nop() (though my preferred option is
> > the white-list one).
> 
> The only thing I've seen in testing with just NOPs whitelisted is an
> inability to probe the PAC instructions which isn't the best user
> experience, especially since the effect is that the probes get silently
> ignored. This isn't extensive userspace testing though.  Adding
> whitelisting of the BTI and PAC hints would definitely be a safer as a
> first step though.  I can post either version?

I thought BTI and PAC are already whitelisted in mainline as they fall
into the hint space (by whitelisting I mean you can probe them).

I'm trying to understand how the BTI patches affect the current uprobes
support and what is needed. Executing BTI or PCI?SP out of line should
be fine as they don't generate a BTI exception (the BRK doesn't either,
just the normal debug exception).

I think (it needs checking) that BRK preserves the PSTATE.BTYPE in SPSR.
If we probe an instruction in a guarded page and then we single-step it
in a non-guarded page, we'll miss a potential BTI fault. Is this an
issue?

If we are to keep the BTI faulting behaviour, we'd need an additional
xol page, guarded, and to find a way to report the original probed
address of the fault rather than the xol page.

So, IIUC, we don't have an issue with the actual BTI or PACI?SP
instructions but rather the other instructions that would not fault with
the BTI support. While we should try to address this, I think the
important bit now is not to break the existing uprobes support when
running a binary with BTI enabled.

Have I missed anything?

-- 
Catalin
