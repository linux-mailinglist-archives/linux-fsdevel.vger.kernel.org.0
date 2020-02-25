Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD016EC7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 18:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgBYR10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 12:27:26 -0500
Received: from foss.arm.com ([217.140.110.172]:53552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYR1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:27:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F221FB;
        Tue, 25 Feb 2020 09:27:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6403F6CF;
        Tue, 25 Feb 2020 09:27:24 -0800 (PST)
Date:   Tue, 25 Feb 2020 17:27:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kachhap <amit.kachhap@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v6 05/11] arm64: elf: Enable BTI at exec based on ELF
 program properties
Message-ID: <20200225172723.GG4633@sirena.org.uk>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-6-broonie@kernel.org>
 <275b9cdb-7835-0dfe-9bea-acb0d8301e36@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <275b9cdb-7835-0dfe-9bea-acb0d8301e36@arm.com>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 06:58:50PM +0530, Amit Kachhap wrote:
> On 2/13/20 12:59 AM, Mark Brown wrote:

> > +static inline int arch_parse_elf_property(u32 type, const void *data,
> > +					  size_t datasz, bool compat,
> > +					  struct arch_elf_state *arch)
> > +{

> Does this check here make sense to skip running extra code?
>     if (!system_supports_bti())
>              return 0;

This specifically is the wrong place for such a test since we didn't
even figure out if we're looking at the BTI property yet so it'd need to
be moved if any further properties are added.

> Although this check is there in arch_validate_prot.

And more importantly in arch_calc_vm_prot_bits() so we never actually
create guarded pages on a system that doesn't support BTI.  That said I
do agree that it seems reasonable to add an explicit check in the
parsing of the actual BTI property for robustness and clarity, I'll do a
patch for that and roll it into any future versions or send it
incrementally if this one is applied but it doesn't seem sensible to
spin the whole series with the very broad CC list it has.

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VWPoACgkQJNaLcl1U
h9Bq6Af/XISIHfTbIdVWLIy9cav1xBGoNheQB8U8jrd370PqkAtHsvZwnq9aDdt3
IxSWEuRVgj4bCprzm7gRSiLT5DSxNEqraVfT9GtbAy2Yi/ErLTSHRTCafCelguRv
guxddwpmSo/yyNcyW0xen19YAhFjJ+VAKjlPdO0ApbplIBWPzwX7cvO7db6qnH9m
k0GBhysZIXjhJW9KtjmFjdeiJxWGkjTXMDiC5O+Lq0/PL5MIWzrALmT45mFq4Ojf
1rHAkV6H/8HqU7hSGxnKegK5uwx/gPT2JjhKVYoXXnTIogDeFmnBuz4ZlWMaVD0P
3T4W1JDe639jb8v2EqZNxjdsU2XPFA==
=os2p
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
