Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB988184759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCMM7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 08:59:30 -0400
Received: from foss.arm.com ([217.140.110.172]:54754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMM7a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:59:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1981730E;
        Fri, 13 Mar 2020 05:59:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905A13F67D;
        Fri, 13 Mar 2020 05:59:28 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:59:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20200313125927.GE5528@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
 <20200310124226.GC4106@sirena.org.uk>
 <20200311162858.GK3216816@arrakis.emea.arm.com>
 <20200311172556.GJ5411@sirena.org.uk>
 <20200312184211.GA3849205@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <20200312184211.GA3849205@arrakis.emea.arm.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 06:42:11PM +0000, Catalin Marinas wrote:
> On Wed, Mar 11, 2020 at 05:25:56PM +0000, Mark Brown wrote:
> > On Wed, Mar 11, 2020 at 04:28:58PM +0000, Catalin Marinas wrote:

> > > Can we not change aarch64_insn_is_nop() to actually return true only for
> > > NOP and ignore everything else in the hint space? We tend to re-use the

> > ignored. This isn't extensive userspace testing though.  Adding
> > whitelisting of the BTI and PAC hints would definitely be a safer as a
> > first step though.  I can post either version?

> I thought BTI and PAC are already whitelisted in mainline as they fall
> into the hint space (by whitelisting I mean you can probe them).

This was in the context of your comment above about modifying
aarch64_insn_is_nop() - if we do that and nothing else then we'd remove
the current whitelisting.

> I'm trying to understand how the BTI patches affect the current uprobes
> support and what is needed. Executing BTI or PCI?SP out of line should
> be fine as they don't generate a BTI exception (the BRK doesn't either,
> just the normal debug exception).

Right.

> I think (it needs checking) that BRK preserves the PSTATE.BTYPE in SPSR.

Yes, Exception_SoftwareBreakpoint preserves PSTATE.BTYPE.

> If we probe an instruction in a guarded page and then we single-step it
> in a non-guarded page, we'll miss a potential BTI fault. Is this an
> issue?

Obviously the main thing here is that if we miss faults then that's
potentially opening something that could be used as part of an exploit
chain.  I'm not aware of any sensible applications that would generate
the exceptions in normal operation.

> If we are to keep the BTI faulting behaviour, we'd need an additional
> xol page, guarded, and to find a way to report the original probed
> address of the fault rather than the xol page.

Yes, or just accept the inaccurate fault address which isn't good but
might be the least worst thing if there's issues with reporting the
original address.

> So, IIUC, we don't have an issue with the actual BTI or PACI?SP
> instructions but rather the other instructions that would not fault with
> the BTI support. While we should try to address this, I think the
> important bit now is not to break the existing uprobes support when
> running a binary with BTI enabled.

I think so, and as far as my ability to tell goes the worst consequence
would be missing exceptions like you say.  That's not great but it's at
least an extra hoop people have to jump through.

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rg64ACgkQJNaLcl1U
h9DWnQgAhUxlaicd2a+MBwTWiCVEJTRRFVsRGhEykHrb5hzLpkJjryEGiVCRyRQu
oVmbnqJvqq7rPvgU9m5hjzCRHisdgwfusfAHEeh5wb2Mj4PDLjy5eZqVDiA070Qk
kTw4qZuayRbkD/k3axQ3/DT8+Etp7R7diCsLNp9VXMuc8E54XYtUv7lEreciqiJR
MSagKFj37vUFHTJIXAzynd1W+b4QyPA3FGKi1U90CijwuWGRu5HY8XKguW/7jLIp
5FsUaW+Qz45aPeQF9g5Ka85iNrTKuaj49BpvK4vsM7TjjKJ2Br7k1fmxqceWessd
5gP9y4bcPEjW+7sf40ALa+SsaPmVTw==
=g2Tj
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
