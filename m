Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD15418F5A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgCWNYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:24:15 -0400
Received: from foss.arm.com ([217.140.110.172]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgCWNYP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6651FB;
        Mon, 23 Mar 2020 06:24:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 403A23F52E;
        Mon, 23 Mar 2020 06:24:14 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:24:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
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
Message-ID: <20200323132412.GD4948@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20200323122143.GB4892@mbp>
X-Cookie: Stay on the trail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2020 at 12:21:44PM +0000, Catalin Marinas wrote:
> On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:

> +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> +                        bool has_interp, bool is_interp)
> +{
> +       if (is_interp != has_interp)
> +               return prot;
> +
> +       if (!(state->flags & ARM64_ELF_BTI))
> +               return prot;
> +
> +       if (prot & PROT_EXEC)
> +               prot |= PROT_BTI;
> +
> +       return prot;
> +}

> At a quick look, for dynamic binaries we have has_interp == true and
> is_interp == false. I don't know why but, either way, the above code
> needs a comment with some justification.

I don't really know for certain either, I inherited this code as is with
the understanding that this was all agreed with the toolchain and libc
people - the actual discussion that lead to the decisions being made
happened before I was involved.  My understanding is that the idea was
that the dynamic linker would be responsible for mapping everything in
dynamic applications other than itself but other than consistency I
don't know why.  I guess it defers more decision making to userspace but
I'm having a hard time thinking of sensible cases where one might wish
to make a decision other than enabling PROT_BTI.

I'd be perfectly happy to drop the check if that makes more sense to
people, otherwise I can send a patch adding a comment explaining the
situation.

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl54uHwACgkQJNaLcl1U
h9DAYQf+PC+yaMtvYW9mN4nKAz7ncHVrReSbAGM8vzqPWdFAlq9YUOWrM19ZtwX3
Reos273yUIeierbiwvJMNq+eDPFo9bF3mqTxkQr5uA4+RDAqXedTNeS637lX1tG3
/uzSb0uqwvff1A9+IZsavz2GuhK8WNmybN7xbOPD1SLHZd4ouEiMlBoE3Ze+nMqm
gClUEz9TTAmK6m9sL7rchJgnSFoG5OU4F/6sWpCoip4mFa5QnBAkeWh6RssDImFg
hIm9njv6a9aeNHTw1YnM1heqRe86GkmGk3LsgGrHETzDNFOwlBNek95tXIVl7W7I
f99IlRUisKUN9wu9VYAtNzRSGiDGLQ==
=70MP
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
