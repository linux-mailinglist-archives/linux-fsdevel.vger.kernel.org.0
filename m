Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCA181DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgCKQ3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 12:29:04 -0400
Received: from foss.arm.com ([217.140.110.172]:51624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgCKQ3E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:29:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FD47FA;
        Wed, 11 Mar 2020 09:29:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93C63F6CF;
        Wed, 11 Mar 2020 09:29:00 -0700 (PDT)
Date:   Wed, 11 Mar 2020 16:28:58 +0000
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
Message-ID: <20200311162858.GK3216816@arrakis.emea.arm.com>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
 <20200310124226.GC4106@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310124226.GC4106@sirena.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:42:26PM +0000, Mark Brown wrote:
> On Mon, Mar 09, 2020 at 09:05:05PM +0000, Mark Brown wrote:
> > On Fri, Mar 06, 2020 at 10:27:29AM +0000, Catalin Marinas wrote:
> 
> > > Does this series affect uprobes in any way? I.e. can you probe a landing
> > > pad?
> 
> > You can't probe a landing pad, uprobes on landing pads will be silently
> > ignored so the program isn't disrupted, you just don't get the expected
> > trace from those uprobes.  This isn't new with the BTI support since
> > the landing pads are generally pointer auth instructions, these already
> > can't be probed regardless of what's going on with this series.  It's
> > already on the list to get sorted.
> 
> Sorry, I realized thanks to Amit's off-list prompting that I was testing
> that I was verifying with the wrong kernel binary here (user error since
> it took me a while to sort out uprobes) so this isn't quite right - you
> can probe the landing pads with or without this series.

Can we not change aarch64_insn_is_nop() to actually return true only for
NOP and ignore everything else in the hint space? We tend to re-use the
hint instructions for new things in the architecture, so I'd rather
white-list what we know we can safely probe than black-listing only some
of the hint instructions.

I haven't assessed the effort of doing the above (probably not a lot)
but as a short-term workaround we could add the BTI and PAC hint
instructions to the aarch64_insn_is_nop() (though my preferred option is
the white-list one).

-- 
Catalin
